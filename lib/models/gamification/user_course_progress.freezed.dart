// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_course_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserCourseProgress _$UserCourseProgressFromJson(Map<String, dynamic> json) {
  return _UserCourseProgress.fromJson(json);
}

/// @nodoc
mixin _$UserCourseProgress {
  /// معرف المستخدم
  String get userId => throw _privateConstructorUsedError;

  /// معرف الكورس
  String get courseId => throw _privateConstructorUsedError;

  /// إجمالي النقاط المكتسبة
  int get totalPoints => throw _privateConstructorUsedError;

  /// المستوى الحالي
  int get currentLevel => throw _privateConstructorUsedError;

  /// النقاط المتبقية للمستوى التالي
  int get pointsToNextLevel => throw _privateConstructorUsedError;

  /// عدد كل نشاط (activity_type -> count)
  /// مثال: {'completing_lesson': 5, 'passing_quiz': 3}
  Map<String, int> get activityCounts => throw _privateConstructorUsedError;

  /// الشارات المكتسبة
  List<String> get earnedBadges => throw _privateConstructorUsedError;

  /// آخر نشاط
  @TimestampConverter()
  DateTime get lastActivityAt => throw _privateConstructorUsedError;

  /// عدد أيام الدخول المتواصل
  int get dailyStreakCount => throw _privateConstructorUsedError;

  /// أطول سلسلة دخول متواصلة
  int get longestStreak => throw _privateConstructorUsedError;

  /// تاريخ آخر دخول (لحساب الـ streak)
  @TimestampConverter()
  DateTime? get lastStreakCheckDate => throw _privateConstructorUsedError;

  /// تاريخ الإنشاء
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// تاريخ آخر تحديث
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserCourseProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserCourseProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCourseProgressCopyWith<UserCourseProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCourseProgressCopyWith<$Res> {
  factory $UserCourseProgressCopyWith(
    UserCourseProgress value,
    $Res Function(UserCourseProgress) then,
  ) = _$UserCourseProgressCopyWithImpl<$Res, UserCourseProgress>;
  @useResult
  $Res call({
    String userId,
    String courseId,
    int totalPoints,
    int currentLevel,
    int pointsToNextLevel,
    Map<String, int> activityCounts,
    List<String> earnedBadges,
    @TimestampConverter() DateTime lastActivityAt,
    int dailyStreakCount,
    int longestStreak,
    @TimestampConverter() DateTime? lastStreakCheckDate,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  });
}

/// @nodoc
class _$UserCourseProgressCopyWithImpl<$Res, $Val extends UserCourseProgress>
    implements $UserCourseProgressCopyWith<$Res> {
  _$UserCourseProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserCourseProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? courseId = null,
    Object? totalPoints = null,
    Object? currentLevel = null,
    Object? pointsToNextLevel = null,
    Object? activityCounts = null,
    Object? earnedBadges = null,
    Object? lastActivityAt = null,
    Object? dailyStreakCount = null,
    Object? longestStreak = null,
    Object? lastStreakCheckDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            totalPoints: null == totalPoints
                ? _value.totalPoints
                : totalPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            currentLevel: null == currentLevel
                ? _value.currentLevel
                : currentLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            pointsToNextLevel: null == pointsToNextLevel
                ? _value.pointsToNextLevel
                : pointsToNextLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            activityCounts: null == activityCounts
                ? _value.activityCounts
                : activityCounts // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            earnedBadges: null == earnedBadges
                ? _value.earnedBadges
                : earnedBadges // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            lastActivityAt: null == lastActivityAt
                ? _value.lastActivityAt
                : lastActivityAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            dailyStreakCount: null == dailyStreakCount
                ? _value.dailyStreakCount
                : dailyStreakCount // ignore: cast_nullable_to_non_nullable
                      as int,
            longestStreak: null == longestStreak
                ? _value.longestStreak
                : longestStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            lastStreakCheckDate: freezed == lastStreakCheckDate
                ? _value.lastStreakCheckDate
                : lastStreakCheckDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
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
abstract class _$$UserCourseProgressImplCopyWith<$Res>
    implements $UserCourseProgressCopyWith<$Res> {
  factory _$$UserCourseProgressImplCopyWith(
    _$UserCourseProgressImpl value,
    $Res Function(_$UserCourseProgressImpl) then,
  ) = __$$UserCourseProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String courseId,
    int totalPoints,
    int currentLevel,
    int pointsToNextLevel,
    Map<String, int> activityCounts,
    List<String> earnedBadges,
    @TimestampConverter() DateTime lastActivityAt,
    int dailyStreakCount,
    int longestStreak,
    @TimestampConverter() DateTime? lastStreakCheckDate,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  });
}

