// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SystemSettingsImpl _$$SystemSettingsImplFromJson(Map<String, dynamic> json) =>
    _$SystemSettingsImpl(
      id: json['id'] as String,
      featureFlags: json['featureFlags'] as Map<String, dynamic>? ?? const {},
      thresholds: json['thresholds'] as Map<String, dynamic>? ?? const {},
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$SystemSettingsImplToJson(
  _$SystemSettingsImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'featureFlags': instance.featureFlags,
  'thresholds': instance.thresholds,
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};
