// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_skill_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSkillStatsImpl _$$UserSkillStatsImplFromJson(Map<String, dynamic> json) =>
    _$UserSkillStatsImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      skillCode: json['skillCode'] as String,
      masteryScore: (json['masteryScore'] as num?)?.toDouble() ?? 0,
      attempts: (json['attempts'] as num?)?.toInt() ?? 0,
      lastUpdate: const TimestampConverter().fromJson(json['lastUpdate']),
      delta14d: (json['delta14d'] as num?)?.toDouble() ?? 0,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$UserSkillStatsImplToJson(
  _$UserSkillStatsImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'skillCode': instance.skillCode,
  'masteryScore': instance.masteryScore,
  'attempts': instance.attempts,
  'lastUpdate': const TimestampConverter().toJson(instance.lastUpdate),
  'delta14d': instance.delta14d,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};
