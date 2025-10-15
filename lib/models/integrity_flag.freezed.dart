// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'integrity_flag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

IntegrityFlag _$IntegrityFlagFromJson(Map<String, dynamic> json) {
  return _IntegrityFlag.fromJson(json);
}

/// @nodoc
mixin _$IntegrityFlag {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // e.g. points_spike, rapid_badge_attempts
  @TimestampConverter()
  DateTime? get ts => throw _privateConstructorUsedError;
  String get severity => throw _privateConstructorUsedError;
  Map<String, dynamic> get details => throw _privateConstructorUsedError;
  bool get resolved => throw _privateConstructorUsedError;

  /// Serializes this IntegrityFlag to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntegrityFlag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntegrityFlagCopyWith<IntegrityFlag> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntegrityFlagCopyWith<$Res> {
  factory $IntegrityFlagCopyWith(
    IntegrityFlag value,
    $Res Function(IntegrityFlag) then,
  ) = _$IntegrityFlagCopyWithImpl<$Res, IntegrityFlag>;
  @useResult
  $Res call({
    String id,
    String userId,
    String type,
    @TimestampConverter() DateTime? ts,
    String severity,
    Map<String, dynamic> details,
    bool resolved,
  });
}

/// @nodoc
class _$IntegrityFlagCopyWithImpl<$Res, $Val extends IntegrityFlag>
    implements $IntegrityFlagCopyWith<$Res> {
  _$IntegrityFlagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntegrityFlag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? ts = freezed,
    Object? severity = null,
    Object? details = null,
    Object? resolved = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            ts: freezed == ts
                ? _value.ts
                : ts // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as String,
            details: null == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            resolved: null == resolved
                ? _value.resolved
                : resolved // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IntegrityFlagImplCopyWith<$Res>
    implements $IntegrityFlagCopyWith<$Res> {
  factory _$$IntegrityFlagImplCopyWith(
    _$IntegrityFlagImpl value,
    $Res Function(_$IntegrityFlagImpl) then,
  ) = __$$IntegrityFlagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String type,
    @TimestampConverter() DateTime? ts,
    String severity,
    Map<String, dynamic> details,
    bool resolved,
  });
}

/// @nodoc
class __$$IntegrityFlagImplCopyWithImpl<$Res>
    extends _$IntegrityFlagCopyWithImpl<$Res, _$IntegrityFlagImpl>
    implements _$$IntegrityFlagImplCopyWith<$Res> {
  __$$IntegrityFlagImplCopyWithImpl(
    _$IntegrityFlagImpl _value,
    $Res Function(_$IntegrityFlagImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IntegrityFlag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? ts = freezed,
    Object? severity = null,
    Object? details = null,
    Object? resolved = null,
  }) {
    return _then(
      _$IntegrityFlagImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        ts: freezed == ts
            ? _value.ts
            : ts // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as String,
        details: null == details
            ? _value._details
            : details // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        resolved: null == resolved
            ? _value.resolved
            : resolved // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IntegrityFlagImpl extends _IntegrityFlag {
  const _$IntegrityFlagImpl({
    required this.id,
    required this.userId,
    required this.type,
    @TimestampConverter() this.ts,
    this.severity = 'low',
    final Map<String, dynamic> details = const {},
    this.resolved = false,
  }) : _details = details,
       super._();

  factory _$IntegrityFlagImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntegrityFlagImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String type;
  // e.g. points_spike, rapid_badge_attempts
  @override
  @TimestampConverter()
  final DateTime? ts;
  @override
  @JsonKey()
  final String severity;
  final Map<String, dynamic> _details;
  @override
  @JsonKey()
  Map<String, dynamic> get details {
    if (_details is EqualUnmodifiableMapView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_details);
  }

  @override
  @JsonKey()
  final bool resolved;

  @override
  String toString() {
    return 'IntegrityFlag(id: $id, userId: $userId, type: $type, ts: $ts, severity: $severity, details: $details, resolved: $resolved)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntegrityFlagImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.ts, ts) || other.ts == ts) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            const DeepCollectionEquality().equals(other._details, _details) &&
            (identical(other.resolved, resolved) ||
                other.resolved == resolved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    type,
    ts,
    severity,
    const DeepCollectionEquality().hash(_details),
    resolved,
  );

  /// Create a copy of IntegrityFlag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntegrityFlagImplCopyWith<_$IntegrityFlagImpl> get copyWith =>
      __$$IntegrityFlagImplCopyWithImpl<_$IntegrityFlagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntegrityFlagImplToJson(this);
  }
}

abstract class _IntegrityFlag extends IntegrityFlag {
  const factory _IntegrityFlag({
    required final String id,
    required final String userId,
    required final String type,
    @TimestampConverter() final DateTime? ts,
    final String severity,
    final Map<String, dynamic> details,
    final bool resolved,
  }) = _$IntegrityFlagImpl;
  const _IntegrityFlag._() : super._();

  factory _IntegrityFlag.fromJson(Map<String, dynamic> json) =
      _$IntegrityFlagImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get type; // e.g. points_spike, rapid_badge_attempts
  @override
  @TimestampConverter()
  DateTime? get ts;
  @override
  String get severity;
  @override
  Map<String, dynamic> get details;
  @override
  bool get resolved;

  /// Create a copy of IntegrityFlag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntegrityFlagImplCopyWith<_$IntegrityFlagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
