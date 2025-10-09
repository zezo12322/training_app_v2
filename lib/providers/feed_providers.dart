import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import '../models/feed_event.dart';

final _fs = Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);

// Base streams per source (scoped to user) with lightweight limits.
Stream<List<FeedEvent>> _pointsEvents(FirebaseFirestore fs, String userId) => fs
    .collection('user_points_events')
    .where('userId', isEqualTo: userId)
    .orderBy('createdAt', descending: true)
    .limit(20)
    .snapshots()
    .map((q) => q.docs.map(feedFromPointsEvent).toList());

Stream<List<FeedEvent>> _badgeAwards(FirebaseFirestore fs, String userId) => fs
    .collection('user_points')
    .doc(userId)
    .collection('badge_awards')
    .orderBy('awardedAt', descending: true)
    .limit(10)
    .snapshots()
    .map((q) => q.docs.map((d) => feedFromBadgeAward(userId, d)).toList());

Stream<List<FeedEvent>> _completedChallenges(FirebaseFirestore fs, String userId) => fs
    .collection('user_challenge_progress')
    .where('userId', isEqualTo: userId)
    .where('completed', isEqualTo: true)
    .orderBy('completedAt', descending: true)
    .limit(10)
    .snapshots()
    .map((q) => q.docs.map(feedFromChallengeProgress).toList());

Stream<List<FeedEvent>> _masteryUpdates(FirebaseFirestore fs, String userId) => fs
    .collection('user_skill_stats')
    .where('userId', isEqualTo: userId)
    .orderBy('lastUpdate', descending: true)
    .limit(15)
    .snapshots()
    .map((q) => q.docs
        .map(feedFromMasteryDelta)
        .where((e) => (e.delta ?? 0).abs() > 0.01) // filter negligible noise
        .toList());

/// Aggregated feed combining multiple sources, sorted by timestamp desc.
final userFeedProvider = StreamProvider.family<List<FeedEvent>, String>((ref, userId) {
  final fs = ref.watch(_fs);
  final streams = [
    _pointsEvents(fs, userId),
    _badgeAwards(fs, userId),
    _completedChallenges(fs, userId),
    _masteryUpdates(fs, userId),
    // Kudos given or received involving the user
    fs
        .collection('kudos_events')
        .where('fromUserId', isEqualTo: userId)
        .orderBy('ts', descending: true)
        .limit(10)
        .snapshots()
        .map((q) => q.docs.map((d) => FeedEvent(
              id: 'k_${d.id}',
              type: 'kudos_given',
              userId: userId,
              refId: d.id,
              title: 'Kudos Given',
              subtitle: d.data()['toUserId']?.toString(),
              ts: (d.data()['ts'] as Timestamp?)?.toDate(),
            )).toList()),
    fs
        .collection('kudos_events')
        .where('toUserId', isEqualTo: userId)
        .orderBy('ts', descending: true)
        .limit(10)
        .snapshots()
        .map((q) => q.docs.map((d) => FeedEvent(
              id: 'kr_${d.id}',
              type: 'kudos_received',
              userId: userId,
              refId: d.id,
              title: 'Kudos Received',
              subtitle: d.data()['fromUserId']?.toString(),
              ts: (d.data()['ts'] as Timestamp?)?.toDate(),
            )).toList()),
    // Quest completions
    fs
        .collection('user_quest_state')
        .where('userId', isEqualTo: userId)
        .where('completed', isEqualTo: true)
        .orderBy('completedAt', descending: true)
        .limit(10)
        .snapshots()
        .map((q) => q.docs.map((d) => FeedEvent(
              id: 'q_${d.id}',
              type: 'quest_completed',
              userId: userId,
              refId: d.data()['questId']?.toString(),
              title: 'Quest Completed',
              subtitle: d.data()['questId']?.toString(),
              ts: (d.data()['completedAt'] as Timestamp?)?.toDate(),
            )).toList()),
  ];
  return Rx.combineLatest<List<FeedEvent>, List<FeedEvent>>(streams, (lists) {
    final merged = <FeedEvent>[];
    for (final l in lists) {
      merged.addAll(l);
    }
    merged.sort((a,b) => (b.ts?.millisecondsSinceEpoch ?? 0) - (a.ts?.millisecondsSinceEpoch ?? 0));
    return merged.take(50).toList();
  });
});
