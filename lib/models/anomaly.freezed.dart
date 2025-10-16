// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'anomaly.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AnomalyScore _$AnomalyScoreFromJson(Map<String, dynamic> json) {
  return _AnomalyScore.fromJson(json);
}

/// @nodoc
mixin _$AnomalyScore {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get institutionId => throw _privateConstructorUsedError;
  String? get companyId => throw _privateConstructorUsedError;

  /// معلومات الشذوذ
  AnomalyType get type => throw _privateConstructorUsedError;
  AnomalySeverity get severity => throw _privateConstructorUsedError;
  double get score =>
      throw _privateConstructorUsedError; // 0.0 - 1.0 (1.0 = شذوذ مؤكد)
  double get confidenceLevel =>
      throw _privateConstructorUsedError; // 0.0 - 1.0 (1.0 = ثقة عالية)
  /// البيانات المرتبطة
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  String? get relatedEntityId =>
      throw _privateConstructorUsedError; // معرف الدورة/الاختبار/الخ
  String? get relatedEntityType =>
      throw _privateConstructorUsedError; // course, quiz, etc.
  /// الوصف
  String get description => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  List<String> get evidencePoints => throw _privateConstructorUsedError;

  /// الحالة
  InvestigationStatus get status => throw _privateConstructorUsedError;
  bool get isReviewed => throw _privateConstructorUsedError;
  String? get reviewedBy => throw _privateConstructorUsedError;
  String? get reviewerName => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get reviewedAt => throw _privateConstructorUsedError;
  String? get reviewNotes => throw _privateConstructorUsedError;

  /// الإجراءات
  bool get actionTaken => throw _privateConstructorUsedError;
  String? get action =>
      throw _privateConstructorUsedError; // warning, suspend, etc.
  /// التوقيت
  @RequiredTimestampConverter()
  DateTime get detectedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get resolvedAt => throw _privateConstructorUsedError;

  /// Serializes this AnomalyScore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnomalyScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnomalyScoreCopyWith<AnomalyScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnomalyScoreCopyWith<$Res> {
  factory $AnomalyScoreCopyWith(
    AnomalyScore value,
    $Res Function(AnomalyScore) then,
  ) = _$AnomalyScoreCopyWithImpl<$Res, AnomalyScore>;
  @useResult
  $Res call({
    String id,
    String userId,
    String userName,
    String institutionId,
    String? companyId,
    AnomalyType type,
    AnomalySeverity severity,
    double score,
    double confidenceLevel,
    Map<String, dynamic> metadata,
    String? relatedEntityId,
    String? relatedEntityType,
    String description,
    String reason,
    List<String> evidencePoints,
    InvestigationStatus status,
    bool isReviewed,
    String? reviewedBy,
    String? reviewerName,
    @TimestampConverter() DateTime? reviewedAt,
    String? reviewNotes,
    bool actionTaken,
    String? action,
    @RequiredTimestampConverter() DateTime detectedAt,
    @TimestampConverter() DateTime? resolvedAt,
  });
}

/// @nodoc
class _$AnomalyScoreCopyWithImpl<$Res, $Val extends AnomalyScore>
    implements $AnomalyScoreCopyWith<$Res> {
  _$AnomalyScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnomalyScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? type = null,
    Object? severity = null,
    Object? score = null,
    Object? confidenceLevel = null,
    Object? metadata = null,
    Object? relatedEntityId = freezed,
    Object? relatedEntityType = freezed,
    Object? description = null,
    Object? reason = null,
    Object? evidencePoints = null,
    Object? status = null,
    Object? isReviewed = null,
    Object? reviewedBy = freezed,
    Object? reviewerName = freezed,
    Object? reviewedAt = freezed,
    Object? reviewNotes = freezed,
    Object? actionTaken = null,
    Object? action = freezed,
    Object? detectedAt = null,
    Object? resolvedAt = freezed,
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
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: freezed == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as AnomalyType,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as AnomalySeverity,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as double,
            confidenceLevel: null == confidenceLevel
                ? _value.confidenceLevel
                : confidenceLevel // ignore: cast_nullable_to_non_nullable
                      as double,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            relatedEntityId: freezed == relatedEntityId
                ? _value.relatedEntityId
                : relatedEntityId // ignore: cast_nullable_to_non_nullable
                      as String?,
            relatedEntityType: freezed == relatedEntityType
                ? _value.relatedEntityType
                : relatedEntityType // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            evidencePoints: null == evidencePoints
                ? _value.evidencePoints
                : evidencePoints // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as InvestigationStatus,
            isReviewed: null == isReviewed
                ? _value.isReviewed
                : isReviewed // ignore: cast_nullable_to_non_nullable
                      as bool,
            reviewedBy: freezed == reviewedBy
                ? _value.reviewedBy
                : reviewedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            reviewerName: freezed == reviewerName
                ? _value.reviewerName
                : reviewerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            reviewedAt: freezed == reviewedAt
                ? _value.reviewedAt
                : reviewedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            reviewNotes: freezed == reviewNotes
                ? _value.reviewNotes
                : reviewNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            actionTaken: null == actionTaken
                ? _value.actionTaken
                : actionTaken // ignore: cast_nullable_to_non_nullable
                      as bool,
            action: freezed == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as String?,
            detectedAt: null == detectedAt
                ? _value.detectedAt
                : detectedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            resolvedAt: freezed == resolvedAt
                ? _value.resolvedAt
                : resolvedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnomalyScoreImplCopyWith<$Res>
    implements $AnomalyScoreCopyWith<$Res> {
  factory _$$AnomalyScoreImplCopyWith(
    _$AnomalyScoreImpl value,
    $Res Function(_$AnomalyScoreImpl) then,
  ) = __$$AnomalyScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String userName,
    String institutionId,
    String? companyId,
    AnomalyType type,
    AnomalySeverity severity,
    double score,
    double confidenceLevel,
    Map<String, dynamic> metadata,
    String? relatedEntityId,
    String? relatedEntityType,
    String description,
    String reason,
    List<String> evidencePoints,
    InvestigationStatus status,
    bool isReviewed,
    String? reviewedBy,
    String? reviewerName,
    @TimestampConverter() DateTime? reviewedAt,
    String? reviewNotes,
    bool actionTaken,
    String? action,
    @RequiredTimestampConverter() DateTime detectedAt,
    @TimestampConverter() DateTime? resolvedAt,
  });
}

/// @nodoc
class __$$AnomalyScoreImplCopyWithImpl<$Res>
    extends _$AnomalyScoreCopyWithImpl<$Res, _$AnomalyScoreImpl>
    implements _$$AnomalyScoreImplCopyWith<$Res> {
  __$$AnomalyScoreImplCopyWithImpl(
    _$AnomalyScoreImpl _value,
    $Res Function(_$AnomalyScoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnomalyScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? type = null,
    Object? severity = null,
    Object? score = null,
    Object? confidenceLevel = null,
    Object? metadata = null,
    Object? relatedEntityId = freezed,
    Object? relatedEntityType = freezed,
    Object? description = null,
    Object? reason = null,
    Object? evidencePoints = null,
    Object? status = null,
    Object? isReviewed = null,
    Object? reviewedBy = freezed,
    Object? reviewerName = freezed,
    Object? reviewedAt = freezed,
    Object? reviewNotes = freezed,
    Object? actionTaken = null,
    Object? action = freezed,
    Object? detectedAt = null,
    Object? resolvedAt = freezed,
  }) {
    return _then(
      _$AnomalyScoreImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: freezed == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as AnomalyType,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as AnomalySeverity,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as double,
        confidenceLevel: null == confidenceLevel
            ? _value.confidenceLevel
            : confidenceLevel // ignore: cast_nullable_to_non_nullable
                  as double,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        relatedEntityId: freezed == relatedEntityId
            ? _value.relatedEntityId
            : relatedEntityId // ignore: cast_nullable_to_non_nullable
                  as String?,
        relatedEntityType: freezed == relatedEntityType
            ? _value.relatedEntityType
            : relatedEntityType // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        evidencePoints: null == evidencePoints
            ? _value._evidencePoints
            : evidencePoints // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as InvestigationStatus,
        isReviewed: null == isReviewed
            ? _value.isReviewed
            : isReviewed // ignore: cast_nullable_to_non_nullable
                  as bool,
        reviewedBy: freezed == reviewedBy
            ? _value.reviewedBy
            : reviewedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        reviewerName: freezed == reviewerName
            ? _value.reviewerName
            : reviewerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        reviewedAt: freezed == reviewedAt
            ? _value.reviewedAt
            : reviewedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        reviewNotes: freezed == reviewNotes
            ? _value.reviewNotes
            : reviewNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        actionTaken: null == actionTaken
            ? _value.actionTaken
            : actionTaken // ignore: cast_nullable_to_non_nullable
                  as bool,
        action: freezed == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as String?,
        detectedAt: null == detectedAt
            ? _value.detectedAt
            : detectedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        resolvedAt: freezed == resolvedAt
            ? _value.resolvedAt
            : resolvedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnomalyScoreImpl implements _AnomalyScore {
  const _$AnomalyScoreImpl({
    required this.id,
    required this.userId,
    required this.userName,
    required this.institutionId,
    this.companyId,
    required this.type,
    required this.severity,
    required this.score,
    required this.confidenceLevel,
    required final Map<String, dynamic> metadata,
    this.relatedEntityId,
    this.relatedEntityType,
    required this.description,
    required this.reason,
    final List<String> evidencePoints = const [],
    required this.status,
    this.isReviewed = false,
    this.reviewedBy,
    this.reviewerName,
    @TimestampConverter() this.reviewedAt,
    this.reviewNotes,
    this.actionTaken = false,
    this.action,
    @RequiredTimestampConverter() required this.detectedAt,
    @TimestampConverter() this.resolvedAt,
  }) : _metadata = metadata,
       _evidencePoints = evidencePoints;

  factory _$AnomalyScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnomalyScoreImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String userName;
  @override
  final String institutionId;
  @override
  final String? companyId;

  /// معلومات الشذوذ
  @override
  final AnomalyType type;
  @override
  final AnomalySeverity severity;
  @override
  final double score;
  // 0.0 - 1.0 (1.0 = شذوذ مؤكد)
  @override
  final double confidenceLevel;
  // 0.0 - 1.0 (1.0 = ثقة عالية)
  /// البيانات المرتبطة
  final Map<String, dynamic> _metadata;
  // 0.0 - 1.0 (1.0 = ثقة عالية)
  /// البيانات المرتبطة
  @override
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final String? relatedEntityId;
  // معرف الدورة/الاختبار/الخ
  @override
  final String? relatedEntityType;
  // course, quiz, etc.
  /// الوصف
  @override
  final String description;
  @override
  final String reason;
  final List<String> _evidencePoints;
  @override
  @JsonKey()
  List<String> get evidencePoints {
    if (_evidencePoints is EqualUnmodifiableListView) return _evidencePoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_evidencePoints);
  }

  /// الحالة
  @override
  final InvestigationStatus status;
  @override
  @JsonKey()
  final bool isReviewed;
  @override
  final String? reviewedBy;
  @override
  final String? reviewerName;
  @override
  @TimestampConverter()
  final DateTime? reviewedAt;
  @override
  final String? reviewNotes;

  /// الإجراءات
  @override
  @JsonKey()
  final bool actionTaken;
  @override
  final String? action;
  // warning, suspend, etc.
  /// التوقيت
  @override
  @RequiredTimestampConverter()
  final DateTime detectedAt;
  @override
  @TimestampConverter()
  final DateTime? resolvedAt;

  @override
  String toString() {
    return 'AnomalyScore(id: $id, userId: $userId, userName: $userName, institutionId: $institutionId, companyId: $companyId, type: $type, severity: $severity, score: $score, confidenceLevel: $confidenceLevel, metadata: $metadata, relatedEntityId: $relatedEntityId, relatedEntityType: $relatedEntityType, description: $description, reason: $reason, evidencePoints: $evidencePoints, status: $status, isReviewed: $isReviewed, reviewedBy: $reviewedBy, reviewerName: $reviewerName, reviewedAt: $reviewedAt, reviewNotes: $reviewNotes, actionTaken: $actionTaken, action: $action, detectedAt: $detectedAt, resolvedAt: $resolvedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnomalyScoreImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.confidenceLevel, confidenceLevel) ||
                other.confidenceLevel == confidenceLevel) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.relatedEntityId, relatedEntityId) ||
                other.relatedEntityId == relatedEntityId) &&
            (identical(other.relatedEntityType, relatedEntityType) ||
                other.relatedEntityType == relatedEntityType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            const DeepCollectionEquality().equals(
              other._evidencePoints,
              _evidencePoints,
            ) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isReviewed, isReviewed) ||
                other.isReviewed == isReviewed) &&
            (identical(other.reviewedBy, reviewedBy) ||
                other.reviewedBy == reviewedBy) &&
            (identical(other.reviewerName, reviewerName) ||
                other.reviewerName == reviewerName) &&
            (identical(other.reviewedAt, reviewedAt) ||
                other.reviewedAt == reviewedAt) &&
            (identical(other.reviewNotes, reviewNotes) ||
                other.reviewNotes == reviewNotes) &&
            (identical(other.actionTaken, actionTaken) ||
                other.actionTaken == actionTaken) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.detectedAt, detectedAt) ||
                other.detectedAt == detectedAt) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    userId,
    userName,
    institutionId,
    companyId,
    type,
    severity,
    score,
    confidenceLevel,
    const DeepCollectionEquality().hash(_metadata),
    relatedEntityId,
    relatedEntityType,
    description,
    reason,
    const DeepCollectionEquality().hash(_evidencePoints),
    status,
    isReviewed,
    reviewedBy,
    reviewerName,
    reviewedAt,
    reviewNotes,
    actionTaken,
    action,
    detectedAt,
    resolvedAt,
  ]);

  /// Create a copy of AnomalyScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnomalyScoreImplCopyWith<_$AnomalyScoreImpl> get copyWith =>
      __$$AnomalyScoreImplCopyWithImpl<_$AnomalyScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnomalyScoreImplToJson(this);
  }
}

