// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email =>
      throw _privateConstructorUsedError; // role set now includes: trainer | trainee | super_admin | org_admin | company_admin (future: manager/employee variants)
  String get role =>
      throw _privateConstructorUsedError; // 'trainer' | 'trainee' | 'super_admin' | 'org_admin' | 'company_admin'
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get oneSignalPlayerId =>
      throw _privateConstructorUsedError; // Optional profile image URL
  String? get imageUrl =>
      throw _privateConstructorUsedError; // Multi-tenancy (placeholders, may remain null for B2C phase)
  String? get institutionId => throw _privateConstructorUsedError;
  String? get companyId =>
      throw _privateConstructorUsedError; // Blocked users list
  List<String> get blockedUsers =>
      throw _privateConstructorUsedError; // FCM token for push notifications
  String? get fcmToken => throw _privateConstructorUsedError;

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call({
    String id,
    String name,
    String email,
    String role,
    @TimestampConverter() DateTime? createdAt,
    String? oneSignalPlayerId,
    String? imageUrl,
    String? institutionId,
    String? companyId,
    List<String> blockedUsers,
    String? fcmToken,
  });
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
    Object? createdAt = freezed,
    Object? oneSignalPlayerId = freezed,
    Object? imageUrl = freezed,
    Object? institutionId = freezed,
    Object? companyId = freezed,
    Object? blockedUsers = null,
    Object? fcmToken = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            oneSignalPlayerId: freezed == oneSignalPlayerId
                ? _value.oneSignalPlayerId
                : oneSignalPlayerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            institutionId: freezed == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            companyId: freezed == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String?,
            blockedUsers: null == blockedUsers
                ? _value.blockedUsers
                : blockedUsers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            fcmToken: freezed == fcmToken
                ? _value.fcmToken
                : fcmToken // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppUserImplCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(
    _$AppUserImpl value,
    $Res Function(_$AppUserImpl) then,
  ) = __$$AppUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String email,
    String role,
    @TimestampConverter() DateTime? createdAt,
    String? oneSignalPlayerId,
    String? imageUrl,
    String? institutionId,
    String? companyId,
    List<String> blockedUsers,
    String? fcmToken,
  });
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(
    _$AppUserImpl _value,
    $Res Function(_$AppUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? role = null,
    Object? createdAt = freezed,
    Object? oneSignalPlayerId = freezed,
    Object? imageUrl = freezed,
    Object? institutionId = freezed,
    Object? companyId = freezed,
    Object? blockedUsers = null,
    Object? fcmToken = freezed,
  }) {
    return _then(
      _$AppUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        oneSignalPlayerId: freezed == oneSignalPlayerId
            ? _value.oneSignalPlayerId
            : oneSignalPlayerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        institutionId: freezed == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        companyId: freezed == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String?,
        blockedUsers: null == blockedUsers
            ? _value._blockedUsers
            : blockedUsers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        fcmToken: freezed == fcmToken
            ? _value.fcmToken
            : fcmToken // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppUserImpl extends _AppUser {
  const _$AppUserImpl({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    @TimestampConverter() this.createdAt,
    this.oneSignalPlayerId,
    this.imageUrl,
    this.institutionId,
    this.companyId,
    final List<String> blockedUsers = const [],
    this.fcmToken,
  }) : _blockedUsers = blockedUsers,
       super._();

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  // role set now includes: trainer | trainee | super_admin | org_admin | company_admin (future: manager/employee variants)
  @override
  final String role;
  // 'trainer' | 'trainee' | 'super_admin' | 'org_admin' | 'company_admin'
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  final String? oneSignalPlayerId;
  // Optional profile image URL
  @override
  final String? imageUrl;
  // Multi-tenancy (placeholders, may remain null for B2C phase)
  @override
  final String? institutionId;
  @override
  final String? companyId;
  // Blocked users list
  final List<String> _blockedUsers;
  // Blocked users list
  @override
  @JsonKey()
  List<String> get blockedUsers {
    if (_blockedUsers is EqualUnmodifiableListView) return _blockedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blockedUsers);
  }

  // FCM token for push notifications
  @override
  final String? fcmToken;

  @override
  String toString() {
    return 'AppUser(id: $id, name: $name, email: $email, role: $role, createdAt: $createdAt, oneSignalPlayerId: $oneSignalPlayerId, imageUrl: $imageUrl, institutionId: $institutionId, companyId: $companyId, blockedUsers: $blockedUsers, fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.oneSignalPlayerId, oneSignalPlayerId) ||
                other.oneSignalPlayerId == oneSignalPlayerId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            const DeepCollectionEquality().equals(
              other._blockedUsers,
              _blockedUsers,
            ) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    email,
    role,
    createdAt,
    oneSignalPlayerId,
    imageUrl,
    institutionId,
    companyId,
    const DeepCollectionEquality().hash(_blockedUsers),
    fcmToken,
  );

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      __$$AppUserImplCopyWithImpl<_$AppUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(this);
  }
}

abstract class _AppUser extends AppUser {
  const factory _AppUser({
    required final String id,
    required final String name,
    required final String email,
    required final String role,
    @TimestampConverter() final DateTime? createdAt,
    final String? oneSignalPlayerId,
    final String? imageUrl,
    final String? institutionId,
    final String? companyId,
    final List<String> blockedUsers,
    final String? fcmToken,
  }) = _$AppUserImpl;
  const _AppUser._() : super._();

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email; // role set now includes: trainer | trainee | super_admin | org_admin | company_admin (future: manager/employee variants)
  @override
  String get role; // 'trainer' | 'trainee' | 'super_admin' | 'org_admin' | 'company_admin'
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  String? get oneSignalPlayerId; // Optional profile image URL
  @override
  String? get imageUrl; // Multi-tenancy (placeholders, may remain null for B2C phase)
  @override
  String? get institutionId;
  @override
  String? get companyId; // Blocked users list
  @override
  List<String> get blockedUsers; // FCM token for push notifications
  @override
  String? get fcmToken;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
