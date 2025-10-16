// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommendation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Recommendation _$RecommendationFromJson(Map<String, dynamic> json) {
  return _Recommendation.fromJson(json);
}

/// @nodoc
mixin _$Recommendation {
  /// معرف التوصية
  String get id => throw _privateConstructorUsedError;

  /// معرف المستخدم
  String get userId => throw _privateConstructorUsedError;

  /// معرف الكورس
  String get courseId => throw _privateConstructorUsedError;

  /// نوع التوصية
  RecommendationType get type => throw _privateConstructorUsedError;

  /// سبب التوصية
  RecommendationReason get reason => throw _privateConstructorUsedError;

  /// معرف المحتوى الموصى به
  String get contentId => throw _privateConstructorUsedError;

  /// عنوان المحتوى
  String get contentTitle => throw _privateConstructorUsedError;

  /// وصف مختصر
  String get description => throw _privateConstructorUsedError;

  /// درجة الأولوية (0-100)
  /// كلما زادت الدرجة، كانت التوصية أهم
  int get priority => throw _privateConstructorUsedError;

  /// درجة الثقة (0-1)
  /// مدى ثقة النظام في هذه التوصية
  double get confidence => throw _privateConstructorUsedError;

  /// الوقت المتوقع للإتمام (بالدقائق)
  int? get estimatedMinutes => throw _privateConstructorUsedError;

  /// الصعوبة المتوقعة
  String get difficulty => throw _privateConstructorUsedError;

  /// هل تم مشاهدة التوصية
  bool get isViewed => throw _privateConstructorUsedError;

  /// هل تم قبول التوصية (تم فتح المحتوى)
  bool get isAccepted => throw _privateConstructorUsedError;

  /// هل تم رفض التوصية
  bool get isDismissed => throw _privateConstructorUsedError;

  /// هل تم إتمام المحتوى
  bool get isCompleted => throw _privateConstructorUsedError;

  /// تاريخ الإنشاء
  @RequiredTimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// تاريخ انتهاء الصلاحية (optional)
  @TimestampConverter()
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// تاريخ المشاهدة
  @TimestampConverter()
  DateTime? get viewedAt => throw _privateConstructorUsedError;

  /// تاريخ القبول
  @TimestampConverter()
  DateTime? get acceptedAt => throw _privateConstructorUsedError;

  /// البيانات الإضافية (metadata)
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this Recommendation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Recommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendationCopyWith<Recommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationCopyWith<$Res> {
  factory $RecommendationCopyWith(
    Recommendation value,
    $Res Function(Recommendation) then,
  ) = _$RecommendationCopyWithImpl<$Res, Recommendation>;
  @useResult
  $Res call({
    String id,
    String userId,
    String courseId,
    RecommendationType type,
    RecommendationReason reason,
    String contentId,
    String contentTitle,
    String description,
    int priority,
    double confidence,
    int? estimatedMinutes,
    String difficulty,
    bool isViewed,
    bool isAccepted,
    bool isDismissed,
    bool isCompleted,
    @RequiredTimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime? expiresAt,
    @TimestampConverter() DateTime? viewedAt,
    @TimestampConverter() DateTime? acceptedAt,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class _$RecommendationCopyWithImpl<$Res, $Val extends Recommendation>
    implements $RecommendationCopyWith<$Res> {
  _$RecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Recommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? courseId = null,
    Object? type = null,
    Object? reason = null,
    Object? contentId = null,
    Object? contentTitle = null,
    Object? description = null,
    Object? priority = null,
    Object? confidence = null,
    Object? estimatedMinutes = freezed,
    Object? difficulty = null,
    Object? isViewed = null,
    Object? isAccepted = null,
    Object? isDismissed = null,
    Object? isCompleted = null,
    Object? createdAt = null,
    Object? expiresAt = freezed,
    Object? viewedAt = freezed,
    Object? acceptedAt = freezed,
    Object? metadata = null,
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
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as RecommendationType,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as RecommendationReason,
            contentId: null == contentId
                ? _value.contentId
                : contentId // ignore: cast_nullable_to_non_nullable
                      as String,
            contentTitle: null == contentTitle
                ? _value.contentTitle
                : contentTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as int,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            estimatedMinutes: freezed == estimatedMinutes
                ? _value.estimatedMinutes
                : estimatedMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as String,
            isViewed: null == isViewed
                ? _value.isViewed
                : isViewed // ignore: cast_nullable_to_non_nullable
                      as bool,
            isAccepted: null == isAccepted
                ? _value.isAccepted
                : isAccepted // ignore: cast_nullable_to_non_nullable
                      as bool,
            isDismissed: null == isDismissed
                ? _value.isDismissed
                : isDismissed // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            viewedAt: freezed == viewedAt
                ? _value.viewedAt
                : viewedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            acceptedAt: freezed == acceptedAt
                ? _value.acceptedAt
                : acceptedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecommendationImplCopyWith<$Res>
    implements $RecommendationCopyWith<$Res> {
  factory _$$RecommendationImplCopyWith(
    _$RecommendationImpl value,
    $Res Function(_$RecommendationImpl) then,
  ) = __$$RecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String courseId,
    RecommendationType type,
    RecommendationReason reason,
    String contentId,
    String contentTitle,
    String description,
    int priority,
    double confidence,
    int? estimatedMinutes,
    String difficulty,
    bool isViewed,
    bool isAccepted,
    bool isDismissed,
    bool isCompleted,
    @RequiredTimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime? expiresAt,
    @TimestampConverter() DateTime? viewedAt,
    @TimestampConverter() DateTime? acceptedAt,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class __$$RecommendationImplCopyWithImpl<$Res>
    extends _$RecommendationCopyWithImpl<$Res, _$RecommendationImpl>
    implements _$$RecommendationImplCopyWith<$Res> {
  __$$RecommendationImplCopyWithImpl(
    _$RecommendationImpl _value,
    $Res Function(_$RecommendationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Recommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? courseId = null,
    Object? type = null,
    Object? reason = null,
    Object? contentId = null,
    Object? contentTitle = null,
    Object? description = null,
    Object? priority = null,
    Object? confidence = null,
    Object? estimatedMinutes = freezed,
    Object? difficulty = null,
    Object? isViewed = null,
    Object? isAccepted = null,
    Object? isDismissed = null,
    Object? isCompleted = null,
    Object? createdAt = null,
    Object? expiresAt = freezed,
    Object? viewedAt = freezed,
    Object? acceptedAt = freezed,
    Object? metadata = null,
  }) {
    return _then(
      _$RecommendationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as RecommendationType,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as RecommendationReason,
        contentId: null == contentId
            ? _value.contentId
            : contentId // ignore: cast_nullable_to_non_nullable
                  as String,
        contentTitle: null == contentTitle
            ? _value.contentTitle
            : contentTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as int,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        estimatedMinutes: freezed == estimatedMinutes
            ? _value.estimatedMinutes
            : estimatedMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as String,
        isViewed: null == isViewed
            ? _value.isViewed
            : isViewed // ignore: cast_nullable_to_non_nullable
                  as bool,
        isAccepted: null == isAccepted
            ? _value.isAccepted
            : isAccepted // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDismissed: null == isDismissed
            ? _value.isDismissed
            : isDismissed // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        viewedAt: freezed == viewedAt
            ? _value.viewedAt
            : viewedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        acceptedAt: freezed == acceptedAt
            ? _value.acceptedAt
            : acceptedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecommendationImpl implements _Recommendation {
  const _$RecommendationImpl({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.type,
    required this.reason,
    required this.contentId,
    required this.contentTitle,
    this.description = '',
    this.priority = 50,
    this.confidence = 0.5,
    this.estimatedMinutes,
    this.difficulty = 'متوسط',
    this.isViewed = false,
    this.isAccepted = false,
    this.isDismissed = false,
    this.isCompleted = false,
    @RequiredTimestampConverter() required this.createdAt,
    @TimestampConverter() this.expiresAt,
    @TimestampConverter() this.viewedAt,
    @TimestampConverter() this.acceptedAt,
    final Map<String, dynamic> metadata = const {},
  }) : _metadata = metadata;

  factory _$RecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecommendationImplFromJson(json);

  /// معرف التوصية
  @override
  final String id;

  /// معرف المستخدم
  @override
  final String userId;

  /// معرف الكورس
  @override
  final String courseId;

  /// نوع التوصية
  @override
  final RecommendationType type;

  /// سبب التوصية
  @override
  final RecommendationReason reason;

  /// معرف المحتوى الموصى به
  @override
  final String contentId;

  /// عنوان المحتوى
  @override
  final String contentTitle;

  /// وصف مختصر
  @override
  @JsonKey()
  final String description;

  /// درجة الأولوية (0-100)
  /// كلما زادت الدرجة، كانت التوصية أهم
  @override
  @JsonKey()
  final int priority;

  /// درجة الثقة (0-1)
  /// مدى ثقة النظام في هذه التوصية
  @override
  @JsonKey()
  final double confidence;

  /// الوقت المتوقع للإتمام (بالدقائق)
  @override
  final int? estimatedMinutes;

  /// الصعوبة المتوقعة
  @override
  @JsonKey()
  final String difficulty;

  /// هل تم مشاهدة التوصية
  @override
  @JsonKey()
  final bool isViewed;

  /// هل تم قبول التوصية (تم فتح المحتوى)
  @override
  @JsonKey()
  final bool isAccepted;

  /// هل تم رفض التوصية
  @override
  @JsonKey()
  final bool isDismissed;

  /// هل تم إتمام المحتوى
  @override
  @JsonKey()
  final bool isCompleted;

  /// تاريخ الإنشاء
  @override
  @RequiredTimestampConverter()
  final DateTime createdAt;

  /// تاريخ انتهاء الصلاحية (optional)
  @override
  @TimestampConverter()
  final DateTime? expiresAt;

  /// تاريخ المشاهدة
  @override
  @TimestampConverter()
  final DateTime? viewedAt;

  /// تاريخ القبول
  @override
  @TimestampConverter()
  final DateTime? acceptedAt;

  /// البيانات الإضافية (metadata)
  final Map<String, dynamic> _metadata;

  /// البيانات الإضافية (metadata)
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'Recommendation(id: $id, userId: $userId, courseId: $courseId, type: $type, reason: $reason, contentId: $contentId, contentTitle: $contentTitle, description: $description, priority: $priority, confidence: $confidence, estimatedMinutes: $estimatedMinutes, difficulty: $difficulty, isViewed: $isViewed, isAccepted: $isAccepted, isDismissed: $isDismissed, isCompleted: $isCompleted, createdAt: $createdAt, expiresAt: $expiresAt, viewedAt: $viewedAt, acceptedAt: $acceptedAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.contentTitle, contentTitle) ||
                other.contentTitle == contentTitle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.estimatedMinutes, estimatedMinutes) ||
                other.estimatedMinutes == estimatedMinutes) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.isViewed, isViewed) ||
                other.isViewed == isViewed) &&
            (identical(other.isAccepted, isAccepted) ||
                other.isAccepted == isAccepted) &&
            (identical(other.isDismissed, isDismissed) ||
                other.isDismissed == isDismissed) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.viewedAt, viewedAt) ||
                other.viewedAt == viewedAt) &&
            (identical(other.acceptedAt, acceptedAt) ||
                other.acceptedAt == acceptedAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    userId,
    courseId,
    type,
    reason,
    contentId,
    contentTitle,
    description,
    priority,
    confidence,
    estimatedMinutes,
    difficulty,
    isViewed,
    isAccepted,
    isDismissed,
    isCompleted,
    createdAt,
    expiresAt,
    viewedAt,
    acceptedAt,
    const DeepCollectionEquality().hash(_metadata),
  ]);

  /// Create a copy of Recommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationImplCopyWith<_$RecommendationImpl> get copyWith =>
      __$$RecommendationImplCopyWithImpl<_$RecommendationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecommendationImplToJson(this);
  }
}

abstract class _Recommendation implements Recommendation {
  const factory _Recommendation({
    required final String id,
    required final String userId,
    required final String courseId,
    required final RecommendationType type,
    required final RecommendationReason reason,
    required final String contentId,
    required final String contentTitle,
    final String description,
    final int priority,
    final double confidence,
    final int? estimatedMinutes,
    final String difficulty,
    final bool isViewed,
    final bool isAccepted,
    final bool isDismissed,
    final bool isCompleted,
    @RequiredTimestampConverter() required final DateTime createdAt,
    @TimestampConverter() final DateTime? expiresAt,
    @TimestampConverter() final DateTime? viewedAt,
    @TimestampConverter() final DateTime? acceptedAt,
    final Map<String, dynamic> metadata,
  }) = _$RecommendationImpl;

  factory _Recommendation.fromJson(Map<String, dynamic> json) =
      _$RecommendationImpl.fromJson;

  /// معرف التوصية
  @override
  String get id;

  /// معرف المستخدم
  @override
  String get userId;

  /// معرف الكورس
  @override
  String get courseId;

  /// نوع التوصية
  @override
  RecommendationType get type;

  /// سبب التوصية
  @override
  RecommendationReason get reason;

  /// معرف المحتوى الموصى به
  @override
  String get contentId;

  /// عنوان المحتوى
  @override
  String get contentTitle;

  /// وصف مختصر
  @override
  String get description;

  /// درجة الأولوية (0-100)
  /// كلما زادت الدرجة، كانت التوصية أهم
  @override
  int get priority;

  /// درجة الثقة (0-1)
  /// مدى ثقة النظام في هذه التوصية
  @override
  double get confidence;

  /// الوقت المتوقع للإتمام (بالدقائق)
  @override
  int? get estimatedMinutes;

  /// الصعوبة المتوقعة
  @override
  String get difficulty;

  /// هل تم مشاهدة التوصية
  @override
  bool get isViewed;

  /// هل تم قبول التوصية (تم فتح المحتوى)
  @override
  bool get isAccepted;

  /// هل تم رفض التوصية
  @override
  bool get isDismissed;

  /// هل تم إتمام المحتوى
  @override
  bool get isCompleted;

  /// تاريخ الإنشاء
  @override
  @RequiredTimestampConverter()
  DateTime get createdAt;

  /// تاريخ انتهاء الصلاحية (optional)
  @override
  @TimestampConverter()
  DateTime? get expiresAt;

  /// تاريخ المشاهدة
  @override
  @TimestampConverter()
  DateTime? get viewedAt;

  /// تاريخ القبول
  @override
  @TimestampConverter()
  DateTime? get acceptedAt;

  /// البيانات الإضافية (metadata)
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of Recommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendationImplCopyWith<_$RecommendationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecommendationCriteria _$RecommendationCriteriaFromJson(
  Map<String, dynamic> json,
) {
  return _RecommendationCriteria.fromJson(json);
}

/// @nodoc
mixin _$RecommendationCriteria {
  /// معرف المستخدم
  String get userId => throw _privateConstructorUsedError;

  /// معرف الكورس
  String get courseId => throw _privateConstructorUsedError;

  /// أنواع المحتوى المفضلة
  List<RecommendationType> get preferredTypes =>
      throw _privateConstructorUsedError;

  /// المهارات المستهدفة
  List<String> get targetSkills => throw _privateConstructorUsedError;

  /// مستوى الصعوبة المفضل
  String get preferredDifficulty => throw _privateConstructorUsedError;

  /// الحد الأقصى للوقت المتاح (بالدقائق)
  int? get maxTimeAvailable => throw _privateConstructorUsedError;

  /// عدد التوصيات المطلوبة
  int get limit => throw _privateConstructorUsedError;

  /// استبعاد المحتوى المكتمل
  bool get excludeCompleted => throw _privateConstructorUsedError;

  /// استبعاد المحتوى المرفوض
  bool get excludeDismissed => throw _privateConstructorUsedError;

  /// Serializes this RecommendationCriteria to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecommendationCriteria
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendationCriteriaCopyWith<RecommendationCriteria> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationCriteriaCopyWith<$Res> {
  factory $RecommendationCriteriaCopyWith(
    RecommendationCriteria value,
    $Res Function(RecommendationCriteria) then,
  ) = _$RecommendationCriteriaCopyWithImpl<$Res, RecommendationCriteria>;
  @useResult
  $Res call({
    String userId,
    String courseId,
    List<RecommendationType> preferredTypes,
    List<String> targetSkills,
    String preferredDifficulty,
    int? maxTimeAvailable,
    int limit,
    bool excludeCompleted,
    bool excludeDismissed,
  });
}

/// @nodoc
class _$RecommendationCriteriaCopyWithImpl<
  $Res,
  $Val extends RecommendationCriteria
>
    implements $RecommendationCriteriaCopyWith<$Res> {
  _$RecommendationCriteriaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendationCriteria
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? courseId = null,
    Object? preferredTypes = null,
    Object? targetSkills = null,
    Object? preferredDifficulty = null,
    Object? maxTimeAvailable = freezed,
    Object? limit = null,
    Object? excludeCompleted = null,
    Object? excludeDismissed = null,
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
            preferredTypes: null == preferredTypes
                ? _value.preferredTypes
                : preferredTypes // ignore: cast_nullable_to_non_nullable
                      as List<RecommendationType>,
            targetSkills: null == targetSkills
                ? _value.targetSkills
                : targetSkills // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            preferredDifficulty: null == preferredDifficulty
                ? _value.preferredDifficulty
                : preferredDifficulty // ignore: cast_nullable_to_non_nullable
                      as String,
            maxTimeAvailable: freezed == maxTimeAvailable
                ? _value.maxTimeAvailable
                : maxTimeAvailable // ignore: cast_nullable_to_non_nullable
                      as int?,
            limit: null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int,
            excludeCompleted: null == excludeCompleted
                ? _value.excludeCompleted
                : excludeCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            excludeDismissed: null == excludeDismissed
                ? _value.excludeDismissed
                : excludeDismissed // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecommendationCriteriaImplCopyWith<$Res>
    implements $RecommendationCriteriaCopyWith<$Res> {
  factory _$$RecommendationCriteriaImplCopyWith(
    _$RecommendationCriteriaImpl value,
    $Res Function(_$RecommendationCriteriaImpl) then,
  ) = __$$RecommendationCriteriaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String courseId,
    List<RecommendationType> preferredTypes,
    List<String> targetSkills,
    String preferredDifficulty,
    int? maxTimeAvailable,
    int limit,
    bool excludeCompleted,
    bool excludeDismissed,
  });
}

/// @nodoc
class __$$RecommendationCriteriaImplCopyWithImpl<$Res>
    extends
        _$RecommendationCriteriaCopyWithImpl<$Res, _$RecommendationCriteriaImpl>
    implements _$$RecommendationCriteriaImplCopyWith<$Res> {
  __$$RecommendationCriteriaImplCopyWithImpl(
    _$RecommendationCriteriaImpl _value,
    $Res Function(_$RecommendationCriteriaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecommendationCriteria
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? courseId = null,
    Object? preferredTypes = null,
    Object? targetSkills = null,
    Object? preferredDifficulty = null,
    Object? maxTimeAvailable = freezed,
    Object? limit = null,
    Object? excludeCompleted = null,
    Object? excludeDismissed = null,
  }) {
    return _then(
      _$RecommendationCriteriaImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        preferredTypes: null == preferredTypes
            ? _value._preferredTypes
            : preferredTypes // ignore: cast_nullable_to_non_nullable
                  as List<RecommendationType>,
        targetSkills: null == targetSkills
            ? _value._targetSkills
            : targetSkills // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        preferredDifficulty: null == preferredDifficulty
            ? _value.preferredDifficulty
            : preferredDifficulty // ignore: cast_nullable_to_non_nullable
                  as String,
        maxTimeAvailable: freezed == maxTimeAvailable
            ? _value.maxTimeAvailable
            : maxTimeAvailable // ignore: cast_nullable_to_non_nullable
                  as int?,
        limit: null == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int,
        excludeCompleted: null == excludeCompleted
            ? _value.excludeCompleted
            : excludeCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        excludeDismissed: null == excludeDismissed
            ? _value.excludeDismissed
            : excludeDismissed // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecommendationCriteriaImpl implements _RecommendationCriteria {
  const _$RecommendationCriteriaImpl({
    required this.userId,
    required this.courseId,
    final List<RecommendationType> preferredTypes = const [],
    final List<String> targetSkills = const [],
    this.preferredDifficulty = 'متوسط',
    this.maxTimeAvailable,
    this.limit = 5,
    this.excludeCompleted = true,
    this.excludeDismissed = true,
  }) : _preferredTypes = preferredTypes,
       _targetSkills = targetSkills;

  factory _$RecommendationCriteriaImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecommendationCriteriaImplFromJson(json);

  /// معرف المستخدم
  @override
  final String userId;

  /// معرف الكورس
  @override
  final String courseId;

  /// أنواع المحتوى المفضلة
  final List<RecommendationType> _preferredTypes;

  /// أنواع المحتوى المفضلة
  @override
  @JsonKey()
  List<RecommendationType> get preferredTypes {
    if (_preferredTypes is EqualUnmodifiableListView) return _preferredTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredTypes);
  }

  /// المهارات المستهدفة
  final List<String> _targetSkills;

  /// المهارات المستهدفة
  @override
  @JsonKey()
  List<String> get targetSkills {
    if (_targetSkills is EqualUnmodifiableListView) return _targetSkills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetSkills);
  }

  /// مستوى الصعوبة المفضل
  @override
  @JsonKey()
  final String preferredDifficulty;

  /// الحد الأقصى للوقت المتاح (بالدقائق)
  @override
  final int? maxTimeAvailable;

  /// عدد التوصيات المطلوبة
  @override
  @JsonKey()
  final int limit;

  /// استبعاد المحتوى المكتمل
  @override
  @JsonKey()
  final bool excludeCompleted;

  /// استبعاد المحتوى المرفوض
  @override
  @JsonKey()
  final bool excludeDismissed;

  @override
  String toString() {
    return 'RecommendationCriteria(userId: $userId, courseId: $courseId, preferredTypes: $preferredTypes, targetSkills: $targetSkills, preferredDifficulty: $preferredDifficulty, maxTimeAvailable: $maxTimeAvailable, limit: $limit, excludeCompleted: $excludeCompleted, excludeDismissed: $excludeDismissed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationCriteriaImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            const DeepCollectionEquality().equals(
              other._preferredTypes,
              _preferredTypes,
            ) &&
            const DeepCollectionEquality().equals(
              other._targetSkills,
              _targetSkills,
            ) &&
            (identical(other.preferredDifficulty, preferredDifficulty) ||
                other.preferredDifficulty == preferredDifficulty) &&
            (identical(other.maxTimeAvailable, maxTimeAvailable) ||
                other.maxTimeAvailable == maxTimeAvailable) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.excludeCompleted, excludeCompleted) ||
                other.excludeCompleted == excludeCompleted) &&
            (identical(other.excludeDismissed, excludeDismissed) ||
                other.excludeDismissed == excludeDismissed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    courseId,
    const DeepCollectionEquality().hash(_preferredTypes),
    const DeepCollectionEquality().hash(_targetSkills),
    preferredDifficulty,
    maxTimeAvailable,
    limit,
    excludeCompleted,
    excludeDismissed,
  );

  /// Create a copy of RecommendationCriteria
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationCriteriaImplCopyWith<_$RecommendationCriteriaImpl>
  get copyWith =>
      __$$RecommendationCriteriaImplCopyWithImpl<_$RecommendationCriteriaImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecommendationCriteriaImplToJson(this);
  }
}

