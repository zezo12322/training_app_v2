// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sso_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SSOProviderImpl _$$SSOProviderImplFromJson(Map<String, dynamic> json) =>
    _$SSOProviderImpl(
      id: json['id'] as String,
      type: $enumDecode(_$SSOProviderTypeEnumMap, json['type']),
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      isEnabled: json['isEnabled'] as bool,
      clientId: json['clientId'] as String?,
      clientSecret: json['clientSecret'] as String?,
      redirectUri: json['redirectUri'] as String?,
      providerId: json['providerId'] as String?,
      providerEmail: json['providerEmail'] as String?,
      providerName: json['providerName'] as String?,
      providerPhotoUrl: json['providerPhotoUrl'] as String?,
      institutionId: json['institutionId'] as String?,
      companyId: json['companyId'] as String?,
    );

Map<String, dynamic> _$$SSOProviderImplToJson(_$SSOProviderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$SSOProviderTypeEnumMap[instance.type]!,
      'name': instance.name,
      'displayName': instance.displayName,
      'isEnabled': instance.isEnabled,
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
      'redirectUri': instance.redirectUri,
      'providerId': instance.providerId,
      'providerEmail': instance.providerEmail,
      'providerName': instance.providerName,
      'providerPhotoUrl': instance.providerPhotoUrl,
      'institutionId': instance.institutionId,
      'companyId': instance.companyId,
    };

const _$SSOProviderTypeEnumMap = {
  SSOProviderType.google: 'google',
  SSOProviderType.apple: 'apple',
  SSOProviderType.microsoft: 'microsoft',
  SSOProviderType.facebook: 'facebook',
};

_$SSOLoginResultImpl _$$SSOLoginResultImplFromJson(Map<String, dynamic> json) =>
    _$SSOLoginResultImpl(
      success: json['success'] as bool,
      provider: $enumDecode(_$SSOProviderTypeEnumMap, json['provider']),
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      idToken: json['idToken'] as String?,
      accessToken: json['accessToken'] as String?,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$$SSOLoginResultImplToJson(
  _$SSOLoginResultImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'provider': _$SSOProviderTypeEnumMap[instance.provider]!,
  'userId': instance.userId,
  'email': instance.email,
  'displayName': instance.displayName,
  'photoUrl': instance.photoUrl,
  'idToken': instance.idToken,
  'accessToken': instance.accessToken,
  'errorMessage': instance.errorMessage,
};

_$SSOSettingsImpl _$$SSOSettingsImplFromJson(Map<String, dynamic> json) =>
    _$SSOSettingsImpl(
      institutionId: json['institutionId'] as String,
      googleEnabled: json['googleEnabled'] as bool? ?? false,
      appleEnabled: json['appleEnabled'] as bool? ?? false,
      microsoftEnabled: json['microsoftEnabled'] as bool? ?? false,
      googleClientId: json['googleClientId'] as String?,
      googleClientSecret: json['googleClientSecret'] as String?,
      appleClientId: json['appleClientId'] as String?,
      appleTeamId: json['appleTeamId'] as String?,
      microsoftTenantId: json['microsoftTenantId'] as String?,
      microsoftClientId: json['microsoftClientId'] as String?,
      autoCreateAccount: json['autoCreateAccount'] as bool? ?? true,
      allowedDomains:
          (json['allowedDomains'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      defaultRole: json['defaultRole'] as String? ?? 'trainee',
    );

Map<String, dynamic> _$$SSOSettingsImplToJson(_$SSOSettingsImpl instance) =>
    <String, dynamic>{
      'institutionId': instance.institutionId,
      'googleEnabled': instance.googleEnabled,
      'appleEnabled': instance.appleEnabled,
      'microsoftEnabled': instance.microsoftEnabled,
      'googleClientId': instance.googleClientId,
      'googleClientSecret': instance.googleClientSecret,
      'appleClientId': instance.appleClientId,
      'appleTeamId': instance.appleTeamId,
      'microsoftTenantId': instance.microsoftTenantId,
      'microsoftClientId': instance.microsoftClientId,
      'autoCreateAccount': instance.autoCreateAccount,
      'allowedDomains': instance.allowedDomains,
      'defaultRole': instance.defaultRole,
    };
