// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Achievement _$AchievementFromJson(Map<String, dynamic> json) {
  return _Achievement.fromJson(json);
}

/// @nodoc
mixin _$Achievement {
  /// معرف الإنجاز
  String get id => throw _privateConstructorUsedError;

  /// العنوان
  String get title => throw _privateConstructorUsedError;

  /// الوصف
  String get description => throw _privateConstructorUsedError;

  /// رابط الأيقونة
  String get iconUrl => throw _privateConstructorUsedError;

  /// الفئة
  AchievementCategory get category => throw _privateConstructorUsedError;

  /// المعايير لفتح الإنجاز
  AchievementCriteria get criteria => throw _privateConstructorUsedError;

  /// نقاط المكافأة عند الفتح
  int get pointsReward => throw _privateConstructorUsedError;

  /// هل الإنجاز سري (مخفي حتى يتم فتحه)
  bool get isSecret => throw _privateConstructorUsedError;

  /// معرف الكورس (null = عام لكل الكورسات)
  String? get courseId => throw _privateConstructorUsedError;

  /// Serializes this Achievement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AchievementCopyWith<Achievement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementCopyWith<$Res> {
  factory $AchievementCopyWith(
    Achievement value,
    $Res Function(Achievement) then,
  ) = _$AchievementCopyWithImpl<$Res, Achievement>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String iconUrl,
    AchievementCategory category,
    AchievementCriteria criteria,
    int pointsReward,
    bool isSecret,
    String? courseId,
  });

  $AchievementCriteriaCopyWith<$Res> get criteria;
}