abstract class _RecommendationCriteria implements RecommendationCriteria {
  const factory _RecommendationCriteria({
    required final String userId,
    required final String courseId,
    final List<RecommendationType> preferredTypes,
    final List<String> targetSkills,
    final String preferredDifficulty,
    final int? maxTimeAvailable,
    final int limit,
    final bool excludeCompleted,
    final bool excludeDismissed,
  }) = _$RecommendationCriteriaImpl;

  factory _RecommendationCriteria.fromJson(Map<String, dynamic> json) =
      _$RecommendationCriteriaImpl.fromJson;

  /// معرف المستخدم
  @override
  String get userId;

  /// معرف الكورس
  @override
  String get courseId;

  /// أنواع المحتوى المفضلة
  @override
  List<RecommendationType> get preferredTypes;

  /// المهارات المستهدفة
  @override
  List<String> get targetSkills;

  /// مستوى الصعوبة المفضل
  @override
  String get preferredDifficulty;

  /// الحد الأقصى للوقت المتاح (بالدقائق)
  @override
  int? get maxTimeAvailable;

  /// عدد التوصيات المطلوبة
  @override
  int get limit;

  /// استبعاد المحتوى المكتمل
  @override
  bool get excludeCompleted;

  /// استبعاد المحتوى المرفوض
  @override
  bool get excludeDismissed;

