import 'package:cloud_firestore/cloud_firestore.dart';

class QuizLiteModel {
  final String id;
  final String courseId;
  final String title;
  final int totalQuestions;
  final int passScore; // percentage threshold
  final bool allowRetake;

  /// Maximum number of attempts allowed for a trainee (trainer controlled).
  /// If absent in Firestore defaults to: allowRetake ? 2 : 1 (legacy fallback).
  final int maxAttempts; // e.g. 1 or 2 (current requested scope)
  final int rewardPoints; // points granted on first pass
  final DateTime createdAt;
  QuizLiteModel({
    required this.id,
    required this.courseId,
    required this.title,
    required this.totalQuestions,
    required this.passScore,
    required this.allowRetake,
    required this.maxAttempts,
    required this.rewardPoints,
    required this.createdAt,
  });
  factory QuizLiteModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return QuizLiteModel(
      id: doc.id,
      courseId: d['courseId'] as String,
      title: d['title'] as String,
      totalQuestions: (d['totalQuestions'] as int?) ?? 0,
      passScore: (d['passScore'] as int?) ?? 60,
      allowRetake: (d['allowRetake'] as bool?) ?? true,
      maxAttempts:
          (d['maxAttempts'] as int?) ??
          ((d['allowRetake'] as bool?) == true ? 2 : 1),
      rewardPoints: (d['rewardPoints'] as int?) ?? 15,
      createdAt:
          (d['createdAt'] as Timestamp?)?.toDate() ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}

class QuizSubmissionLite {
  final String id;
  final String quizId;
  final String traineeId;
  final int score; // 0..100
  final DateTime submittedAt;
  final Map<String, int>?
  answers; // questionId -> chosenIndex (optional for review)
  QuizSubmissionLite({
    required this.id,
    required this.quizId,
    required this.traineeId,
    required this.score,
    required this.submittedAt,
    this.answers,
  });
  factory QuizSubmissionLite.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final d = doc.data()!;
    return QuizSubmissionLite(
      id: doc.id,
      quizId: d['quizId'] as String,
      traineeId: d['traineeId'] as String,
      score: (d['score'] as int?) ?? 0,
      submittedAt:
          (d['submittedAt'] as Timestamp?)?.toDate() ??
          DateTime.fromMillisecondsSinceEpoch(0),
      answers: (d['answers'] as Map<String, dynamic>?)?.map(
        (k, v) => MapEntry(k, (v as int)),
      ),
    );
  }
}