/// @nodoc
class __$$UserCourseProgressImplCopyWithImpl<$Res>
    extends _$UserCourseProgressCopyWithImpl<$Res, _$UserCourseProgressImpl>
    implements _$$UserCourseProgressImplCopyWith<$Res> {
  __$$UserCourseProgressImplCopyWithImpl(
    _$UserCourseProgressImpl _value,
    $Res Function(_$UserCourseProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserCourseProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? courseId = null,
    Object? totalPoints = null,
    Object? currentLevel = null,
    Object? pointsToNextLevel = null,
    Object? activityCounts = null,
    Object? earnedBadges = null,
    Object? lastActivityAt = null,
    Object? dailyStreakCount = null,
    Object? longestStreak = null,
    Object? lastStreakCheckDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$UserCourseProgressImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        totalPoints: null == totalPoints
            ? _value.totalPoints
            : totalPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        currentLevel: null == currentLevel
            ? _value.currentLevel
            : currentLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        pointsToNextLevel: null == pointsToNextLevel
            ? _value.pointsToNextLevel
            : pointsToNextLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        activityCounts: null == activityCounts
            ? _value._activityCounts
            : activityCounts // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        earnedBadges: null == earnedBadges
            ? _value._earnedBadges
            : earnedBadges // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        lastActivityAt: null == lastActivityAt
            ? _value.lastActivityAt
            : lastActivityAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        dailyStreakCount: null == dailyStreakCount
            ? _value.dailyStreakCount
            : dailyStreakCount // ignore: cast_nullable_to_non_nullable
                  as int,
        longestStreak: null == longestStreak
            ? _value.longestStreak
            : longestStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        lastStreakCheckDate: freezed == lastStreakCheckDate
            ? _value.lastStreakCheckDate
            : lastStreakCheckDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
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
class _$UserCourseProgressImpl implements _UserCourseProgress {
  const _$UserCourseProgressImpl({
    required this.userId,
    required this.courseId,
    this.totalPoints = 0,
    this.currentLevel = 1,
    this.pointsToNextLevel = 100,
    final Map<String, int> activityCounts = const {},
    final List<String> earnedBadges = const [],
    @TimestampConverter() required this.lastActivityAt,
    this.dailyStreakCount = 0,
    this.longestStreak = 0,
    @TimestampConverter() this.lastStreakCheckDate,
    @TimestampConverter() this.createdAt,
    @TimestampConverter() this.updatedAt,
  }) : _activityCounts = activityCounts,
       _earnedBadges = earnedBadges;

  factory _$UserCourseProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserCourseProgressImplFromJson(json);

  /// معرف المستخدم
  @override
  final String userId;

  /// معرف الكورس
  @override
  final String courseId;

  /// إجمالي النقاط المكتسبة
  @override
  @JsonKey()
  final int totalPoints;

  /// المستوى الحالي
  @override
  @JsonKey()
  final int currentLevel;

  /// النقاط المتبقية للمستوى التالي
  @override
  @JsonKey()
  final int pointsToNextLevel;

  /// عدد كل نشاط (activity_type -> count)
  /// مثال: {'completing_lesson': 5, 'passing_quiz': 3}
  final Map<String, int> _activityCounts;

  /// عدد كل نشاط (activity_type -> count)
  /// مثال: {'completing_lesson': 5, 'passing_quiz': 3}
  @override
  @JsonKey()
  Map<String, int> get activityCounts {
    if (_activityCounts is EqualUnmodifiableMapView) return _activityCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_activityCounts);
  }

  /// الشارات المكتسبة
  final List<String> _earnedBadges;

  /// الشارات المكتسبة
  @override
  @JsonKey()
  List<String> get earnedBadges {
    if (_earnedBadges is EqualUnmodifiableListView) return _earnedBadges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_earnedBadges);
  }

  /// آخر نشاط
  @override
  @TimestampConverter()
  final DateTime lastActivityAt;

  /// عدد أيام الدخول المتواصل
  @override
  @JsonKey()
  final int dailyStreakCount;

  /// أطول سلسلة دخول متواصلة
  @override
  @JsonKey()
  final int longestStreak;

  /// تاريخ آخر دخول (لحساب الـ streak)
  @override
  @TimestampConverter()
  final DateTime? lastStreakCheckDate;

  /// تاريخ الإنشاء
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  /// تاريخ آخر تحديث
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'UserCourseProgress(userId: $userId, courseId: $courseId, totalPoints: $totalPoints, currentLevel: $currentLevel, pointsToNextLevel: $pointsToNextLevel, activityCounts: $activityCounts, earnedBadges: $earnedBadges, lastActivityAt: $lastActivityAt, dailyStreakCount: $dailyStreakCount, longestStreak: $longestStreak, lastStreakCheckDate: $lastStreakCheckDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserCourseProgressImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel) &&
            (identical(other.pointsToNextLevel, pointsToNextLevel) ||
                other.pointsToNextLevel == pointsToNextLevel) &&
            const DeepCollectionEquality().equals(
              other._activityCounts,
              _activityCounts,
            ) &&
            const DeepCollectionEquality().equals(
              other._earnedBadges,
              _earnedBadges,
            ) &&
            (identical(other.lastActivityAt, lastActivityAt) ||
                other.lastActivityAt == lastActivityAt) &&
            (identical(other.dailyStreakCount, dailyStreakCount) ||
                other.dailyStreakCount == dailyStreakCount) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.lastStreakCheckDate, lastStreakCheckDate) ||
                other.lastStreakCheckDate == lastStreakCheckDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    courseId,
    totalPoints,
    currentLevel,
    pointsToNextLevel,
    const DeepCollectionEquality().hash(_activityCounts),
    const DeepCollectionEquality().hash(_earnedBadges),
    lastActivityAt,
    dailyStreakCount,
    longestStreak,
    lastStreakCheckDate,
    createdAt,
    updatedAt,
  );

  /// Create a copy of UserCourseProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserCourseProgressImplCopyWith<_$UserCourseProgressImpl> get copyWith =>
      __$$UserCourseProgressImplCopyWithImpl<_$UserCourseProgressImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserCourseProgressImplToJson(this);
  }
}