abstract class _AnomalyScore implements AnomalyScore {
  const factory _AnomalyScore({
    required final String id,
    required final String userId,
    required final String userName,
    required final String institutionId,
    final String? companyId,
    required final AnomalyType type,
    required final AnomalySeverity severity,
    required final double score,
    required final double confidenceLevel,
    required final Map<String, dynamic> metadata,
    final String? relatedEntityId,
    final String? relatedEntityType,
    required final String description,
    required final String reason,
    final List<String> evidencePoints,
    required final InvestigationStatus status,
    final bool isReviewed,
    final String? reviewedBy,
    final String? reviewerName,
    @TimestampConverter() final DateTime? reviewedAt,
    final String? reviewNotes,
    final bool actionTaken,
    final String? action,
    @RequiredTimestampConverter() required final DateTime detectedAt,
    @TimestampConverter() final DateTime? resolvedAt,
  }) = _$AnomalyScoreImpl;

  factory _AnomalyScore.fromJson(Map<String, dynamic> json) =
      _$AnomalyScoreImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get userName;
  @override
  String get institutionId;
  @override
  String? get companyId;

  /// معلومات الشذوذ
  @override
  AnomalyType get type;
  @override
  AnomalySeverity get severity;
  @override
  double get score; // 0.0 - 1.0 (1.0 = شذوذ مؤكد)
  @override
  double get confidenceLevel; // 0.0 - 1.0 (1.0 = ثقة عالية)
  /// البيانات المرتبطة
  @override
  Map<String, dynamic> get metadata;
  @override
  String? get relatedEntityId; // معرف الدورة/الاختبار/الخ
  @override
  String? get relatedEntityType; // course, quiz, etc.
  /// الوصف
  @override
  String get description;
  @override
  String get reason;
  @override
  List<String> get evidencePoints;

  /// الحالة
  @override
  InvestigationStatus get status;
  @override
  bool get isReviewed;
  @override
  String? get reviewedBy;
  @override
  String? get reviewerName;
  @override
  @TimestampConverter()
  DateTime? get reviewedAt;
  @override
  String? get reviewNotes;

  /// الإجراءات
  @override
  bool get actionTaken;
  @override
  String? get action; // warning, suspend, etc.
  /// التوقيت
  @override
  @RequiredTimestampConverter()
  DateTime get detectedAt;
  @override
  @TimestampConverter()
  DateTime? get resolvedAt;

  /// Create a copy of AnomalyScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnomalyScoreImplCopyWith<_$AnomalyScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnomalyAlert _$AnomalyAlertFromJson(Map<String, dynamic> json) {
  return _AnomalyAlert.fromJson(json);
}

/// @nodoc
mixin _$AnomalyAlert {
  String get id => throw _privateConstructorUsedError;
  String get anomalyId =>
      throw _privateConstructorUsedError; // مرجع AnomalyScore
  String get institutionId => throw _privateConstructorUsedError;
  String? get companyId => throw _privateConstructorUsedError;

  /// معلومات التنبيه
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  AnomalySeverity get severity => throw _privateConstructorUsedError;

  /// المستلمون
  List<String> get recipientIds => throw _privateConstructorUsedError;
  List<String> get readBy => throw _privateConstructorUsedError;

  /// الحالة
  bool get isRead => throw _privateConstructorUsedError;
  bool get isDismissed => throw _privateConstructorUsedError;
  String? get dismissedBy => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get dismissedAt => throw _privateConstructorUsedError;

  /// التوقيت
  @RequiredTimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this AnomalyAlert to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnomalyAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnomalyAlertCopyWith<AnomalyAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnomalyAlertCopyWith<$Res> {
  factory $AnomalyAlertCopyWith(
    AnomalyAlert value,
    $Res Function(AnomalyAlert) then,
  ) = _$AnomalyAlertCopyWithImpl<$Res, AnomalyAlert>;
  @useResult
  $Res call({
    String id,
    String anomalyId,
    String institutionId,
    String? companyId,
    String title,
    String message,
    AnomalySeverity severity,
    List<String> recipientIds,
    List<String> readBy,
    bool isRead,
    bool isDismissed,
    String? dismissedBy,
    @TimestampConverter() DateTime? dismissedAt,
    @RequiredTimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime? expiresAt,
  });
}

/// @nodoc
class _$AnomalyAlertCopyWithImpl<$Res, $Val extends AnomalyAlert>
    implements $AnomalyAlertCopyWith<$Res> {
  _$AnomalyAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnomalyAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? anomalyId = null,
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? title = null,
    Object? message = null,
    Object? severity = null,
    Object? recipientIds = null,
    Object? readBy = null,
    Object? isRead = null,
    Object? isDismissed = null,
    Object? dismissedBy = freezed,
    Object? dismissedAt = freezed,
    Object? createdAt = null,
    Object? expiresAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            anomalyId: null == anomalyId
                ? _value.anomalyId
                : anomalyId // ignore: cast_nullable_to_non_nullable
                      as String,
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: freezed == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as AnomalySeverity,
            recipientIds: null == recipientIds
                ? _value.recipientIds
                : recipientIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            readBy: null == readBy
                ? _value.readBy
                : readBy // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            isDismissed: null == isDismissed
                ? _value.isDismissed
                : isDismissed // ignore: cast_nullable_to_non_nullable
                      as bool,
            dismissedBy: freezed == dismissedBy
                ? _value.dismissedBy
                : dismissedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            dismissedAt: freezed == dismissedAt
                ? _value.dismissedAt
                : dismissedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnomalyAlertImplCopyWith<$Res>
    implements $AnomalyAlertCopyWith<$Res> {
  factory _$$AnomalyAlertImplCopyWith(
    _$AnomalyAlertImpl value,
    $Res Function(_$AnomalyAlertImpl) then,
  ) = __$$AnomalyAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String anomalyId,
    String institutionId,
    String? companyId,
    String title,
    String message,
    AnomalySeverity severity,
    List<String> recipientIds,
    List<String> readBy,
    bool isRead,
    bool isDismissed,
    String? dismissedBy,
    @TimestampConverter() DateTime? dismissedAt,
    @RequiredTimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime? expiresAt,
  });
}

/// @nodoc
class __$$AnomalyAlertImplCopyWithImpl<$Res>
    extends _$AnomalyAlertCopyWithImpl<$Res, _$AnomalyAlertImpl>
    implements _$$AnomalyAlertImplCopyWith<$Res> {
  __$$AnomalyAlertImplCopyWithImpl(
    _$AnomalyAlertImpl _value,
    $Res Function(_$AnomalyAlertImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnomalyAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? anomalyId = null,
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? title = null,
    Object? message = null,
    Object? severity = null,
    Object? recipientIds = null,
    Object? readBy = null,
    Object? isRead = null,
    Object? isDismissed = null,
    Object? dismissedBy = freezed,
    Object? dismissedAt = freezed,
    Object? createdAt = null,
    Object? expiresAt = freezed,
  }) {
    return _then(
      _$AnomalyAlertImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        anomalyId: null == anomalyId
            ? _value.anomalyId
            : anomalyId // ignore: cast_nullable_to_non_nullable
                  as String,
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: freezed == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as AnomalySeverity,
        recipientIds: null == recipientIds
            ? _value._recipientIds
            : recipientIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        readBy: null == readBy
            ? _value._readBy
            : readBy // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDismissed: null == isDismissed
            ? _value.isDismissed
            : isDismissed // ignore: cast_nullable_to_non_nullable
                  as bool,
        dismissedBy: freezed == dismissedBy
            ? _value.dismissedBy
            : dismissedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        dismissedAt: freezed == dismissedAt
            ? _value.dismissedAt
            : dismissedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnomalyAlertImpl implements _AnomalyAlert {
  const _$AnomalyAlertImpl({
    required this.id,
    required this.anomalyId,
    required this.institutionId,
    this.companyId,
    required this.title,
    required this.message,
    required this.severity,
    required final List<String> recipientIds,
    final List<String> readBy = const [],
    required this.isRead,
    required this.isDismissed,
    this.dismissedBy,
    @TimestampConverter() this.dismissedAt,
    @RequiredTimestampConverter() required this.createdAt,
    @TimestampConverter() this.expiresAt,
  }) : _recipientIds = recipientIds,
       _readBy = readBy;

  factory _$AnomalyAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnomalyAlertImplFromJson(json);

  @override
  final String id;
  @override
  final String anomalyId;
  // مرجع AnomalyScore
  @override
  final String institutionId;
  @override
  final String? companyId;

  /// معلومات التنبيه
  @override
  final String title;
  @override
  final String message;
  @override
  final AnomalySeverity severity;

  /// المستلمون
  final List<String> _recipientIds;

  /// المستلمون
  @override
  List<String> get recipientIds {
    if (_recipientIds is EqualUnmodifiableListView) return _recipientIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipientIds);
  }

  final List<String> _readBy;
  @override
  @JsonKey()
  List<String> get readBy {
    if (_readBy is EqualUnmodifiableListView) return _readBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_readBy);
  }

  /// الحالة
  @override
  final bool isRead;
  @override
  final bool isDismissed;
  @override
  final String? dismissedBy;
  @override
  @TimestampConverter()
  final DateTime? dismissedAt;

  /// التوقيت
  @override
  @RequiredTimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'AnomalyAlert(id: $id, anomalyId: $anomalyId, institutionId: $institutionId, companyId: $companyId, title: $title, message: $message, severity: $severity, recipientIds: $recipientIds, readBy: $readBy, isRead: $isRead, isDismissed: $isDismissed, dismissedBy: $dismissedBy, dismissedAt: $dismissedAt, createdAt: $createdAt, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnomalyAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.anomalyId, anomalyId) ||
                other.anomalyId == anomalyId) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            const DeepCollectionEquality().equals(
              other._recipientIds,
              _recipientIds,
            ) &&
            const DeepCollectionEquality().equals(other._readBy, _readBy) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isDismissed, isDismissed) ||
                other.isDismissed == isDismissed) &&
            (identical(other.dismissedBy, dismissedBy) ||
                other.dismissedBy == dismissedBy) &&
            (identical(other.dismissedAt, dismissedAt) ||
                other.dismissedAt == dismissedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    anomalyId,
    institutionId,
    companyId,
    title,
    message,
    severity,
    const DeepCollectionEquality().hash(_recipientIds),
    const DeepCollectionEquality().hash(_readBy),
    isRead,
    isDismissed,
    dismissedBy,
    dismissedAt,
    createdAt,
    expiresAt,
  );

  /// Create a copy of AnomalyAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnomalyAlertImplCopyWith<_$AnomalyAlertImpl> get copyWith =>
      __$$AnomalyAlertImplCopyWithImpl<_$AnomalyAlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnomalyAlertImplToJson(this);
  }
}

