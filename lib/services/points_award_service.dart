import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/gamification_providers.dart'
    show firebaseFirestoreProvider, pointsRepositoryProvider;

/// A unified, idempotent service for awarding points & triggering badge evaluation.
/// It stores a single immutable event document in `user_points_events` and increments
/// the user's points atomically in a Firestore transaction. If the event already
/// exists it returns false (no new award).
class PointsAwardService {
  final FirebaseFirestore _firestore;
  PointsAwardService(this._firestore);

  /// Awards points once per unique [eventId]. Extra metadata can be passed via [extra].
  /// Returns true if a new award was created, false if the event already existed.
  Future<bool> award({
    required String userId,
    required String eventId,
    required String
    type, // quiz_pass | task_completed | lesson_completed | daily_streak
    required int points,
    Map<String, dynamic>? extra,
  }) async {
    if (points <= 0) return false;
    final eventsRef = _firestore.collection('user_points_events').doc(eventId);

    bool created = false;
    await _firestore.runTransaction((tx) async {
      final evtSnap = await tx.get(eventsRef);
      if (evtSnap.exists) return; // already awarded
      created = true;
      // No direct points increment here anymore; server Cloud Function processes counters & points.
      // Write immutable event
      tx.set(eventsRef, {
        'userId': userId,
        'type': type,
        'points': points,
        'createdAt': FieldValue.serverTimestamp(),
        ...?extra,
      });
    });

    // Server Cloud Function will evaluate and award badges; no client call here.
    return created;
  }

  /// Atomically updates the user's daily streak (if day changed) and awards daily streak points once per day.
  /// Returns a tuple (awardedPoints, newStreak).
  Future<(bool awardedPoints, int newStreak)> updateDailyStreakAndAward({
    required String userId,
    required int dailyPoints,
  }) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dayKey =
        '${today.year.toString().padLeft(4, '0')}${today.month.toString().padLeft(2, '0')}${today.day.toString().padLeft(2, '0')}';
    final eventId = 'daily_streak_${userId}_$dayKey';
    final eventsRef = _firestore.collection('user_points_events').doc(eventId);
    final userRef = _firestore.collection('user_points').doc(userId);
    bool awarded = false;
    int resultingStreak = 1;
    await _firestore.runTransaction((tx) async {
      final userSnap = await tx.get(userRef);
      final raw = userSnap.data();
      final data = raw is Map<String, dynamic> ? raw : <String, dynamic>{};
      final currentStreak = (data['dailyStreak'] ?? 0) as int;
      final lastTs = data['lastActiveDay'] as Timestamp?;
      DateTime? lastDay = lastTs?.toDate();
      final lastDate = lastDay != null
          ? DateTime(lastDay.year, lastDay.month, lastDay.day)
          : null;
      int newStreak;
      bool dayChanged = false;
      if (lastDate == null) {
        newStreak = 1;
        dayChanged = true; // first day
      } else {
        final diff = today.difference(lastDate).inDays;
        if (diff == 0) {
          newStreak = currentStreak; // same day
        } else if (diff == 1) {
          newStreak = currentStreak + 1;
          dayChanged = true;
        } else {
          newStreak = 1; // reset
          dayChanged = true;
        }
      }
      resultingStreak = newStreak;
      if (dayChanged) {
        tx.set(userRef, {
          'dailyStreak': newStreak,
          'lastActiveDay': Timestamp.fromDate(today),
        }, SetOptions(merge: true));
      }
      // Award points only if event not exists (once per calendar day)
      final evtSnap = await tx.get(eventsRef);
      if (!evtSnap.exists) {
        awarded = true;
        // Server function will process increment from event document only.
        tx.set(eventsRef, {
          'userId': userId,
          'type': 'daily_streak',
          'points': dailyPoints,
          'day': dayKey,
          'createdAt': FieldValue.serverTimestamp(),
          'streakAfter': resultingStreak,
        });
      }
    });
    // Badge evaluation handled server-side; streak doc write + event triggers CF.
    return (awarded, resultingStreak);
  }
}

final pointsAwardServiceProvider = Provider<PointsAwardService>((ref) {
  final fs = ref.watch(firebaseFirestoreProvider);
  // pointsRepositoryProvider kept watched so it's still initialized if it has side-effects / caching
  ref.watch(pointsRepositoryProvider);
  return PointsAwardService(fs);
});

/// Convenience provider to award the current signed-in user without manually pulling UID.
final awardCurrentUserPointsProvider =
    FutureProvider.family<
      bool,
      ({String eventId, String type, int points, Map<String, dynamic>? extra})
    >((ref, params) async {
      final auth = ref.watch(authStateProvider).value;
      if (auth == null) return false;
      final svc = ref.read(pointsAwardServiceProvider);
      return svc.award(
        userId: auth.uid,
        eventId: params.eventId,
        type: params.type,
        points: params.points,
        extra: params.extra,
      );
    });

/// Award lesson completion points once per lesson per user.
final awardLessonCompletedProvider = FutureProvider.family<bool, String>((
  ref,
  lessonId,
) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return false;
  final svc = ref.read(pointsAwardServiceProvider);
  final points = 10; // could externalize later
  return svc.award(
    userId: auth.uid,
    eventId: 'lesson_${lessonId}_${auth.uid}',
    type: 'lesson_completed',
    points: points,
    extra: {'lessonId': lessonId},
  );
});

/// Update streak & award daily streak points (idempotent per day)
final awardDailyStreakTodayProvider =
    FutureProvider<(bool awarded, int newStreak)>((ref) async {
      final auth = ref.watch(authStateProvider).value;
      if (auth == null) return (false, 0);
      final svc = ref.read(pointsAwardServiceProvider);
      // daily streak points: could look up from config; hard-coded 5 for now
      return svc.updateDailyStreakAndAward(userId: auth.uid, dailyPoints: 5);
    });
