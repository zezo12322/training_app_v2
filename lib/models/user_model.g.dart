// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      oneSignalPlayerId: json['oneSignalPlayerId'] as String?,
      imageUrl: json['imageUrl'] as String?,
      institutionId: json['institutionId'] as String?,
      companyId: json['companyId'] as String?,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'oneSignalPlayerId': instance.oneSignalPlayerId,
      'imageUrl': instance.imageUrl,
      'institutionId': instance.institutionId,
      'companyId': instance.companyId,
    };
