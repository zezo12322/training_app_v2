// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skill_attempt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SkillAttempt _$SkillAttemptFromJson(Map<String, dynamic> json) {
  return _SkillAttempt.fromJson(json);
}

/// @nodoc
mixin _$SkillAttempt {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get skillCode => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get ts => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;

  /// Serializes this SkillAttempt to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SkillAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SkillAttemptCopyWith<SkillAttempt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillAttemptCopyWith<$Res> {
  factory $SkillAttemptCopyWith(
    SkillAttempt value,
    $Res Function(SkillAttempt) then,
  ) = _$SkillAttemptCopyWithImpl<$Res, SkillAttempt>;
  @useResult
  $Res call({
    String id,
    String userId,
    String skillCode,
    bool success,
    @TimestampConverter() DateTime? ts,
    int points,
  });
}

/// @nodoc
class _$SkillAttemptCopyWithImpl<$Res, $Val extends SkillAttempt>
    implements $SkillAttemptCopyWith<$Res> {
  _$SkillAttemptCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SkillAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? skillCode = null,
    Object? success = null,
    Object? ts = freezed,
    Object? points = null,
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
            skillCode: null == skillCode
                ? _value.skillCode
                : skillCode // ignore: cast_nullable_to_non_nullable
                      as String,
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            ts: freezed == ts
                ? _value.ts
                : ts // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SkillAttemptImplCopyWith<$Res>
    implements $SkillAttemptCopyWith<$Res> {
  factory _$$SkillAttemptImplCopyWith(
    _$SkillAttemptImpl value,
    $Res Function(_$SkillAttemptImpl) then,
  ) = __$$SkillAttemptImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String skillCode,
    bool success,
    @TimestampConverter() DateTime? ts,
    int points,
  });
}

/// @nodoc
class __$$SkillAttemptImplCopyWithImpl<$Res>
    extends _$SkillAttemptCopyWithImpl<$Res, _$SkillAttemptImpl>
    implements _$$SkillAttemptImplCopyWith<$Res> {
  __$$SkillAttemptImplCopyWithImpl(
    _$SkillAttemptImpl _value,
    $Res Function(_$SkillAttemptImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SkillAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? skillCode = null,
    Object? success = null,
    Object? ts = freezed,
    Object? points = null,
  }) {
    return _then(
      _$SkillAttemptImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        skillCode: null == skillCode
            ? _value.skillCode
            : skillCode // ignore: cast_nullable_to_non_nullable
                  as String,
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        ts: freezed == ts
            ? _value.ts
            : ts // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SkillAttemptImpl extends _SkillAttempt {
  const _$SkillAttemptImpl({
    required this.id,
    required this.userId,
    required this.skillCode,
    required this.success,
    @TimestampConverter() this.ts,
    this.points = 0,
  }) : super._();

  factory _$SkillAttemptImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillAttemptImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String skillCode;
  @override
  final bool success;
  @override
  @TimestampConverter()
  final DateTime? ts;
  @override
  @JsonKey()
  final int points;

  @override
  String toString() {
    return 'SkillAttempt(id: $id, userId: $userId, skillCode: $skillCode, success: $success, ts: $ts, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkillAttemptImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.skillCode, skillCode) ||
                other.skillCode == skillCode) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.ts, ts) || other.ts == ts) &&
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, skillCode, success, ts, points);

  /// Create a copy of SkillAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SkillAttemptImplCopyWith<_$SkillAttemptImpl> get copyWith =>
      __$$SkillAttemptImplCopyWithImpl<_$SkillAttemptImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkillAttemptImplToJson(this);
  }
}

abstract class _SkillAttempt extends SkillAttempt {
  const factory _SkillAttempt({
    required final String id,
    required final String userId,
    required final String skillCode,
    required final bool success,
    @TimestampConverter() final DateTime? ts,
    final int points,
  }) = _$SkillAttemptImpl;
  const _SkillAttempt._() : super._();

  factory _SkillAttempt.fromJson(Map<String, dynamic> json) =
      _$SkillAttemptImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get skillCode;
  @override
  bool get success;
  @override
  @TimestampConverter()
  DateTime? get ts;
  @override
  int get points;

  /// Create a copy of SkillAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SkillAttemptImplCopyWith<_$SkillAttemptImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
