// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_points.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ActivityPoints _$ActivityPointsFromJson(Map<String, dynamic> json) {
  return _ActivityPoints.fromJson(json);
}

/// @nodoc
mixin _$ActivityPoints {
  // ⭐ الأساسيات (Core) - إلزامية
  /// نقاط إتمام درس واحد
  int get completingLesson => throw _privateConstructorUsedError;

  /// نقاط اجتياز اختبار (70% أو أكثر)
  int get passingQuiz => throw _privateConstructorUsedError;

  /// نقاط الحصول على درجة كاملة في اختبار
  int get perfectQuizScore => throw _privateConstructorUsedError;

  /// نقاط إتمام مهمة/تكليف
  int get completingAssignment => throw _privateConstructorUsedError;

  /// نقاط إتمام وحدة تعليمية كاملة
  int get completingModule =>
      throw _privateConstructorUsedError; // 🎮 التفاعل الاجتماعي (Social) - اختياري
  /// نقاط إنشاء منشور في حائط الكورس
  int get creatingPost => throw _privateConstructorUsedError;

  /// نقاط التعليق على منشور
  int get commentingOnPost => throw _privateConstructorUsedError;

  /// نقاط مساعدة زميل (رد مفيد)
  int get helpingPeer => throw _privateConstructorUsedError;

  /// نقاط الحصول على reaction
  int get receivingReaction =>
      throw _privateConstructorUsedError; // 🔥 Daily Streak - اختياري
  /// نقاط الدخول اليومي المتواصل
  int get dailyStreak => throw _privateConstructorUsedError;

  /// مكافأة الأسبوع المتواصل (7 أيام)
  int get weeklyStreak => throw _privateConstructorUsedError; // ⚙️ الإعدادات
  /// تفعيل نقاط التفاعل الاجتماعي
  bool get enableSocialPoints => throw _privateConstructorUsedError;

  /// تفعيل نقاط الدخول اليومي
  bool get enableDailyStreak => throw _privateConstructorUsedError;

  /// Serializes this ActivityPoints to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityPoints
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityPointsCopyWith<ActivityPoints> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityPointsCopyWith<$Res> {
  factory $ActivityPointsCopyWith(
    ActivityPoints value,
    $Res Function(ActivityPoints) then,
  ) = _$ActivityPointsCopyWithImpl<$Res, ActivityPoints>;
  @useResult
  $Res call({
    int completingLesson,
    int passingQuiz,
    int perfectQuizScore,
    int completingAssignment,
    int completingModule,
    int creatingPost,
    int commentingOnPost,
    int helpingPeer,
    int receivingReaction,
    int dailyStreak,
    int weeklyStreak,
    bool enableSocialPoints,
    bool enableDailyStreak,
  });
}

/// @nodoc
class _$ActivityPointsCopyWithImpl<$Res, $Val extends ActivityPoints>
    implements $ActivityPointsCopyWith<$Res> {
  _$ActivityPointsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityPoints
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completingLesson = null,
    Object? passingQuiz = null,
    Object? perfectQuizScore = null,
    Object? completingAssignment = null,
    Object? completingModule = null,
    Object? creatingPost = null,
    Object? commentingOnPost = null,
    Object? helpingPeer = null,
    Object? receivingReaction = null,
    Object? dailyStreak = null,
    Object? weeklyStreak = null,
    Object? enableSocialPoints = null,
    Object? enableDailyStreak = null,
  }) {
    return _then(
      _value.copyWith(
            completingLesson: null == completingLesson
                ? _value.completingLesson
                : completingLesson // ignore: cast_nullable_to_non_nullable
                      as int,
            passingQuiz: null == passingQuiz
                ? _value.passingQuiz
                : passingQuiz // ignore: cast_nullable_to_non_nullable
                      as int,
            perfectQuizScore: null == perfectQuizScore
                ? _value.perfectQuizScore
                : perfectQuizScore // ignore: cast_nullable_to_non_nullable
                      as int,
            completingAssignment: null == completingAssignment
                ? _value.completingAssignment
                : completingAssignment // ignore: cast_nullable_to_non_nullable
                      as int,
            completingModule: null == completingModule
                ? _value.completingModule
                : completingModule // ignore: cast_nullable_to_non_nullable
                      as int,
            creatingPost: null == creatingPost
                ? _value.creatingPost
                : creatingPost // ignore: cast_nullable_to_non_nullable
                      as int,
            commentingOnPost: null == commentingOnPost
                ? _value.commentingOnPost
                : commentingOnPost // ignore: cast_nullable_to_non_nullable
                      as int,
            helpingPeer: null == helpingPeer
                ? _value.helpingPeer
                : helpingPeer // ignore: cast_nullable_to_non_nullable
                      as int,
            receivingReaction: null == receivingReaction
                ? _value.receivingReaction
                : receivingReaction // ignore: cast_nullable_to_non_nullable
                      as int,
            dailyStreak: null == dailyStreak
                ? _value.dailyStreak
                : dailyStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            weeklyStreak: null == weeklyStreak
                ? _value.weeklyStreak
                : weeklyStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            enableSocialPoints: null == enableSocialPoints
                ? _value.enableSocialPoints
                : enableSocialPoints // ignore: cast_nullable_to_non_nullable
                      as bool,
            enableDailyStreak: null == enableDailyStreak
                ? _value.enableDailyStreak
                : enableDailyStreak // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActivityPointsImplCopyWith<$Res>
    implements $ActivityPointsCopyWith<$Res> {
  factory _$$ActivityPointsImplCopyWith(
    _$ActivityPointsImpl value,
    $Res Function(_$ActivityPointsImpl) then,
  ) = __$$ActivityPointsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int completingLesson,
    int passingQuiz,
    int perfectQuizScore,
    int completingAssignment,
    int completingModule,
    int creatingPost,
    int commentingOnPost,
    int helpingPeer,
    int receivingReaction,
    int dailyStreak,
    int weeklyStreak,
    bool enableSocialPoints,
    bool enableDailyStreak,
  });
}

/// @nodoc
class __$$ActivityPointsImplCopyWithImpl<$Res>
    extends _$ActivityPointsCopyWithImpl<$Res, _$ActivityPointsImpl>
    implements _$$ActivityPointsImplCopyWith<$Res> {
  __$$ActivityPointsImplCopyWithImpl(
    _$ActivityPointsImpl _value,
    $Res Function(_$ActivityPointsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivityPoints
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completingLesson = null,
    Object? passingQuiz = null,
    Object? perfectQuizScore = null,
    Object? completingAssignment = null,
    Object? completingModule = null,
    Object? creatingPost = null,
    Object? commentingOnPost = null,
    Object? helpingPeer = null,
    Object? receivingReaction = null,
    Object? dailyStreak = null,
    Object? weeklyStreak = null,
    Object? enableSocialPoints = null,
    Object? enableDailyStreak = null,
  }) {
    return _then(
      _$ActivityPointsImpl(
        completingLesson: null == completingLesson
            ? _value.completingLesson
            : completingLesson // ignore: cast_nullable_to_non_nullable
                  as int,
        passingQuiz: null == passingQuiz
            ? _value.passingQuiz
            : passingQuiz // ignore: cast_nullable_to_non_nullable
                  as int,
        perfectQuizScore: null == perfectQuizScore
            ? _value.perfectQuizScore
            : perfectQuizScore // ignore: cast_nullable_to_non_nullable
                  as int,
        completingAssignment: null == completingAssignment
            ? _value.completingAssignment
            : completingAssignment // ignore: cast_nullable_to_non_nullable
                  as int,
        completingModule: null == completingModule
            ? _value.completingModule
            : completingModule // ignore: cast_nullable_to_non_nullable
                  as int,
        creatingPost: null == creatingPost
            ? _value.creatingPost
            : creatingPost // ignore: cast_nullable_to_non_nullable
                  as int,
        commentingOnPost: null == commentingOnPost
            ? _value.commentingOnPost
            : commentingOnPost // ignore: cast_nullable_to_non_nullable
                  as int,
        helpingPeer: null == helpingPeer
            ? _value.helpingPeer
            : helpingPeer // ignore: cast_nullable_to_non_nullable
                  as int,
        receivingReaction: null == receivingReaction
            ? _value.receivingReaction
            : receivingReaction // ignore: cast_nullable_to_non_nullable
                  as int,
        dailyStreak: null == dailyStreak
            ? _value.dailyStreak
            : dailyStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        weeklyStreak: null == weeklyStreak
            ? _value.weeklyStreak
            : weeklyStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        enableSocialPoints: null == enableSocialPoints
            ? _value.enableSocialPoints
            : enableSocialPoints // ignore: cast_nullable_to_non_nullable
                  as bool,
        enableDailyStreak: null == enableDailyStreak
            ? _value.enableDailyStreak
            : enableDailyStreak // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityPointsImpl implements _ActivityPoints {
  const _$ActivityPointsImpl({
    this.completingLesson = 10,
    this.passingQuiz = 20,
    this.perfectQuizScore = 50,
    this.completingAssignment = 30,
    this.completingModule = 100,
    this.creatingPost = 5,
    this.commentingOnPost = 2,
    this.helpingPeer = 15,
    this.receivingReaction = 1,
    this.dailyStreak = 5,
    this.weeklyStreak = 50,
    this.enableSocialPoints = false,
    this.enableDailyStreak = false,
  });

  factory _$ActivityPointsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityPointsImplFromJson(json);

  // ⭐ الأساسيات (Core) - إلزامية
  /// نقاط إتمام درس واحد
  @override
  @JsonKey()
  final int completingLesson;

  /// نقاط اجتياز اختبار (70% أو أكثر)
  @override
  @JsonKey()
  final int passingQuiz;

  /// نقاط الحصول على درجة كاملة في اختبار
  @override
  @JsonKey()
  final int perfectQuizScore;

  /// نقاط إتمام مهمة/تكليف
  @override
  @JsonKey()
  final int completingAssignment;

  /// نقاط إتمام وحدة تعليمية كاملة
  @override
  @JsonKey()
  final int completingModule;
  // 🎮 التفاعل الاجتماعي (Social) - اختياري
  /// نقاط إنشاء منشور في حائط الكورس
  @override
  @JsonKey()
  final int creatingPost;

  /// نقاط التعليق على منشور
  @override
  @JsonKey()
  final int commentingOnPost;

  /// نقاط مساعدة زميل (رد مفيد)
  @override
  @JsonKey()
  final int helpingPeer;

  /// نقاط الحصول على reaction
  @override
  @JsonKey()
  final int receivingReaction;
  // 🔥 Daily Streak - اختياري
  /// نقاط الدخول اليومي المتواصل
  @override
  @JsonKey()
  final int dailyStreak;

  /// مكافأة الأسبوع المتواصل (7 أيام)
  @override
  @JsonKey()
  final int weeklyStreak;
  // ⚙️ الإعدادات
  /// تفعيل نقاط التفاعل الاجتماعي
  @override
  @JsonKey()
  final bool enableSocialPoints;

  /// تفعيل نقاط الدخول اليومي
  @override
  @JsonKey()
  final bool enableDailyStreak;

  @override
  String toString() {
    return 'ActivityPoints(completingLesson: $completingLesson, passingQuiz: $passingQuiz, perfectQuizScore: $perfectQuizScore, completingAssignment: $completingAssignment, completingModule: $completingModule, creatingPost: $creatingPost, commentingOnPost: $commentingOnPost, helpingPeer: $helpingPeer, receivingReaction: $receivingReaction, dailyStreak: $dailyStreak, weeklyStreak: $weeklyStreak, enableSocialPoints: $enableSocialPoints, enableDailyStreak: $enableDailyStreak)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityPointsImpl &&
            (identical(other.completingLesson, completingLesson) ||
                other.completingLesson == completingLesson) &&
            (identical(other.passingQuiz, passingQuiz) ||
                other.passingQuiz == passingQuiz) &&
            (identical(other.perfectQuizScore, perfectQuizScore) ||
                other.perfectQuizScore == perfectQuizScore) &&
            (identical(other.completingAssignment, completingAssignment) ||
                other.completingAssignment == completingAssignment) &&
            (identical(other.completingModule, completingModule) ||
                other.completingModule == completingModule) &&
            (identical(other.creatingPost, creatingPost) ||
                other.creatingPost == creatingPost) &&
            (identical(other.commentingOnPost, commentingOnPost) ||
                other.commentingOnPost == commentingOnPost) &&
            (identical(other.helpingPeer, helpingPeer) ||
                other.helpingPeer == helpingPeer) &&
            (identical(other.receivingReaction, receivingReaction) ||
                other.receivingReaction == receivingReaction) &&
            (identical(other.dailyStreak, dailyStreak) ||
                other.dailyStreak == dailyStreak) &&
            (identical(other.weeklyStreak, weeklyStreak) ||
                other.weeklyStreak == weeklyStreak) &&
            (identical(other.enableSocialPoints, enableSocialPoints) ||
                other.enableSocialPoints == enableSocialPoints) &&
            (identical(other.enableDailyStreak, enableDailyStreak) ||
                other.enableDailyStreak == enableDailyStreak));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    completingLesson,
    passingQuiz,
    perfectQuizScore,
    completingAssignment,
    completingModule,
    creatingPost,
    commentingOnPost,
    helpingPeer,
    receivingReaction,
    dailyStreak,
    weeklyStreak,
    enableSocialPoints,
    enableDailyStreak,
  );

  /// Create a copy of ActivityPoints
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityPointsImplCopyWith<_$ActivityPointsImpl> get copyWith =>
      __$$ActivityPointsImplCopyWithImpl<_$ActivityPointsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityPointsImplToJson(this);
  }
}

abstract class _ActivityPoints implements ActivityPoints {
  const factory _ActivityPoints({
    final int completingLesson,
    final int passingQuiz,
    final int perfectQuizScore,
    final int completingAssignment,
    final int completingModule,
    final int creatingPost,
    final int commentingOnPost,
    final int helpingPeer,
    final int receivingReaction,
    final int dailyStreak,
    final int weeklyStreak,
    final bool enableSocialPoints,
    final bool enableDailyStreak,
  }) = _$ActivityPointsImpl;

  factory _ActivityPoints.fromJson(Map<String, dynamic> json) =
      _$ActivityPointsImpl.fromJson;

  // ⭐ الأساسيات (Core) - إلزامية
  /// نقاط إتمام درس واحد
  @override
  int get completingLesson;

  /// نقاط اجتياز اختبار (70% أو أكثر)
  @override
  int get passingQuiz;

  /// نقاط الحصول على درجة كاملة في اختبار
  @override
  int get perfectQuizScore;

  /// نقاط إتمام مهمة/تكليف
  @override
  int get completingAssignment;

  /// نقاط إتمام وحدة تعليمية كاملة
  @override
  int get completingModule; // 🎮 التفاعل الاجتماعي (Social) - اختياري
  /// نقاط إنشاء منشور في حائط الكورس
  @override
  int get creatingPost;

  /// نقاط التعليق على منشور
  @override
  int get commentingOnPost;

  /// نقاط مساعدة زميل (رد مفيد)
  @override
  int get helpingPeer;

  /// نقاط الحصول على reaction
  @override
  int get receivingReaction; // 🔥 Daily Streak - اختياري
  /// نقاط الدخول اليومي المتواصل
  @override
  int get dailyStreak;

  /// مكافأة الأسبوع المتواصل (7 أيام)
  @override
  int get weeklyStreak; // ⚙️ الإعدادات
  /// تفعيل نقاط التفاعل الاجتماعي
  @override
  bool get enableSocialPoints;

  /// تفعيل نقاط الدخول اليومي
  @override
  bool get enableDailyStreak;

  /// Create a copy of ActivityPoints
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityPointsImplCopyWith<_$ActivityPointsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
