// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_analytics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CourseAnalytics _$CourseAnalyticsFromJson(Map<String, dynamic> json) {
  return _CourseAnalytics.fromJson(json);
}

/// @nodoc
mixin _$CourseAnalytics {
  /// معرف الكورس
  String get courseId => throw _privateConstructorUsedError;

  /// إجمالي عدد الطلاب
  int get totalStudents => throw _privateConstructorUsedError;

  /// الطلاب النشطون (آخر 7 أيام)
  int get activeStudents => throw _privateConstructorUsedError;

  /// متوسط النقاط
  double get avgPoints => throw _privateConstructorUsedError;

  /// متوسط المستوى
  double get avgLevel => throw _privateConstructorUsedError;

  /// توزيع الأنشطة (Activity Breakdown)
  /// مثال: {"modules": 45, "quizzes": 30, "social": 25}
  Map<String, int> get activityBreakdown => throw _privateConstructorUsedError;

  /// أفضل الطلاب (Top 5)
  List<TopStudent> get topStudents => throw _privateConstructorUsedError;

  /// معدل التفاعل (Engagement Rate)
  /// مثال: {"daily": 0.75, "weekly": 0.90}
  Map<String, double> get engagementRate => throw _privateConstructorUsedError;

  /// إجمالي النقاط الممنوحة
  int get totalPointsAwarded => throw _privateConstructorUsedError;

  /// إجمالي الإنجازات المفتوحة
  int get totalAchievementsUnlocked => throw _privateConstructorUsedError;

  /// آخر تحديث
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this CourseAnalytics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseAnalyticsCopyWith<CourseAnalytics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseAnalyticsCopyWith<$Res> {
  factory $CourseAnalyticsCopyWith(
    CourseAnalytics value,
    $Res Function(CourseAnalytics) then,
  ) = _$CourseAnalyticsCopyWithImpl<$Res, CourseAnalytics>;
  @useResult
  $Res call({
    String courseId,
    int totalStudents,
    int activeStudents,
    double avgPoints,
    double avgLevel,
    Map<String, int> activityBreakdown,
    List<TopStudent> topStudents,
    Map<String, double> engagementRate,
    int totalPointsAwarded,
    int totalAchievementsUnlocked,
    DateTime? lastUpdated,
  });
}

/// @nodoc
class _$CourseAnalyticsCopyWithImpl<$Res, $Val extends CourseAnalytics>
    implements $CourseAnalyticsCopyWith<$Res> {
  _$CourseAnalyticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? totalStudents = null,
    Object? activeStudents = null,
    Object? avgPoints = null,
    Object? avgLevel = null,
    Object? activityBreakdown = null,
    Object? topStudents = null,
    Object? engagementRate = null,
    Object? totalPointsAwarded = null,
    Object? totalAchievementsUnlocked = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _value.copyWith(
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            totalStudents: null == totalStudents
                ? _value.totalStudents
                : totalStudents // ignore: cast_nullable_to_non_nullable
                      as int,
            activeStudents: null == activeStudents
                ? _value.activeStudents
                : activeStudents // ignore: cast_nullable_to_non_nullable
                      as int,
            avgPoints: null == avgPoints
                ? _value.avgPoints
                : avgPoints // ignore: cast_nullable_to_non_nullable
                      as double,
            avgLevel: null == avgLevel
                ? _value.avgLevel
                : avgLevel // ignore: cast_nullable_to_non_nullable
                      as double,
            activityBreakdown: null == activityBreakdown
                ? _value.activityBreakdown
                : activityBreakdown // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            topStudents: null == topStudents
                ? _value.topStudents
                : topStudents // ignore: cast_nullable_to_non_nullable
                      as List<TopStudent>,
            engagementRate: null == engagementRate
                ? _value.engagementRate
                : engagementRate // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>,
            totalPointsAwarded: null == totalPointsAwarded
                ? _value.totalPointsAwarded
                : totalPointsAwarded // ignore: cast_nullable_to_non_nullable
                      as int,
            totalAchievementsUnlocked: null == totalAchievementsUnlocked
                ? _value.totalAchievementsUnlocked
                : totalAchievementsUnlocked // ignore: cast_nullable_to_non_nullable
                      as int,
            lastUpdated: freezed == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CourseAnalyticsImplCopyWith<$Res>
    implements $CourseAnalyticsCopyWith<$Res> {
  factory _$$CourseAnalyticsImplCopyWith(
    _$CourseAnalyticsImpl value,
    $Res Function(_$CourseAnalyticsImpl) then,
  ) = __$$CourseAnalyticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String courseId,
    int totalStudents,
    int activeStudents,
    double avgPoints,
    double avgLevel,
    Map<String, int> activityBreakdown,
    List<TopStudent> topStudents,
    Map<String, double> engagementRate,
    int totalPointsAwarded,
    int totalAchievementsUnlocked,
    DateTime? lastUpdated,
  });
}

/// @nodoc
class __$$CourseAnalyticsImplCopyWithImpl<$Res>
    extends _$CourseAnalyticsCopyWithImpl<$Res, _$CourseAnalyticsImpl>
    implements _$$CourseAnalyticsImplCopyWith<$Res> {
  __$$CourseAnalyticsImplCopyWithImpl(
    _$CourseAnalyticsImpl _value,
    $Res Function(_$CourseAnalyticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? totalStudents = null,
    Object? activeStudents = null,
    Object? avgPoints = null,
    Object? avgLevel = null,
    Object? activityBreakdown = null,
    Object? topStudents = null,
    Object? engagementRate = null,
    Object? totalPointsAwarded = null,
    Object? totalAchievementsUnlocked = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _$CourseAnalyticsImpl(
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        totalStudents: null == totalStudents
            ? _value.totalStudents
            : totalStudents // ignore: cast_nullable_to_non_nullable
                  as int,
        activeStudents: null == activeStudents
            ? _value.activeStudents
            : activeStudents // ignore: cast_nullable_to_non_nullable
                  as int,
        avgPoints: null == avgPoints
            ? _value.avgPoints
            : avgPoints // ignore: cast_nullable_to_non_nullable
                  as double,
        avgLevel: null == avgLevel
            ? _value.avgLevel
            : avgLevel // ignore: cast_nullable_to_non_nullable
                  as double,
        activityBreakdown: null == activityBreakdown
            ? _value._activityBreakdown
            : activityBreakdown // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        topStudents: null == topStudents
            ? _value._topStudents
            : topStudents // ignore: cast_nullable_to_non_nullable
                  as List<TopStudent>,
        engagementRate: null == engagementRate
            ? _value._engagementRate
            : engagementRate // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        totalPointsAwarded: null == totalPointsAwarded
            ? _value.totalPointsAwarded
            : totalPointsAwarded // ignore: cast_nullable_to_non_nullable
                  as int,
        totalAchievementsUnlocked: null == totalAchievementsUnlocked
            ? _value.totalAchievementsUnlocked
            : totalAchievementsUnlocked // ignore: cast_nullable_to_non_nullable
                  as int,
        lastUpdated: freezed == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseAnalyticsImpl implements _CourseAnalytics {
  const _$CourseAnalyticsImpl({
    required this.courseId,
    required this.totalStudents,
    required this.activeStudents,
    required this.avgPoints,
    required this.avgLevel,
    required final Map<String, int> activityBreakdown,
    required final List<TopStudent> topStudents,
    required final Map<String, double> engagementRate,
    this.totalPointsAwarded = 0,
    this.totalAchievementsUnlocked = 0,
    this.lastUpdated,
  }) : _activityBreakdown = activityBreakdown,
       _topStudents = topStudents,
       _engagementRate = engagementRate;

  factory _$CourseAnalyticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseAnalyticsImplFromJson(json);

  /// معرف الكورس
  @override
  final String courseId;

  /// إجمالي عدد الطلاب
  @override
  final int totalStudents;

  /// الطلاب النشطون (آخر 7 أيام)
  @override
  final int activeStudents;

  /// متوسط النقاط
  @override
  final double avgPoints;

  /// متوسط المستوى
  @override
  final double avgLevel;

  /// توزيع الأنشطة (Activity Breakdown)
  /// مثال: {"modules": 45, "quizzes": 30, "social": 25}
  final Map<String, int> _activityBreakdown;

  /// توزيع الأنشطة (Activity Breakdown)
  /// مثال: {"modules": 45, "quizzes": 30, "social": 25}
  @override
  Map<String, int> get activityBreakdown {
    if (_activityBreakdown is EqualUnmodifiableMapView)
      return _activityBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_activityBreakdown);
  }

  /// أفضل الطلاب (Top 5)
  final List<TopStudent> _topStudents;

  /// أفضل الطلاب (Top 5)
  @override
  List<TopStudent> get topStudents {
    if (_topStudents is EqualUnmodifiableListView) return _topStudents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topStudents);
  }

  /// معدل التفاعل (Engagement Rate)
  /// مثال: {"daily": 0.75, "weekly": 0.90}
  final Map<String, double> _engagementRate;

  /// معدل التفاعل (Engagement Rate)
  /// مثال: {"daily": 0.75, "weekly": 0.90}
  @override
  Map<String, double> get engagementRate {
    if (_engagementRate is EqualUnmodifiableMapView) return _engagementRate;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_engagementRate);
  }

  /// إجمالي النقاط الممنوحة
  @override
  @JsonKey()
  final int totalPointsAwarded;

  /// إجمالي الإنجازات المفتوحة
  @override
  @JsonKey()
  final int totalAchievementsUnlocked;

  /// آخر تحديث
  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'CourseAnalytics(courseId: $courseId, totalStudents: $totalStudents, activeStudents: $activeStudents, avgPoints: $avgPoints, avgLevel: $avgLevel, activityBreakdown: $activityBreakdown, topStudents: $topStudents, engagementRate: $engagementRate, totalPointsAwarded: $totalPointsAwarded, totalAchievementsUnlocked: $totalAchievementsUnlocked, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseAnalyticsImpl &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.totalStudents, totalStudents) ||
                other.totalStudents == totalStudents) &&
            (identical(other.activeStudents, activeStudents) ||
                other.activeStudents == activeStudents) &&
            (identical(other.avgPoints, avgPoints) ||
                other.avgPoints == avgPoints) &&
            (identical(other.avgLevel, avgLevel) ||
                other.avgLevel == avgLevel) &&
            const DeepCollectionEquality().equals(
              other._activityBreakdown,
              _activityBreakdown,
            ) &&
            const DeepCollectionEquality().equals(
              other._topStudents,
              _topStudents,
            ) &&
            const DeepCollectionEquality().equals(
              other._engagementRate,
              _engagementRate,
            ) &&
            (identical(other.totalPointsAwarded, totalPointsAwarded) ||
                other.totalPointsAwarded == totalPointsAwarded) &&
            (identical(
                  other.totalAchievementsUnlocked,
                  totalAchievementsUnlocked,
                ) ||
                other.totalAchievementsUnlocked == totalAchievementsUnlocked) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    courseId,
    totalStudents,
    activeStudents,
    avgPoints,
    avgLevel,
    const DeepCollectionEquality().hash(_activityBreakdown),
    const DeepCollectionEquality().hash(_topStudents),
    const DeepCollectionEquality().hash(_engagementRate),
    totalPointsAwarded,
    totalAchievementsUnlocked,
    lastUpdated,
  );

  /// Create a copy of CourseAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseAnalyticsImplCopyWith<_$CourseAnalyticsImpl> get copyWith =>
      __$$CourseAnalyticsImplCopyWithImpl<_$CourseAnalyticsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseAnalyticsImplToJson(this);
  }
}

