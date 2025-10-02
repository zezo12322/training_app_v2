import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'quiz_submission.freezed.dart';
part 'quiz_submission.g.dart';

@freezed
class QuizSubmission with _$QuizSubmission {
  const QuizSubmission._();
  const factory QuizSubmission({
    required String id,
    required String quizId,
    required String traineeId,
    required String traineeEmail,
    required int autoScore,
    required int manualScore,
    required int finalScore,
    required int totalQuestions,
    required Map<String, dynamic> answers,
    required Map<String, int> manualScores, // per-question manual points
    required Map<String, String> questionTypes, // questionId -> type
    required bool needsManualReview,
    List<String>? requiresManualGrading, // textual question ids
    DateTime? submittedAt,
    DateTime? gradedAt,
    String? graderId,
  }) = _QuizSubmission;

  factory QuizSubmission.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return QuizSubmission(
      id: doc.id,
      quizId: data['quizId'] as String,
      traineeId: data['traineeId'] as String,
      traineeEmail: data['traineeEmail'] as String? ?? '',
      autoScore: data['autoScore'] is int ? data['autoScore'] as int : (data['score'] as int? ?? 0),
      manualScore: data['manualScore'] as int? ?? 0,
      finalScore: data['finalScore'] as int? ?? (data['score'] as int? ?? 0),
      totalQuestions: data['totalQuestions'] as int? ?? 0,
      answers: (data['answers'] as Map?)?.map((k, v) => MapEntry(k.toString(), v)) ?? {},
      manualScores: (data['manualScores'] as Map?)?.map((k, v) => MapEntry(k.toString(), v is int ? v : 0)) ?? {},
      questionTypes: (data['questionTypes'] as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())) ?? {},
      needsManualReview: data['needsManualReview'] as bool? ?? false,
      requiresManualGrading: (data['requiresManualGrading'] as List?)?.map((e) => e.toString()).toList(),
      submittedAt: (data['submittedAt'] is Timestamp) ? (data['submittedAt'] as Timestamp).toDate() : null,
      gradedAt: (data['gradedAt'] is Timestamp) ? (data['gradedAt'] as Timestamp).toDate() : null,
      graderId: data['graderId'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'quizId': quizId,
    'traineeId': traineeId,
    'traineeEmail': traineeEmail,
    'autoScore': autoScore,
    'manualScore': manualScore,
    'finalScore': finalScore,
    'totalQuestions': totalQuestions,
    'answers': answers,
    'manualScores': manualScores,
    'questionTypes': questionTypes,
    'needsManualReview': needsManualReview,
    if (requiresManualGrading != null) 'requiresManualGrading': requiresManualGrading,
    'submittedAt': FieldValue.serverTimestamp(),
    if (gradedAt != null) 'gradedAt': gradedAt,
    if (graderId != null) 'graderId': graderId,
  };

  factory QuizSubmission.fromJson(Map<String, dynamic> json) => _$QuizSubmissionFromJson(json);
}
