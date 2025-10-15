// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'engagement_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EngagementSnapshot _$EngagementSnapshotFromJson(Map<String, dynamic> json) {
  return _EngagementSnapshot.fromJson(json);
}

/// @nodoc
mixin _$EngagementSnapshot {
  String get id =>
      throw _privateConstructorUsedError; // composite userId_YYYYMMDD
  String get userId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError; // YYYY-MM-DD
  int get events7d => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastActiveTs => throw _privateConstructorUsedError;
  int get streak =>
      throw _privateConstructorUsedError; // Optional mastery delta placeholder for future skill stats
  double get masteryDelta14d => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this EngagementSnapshot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EngagementSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EngagementSnapshotCopyWith<EngagementSnapshot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EngagementSnapshotCopyWith<$Res> {
  factory $EngagementSnapshotCopyWith(
    EngagementSnapshot value,
    $Res Function(EngagementSnapshot) then,
  ) = _$EngagementSnapshotCopyWithImpl<$Res, EngagementSnapshot>;
  @useResult
  $Res call({
    String id,
    String userId,
    String date,
    int events7d,
    @TimestampConverter() DateTime? lastActiveTs,
    int streak,
    double masteryDelta14d,
    @TimestampConverter() DateTime? createdAt,
  });
}

/// @nodoc
class _$EngagementSnapshotCopyWithImpl<$Res, $Val extends EngagementSnapshot>
    implements $EngagementSnapshotCopyWith<$Res> {
  _$EngagementSnapshotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EngagementSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? date = null,
    Object? events7d = null,
    Object? lastActiveTs = freezed,
    Object? streak = null,
    Object? masteryDelta14d = null,
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
            events7d: null == events7d
                ? _value.events7d
                : events7d // ignore: cast_nullable_to_non_nullable
                      as int,
            lastActiveTs: freezed == lastActiveTs
                ? _value.lastActiveTs
                : lastActiveTs // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            streak: null == streak
                ? _value.streak
                : streak // ignore: cast_nullable_to_non_nullable
                      as int,
            masteryDelta14d: null == masteryDelta14d
                ? _value.masteryDelta14d
                : masteryDelta14d // ignore: cast_nullable_to_non_nullable
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
abstract class _$$EngagementSnapshotImplCopyWith<$Res>
    implements $EngagementSnapshotCopyWith<$Res> {
  factory _$$EngagementSnapshotImplCopyWith(
    _$EngagementSnapshotImpl value,
    $Res Function(_$EngagementSnapshotImpl) then,
  ) = __$$EngagementSnapshotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String date,
    int events7d,
    @TimestampConverter() DateTime? lastActiveTs,
    int streak,
    double masteryDelta14d,
    @TimestampConverter() DateTime? createdAt,
  });
}

/// @nodoc
class __$$EngagementSnapshotImplCopyWithImpl<$Res>
    extends _$EngagementSnapshotCopyWithImpl<$Res, _$EngagementSnapshotImpl>
    implements _$$EngagementSnapshotImplCopyWith<$Res> {
  __$$EngagementSnapshotImplCopyWithImpl(
    _$EngagementSnapshotImpl _value,
    $Res Function(_$EngagementSnapshotImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EngagementSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? date = null,
    Object? events7d = null,
    Object? lastActiveTs = freezed,
    Object? streak = null,
    Object? masteryDelta14d = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$EngagementSnapshotImpl(
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
        events7d: null == events7d
            ? _value.events7d
            : events7d // ignore: cast_nullable_to_non_nullable
                  as int,
        lastActiveTs: freezed == lastActiveTs
            ? _value.lastActiveTs
            : lastActiveTs // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        streak: null == streak
            ? _value.streak
            : streak // ignore: cast_nullable_to_non_nullable
                  as int,
        masteryDelta14d: null == masteryDelta14d
            ? _value.masteryDelta14d
            : masteryDelta14d // ignore: cast_nullable_to_non_nullable
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
class _$EngagementSnapshotImpl extends _EngagementSnapshot {
  const _$EngagementSnapshotImpl({
    required this.id,
    required this.userId,
    required this.date,
    this.events7d = 0,
    @TimestampConverter() this.lastActiveTs,
    this.streak = 0,
    this.masteryDelta14d = 0,
    @TimestampConverter() this.createdAt,
  }) : super._();

  factory _$EngagementSnapshotImpl.fromJson(Map<String, dynamic> json) =>
      _$$EngagementSnapshotImplFromJson(json);

  @override
  final String id;
  // composite userId_YYYYMMDD
  @override
  final String userId;
  @override
  final String date;
  // YYYY-MM-DD
  @override
  @JsonKey()
  final int events7d;
  @override
  @TimestampConverter()
  final DateTime? lastActiveTs;
  @override
  @JsonKey()
  final int streak;
  // Optional mastery delta placeholder for future skill stats
  @override
  @JsonKey()
  final double masteryDelta14d;
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'EngagementSnapshot(id: $id, userId: $userId, date: $date, events7d: $events7d, lastActiveTs: $lastActiveTs, streak: $streak, masteryDelta14d: $masteryDelta14d, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EngagementSnapshotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.events7d, events7d) ||
                other.events7d == events7d) &&
            (identical(other.lastActiveTs, lastActiveTs) ||
                other.lastActiveTs == lastActiveTs) &&
            (identical(other.streak, streak) || other.streak == streak) &&
            (identical(other.masteryDelta14d, masteryDelta14d) ||
                other.masteryDelta14d == masteryDelta14d) &&
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
    events7d,
    lastActiveTs,
    streak,
    masteryDelta14d,
    createdAt,
  );

  /// Create a copy of EngagementSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EngagementSnapshotImplCopyWith<_$EngagementSnapshotImpl> get copyWith =>
      __$$EngagementSnapshotImplCopyWithImpl<_$EngagementSnapshotImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EngagementSnapshotImplToJson(this);
  }
}

abstract class _EngagementSnapshot extends EngagementSnapshot {
  const factory _EngagementSnapshot({
    required final String id,
    required final String userId,
    required final String date,
    final int events7d,
    @TimestampConverter() final DateTime? lastActiveTs,
    final int streak,
    final double masteryDelta14d,
    @TimestampConverter() final DateTime? createdAt,
  }) = _$EngagementSnapshotImpl;
  const _EngagementSnapshot._() : super._();

  factory _EngagementSnapshot.fromJson(Map<String, dynamic> json) =
      _$EngagementSnapshotImpl.fromJson;

  @override
  String get id; // composite userId_YYYYMMDD
  @override
  String get userId;
  @override
  String get date; // YYYY-MM-DD
  @override
  int get events7d;
  @override
  @TimestampConverter()
  DateTime? get lastActiveTs;
  @override
  int get streak; // Optional mastery delta placeholder for future skill stats
  @override
  double get masteryDelta14d;
  @override
  @TimestampConverter()
  DateTime? get createdAt;

  /// Create a copy of EngagementSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EngagementSnapshotImplCopyWith<_$EngagementSnapshotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
