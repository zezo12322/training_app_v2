import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/badge.dart';
import 'gamification_providers.dart' show firebaseFirestoreProvider;
import 'auth_provider.dart';

final badgeManagementRepositoryProvider = Provider<CollectionReference>((ref) {
  final fs = ref.watch(firebaseFirestoreProvider);
  return fs.collection('badges');
});

final createOrUpdateBadgeProvider = FutureProvider.family<void, Badge>((
  ref,
  badge,
) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return;
  // NOT enforcing trainer role here; rely on Firestore rules server-side.
  final col = ref.read(badgeManagementRepositoryProvider);
  await col.doc(badge.id).set(badge.toMap(), SetOptions(merge: true));
});

final deleteBadgeProvider = FutureProvider.family<void, String>((
  ref,
  badgeId,
) async {
  final col = ref.read(badgeManagementRepositoryProvider);
  await col.doc(badgeId).delete();
});

final activeBadgesProvider = StreamProvider.autoDispose<List<Badge>>((ref) {
  final col = ref.watch(badgeManagementRepositoryProvider);
  return col
      .where('active', isEqualTo: true)
      .snapshots()
      .map(
        (snap) => snap.docs
            .map((d) => Badge.fromMap(d.data() as Map<String, dynamic>, d.id))
            .toList(),
      );
});

final allBadgesStreamProvider = StreamProvider.autoDispose<List<Badge>>((ref) {
  final col = ref.watch(badgeManagementRepositoryProvider);
  return col.snapshots().map(
    (snap) => snap.docs
        .map((d) => Badge.fromMap(d.data() as Map<String, dynamic>, d.id))
        .toList(),
  );
});
