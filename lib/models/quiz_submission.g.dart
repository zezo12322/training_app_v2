// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_submission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizSubmissionImpl _$$QuizSubmissionImplFromJson(Map<String, dynamic> json) =>
    _$QuizSubmissionImpl(
      id: json['id'] as String,
      quizId: json['quizId'] as String,
      traineeId: json['traineeId'] as String,
      traineeEmail: json['traineeEmail'] as String,
      autoScore: (json['autoScore'] as num).toInt(),
      manualScore: (json['manualScore'] as num).toInt(),
      finalScore: (json['finalScore'] as num).toInt(),
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      answers: json['answers'] as Map<String, dynamic>,
      manualScores: Map<String, int>.from(json['manualScores'] as Map),
      questionTypes: Map<String, String>.from(json['questionTypes'] as Map),
      needsManualReview: json['needsManualReview'] as bool,
      requiresManualGrading: (json['requiresManualGrading'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
      gradedAt: json['gradedAt'] == null
          ? null
          : DateTime.parse(json['gradedAt'] as String),
      graderId: json['graderId'] as String?,
    );

Map<String, dynamic> _$$QuizSubmissionImplToJson(
  _$QuizSubmissionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'quizId': instance.quizId,
  'traineeId': instance.traineeId,
  'traineeEmail': instance.traineeEmail,
  'autoScore': instance.autoScore,
  'manualScore': instance.manualScore,
  'finalScore': instance.finalScore,
  'totalQuestions': instance.totalQuestions,
  'answers': instance.answers,
  'manualScores': instance.manualScores,
  'questionTypes': instance.questionTypes,
  'needsManualReview': instance.needsManualReview,
  'requiresManualGrading': instance.requiresManualGrading,
  'submittedAt': instance.submittedAt?.toIso8601String(),
  'gradedAt': instance.gradedAt?.toIso8601String(),
  'graderId': instance.graderId,
};
