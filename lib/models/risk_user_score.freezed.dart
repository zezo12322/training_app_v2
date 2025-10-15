// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'risk_user_score.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RiskUserScore _$RiskUserScoreFromJson(Map<String, dynamic> json) {
  return _RiskUserScore.fromJson(json);
}

/// @nodoc
mixin _$RiskUserScore {
  String get id => throw _privateConstructorUsedError; // userId_YYYYMMDD
  String get userId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError; // YYYY-MM-DD
  double get score => throw _privateConstructorUsedError;
  Map<String, dynamic> get factors => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError; // low|med|high
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this RiskUserScore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RiskUserScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RiskUserScoreCopyWith<RiskUserScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskUserScoreCopyWith<$Res> {
  factory $RiskUserScoreCopyWith(
    RiskUserScore value,
    $Res Function(RiskUserScore) then,
  ) = _$RiskUserScoreCopyWithImpl<$Res, RiskUserScore>;
  @useResult
  $Res call({
    String id,
    String userId,
    String date,
    double score,
    Map<String, dynamic> factors,
    String level,
    @TimestampConverter() DateTime? createdAt,
  });
}

/// @nodoc
class _$RiskUserScoreCopyWithImpl<$Res, $Val extends RiskUserScore>
    implements $RiskUserScoreCopyWith<$Res> {
  _$RiskUserScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RiskUserScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? date = null,
    Object? score = null,
    Object? factors = null,
    Object? level = null,
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
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as double,
            factors: null == factors
                ? _value.factors
                : factors // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$RiskUserScoreImplCopyWith<$Res>
    implements $RiskUserScoreCopyWith<$Res> {
  factory _$$RiskUserScoreImplCopyWith(
    _$RiskUserScoreImpl value,
    $Res Function(_$RiskUserScoreImpl) then,
  ) = __$$RiskUserScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String date,
    double score,
    Map<String, dynamic> factors,
    String level,
    @TimestampConverter() DateTime? createdAt,
  });
}

/// @nodoc
class __$$RiskUserScoreImplCopyWithImpl<$Res>
    extends _$RiskUserScoreCopyWithImpl<$Res, _$RiskUserScoreImpl>
    implements _$$RiskUserScoreImplCopyWith<$Res> {
  __$$RiskUserScoreImplCopyWithImpl(
    _$RiskUserScoreImpl _value,
    $Res Function(_$RiskUserScoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RiskUserScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? date = null,
    Object? score = null,
    Object? factors = null,
    Object? level = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$RiskUserScoreImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as double,
        factors: null == factors
            ? _value._factors
            : factors // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$RiskUserScoreImpl extends _RiskUserScore {
  const _$RiskUserScoreImpl({
    required this.id,
    required this.userId,
    required this.date,
    this.score = 0.0,
    final Map<String, dynamic> factors = const {},
    this.level = 'low',
    @TimestampConverter() this.createdAt,
  }) : _factors = factors,
       super._();

  factory _$RiskUserScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskUserScoreImplFromJson(json);

  @override
  final String id;
  // userId_YYYYMMDD
  @override
  final String userId;
  @override
  final String date;
  // YYYY-MM-DD
  @override
  @JsonKey()
  final double score;
  final Map<String, dynamic> _factors;
  @override
  @JsonKey()
  Map<String, dynamic> get factors {
    if (_factors is EqualUnmodifiableMapView) return _factors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_factors);
  }

  @override
  @JsonKey()
  final String level;
  // low|med|high
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'RiskUserScore(id: $id, userId: $userId, date: $date, score: $score, factors: $factors, level: $level, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskUserScoreImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality().equals(other._factors, _factors) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    date,
    score,
    const DeepCollectionEquality().hash(_factors),
    level,
    createdAt,
  );

  /// Create a copy of RiskUserScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskUserScoreImplCopyWith<_$RiskUserScoreImpl> get copyWith =>
      __$$RiskUserScoreImplCopyWithImpl<_$RiskUserScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskUserScoreImplToJson(this);
  }
}

abstract class _RiskUserScore extends RiskUserScore {
  const factory _RiskUserScore({
    required final String id,
    required final String userId,
    required final String date,
    final double score,
    final Map<String, dynamic> factors,
    final String level,
    @TimestampConverter() final DateTime? createdAt,
  }) = _$RiskUserScoreImpl;
  const _RiskUserScore._() : super._();

  factory _RiskUserScore.fromJson(Map<String, dynamic> json) =
      _$RiskUserScoreImpl.fromJson;

  @override
  String get id; // userId_YYYYMMDD
  @override
  String get userId;
  @override
  String get date; // YYYY-MM-DD
  @override
  double get score;
  @override
  Map<String, dynamic> get factors;
  @override
  String get level; // low|med|high
  @override
  @TimestampConverter()
  DateTime? get createdAt;

  /// Create a copy of RiskUserScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RiskUserScoreImplCopyWith<_$RiskUserScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
