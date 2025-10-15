// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_daily_rollup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SecurityDailyRollupImpl _$$SecurityDailyRollupImplFromJson(
  Map<String, dynamic> json,
) => _$SecurityDailyRollupImpl(
  id: json['id'] as String,
  date: json['date'] as String,
  totalEvents: (json['totalEvents'] as num?)?.toInt() ?? 0,
  permissionDenied: (json['permissionDenied'] as num?)?.toInt() ?? 0,
  privilegeEscalation: (json['privilegeEscalation'] as num?)?.toInt() ?? 0,
  suspectPayload: (json['suspectPayload'] as num?)?.toInt() ?? 0,
  highSeverity: (json['highSeverity'] as num?)?.toInt() ?? 0,
  distinctUsers: (json['distinctUsers'] as num?)?.toInt() ?? 0,
  computedAt: const TimestampConverter().fromJson(json['computedAt']),
  meta: json['meta'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$$SecurityDailyRollupImplToJson(
  _$SecurityDailyRollupImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date,
  'totalEvents': instance.totalEvents,
  'permissionDenied': instance.permissionDenied,
  'privilegeEscalation': instance.privilegeEscalation,
  'suspectPayload': instance.suspectPayload,
  'highSeverity': instance.highSeverity,
  'distinctUsers': instance.distinctUsers,
  'computedAt': const TimestampConverter().toJson(instance.computedAt),
  'meta': instance.meta,
};
