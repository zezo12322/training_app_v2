// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SystemSettings _$SystemSettingsFromJson(Map<String, dynamic> json) {
  return _SystemSettings.fromJson(json);
}

/// @nodoc
mixin _$SystemSettings {
  String get id =>
      throw _privateConstructorUsedError; // document id (e.g. "global")
  Map<String, dynamic> get featureFlags => throw _privateConstructorUsedError;
  Map<String, dynamic> get thresholds => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this SystemSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SystemSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SystemSettingsCopyWith<SystemSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SystemSettingsCopyWith<$Res> {
  factory $SystemSettingsCopyWith(
    SystemSettings value,
    $Res Function(SystemSettings) then,
  ) = _$SystemSettingsCopyWithImpl<$Res, SystemSettings>;
  @useResult
  $Res call({
    String id,
    Map<String, dynamic> featureFlags,
    Map<String, dynamic> thresholds,
    @TimestampConverter() DateTime? updatedAt,
  });
}

/// @nodoc
class _$SystemSettingsCopyWithImpl<$Res, $Val extends SystemSettings>
    implements $SystemSettingsCopyWith<$Res> {
  _$SystemSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SystemSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? featureFlags = null,
    Object? thresholds = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            featureFlags: null == featureFlags
                ? _value.featureFlags
                : featureFlags // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            thresholds: null == thresholds
                ? _value.thresholds
                : thresholds // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SystemSettingsImplCopyWith<$Res>
    implements $SystemSettingsCopyWith<$Res> {
  factory _$$SystemSettingsImplCopyWith(
    _$SystemSettingsImpl value,
    $Res Function(_$SystemSettingsImpl) then,
  ) = __$$SystemSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    Map<String, dynamic> featureFlags,
    Map<String, dynamic> thresholds,
    @TimestampConverter() DateTime? updatedAt,
  });
}

/// @nodoc
class __$$SystemSettingsImplCopyWithImpl<$Res>
    extends _$SystemSettingsCopyWithImpl<$Res, _$SystemSettingsImpl>
    implements _$$SystemSettingsImplCopyWith<$Res> {
  __$$SystemSettingsImplCopyWithImpl(
    _$SystemSettingsImpl _value,
    $Res Function(_$SystemSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SystemSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? featureFlags = null,
    Object? thresholds = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$SystemSettingsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        featureFlags: null == featureFlags
            ? _value._featureFlags
            : featureFlags // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        thresholds: null == thresholds
            ? _value._thresholds
            : thresholds // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SystemSettingsImpl extends _SystemSettings {
  const _$SystemSettingsImpl({
    required this.id,
    final Map<String, dynamic> featureFlags = const {},
    final Map<String, dynamic> thresholds = const {},
    @TimestampConverter() this.updatedAt,
  }) : _featureFlags = featureFlags,
       _thresholds = thresholds,
       super._();

  factory _$SystemSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SystemSettingsImplFromJson(json);

  @override
  final String id;
  // document id (e.g. "global")
  final Map<String, dynamic> _featureFlags;
  // document id (e.g. "global")
  @override
  @JsonKey()
  Map<String, dynamic> get featureFlags {
    if (_featureFlags is EqualUnmodifiableMapView) return _featureFlags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_featureFlags);
  }

  final Map<String, dynamic> _thresholds;
  @override
  @JsonKey()
  Map<String, dynamic> get thresholds {
    if (_thresholds is EqualUnmodifiableMapView) return _thresholds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_thresholds);
  }

  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'SystemSettings(id: $id, featureFlags: $featureFlags, thresholds: $thresholds, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SystemSettingsImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(
              other._featureFlags,
              _featureFlags,
            ) &&
            const DeepCollectionEquality().equals(
              other._thresholds,
              _thresholds,
            ) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    const DeepCollectionEquality().hash(_featureFlags),
    const DeepCollectionEquality().hash(_thresholds),
    updatedAt,
  );

  /// Create a copy of SystemSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SystemSettingsImplCopyWith<_$SystemSettingsImpl> get copyWith =>
      __$$SystemSettingsImplCopyWithImpl<_$SystemSettingsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SystemSettingsImplToJson(this);
  }
}

abstract class _SystemSettings extends SystemSettings {
  const factory _SystemSettings({
    required final String id,
    final Map<String, dynamic> featureFlags,
    final Map<String, dynamic> thresholds,
    @TimestampConverter() final DateTime? updatedAt,
  }) = _$SystemSettingsImpl;
  const _SystemSettings._() : super._();

  factory _SystemSettings.fromJson(Map<String, dynamic> json) =
      _$SystemSettingsImpl.fromJson;

  @override
  String get id; // document id (e.g. "global")
  @override
  Map<String, dynamic> get featureFlags;
  @override
  Map<String, dynamic> get thresholds;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;

  /// Create a copy of SystemSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SystemSettingsImplCopyWith<_$SystemSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
