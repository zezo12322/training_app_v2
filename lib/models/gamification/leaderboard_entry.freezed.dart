// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LeaderboardEntry _$LeaderboardEntryFromJson(Map<String, dynamic> json) {
  return _LeaderboardEntry.fromJson(json);
}

/// @nodoc
mixin _$LeaderboardEntry {
  /// معرف المستخدم
  String get userId => throw _privateConstructorUsedError;

  /// اسم المستخدم
  String get userName => throw _privateConstructorUsedError;

  /// صورة المستخدم (اختياري)
  String? get userAvatar => throw _privateConstructorUsedError;

  /// إجمالي النقاط
  int get totalPoints => throw _privateConstructorUsedError;

  /// المستوى الحالي
  int get currentLevel => throw _privateConstructorUsedError;

  /// اسم المستوى
  String get levelName => throw _privateConstructorUsedError;

  /// الترتيب
  int get rank => throw _privateConstructorUsedError;

  /// عدد الوحدات المكتملة
  int get moduleCount => throw _privateConstructorUsedError;

  /// عدد الاختبارات المكتملة
  int get quizCount => throw _privateConstructorUsedError;

  /// عدد أيام Daily Streak
  int get streakCount => throw _privateConstructorUsedError;

  /// آخر نشاط
  DateTime? get lastActivity => throw _privateConstructorUsedError;

  /// Serializes this LeaderboardEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderboardEntryCopyWith<LeaderboardEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardEntryCopyWith<$Res> {
  factory $LeaderboardEntryCopyWith(
    LeaderboardEntry value,
    $Res Function(LeaderboardEntry) then,
  ) = _$LeaderboardEntryCopyWithImpl<$Res, LeaderboardEntry>;
  @useResult
  $Res call({
    String userId,
    String userName,
    String? userAvatar,
    int totalPoints,
    int currentLevel,
    String levelName,
    int rank,
    int moduleCount,
    int quizCount,
    int streakCount,
    DateTime? lastActivity,
  });
}

/// @nodoc
class _$LeaderboardEntryCopyWithImpl<$Res, $Val extends LeaderboardEntry>
    implements $LeaderboardEntryCopyWith<$Res> {
  _$LeaderboardEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? userAvatar = freezed,
    Object? totalPoints = null,
    Object? currentLevel = null,
    Object? levelName = null,
    Object? rank = null,
    Object? moduleCount = null,
    Object? quizCount = null,
    Object? streakCount = null,
    Object? lastActivity = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            userAvatar: freezed == userAvatar
                ? _value.userAvatar
                : userAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalPoints: null == totalPoints
                ? _value.totalPoints
                : totalPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            currentLevel: null == currentLevel
                ? _value.currentLevel
                : currentLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            levelName: null == levelName
                ? _value.levelName
                : levelName // ignore: cast_nullable_to_non_nullable
                      as String,
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
            moduleCount: null == moduleCount
                ? _value.moduleCount
                : moduleCount // ignore: cast_nullable_to_non_nullable
                      as int,
            quizCount: null == quizCount
                ? _value.quizCount
                : quizCount // ignore: cast_nullable_to_non_nullable
                      as int,
            streakCount: null == streakCount
                ? _value.streakCount
                : streakCount // ignore: cast_nullable_to_non_nullable
                      as int,
            lastActivity: freezed == lastActivity
                ? _value.lastActivity
                : lastActivity // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LeaderboardEntryImplCopyWith<$Res>
    implements $LeaderboardEntryCopyWith<$Res> {
  factory _$$LeaderboardEntryImplCopyWith(
    _$LeaderboardEntryImpl value,
    $Res Function(_$LeaderboardEntryImpl) then,
  ) = __$$LeaderboardEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String userName,
    String? userAvatar,
    int totalPoints,
    int currentLevel,
    String levelName,
    int rank,
    int moduleCount,
    int quizCount,
    int streakCount,
    DateTime? lastActivity,
  });
}

