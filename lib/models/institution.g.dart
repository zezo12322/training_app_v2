// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InstitutionImpl _$$InstitutionImplFromJson(Map<String, dynamic> json) =>
    _$InstitutionImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      planTier: json['planTier'] as String? ?? 'free',
      active: json['active'] as bool? ?? true,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      meta: json['meta'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$InstitutionImplToJson(_$InstitutionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'planTier': instance.planTier,
      'active': instance.active,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'meta': instance.meta,
    };