abstract class _UserCourseProgress implements UserCourseProgress {
  const factory _UserCourseProgress({
    required final String userId,
    required final String courseId,
    final int totalPoints,
    final int currentLevel,
    final int pointsToNextLevel,
    final Map<String, int> activityCounts,
    final List<String> earnedBadges,
    @TimestampConverter() required final DateTime lastActivityAt,
    final int dailyStreakCount,
    final int longestStreak,
    @TimestampConverter() final DateTime? lastStreakCheckDate,
    @TimestampConverter() final DateTime? createdAt,
    @TimestampConverter() final DateTime? updatedAt,
  }) = _$UserCourseProgressImpl;

  factory _UserCourseProgress.fromJson(Map<String, dynamic> json) =
      _$UserCourseProgressImpl.fromJson;

  /// معرف المستخدم
  @override
  String get userId;

  /// معرف الكورس
  @override
  String get courseId;

  /// إجمالي النقاط المكتسبة
  @override
  int get totalPoints;

  /// المستوى الحالي
  @override
  int get currentLevel;

  /// النقاط المتبقية للمستوى التالي
  @override
  int get pointsToNextLevel;

  /// عدد كل نشاط (activity_type -> count)
  /// مثال: {'completing_lesson': 5, 'passing_quiz': 3}
  @override
  Map<String, int> get activityCounts;

  /// الشارات المكتسبة
  @override
  List<String> get earnedBadges;

  /// آخر نشاط
  @override
  @TimestampConverter()
  DateTime get lastActivityAt;

  /// عدد أيام الدخول المتواصل
  @override
  int get dailyStreakCount;

  /// أطول سلسلة دخول متواصلة
  @override
  int get longestStreak;

  /// تاريخ آخر دخول (لحساب الـ streak)
  @override
  @TimestampConverter()
  DateTime? get lastStreakCheckDate;

  /// تاريخ الإنشاء
  @override
  @TimestampConverter()
  DateTime? get createdAt;

  /// تاريخ آخر تحديث
  @override
  @TimestampConverter()
  DateTime? get updatedAt;

  /// Create a copy of UserCourseProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserCourseProgressImplCopyWith<_$UserCourseProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgressStats _$ProgressStatsFromJson(Map<String, dynamic> json) {
  return _ProgressStats.fromJson(json);
}