abstract class _CourseAnalytics implements CourseAnalytics {
  const factory _CourseAnalytics({
    required final String courseId,
    required final int totalStudents,
    required final int activeStudents,
    required final double avgPoints,
    required final double avgLevel,
    required final Map<String, int> activityBreakdown,
    required final List<TopStudent> topStudents,
    required final Map<String, double> engagementRate,
    final int totalPointsAwarded,
    final int totalAchievementsUnlocked,
    final DateTime? lastUpdated,
  }) = _$CourseAnalyticsImpl;

  factory _CourseAnalytics.fromJson(Map<String, dynamic> json) =
      _$CourseAnalyticsImpl.fromJson;

  /// معرف الكورس
  @override
  String get courseId;

  /// إجمالي عدد الطلاب
  @override
  int get totalStudents;

  /// الطلاب النشطون (آخر 7 أيام)
  @override
  int get activeStudents;

  /// متوسط النقاط
  @override
  double get avgPoints;

  /// متوسط المستوى
  @override
  double get avgLevel;

  /// توزيع الأنشطة (Activity Breakdown)
  /// مثال: {"modules": 45, "quizzes": 30, "social": 25}
  @override
  Map<String, int> get activityBreakdown;

  /// أفضل الطلاب (Top 5)
  @override
  List<TopStudent> get topStudents;