abstract class _AnomalyAlert implements AnomalyAlert {
  const factory _AnomalyAlert({
    required final String id,
    required final String anomalyId,
    required final String institutionId,
    final String? companyId,
    required final String title,
    required final String message,
    required final AnomalySeverity severity,
    required final List<String> recipientIds,
    final List<String> readBy,
    required final bool isRead,
    required final bool isDismissed,
    final String? dismissedBy,
    @TimestampConverter() final DateTime? dismissedAt,
    @RequiredTimestampConverter() required final DateTime createdAt,
    @TimestampConverter() final DateTime? expiresAt,
  }) = _$AnomalyAlertImpl;

  factory _AnomalyAlert.fromJson(Map<String, dynamic> json) =
      _$AnomalyAlertImpl.fromJson;

  @override
  String get id;
  @override
  String get anomalyId; // مرجع AnomalyScore
  @override
  String get institutionId;
  @override
  String? get companyId;

  /// معلومات التنبيه
  @override
  String get title;
  @override
  String get message;
  @override
  AnomalySeverity get severity;

  /// المستلمون
  @override
  List<String> get recipientIds;
  @override
  List<String> get readBy;

  /// الحالة
  @override
  bool get isRead;
  @override
  bool get isDismissed;
  @override
  String? get dismissedBy;
  @override
  @TimestampConverter()
  DateTime? get dismissedAt;

  /// التوقيت
  @override
  @RequiredTimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime? get expiresAt;

  /// Create a copy of AnomalyAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnomalyAlertImplCopyWith<_$AnomalyAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnomalyDetectionSettings _$AnomalyDetectionSettingsFromJson(
  Map<String, dynamic> json,
) {
  return _AnomalyDetectionSettings.fromJson(json);
}

/// @nodoc
mixin _$AnomalyDetectionSettings {
  String get id => throw _privateConstructorUsedError;
  String get institutionId => throw _privateConstructorUsedError;
  String? get companyId => throw _privateConstructorUsedError;

  /// التفعيل
  bool get isEnabled => throw _privateConstructorUsedError;
  List<AnomalyType> get enabledTypes => throw _privateConstructorUsedError;

  /// الحساسية (0.0 - 1.0)
  double get sensitivityLevel => throw _privateConstructorUsedError;

  /// الحدود
  double get rapidProgressThreshold =>
      throw _privateConstructorUsedError; // ساعات
  double get unusualScoreThreshold =>
      throw _privateConstructorUsedError; // النسبة المئوية
  int get multipleDevicesThreshold =>
      throw _privateConstructorUsedError; // عدد الأجهزة
  int get unusualActivityThreshold =>
      throw _privateConstructorUsedError; // عدد الأحداث/ساعة
  /// الإشعارات
  bool get sendAlerts => throw _privateConstructorUsedError;
  List<String> get alertRecipients =>
      throw _privateConstructorUsedError; // معرفات المستخدمين
  AnomalySeverity get minAlertSeverity => throw _privateConstructorUsedError;

  /// الإجراءات التلقائية
  bool get autoSuspendCritical => throw _privateConstructorUsedError;
  bool get autoFlagCheating => throw _privateConstructorUsedError;

  /// التحديث
  @RequiredTimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String get updatedBy => throw _privateConstructorUsedError;

  /// Serializes this AnomalyDetectionSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnomalyDetectionSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnomalyDetectionSettingsCopyWith<AnomalyDetectionSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnomalyDetectionSettingsCopyWith<$Res> {
  factory $AnomalyDetectionSettingsCopyWith(
    AnomalyDetectionSettings value,
    $Res Function(AnomalyDetectionSettings) then,
  ) = _$AnomalyDetectionSettingsCopyWithImpl<$Res, AnomalyDetectionSettings>;
  @useResult
  $Res call({
    String id,
    String institutionId,
    String? companyId,
    bool isEnabled,
    List<AnomalyType> enabledTypes,
    double sensitivityLevel,
    double rapidProgressThreshold,
    double unusualScoreThreshold,
    int multipleDevicesThreshold,
    int unusualActivityThreshold,
    bool sendAlerts,
    List<String> alertRecipients,
    AnomalySeverity minAlertSeverity,
    bool autoSuspendCritical,
    bool autoFlagCheating,
    @RequiredTimestampConverter() DateTime updatedAt,
    String updatedBy,
  });
}

/// @nodoc
class _$AnomalyDetectionSettingsCopyWithImpl<
  $Res,
  $Val extends AnomalyDetectionSettings
>
    implements $AnomalyDetectionSettingsCopyWith<$Res> {
  _$AnomalyDetectionSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnomalyDetectionSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? isEnabled = null,
    Object? enabledTypes = null,
    Object? sensitivityLevel = null,
    Object? rapidProgressThreshold = null,
    Object? unusualScoreThreshold = null,
    Object? multipleDevicesThreshold = null,
    Object? unusualActivityThreshold = null,
    Object? sendAlerts = null,
    Object? alertRecipients = null,
    Object? minAlertSeverity = null,
    Object? autoSuspendCritical = null,
    Object? autoFlagCheating = null,
    Object? updatedAt = null,
    Object? updatedBy = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: freezed == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String?,
            isEnabled: null == isEnabled
                ? _value.isEnabled
                : isEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            enabledTypes: null == enabledTypes
                ? _value.enabledTypes
                : enabledTypes // ignore: cast_nullable_to_non_nullable
                      as List<AnomalyType>,
            sensitivityLevel: null == sensitivityLevel
                ? _value.sensitivityLevel
                : sensitivityLevel // ignore: cast_nullable_to_non_nullable
                      as double,
            rapidProgressThreshold: null == rapidProgressThreshold
                ? _value.rapidProgressThreshold
                : rapidProgressThreshold // ignore: cast_nullable_to_non_nullable
                      as double,
            unusualScoreThreshold: null == unusualScoreThreshold
                ? _value.unusualScoreThreshold
                : unusualScoreThreshold // ignore: cast_nullable_to_non_nullable
                      as double,
            multipleDevicesThreshold: null == multipleDevicesThreshold
                ? _value.multipleDevicesThreshold
                : multipleDevicesThreshold // ignore: cast_nullable_to_non_nullable
                      as int,
            unusualActivityThreshold: null == unusualActivityThreshold
                ? _value.unusualActivityThreshold
                : unusualActivityThreshold // ignore: cast_nullable_to_non_nullable
                      as int,
            sendAlerts: null == sendAlerts
                ? _value.sendAlerts
                : sendAlerts // ignore: cast_nullable_to_non_nullable
                      as bool,
            alertRecipients: null == alertRecipients
                ? _value.alertRecipients
                : alertRecipients // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            minAlertSeverity: null == minAlertSeverity
                ? _value.minAlertSeverity
                : minAlertSeverity // ignore: cast_nullable_to_non_nullable
                      as AnomalySeverity,
            autoSuspendCritical: null == autoSuspendCritical
                ? _value.autoSuspendCritical
                : autoSuspendCritical // ignore: cast_nullable_to_non_nullable
                      as bool,
            autoFlagCheating: null == autoFlagCheating
                ? _value.autoFlagCheating
                : autoFlagCheating // ignore: cast_nullable_to_non_nullable
                      as bool,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedBy: null == updatedBy
                ? _value.updatedBy
                : updatedBy // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnomalyDetectionSettingsImplCopyWith<$Res>
    implements $AnomalyDetectionSettingsCopyWith<$Res> {
  factory _$$AnomalyDetectionSettingsImplCopyWith(
    _$AnomalyDetectionSettingsImpl value,
    $Res Function(_$AnomalyDetectionSettingsImpl) then,
  ) = __$$AnomalyDetectionSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String institutionId,
    String? companyId,
    bool isEnabled,
    List<AnomalyType> enabledTypes,
    double sensitivityLevel,
    double rapidProgressThreshold,
    double unusualScoreThreshold,
    int multipleDevicesThreshold,
    int unusualActivityThreshold,
    bool sendAlerts,
    List<String> alertRecipients,
    AnomalySeverity minAlertSeverity,
    bool autoSuspendCritical,
    bool autoFlagCheating,
    @RequiredTimestampConverter() DateTime updatedAt,
    String updatedBy,
  });
}