/// @nodoc
class _$AchievementCopyWithImpl<$Res, $Val extends Achievement>
    implements $AchievementCopyWith<$Res> {
  _$AchievementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? iconUrl = null,
    Object? category = null,
    Object? criteria = null,
    Object? pointsReward = null,
    Object? isSecret = null,
    Object? courseId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            iconUrl: null == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as AchievementCategory,
            criteria: null == criteria
                ? _value.criteria
                : criteria // ignore: cast_nullable_to_non_nullable
                      as AchievementCriteria,
            pointsReward: null == pointsReward
                ? _value.pointsReward
                : pointsReward // ignore: cast_nullable_to_non_nullable
                      as int,
            isSecret: null == isSecret
                ? _value.isSecret
                : isSecret // ignore: cast_nullable_to_non_nullable
                      as bool,
            courseId: freezed == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AchievementCriteriaCopyWith<$Res> get criteria {
    return $AchievementCriteriaCopyWith<$Res>(_value.criteria, (value) {
      return _then(_value.copyWith(criteria: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AchievementImplCopyWith<$Res>
    implements $AchievementCopyWith<$Res> {
  factory _$$AchievementImplCopyWith(
    _$AchievementImpl value,
    $Res Function(_$AchievementImpl) then,
  ) = __$$AchievementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String iconUrl,
    AchievementCategory category,
    AchievementCriteria criteria,
    int pointsReward,
    bool isSecret,
    String? courseId,
  });

  @override
  $AchievementCriteriaCopyWith<$Res> get criteria;
}

/// @nodoc
class __$$AchievementImplCopyWithImpl<$Res>
    extends _$AchievementCopyWithImpl<$Res, _$AchievementImpl>
    implements _$$AchievementImplCopyWith<$Res> {
  __$$AchievementImplCopyWithImpl(
    _$AchievementImpl _value,
    $Res Function(_$AchievementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? iconUrl = null,
    Object? category = null,
    Object? criteria = null,
    Object? pointsReward = null,
    Object? isSecret = null,
    Object? courseId = freezed,
  }) {
    return _then(
      _$AchievementImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        iconUrl: null == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as AchievementCategory,
        criteria: null == criteria
            ? _value.criteria
            : criteria // ignore: cast_nullable_to_non_nullable
                  as AchievementCriteria,
        pointsReward: null == pointsReward
            ? _value.pointsReward
            : pointsReward // ignore: cast_nullable_to_non_nullable
                  as int,
        isSecret: null == isSecret
            ? _value.isSecret
            : isSecret // ignore: cast_nullable_to_non_nullable
                  as bool,
        courseId: freezed == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AchievementImpl implements _Achievement {
  const _$AchievementImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.category,
    required this.criteria,
    this.pointsReward = 0,
    this.isSecret = false,
    this.courseId,
  });

  factory _$AchievementImpl.fromJson(Map<String, dynamic> json) =>
      _$$AchievementImplFromJson(json);

  /// معرف الإنجاز
  @override
  final String id;

  /// العنوان
  @override
  final String title;

  /// الوصف
  @override
  final String description;

  /// رابط الأيقونة
  @override
  final String iconUrl;

  /// الفئة
  @override
  final AchievementCategory category;

  /// المعايير لفتح الإنجاز
  @override
  final AchievementCriteria criteria;

  /// نقاط المكافأة عند الفتح
  @override
  @JsonKey()
  final int pointsReward;

  /// هل الإنجاز سري (مخفي حتى يتم فتحه)
  @override
  @JsonKey()
  final bool isSecret;

  /// معرف الكورس (null = عام لكل الكورسات)
  @override
  final String? courseId;

  @override
  String toString() {
    return 'Achievement(id: $id, title: $title, description: $description, iconUrl: $iconUrl, category: $category, criteria: $criteria, pointsReward: $pointsReward, isSecret: $isSecret, courseId: $courseId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.criteria, criteria) ||
                other.criteria == criteria) &&
            (identical(other.pointsReward, pointsReward) ||
                other.pointsReward == pointsReward) &&
            (identical(other.isSecret, isSecret) ||
                other.isSecret == isSecret) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    iconUrl,
    category,
    criteria,
    pointsReward,
    isSecret,
    courseId,
  );

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementImplCopyWith<_$AchievementImpl> get copyWith =>
      __$$AchievementImplCopyWithImpl<_$AchievementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AchievementImplToJson(this);
  }
}

abstract class _Achievement implements Achievement {
  const factory _Achievement({
    required final String id,
    required final String title,
    required final String description,
    required final String iconUrl,
    required final AchievementCategory category,
    required final AchievementCriteria criteria,
    final int pointsReward,
    final bool isSecret,
    final String? courseId,
  }) = _$AchievementImpl;

  factory _Achievement.fromJson(Map<String, dynamic> json) =
      _$AchievementImpl.fromJson;

  /// معرف الإنجاز
  @override
  String get id;

  /// العنوان
  @override
  String get title;

  /// الوصف
  @override
  String get description;

  /// رابط الأيقونة
  @override
  String get iconUrl;

  /// الفئة
  @override
  AchievementCategory get category;

  /// المعايير لفتح الإنجاز
  @override
  AchievementCriteria get criteria;

  /// نقاط المكافأة عند الفتح
  @override
  int get pointsReward;

  /// هل الإنجاز سري (مخفي حتى يتم فتحه)
  @override
  bool get isSecret;

  /// معرف الكورس (null = عام لكل الكورسات)
  @override
  String? get courseId;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AchievementImplCopyWith<_$AchievementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AchievementCriteria _$AchievementCriteriaFromJson(Map<String, dynamic> json) {
  return _AchievementCriteria.fromJson(json);
}

/// @nodoc
mixin _$AchievementCriteria {
  /// نوع المعيار
  /// مثال: "modules_completed", "quizzes_passed", "streak_days"
  String get type => throw _privateConstructorUsedError;

  /// القيمة المستهدفة
  /// مثال: 5 (وحدات)، 10 (اختبارات)، 7 (أيام)
  int get targetValue => throw _privateConstructorUsedError;

  /// معرف محدد (اختياري)
  /// مثال: معرف وحدة معينة، معرف اختبار معين
  String? get specificId => throw _privateConstructorUsedError;

  /// شروط إضافية (اختياري)
  Map<String, dynamic>? get additionalConditions =>
      throw _privateConstructorUsedError;

  /// Serializes this AchievementCriteria to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AchievementCriteria
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AchievementCriteriaCopyWith<AchievementCriteria> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementCriteriaCopyWith<$Res> {
  factory $AchievementCriteriaCopyWith(
    AchievementCriteria value,
    $Res Function(AchievementCriteria) then,
  ) = _$AchievementCriteriaCopyWithImpl<$Res, AchievementCriteria>;
  @useResult
  $Res call({
    String type,
    int targetValue,
    String? specificId,
    Map<String, dynamic>? additionalConditions,
  });
}

/// @nodoc
class _$AchievementCriteriaCopyWithImpl<$Res, $Val extends AchievementCriteria>
    implements $AchievementCriteriaCopyWith<$Res> {
  _$AchievementCriteriaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AchievementCriteria
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? targetValue = null,
    Object? specificId = freezed,
    Object? additionalConditions = freezed,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            targetValue: null == targetValue
                ? _value.targetValue
                : targetValue // ignore: cast_nullable_to_non_nullable
                      as int,
            specificId: freezed == specificId
                ? _value.specificId
                : specificId // ignore: cast_nullable_to_non_nullable
                      as String?,
            additionalConditions: freezed == additionalConditions
                ? _value.additionalConditions
                : additionalConditions // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AchievementCriteriaImplCopyWith<$Res>
    implements $AchievementCriteriaCopyWith<$Res> {
  factory _$$AchievementCriteriaImplCopyWith(
    _$AchievementCriteriaImpl value,
    $Res Function(_$AchievementCriteriaImpl) then,
  ) = __$$AchievementCriteriaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    int targetValue,
    String? specificId,
    Map<String, dynamic>? additionalConditions,
  });
}

/// @nodoc
class __$$AchievementCriteriaImplCopyWithImpl<$Res>
    extends _$AchievementCriteriaCopyWithImpl<$Res, _$AchievementCriteriaImpl>
    implements _$$AchievementCriteriaImplCopyWith<$Res> {
  __$$AchievementCriteriaImplCopyWithImpl(
    _$AchievementCriteriaImpl _value,
    $Res Function(_$AchievementCriteriaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AchievementCriteria
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? targetValue = null,
    Object? specificId = freezed,
    Object? additionalConditions = freezed,
  }) {
    return _then(
      _$AchievementCriteriaImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        targetValue: null == targetValue
            ? _value.targetValue
            : targetValue // ignore: cast_nullable_to_non_nullable
                  as int,
        specificId: freezed == specificId
            ? _value.specificId
            : specificId // ignore: cast_nullable_to_non_nullable
                  as String?,
        additionalConditions: freezed == additionalConditions
            ? _value._additionalConditions
            : additionalConditions // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AchievementCriteriaImpl implements _AchievementCriteria {
  const _$AchievementCriteriaImpl({
    required this.type,
    required this.targetValue,
    this.specificId,
    final Map<String, dynamic>? additionalConditions,
  }) : _additionalConditions = additionalConditions;

  factory _$AchievementCriteriaImpl.fromJson(Map<String, dynamic> json) =>
      _$$AchievementCriteriaImplFromJson(json);

  /// نوع المعيار
  /// مثال: "modules_completed", "quizzes_passed", "streak_days"
  @override
  final String type;

  /// القيمة المستهدفة
  /// مثال: 5 (وحدات)، 10 (اختبارات)، 7 (أيام)
  @override
  final int targetValue;

  /// معرف محدد (اختياري)
  /// مثال: معرف وحدة معينة، معرف اختبار معين
  @override
  final String? specificId;

  /// شروط إضافية (اختياري)
  final Map<String, dynamic>? _additionalConditions;

  /// شروط إضافية (اختياري)
  @override
  Map<String, dynamic>? get additionalConditions {
    final value = _additionalConditions;
    if (value == null) return null;
    if (_additionalConditions is EqualUnmodifiableMapView)
      return _additionalConditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AchievementCriteria(type: $type, targetValue: $targetValue, specificId: $specificId, additionalConditions: $additionalConditions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementCriteriaImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.specificId, specificId) ||
                other.specificId == specificId) &&
            const DeepCollectionEquality().equals(
              other._additionalConditions,
              _additionalConditions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    targetValue,
    specificId,
    const DeepCollectionEquality().hash(_additionalConditions),
  );

  /// Create a copy of AchievementCriteria
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementCriteriaImplCopyWith<_$AchievementCriteriaImpl> get copyWith =>
      __$$AchievementCriteriaImplCopyWithImpl<_$AchievementCriteriaImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AchievementCriteriaImplToJson(this);
  }
}

abstract class _AchievementCriteria implements AchievementCriteria {
  const factory _AchievementCriteria({
    required final String type,
    required final int targetValue,
    final String? specificId,
    final Map<String, dynamic>? additionalConditions,
  }) = _$AchievementCriteriaImpl;

  factory _AchievementCriteria.fromJson(Map<String, dynamic> json) =
      _$AchievementCriteriaImpl.fromJson;

  /// نوع المعيار
  /// مثال: "modules_completed", "quizzes_passed", "streak_days"
  @override
  String get type;

  /// القيمة المستهدفة
  /// مثال: 5 (وحدات)، 10 (اختبارات)، 7 (أيام)
  @override
  int get targetValue;

  /// معرف محدد (اختياري)
  /// مثال: معرف وحدة معينة، معرف اختبار معين
  @override
  String? get specificId;

  /// شروط إضافية (اختياري)
  @override
  Map<String, dynamic>? get additionalConditions;

  /// Create a copy of AchievementCriteria
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AchievementCriteriaImplCopyWith<_$AchievementCriteriaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserAchievement _$UserAchievementFromJson(Map<String, dynamic> json) {
  return _UserAchievement.fromJson(json);
}

/// @nodoc
mixin _$UserAchievement {
  /// معرف الإنجاز
  String get achievementId => throw _privateConstructorUsedError;

  /// معرف المستخدم
  String get userId => throw _privateConstructorUsedError;

  /// معرف الكورس
  String get courseId => throw _privateConstructorUsedError;

  /// تاريخ الفتح
  DateTime get unlockedAt => throw _privateConstructorUsedError;

  /// هل تم عرضه للمستخدم (لإظهار notification)
  bool get isViewed => throw _privateConstructorUsedError;

  /// التقدم الحالي (اختياري - للإنجازات التدريجية)
  int get currentProgress => throw _privateConstructorUsedError;

  /// Serializes this UserAchievement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserAchievement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserAchievementCopyWith<UserAchievement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAchievementCopyWith<$Res> {
  factory $UserAchievementCopyWith(
    UserAchievement value,
    $Res Function(UserAchievement) then,
  ) = _$UserAchievementCopyWithImpl<$Res, UserAchievement>;
  @useResult
  $Res call({
    String achievementId,
    String userId,
    String courseId,
    DateTime unlockedAt,
    bool isViewed,
    int currentProgress,
  });
}

/// @nodoc
class _$UserAchievementCopyWithImpl<$Res, $Val extends UserAchievement>
    implements $UserAchievementCopyWith<$Res> {
  _$UserAchievementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserAchievement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? achievementId = null,
    Object? userId = null,
    Object? courseId = null,
    Object? unlockedAt = null,
    Object? isViewed = null,
    Object? currentProgress = null,
  }) {
    return _then(
      _value.copyWith(
            achievementId: null == achievementId
                ? _value.achievementId
                : achievementId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            unlockedAt: null == unlockedAt
                ? _value.unlockedAt
                : unlockedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isViewed: null == isViewed
                ? _value.isViewed
                : isViewed // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentProgress: null == currentProgress
                ? _value.currentProgress
                : currentProgress // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserAchievementImplCopyWith<$Res>
    implements $UserAchievementCopyWith<$Res> {
  factory _$$UserAchievementImplCopyWith(
    _$UserAchievementImpl value,
    $Res Function(_$UserAchievementImpl) then,
  ) = __$$UserAchievementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String achievementId,
    String userId,
    String courseId,
    DateTime unlockedAt,
    bool isViewed,
    int currentProgress,
  });
}

/// @nodoc
class __$$UserAchievementImplCopyWithImpl<$Res>
    extends _$UserAchievementCopyWithImpl<$Res, _$UserAchievementImpl>
    implements _$$UserAchievementImplCopyWith<$Res> {
  __$$UserAchievementImplCopyWithImpl(
    _$UserAchievementImpl _value,
    $Res Function(_$UserAchievementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserAchievement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? achievementId = null,
    Object? userId = null,
    Object? courseId = null,
    Object? unlockedAt = null,
    Object? isViewed = null,
    Object? currentProgress = null,
  }) {
    return _then(
      _$UserAchievementImpl(
        achievementId: null == achievementId
            ? _value.achievementId
            : achievementId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        unlockedAt: null == unlockedAt
            ? _value.unlockedAt
            : unlockedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isViewed: null == isViewed
            ? _value.isViewed
            : isViewed // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentProgress: null == currentProgress
            ? _value.currentProgress
            : currentProgress // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAchievementImpl implements _UserAchievement {
  const _$UserAchievementImpl({
    required this.achievementId,
    required this.userId,
    required this.courseId,
    required this.unlockedAt,
    this.isViewed = false,
    this.currentProgress = 0,
  });

  factory _$UserAchievementImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAchievementImplFromJson(json);

  /// معرف الإنجاز
  @override
  final String achievementId;

  /// معرف المستخدم
  @override
  final String userId;

  /// معرف الكورس
  @override
  final String courseId;

  /// تاريخ الفتح
  @override
  final DateTime unlockedAt;

  /// هل تم عرضه للمستخدم (لإظهار notification)
  @override
  @JsonKey()
  final bool isViewed;

  /// التقدم الحالي (اختياري - للإنجازات التدريجية)
  @override
  @JsonKey()
  final int currentProgress;

  @override
  String toString() {
    return 'UserAchievement(achievementId: $achievementId, userId: $userId, courseId: $courseId, unlockedAt: $unlockedAt, isViewed: $isViewed, currentProgress: $currentProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAchievementImpl &&
            (identical(other.achievementId, achievementId) ||
                other.achievementId == achievementId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt) &&
            (identical(other.isViewed, isViewed) ||
                other.isViewed == isViewed) &&
            (identical(other.currentProgress, currentProgress) ||
                other.currentProgress == currentProgress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    achievementId,
    userId,
    courseId,
    unlockedAt,
    isViewed,
    currentProgress,
  );

  /// Create a copy of UserAchievement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAchievementImplCopyWith<_$UserAchievementImpl> get copyWith =>
      __$$UserAchievementImplCopyWithImpl<_$UserAchievementImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAchievementImplToJson(this);
  }
}

abstract class _UserAchievement implements UserAchievement {
  const factory _UserAchievement({
    required final String achievementId,
    required final String userId,
    required final String courseId,
    required final DateTime unlockedAt,
    final bool isViewed,
    final int currentProgress,
  }) = _$UserAchievementImpl;

  factory _UserAchievement.fromJson(Map<String, dynamic> json) =
      _$UserAchievementImpl.fromJson;

  /// معرف الإنجاز
  @override
  String get achievementId;

  /// معرف المستخدم
  @override
  String get userId;

  /// معرف الكورس
  @override
  String get courseId;

  /// تاريخ الفتح
  @override
  DateTime get unlockedAt;

  /// هل تم عرضه للمستخدم (لإظهار notification)
  @override
  bool get isViewed;

  /// التقدم الحالي (اختياري - للإنجازات التدريجية)
  @override
  int get currentProgress;

  /// Create a copy of UserAchievement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserAchievementImplCopyWith<_$UserAchievementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