  /// Create a copy of RecommendationCriteria
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendationCriteriaImplCopyWith<_$RecommendationCriteriaImpl>
  get copyWith => throw _privateConstructorUsedError;
}

RecommendationStats _$RecommendationStatsFromJson(Map<String, dynamic> json) {
  return _RecommendationStats.fromJson(json);
}

/// @nodoc
mixin _$RecommendationStats {
  /// عدد التوصيات الكلي
  int get totalRecommendations => throw _privateConstructorUsedError;

  /// عدد التوصيات المشاهدة
  int get viewedRecommendations => throw _privateConstructorUsedError;

  /// عدد التوصيات المقبولة
  int get acceptedRecommendations => throw _privateConstructorUsedError;

  /// عدد التوصيات المرفوضة
  int get dismissedRecommendations => throw _privateConstructorUsedError;

  /// عدد التوصيات المكتملة
  int get completedRecommendations => throw _privateConstructorUsedError;

  /// نسبة القبول (0-1)
  double get acceptanceRate => throw _privateConstructorUsedError;

  /// نسبة الإتمام (0-1)
  double get completionRate => throw _privateConstructorUsedError;

  /// متوسط وقت القبول (بالساعات)
  double get avgTimeToAccept => throw _privateConstructorUsedError;

  /// متوسط درجة الثقة
  double get avgConfidence => throw _privateConstructorUsedError;

  /// Serializes this RecommendationStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecommendationStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendationStatsCopyWith<RecommendationStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationStatsCopyWith<$Res> {
  factory $RecommendationStatsCopyWith(
    RecommendationStats value,
    $Res Function(RecommendationStats) then,
  ) = _$RecommendationStatsCopyWithImpl<$Res, RecommendationStats>;
  @useResult
  $Res call({
    int totalRecommendations,
    int viewedRecommendations,
    int acceptedRecommendations,
    int dismissedRecommendations,
    int completedRecommendations,
    double acceptanceRate,
    double completionRate,
    double avgTimeToAccept,
    double avgConfidence,
  });
}