/// @nodoc
class __$$AnomalyDetectionSettingsImplCopyWithImpl<$Res>
    extends
        _$AnomalyDetectionSettingsCopyWithImpl<
          $Res,
          _$AnomalyDetectionSettingsImpl
        >
    implements _$$AnomalyDetectionSettingsImplCopyWith<$Res> {
  __$$AnomalyDetectionSettingsImplCopyWithImpl(
    _$AnomalyDetectionSettingsImpl _value,
    $Res Function(_$AnomalyDetectionSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnomalyDetectionSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? isEnabled = null,
    Object? enabledTypes = null,
    Object? sensitivityLevel = null,
    Object? rapidProgressThreshold = null,
    Object? unusualScoreThreshold = null,
    Object? multipleDevicesThreshold = null,
    Object? unusualActivityThreshold = null,
    Object? sendAlerts = null,
    Object? alertRecipients = null,
    Object? minAlertSeverity = null,
    Object? autoSuspendCritical = null,
    Object? autoFlagCheating = null,
    Object? updatedAt = null,
    Object? updatedBy = null,
  }) {
    return _then(
      _$AnomalyDetectionSettingsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: freezed == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isEnabled: null == isEnabled
            ? _value.isEnabled
            : isEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        enabledTypes: null == enabledTypes
            ? _value._enabledTypes
            : enabledTypes // ignore: cast_nullable_to_non_nullable
                  as List<AnomalyType>,
        sensitivityLevel: null == sensitivityLevel
            ? _value.sensitivityLevel
            : sensitivityLevel // ignore: cast_nullable_to_non_nullable
                  as double,
        rapidProgressThreshold: null == rapidProgressThreshold
            ? _value.rapidProgressThreshold
            : rapidProgressThreshold // ignore: cast_nullable_to_non_nullable
                  as double,
        unusualScoreThreshold: null == unusualScoreThreshold
            ? _value.unusualScoreThreshold
            : unusualScoreThreshold // ignore: cast_nullable_to_non_nullable
                  as double,
        multipleDevicesThreshold: null == multipleDevicesThreshold
            ? _value.multipleDevicesThreshold
            : multipleDevicesThreshold // ignore: cast_nullable_to_non_nullable
                  as int,
        unusualActivityThreshold: null == unusualActivityThreshold
            ? _value.unusualActivityThreshold
            : unusualActivityThreshold // ignore: cast_nullable_to_non_nullable
                  as int,
        sendAlerts: null == sendAlerts
            ? _value.sendAlerts
            : sendAlerts // ignore: cast_nullable_to_non_nullable
                  as bool,
        alertRecipients: null == alertRecipients
            ? _value._alertRecipients
            : alertRecipients // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        minAlertSeverity: null == minAlertSeverity
            ? _value.minAlertSeverity
            : minAlertSeverity // ignore: cast_nullable_to_non_nullable
                  as AnomalySeverity,
        autoSuspendCritical: null == autoSuspendCritical
            ? _value.autoSuspendCritical
            : autoSuspendCritical // ignore: cast_nullable_to_non_nullable
                  as bool,
        autoFlagCheating: null == autoFlagCheating
            ? _value.autoFlagCheating
            : autoFlagCheating // ignore: cast_nullable_to_non_nullable
                  as bool,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedBy: null == updatedBy
            ? _value.updatedBy
            : updatedBy // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnomalyDetectionSettingsImpl implements _AnomalyDetectionSettings {
  const _$AnomalyDetectionSettingsImpl({
    required this.id,
    required this.institutionId,
    this.companyId,
    required this.isEnabled,
    final List<AnomalyType> enabledTypes = const [],
    this.sensitivityLevel = 0.7,
    this.rapidProgressThreshold = 3.0,
    this.unusualScoreThreshold = 0.95,
    this.multipleDevicesThreshold = 5,
    this.unusualActivityThreshold = 100,
    required this.sendAlerts,
    final List<String> alertRecipients = const [],
    this.minAlertSeverity = AnomalySeverity.medium,
    required this.autoSuspendCritical,
    required this.autoFlagCheating,
    @RequiredTimestampConverter() required this.updatedAt,
    required this.updatedBy,
  }) : _enabledTypes = enabledTypes,
       _alertRecipients = alertRecipients;

  factory _$AnomalyDetectionSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnomalyDetectionSettingsImplFromJson(json);

  @override
  final String id;
  @override
  final String institutionId;
  @override
  final String? companyId;

  /// التفعيل
  @override
  final bool isEnabled;
  final List<AnomalyType> _enabledTypes;
  @override
  @JsonKey()
  List<AnomalyType> get enabledTypes {
    if (_enabledTypes is EqualUnmodifiableListView) return _enabledTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_enabledTypes);
  }

  /// الحساسية (0.0 - 1.0)
  @override
  @JsonKey()
  final double sensitivityLevel;

  /// الحدود
  @override
  @JsonKey()
  final double rapidProgressThreshold;
  // ساعات
  @override
  @JsonKey()
  final double unusualScoreThreshold;
  // النسبة المئوية
  @override
  @JsonKey()
  final int multipleDevicesThreshold;
  // عدد الأجهزة
  @override
  @JsonKey()
  final int unusualActivityThreshold;
  // عدد الأحداث/ساعة
  /// الإشعارات
  @override
  final bool sendAlerts;
  final List<String> _alertRecipients;
  @override
  @JsonKey()
  List<String> get alertRecipients {
    if (_alertRecipients is EqualUnmodifiableListView) return _alertRecipients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alertRecipients);
  }

  // معرفات المستخدمين
  @override
  @JsonKey()
  final AnomalySeverity minAlertSeverity;

  /// الإجراءات التلقائية
  @override
  final bool autoSuspendCritical;
  @override
  final bool autoFlagCheating;

  /// التحديث
  @override
  @RequiredTimestampConverter()
  final DateTime updatedAt;
  @override
  final String updatedBy;

  @override
  String toString() {
    return 'AnomalyDetectionSettings(id: $id, institutionId: $institutionId, companyId: $companyId, isEnabled: $isEnabled, enabledTypes: $enabledTypes, sensitivityLevel: $sensitivityLevel, rapidProgressThreshold: $rapidProgressThreshold, unusualScoreThreshold: $unusualScoreThreshold, multipleDevicesThreshold: $multipleDevicesThreshold, unusualActivityThreshold: $unusualActivityThreshold, sendAlerts: $sendAlerts, alertRecipients: $alertRecipients, minAlertSeverity: $minAlertSeverity, autoSuspendCritical: $autoSuspendCritical, autoFlagCheating: $autoFlagCheating, updatedAt: $updatedAt, updatedBy: $updatedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnomalyDetectionSettingsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            const DeepCollectionEquality().equals(
              other._enabledTypes,
              _enabledTypes,
            ) &&
            (identical(other.sensitivityLevel, sensitivityLevel) ||
                other.sensitivityLevel == sensitivityLevel) &&
            (identical(other.rapidProgressThreshold, rapidProgressThreshold) ||
                other.rapidProgressThreshold == rapidProgressThreshold) &&
            (identical(other.unusualScoreThreshold, unusualScoreThreshold) ||
                other.unusualScoreThreshold == unusualScoreThreshold) &&
            (identical(
                  other.multipleDevicesThreshold,
                  multipleDevicesThreshold,
                ) ||
                other.multipleDevicesThreshold == multipleDevicesThreshold) &&
            (identical(
                  other.unusualActivityThreshold,
                  unusualActivityThreshold,
                ) ||
                other.unusualActivityThreshold == unusualActivityThreshold) &&
            (identical(other.sendAlerts, sendAlerts) ||
                other.sendAlerts == sendAlerts) &&
            const DeepCollectionEquality().equals(
              other._alertRecipients,
              _alertRecipients,
            ) &&
            (identical(other.minAlertSeverity, minAlertSeverity) ||
                other.minAlertSeverity == minAlertSeverity) &&
            (identical(other.autoSuspendCritical, autoSuspendCritical) ||
                other.autoSuspendCritical == autoSuspendCritical) &&
            (identical(other.autoFlagCheating, autoFlagCheating) ||
                other.autoFlagCheating == autoFlagCheating) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    institutionId,
    companyId,
    isEnabled,
    const DeepCollectionEquality().hash(_enabledTypes),
    sensitivityLevel,
    rapidProgressThreshold,
    unusualScoreThreshold,
    multipleDevicesThreshold,
    unusualActivityThreshold,
    sendAlerts,
    const DeepCollectionEquality().hash(_alertRecipients),
    minAlertSeverity,
    autoSuspendCritical,
    autoFlagCheating,
    updatedAt,
    updatedBy,
  );

  /// Create a copy of AnomalyDetectionSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnomalyDetectionSettingsImplCopyWith<_$AnomalyDetectionSettingsImpl>
  get copyWith =>
      __$$AnomalyDetectionSettingsImplCopyWithImpl<
        _$AnomalyDetectionSettingsImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnomalyDetectionSettingsImplToJson(this);
  }
}

abstract class _AnomalyDetectionSettings implements AnomalyDetectionSettings {
  const factory _AnomalyDetectionSettings({
    required final String id,
    required final String institutionId,
    final String? companyId,
    required final bool isEnabled,
    final List<AnomalyType> enabledTypes,
    final double sensitivityLevel,
    final double rapidProgressThreshold,
    final double unusualScoreThreshold,
    final int multipleDevicesThreshold,
    final int unusualActivityThreshold,
    required final bool sendAlerts,
    final List<String> alertRecipients,
    final AnomalySeverity minAlertSeverity,
    required final bool autoSuspendCritical,
    required final bool autoFlagCheating,
    @RequiredTimestampConverter() required final DateTime updatedAt,
    required final String updatedBy,
  }) = _$AnomalyDetectionSettingsImpl;

  factory _AnomalyDetectionSettings.fromJson(Map<String, dynamic> json) =
      _$AnomalyDetectionSettingsImpl.fromJson;

  @override
  String get id;
  @override
  String get institutionId;
  @override
  String? get companyId;

  /// التفعيل
  @override
  bool get isEnabled;
  @override
  List<AnomalyType> get enabledTypes;

  /// الحساسية (0.0 - 1.0)
  @override
  double get sensitivityLevel;

  /// الحدود
  @override
  double get rapidProgressThreshold; // ساعات
  @override
  double get unusualScoreThreshold; // النسبة المئوية
  @override
  int get multipleDevicesThreshold; // عدد الأجهزة
  @override
  int get unusualActivityThreshold; // عدد الأحداث/ساعة
  /// الإشعارات
  @override
  bool get sendAlerts;
  @override
  List<String> get alertRecipients; // معرفات المستخدمين
  @override
  AnomalySeverity get minAlertSeverity;

  /// الإجراءات التلقائية
  @override
  bool get autoSuspendCritical;
  @override
  bool get autoFlagCheating;

  /// التحديث
  @override
  @RequiredTimestampConverter()
  DateTime get updatedAt;
  @override
  String get updatedBy;

  /// Create a copy of AnomalyDetectionSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnomalyDetectionSettingsImplCopyWith<_$AnomalyDetectionSettingsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AnomalyDetectionModel _$AnomalyDetectionModelFromJson(
  Map<String, dynamic> json,
) {
  return _AnomalyDetectionModel.fromJson(json);
}

/// @nodoc
mixin _$AnomalyDetectionModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  AnomalyType get type => throw _privateConstructorUsedError;

  /// معلومات النموذج
  String get version => throw _privateConstructorUsedError;
  String get modelPath =>
      throw _privateConstructorUsedError; // مسار ملف .tflite
  double get accuracy => throw _privateConstructorUsedError;
  double get precision => throw _privateConstructorUsedError;
  double get recall => throw _privateConstructorUsedError;

  /// التدريب
  int get trainingDataSize => throw _privateConstructorUsedError;
  @RequiredTimestampConverter()
  DateTime get trainedAt => throw _privateConstructorUsedError;
  String? get trainedBy => throw _privateConstructorUsedError;

  /// الحالة
  bool get isActive => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastUsedAt => throw _privateConstructorUsedError;

  /// البيانات الوصفية
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this AnomalyDetectionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnomalyDetectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnomalyDetectionModelCopyWith<AnomalyDetectionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnomalyDetectionModelCopyWith<$Res> {
  factory $AnomalyDetectionModelCopyWith(
    AnomalyDetectionModel value,
    $Res Function(AnomalyDetectionModel) then,
  ) = _$AnomalyDetectionModelCopyWithImpl<$Res, AnomalyDetectionModel>;
  @useResult
  $Res call({
    String id,
    String name,
    AnomalyType type,
    String version,
    String modelPath,
    double accuracy,
    double precision,
    double recall,
    int trainingDataSize,
    @RequiredTimestampConverter() DateTime trainedAt,
    String? trainedBy,
    bool isActive,
    @TimestampConverter() DateTime? lastUsedAt,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class _$AnomalyDetectionModelCopyWithImpl<
  $Res,
  $Val extends AnomalyDetectionModel
>
    implements $AnomalyDetectionModelCopyWith<$Res> {
  _$AnomalyDetectionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnomalyDetectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? version = null,
    Object? modelPath = null,
    Object? accuracy = null,
    Object? precision = null,
    Object? recall = null,
    Object? trainingDataSize = null,
    Object? trainedAt = null,
    Object? trainedBy = freezed,
    Object? isActive = null,
    Object? lastUsedAt = freezed,
    Object? metadata = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as AnomalyType,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as String,
            modelPath: null == modelPath
                ? _value.modelPath
                : modelPath // ignore: cast_nullable_to_non_nullable
                      as String,
            accuracy: null == accuracy
                ? _value.accuracy
                : accuracy // ignore: cast_nullable_to_non_nullable
                      as double,
            precision: null == precision
                ? _value.precision
                : precision // ignore: cast_nullable_to_non_nullable
                      as double,
            recall: null == recall
                ? _value.recall
                : recall // ignore: cast_nullable_to_non_nullable
                      as double,
            trainingDataSize: null == trainingDataSize
                ? _value.trainingDataSize
                : trainingDataSize // ignore: cast_nullable_to_non_nullable
                      as int,
            trainedAt: null == trainedAt
                ? _value.trainedAt
                : trainedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            trainedBy: freezed == trainedBy
                ? _value.trainedBy
                : trainedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastUsedAt: freezed == lastUsedAt
                ? _value.lastUsedAt
                : lastUsedAt // ignore: cast_nullable_to_non_nullable
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
abstract class _$$AnomalyDetectionModelImplCopyWith<$Res>
    implements $AnomalyDetectionModelCopyWith<$Res> {
  factory _$$AnomalyDetectionModelImplCopyWith(
    _$AnomalyDetectionModelImpl value,
    $Res Function(_$AnomalyDetectionModelImpl) then,
  ) = __$$AnomalyDetectionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    AnomalyType type,
    String version,
    String modelPath,
    double accuracy,
    double precision,
    double recall,
    int trainingDataSize,
    @RequiredTimestampConverter() DateTime trainedAt,
    String? trainedBy,
    bool isActive,
    @TimestampConverter() DateTime? lastUsedAt,
    Map<String, dynamic> metadata,
  });
}

/// @nodoc
class __$$AnomalyDetectionModelImplCopyWithImpl<$Res>
    extends
        _$AnomalyDetectionModelCopyWithImpl<$Res, _$AnomalyDetectionModelImpl>
    implements _$$AnomalyDetectionModelImplCopyWith<$Res> {
  __$$AnomalyDetectionModelImplCopyWithImpl(
    _$AnomalyDetectionModelImpl _value,
    $Res Function(_$AnomalyDetectionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnomalyDetectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? version = null,
    Object? modelPath = null,
    Object? accuracy = null,
    Object? precision = null,
    Object? recall = null,
    Object? trainingDataSize = null,
    Object? trainedAt = null,
    Object? trainedBy = freezed,
    Object? isActive = null,
    Object? lastUsedAt = freezed,
    Object? metadata = null,
  }) {
    return _then(
      _$AnomalyDetectionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as AnomalyType,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as String,
        modelPath: null == modelPath
            ? _value.modelPath
            : modelPath // ignore: cast_nullable_to_non_nullable
                  as String,
        accuracy: null == accuracy
            ? _value.accuracy
            : accuracy // ignore: cast_nullable_to_non_nullable
                  as double,
        precision: null == precision
            ? _value.precision
            : precision // ignore: cast_nullable_to_non_nullable
                  as double,
        recall: null == recall
            ? _value.recall
            : recall // ignore: cast_nullable_to_non_nullable
                  as double,
        trainingDataSize: null == trainingDataSize
            ? _value.trainingDataSize
            : trainingDataSize // ignore: cast_nullable_to_non_nullable
                  as int,
        trainedAt: null == trainedAt
            ? _value.trainedAt
            : trainedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        trainedBy: freezed == trainedBy
            ? _value.trainedBy
            : trainedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastUsedAt: freezed == lastUsedAt
            ? _value.lastUsedAt
            : lastUsedAt // ignore: cast_nullable_to_non_nullable
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
class _$AnomalyDetectionModelImpl implements _AnomalyDetectionModel {
  const _$AnomalyDetectionModelImpl({
    required this.id,
    required this.name,
    required this.type,
    required this.version,
    required this.modelPath,
    this.accuracy = 0.0,
    this.precision = 0.0,
    this.recall = 0.0,
    required this.trainingDataSize,
    @RequiredTimestampConverter() required this.trainedAt,
    this.trainedBy,
    required this.isActive,
    @TimestampConverter() this.lastUsedAt,
    required final Map<String, dynamic> metadata,
  }) : _metadata = metadata;

  factory _$AnomalyDetectionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnomalyDetectionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final AnomalyType type;

  /// معلومات النموذج
  @override
  final String version;
  @override
  final String modelPath;
  // مسار ملف .tflite
  @override
  @JsonKey()
  final double accuracy;
  @override
  @JsonKey()
  final double precision;
  @override
  @JsonKey()
  final double recall;

  /// التدريب
  @override
  final int trainingDataSize;
  @override
  @RequiredTimestampConverter()
  final DateTime trainedAt;
  @override
  final String? trainedBy;

  /// الحالة
  @override
  final bool isActive;
  @override
  @TimestampConverter()
  final DateTime? lastUsedAt;

  /// البيانات الوصفية
  final Map<String, dynamic> _metadata;

  /// البيانات الوصفية
  @override
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'AnomalyDetectionModel(id: $id, name: $name, type: $type, version: $version, modelPath: $modelPath, accuracy: $accuracy, precision: $precision, recall: $recall, trainingDataSize: $trainingDataSize, trainedAt: $trainedAt, trainedBy: $trainedBy, isActive: $isActive, lastUsedAt: $lastUsedAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnomalyDetectionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.modelPath, modelPath) ||
                other.modelPath == modelPath) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.precision, precision) ||
                other.precision == precision) &&
            (identical(other.recall, recall) || other.recall == recall) &&
            (identical(other.trainingDataSize, trainingDataSize) ||
                other.trainingDataSize == trainingDataSize) &&
            (identical(other.trainedAt, trainedAt) ||
                other.trainedAt == trainedAt) &&
            (identical(other.trainedBy, trainedBy) ||
                other.trainedBy == trainedBy) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.lastUsedAt, lastUsedAt) ||
                other.lastUsedAt == lastUsedAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    version,
    modelPath,
    accuracy,
    precision,
    recall,
    trainingDataSize,
    trainedAt,
    trainedBy,
    isActive,
    lastUsedAt,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of AnomalyDetectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnomalyDetectionModelImplCopyWith<_$AnomalyDetectionModelImpl>
  get copyWith =>
      __$$AnomalyDetectionModelImplCopyWithImpl<_$AnomalyDetectionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnomalyDetectionModelImplToJson(this);
  }
}

