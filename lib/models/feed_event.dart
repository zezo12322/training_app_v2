import 'package:cloud_firestore/cloud_firestore.dart';

// Lightweight immutable FeedEvent model (no codegen to keep simple here)
class FeedEvent {
  final String id;
  final String type; // points_event | badge_award | challenge_completed | mastery_improved
  final String userId;
  final String? refId;
  final String? title;
  final String? subtitle;
  final int? points;
  final double? delta;
  final DateTime? ts;

  const FeedEvent({
    required this.id,
    required this.type,
    required this.userId,
    this.refId,
    this.title,
    this.subtitle,
    this.points,
    this.delta,
    this.ts,
  });
}

// Helpers to build events from disparate source docs (defensive & null-safe).
FeedEvent feedFromPointsEvent(DocumentSnapshot snap) {
  final d = snap.data() as Map<String,dynamic>? ?? {};
  return FeedEvent(
    id: 'pe_${snap.id}',
    type: 'points_event',
    userId: d['userId'] ?? '',
    refId: snap.id,
  title: 'Points +${d['points'] ?? 0}',
    subtitle: d['type']?.toString(),
    points: (d['points'] is int) ? d['points'] as int : null,
    ts: (d['createdAt'] as Timestamp?)?.toDate(),
  );
}

FeedEvent feedFromBadgeAward(String userId, DocumentSnapshot snap) {
  final d = snap.data() as Map<String,dynamic>? ?? {};
  return FeedEvent(
    id: 'ba_${snap.id}_$userId',
    type: 'badge_award',
    userId: userId,
    refId: snap.id,
    title: 'Badge Earned',
    subtitle: snap.id,
    ts: (d['awardedAt'] as Timestamp?)?.toDate(),
  );
}

FeedEvent feedFromChallengeProgress(DocumentSnapshot snap) {
  final d = snap.data() as Map<String,dynamic>? ?? {};
  return FeedEvent(
    id: 'ch_${snap.id}',
    type: 'challenge_completed',
    userId: d['userId'] ?? '',
    refId: d['challengeId']?.toString(),
    title: 'Challenge Completed',
    subtitle: d['challengeId']?.toString(),
    ts: (d['completedAt'] as Timestamp?)?.toDate(),
  );
}

FeedEvent feedFromMasteryDelta(DocumentSnapshot snap) {
  final d = snap.data() as Map<String,dynamic>? ?? {};
  return FeedEvent(
    id: 'ms_${snap.id}',
    type: 'mastery_improved',
    userId: d['userId'] ?? '',
    refId: d['skillCode']?.toString(),
    title: 'Skill Mastery Update',
    subtitle: d['skillCode']?.toString(),
    delta: (d['delta14d'] is num) ? (d['delta14d'] as num).toDouble() : null,
    ts: (d['lastUpdate'] as Timestamp?)?.toDate(),
  );
}