  /// معدل التفاعل (Engagement Rate)
  /// مثال: {"daily": 0.75, "weekly": 0.90}
  @override
  Map<String, double> get engagementRate;

  /// إجمالي النقاط الممنوحة
  @override
  int get totalPointsAwarded;

  /// إجمالي الإنجازات المفتوحة
  @override
  int get totalAchievementsUnlocked;

  /// آخر تحديث
  @override
  DateTime? get lastUpdated;

  /// Create a copy of CourseAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseAnalyticsImplCopyWith<_$CourseAnalyticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopStudent _$TopStudentFromJson(Map<String, dynamic> json) {
  return _TopStudent.fromJson(json);
}

/// @nodoc
mixin _$TopStudent {
  /// معرف المستخدم
  String get userId => throw _privateConstructorUsedError;

  /// اسم المستخدم
  String get userName => throw _privateConstructorUsedError;

  /// النقاط
  int get points => throw _privateConstructorUsedError;

  /// المستوى
  int get level => throw _privateConstructorUsedError;

  /// صورة المستخدم (اختياري)
  String? get userAvatar => throw _privateConstructorUsedError;

  /// الترتيب
  int get rank => throw _privateConstructorUsedError;

  /// Serializes this TopStudent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopStudent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopStudentCopyWith<TopStudent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopStudentCopyWith<$Res> {
  factory $TopStudentCopyWith(
    TopStudent value,
    $Res Function(TopStudent) then,
  ) = _$TopStudentCopyWithImpl<$Res, TopStudent>;
  @useResult
  $Res call({
    String userId,
    String userName,
    int points,
    int level,
    String? userAvatar,
    int rank,
  });
}