/// @nodoc
mixin _$ProgressStats {
  /// عدد الدروس المكتملة
  int get totalLessonsCompleted => throw _privateConstructorUsedError;

  /// عدد الاختبارات المجتازة
  int get totalQuizzesPassed => throw _privateConstructorUsedError;

  /// عدد الاختبارات بدرجة كاملة
  int get perfectQuizzes => throw _privateConstructorUsedError;

  /// عدد المهام المكتملة
  int get totalAssignmentsCompleted => throw _privateConstructorUsedError;

  /// عدد الوحدات المكتملة
  int get totalModulesCompleted => throw _privateConstructorUsedError;

  /// عدد المنشورات
  int get totalPosts => throw _privateConstructorUsedError;

  /// عدد التعليقات
  int get totalComments => throw _privateConstructorUsedError;

  /// عدد التعليقات المفيدة
  int get helpfulCommentsCount => throw _privateConstructorUsedError;

  /// متوسط درجات الاختبارات
  double get averageQuizScore => throw _privateConstructorUsedError;

  /// أطول سلسلة دخول
  int get longestStreak => throw _privateConstructorUsedError;

  /// إجمالي وقت التعلم (بالدقائق)
  int get totalLearningMinutes => throw _privateConstructorUsedError;

  /// Serializes this ProgressStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgressStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgressStatsCopyWith<ProgressStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressStatsCopyWith<$Res> {
  factory $ProgressStatsCopyWith(
    ProgressStats value,
    $Res Function(ProgressStats) then,
  ) = _$ProgressStatsCopyWithImpl<$Res, ProgressStats>;
  @useResult
  $Res call({
    int totalLessonsCompleted,
    int totalQuizzesPassed,
    int perfectQuizzes,
    int totalAssignmentsCompleted,
    int totalModulesCompleted,
    int totalPosts,
    int totalComments,
    int helpfulCommentsCount,
    double averageQuizScore,
    int longestStreak,
    int totalLearningMinutes,
  });
}

