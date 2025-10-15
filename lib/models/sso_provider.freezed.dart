// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sso_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SSOProvider _$SSOProviderFromJson(Map<String, dynamic> json) {
  return _SSOProvider.fromJson(json);
}

/// @nodoc
mixin _$SSOProvider {
  String get id => throw _privateConstructorUsedError;
  SSOProviderType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  bool get isEnabled => throw _privateConstructorUsedError;

  /// معلومات التكوين
  String? get clientId => throw _privateConstructorUsedError;
  String? get clientSecret => throw _privateConstructorUsedError;
  String? get redirectUri => throw _privateConstructorUsedError;

  /// معلومات المستخدم من المزود
  String? get providerId => throw _privateConstructorUsedError;
  String? get providerEmail => throw _privateConstructorUsedError;
  String? get providerName => throw _privateConstructorUsedError;
  String? get providerPhotoUrl => throw _privateConstructorUsedError;

  /// Tenant
  String? get institutionId => throw _privateConstructorUsedError;
  String? get companyId => throw _privateConstructorUsedError;

  /// Serializes this SSOProvider to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SSOProvider
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SSOProviderCopyWith<SSOProvider> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SSOProviderCopyWith<$Res> {
  factory $SSOProviderCopyWith(
    SSOProvider value,
    $Res Function(SSOProvider) then,
  ) = _$SSOProviderCopyWithImpl<$Res, SSOProvider>;
  @useResult
  $Res call({
    String id,
    SSOProviderType type,
    String name,
    String displayName,
    bool isEnabled,
    String? clientId,
    String? clientSecret,
    String? redirectUri,
    String? providerId,
    String? providerEmail,
    String? providerName,
    String? providerPhotoUrl,
    String? institutionId,
    String? companyId,
  });
}

/// @nodoc
class _$SSOProviderCopyWithImpl<$Res, $Val extends SSOProvider>
    implements $SSOProviderCopyWith<$Res> {
  _$SSOProviderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SSOProvider
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? displayName = null,
    Object? isEnabled = null,
    Object? clientId = freezed,
    Object? clientSecret = freezed,
    Object? redirectUri = freezed,
    Object? providerId = freezed,
    Object? providerEmail = freezed,
    Object? providerName = freezed,
    Object? providerPhotoUrl = freezed,
    Object? institutionId = freezed,
    Object? companyId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as SSOProviderType,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            isEnabled: null == isEnabled
                ? _value.isEnabled
                : isEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            clientId: freezed == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as String?,
            clientSecret: freezed == clientSecret
                ? _value.clientSecret
                : clientSecret // ignore: cast_nullable_to_non_nullable
                      as String?,
            redirectUri: freezed == redirectUri
                ? _value.redirectUri
                : redirectUri // ignore: cast_nullable_to_non_nullable
                      as String?,
            providerId: freezed == providerId
                ? _value.providerId
                : providerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            providerEmail: freezed == providerEmail
                ? _value.providerEmail
                : providerEmail // ignore: cast_nullable_to_non_nullable
                      as String?,
            providerName: freezed == providerName
                ? _value.providerName
                : providerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            providerPhotoUrl: freezed == providerPhotoUrl
                ? _value.providerPhotoUrl
                : providerPhotoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            institutionId: freezed == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            companyId: freezed == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SSOProviderImplCopyWith<$Res>
    implements $SSOProviderCopyWith<$Res> {
  factory _$$SSOProviderImplCopyWith(
    _$SSOProviderImpl value,
    $Res Function(_$SSOProviderImpl) then,
  ) = __$$SSOProviderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    SSOProviderType type,
    String name,
    String displayName,
    bool isEnabled,
    String? clientId,
    String? clientSecret,
    String? redirectUri,
    String? providerId,
    String? providerEmail,
    String? providerName,
    String? providerPhotoUrl,
    String? institutionId,
    String? companyId,
  });
}

