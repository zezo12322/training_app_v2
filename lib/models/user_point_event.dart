import 'package:cloud_firestore/cloud_firestore.dart';

class UserPointEvent {
  final String id;
  final String userId;
  final String
  type; // quiz_pass | task_completed | lesson_completed | daily_streak
  final int points;
  final DateTime? createdAt;
  final Map<String, dynamic> extra;

  UserPointEvent({
    required this.id,
    required this.userId,
    required this.type,
    required this.points,
    required this.createdAt,
    required this.extra,
  });

  factory UserPointEvent.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final ts = data['createdAt'];
    DateTime? created;
    if (ts is Timestamp) created = ts.toDate();
    return UserPointEvent(
      id: doc.id,
      userId: data['userId'] ?? '',
      type: data['type'] ?? '',
      points: (data['points'] ?? 0) is int ? data['points'] as int : 0,
      createdAt: created,
      extra: Map<String, dynamic>.from(data)
        ..removeWhere(
          (k, _) => ['userId', 'type', 'points', 'createdAt'].contains(k),
        ),
    );
  }
}