abstract class _AnomalyDetectionModel implements AnomalyDetectionModel {
  const factory _AnomalyDetectionModel({
    required final String id,
    required final String name,
    required final AnomalyType type,
    required final String version,
    required final String modelPath,
    final double accuracy,
    final double precision,
    final double recall,
    required final int trainingDataSize,
    @RequiredTimestampConverter() required final DateTime trainedAt,
    final String? trainedBy,
    required final bool isActive,
    @TimestampConverter() final DateTime? lastUsedAt,
    required final Map<String, dynamic> metadata,
  }) = _$AnomalyDetectionModelImpl;

  factory _AnomalyDetectionModel.fromJson(Map<String, dynamic> json) =
      _$AnomalyDetectionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  AnomalyType get type;

  /// معلومات النموذج
  @override
  String get version;
  @override
  String get modelPath; // مسار ملف .tflite
  @override
  double get accuracy;
  @override
  double get precision;
  @override
  double get recall;

  /// التدريب
  @override
  int get trainingDataSize;
  @override
  @RequiredTimestampConverter()
  DateTime get trainedAt;
  @override
  String? get trainedBy;

  /// الحالة
  @override
  bool get isActive;
  @override
  @TimestampConverter()
  DateTime? get lastUsedAt;

  /// البيانات الوصفية
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of AnomalyDetectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnomalyDetectionModelImplCopyWith<_$AnomalyDetectionModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

BehaviorPattern _$BehaviorPatternFromJson(Map<String, dynamic> json) {
  return _BehaviorPattern.fromJson(json);
}

/// @nodoc
mixin _$BehaviorPattern {
  String get userId => throw _privateConstructorUsedError;
  String get institutionId => throw _privateConstructorUsedError;

  /// أنماط الاختبارات
  double get avgQuizScore => throw _privateConstructorUsedError;
  double get quizScoreStdDev => throw _privateConstructorUsedError;
  int get totalQuizzesTaken => throw _privateConstructorUsedError;
  double get avgQuizCompletionTime =>
      throw _privateConstructorUsedError; // دقائق
  /// أنماط الدورات
  double get avgCourseProgress => throw _privateConstructorUsedError;
  int get totalCoursesEnrolled => throw _privateConstructorUsedError;
  int get totalCoursesCompleted => throw _privateConstructorUsedError;
  double get avgLessonDuration => throw _privateConstructorUsedError; // دقائق
  /// أنماط تسجيل الدخول
  List<String> get commonLoginTimes =>
      throw _privateConstructorUsedError; // "09:00", "14:00", etc.
  List<String> get commonDevices => throw _privateConstructorUsedError;
  List<String> get commonLocations =>
      throw _privateConstructorUsedError; // IP regions
  int get totalLoginSessions => throw _privateConstructorUsedError;

  /// أنماط النشاط
  int get totalActivities => throw _privateConstructorUsedError;
  double get avgSessionDuration => throw _privateConstructorUsedError; // دقائق
  List<String> get peakActivityHours => throw _privateConstructorUsedError;

  /// التحديث
  @RequiredTimestampConverter()
  DateTime get lastUpdatedAt => throw _privateConstructorUsedError;
  @RequiredTimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this BehaviorPattern to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BehaviorPattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BehaviorPatternCopyWith<BehaviorPattern> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BehaviorPatternCopyWith<$Res> {
  factory $BehaviorPatternCopyWith(
    BehaviorPattern value,
    $Res Function(BehaviorPattern) then,
  ) = _$BehaviorPatternCopyWithImpl<$Res, BehaviorPattern>;
  @useResult
  $Res call({
    String userId,
    String institutionId,
    double avgQuizScore,
    double quizScoreStdDev,
    int totalQuizzesTaken,
    double avgQuizCompletionTime,
    double avgCourseProgress,
    int totalCoursesEnrolled,
    int totalCoursesCompleted,
    double avgLessonDuration,
    List<String> commonLoginTimes,
    List<String> commonDevices,
    List<String> commonLocations,
    int totalLoginSessions,
    int totalActivities,
    double avgSessionDuration,
    List<String> peakActivityHours,
    @RequiredTimestampConverter() DateTime lastUpdatedAt,
    @RequiredTimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$BehaviorPatternCopyWithImpl<$Res, $Val extends BehaviorPattern>
    implements $BehaviorPatternCopyWith<$Res> {
  _$BehaviorPatternCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BehaviorPattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? institutionId = null,
    Object? avgQuizScore = null,
    Object? quizScoreStdDev = null,
    Object? totalQuizzesTaken = null,
    Object? avgQuizCompletionTime = null,
    Object? avgCourseProgress = null,
    Object? totalCoursesEnrolled = null,
    Object? totalCoursesCompleted = null,
    Object? avgLessonDuration = null,
    Object? commonLoginTimes = null,
    Object? commonDevices = null,
    Object? commonLocations = null,
    Object? totalLoginSessions = null,
    Object? totalActivities = null,
    Object? avgSessionDuration = null,
    Object? peakActivityHours = null,
    Object? lastUpdatedAt = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            avgQuizScore: null == avgQuizScore
                ? _value.avgQuizScore
                : avgQuizScore // ignore: cast_nullable_to_non_nullable
                      as double,
            quizScoreStdDev: null == quizScoreStdDev
                ? _value.quizScoreStdDev
                : quizScoreStdDev // ignore: cast_nullable_to_non_nullable
                      as double,
            totalQuizzesTaken: null == totalQuizzesTaken
                ? _value.totalQuizzesTaken
                : totalQuizzesTaken // ignore: cast_nullable_to_non_nullable
                      as int,
            avgQuizCompletionTime: null == avgQuizCompletionTime
                ? _value.avgQuizCompletionTime
                : avgQuizCompletionTime // ignore: cast_nullable_to_non_nullable
                      as double,
            avgCourseProgress: null == avgCourseProgress
                ? _value.avgCourseProgress
                : avgCourseProgress // ignore: cast_nullable_to_non_nullable
                      as double,
            totalCoursesEnrolled: null == totalCoursesEnrolled
                ? _value.totalCoursesEnrolled
                : totalCoursesEnrolled // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCoursesCompleted: null == totalCoursesCompleted
                ? _value.totalCoursesCompleted
                : totalCoursesCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            avgLessonDuration: null == avgLessonDuration
                ? _value.avgLessonDuration
                : avgLessonDuration // ignore: cast_nullable_to_non_nullable
                      as double,
            commonLoginTimes: null == commonLoginTimes
                ? _value.commonLoginTimes
                : commonLoginTimes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            commonDevices: null == commonDevices
                ? _value.commonDevices
                : commonDevices // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            commonLocations: null == commonLocations
                ? _value.commonLocations
                : commonLocations // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            totalLoginSessions: null == totalLoginSessions
                ? _value.totalLoginSessions
                : totalLoginSessions // ignore: cast_nullable_to_non_nullable
                      as int,
            totalActivities: null == totalActivities
                ? _value.totalActivities
                : totalActivities // ignore: cast_nullable_to_non_nullable
                      as int,
            avgSessionDuration: null == avgSessionDuration
                ? _value.avgSessionDuration
                : avgSessionDuration // ignore: cast_nullable_to_non_nullable
                      as double,
            peakActivityHours: null == peakActivityHours
                ? _value.peakActivityHours
                : peakActivityHours // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            lastUpdatedAt: null == lastUpdatedAt
                ? _value.lastUpdatedAt
                : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BehaviorPatternImplCopyWith<$Res>
    implements $BehaviorPatternCopyWith<$Res> {
  factory _$$BehaviorPatternImplCopyWith(
    _$BehaviorPatternImpl value,
    $Res Function(_$BehaviorPatternImpl) then,
  ) = __$$BehaviorPatternImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String institutionId,
    double avgQuizScore,
    double quizScoreStdDev,
    int totalQuizzesTaken,
    double avgQuizCompletionTime,
    double avgCourseProgress,
    int totalCoursesEnrolled,
    int totalCoursesCompleted,
    double avgLessonDuration,
    List<String> commonLoginTimes,
    List<String> commonDevices,
    List<String> commonLocations,
    int totalLoginSessions,
    int totalActivities,
    double avgSessionDuration,
    List<String> peakActivityHours,
    @RequiredTimestampConverter() DateTime lastUpdatedAt,
    @RequiredTimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$BehaviorPatternImplCopyWithImpl<$Res>
    extends _$BehaviorPatternCopyWithImpl<$Res, _$BehaviorPatternImpl>
    implements _$$BehaviorPatternImplCopyWith<$Res> {
  __$$BehaviorPatternImplCopyWithImpl(
    _$BehaviorPatternImpl _value,
    $Res Function(_$BehaviorPatternImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BehaviorPattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? institutionId = null,
    Object? avgQuizScore = null,
    Object? quizScoreStdDev = null,
    Object? totalQuizzesTaken = null,
    Object? avgQuizCompletionTime = null,
    Object? avgCourseProgress = null,
    Object? totalCoursesEnrolled = null,
    Object? totalCoursesCompleted = null,
    Object? avgLessonDuration = null,
    Object? commonLoginTimes = null,
    Object? commonDevices = null,
    Object? commonLocations = null,
    Object? totalLoginSessions = null,
    Object? totalActivities = null,
    Object? avgSessionDuration = null,
    Object? peakActivityHours = null,
    Object? lastUpdatedAt = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$BehaviorPatternImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        avgQuizScore: null == avgQuizScore
            ? _value.avgQuizScore
            : avgQuizScore // ignore: cast_nullable_to_non_nullable
                  as double,
        quizScoreStdDev: null == quizScoreStdDev
            ? _value.quizScoreStdDev
            : quizScoreStdDev // ignore: cast_nullable_to_non_nullable
                  as double,
        totalQuizzesTaken: null == totalQuizzesTaken
            ? _value.totalQuizzesTaken
            : totalQuizzesTaken // ignore: cast_nullable_to_non_nullable
                  as int,
        avgQuizCompletionTime: null == avgQuizCompletionTime
            ? _value.avgQuizCompletionTime
            : avgQuizCompletionTime // ignore: cast_nullable_to_non_nullable
                  as double,
        avgCourseProgress: null == avgCourseProgress
            ? _value.avgCourseProgress
            : avgCourseProgress // ignore: cast_nullable_to_non_nullable
                  as double,
        totalCoursesEnrolled: null == totalCoursesEnrolled
            ? _value.totalCoursesEnrolled
            : totalCoursesEnrolled // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCoursesCompleted: null == totalCoursesCompleted
            ? _value.totalCoursesCompleted
            : totalCoursesCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        avgLessonDuration: null == avgLessonDuration
            ? _value.avgLessonDuration
            : avgLessonDuration // ignore: cast_nullable_to_non_nullable
                  as double,
        commonLoginTimes: null == commonLoginTimes
            ? _value._commonLoginTimes
            : commonLoginTimes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        commonDevices: null == commonDevices
            ? _value._commonDevices
            : commonDevices // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        commonLocations: null == commonLocations
            ? _value._commonLocations
            : commonLocations // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        totalLoginSessions: null == totalLoginSessions
            ? _value.totalLoginSessions
            : totalLoginSessions // ignore: cast_nullable_to_non_nullable
                  as int,
        totalActivities: null == totalActivities
            ? _value.totalActivities
            : totalActivities // ignore: cast_nullable_to_non_nullable
                  as int,
        avgSessionDuration: null == avgSessionDuration
            ? _value.avgSessionDuration
            : avgSessionDuration // ignore: cast_nullable_to_non_nullable
                  as double,
        peakActivityHours: null == peakActivityHours
            ? _value._peakActivityHours
            : peakActivityHours // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        lastUpdatedAt: null == lastUpdatedAt
            ? _value.lastUpdatedAt
            : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BehaviorPatternImpl implements _BehaviorPattern {
  const _$BehaviorPatternImpl({
    required this.userId,
    required this.institutionId,
    this.avgQuizScore = 0.0,
    this.quizScoreStdDev = 0.0,
    this.totalQuizzesTaken = 0,
    this.avgQuizCompletionTime = 0.0,
    this.avgCourseProgress = 0.0,
    this.totalCoursesEnrolled = 0,
    this.totalCoursesCompleted = 0,
    this.avgLessonDuration = 0.0,
    final List<String> commonLoginTimes = const [],
    final List<String> commonDevices = const [],
    final List<String> commonLocations = const [],
    this.totalLoginSessions = 0,
    this.totalActivities = 0,
    this.avgSessionDuration = 0.0,
    final List<String> peakActivityHours = const [],
    @RequiredTimestampConverter() required this.lastUpdatedAt,
    @RequiredTimestampConverter() required this.createdAt,
  }) : _commonLoginTimes = commonLoginTimes,
       _commonDevices = commonDevices,
       _commonLocations = commonLocations,
       _peakActivityHours = peakActivityHours;

  factory _$BehaviorPatternImpl.fromJson(Map<String, dynamic> json) =>
      _$$BehaviorPatternImplFromJson(json);

  @override
  final String userId;
  @override
  final String institutionId;

  /// أنماط الاختبارات
  @override
  @JsonKey()
  final double avgQuizScore;
  @override
  @JsonKey()
  final double quizScoreStdDev;
  @override
  @JsonKey()
  final int totalQuizzesTaken;
  @override
  @JsonKey()
  final double avgQuizCompletionTime;
  // دقائق
  /// أنماط الدورات
  @override
  @JsonKey()
  final double avgCourseProgress;
  @override
  @JsonKey()
  final int totalCoursesEnrolled;
  @override
  @JsonKey()
  final int totalCoursesCompleted;
  @override
  @JsonKey()
  final double avgLessonDuration;
  // دقائق
  /// أنماط تسجيل الدخول
  final List<String> _commonLoginTimes;
  // دقائق
  /// أنماط تسجيل الدخول
  @override
  @JsonKey()
  List<String> get commonLoginTimes {
    if (_commonLoginTimes is EqualUnmodifiableListView)
      return _commonLoginTimes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commonLoginTimes);
  }

  // "09:00", "14:00", etc.
  final List<String> _commonDevices;
  // "09:00", "14:00", etc.
  @override
  @JsonKey()
  List<String> get commonDevices {
    if (_commonDevices is EqualUnmodifiableListView) return _commonDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commonDevices);
  }

  final List<String> _commonLocations;
  @override
  @JsonKey()
  List<String> get commonLocations {
    if (_commonLocations is EqualUnmodifiableListView) return _commonLocations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commonLocations);
  }

  // IP regions
  @override
  @JsonKey()
  final int totalLoginSessions;

  /// أنماط النشاط
  @override
  @JsonKey()
  final int totalActivities;
  @override
  @JsonKey()
  final double avgSessionDuration;
  // دقائق
  final List<String> _peakActivityHours;
  // دقائق
  @override
  @JsonKey()
  List<String> get peakActivityHours {
    if (_peakActivityHours is EqualUnmodifiableListView)
      return _peakActivityHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_peakActivityHours);
  }

  /// التحديث
  @override
  @RequiredTimestampConverter()
  final DateTime lastUpdatedAt;
  @override
  @RequiredTimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'BehaviorPattern(userId: $userId, institutionId: $institutionId, avgQuizScore: $avgQuizScore, quizScoreStdDev: $quizScoreStdDev, totalQuizzesTaken: $totalQuizzesTaken, avgQuizCompletionTime: $avgQuizCompletionTime, avgCourseProgress: $avgCourseProgress, totalCoursesEnrolled: $totalCoursesEnrolled, totalCoursesCompleted: $totalCoursesCompleted, avgLessonDuration: $avgLessonDuration, commonLoginTimes: $commonLoginTimes, commonDevices: $commonDevices, commonLocations: $commonLocations, totalLoginSessions: $totalLoginSessions, totalActivities: $totalActivities, avgSessionDuration: $avgSessionDuration, peakActivityHours: $peakActivityHours, lastUpdatedAt: $lastUpdatedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BehaviorPatternImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.avgQuizScore, avgQuizScore) ||
                other.avgQuizScore == avgQuizScore) &&
            (identical(other.quizScoreStdDev, quizScoreStdDev) ||
                other.quizScoreStdDev == quizScoreStdDev) &&
            (identical(other.totalQuizzesTaken, totalQuizzesTaken) ||
                other.totalQuizzesTaken == totalQuizzesTaken) &&
            (identical(other.avgQuizCompletionTime, avgQuizCompletionTime) ||
                other.avgQuizCompletionTime == avgQuizCompletionTime) &&
            (identical(other.avgCourseProgress, avgCourseProgress) ||
                other.avgCourseProgress == avgCourseProgress) &&
            (identical(other.totalCoursesEnrolled, totalCoursesEnrolled) ||
                other.totalCoursesEnrolled == totalCoursesEnrolled) &&
            (identical(other.totalCoursesCompleted, totalCoursesCompleted) ||
                other.totalCoursesCompleted == totalCoursesCompleted) &&
            (identical(other.avgLessonDuration, avgLessonDuration) ||
                other.avgLessonDuration == avgLessonDuration) &&
            const DeepCollectionEquality().equals(
              other._commonLoginTimes,
              _commonLoginTimes,
            ) &&
            const DeepCollectionEquality().equals(
              other._commonDevices,
              _commonDevices,
            ) &&
            const DeepCollectionEquality().equals(
              other._commonLocations,
              _commonLocations,
            ) &&
            (identical(other.totalLoginSessions, totalLoginSessions) ||
                other.totalLoginSessions == totalLoginSessions) &&
            (identical(other.totalActivities, totalActivities) ||
                other.totalActivities == totalActivities) &&
            (identical(other.avgSessionDuration, avgSessionDuration) ||
                other.avgSessionDuration == avgSessionDuration) &&
            const DeepCollectionEquality().equals(
              other._peakActivityHours,
              _peakActivityHours,
            ) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    userId,
    institutionId,
    avgQuizScore,
    quizScoreStdDev,
    totalQuizzesTaken,
    avgQuizCompletionTime,
    avgCourseProgress,
    totalCoursesEnrolled,
    totalCoursesCompleted,
    avgLessonDuration,
    const DeepCollectionEquality().hash(_commonLoginTimes),
    const DeepCollectionEquality().hash(_commonDevices),
    const DeepCollectionEquality().hash(_commonLocations),
    totalLoginSessions,
    totalActivities,
    avgSessionDuration,
    const DeepCollectionEquality().hash(_peakActivityHours),
    lastUpdatedAt,
    createdAt,
  ]);

  /// Create a copy of BehaviorPattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BehaviorPatternImplCopyWith<_$BehaviorPatternImpl> get copyWith =>
      __$$BehaviorPatternImplCopyWithImpl<_$BehaviorPatternImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BehaviorPatternImplToJson(this);
  }
}

abstract class _BehaviorPattern implements BehaviorPattern {
  const factory _BehaviorPattern({
    required final String userId,
    required final String institutionId,
    final double avgQuizScore,
    final double quizScoreStdDev,
    final int totalQuizzesTaken,
    final double avgQuizCompletionTime,
    final double avgCourseProgress,
    final int totalCoursesEnrolled,
    final int totalCoursesCompleted,
    final double avgLessonDuration,
    final List<String> commonLoginTimes,
    final List<String> commonDevices,
    final List<String> commonLocations,
    final int totalLoginSessions,
    final int totalActivities,
    final double avgSessionDuration,
    final List<String> peakActivityHours,
    @RequiredTimestampConverter() required final DateTime lastUpdatedAt,
    @RequiredTimestampConverter() required final DateTime createdAt,
  }) = _$BehaviorPatternImpl;

  factory _BehaviorPattern.fromJson(Map<String, dynamic> json) =
      _$BehaviorPatternImpl.fromJson;

  @override
  String get userId;
  @override
  String get institutionId;

  /// أنماط الاختبارات
  @override
  double get avgQuizScore;
  @override
  double get quizScoreStdDev;
  @override
  int get totalQuizzesTaken;
  @override
  double get avgQuizCompletionTime; // دقائق
  /// أنماط الدورات
  @override
  double get avgCourseProgress;
  @override
  int get totalCoursesEnrolled;
  @override
  int get totalCoursesCompleted;
  @override
  double get avgLessonDuration; // دقائق
  /// أنماط تسجيل الدخول
  @override
  List<String> get commonLoginTimes; // "09:00", "14:00", etc.
  @override
  List<String> get commonDevices;
  @override
  List<String> get commonLocations; // IP regions
  @override
  int get totalLoginSessions;

  /// أنماط النشاط
  @override
  int get totalActivities;
  @override
  double get avgSessionDuration; // دقائق
  @override
  List<String> get peakActivityHours;

  /// التحديث
  @override
  @RequiredTimestampConverter()
  DateTime get lastUpdatedAt;
  @override
  @RequiredTimestampConverter()
  DateTime get createdAt;

  /// Create a copy of BehaviorPattern
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BehaviorPatternImplCopyWith<_$BehaviorPatternImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActivityEvent _$ActivityEventFromJson(Map<String, dynamic> json) {
  return _ActivityEvent.fromJson(json);
}

/// @nodoc
mixin _$ActivityEvent {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get institutionId => throw _privateConstructorUsedError;

  /// معلومات الحدث
  String get eventType =>
      throw _privateConstructorUsedError; // login, quiz_submit, lesson_view, etc.
  Map<String, dynamic> get eventData => throw _privateConstructorUsedError;

  /// السياق
  String? get deviceId => throw _privateConstructorUsedError;
  String? get deviceType =>
      throw _privateConstructorUsedError; // mobile, web, tablet
  String? get ipAddress => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError; // من IP
  String? get userAgent => throw _privateConstructorUsedError;

  /// التوقيت
  @RequiredTimestampConverter()
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// التحليل
  bool get isFlagged => throw _privateConstructorUsedError;
  double? get anomalyScore => throw _privateConstructorUsedError;

  /// Serializes this ActivityEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityEventCopyWith<ActivityEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityEventCopyWith<$Res> {
  factory $ActivityEventCopyWith(
    ActivityEvent value,
    $Res Function(ActivityEvent) then,
  ) = _$ActivityEventCopyWithImpl<$Res, ActivityEvent>;
  @useResult
  $Res call({
    String id,
    String userId,
    String institutionId,
    String eventType,
    Map<String, dynamic> eventData,
    String? deviceId,
    String? deviceType,
    String? ipAddress,
    String? location,
    String? userAgent,
    @RequiredTimestampConverter() DateTime timestamp,
    bool isFlagged,
    double? anomalyScore,
  });
}

/// @nodoc
class _$ActivityEventCopyWithImpl<$Res, $Val extends ActivityEvent>
    implements $ActivityEventCopyWith<$Res> {
  _$ActivityEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? institutionId = null,
    Object? eventType = null,
    Object? eventData = null,
    Object? deviceId = freezed,
    Object? deviceType = freezed,
    Object? ipAddress = freezed,
    Object? location = freezed,
    Object? userAgent = freezed,
    Object? timestamp = null,
    Object? isFlagged = null,
    Object? anomalyScore = freezed,
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
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            eventType: null == eventType
                ? _value.eventType
                : eventType // ignore: cast_nullable_to_non_nullable
                      as String,
            eventData: null == eventData
                ? _value.eventData
                : eventData // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            deviceId: freezed == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            deviceType: freezed == deviceType
                ? _value.deviceType
                : deviceType // ignore: cast_nullable_to_non_nullable
                      as String?,
            ipAddress: freezed == ipAddress
                ? _value.ipAddress
                : ipAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            userAgent: freezed == userAgent
                ? _value.userAgent
                : userAgent // ignore: cast_nullable_to_non_nullable
                      as String?,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isFlagged: null == isFlagged
                ? _value.isFlagged
                : isFlagged // ignore: cast_nullable_to_non_nullable
                      as bool,
            anomalyScore: freezed == anomalyScore
                ? _value.anomalyScore
                : anomalyScore // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActivityEventImplCopyWith<$Res>
    implements $ActivityEventCopyWith<$Res> {
  factory _$$ActivityEventImplCopyWith(
    _$ActivityEventImpl value,
    $Res Function(_$ActivityEventImpl) then,
  ) = __$$ActivityEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String institutionId,
    String eventType,
    Map<String, dynamic> eventData,
    String? deviceId,
    String? deviceType,
    String? ipAddress,
    String? location,
    String? userAgent,
    @RequiredTimestampConverter() DateTime timestamp,
    bool isFlagged,
    double? anomalyScore,
  });
}

/// @nodoc
class __$$ActivityEventImplCopyWithImpl<$Res>
    extends _$ActivityEventCopyWithImpl<$Res, _$ActivityEventImpl>
    implements _$$ActivityEventImplCopyWith<$Res> {
  __$$ActivityEventImplCopyWithImpl(
    _$ActivityEventImpl _value,
    $Res Function(_$ActivityEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivityEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? institutionId = null,
    Object? eventType = null,
    Object? eventData = null,
    Object? deviceId = freezed,
    Object? deviceType = freezed,
    Object? ipAddress = freezed,
    Object? location = freezed,
    Object? userAgent = freezed,
    Object? timestamp = null,
    Object? isFlagged = null,
    Object? anomalyScore = freezed,
  }) {
    return _then(
      _$ActivityEventImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        eventType: null == eventType
            ? _value.eventType
            : eventType // ignore: cast_nullable_to_non_nullable
                  as String,
        eventData: null == eventData
            ? _value._eventData
            : eventData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        deviceId: freezed == deviceId
            ? _value.deviceId
            : deviceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        deviceType: freezed == deviceType
            ? _value.deviceType
            : deviceType // ignore: cast_nullable_to_non_nullable
                  as String?,
        ipAddress: freezed == ipAddress
            ? _value.ipAddress
            : ipAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        userAgent: freezed == userAgent
            ? _value.userAgent
            : userAgent // ignore: cast_nullable_to_non_nullable
                  as String?,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isFlagged: null == isFlagged
            ? _value.isFlagged
            : isFlagged // ignore: cast_nullable_to_non_nullable
                  as bool,
        anomalyScore: freezed == anomalyScore
            ? _value.anomalyScore
            : anomalyScore // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityEventImpl implements _ActivityEvent {
  const _$ActivityEventImpl({
    required this.id,
    required this.userId,
    required this.institutionId,
    required this.eventType,
    required final Map<String, dynamic> eventData,
    this.deviceId,
    this.deviceType,
    this.ipAddress,
    this.location,
    this.userAgent,
    @RequiredTimestampConverter() required this.timestamp,
    this.isFlagged = false,
    this.anomalyScore,
  }) : _eventData = eventData;

  factory _$ActivityEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityEventImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String institutionId;

  /// معلومات الحدث
  @override
  final String eventType;
  // login, quiz_submit, lesson_view, etc.
  final Map<String, dynamic> _eventData;
  // login, quiz_submit, lesson_view, etc.
  @override
  Map<String, dynamic> get eventData {
    if (_eventData is EqualUnmodifiableMapView) return _eventData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_eventData);
  }

  /// السياق
  @override
  final String? deviceId;
  @override
  final String? deviceType;
  // mobile, web, tablet
  @override
  final String? ipAddress;
  @override
  final String? location;
  // من IP
  @override
  final String? userAgent;

  /// التوقيت
  @override
  @RequiredTimestampConverter()
  final DateTime timestamp;

  /// التحليل
  @override
  @JsonKey()
  final bool isFlagged;
  @override
  final double? anomalyScore;

  @override
  String toString() {
    return 'ActivityEvent(id: $id, userId: $userId, institutionId: $institutionId, eventType: $eventType, eventData: $eventData, deviceId: $deviceId, deviceType: $deviceType, ipAddress: $ipAddress, location: $location, userAgent: $userAgent, timestamp: $timestamp, isFlagged: $isFlagged, anomalyScore: $anomalyScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            const DeepCollectionEquality().equals(
              other._eventData,
              _eventData,
            ) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.userAgent, userAgent) ||
                other.userAgent == userAgent) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isFlagged, isFlagged) ||
                other.isFlagged == isFlagged) &&
            (identical(other.anomalyScore, anomalyScore) ||
                other.anomalyScore == anomalyScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    institutionId,
    eventType,
    const DeepCollectionEquality().hash(_eventData),
    deviceId,
    deviceType,
    ipAddress,
    location,
    userAgent,
    timestamp,
    isFlagged,
    anomalyScore,
  );

  /// Create a copy of ActivityEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityEventImplCopyWith<_$ActivityEventImpl> get copyWith =>
      __$$ActivityEventImplCopyWithImpl<_$ActivityEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityEventImplToJson(this);
  }
}

