// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_skill_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserSkillStats _$UserSkillStatsFromJson(Map<String, dynamic> json) {
  return _UserSkillStats.fromJson(json);
}

/// @nodoc
mixin _$UserSkillStats {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get skillCode => throw _privateConstructorUsedError;
  double get masteryScore => throw _privateConstructorUsedError;
  int get attempts => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastUpdate => throw _privateConstructorUsedError;
  double get delta14d => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this UserSkillStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSkillStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSkillStatsCopyWith<UserSkillStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSkillStatsCopyWith<$Res> {
  factory $UserSkillStatsCopyWith(
    UserSkillStats value,
    $Res Function(UserSkillStats) then,
  ) = _$UserSkillStatsCopyWithImpl<$Res, UserSkillStats>;
  @useResult
  $Res call({
    String id,
    String userId,
    String skillCode,
    double masteryScore,
    int attempts,
    @TimestampConverter() DateTime? lastUpdate,
    double delta14d,
    @TimestampConverter() DateTime? createdAt,
  });
}

/// @nodoc
class _$UserSkillStatsCopyWithImpl<$Res, $Val extends UserSkillStats>
    implements $UserSkillStatsCopyWith<$Res> {
  _$UserSkillStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSkillStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? skillCode = null,
    Object? masteryScore = null,
    Object? attempts = null,
    Object? lastUpdate = freezed,
    Object? delta14d = null,
    Object? createdAt = freezed,
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
            masteryScore: null == masteryScore
                ? _value.masteryScore
                : masteryScore // ignore: cast_nullable_to_non_nullable
                      as double,
            attempts: null == attempts
                ? _value.attempts
                : attempts // ignore: cast_nullable_to_non_nullable
                      as int,
            lastUpdate: freezed == lastUpdate
                ? _value.lastUpdate
                : lastUpdate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            delta14d: null == delta14d
                ? _value.delta14d
                : delta14d // ignore: cast_nullable_to_non_nullable
                      as double,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSkillStatsImplCopyWith<$Res>
    implements $UserSkillStatsCopyWith<$Res> {
  factory _$$UserSkillStatsImplCopyWith(
    _$UserSkillStatsImpl value,
    $Res Function(_$UserSkillStatsImpl) then,
  ) = __$$UserSkillStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String skillCode,
    double masteryScore,
    int attempts,
    @TimestampConverter() DateTime? lastUpdate,
    double delta14d,
    @TimestampConverter() DateTime? createdAt,
  });
}

/// @nodoc
class __$$UserSkillStatsImplCopyWithImpl<$Res>
    extends _$UserSkillStatsCopyWithImpl<$Res, _$UserSkillStatsImpl>
    implements _$$UserSkillStatsImplCopyWith<$Res> {
  __$$UserSkillStatsImplCopyWithImpl(
    _$UserSkillStatsImpl _value,
    $Res Function(_$UserSkillStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSkillStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? skillCode = null,
    Object? masteryScore = null,
    Object? attempts = null,
    Object? lastUpdate = freezed,
    Object? delta14d = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$UserSkillStatsImpl(
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
        masteryScore: null == masteryScore
            ? _value.masteryScore
            : masteryScore // ignore: cast_nullable_to_non_nullable
                  as double,
        attempts: null == attempts
            ? _value.attempts
            : attempts // ignore: cast_nullable_to_non_nullable
                  as int,
        lastUpdate: freezed == lastUpdate
            ? _value.lastUpdate
            : lastUpdate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        delta14d: null == delta14d
            ? _value.delta14d
            : delta14d // ignore: cast_nullable_to_non_nullable
                  as double,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSkillStatsImpl extends _UserSkillStats {
  const _$UserSkillStatsImpl({
    required this.id,
    required this.userId,
    required this.skillCode,
    this.masteryScore = 0,
    this.attempts = 0,
    @TimestampConverter() this.lastUpdate,
    this.delta14d = 0,
    @TimestampConverter() this.createdAt,
  }) : super._();

  factory _$UserSkillStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSkillStatsImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String skillCode;
  @override
  @JsonKey()
  final double masteryScore;
  @override
  @JsonKey()
  final int attempts;
  @override
  @TimestampConverter()
  final DateTime? lastUpdate;
  @override
  @JsonKey()
  final double delta14d;
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'UserSkillStats(id: $id, userId: $userId, skillCode: $skillCode, masteryScore: $masteryScore, attempts: $attempts, lastUpdate: $lastUpdate, delta14d: $delta14d, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSkillStatsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.skillCode, skillCode) ||
                other.skillCode == skillCode) &&
            (identical(other.masteryScore, masteryScore) ||
                other.masteryScore == masteryScore) &&
            (identical(other.attempts, attempts) ||
                other.attempts == attempts) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate) &&
            (identical(other.delta14d, delta14d) ||
                other.delta14d == delta14d) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    skillCode,
    masteryScore,
    attempts,
    lastUpdate,
    delta14d,
    createdAt,
  );

  /// Create a copy of UserSkillStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSkillStatsImplCopyWith<_$UserSkillStatsImpl> get copyWith =>
      __$$UserSkillStatsImplCopyWithImpl<_$UserSkillStatsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSkillStatsImplToJson(this);
  }
}

abstract class _UserSkillStats extends UserSkillStats {
  const factory _UserSkillStats({
    required final String id,
    required final String userId,
    required final String skillCode,
    final double masteryScore,
    final int attempts,
    @TimestampConverter() final DateTime? lastUpdate,
    final double delta14d,
    @TimestampConverter() final DateTime? createdAt,
  }) = _$UserSkillStatsImpl;
  const _UserSkillStats._() : super._();

  factory _UserSkillStats.fromJson(Map<String, dynamic> json) =
      _$UserSkillStatsImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get skillCode;
  @override
  double get masteryScore;
  @override
  int get attempts;
  @override
  @TimestampConverter()
  DateTime? get lastUpdate;
  @override
  double get delta14d;
  @override
  @TimestampConverter()
  DateTime? get createdAt;

  /// Create a copy of UserSkillStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSkillStatsImplCopyWith<_$UserSkillStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
