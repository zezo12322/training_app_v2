// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SecurityEventImpl _$$SecurityEventImplFromJson(Map<String, dynamic> json) =>
    _$SecurityEventImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      vector: json['vector'] as String,
      docPath: json['docPath'] as String?,
      severity: json['severity'] as String? ?? 'low',
      ts: const TimestampConverter().fromJson(json['ts']),
      meta: json['meta'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$SecurityEventImplToJson(_$SecurityEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'vector': instance.vector,
      'docPath': instance.docPath,
      'severity': instance.severity,
      'ts': const TimestampConverter().toJson(instance.ts),
      'meta': instance.meta,
    };
