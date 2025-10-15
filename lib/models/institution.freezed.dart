// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'institution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Institution _$InstitutionFromJson(Map<String, dynamic> json) {
  return _Institution.fromJson(json);
}

/// @nodoc
mixin _$Institution {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get planTier => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get meta => throw _privateConstructorUsedError;

  /// Serializes this Institution to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Institution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InstitutionCopyWith<Institution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InstitutionCopyWith<$Res> {
  factory $InstitutionCopyWith(
    Institution value,
    $Res Function(Institution) then,
  ) = _$InstitutionCopyWithImpl<$Res, Institution>;
  @useResult
  $Res call({
    String id,
    String name,
    String planTier,
    bool active,
    @TimestampConverter() DateTime? createdAt,
    Map<String, dynamic> meta,
  });
}

/// @nodoc
class _$InstitutionCopyWithImpl<$Res, $Val extends Institution>
    implements $InstitutionCopyWith<$Res> {
  _$InstitutionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Institution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? planTier = null,
    Object? active = null,
    Object? createdAt = freezed,
    Object? meta = null,
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
            planTier: null == planTier
                ? _value.planTier
                : planTier // ignore: cast_nullable_to_non_nullable
                      as String,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            meta: null == meta
                ? _value.meta
                : meta // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InstitutionImplCopyWith<$Res>
    implements $InstitutionCopyWith<$Res> {
  factory _$$InstitutionImplCopyWith(
    _$InstitutionImpl value,
    $Res Function(_$InstitutionImpl) then,
  ) = __$$InstitutionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String planTier,
    bool active,
    @TimestampConverter() DateTime? createdAt,
    Map<String, dynamic> meta,
  });
}

/// @nodoc
class __$$InstitutionImplCopyWithImpl<$Res>
    extends _$InstitutionCopyWithImpl<$Res, _$InstitutionImpl>
    implements _$$InstitutionImplCopyWith<$Res> {
  __$$InstitutionImplCopyWithImpl(
    _$InstitutionImpl _value,
    $Res Function(_$InstitutionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Institution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? planTier = null,
    Object? active = null,
    Object? createdAt = freezed,
    Object? meta = null,
  }) {
    return _then(
      _$InstitutionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        planTier: null == planTier
            ? _value.planTier
            : planTier // ignore: cast_nullable_to_non_nullable
                  as String,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        meta: null == meta
            ? _value._meta
            : meta // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InstitutionImpl extends _Institution {
  const _$InstitutionImpl({
    required this.id,
    required this.name,
    this.planTier = 'free',
    this.active = true,
    @TimestampConverter() this.createdAt,
    final Map<String, dynamic> meta = const {},
  }) : _meta = meta,
       super._();

  factory _$InstitutionImpl.fromJson(Map<String, dynamic> json) =>
      _$$InstitutionImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String planTier;
  @override
  @JsonKey()
  final bool active;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  final Map<String, dynamic> _meta;
  @override
  @JsonKey()
  Map<String, dynamic> get meta {
    if (_meta is EqualUnmodifiableMapView) return _meta;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_meta);
  }

  @override
  String toString() {
    return 'Institution(id: $id, name: $name, planTier: $planTier, active: $active, createdAt: $createdAt, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InstitutionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.planTier, planTier) ||
                other.planTier == planTier) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._meta, _meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    planTier,
    active,
    createdAt,
    const DeepCollectionEquality().hash(_meta),
  );

  /// Create a copy of Institution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InstitutionImplCopyWith<_$InstitutionImpl> get copyWith =>
      __$$InstitutionImplCopyWithImpl<_$InstitutionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InstitutionImplToJson(this);
  }
}

abstract class _Institution extends Institution {
  const factory _Institution({
    required final String id,
    required final String name,
    final String planTier,
    final bool active,
    @TimestampConverter() final DateTime? createdAt,
    final Map<String, dynamic> meta,
  }) = _$InstitutionImpl;
  const _Institution._() : super._();

  factory _Institution.fromJson(Map<String, dynamic> json) =
      _$InstitutionImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get planTier;
  @override
  bool get active;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  Map<String, dynamic> get meta;

  /// Create a copy of Institution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InstitutionImplCopyWith<_$InstitutionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
