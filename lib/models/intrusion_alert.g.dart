// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intrusion_alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IntrusionAlertImpl _$$IntrusionAlertImplFromJson(Map<String, dynamic> json) =>
    _$IntrusionAlertImpl(
      id: json['id'] as String,
      vector: json['vector'] as String,
      category: json['category'] as String,
      firstSeen: const TimestampConverter().fromJson(json['firstSeen']),
      lastSeen: const TimestampConverter().fromJson(json['lastSeen']),
      count: (json['count'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'open',
      severity: json['severity'] as String? ?? 'low',
      impactedUsers:
          (json['impactedUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      meta: json['meta'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$IntrusionAlertImplToJson(
  _$IntrusionAlertImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'vector': instance.vector,
  'category': instance.category,
  'firstSeen': const TimestampConverter().toJson(instance.firstSeen),
  'lastSeen': const TimestampConverter().toJson(instance.lastSeen),
  'count': instance.count,
  'status': instance.status,
  'severity': instance.severity,
  'impactedUsers': instance.impactedUsers,
  'meta': instance.meta,
};