abstract class _ActivityEvent implements ActivityEvent {
  const factory _ActivityEvent({
    required final String id,
    required final String userId,
    required final String institutionId,
    required final String eventType,
    required final Map<String, dynamic> eventData,
    final String? deviceId,
    final String? deviceType,
    final String? ipAddress,
    final String? location,
    final String? userAgent,
    @RequiredTimestampConverter() required final DateTime timestamp,
    final bool isFlagged,
    final double? anomalyScore,
  }) = _$ActivityEventImpl;

  factory _ActivityEvent.fromJson(Map<String, dynamic> json) =
      _$ActivityEventImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get institutionId;

  /// معلومات الحدث
  @override
  String get eventType; // login, quiz_submit, lesson_view, etc.
  @override
  Map<String, dynamic> get eventData;

  /// السياق
  @override
  String? get deviceId;
  @override
  String? get deviceType; // mobile, web, tablet
  @override
  String? get ipAddress;
  @override
  String? get location; // من IP
  @override
  String? get userAgent;

  /// التوقيت
  @override
  @RequiredTimestampConverter()
  DateTime get timestamp;

  /// التحليل
  @override
  bool get isFlagged;
  @override
  double? get anomalyScore;

  /// Create a copy of ActivityEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityEventImplCopyWith<_$ActivityEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DetectionStatistics _$DetectionStatisticsFromJson(Map<String, dynamic> json) {
  return _DetectionStatistics.fromJson(json);
}

