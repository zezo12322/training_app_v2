// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_attempt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SkillAttemptImpl _$$SkillAttemptImplFromJson(Map<String, dynamic> json) =>
    _$SkillAttemptImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      skillCode: json['skillCode'] as String,
      success: json['success'] as bool,
      ts: const TimestampConverter().fromJson(json['ts']),
      points: (json['points'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$SkillAttemptImplToJson(_$SkillAttemptImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'skillCode': instance.skillCode,
      'success': instance.success,
      'ts': const TimestampConverter().toJson(instance.ts),
      'points': instance.points,
    };
