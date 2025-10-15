// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizQuestionImpl _$$QuizQuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuizQuestionImpl(
      id: json['id'] as String,
      quizId: json['quizId'] as String,
      questionText: json['questionText'] as String,
      type: json['type'] as String,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      correctAnswerIndex: (json['correctAnswerIndex'] as num?)?.toInt(),
      leftItems: (json['leftItems'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      rightItems: (json['rightItems'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      correctPairs: (json['correctPairs'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$QuizQuestionImplToJson(_$QuizQuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quizId': instance.quizId,
      'questionText': instance.questionText,
      'type': instance.type,
      'options': instance.options,
      'correctAnswerIndex': instance.correctAnswerIndex,
      'leftItems': instance.leftItems,
      'rightItems': instance.rightItems,
      'correctPairs': instance.correctPairs,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