/// @nodoc
class _$RecommendationStatsCopyWithImpl<$Res, $Val extends RecommendationStats>
    implements $RecommendationStatsCopyWith<$Res> {
  _$RecommendationStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendationStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRecommendations = null,
    Object? viewedRecommendations = null,
    Object? acceptedRecommendations = null,
    Object? dismissedRecommendations = null,
    Object? completedRecommendations = null,
    Object? acceptanceRate = null,
    Object? completionRate = null,
    Object? avgTimeToAccept = null,
    Object? avgConfidence = null,
  }) {
    return _then(
      _value.copyWith(
            totalRecommendations: null == totalRecommendations
                ? _value.totalRecommendations
                : totalRecommendations // ignore: cast_nullable_to_non_nullable
                      as int,
            viewedRecommendations: null == viewedRecommendations
                ? _value.viewedRecommendations
                : viewedRecommendations // ignore: cast_nullable_to_non_nullable
                      as int,
            acceptedRecommendations: null == acceptedRecommendations
                ? _value.acceptedRecommendations
                : acceptedRecommendations // ignore: cast_nullable_to_non_nullable
                      as int,
            dismissedRecommendations: null == dismissedRecommendations
                ? _value.dismissedRecommendations
                : dismissedRecommendations // ignore: cast_nullable_to_non_nullable
                      as int,
            completedRecommendations: null == completedRecommendations
                ? _value.completedRecommendations
                : completedRecommendations // ignore: cast_nullable_to_non_nullable
                      as int,
            acceptanceRate: null == acceptanceRate
                ? _value.acceptanceRate
                : acceptanceRate // ignore: cast_nullable_to_non_nullable
                      as double,
            completionRate: null == completionRate
                ? _value.completionRate
                : completionRate // ignore: cast_nullable_to_non_nullable
                      as double,
            avgTimeToAccept: null == avgTimeToAccept
                ? _value.avgTimeToAccept
                : avgTimeToAccept // ignore: cast_nullable_to_non_nullable
                      as double,
            avgConfidence: null == avgConfidence
                ? _value.avgConfidence
                : avgConfidence // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecommendationStatsImplCopyWith<$Res>
    implements $RecommendationStatsCopyWith<$Res> {
  factory _$$RecommendationStatsImplCopyWith(
    _$RecommendationStatsImpl value,
    $Res Function(_$RecommendationStatsImpl) then,
  ) = __$$RecommendationStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalRecommendations,
    int viewedRecommendations,
    int acceptedRecommendations,
    int dismissedRecommendations,
    int completedRecommendations,
    double acceptanceRate,
    double completionRate,
    double avgTimeToAccept,
    double avgConfidence,
  });
}

/// @nodoc
class __$$RecommendationStatsImplCopyWithImpl<$Res>
    extends _$RecommendationStatsCopyWithImpl<$Res, _$RecommendationStatsImpl>
    implements _$$RecommendationStatsImplCopyWith<$Res> {
  __$$RecommendationStatsImplCopyWithImpl(
    _$RecommendationStatsImpl _value,
    $Res Function(_$RecommendationStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecommendationStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRecommendations = null,
    Object? viewedRecommendations = null,
    Object? acceptedRecommendations = null,
    Object? dismissedRecommendations = null,
    Object? completedRecommendations = null,
    Object? acceptanceRate = null,
    Object? completionRate = null,
    Object? avgTimeToAccept = null,
    Object? avgConfidence = null,
  }) {
    return _then(
      _$RecommendationStatsImpl(
        totalRecommendations: null == totalRecommendations
            ? _value.totalRecommendations
            : totalRecommendations // ignore: cast_nullable_to_non_nullable
                  as int,
        viewedRecommendations: null == viewedRecommendations
            ? _value.viewedRecommendations
            : viewedRecommendations // ignore: cast_nullable_to_non_nullable
                  as int,
        acceptedRecommendations: null == acceptedRecommendations
            ? _value.acceptedRecommendations
            : acceptedRecommendations // ignore: cast_nullable_to_non_nullable
                  as int,
        dismissedRecommendations: null == dismissedRecommendations
            ? _value.dismissedRecommendations
            : dismissedRecommendations // ignore: cast_nullable_to_non_nullable
                  as int,
        completedRecommendations: null == completedRecommendations
            ? _value.completedRecommendations
            : completedRecommendations // ignore: cast_nullable_to_non_nullable
                  as int,
        acceptanceRate: null == acceptanceRate
            ? _value.acceptanceRate
            : acceptanceRate // ignore: cast_nullable_to_non_nullable
                  as double,
        completionRate: null == completionRate
            ? _value.completionRate
            : completionRate // ignore: cast_nullable_to_non_nullable
                  as double,
        avgTimeToAccept: null == avgTimeToAccept
            ? _value.avgTimeToAccept
            : avgTimeToAccept // ignore: cast_nullable_to_non_nullable
                  as double,
        avgConfidence: null == avgConfidence
            ? _value.avgConfidence
            : avgConfidence // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecommendationStatsImpl implements _RecommendationStats {
  const _$RecommendationStatsImpl({
    this.totalRecommendations = 0,
    this.viewedRecommendations = 0,
    this.acceptedRecommendations = 0,
    this.dismissedRecommendations = 0,
    this.completedRecommendations = 0,
    this.acceptanceRate = 0.0,
    this.completionRate = 0.0,
    this.avgTimeToAccept = 0.0,
    this.avgConfidence = 0.5,
  });

  factory _$RecommendationStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecommendationStatsImplFromJson(json);

  /// عدد التوصيات الكلي
  @override
  @JsonKey()
  final int totalRecommendations;

  /// عدد التوصيات المشاهدة
  @override
  @JsonKey()
  final int viewedRecommendations;

  /// عدد التوصيات المقبولة
  @override
  @JsonKey()
  final int acceptedRecommendations;

  /// عدد التوصيات المرفوضة
  @override
  @JsonKey()
  final int dismissedRecommendations;

  /// عدد التوصيات المكتملة
  @override
  @JsonKey()
  final int completedRecommendations;

  /// نسبة القبول (0-1)
  @override
  @JsonKey()
  final double acceptanceRate;

  /// نسبة الإتمام (0-1)
  @override
  @JsonKey()
  final double completionRate;

  /// متوسط وقت القبول (بالساعات)
  @override
  @JsonKey()
  final double avgTimeToAccept;

  /// متوسط درجة الثقة
  @override
  @JsonKey()
  final double avgConfidence;

  @override
  String toString() {
    return 'RecommendationStats(totalRecommendations: $totalRecommendations, viewedRecommendations: $viewedRecommendations, acceptedRecommendations: $acceptedRecommendations, dismissedRecommendations: $dismissedRecommendations, completedRecommendations: $completedRecommendations, acceptanceRate: $acceptanceRate, completionRate: $completionRate, avgTimeToAccept: $avgTimeToAccept, avgConfidence: $avgConfidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationStatsImpl &&
            (identical(other.totalRecommendations, totalRecommendations) ||
                other.totalRecommendations == totalRecommendations) &&
            (identical(other.viewedRecommendations, viewedRecommendations) ||
                other.viewedRecommendations == viewedRecommendations) &&
            (identical(
                  other.acceptedRecommendations,
                  acceptedRecommendations,
                ) ||
                other.acceptedRecommendations == acceptedRecommendations) &&
            (identical(
                  other.dismissedRecommendations,
                  dismissedRecommendations,
                ) ||
                other.dismissedRecommendations == dismissedRecommendations) &&
            (identical(
                  other.completedRecommendations,
                  completedRecommendations,
                ) ||
                other.completedRecommendations == completedRecommendations) &&
            (identical(other.acceptanceRate, acceptanceRate) ||
                other.acceptanceRate == acceptanceRate) &&
            (identical(other.completionRate, completionRate) ||
                other.completionRate == completionRate) &&
            (identical(other.avgTimeToAccept, avgTimeToAccept) ||
                other.avgTimeToAccept == avgTimeToAccept) &&
            (identical(other.avgConfidence, avgConfidence) ||
                other.avgConfidence == avgConfidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalRecommendations,
    viewedRecommendations,
    acceptedRecommendations,
    dismissedRecommendations,
    completedRecommendations,
    acceptanceRate,
    completionRate,
    avgTimeToAccept,
    avgConfidence,
  );

  /// Create a copy of RecommendationStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationStatsImplCopyWith<_$RecommendationStatsImpl> get copyWith =>
      __$$RecommendationStatsImplCopyWithImpl<_$RecommendationStatsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecommendationStatsImplToJson(this);
  }
}

abstract class _RecommendationStats implements RecommendationStats {
  const factory _RecommendationStats({
    final int totalRecommendations,
    final int viewedRecommendations,
    final int acceptedRecommendations,
    final int dismissedRecommendations,
    final int completedRecommendations,
    final double acceptanceRate,
    final double completionRate,
    final double avgTimeToAccept,
    final double avgConfidence,
  }) = _$RecommendationStatsImpl;

  factory _RecommendationStats.fromJson(Map<String, dynamic> json) =
      _$RecommendationStatsImpl.fromJson;

  /// عدد التوصيات الكلي
  @override
  int get totalRecommendations;

  /// عدد التوصيات المشاهدة
  @override
  int get viewedRecommendations;

  /// عدد التوصيات المقبولة
  @override
  int get acceptedRecommendations;

  /// عدد التوصيات المرفوضة
  @override
  int get dismissedRecommendations;

  /// عدد التوصيات المكتملة
  @override
  int get completedRecommendations;

  /// نسبة القبول (0-1)
  @override
  double get acceptanceRate;

  /// نسبة الإتمام (0-1)
  @override
  double get completionRate;

  /// متوسط وقت القبول (بالساعات)
  @override
  double get avgTimeToAccept;

  /// متوسط درجة الثقة
  @override
  double get avgConfidence;

  /// Create a copy of RecommendationStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendationStatsImplCopyWith<_$RecommendationStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