/// @nodoc
class _$ProgressStatsCopyWithImpl<$Res, $Val extends ProgressStats>
    implements $ProgressStatsCopyWith<$Res> {
  _$ProgressStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgressStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalLessonsCompleted = null,
    Object? totalQuizzesPassed = null,
    Object? perfectQuizzes = null,
    Object? totalAssignmentsCompleted = null,
    Object? totalModulesCompleted = null,
    Object? totalPosts = null,
    Object? totalComments = null,
    Object? helpfulCommentsCount = null,
    Object? averageQuizScore = null,
    Object? longestStreak = null,
    Object? totalLearningMinutes = null,
  }) {
    return _then(
      _value.copyWith(
            totalLessonsCompleted: null == totalLessonsCompleted
                ? _value.totalLessonsCompleted
                : totalLessonsCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            totalQuizzesPassed: null == totalQuizzesPassed
                ? _value.totalQuizzesPassed
                : totalQuizzesPassed // ignore: cast_nullable_to_non_nullable
                      as int,
            perfectQuizzes: null == perfectQuizzes
                ? _value.perfectQuizzes
                : perfectQuizzes // ignore: cast_nullable_to_non_nullable
                      as int,
            totalAssignmentsCompleted: null == totalAssignmentsCompleted
                ? _value.totalAssignmentsCompleted
                : totalAssignmentsCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            totalModulesCompleted: null == totalModulesCompleted
                ? _value.totalModulesCompleted
                : totalModulesCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPosts: null == totalPosts
                ? _value.totalPosts
                : totalPosts // ignore: cast_nullable_to_non_nullable
                      as int,
            totalComments: null == totalComments
                ? _value.totalComments
                : totalComments // ignore: cast_nullable_to_non_nullable
                      as int,
            helpfulCommentsCount: null == helpfulCommentsCount
                ? _value.helpfulCommentsCount
                : helpfulCommentsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            averageQuizScore: null == averageQuizScore
                ? _value.averageQuizScore
                : averageQuizScore // ignore: cast_nullable_to_non_nullable
                      as double,
            longestStreak: null == longestStreak
                ? _value.longestStreak
                : longestStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            totalLearningMinutes: null == totalLearningMinutes
                ? _value.totalLearningMinutes
                : totalLearningMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProgressStatsImplCopyWith<$Res>
    implements $ProgressStatsCopyWith<$Res> {
  factory _$$ProgressStatsImplCopyWith(
    _$ProgressStatsImpl value,
    $Res Function(_$ProgressStatsImpl) then,
  ) = __$$ProgressStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalLessonsCompleted,
    int totalQuizzesPassed,
    int perfectQuizzes,
    int totalAssignmentsCompleted,
    int totalModulesCompleted,
    int totalPosts,
    int totalComments,
    int helpfulCommentsCount,
    double averageQuizScore,
    int longestStreak,
    int totalLearningMinutes,
  });
}

/// @nodoc
class __$$ProgressStatsImplCopyWithImpl<$Res>
    extends _$ProgressStatsCopyWithImpl<$Res, _$ProgressStatsImpl>
    implements _$$ProgressStatsImplCopyWith<$Res> {
  __$$ProgressStatsImplCopyWithImpl(
    _$ProgressStatsImpl _value,
    $Res Function(_$ProgressStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProgressStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalLessonsCompleted = null,
    Object? totalQuizzesPassed = null,
    Object? perfectQuizzes = null,
    Object? totalAssignmentsCompleted = null,
    Object? totalModulesCompleted = null,
    Object? totalPosts = null,
    Object? totalComments = null,
    Object? helpfulCommentsCount = null,
    Object? averageQuizScore = null,
    Object? longestStreak = null,
    Object? totalLearningMinutes = null,
  }) {
    return _then(
      _$ProgressStatsImpl(
        totalLessonsCompleted: null == totalLessonsCompleted
            ? _value.totalLessonsCompleted
            : totalLessonsCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        totalQuizzesPassed: null == totalQuizzesPassed
            ? _value.totalQuizzesPassed
            : totalQuizzesPassed // ignore: cast_nullable_to_non_nullable
                  as int,
        perfectQuizzes: null == perfectQuizzes
            ? _value.perfectQuizzes
            : perfectQuizzes // ignore: cast_nullable_to_non_nullable
                  as int,
        totalAssignmentsCompleted: null == totalAssignmentsCompleted
            ? _value.totalAssignmentsCompleted
            : totalAssignmentsCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        totalModulesCompleted: null == totalModulesCompleted
            ? _value.totalModulesCompleted
            : totalModulesCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPosts: null == totalPosts
            ? _value.totalPosts
            : totalPosts // ignore: cast_nullable_to_non_nullable
                  as int,
        totalComments: null == totalComments
            ? _value.totalComments
            : totalComments // ignore: cast_nullable_to_non_nullable
                  as int,
        helpfulCommentsCount: null == helpfulCommentsCount
            ? _value.helpfulCommentsCount
            : helpfulCommentsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        averageQuizScore: null == averageQuizScore
            ? _value.averageQuizScore
            : averageQuizScore // ignore: cast_nullable_to_non_nullable
                  as double,
        longestStreak: null == longestStreak
            ? _value.longestStreak
            : longestStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        totalLearningMinutes: null == totalLearningMinutes
            ? _value.totalLearningMinutes
            : totalLearningMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgressStatsImpl implements _ProgressStats {
  const _$ProgressStatsImpl({
    this.totalLessonsCompleted = 0,
    this.totalQuizzesPassed = 0,
    this.perfectQuizzes = 0,
    this.totalAssignmentsCompleted = 0,
    this.totalModulesCompleted = 0,
    this.totalPosts = 0,
    this.totalComments = 0,
    this.helpfulCommentsCount = 0,
    this.averageQuizScore = 0.0,
    this.longestStreak = 0,
    this.totalLearningMinutes = 0,
  });

  factory _$ProgressStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgressStatsImplFromJson(json);

  /// عدد الدروس المكتملة
  @override
  @JsonKey()
  final int totalLessonsCompleted;

  /// عدد الاختبارات المجتازة
  @override
  @JsonKey()
  final int totalQuizzesPassed;

  /// عدد الاختبارات بدرجة كاملة
  @override
  @JsonKey()
  final int perfectQuizzes;

  /// عدد المهام المكتملة
  @override
  @JsonKey()
  final int totalAssignmentsCompleted;

  /// عدد الوحدات المكتملة
  @override
  @JsonKey()
  final int totalModulesCompleted;

  /// عدد المنشورات
  @override
  @JsonKey()
  final int totalPosts;

  /// عدد التعليقات
  @override
  @JsonKey()
  final int totalComments;

  /// عدد التعليقات المفيدة
  @override
  @JsonKey()
  final int helpfulCommentsCount;

  /// متوسط درجات الاختبارات
  @override
  @JsonKey()
  final double averageQuizScore;

  /// أطول سلسلة دخول
  @override
  @JsonKey()
  final int longestStreak;

  /// إجمالي وقت التعلم (بالدقائق)
  @override
  @JsonKey()
  final int totalLearningMinutes;

  @override
  String toString() {
    return 'ProgressStats(totalLessonsCompleted: $totalLessonsCompleted, totalQuizzesPassed: $totalQuizzesPassed, perfectQuizzes: $perfectQuizzes, totalAssignmentsCompleted: $totalAssignmentsCompleted, totalModulesCompleted: $totalModulesCompleted, totalPosts: $totalPosts, totalComments: $totalComments, helpfulCommentsCount: $helpfulCommentsCount, averageQuizScore: $averageQuizScore, longestStreak: $longestStreak, totalLearningMinutes: $totalLearningMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressStatsImpl &&
            (identical(other.totalLessonsCompleted, totalLessonsCompleted) ||
                other.totalLessonsCompleted == totalLessonsCompleted) &&
            (identical(other.totalQuizzesPassed, totalQuizzesPassed) ||
                other.totalQuizzesPassed == totalQuizzesPassed) &&
            (identical(other.perfectQuizzes, perfectQuizzes) ||
                other.perfectQuizzes == perfectQuizzes) &&
            (identical(
                  other.totalAssignmentsCompleted,
                  totalAssignmentsCompleted,
                ) ||
                other.totalAssignmentsCompleted == totalAssignmentsCompleted) &&
            (identical(other.totalModulesCompleted, totalModulesCompleted) ||
                other.totalModulesCompleted == totalModulesCompleted) &&
            (identical(other.totalPosts, totalPosts) ||
                other.totalPosts == totalPosts) &&
            (identical(other.totalComments, totalComments) ||
                other.totalComments == totalComments) &&
            (identical(other.helpfulCommentsCount, helpfulCommentsCount) ||
                other.helpfulCommentsCount == helpfulCommentsCount) &&
            (identical(other.averageQuizScore, averageQuizScore) ||
                other.averageQuizScore == averageQuizScore) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.totalLearningMinutes, totalLearningMinutes) ||
                other.totalLearningMinutes == totalLearningMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalLessonsCompleted,
    totalQuizzesPassed,
    perfectQuizzes,
    totalAssignmentsCompleted,
    totalModulesCompleted,
    totalPosts,
    totalComments,
    helpfulCommentsCount,
    averageQuizScore,
    longestStreak,
    totalLearningMinutes,
  );

  /// Create a copy of ProgressStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressStatsImplCopyWith<_$ProgressStatsImpl> get copyWith =>
      __$$ProgressStatsImplCopyWithImpl<_$ProgressStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgressStatsImplToJson(this);
  }
}

abstract class _ProgressStats implements ProgressStats {
  const factory _ProgressStats({
    final int totalLessonsCompleted,
    final int totalQuizzesPassed,
    final int perfectQuizzes,
    final int totalAssignmentsCompleted,
    final int totalModulesCompleted,
    final int totalPosts,
    final int totalComments,
    final int helpfulCommentsCount,
    final double averageQuizScore,
    final int longestStreak,
    final int totalLearningMinutes,
  }) = _$ProgressStatsImpl;

  factory _ProgressStats.fromJson(Map<String, dynamic> json) =
      _$ProgressStatsImpl.fromJson;

  /// عدد الدروس المكتملة
  @override
  int get totalLessonsCompleted;

  /// عدد الاختبارات المجتازة
  @override
  int get totalQuizzesPassed;

  /// عدد الاختبارات بدرجة كاملة
  @override
  int get perfectQuizzes;

  /// عدد المهام المكتملة
  @override
  int get totalAssignmentsCompleted;

  /// عدد الوحدات المكتملة
  @override
  int get totalModulesCompleted;

  /// عدد المنشورات
  @override
  int get totalPosts;

  /// عدد التعليقات
  @override
  int get totalComments;

  /// عدد التعليقات المفيدة
  @override
  int get helpfulCommentsCount;

  /// متوسط درجات الاختبارات
  @override
  double get averageQuizScore;

  /// أطول سلسلة دخول
  @override
  int get longestStreak;

  /// إجمالي وقت التعلم (بالدقائق)
  @override
  int get totalLearningMinutes;

  /// Create a copy of ProgressStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgressStatsImplCopyWith<_$ProgressStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