/// @nodoc
class __$$SSOProviderImplCopyWithImpl<$Res>
    extends _$SSOProviderCopyWithImpl<$Res, _$SSOProviderImpl>
    implements _$$SSOProviderImplCopyWith<$Res> {
  __$$SSOProviderImplCopyWithImpl(
    _$SSOProviderImpl _value,
    $Res Function(_$SSOProviderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SSOProvider
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? displayName = null,
    Object? isEnabled = null,
    Object? clientId = freezed,
    Object? clientSecret = freezed,
    Object? redirectUri = freezed,
    Object? providerId = freezed,
    Object? providerEmail = freezed,
    Object? providerName = freezed,
    Object? providerPhotoUrl = freezed,
    Object? institutionId = freezed,
    Object? companyId = freezed,
  }) {
    return _then(
      _$SSOProviderImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as SSOProviderType,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        isEnabled: null == isEnabled
            ? _value.isEnabled
            : isEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        clientId: freezed == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String?,
        clientSecret: freezed == clientSecret
            ? _value.clientSecret
            : clientSecret // ignore: cast_nullable_to_non_nullable
                  as String?,
        redirectUri: freezed == redirectUri
            ? _value.redirectUri
            : redirectUri // ignore: cast_nullable_to_non_nullable
                  as String?,
        providerId: freezed == providerId
            ? _value.providerId
            : providerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        providerEmail: freezed == providerEmail
            ? _value.providerEmail
            : providerEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        providerName: freezed == providerName
            ? _value.providerName
            : providerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        providerPhotoUrl: freezed == providerPhotoUrl
            ? _value.providerPhotoUrl
            : providerPhotoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        institutionId: freezed == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        companyId: freezed == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SSOProviderImpl implements _SSOProvider {
  const _$SSOProviderImpl({
    required this.id,
    required this.type,
    required this.name,
    required this.displayName,
    required this.isEnabled,
    this.clientId,
    this.clientSecret,
    this.redirectUri,
    this.providerId,
    this.providerEmail,
    this.providerName,
    this.providerPhotoUrl,
    this.institutionId,
    this.companyId,
  });

  factory _$SSOProviderImpl.fromJson(Map<String, dynamic> json) =>
      _$$SSOProviderImplFromJson(json);

  @override
  final String id;
  @override
  final SSOProviderType type;
  @override
  final String name;
  @override
  final String displayName;
  @override
  final bool isEnabled;

  /// معلومات التكوين
  @override
  final String? clientId;
  @override
  final String? clientSecret;
  @override
  final String? redirectUri;

  /// معلومات المستخدم من المزود
  @override
  final String? providerId;
  @override
  final String? providerEmail;
  @override
  final String? providerName;
  @override
  final String? providerPhotoUrl;

  /// Tenant
  @override
  final String? institutionId;
  @override
  final String? companyId;

  @override
  String toString() {
    return 'SSOProvider(id: $id, type: $type, name: $name, displayName: $displayName, isEnabled: $isEnabled, clientId: $clientId, clientSecret: $clientSecret, redirectUri: $redirectUri, providerId: $providerId, providerEmail: $providerEmail, providerName: $providerName, providerPhotoUrl: $providerPhotoUrl, institutionId: $institutionId, companyId: $companyId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SSOProviderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientSecret, clientSecret) ||
                other.clientSecret == clientSecret) &&
            (identical(other.redirectUri, redirectUri) ||
                other.redirectUri == redirectUri) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.providerEmail, providerEmail) ||
                other.providerEmail == providerEmail) &&
            (identical(other.providerName, providerName) ||
                other.providerName == providerName) &&
            (identical(other.providerPhotoUrl, providerPhotoUrl) ||
                other.providerPhotoUrl == providerPhotoUrl) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    name,
    displayName,
    isEnabled,
    clientId,
    clientSecret,
    redirectUri,
    providerId,
    providerEmail,
    providerName,
    providerPhotoUrl,
    institutionId,
    companyId,
  );

  /// Create a copy of SSOProvider
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SSOProviderImplCopyWith<_$SSOProviderImpl> get copyWith =>
      __$$SSOProviderImplCopyWithImpl<_$SSOProviderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SSOProviderImplToJson(this);
  }
}

