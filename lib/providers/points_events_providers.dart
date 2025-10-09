import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../repositories/points_events_repository.dart';
import '../models/user_point_event.dart';
import 'gamification_providers.dart'
    show firebaseFirestoreProvider; // reuse existing firestore provider

final pointsEventsRepositoryProvider = Provider<PointsEventsRepository>((ref) {
  final fs = ref.watch(firebaseFirestoreProvider);
  return PointsEventsRepository(firestore: fs);
});

/// Recent events stream (live updates) limited
final userRecentPointEventsProvider =
    StreamProvider.family<List<UserPointEvent>, String>((ref, userId) {
      return ref.watch(pointsEventsRepositoryProvider).streamRecent(userId);
    });

/// Simple paginated loader (accumulative state)
class UserPointEventsPager
    extends StateNotifier<AsyncValue<List<UserPointEvent>>> {
  final PointsEventsRepository _repo;
  final String userId;
  final String? type;
  final int pageSize;
  DocumentSnapshot? _last;
  bool _exhausted = false;
  bool _loadingPage = false; // guard against concurrent loads
  bool get exhausted => _exhausted;

  UserPointEventsPager(
    this._repo, {
    required this.userId,
    this.type,
    this.pageSize = 20,
  }) : super(const AsyncValue.loading()) {
    // Defer first page load to microtask to avoid modifying provider during build
    Future.microtask(() => loadMore());
  }

  Future<void> loadMore() async {
    if (_exhausted || _loadingPage) return;
    _loadingPage = true;
    try {
      final prev = state.value ?? const <UserPointEvent>[];
      final startAfter = _last;
      if (prev.isEmpty) {
        state = const AsyncValue.loading();
      }
      final q = _repo.baseQuery(userId, type: type).limit(pageSize);
      final snap = startAfter == null
          ? await q.get()
          : await q.startAfterDocument(startAfter).get();
      final events = snap.docs.map(UserPointEvent.fromDoc).toList();
      if (events.isEmpty) {
        // No new events: if this is the very first load we must emit an empty list
        if (prev.isEmpty) {
          state = const AsyncValue.data(<UserPointEvent>[]);
        } else {
          // keep previous accumulated list
          state = AsyncValue.data(prev);
        }
        _exhausted = true;
        _loadingPage = false;
        return;
      }
      _last = snap.docs.last;
      state = AsyncValue.data([...prev, ...events]);
      if (events.length < pageSize) _exhausted = true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
    _loadingPage = false;
  }
}

final userPointEventsPagerProvider =
    StateNotifierProvider.family<
      UserPointEventsPager,
      AsyncValue<List<UserPointEvent>>,
      ({String userId, String? type})
    >((ref, params) {
      final repo = ref.watch(pointsEventsRepositoryProvider);
      return UserPointEventsPager(
        repo,
        userId: params.userId,
        type: params.type,
      );
    });
