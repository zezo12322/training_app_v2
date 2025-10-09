// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'integrity_flag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IntegrityFlagImpl _$$IntegrityFlagImplFromJson(Map<String, dynamic> json) =>
    _$IntegrityFlagImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: json['type'] as String,
      ts: const TimestampConverter().fromJson(json['ts']),
      severity: json['severity'] as String? ?? 'low',
      details: json['details'] as Map<String, dynamic>? ?? const {},
      resolved: json['resolved'] as bool? ?? false,
    );

Map<String, dynamic> _$$IntegrityFlagImplToJson(_$IntegrityFlagImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': instance.type,
      'ts': const TimestampConverter().toJson(instance.ts),
      'severity': instance.severity,
      'details': instance.details,
      'resolved': instance.resolved,
    };