abstract class _SSOProvider implements SSOProvider {
  const factory _SSOProvider({
    required final String id,
    required final SSOProviderType type,
    required final String name,
    required final String displayName,
    required final bool isEnabled,
    final String? clientId,
    final String? clientSecret,
    final String? redirectUri,
    final String? providerId,
    final String? providerEmail,
    final String? providerName,
    final String? providerPhotoUrl,
    final String? institutionId,
    final String? companyId,
  }) = _$SSOProviderImpl;

  factory _SSOProvider.fromJson(Map<String, dynamic> json) =
      _$SSOProviderImpl.fromJson;

  @override
  String get id;
  @override
  SSOProviderType get type;
  @override
  String get name;
  @override
  String get displayName;
  @override
  bool get isEnabled;

  /// معلومات التكوين
  @override
  String? get clientId;
  @override
  String? get clientSecret;
  @override
  String? get redirectUri;

  /// معلومات المستخدم من المزود
  @override
  String? get providerId;
  @override
  String? get providerEmail;
  @override
  String? get providerName;
  @override
  String? get providerPhotoUrl;

  /// Tenant
  @override
  String? get institutionId;
  @override
  String? get companyId;

  /// Create a copy of SSOProvider
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SSOProviderImplCopyWith<_$SSOProviderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SSOLoginResult _$SSOLoginResultFromJson(Map<String, dynamic> json) {
  return _SSOLoginResult.fromJson(json);
}

/// @nodoc
mixin _$SSOLoginResult {
  bool get success => throw _privateConstructorUsedError;
  SSOProviderType get provider => throw _privateConstructorUsedError;

  /// معلومات المستخدم
  String? get userId => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  String? get idToken => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;

  /// رسالة الخطأ
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Serializes this SSOLoginResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SSOLoginResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SSOLoginResultCopyWith<SSOLoginResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SSOLoginResultCopyWith<$Res> {
  factory $SSOLoginResultCopyWith(
    SSOLoginResult value,
    $Res Function(SSOLoginResult) then,
  ) = _$SSOLoginResultCopyWithImpl<$Res, SSOLoginResult>;
  @useResult
  $Res call({
    bool success,
    SSOProviderType provider,
    String? userId,
    String? email,
    String? displayName,
    String? photoUrl,
    String? idToken,
    String? accessToken,
    String? errorMessage,
  });
}

/// @nodoc
class _$SSOLoginResultCopyWithImpl<$Res, $Val extends SSOLoginResult>
    implements $SSOLoginResultCopyWith<$Res> {
  _$SSOLoginResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SSOLoginResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? provider = null,
    Object? userId = freezed,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? idToken = freezed,
    Object? accessToken = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            provider: null == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                      as SSOProviderType,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            photoUrl: freezed == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            idToken: freezed == idToken
                ? _value.idToken
                : idToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            accessToken: freezed == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SSOLoginResultImplCopyWith<$Res>
    implements $SSOLoginResultCopyWith<$Res> {
  factory _$$SSOLoginResultImplCopyWith(
    _$SSOLoginResultImpl value,
    $Res Function(_$SSOLoginResultImpl) then,
  ) = __$$SSOLoginResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    SSOProviderType provider,
    String? userId,
    String? email,
    String? displayName,
    String? photoUrl,
    String? idToken,
    String? accessToken,
    String? errorMessage,
  });
}

/// @nodoc
class __$$SSOLoginResultImplCopyWithImpl<$Res>
    extends _$SSOLoginResultCopyWithImpl<$Res, _$SSOLoginResultImpl>
    implements _$$SSOLoginResultImplCopyWith<$Res> {
  __$$SSOLoginResultImplCopyWithImpl(
    _$SSOLoginResultImpl _value,
    $Res Function(_$SSOLoginResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SSOLoginResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? provider = null,
    Object? userId = freezed,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? idToken = freezed,
    Object? accessToken = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$SSOLoginResultImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        provider: null == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as SSOProviderType,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        photoUrl: freezed == photoUrl
            ? _value.photoUrl
            : photoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        idToken: freezed == idToken
            ? _value.idToken
            : idToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        accessToken: freezed == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SSOLoginResultImpl implements _SSOLoginResult {
  const _$SSOLoginResultImpl({
    required this.success,
    required this.provider,
    this.userId,
    this.email,
    this.displayName,
    this.photoUrl,
    this.idToken,
    this.accessToken,
    this.errorMessage,
  });

  factory _$SSOLoginResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SSOLoginResultImplFromJson(json);

  @override
  final bool success;
  @override
  final SSOProviderType provider;

  /// معلومات المستخدم
  @override
  final String? userId;
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final String? photoUrl;
  @override
  final String? idToken;
  @override
  final String? accessToken;

  /// رسالة الخطأ
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'SSOLoginResult(success: $success, provider: $provider, userId: $userId, email: $email, displayName: $displayName, photoUrl: $photoUrl, idToken: $idToken, accessToken: $accessToken, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SSOLoginResultImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.idToken, idToken) || other.idToken == idToken) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    provider,
    userId,
    email,
    displayName,
    photoUrl,
    idToken,
    accessToken,
    errorMessage,
  );

  /// Create a copy of SSOLoginResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SSOLoginResultImplCopyWith<_$SSOLoginResultImpl> get copyWith =>
      __$$SSOLoginResultImplCopyWithImpl<_$SSOLoginResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SSOLoginResultImplToJson(this);
  }
}

abstract class _SSOLoginResult implements SSOLoginResult {
  const factory _SSOLoginResult({
    required final bool success,
    required final SSOProviderType provider,
    final String? userId,
    final String? email,
    final String? displayName,
    final String? photoUrl,
    final String? idToken,
    final String? accessToken,
    final String? errorMessage,
  }) = _$SSOLoginResultImpl;

  factory _SSOLoginResult.fromJson(Map<String, dynamic> json) =
      _$SSOLoginResultImpl.fromJson;

  @override
  bool get success;
  @override
  SSOProviderType get provider;

  /// معلومات المستخدم
  @override
  String? get userId;
  @override
  String? get email;
  @override
  String? get displayName;
  @override
  String? get photoUrl;
  @override
  String? get idToken;
  @override
  String? get accessToken;

  /// رسالة الخطأ
  @override
  String? get errorMessage;

  /// Create a copy of SSOLoginResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SSOLoginResultImplCopyWith<_$SSOLoginResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SSOSettings _$SSOSettingsFromJson(Map<String, dynamic> json) {
  return _SSOSettings.fromJson(json);
}

/// @nodoc
mixin _$SSOSettings {
  String get institutionId => throw _privateConstructorUsedError;

  /// المزودات المفعلة
  bool get googleEnabled => throw _privateConstructorUsedError;
  bool get appleEnabled => throw _privateConstructorUsedError;
  bool get microsoftEnabled => throw _privateConstructorUsedError;

  /// إعدادات Google
  String? get googleClientId => throw _privateConstructorUsedError;
  String? get googleClientSecret => throw _privateConstructorUsedError;

  /// إعدادات Apple
  String? get appleClientId => throw _privateConstructorUsedError;
  String? get appleTeamId => throw _privateConstructorUsedError;

  /// إعدادات Microsoft
  String? get microsoftTenantId => throw _privateConstructorUsedError;
  String? get microsoftClientId => throw _privateConstructorUsedError;

  /// إنشاء حساب تلقائي عند أول تسجيل دخول
  bool get autoCreateAccount => throw _privateConstructorUsedError;

  /// المجالات المسموح بها (للبريد الإلكتروني)
  List<String> get allowedDomains => throw _privateConstructorUsedError;

  /// الدور الافتراضي للمستخدمين الجدد
  String get defaultRole => throw _privateConstructorUsedError;

  /// Serializes this SSOSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SSOSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SSOSettingsCopyWith<SSOSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SSOSettingsCopyWith<$Res> {
  factory $SSOSettingsCopyWith(
    SSOSettings value,
    $Res Function(SSOSettings) then,
  ) = _$SSOSettingsCopyWithImpl<$Res, SSOSettings>;
  @useResult
  $Res call({
    String institutionId,
    bool googleEnabled,
    bool appleEnabled,
    bool microsoftEnabled,
    String? googleClientId,
    String? googleClientSecret,
    String? appleClientId,
    String? appleTeamId,
    String? microsoftTenantId,
    String? microsoftClientId,
    bool autoCreateAccount,
    List<String> allowedDomains,
    String defaultRole,
  });
}

/// @nodoc
class _$SSOSettingsCopyWithImpl<$Res, $Val extends SSOSettings>
    implements $SSOSettingsCopyWith<$Res> {
  _$SSOSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SSOSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? institutionId = null,
    Object? googleEnabled = null,
    Object? appleEnabled = null,
    Object? microsoftEnabled = null,
    Object? googleClientId = freezed,
    Object? googleClientSecret = freezed,
    Object? appleClientId = freezed,
    Object? appleTeamId = freezed,
    Object? microsoftTenantId = freezed,
    Object? microsoftClientId = freezed,
    Object? autoCreateAccount = null,
    Object? allowedDomains = null,
    Object? defaultRole = null,
  }) {
    return _then(
      _value.copyWith(
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            googleEnabled: null == googleEnabled
                ? _value.googleEnabled
                : googleEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            appleEnabled: null == appleEnabled
                ? _value.appleEnabled
                : appleEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            microsoftEnabled: null == microsoftEnabled
                ? _value.microsoftEnabled
                : microsoftEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            googleClientId: freezed == googleClientId
                ? _value.googleClientId
                : googleClientId // ignore: cast_nullable_to_non_nullable
                      as String?,
            googleClientSecret: freezed == googleClientSecret
                ? _value.googleClientSecret
                : googleClientSecret // ignore: cast_nullable_to_non_nullable
                      as String?,
            appleClientId: freezed == appleClientId
                ? _value.appleClientId
                : appleClientId // ignore: cast_nullable_to_non_nullable
                      as String?,
            appleTeamId: freezed == appleTeamId
                ? _value.appleTeamId
                : appleTeamId // ignore: cast_nullable_to_non_nullable
                      as String?,
            microsoftTenantId: freezed == microsoftTenantId
                ? _value.microsoftTenantId
                : microsoftTenantId // ignore: cast_nullable_to_non_nullable
                      as String?,
            microsoftClientId: freezed == microsoftClientId
                ? _value.microsoftClientId
                : microsoftClientId // ignore: cast_nullable_to_non_nullable
                      as String?,
            autoCreateAccount: null == autoCreateAccount
                ? _value.autoCreateAccount
                : autoCreateAccount // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowedDomains: null == allowedDomains
                ? _value.allowedDomains
                : allowedDomains // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            defaultRole: null == defaultRole
                ? _value.defaultRole
                : defaultRole // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SSOSettingsImplCopyWith<$Res>
    implements $SSOSettingsCopyWith<$Res> {
  factory _$$SSOSettingsImplCopyWith(
    _$SSOSettingsImpl value,
    $Res Function(_$SSOSettingsImpl) then,
  ) = __$$SSOSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String institutionId,
    bool googleEnabled,
    bool appleEnabled,
    bool microsoftEnabled,
    String? googleClientId,
    String? googleClientSecret,
    String? appleClientId,
    String? appleTeamId,
    String? microsoftTenantId,
    String? microsoftClientId,
    bool autoCreateAccount,
    List<String> allowedDomains,
    String defaultRole,
  });
}

/// @nodoc
class __$$SSOSettingsImplCopyWithImpl<$Res>
    extends _$SSOSettingsCopyWithImpl<$Res, _$SSOSettingsImpl>
    implements _$$SSOSettingsImplCopyWith<$Res> {
  __$$SSOSettingsImplCopyWithImpl(
    _$SSOSettingsImpl _value,
    $Res Function(_$SSOSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SSOSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? institutionId = null,
    Object? googleEnabled = null,
    Object? appleEnabled = null,
    Object? microsoftEnabled = null,
    Object? googleClientId = freezed,
    Object? googleClientSecret = freezed,
    Object? appleClientId = freezed,
    Object? appleTeamId = freezed,
    Object? microsoftTenantId = freezed,
    Object? microsoftClientId = freezed,
    Object? autoCreateAccount = null,
    Object? allowedDomains = null,
    Object? defaultRole = null,
  }) {
    return _then(
      _$SSOSettingsImpl(
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        googleEnabled: null == googleEnabled
            ? _value.googleEnabled
            : googleEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        appleEnabled: null == appleEnabled
            ? _value.appleEnabled
            : appleEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        microsoftEnabled: null == microsoftEnabled
            ? _value.microsoftEnabled
            : microsoftEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        googleClientId: freezed == googleClientId
            ? _value.googleClientId
            : googleClientId // ignore: cast_nullable_to_non_nullable
                  as String?,
        googleClientSecret: freezed == googleClientSecret
            ? _value.googleClientSecret
            : googleClientSecret // ignore: cast_nullable_to_non_nullable
                  as String?,
        appleClientId: freezed == appleClientId
            ? _value.appleClientId
            : appleClientId // ignore: cast_nullable_to_non_nullable
                  as String?,
        appleTeamId: freezed == appleTeamId
            ? _value.appleTeamId
            : appleTeamId // ignore: cast_nullable_to_non_nullable
                  as String?,
        microsoftTenantId: freezed == microsoftTenantId
            ? _value.microsoftTenantId
            : microsoftTenantId // ignore: cast_nullable_to_non_nullable
                  as String?,
        microsoftClientId: freezed == microsoftClientId
            ? _value.microsoftClientId
            : microsoftClientId // ignore: cast_nullable_to_non_nullable
                  as String?,
        autoCreateAccount: null == autoCreateAccount
            ? _value.autoCreateAccount
            : autoCreateAccount // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowedDomains: null == allowedDomains
            ? _value._allowedDomains
            : allowedDomains // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        defaultRole: null == defaultRole
            ? _value.defaultRole
            : defaultRole // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SSOSettingsImpl implements _SSOSettings {
  const _$SSOSettingsImpl({
    required this.institutionId,
    this.googleEnabled = false,
    this.appleEnabled = false,
    this.microsoftEnabled = false,
    this.googleClientId,
    this.googleClientSecret,
    this.appleClientId,
    this.appleTeamId,
    this.microsoftTenantId,
    this.microsoftClientId,
    this.autoCreateAccount = true,
    final List<String> allowedDomains = const [],
    this.defaultRole = 'trainee',
  }) : _allowedDomains = allowedDomains;

  factory _$SSOSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SSOSettingsImplFromJson(json);

  @override
  final String institutionId;

  /// المزودات المفعلة
  @override
  @JsonKey()
  final bool googleEnabled;
  @override
  @JsonKey()
  final bool appleEnabled;
  @override
  @JsonKey()
  final bool microsoftEnabled;

  /// إعدادات Google
  @override
  final String? googleClientId;
  @override
  final String? googleClientSecret;

  /// إعدادات Apple
  @override
  final String? appleClientId;
  @override
  final String? appleTeamId;

  /// إعدادات Microsoft
  @override
  final String? microsoftTenantId;
  @override
  final String? microsoftClientId;

  /// إنشاء حساب تلقائي عند أول تسجيل دخول
  @override
  @JsonKey()
  final bool autoCreateAccount;

  /// المجالات المسموح بها (للبريد الإلكتروني)
  final List<String> _allowedDomains;

  /// المجالات المسموح بها (للبريد الإلكتروني)
  @override
  @JsonKey()
  List<String> get allowedDomains {
    if (_allowedDomains is EqualUnmodifiableListView) return _allowedDomains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedDomains);
  }

  /// الدور الافتراضي للمستخدمين الجدد
  @override
  @JsonKey()
  final String defaultRole;

  @override
  String toString() {
    return 'SSOSettings(institutionId: $institutionId, googleEnabled: $googleEnabled, appleEnabled: $appleEnabled, microsoftEnabled: $microsoftEnabled, googleClientId: $googleClientId, googleClientSecret: $googleClientSecret, appleClientId: $appleClientId, appleTeamId: $appleTeamId, microsoftTenantId: $microsoftTenantId, microsoftClientId: $microsoftClientId, autoCreateAccount: $autoCreateAccount, allowedDomains: $allowedDomains, defaultRole: $defaultRole)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SSOSettingsImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.googleEnabled, googleEnabled) ||
                other.googleEnabled == googleEnabled) &&
            (identical(other.appleEnabled, appleEnabled) ||
                other.appleEnabled == appleEnabled) &&
            (identical(other.microsoftEnabled, microsoftEnabled) ||
                other.microsoftEnabled == microsoftEnabled) &&
            (identical(other.googleClientId, googleClientId) ||
                other.googleClientId == googleClientId) &&
            (identical(other.googleClientSecret, googleClientSecret) ||
                other.googleClientSecret == googleClientSecret) &&
            (identical(other.appleClientId, appleClientId) ||
                other.appleClientId == appleClientId) &&
            (identical(other.appleTeamId, appleTeamId) ||
                other.appleTeamId == appleTeamId) &&
            (identical(other.microsoftTenantId, microsoftTenantId) ||
                other.microsoftTenantId == microsoftTenantId) &&
            (identical(other.microsoftClientId, microsoftClientId) ||
                other.microsoftClientId == microsoftClientId) &&
            (identical(other.autoCreateAccount, autoCreateAccount) ||
                other.autoCreateAccount == autoCreateAccount) &&
            const DeepCollectionEquality().equals(
              other._allowedDomains,
              _allowedDomains,
            ) &&
            (identical(other.defaultRole, defaultRole) ||
                other.defaultRole == defaultRole));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    institutionId,
    googleEnabled,
    appleEnabled,
    microsoftEnabled,
    googleClientId,
    googleClientSecret,
    appleClientId,
    appleTeamId,
    microsoftTenantId,
    microsoftClientId,
    autoCreateAccount,
    const DeepCollectionEquality().hash(_allowedDomains),
    defaultRole,
  );

  /// Create a copy of SSOSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SSOSettingsImplCopyWith<_$SSOSettingsImpl> get copyWith =>
      __$$SSOSettingsImplCopyWithImpl<_$SSOSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SSOSettingsImplToJson(this);
  }
}

abstract class _SSOSettings implements SSOSettings {
  const factory _SSOSettings({
    required final String institutionId,
    final bool googleEnabled,
    final bool appleEnabled,
    final bool microsoftEnabled,
    final String? googleClientId,
    final String? googleClientSecret,
    final String? appleClientId,
    final String? appleTeamId,
    final String? microsoftTenantId,
    final String? microsoftClientId,
    final bool autoCreateAccount,
    final List<String> allowedDomains,
    final String defaultRole,
  }) = _$SSOSettingsImpl;

  factory _SSOSettings.fromJson(Map<String, dynamic> json) =
      _$SSOSettingsImpl.fromJson;

  @override
  String get institutionId;

  /// المزودات المفعلة
  @override
  bool get googleEnabled;
  @override
  bool get appleEnabled;
  @override
  bool get microsoftEnabled;

  /// إعدادات Google
  @override
  String? get googleClientId;
  @override
  String? get googleClientSecret;

  /// إعدادات Apple
  @override
  String? get appleClientId;
  @override
  String? get appleTeamId;

  /// إعدادات Microsoft
  @override
  String? get microsoftTenantId;
  @override
  String? get microsoftClientId;

  /// إنشاء حساب تلقائي عند أول تسجيل دخول
  @override
  bool get autoCreateAccount;

  /// المجالات المسموح بها (للبريد الإلكتروني)
  @override
  List<String> get allowedDomains;

  /// الدور الافتراضي للمستخدمين الجدد
  @override
  String get defaultRole;

  /// Create a copy of SSOSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SSOSettingsImplCopyWith<_$SSOSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