/// @nodoc
class _$TopStudentCopyWithImpl<$Res, $Val extends TopStudent>
    implements $TopStudentCopyWith<$Res> {
  _$TopStudentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopStudent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? points = null,
    Object? level = null,
    Object? userAvatar = freezed,
    Object? rank = null,
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
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            userAvatar: freezed == userAvatar
                ? _value.userAvatar
                : userAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TopStudentImplCopyWith<$Res>
    implements $TopStudentCopyWith<$Res> {
  factory _$$TopStudentImplCopyWith(
    _$TopStudentImpl value,
    $Res Function(_$TopStudentImpl) then,
  ) = __$$TopStudentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String userName,
    int points,
    int level,
    String? userAvatar,
    int rank,
  });
}

/// @nodoc
class __$$TopStudentImplCopyWithImpl<$Res>
    extends _$TopStudentCopyWithImpl<$Res, _$TopStudentImpl>
    implements _$$TopStudentImplCopyWith<$Res> {
  __$$TopStudentImplCopyWithImpl(
    _$TopStudentImpl _value,
    $Res Function(_$TopStudentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TopStudent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? points = null,
    Object? level = null,
    Object? userAvatar = freezed,
    Object? rank = null,
  }) {
    return _then(
      _$TopStudentImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        userAvatar: freezed == userAvatar
            ? _value.userAvatar
            : userAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TopStudentImpl implements _TopStudent {
  const _$TopStudentImpl({
    required this.userId,
    required this.userName,
    required this.points,
    required this.level,
    this.userAvatar,
    this.rank = 1,
  });

  factory _$TopStudentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopStudentImplFromJson(json);

  /// معرف المستخدم
  @override
  final String userId;

  /// اسم المستخدم
  @override
  final String userName;

  /// النقاط
  @override
  final int points;

  /// المستوى
  @override
  final int level;

  /// صورة المستخدم (اختياري)
  @override
  final String? userAvatar;

  /// الترتيب
  @override
  @JsonKey()
  final int rank;

  @override
  String toString() {
    return 'TopStudent(userId: $userId, userName: $userName, points: $points, level: $level, userAvatar: $userAvatar, rank: $rank)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopStudentImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.userAvatar, userAvatar) ||
                other.userAvatar == userAvatar) &&
            (identical(other.rank, rank) || other.rank == rank));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    userName,
    points,
    level,
    userAvatar,
    rank,
  );

  /// Create a copy of TopStudent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopStudentImplCopyWith<_$TopStudentImpl> get copyWith =>
      __$$TopStudentImplCopyWithImpl<_$TopStudentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopStudentImplToJson(this);
  }
}

abstract class _TopStudent implements TopStudent {
  const factory _TopStudent({
    required final String userId,
    required final String userName,
    required final int points,
    required final int level,
    final String? userAvatar,
    final int rank,
  }) = _$TopStudentImpl;

  factory _TopStudent.fromJson(Map<String, dynamic> json) =
      _$TopStudentImpl.fromJson;

  /// معرف المستخدم
  @override
  String get userId;

  /// اسم المستخدم
  @override
  String get userName;

  /// النقاط
  @override
  int get points;

  /// المستوى
  @override
  int get level;

  /// صورة المستخدم (اختياري)
  @override
  String? get userAvatar;

  /// الترتيب
  @override
  int get rank;

