// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EvaluationModelImpl _$$EvaluationModelImplFromJson(
  Map<String, dynamic> json,
) => _$EvaluationModelImpl(
  id: json['id'] as String,
  courseId: json['courseId'] as String,
  traineeId: json['traineeId'] as String,
  trainerId: json['trainerId'] as String,
  score: (json['score'] as num).toInt(),
  feedback: json['feedback'] as String,
  audioUrl: json['audioUrl'] as String?,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$$EvaluationModelImplToJson(
  _$EvaluationModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'courseId': instance.courseId,
  'traineeId': instance.traineeId,
  'trainerId': instance.trainerId,
  'score': instance.score,
  'feedback': instance.feedback,
  'audioUrl': instance.audioUrl,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};