/// @nodoc
mixin _$DetectionStatistics {
  String get institutionId => throw _privateConstructorUsedError;
  String? get companyId => throw _privateConstructorUsedError;

  /// الفترة
  @RequiredTimestampConverter()
  DateTime get startDate => throw _privateConstructorUsedError;
  @RequiredTimestampConverter()
  DateTime get endDate => throw _privateConstructorUsedError;

  /// الأعداد
  int get totalAnomaliesDetected => throw _privateConstructorUsedError;
  int get confirmedAnomalies => throw _privateConstructorUsedError;
  int get falsePositives => throw _privateConstructorUsedError;
  int get pendingReview => throw _privateConstructorUsedError;

  /// حسب النوع
  Map<AnomalyType, int> get anomaliesByType =>
      throw _privateConstructorUsedError;
  Map<AnomalySeverity, int> get anomaliesBySeverity =>
      throw _privateConstructorUsedError;

  /// الدقة
  double get detectionAccuracy => throw _privateConstructorUsedError;
  double get falsePositiveRate => throw _privateConstructorUsedError;
  double get truePositiveRate => throw _privateConstructorUsedError;

  /// الأداء
  double get avgDetectionTime => throw _privateConstructorUsedError; // ثواني
  double get avgReviewTime => throw _privateConstructorUsedError; // ساعات
  /// التحديث
  @RequiredTimestampConverter()
  DateTime get generatedAt => throw _privateConstructorUsedError;

  /// Serializes this DetectionStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DetectionStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DetectionStatisticsCopyWith<DetectionStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetectionStatisticsCopyWith<$Res> {
  factory $DetectionStatisticsCopyWith(
    DetectionStatistics value,
    $Res Function(DetectionStatistics) then,
  ) = _$DetectionStatisticsCopyWithImpl<$Res, DetectionStatistics>;
  @useResult
  $Res call({
    String institutionId,
    String? companyId,
    @RequiredTimestampConverter() DateTime startDate,
    @RequiredTimestampConverter() DateTime endDate,
    int totalAnomaliesDetected,
    int confirmedAnomalies,
    int falsePositives,
    int pendingReview,
    Map<AnomalyType, int> anomaliesByType,
    Map<AnomalySeverity, int> anomaliesBySeverity,
    double detectionAccuracy,
    double falsePositiveRate,
    double truePositiveRate,
    double avgDetectionTime,
    double avgReviewTime,
    @RequiredTimestampConverter() DateTime generatedAt,
  });
}

