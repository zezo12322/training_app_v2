import 'package:cloud_firestore/cloud_firestore.dart';

class UserPoints {
  final String userId;
  final int points;
  final List<String> badges;
  final int dailyStreak;
  final DateTime? lastActiveAt;
  final int quizzesPassed;
  final int tasksCompleted;
  final int lessonsCompleted;

  UserPoints({
    required this.userId,
    required this.points,
    required this.badges,
    required this.dailyStreak,
    required this.lastActiveAt,
    required this.quizzesPassed,
    required this.tasksCompleted,
    required this.lessonsCompleted,
  });

  factory UserPoints.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final ts = data['lastActiveDay'];
    DateTime? last;
    if (ts is Timestamp) last = ts.toDate();
    return UserPoints(
      userId: doc.id,
      points: data['points'] ?? 0,
      badges: List<String>.from(data['badges'] ?? []),
      dailyStreak: data['dailyStreak'] ?? 0,
      lastActiveAt: last,
      quizzesPassed: data['quizzesPassed'] ?? 0,
      tasksCompleted: data['tasksCompleted'] ?? 0,
      lessonsCompleted: data['lessonsCompleted'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
    'points': points,
    'badges': badges,
    'dailyStreak': dailyStreak,
    'lastActiveDay': lastActiveAt,
    'quizzesPassed': quizzesPassed,
    'tasksCompleted': tasksCompleted,
    'lessonsCompleted': lessonsCompleted,
  };
}
