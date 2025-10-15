// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_user_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RiskUserScoreImpl _$$RiskUserScoreImplFromJson(Map<String, dynamic> json) =>
    _$RiskUserScoreImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      date: json['date'] as String,
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      factors: json['factors'] as Map<String, dynamic>? ?? const {},
      level: json['level'] as String? ?? 'low',
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$RiskUserScoreImplToJson(_$RiskUserScoreImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'date': instance.date,
      'score': instance.score,
      'factors': instance.factors,
      'level': instance.level,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