/// @nodoc
class _$DetectionStatisticsCopyWithImpl<$Res, $Val extends DetectionStatistics>
    implements $DetectionStatisticsCopyWith<$Res> {
  _$DetectionStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DetectionStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalAnomaliesDetected = null,
    Object? confirmedAnomalies = null,
    Object? falsePositives = null,
    Object? pendingReview = null,
    Object? anomaliesByType = null,
    Object? anomaliesBySeverity = null,
    Object? detectionAccuracy = null,
    Object? falsePositiveRate = null,
    Object? truePositiveRate = null,
    Object? avgDetectionTime = null,
    Object? avgReviewTime = null,
    Object? generatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: freezed == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String?,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalAnomaliesDetected: null == totalAnomaliesDetected
                ? _value.totalAnomaliesDetected
                : totalAnomaliesDetected // ignore: cast_nullable_to_non_nullable
                      as int,
            confirmedAnomalies: null == confirmedAnomalies
                ? _value.confirmedAnomalies
                : confirmedAnomalies // ignore: cast_nullable_to_non_nullable
                      as int,
            falsePositives: null == falsePositives
                ? _value.falsePositives
                : falsePositives // ignore: cast_nullable_to_non_nullable
                      as int,
            pendingReview: null == pendingReview
                ? _value.pendingReview
                : pendingReview // ignore: cast_nullable_to_non_nullable
                      as int,
            anomaliesByType: null == anomaliesByType
                ? _value.anomaliesByType
                : anomaliesByType // ignore: cast_nullable_to_non_nullable
                      as Map<AnomalyType, int>,
            anomaliesBySeverity: null == anomaliesBySeverity
                ? _value.anomaliesBySeverity
                : anomaliesBySeverity // ignore: cast_nullable_to_non_nullable
                      as Map<AnomalySeverity, int>,
            detectionAccuracy: null == detectionAccuracy
                ? _value.detectionAccuracy
                : detectionAccuracy // ignore: cast_nullable_to_non_nullable
                      as double,
            falsePositiveRate: null == falsePositiveRate
                ? _value.falsePositiveRate
                : falsePositiveRate // ignore: cast_nullable_to_non_nullable
                      as double,
            truePositiveRate: null == truePositiveRate
                ? _value.truePositiveRate
                : truePositiveRate // ignore: cast_nullable_to_non_nullable
                      as double,
            avgDetectionTime: null == avgDetectionTime
                ? _value.avgDetectionTime
                : avgDetectionTime // ignore: cast_nullable_to_non_nullable
                      as double,
            avgReviewTime: null == avgReviewTime
                ? _value.avgReviewTime
                : avgReviewTime // ignore: cast_nullable_to_non_nullable
                      as double,
            generatedAt: null == generatedAt
                ? _value.generatedAt
                : generatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DetectionStatisticsImplCopyWith<$Res>
    implements $DetectionStatisticsCopyWith<$Res> {
  factory _$$DetectionStatisticsImplCopyWith(
    _$DetectionStatisticsImpl value,
    $Res Function(_$DetectionStatisticsImpl) then,
  ) = __$$DetectionStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String institutionId,
    String? companyId,
    @RequiredTimestampConverter() DateTime startDate,
    @RequiredTimestampConverter() DateTime endDate,
    int totalAnomaliesDetected,
    int confirmedAnomalies,
    int falsePositives,
    int pendingReview,
    Map<AnomalyType, int> anomaliesByType,
    Map<AnomalySeverity, int> anomaliesBySeverity,
    double detectionAccuracy,
    double falsePositiveRate,
    double truePositiveRate,
    double avgDetectionTime,
    double avgReviewTime,
    @RequiredTimestampConverter() DateTime generatedAt,
  });
}

/// @nodoc
class __$$DetectionStatisticsImplCopyWithImpl<$Res>
    extends _$DetectionStatisticsCopyWithImpl<$Res, _$DetectionStatisticsImpl>
    implements _$$DetectionStatisticsImplCopyWith<$Res> {
  __$$DetectionStatisticsImplCopyWithImpl(
    _$DetectionStatisticsImpl _value,
    $Res Function(_$DetectionStatisticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DetectionStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalAnomaliesDetected = null,
    Object? confirmedAnomalies = null,
    Object? falsePositives = null,
    Object? pendingReview = null,
    Object? anomaliesByType = null,
    Object? anomaliesBySeverity = null,
    Object? detectionAccuracy = null,
    Object? falsePositiveRate = null,
    Object? truePositiveRate = null,
    Object? avgDetectionTime = null,
    Object? avgReviewTime = null,
    Object? generatedAt = null,
  }) {
    return _then(
      _$DetectionStatisticsImpl(
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: freezed == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalAnomaliesDetected: null == totalAnomaliesDetected
            ? _value.totalAnomaliesDetected
            : totalAnomaliesDetected // ignore: cast_nullable_to_non_nullable
                  as int,
        confirmedAnomalies: null == confirmedAnomalies
            ? _value.confirmedAnomalies
            : confirmedAnomalies // ignore: cast_nullable_to_non_nullable
                  as int,
        falsePositives: null == falsePositives
            ? _value.falsePositives
            : falsePositives // ignore: cast_nullable_to_non_nullable
                  as int,
        pendingReview: null == pendingReview
            ? _value.pendingReview
            : pendingReview // ignore: cast_nullable_to_non_nullable
                  as int,
        anomaliesByType: null == anomaliesByType
            ? _value._anomaliesByType
            : anomaliesByType // ignore: cast_nullable_to_non_nullable
                  as Map<AnomalyType, int>,
        anomaliesBySeverity: null == anomaliesBySeverity
            ? _value._anomaliesBySeverity
            : anomaliesBySeverity // ignore: cast_nullable_to_non_nullable
                  as Map<AnomalySeverity, int>,
        detectionAccuracy: null == detectionAccuracy
            ? _value.detectionAccuracy
            : detectionAccuracy // ignore: cast_nullable_to_non_nullable
                  as double,
        falsePositiveRate: null == falsePositiveRate
            ? _value.falsePositiveRate
            : falsePositiveRate // ignore: cast_nullable_to_non_nullable
                  as double,
        truePositiveRate: null == truePositiveRate
            ? _value.truePositiveRate
            : truePositiveRate // ignore: cast_nullable_to_non_nullable
                  as double,
        avgDetectionTime: null == avgDetectionTime
            ? _value.avgDetectionTime
            : avgDetectionTime // ignore: cast_nullable_to_non_nullable
                  as double,
        avgReviewTime: null == avgReviewTime
            ? _value.avgReviewTime
            : avgReviewTime // ignore: cast_nullable_to_non_nullable
                  as double,
        generatedAt: null == generatedAt
            ? _value.generatedAt
            : generatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DetectionStatisticsImpl implements _DetectionStatistics {
  const _$DetectionStatisticsImpl({
    required this.institutionId,
    this.companyId,
    @RequiredTimestampConverter() required this.startDate,
    @RequiredTimestampConverter() required this.endDate,
    required this.totalAnomaliesDetected,
    required this.confirmedAnomalies,
    required this.falsePositives,
    required this.pendingReview,
    required final Map<AnomalyType, int> anomaliesByType,
    required final Map<AnomalySeverity, int> anomaliesBySeverity,
    this.detectionAccuracy = 0.0,
    this.falsePositiveRate = 0.0,
    this.truePositiveRate = 0.0,
    this.avgDetectionTime = 0.0,
    this.avgReviewTime = 0.0,
    @RequiredTimestampConverter() required this.generatedAt,
  }) : _anomaliesByType = anomaliesByType,
       _anomaliesBySeverity = anomaliesBySeverity;

  factory _$DetectionStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetectionStatisticsImplFromJson(json);

  @override
  final String institutionId;
  @override
  final String? companyId;

  /// الفترة
  @override
  @RequiredTimestampConverter()
  final DateTime startDate;
  @override
  @RequiredTimestampConverter()
  final DateTime endDate;

  /// الأعداد
  @override
  final int totalAnomaliesDetected;
  @override
  final int confirmedAnomalies;
  @override
  final int falsePositives;
  @override
  final int pendingReview;

  /// حسب النوع
  final Map<AnomalyType, int> _anomaliesByType;

  /// حسب النوع
  @override
  Map<AnomalyType, int> get anomaliesByType {
    if (_anomaliesByType is EqualUnmodifiableMapView) return _anomaliesByType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_anomaliesByType);
  }

  final Map<AnomalySeverity, int> _anomaliesBySeverity;
  @override
  Map<AnomalySeverity, int> get anomaliesBySeverity {
    if (_anomaliesBySeverity is EqualUnmodifiableMapView)
      return _anomaliesBySeverity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_anomaliesBySeverity);
  }

  /// الدقة
  @override
  @JsonKey()
  final double detectionAccuracy;
  @override
  @JsonKey()
  final double falsePositiveRate;
  @override
  @JsonKey()
  final double truePositiveRate;

  /// الأداء
  @override
  @JsonKey()
  final double avgDetectionTime;
  // ثواني
  @override
  @JsonKey()
  final double avgReviewTime;
  // ساعات
  /// التحديث
  @override
  @RequiredTimestampConverter()
  final DateTime generatedAt;

  @override
  String toString() {
    return 'DetectionStatistics(institutionId: $institutionId, companyId: $companyId, startDate: $startDate, endDate: $endDate, totalAnomaliesDetected: $totalAnomaliesDetected, confirmedAnomalies: $confirmedAnomalies, falsePositives: $falsePositives, pendingReview: $pendingReview, anomaliesByType: $anomaliesByType, anomaliesBySeverity: $anomaliesBySeverity, detectionAccuracy: $detectionAccuracy, falsePositiveRate: $falsePositiveRate, truePositiveRate: $truePositiveRate, avgDetectionTime: $avgDetectionTime, avgReviewTime: $avgReviewTime, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetectionStatisticsImpl &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.totalAnomaliesDetected, totalAnomaliesDetected) ||
                other.totalAnomaliesDetected == totalAnomaliesDetected) &&
            (identical(other.confirmedAnomalies, confirmedAnomalies) ||
                other.confirmedAnomalies == confirmedAnomalies) &&
            (identical(other.falsePositives, falsePositives) ||
                other.falsePositives == falsePositives) &&
            (identical(other.pendingReview, pendingReview) ||
                other.pendingReview == pendingReview) &&
            const DeepCollectionEquality().equals(
              other._anomaliesByType,
              _anomaliesByType,
            ) &&
            const DeepCollectionEquality().equals(
              other._anomaliesBySeverity,
              _anomaliesBySeverity,
            ) &&
            (identical(other.detectionAccuracy, detectionAccuracy) ||
                other.detectionAccuracy == detectionAccuracy) &&
            (identical(other.falsePositiveRate, falsePositiveRate) ||
                other.falsePositiveRate == falsePositiveRate) &&
            (identical(other.truePositiveRate, truePositiveRate) ||
                other.truePositiveRate == truePositiveRate) &&
            (identical(other.avgDetectionTime, avgDetectionTime) ||
                other.avgDetectionTime == avgDetectionTime) &&
            (identical(other.avgReviewTime, avgReviewTime) ||
                other.avgReviewTime == avgReviewTime) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    institutionId,
    companyId,
    startDate,
    endDate,
    totalAnomaliesDetected,
    confirmedAnomalies,
    falsePositives,
    pendingReview,
    const DeepCollectionEquality().hash(_anomaliesByType),
    const DeepCollectionEquality().hash(_anomaliesBySeverity),
    detectionAccuracy,
    falsePositiveRate,
    truePositiveRate,
    avgDetectionTime,
    avgReviewTime,
    generatedAt,
  );

  /// Create a copy of DetectionStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetectionStatisticsImplCopyWith<_$DetectionStatisticsImpl> get copyWith =>
      __$$DetectionStatisticsImplCopyWithImpl<_$DetectionStatisticsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DetectionStatisticsImplToJson(this);
  }
}

abstract class _DetectionStatistics implements DetectionStatistics {
  const factory _DetectionStatistics({
    required final String institutionId,
    final String? companyId,
    @RequiredTimestampConverter() required final DateTime startDate,
    @RequiredTimestampConverter() required final DateTime endDate,
    required final int totalAnomaliesDetected,
    required final int confirmedAnomalies,
    required final int falsePositives,
    required final int pendingReview,
    required final Map<AnomalyType, int> anomaliesByType,
    required final Map<AnomalySeverity, int> anomaliesBySeverity,
    final double detectionAccuracy,
    final double falsePositiveRate,
    final double truePositiveRate,
    final double avgDetectionTime,
    final double avgReviewTime,
    @RequiredTimestampConverter() required final DateTime generatedAt,
  }) = _$DetectionStatisticsImpl;

  factory _DetectionStatistics.fromJson(Map<String, dynamic> json) =
      _$DetectionStatisticsImpl.fromJson;

  @override
  String get institutionId;
  @override
  String? get companyId;

  /// الفترة
  @override
  @RequiredTimestampConverter()
  DateTime get startDate;
  @override
  @RequiredTimestampConverter()
  DateTime get endDate;

  /// الأعداد
  @override
  int get totalAnomaliesDetected;
  @override
  int get confirmedAnomalies;
  @override
  int get falsePositives;
  @override
  int get pendingReview;

  /// حسب النوع
  @override
  Map<AnomalyType, int> get anomaliesByType;
  @override
  Map<AnomalySeverity, int> get anomaliesBySeverity;

  /// الدقة
  @override
  double get detectionAccuracy;
  @override
  double get falsePositiveRate;
  @override
  double get truePositiveRate;

  /// الأداء
  @override
  double get avgDetectionTime; // ثواني
  @override
  double get avgReviewTime; // ساعات
  /// التحديث
  @override
  @RequiredTimestampConverter()
  DateTime get generatedAt;

  /// Create a copy of DetectionStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetectionStatisticsImplCopyWith<_$DetectionStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