/// @nodoc
class __$$LeaderboardEntryImplCopyWithImpl<$Res>
    extends _$LeaderboardEntryCopyWithImpl<$Res, _$LeaderboardEntryImpl>
    implements _$$LeaderboardEntryImplCopyWith<$Res> {
  __$$LeaderboardEntryImplCopyWithImpl(
    _$LeaderboardEntryImpl _value,
    $Res Function(_$LeaderboardEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? userAvatar = freezed,
    Object? totalPoints = null,
    Object? currentLevel = null,
    Object? levelName = null,
    Object? rank = null,
    Object? moduleCount = null,
    Object? quizCount = null,
    Object? streakCount = null,
    Object? lastActivity = freezed,
  }) {
    return _then(
      _$LeaderboardEntryImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        userAvatar: freezed == userAvatar
            ? _value.userAvatar
            : userAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalPoints: null == totalPoints
            ? _value.totalPoints
            : totalPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        currentLevel: null == currentLevel
            ? _value.currentLevel
            : currentLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        levelName: null == levelName
            ? _value.levelName
            : levelName // ignore: cast_nullable_to_non_nullable
                  as String,
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
        moduleCount: null == moduleCount
            ? _value.moduleCount
            : moduleCount // ignore: cast_nullable_to_non_nullable
                  as int,
        quizCount: null == quizCount
            ? _value.quizCount
            : quizCount // ignore: cast_nullable_to_non_nullable
                  as int,
        streakCount: null == streakCount
            ? _value.streakCount
            : streakCount // ignore: cast_nullable_to_non_nullable
                  as int,
        lastActivity: freezed == lastActivity
            ? _value.lastActivity
            : lastActivity // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaderboardEntryImpl implements _LeaderboardEntry {
  const _$LeaderboardEntryImpl({
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.totalPoints,
    required this.currentLevel,
    required this.levelName,
    required this.rank,
    this.moduleCount = 0,
    this.quizCount = 0,
    this.streakCount = 0,
    this.lastActivity,
  });

  factory _$LeaderboardEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderboardEntryImplFromJson(json);

  /// معرف المستخدم
  @override
  final String userId;

  /// اسم المستخدم
  @override
  final String userName;

  /// صورة المستخدم (اختياري)
  @override
  final String? userAvatar;

  /// إجمالي النقاط
  @override
  final int totalPoints;

  /// المستوى الحالي
  @override
  final int currentLevel;

  /// اسم المستوى
  @override
  final String levelName;

  /// الترتيب
  @override
  final int rank;

  /// عدد الوحدات المكتملة
  @override
  @JsonKey()
  final int moduleCount;

  /// عدد الاختبارات المكتملة
  @override
  @JsonKey()
  final int quizCount;

  /// عدد أيام Daily Streak
  @override
  @JsonKey()
  final int streakCount;

  /// آخر نشاط
  @override
  final DateTime? lastActivity;

  @override
  String toString() {
    return 'LeaderboardEntry(userId: $userId, userName: $userName, userAvatar: $userAvatar, totalPoints: $totalPoints, currentLevel: $currentLevel, levelName: $levelName, rank: $rank, moduleCount: $moduleCount, quizCount: $quizCount, streakCount: $streakCount, lastActivity: $lastActivity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardEntryImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userAvatar, userAvatar) ||
                other.userAvatar == userAvatar) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel) &&
            (identical(other.levelName, levelName) ||
                other.levelName == levelName) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.moduleCount, moduleCount) ||
                other.moduleCount == moduleCount) &&
            (identical(other.quizCount, quizCount) ||
                other.quizCount == quizCount) &&
            (identical(other.streakCount, streakCount) ||
                other.streakCount == streakCount) &&
            (identical(other.lastActivity, lastActivity) ||
                other.lastActivity == lastActivity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    userName,
    userAvatar,
    totalPoints,
    currentLevel,
    levelName,
    rank,
    moduleCount,
    quizCount,
    streakCount,
    lastActivity,
  );

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardEntryImplCopyWith<_$LeaderboardEntryImpl> get copyWith =>
      __$$LeaderboardEntryImplCopyWithImpl<_$LeaderboardEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderboardEntryImplToJson(this);
  }
}

abstract class _LeaderboardEntry implements LeaderboardEntry {
  const factory _LeaderboardEntry({
    required final String userId,
    required final String userName,
    final String? userAvatar,
    required final int totalPoints,
    required final int currentLevel,
    required final String levelName,
    required final int rank,
    final int moduleCount,
    final int quizCount,
    final int streakCount,
    final DateTime? lastActivity,
  }) = _$LeaderboardEntryImpl;

  factory _LeaderboardEntry.fromJson(Map<String, dynamic> json) =
      _$LeaderboardEntryImpl.fromJson;

  /// معرف المستخدم
  @override
  String get userId;

  /// اسم المستخدم
  @override
  String get userName;

  /// صورة المستخدم (اختياري)
  @override
  String? get userAvatar;

  /// إجمالي النقاط
  @override
  int get totalPoints;

  /// المستوى الحالي
  @override
  int get currentLevel;

  /// اسم المستوى
  @override
  String get levelName;

  /// الترتيب
  @override
  int get rank;

  /// عدد الوحدات المكتملة
  @override
  int get moduleCount;

  /// عدد الاختبارات المكتملة
  @override
  int get quizCount;

  /// عدد أيام Daily Streak
  @override
  int get streakCount;

  /// آخر نشاط
  @override
  DateTime? get lastActivity;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderboardEntryImplCopyWith<_$LeaderboardEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