  /// Create a copy of TopStudent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopStudentImplCopyWith<_$TopStudentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActivityStats _$ActivityStatsFromJson(Map<String, dynamic> json) {
  return _ActivityStats.fromJson(json);
}

/// @nodoc
mixin _$ActivityStats {
  /// نوع النشاط
  String get activityType => throw _privateConstructorUsedError;

  /// العدد
  int get count => throw _privateConstructorUsedError;

  /// النسبة المئوية
  double get percentage => throw _privateConstructorUsedError;

  /// إجمالي النقاط من هذا النشاط
  int get totalPoints => throw _privateConstructorUsedError;

  /// Serializes this ActivityStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityStatsCopyWith<ActivityStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityStatsCopyWith<$Res> {
  factory $ActivityStatsCopyWith(
    ActivityStats value,
    $Res Function(ActivityStats) then,
  ) = _$ActivityStatsCopyWithImpl<$Res, ActivityStats>;
  @useResult
  $Res call({
    String activityType,
    int count,
    double percentage,
    int totalPoints,
  });
}

/// @nodoc
class _$ActivityStatsCopyWithImpl<$Res, $Val extends ActivityStats>
    implements $ActivityStatsCopyWith<$Res> {
  _$ActivityStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityType = null,
    Object? count = null,
    Object? percentage = null,
    Object? totalPoints = null,
  }) {
    return _then(
      _value.copyWith(
            activityType: null == activityType
                ? _value.activityType
                : activityType // ignore: cast_nullable_to_non_nullable
                      as String,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            percentage: null == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double,
            totalPoints: null == totalPoints
                ? _value.totalPoints
                : totalPoints // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActivityStatsImplCopyWith<$Res>
    implements $ActivityStatsCopyWith<$Res> {
  factory _$$ActivityStatsImplCopyWith(
    _$ActivityStatsImpl value,
    $Res Function(_$ActivityStatsImpl) then,
  ) = __$$ActivityStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String activityType,
    int count,
    double percentage,
    int totalPoints,
  });
}

/// @nodoc
class __$$ActivityStatsImplCopyWithImpl<$Res>
    extends _$ActivityStatsCopyWithImpl<$Res, _$ActivityStatsImpl>
    implements _$$ActivityStatsImplCopyWith<$Res> {
  __$$ActivityStatsImplCopyWithImpl(
    _$ActivityStatsImpl _value,
    $Res Function(_$ActivityStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivityStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityType = null,
    Object? count = null,
    Object? percentage = null,
    Object? totalPoints = null,
  }) {
    return _then(
      _$ActivityStatsImpl(
        activityType: null == activityType
            ? _value.activityType
            : activityType // ignore: cast_nullable_to_non_nullable
                  as String,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        percentage: null == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double,
        totalPoints: null == totalPoints
            ? _value.totalPoints
            : totalPoints // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityStatsImpl implements _ActivityStats {
  const _$ActivityStatsImpl({
    required this.activityType,
    required this.count,
    required this.percentage,
    this.totalPoints = 0,
  });

  factory _$ActivityStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityStatsImplFromJson(json);

  /// نوع النشاط
  @override
  final String activityType;

  /// العدد
  @override
  final int count;

  /// النسبة المئوية
  @override
  final double percentage;

  /// إجمالي النقاط من هذا النشاط
  @override
  @JsonKey()
  final int totalPoints;

  @override
  String toString() {
    return 'ActivityStats(activityType: $activityType, count: $count, percentage: $percentage, totalPoints: $totalPoints)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityStatsImpl &&
            (identical(other.activityType, activityType) ||
                other.activityType == activityType) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, activityType, count, percentage, totalPoints);

  /// Create a copy of ActivityStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityStatsImplCopyWith<_$ActivityStatsImpl> get copyWith =>
      __$$ActivityStatsImplCopyWithImpl<_$ActivityStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityStatsImplToJson(this);
  }
}

abstract class _ActivityStats implements ActivityStats {
  const factory _ActivityStats({
    required final String activityType,
    required final int count,
    required final double percentage,
    final int totalPoints,
  }) = _$ActivityStatsImpl;

  factory _ActivityStats.fromJson(Map<String, dynamic> json) =
      _$ActivityStatsImpl.fromJson;

  /// نوع النشاط
  @override
  String get activityType;

  /// العدد
  @override
  int get count;

  /// النسبة المئوية
  @override
  double get percentage;

  /// إجمالي النقاط من هذا النشاط
  @override
  int get totalPoints;

  /// Create a copy of ActivityStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityStatsImplCopyWith<_$ActivityStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
