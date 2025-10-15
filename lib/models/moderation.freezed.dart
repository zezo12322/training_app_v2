// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'moderation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Report _$ReportFromJson(Map<String, dynamic> json) {
  return _Report.fromJson(json);
}

/// @nodoc
mixin _$Report {
  /// معرف التقرير
  String get id => throw _privateConstructorUsedError;

  /// نوع التقرير
  ReportType get type => throw _privateConstructorUsedError;

  /// حالة التقرير
  ReportStatus get status => throw _privateConstructorUsedError;

  /// معرف المُبلِّغ
  String get reporterId => throw _privateConstructorUsedError;

  /// اسم المُبلِّغ
  String get reporterName => throw _privateConstructorUsedError;

  /// نوع المحتوى المبلغ عنه
  String get contentType =>
      throw _privateConstructorUsedError; // 'message', 'post', 'comment', 'user'
  /// معرف المحتوى المبلغ عنه
  String get contentId => throw _privateConstructorUsedError;

  /// معرف صاحب المحتوى
  String get reportedUserId => throw _privateConstructorUsedError;

  /// اسم صاحب المحتوى
  String? get reportedUserName => throw _privateConstructorUsedError;

  /// سبب التقرير
  String get reason => throw _privateConstructorUsedError;

  /// وصف تفصيلي
  String get description => throw _privateConstructorUsedError;

  /// لقطة شاشة أو دليل
  List<String> get evidenceUrls => throw _privateConstructorUsedError;

  /// معرف الكورس (إن وُجد)
  String? get courseId => throw _privateConstructorUsedError;

  /// معرف المراجع
  String? get reviewerId => throw _privateConstructorUsedError;

  /// اسم المراجع
  String? get reviewerName => throw _privateConstructorUsedError;

  /// الإجراء المتخذ
  ModerationAction get action => throw _privateConstructorUsedError;

  /// ملاحظات المراجع
  String? get reviewNotes => throw _privateConstructorUsedError;

  /// تاريخ الإنشاء
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// تاريخ المراجعة
  @TimestampConverter()
  DateTime? get reviewedAt => throw _privateConstructorUsedError;

  /// تاريخ الحل
  @TimestampConverter()
  DateTime? get resolvedAt => throw _privateConstructorUsedError;

  /// Tenant isolation
  String get institutionId => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;

  /// Serializes this Report to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Report
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportCopyWith<Report> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportCopyWith<$Res> {
  factory $ReportCopyWith(Report value, $Res Function(Report) then) =
      _$ReportCopyWithImpl<$Res, Report>;
  @useResult
  $Res call({
    String id,
    ReportType type,
    ReportStatus status,
    String reporterId,
    String reporterName,
    String contentType,
    String contentId,
    String reportedUserId,
    String? reportedUserName,
    String reason,
    String description,
    List<String> evidenceUrls,
    String? courseId,
    String? reviewerId,
    String? reviewerName,
    ModerationAction action,
    String? reviewNotes,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime? reviewedAt,
    @TimestampConverter() DateTime? resolvedAt,
    String institutionId,
    String companyId,
  });
}

/// @nodoc
class _$ReportCopyWithImpl<$Res, $Val extends Report>
    implements $ReportCopyWith<$Res> {
  _$ReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Report
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? reporterId = null,
    Object? reporterName = null,
    Object? contentType = null,
    Object? contentId = null,
    Object? reportedUserId = null,
    Object? reportedUserName = freezed,
    Object? reason = null,
    Object? description = null,
    Object? evidenceUrls = null,
    Object? courseId = freezed,
    Object? reviewerId = freezed,
    Object? reviewerName = freezed,
    Object? action = null,
    Object? reviewNotes = freezed,
    Object? createdAt = null,
    Object? reviewedAt = freezed,
    Object? resolvedAt = freezed,
    Object? institutionId = null,
    Object? companyId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ReportType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ReportStatus,
            reporterId: null == reporterId
                ? _value.reporterId
                : reporterId // ignore: cast_nullable_to_non_nullable
                      as String,
            reporterName: null == reporterName
                ? _value.reporterName
                : reporterName // ignore: cast_nullable_to_non_nullable
                      as String,
            contentType: null == contentType
                ? _value.contentType
                : contentType // ignore: cast_nullable_to_non_nullable
                      as String,
            contentId: null == contentId
                ? _value.contentId
                : contentId // ignore: cast_nullable_to_non_nullable
                      as String,
            reportedUserId: null == reportedUserId
                ? _value.reportedUserId
                : reportedUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            reportedUserName: freezed == reportedUserName
                ? _value.reportedUserName
                : reportedUserName // ignore: cast_nullable_to_non_nullable
                      as String?,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            evidenceUrls: null == evidenceUrls
                ? _value.evidenceUrls
                : evidenceUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            courseId: freezed == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String?,
            reviewerId: freezed == reviewerId
                ? _value.reviewerId
                : reviewerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            reviewerName: freezed == reviewerName
                ? _value.reviewerName
                : reviewerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            action: null == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as ModerationAction,
            reviewNotes: freezed == reviewNotes
                ? _value.reviewNotes
                : reviewNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            reviewedAt: freezed == reviewedAt
                ? _value.reviewedAt
                : reviewedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            resolvedAt: freezed == resolvedAt
                ? _value.resolvedAt
                : resolvedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: null == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReportImplCopyWith<$Res> implements $ReportCopyWith<$Res> {
  factory _$$ReportImplCopyWith(
    _$ReportImpl value,
    $Res Function(_$ReportImpl) then,
  ) = __$$ReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    ReportType type,
    ReportStatus status,
    String reporterId,
    String reporterName,
    String contentType,
    String contentId,
    String reportedUserId,
    String? reportedUserName,
    String reason,
    String description,
    List<String> evidenceUrls,
    String? courseId,
    String? reviewerId,
    String? reviewerName,
    ModerationAction action,
    String? reviewNotes,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime? reviewedAt,
    @TimestampConverter() DateTime? resolvedAt,
    String institutionId,
    String companyId,
  });
}

/// @nodoc
class __$$ReportImplCopyWithImpl<$Res>
    extends _$ReportCopyWithImpl<$Res, _$ReportImpl>
    implements _$$ReportImplCopyWith<$Res> {
  __$$ReportImplCopyWithImpl(
    _$ReportImpl _value,
    $Res Function(_$ReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Report
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? reporterId = null,
    Object? reporterName = null,
    Object? contentType = null,
    Object? contentId = null,
    Object? reportedUserId = null,
    Object? reportedUserName = freezed,
    Object? reason = null,
    Object? description = null,
    Object? evidenceUrls = null,
    Object? courseId = freezed,
    Object? reviewerId = freezed,
    Object? reviewerName = freezed,
    Object? action = null,
    Object? reviewNotes = freezed,
    Object? createdAt = null,
    Object? reviewedAt = freezed,
    Object? resolvedAt = freezed,
    Object? institutionId = null,
    Object? companyId = null,
  }) {
    return _then(
      _$ReportImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ReportType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ReportStatus,
        reporterId: null == reporterId
            ? _value.reporterId
            : reporterId // ignore: cast_nullable_to_non_nullable
                  as String,
        reporterName: null == reporterName
            ? _value.reporterName
            : reporterName // ignore: cast_nullable_to_non_nullable
                  as String,
        contentType: null == contentType
            ? _value.contentType
            : contentType // ignore: cast_nullable_to_non_nullable
                  as String,
        contentId: null == contentId
            ? _value.contentId
            : contentId // ignore: cast_nullable_to_non_nullable
                  as String,
        reportedUserId: null == reportedUserId
            ? _value.reportedUserId
            : reportedUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        reportedUserName: freezed == reportedUserName
            ? _value.reportedUserName
            : reportedUserName // ignore: cast_nullable_to_non_nullable
                  as String?,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        evidenceUrls: null == evidenceUrls
            ? _value._evidenceUrls
            : evidenceUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        courseId: freezed == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String?,
        reviewerId: freezed == reviewerId
            ? _value.reviewerId
            : reviewerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        reviewerName: freezed == reviewerName
            ? _value.reviewerName
            : reviewerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        action: null == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as ModerationAction,
        reviewNotes: freezed == reviewNotes
            ? _value.reviewNotes
            : reviewNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        reviewedAt: freezed == reviewedAt
            ? _value.reviewedAt
            : reviewedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        resolvedAt: freezed == resolvedAt
            ? _value.resolvedAt
            : resolvedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportImpl implements _Report {
  const _$ReportImpl({
    required this.id,
    required this.type,
    this.status = ReportStatus.pending,
    required this.reporterId,
    required this.reporterName,
    required this.contentType,
    required this.contentId,
    required this.reportedUserId,
    this.reportedUserName,
    required this.reason,
    this.description = '',
    final List<String> evidenceUrls = const [],
    this.courseId,
    this.reviewerId,
    this.reviewerName,
    this.action = ModerationAction.none,
    this.reviewNotes,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() this.reviewedAt,
    @TimestampConverter() this.resolvedAt,
    required this.institutionId,
    required this.companyId,
  }) : _evidenceUrls = evidenceUrls;

  factory _$ReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportImplFromJson(json);

  /// معرف التقرير
  @override
  final String id;

  /// نوع التقرير
  @override
  final ReportType type;

  /// حالة التقرير
  @override
  @JsonKey()
  final ReportStatus status;

  /// معرف المُبلِّغ
  @override
  final String reporterId;

  /// اسم المُبلِّغ
  @override
  final String reporterName;

  /// نوع المحتوى المبلغ عنه
  @override
  final String contentType;
  // 'message', 'post', 'comment', 'user'
  /// معرف المحتوى المبلغ عنه
  @override
  final String contentId;

  /// معرف صاحب المحتوى
  @override
  final String reportedUserId;

  /// اسم صاحب المحتوى
  @override
  final String? reportedUserName;

  /// سبب التقرير
  @override
  final String reason;

  /// وصف تفصيلي
  @override
  @JsonKey()
  final String description;

  /// لقطة شاشة أو دليل
  final List<String> _evidenceUrls;

  /// لقطة شاشة أو دليل
  @override
  @JsonKey()
  List<String> get evidenceUrls {
    if (_evidenceUrls is EqualUnmodifiableListView) return _evidenceUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_evidenceUrls);
  }

  /// معرف الكورس (إن وُجد)
  @override
  final String? courseId;

  /// معرف المراجع
  @override
  final String? reviewerId;

  /// اسم المراجع
  @override
  final String? reviewerName;

  /// الإجراء المتخذ
  @override
  @JsonKey()
  final ModerationAction action;

  /// ملاحظات المراجع
  @override
  final String? reviewNotes;

  /// تاريخ الإنشاء
  @override
  @TimestampConverter()
  final DateTime createdAt;

  /// تاريخ المراجعة
  @override
  @TimestampConverter()
  final DateTime? reviewedAt;

  /// تاريخ الحل
  @override
  @TimestampConverter()
  final DateTime? resolvedAt;

  /// Tenant isolation
  @override
  final String institutionId;
  @override
  final String companyId;

  @override
  String toString() {
    return 'Report(id: $id, type: $type, status: $status, reporterId: $reporterId, reporterName: $reporterName, contentType: $contentType, contentId: $contentId, reportedUserId: $reportedUserId, reportedUserName: $reportedUserName, reason: $reason, description: $description, evidenceUrls: $evidenceUrls, courseId: $courseId, reviewerId: $reviewerId, reviewerName: $reviewerName, action: $action, reviewNotes: $reviewNotes, createdAt: $createdAt, reviewedAt: $reviewedAt, resolvedAt: $resolvedAt, institutionId: $institutionId, companyId: $companyId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reporterId, reporterId) ||
                other.reporterId == reporterId) &&
            (identical(other.reporterName, reporterName) ||
                other.reporterName == reporterName) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.reportedUserId, reportedUserId) ||
                other.reportedUserId == reportedUserId) &&
            (identical(other.reportedUserName, reportedUserName) ||
                other.reportedUserName == reportedUserName) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._evidenceUrls,
              _evidenceUrls,
            ) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.reviewerId, reviewerId) ||
                other.reviewerId == reviewerId) &&
            (identical(other.reviewerName, reviewerName) ||
                other.reviewerName == reviewerName) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.reviewNotes, reviewNotes) ||
                other.reviewNotes == reviewNotes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.reviewedAt, reviewedAt) ||
                other.reviewedAt == reviewedAt) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    type,
    status,
    reporterId,
    reporterName,
    contentType,
    contentId,
    reportedUserId,
    reportedUserName,
    reason,
    description,
    const DeepCollectionEquality().hash(_evidenceUrls),
    courseId,
    reviewerId,
    reviewerName,
    action,
    reviewNotes,
    createdAt,
    reviewedAt,
    resolvedAt,
    institutionId,
    companyId,
  ]);

  /// Create a copy of Report
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportImplCopyWith<_$ReportImpl> get copyWith =>
      __$$ReportImplCopyWithImpl<_$ReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportImplToJson(this);
  }
}

abstract class _Report implements Report {
  const factory _Report({
    required final String id,
    required final ReportType type,
    final ReportStatus status,
    required final String reporterId,
    required final String reporterName,
    required final String contentType,
    required final String contentId,
    required final String reportedUserId,
    final String? reportedUserName,
    required final String reason,
    final String description,
    final List<String> evidenceUrls,
    final String? courseId,
    final String? reviewerId,
    final String? reviewerName,
    final ModerationAction action,
    final String? reviewNotes,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() final DateTime? reviewedAt,
    @TimestampConverter() final DateTime? resolvedAt,
    required final String institutionId,
    required final String companyId,
  }) = _$ReportImpl;

  factory _Report.fromJson(Map<String, dynamic> json) = _$ReportImpl.fromJson;

  /// معرف التقرير
  @override
  String get id;

  /// نوع التقرير
  @override
  ReportType get type;

  /// حالة التقرير
  @override
  ReportStatus get status;

  /// معرف المُبلِّغ
  @override
  String get reporterId;

  /// اسم المُبلِّغ
  @override
  String get reporterName;

  /// نوع المحتوى المبلغ عنه
  @override
  String get contentType; // 'message', 'post', 'comment', 'user'
  /// معرف المحتوى المبلغ عنه
  @override
  String get contentId;

  /// معرف صاحب المحتوى
  @override
  String get reportedUserId;

  /// اسم صاحب المحتوى
  @override
  String? get reportedUserName;

  /// سبب التقرير
  @override
  String get reason;

  /// وصف تفصيلي
  @override
  String get description;

  /// لقطة شاشة أو دليل
  @override
  List<String> get evidenceUrls;

  /// معرف الكورس (إن وُجد)
  @override
  String? get courseId;

  /// معرف المراجع
  @override
  String? get reviewerId;

  /// اسم المراجع
  @override
  String? get reviewerName;

  /// الإجراء المتخذ
  @override
  ModerationAction get action;

  /// ملاحظات المراجع
  @override
  String? get reviewNotes;

  /// تاريخ الإنشاء
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// تاريخ المراجعة
  @override
  @TimestampConverter()
  DateTime? get reviewedAt;

  /// تاريخ الحل
  @override
  @TimestampConverter()
  DateTime? get resolvedAt;

  /// Tenant isolation
  @override
  String get institutionId;
  @override
  String get companyId;

  /// Create a copy of Report
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportImplCopyWith<_$ReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ModerationLog _$ModerationLogFromJson(Map<String, dynamic> json) {
  return _ModerationLog.fromJson(json);
}

/// @nodoc
mixin _$ModerationLog {
  /// معرف السجل
  String get id => throw _privateConstructorUsedError;

  /// معرف المستخدم المُجرى عليه الإجراء
  String get targetUserId => throw _privateConstructorUsedError;

  /// اسم المستخدم
  String get targetUserName => throw _privateConstructorUsedError;

  /// الإجراء المتخذ
  ModerationAction get action => throw _privateConstructorUsedError;

  /// سبب الإجراء
  String get reason => throw _privateConstructorUsedError;

  /// مدة الإجراء (للإجراءات المؤقتة)
  int? get durationDays => throw _privateConstructorUsedError;

  /// تاريخ البدء
  @TimestampConverter()
  DateTime get startDate => throw _privateConstructorUsedError;

  /// تاريخ الانتهاء
  @TimestampConverter()
  DateTime? get endDate => throw _privateConstructorUsedError;

  /// معرف المشرف
  String get moderatorId => throw _privateConstructorUsedError;

  /// اسم المشرف
  String get moderatorName => throw _privateConstructorUsedError;

  /// معرف التقرير المرتبط
  String? get relatedReportId => throw _privateConstructorUsedError;

  /// ملاحظات
  String get notes => throw _privateConstructorUsedError;

  /// هل الإجراء نشط
  bool get isActive => throw _privateConstructorUsedError;

  /// تاريخ الإلغاء
  @TimestampConverter()
  DateTime? get cancelledAt => throw _privateConstructorUsedError;

  /// سبب الإلغاء
  String? get cancellationReason => throw _privateConstructorUsedError;

  /// Tenant isolation
  String get institutionId => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;

  /// Serializes this ModerationLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ModerationLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModerationLogCopyWith<ModerationLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModerationLogCopyWith<$Res> {
  factory $ModerationLogCopyWith(
    ModerationLog value,
    $Res Function(ModerationLog) then,
  ) = _$ModerationLogCopyWithImpl<$Res, ModerationLog>;
  @useResult
  $Res call({
    String id,
    String targetUserId,
    String targetUserName,
    ModerationAction action,
    String reason,
    int? durationDays,
    @TimestampConverter() DateTime startDate,
    @TimestampConverter() DateTime? endDate,
    String moderatorId,
    String moderatorName,
    String? relatedReportId,
    String notes,
    bool isActive,
    @TimestampConverter() DateTime? cancelledAt,
    String? cancellationReason,
    String institutionId,
    String companyId,
  });
}

/// @nodoc
class _$ModerationLogCopyWithImpl<$Res, $Val extends ModerationLog>
    implements $ModerationLogCopyWith<$Res> {
  _$ModerationLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModerationLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? targetUserId = null,
    Object? targetUserName = null,
    Object? action = null,
    Object? reason = null,
    Object? durationDays = freezed,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? moderatorId = null,
    Object? moderatorName = null,
    Object? relatedReportId = freezed,
    Object? notes = null,
    Object? isActive = null,
    Object? cancelledAt = freezed,
    Object? cancellationReason = freezed,
    Object? institutionId = null,
    Object? companyId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            targetUserId: null == targetUserId
                ? _value.targetUserId
                : targetUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            targetUserName: null == targetUserName
                ? _value.targetUserName
                : targetUserName // ignore: cast_nullable_to_non_nullable
                      as String,
            action: null == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as ModerationAction,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            durationDays: freezed == durationDays
                ? _value.durationDays
                : durationDays // ignore: cast_nullable_to_non_nullable
                      as int?,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            moderatorId: null == moderatorId
                ? _value.moderatorId
                : moderatorId // ignore: cast_nullable_to_non_nullable
                      as String,
            moderatorName: null == moderatorName
                ? _value.moderatorName
                : moderatorName // ignore: cast_nullable_to_non_nullable
                      as String,
            relatedReportId: freezed == relatedReportId
                ? _value.relatedReportId
                : relatedReportId // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            cancelledAt: freezed == cancelledAt
                ? _value.cancelledAt
                : cancelledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            cancellationReason: freezed == cancellationReason
                ? _value.cancellationReason
                : cancellationReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: null == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ModerationLogImplCopyWith<$Res>
    implements $ModerationLogCopyWith<$Res> {
  factory _$$ModerationLogImplCopyWith(
    _$ModerationLogImpl value,
    $Res Function(_$ModerationLogImpl) then,
  ) = __$$ModerationLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String targetUserId,
    String targetUserName,
    ModerationAction action,
    String reason,
    int? durationDays,
    @TimestampConverter() DateTime startDate,
    @TimestampConverter() DateTime? endDate,
    String moderatorId,
    String moderatorName,
    String? relatedReportId,
    String notes,
    bool isActive,
    @TimestampConverter() DateTime? cancelledAt,
    String? cancellationReason,
    String institutionId,
    String companyId,
  });
}

/// @nodoc
class __$$ModerationLogImplCopyWithImpl<$Res>
    extends _$ModerationLogCopyWithImpl<$Res, _$ModerationLogImpl>
    implements _$$ModerationLogImplCopyWith<$Res> {
  __$$ModerationLogImplCopyWithImpl(
    _$ModerationLogImpl _value,
    $Res Function(_$ModerationLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ModerationLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? targetUserId = null,
    Object? targetUserName = null,
    Object? action = null,
    Object? reason = null,
    Object? durationDays = freezed,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? moderatorId = null,
    Object? moderatorName = null,
    Object? relatedReportId = freezed,
    Object? notes = null,
    Object? isActive = null,
    Object? cancelledAt = freezed,
    Object? cancellationReason = freezed,
    Object? institutionId = null,
    Object? companyId = null,
  }) {
    return _then(
      _$ModerationLogImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        targetUserId: null == targetUserId
            ? _value.targetUserId
            : targetUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        targetUserName: null == targetUserName
            ? _value.targetUserName
            : targetUserName // ignore: cast_nullable_to_non_nullable
                  as String,
        action: null == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as ModerationAction,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        durationDays: freezed == durationDays
            ? _value.durationDays
            : durationDays // ignore: cast_nullable_to_non_nullable
                  as int?,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        moderatorId: null == moderatorId
            ? _value.moderatorId
            : moderatorId // ignore: cast_nullable_to_non_nullable
                  as String,
        moderatorName: null == moderatorName
            ? _value.moderatorName
            : moderatorName // ignore: cast_nullable_to_non_nullable
                  as String,
        relatedReportId: freezed == relatedReportId
            ? _value.relatedReportId
            : relatedReportId // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: null == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        cancelledAt: freezed == cancelledAt
            ? _value.cancelledAt
            : cancelledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cancellationReason: freezed == cancellationReason
            ? _value.cancellationReason
            : cancellationReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ModerationLogImpl implements _ModerationLog {
  const _$ModerationLogImpl({
    required this.id,
    required this.targetUserId,
    required this.targetUserName,
    required this.action,
    required this.reason,
    this.durationDays,
    @TimestampConverter() required this.startDate,
    @TimestampConverter() this.endDate,
    required this.moderatorId,
    required this.moderatorName,
    this.relatedReportId,
    this.notes = '',
    this.isActive = true,
    @TimestampConverter() this.cancelledAt,
    this.cancellationReason,
    required this.institutionId,
    required this.companyId,
  });

  factory _$ModerationLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModerationLogImplFromJson(json);

  /// معرف السجل
  @override
  final String id;

  /// معرف المستخدم المُجرى عليه الإجراء
  @override
  final String targetUserId;

  /// اسم المستخدم
  @override
  final String targetUserName;

  /// الإجراء المتخذ
  @override
  final ModerationAction action;

  /// سبب الإجراء
  @override
  final String reason;

  /// مدة الإجراء (للإجراءات المؤقتة)
  @override
  final int? durationDays;

  /// تاريخ البدء
  @override
  @TimestampConverter()
  final DateTime startDate;

  /// تاريخ الانتهاء
  @override
  @TimestampConverter()
  final DateTime? endDate;

  /// معرف المشرف
  @override
  final String moderatorId;

  /// اسم المشرف
  @override
  final String moderatorName;

  /// معرف التقرير المرتبط
  @override
  final String? relatedReportId;

  /// ملاحظات
  @override
  @JsonKey()
  final String notes;

  /// هل الإجراء نشط
  @override
  @JsonKey()
  final bool isActive;

  /// تاريخ الإلغاء
  @override
  @TimestampConverter()
  final DateTime? cancelledAt;

  /// سبب الإلغاء
  @override
  final String? cancellationReason;

  /// Tenant isolation
  @override
  final String institutionId;
  @override
  final String companyId;

  @override
  String toString() {
    return 'ModerationLog(id: $id, targetUserId: $targetUserId, targetUserName: $targetUserName, action: $action, reason: $reason, durationDays: $durationDays, startDate: $startDate, endDate: $endDate, moderatorId: $moderatorId, moderatorName: $moderatorName, relatedReportId: $relatedReportId, notes: $notes, isActive: $isActive, cancelledAt: $cancelledAt, cancellationReason: $cancellationReason, institutionId: $institutionId, companyId: $companyId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModerationLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.targetUserId, targetUserId) ||
                other.targetUserId == targetUserId) &&
            (identical(other.targetUserName, targetUserName) ||
                other.targetUserName == targetUserName) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.durationDays, durationDays) ||
                other.durationDays == durationDays) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.moderatorId, moderatorId) ||
                other.moderatorId == moderatorId) &&
            (identical(other.moderatorName, moderatorName) ||
                other.moderatorName == moderatorName) &&
            (identical(other.relatedReportId, relatedReportId) ||
                other.relatedReportId == relatedReportId) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.cancellationReason, cancellationReason) ||
                other.cancellationReason == cancellationReason) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    targetUserId,
    targetUserName,
    action,
    reason,
    durationDays,
    startDate,
    endDate,
    moderatorId,
    moderatorName,
    relatedReportId,
    notes,
    isActive,
    cancelledAt,
    cancellationReason,
    institutionId,
    companyId,
  );

  /// Create a copy of ModerationLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModerationLogImplCopyWith<_$ModerationLogImpl> get copyWith =>
      __$$ModerationLogImplCopyWithImpl<_$ModerationLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModerationLogImplToJson(this);
  }
}

abstract class _ModerationLog implements ModerationLog {
  const factory _ModerationLog({
    required final String id,
    required final String targetUserId,
    required final String targetUserName,
    required final ModerationAction action,
    required final String reason,
    final int? durationDays,
    @TimestampConverter() required final DateTime startDate,
    @TimestampConverter() final DateTime? endDate,
    required final String moderatorId,
    required final String moderatorName,
    final String? relatedReportId,
    final String notes,
    final bool isActive,
    @TimestampConverter() final DateTime? cancelledAt,
    final String? cancellationReason,
    required final String institutionId,
    required final String companyId,
  }) = _$ModerationLogImpl;

  factory _ModerationLog.fromJson(Map<String, dynamic> json) =
      _$ModerationLogImpl.fromJson;

  /// معرف السجل
  @override
  String get id;

  /// معرف المستخدم المُجرى عليه الإجراء
  @override
  String get targetUserId;

  /// اسم المستخدم
  @override
  String get targetUserName;

  /// الإجراء المتخذ
  @override
  ModerationAction get action;

  /// سبب الإجراء
  @override
  String get reason;

  /// مدة الإجراء (للإجراءات المؤقتة)
  @override
  int? get durationDays;

  /// تاريخ البدء
  @override
  @TimestampConverter()
  DateTime get startDate;

  /// تاريخ الانتهاء
  @override
  @TimestampConverter()
  DateTime? get endDate;

  /// معرف المشرف
  @override
  String get moderatorId;

  /// اسم المشرف
  @override
  String get moderatorName;

  /// معرف التقرير المرتبط
  @override
  String? get relatedReportId;

  /// ملاحظات
  @override
  String get notes;

  /// هل الإجراء نشط
  @override
  bool get isActive;

  /// تاريخ الإلغاء
  @override
  @TimestampConverter()
  DateTime? get cancelledAt;

  /// سبب الإلغاء
  @override
  String? get cancellationReason;

  /// Tenant isolation
  @override
  String get institutionId;
  @override
  String get companyId;

  /// Create a copy of ModerationLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModerationLogImplCopyWith<_$ModerationLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContentFilter _$ContentFilterFromJson(Map<String, dynamic> json) {
  return _ContentFilter.fromJson(json);
}

/// @nodoc
mixin _$ContentFilter {
  /// معرف الفلتر
  String get id => throw _privateConstructorUsedError;

  /// الكلمات المحظورة
  List<String> get bannedWords => throw _privateConstructorUsedError;

  /// الأنماط المحظورة (regex)
  List<String> get bannedPatterns => throw _privateConstructorUsedError;

  /// الروابط المسموحة (whitelist)
  List<String> get allowedDomains => throw _privateConstructorUsedError;

  /// هل التصفية نشطة
  bool get isActive => throw _privateConstructorUsedError;

  /// حساسية التصفية (1-10)
  int get sensitivity => throw _privateConstructorUsedError;

  /// إجراء تلقائي عند الكشف
  ModerationAction get autoAction => throw _privateConstructorUsedError;

  /// إشعار المشرف تلقائياً
  bool get notifyModerator => throw _privateConstructorUsedError;

  /// Tenant isolation
  String get institutionId => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;

  /// Serializes this ContentFilter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContentFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentFilterCopyWith<ContentFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentFilterCopyWith<$Res> {
  factory $ContentFilterCopyWith(
    ContentFilter value,
    $Res Function(ContentFilter) then,
  ) = _$ContentFilterCopyWithImpl<$Res, ContentFilter>;
  @useResult
  $Res call({
    String id,
    List<String> bannedWords,
    List<String> bannedPatterns,
    List<String> allowedDomains,
    bool isActive,
    int sensitivity,
    ModerationAction autoAction,
    bool notifyModerator,
    String institutionId,
    String companyId,
  });
}

/// @nodoc
class _$ContentFilterCopyWithImpl<$Res, $Val extends ContentFilter>
    implements $ContentFilterCopyWith<$Res> {
  _$ContentFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bannedWords = null,
    Object? bannedPatterns = null,
    Object? allowedDomains = null,
    Object? isActive = null,
    Object? sensitivity = null,
    Object? autoAction = null,
    Object? notifyModerator = null,
    Object? institutionId = null,
    Object? companyId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            bannedWords: null == bannedWords
                ? _value.bannedWords
                : bannedWords // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            bannedPatterns: null == bannedPatterns
                ? _value.bannedPatterns
                : bannedPatterns // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            allowedDomains: null == allowedDomains
                ? _value.allowedDomains
                : allowedDomains // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            sensitivity: null == sensitivity
                ? _value.sensitivity
                : sensitivity // ignore: cast_nullable_to_non_nullable
                      as int,
            autoAction: null == autoAction
                ? _value.autoAction
                : autoAction // ignore: cast_nullable_to_non_nullable
                      as ModerationAction,
            notifyModerator: null == notifyModerator
                ? _value.notifyModerator
                : notifyModerator // ignore: cast_nullable_to_non_nullable
                      as bool,
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: null == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContentFilterImplCopyWith<$Res>
    implements $ContentFilterCopyWith<$Res> {
  factory _$$ContentFilterImplCopyWith(
    _$ContentFilterImpl value,
    $Res Function(_$ContentFilterImpl) then,
  ) = __$$ContentFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    List<String> bannedWords,
    List<String> bannedPatterns,
    List<String> allowedDomains,
    bool isActive,
    int sensitivity,
    ModerationAction autoAction,
    bool notifyModerator,
    String institutionId,
    String companyId,
  });
}

/// @nodoc
class __$$ContentFilterImplCopyWithImpl<$Res>
    extends _$ContentFilterCopyWithImpl<$Res, _$ContentFilterImpl>
    implements _$$ContentFilterImplCopyWith<$Res> {
  __$$ContentFilterImplCopyWithImpl(
    _$ContentFilterImpl _value,
    $Res Function(_$ContentFilterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContentFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bannedWords = null,
    Object? bannedPatterns = null,
    Object? allowedDomains = null,
    Object? isActive = null,
    Object? sensitivity = null,
    Object? autoAction = null,
    Object? notifyModerator = null,
    Object? institutionId = null,
    Object? companyId = null,
  }) {
    return _then(
      _$ContentFilterImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        bannedWords: null == bannedWords
            ? _value._bannedWords
            : bannedWords // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        bannedPatterns: null == bannedPatterns
            ? _value._bannedPatterns
            : bannedPatterns // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        allowedDomains: null == allowedDomains
            ? _value._allowedDomains
            : allowedDomains // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        sensitivity: null == sensitivity
            ? _value.sensitivity
            : sensitivity // ignore: cast_nullable_to_non_nullable
                  as int,
        autoAction: null == autoAction
            ? _value.autoAction
            : autoAction // ignore: cast_nullable_to_non_nullable
                  as ModerationAction,
        notifyModerator: null == notifyModerator
            ? _value.notifyModerator
            : notifyModerator // ignore: cast_nullable_to_non_nullable
                  as bool,
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentFilterImpl implements _ContentFilter {
  const _$ContentFilterImpl({
    required this.id,
    final List<String> bannedWords = const [],
    final List<String> bannedPatterns = const [],
    final List<String> allowedDomains = const [],
    this.isActive = true,
    this.sensitivity = 5,
    this.autoAction = ModerationAction.hideContent,
    this.notifyModerator = true,
    required this.institutionId,
    required this.companyId,
  }) : _bannedWords = bannedWords,
       _bannedPatterns = bannedPatterns,
       _allowedDomains = allowedDomains;

  factory _$ContentFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentFilterImplFromJson(json);

  /// معرف الفلتر
  @override
  final String id;

  /// الكلمات المحظورة
  final List<String> _bannedWords;

  /// الكلمات المحظورة
  @override
  @JsonKey()
  List<String> get bannedWords {
    if (_bannedWords is EqualUnmodifiableListView) return _bannedWords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bannedWords);
  }

  /// الأنماط المحظورة (regex)
  final List<String> _bannedPatterns;

  /// الأنماط المحظورة (regex)
  @override
  @JsonKey()
  List<String> get bannedPatterns {
    if (_bannedPatterns is EqualUnmodifiableListView) return _bannedPatterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bannedPatterns);
  }

  /// الروابط المسموحة (whitelist)
  final List<String> _allowedDomains;

  /// الروابط المسموحة (whitelist)
  @override
  @JsonKey()
  List<String> get allowedDomains {
    if (_allowedDomains is EqualUnmodifiableListView) return _allowedDomains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedDomains);
  }

  /// هل التصفية نشطة
  @override
  @JsonKey()
  final bool isActive;

  /// حساسية التصفية (1-10)
  @override
  @JsonKey()
  final int sensitivity;

  /// إجراء تلقائي عند الكشف
  @override
  @JsonKey()
  final ModerationAction autoAction;

  /// إشعار المشرف تلقائياً
  @override
  @JsonKey()
  final bool notifyModerator;

  /// Tenant isolation
  @override
  final String institutionId;
  @override
  final String companyId;

  @override
  String toString() {
    return 'ContentFilter(id: $id, bannedWords: $bannedWords, bannedPatterns: $bannedPatterns, allowedDomains: $allowedDomains, isActive: $isActive, sensitivity: $sensitivity, autoAction: $autoAction, notifyModerator: $notifyModerator, institutionId: $institutionId, companyId: $companyId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentFilterImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(
              other._bannedWords,
              _bannedWords,
            ) &&
            const DeepCollectionEquality().equals(
              other._bannedPatterns,
              _bannedPatterns,
            ) &&
            const DeepCollectionEquality().equals(
              other._allowedDomains,
              _allowedDomains,
            ) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.sensitivity, sensitivity) ||
                other.sensitivity == sensitivity) &&
            (identical(other.autoAction, autoAction) ||
                other.autoAction == autoAction) &&
            (identical(other.notifyModerator, notifyModerator) ||
                other.notifyModerator == notifyModerator) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    const DeepCollectionEquality().hash(_bannedWords),
    const DeepCollectionEquality().hash(_bannedPatterns),
    const DeepCollectionEquality().hash(_allowedDomains),
    isActive,
    sensitivity,
    autoAction,
    notifyModerator,
    institutionId,
    companyId,
  );

  /// Create a copy of ContentFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentFilterImplCopyWith<_$ContentFilterImpl> get copyWith =>
      __$$ContentFilterImplCopyWithImpl<_$ContentFilterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentFilterImplToJson(this);
  }
}

abstract class _ContentFilter implements ContentFilter {
  const factory _ContentFilter({
    required final String id,
    final List<String> bannedWords,
    final List<String> bannedPatterns,
    final List<String> allowedDomains,
    final bool isActive,
    final int sensitivity,
    final ModerationAction autoAction,
    final bool notifyModerator,
    required final String institutionId,
    required final String companyId,
  }) = _$ContentFilterImpl;

  factory _ContentFilter.fromJson(Map<String, dynamic> json) =
      _$ContentFilterImpl.fromJson;

  /// معرف الفلتر
  @override
  String get id;

  /// الكلمات المحظورة
  @override
  List<String> get bannedWords;

  /// الأنماط المحظورة (regex)
  @override
  List<String> get bannedPatterns;

  /// الروابط المسموحة (whitelist)
  @override
  List<String> get allowedDomains;

  /// هل التصفية نشطة
  @override
  bool get isActive;

  /// حساسية التصفية (1-10)
  @override
  int get sensitivity;

  /// إجراء تلقائي عند الكشف
  @override
  ModerationAction get autoAction;

  /// إشعار المشرف تلقائياً
  @override
  bool get notifyModerator;

  /// Tenant isolation
  @override
  String get institutionId;
  @override
  String get companyId;

  /// Create a copy of ContentFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentFilterImplCopyWith<_$ContentFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ModerationStats _$ModerationStatsFromJson(Map<String, dynamic> json) {
  return _ModerationStats.fromJson(json);
}

/// @nodoc
mixin _$ModerationStats {
  /// عدد التقارير الكلي
  int get totalReports => throw _privateConstructorUsedError;

  /// التقارير قيد المراجعة
  int get pendingReports => throw _privateConstructorUsedError;

  /// التقارير التي تم حلها
  int get resolvedReports => throw _privateConstructorUsedError;

  /// التقارير المرفوضة
  int get dismissedReports => throw _privateConstructorUsedError;

  /// عدد الإجراءات المتخذة
  int get totalActions => throw _privateConstructorUsedError;

  /// عدد المستخدمين المحظورين
  int get bannedUsers => throw _privateConstructorUsedError;

  /// عدد المستخدمين المكتومين
  int get mutedUsers => throw _privateConstructorUsedError;

  /// متوسط وقت المراجعة (بالساعات)
  double get avgReviewTimeHours => throw _privateConstructorUsedError;

  /// التوزيع حسب النوع
  Map<String, int> get reportsByType => throw _privateConstructorUsedError;

  /// Serializes this ModerationStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ModerationStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModerationStatsCopyWith<ModerationStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModerationStatsCopyWith<$Res> {
  factory $ModerationStatsCopyWith(
    ModerationStats value,
    $Res Function(ModerationStats) then,
  ) = _$ModerationStatsCopyWithImpl<$Res, ModerationStats>;
  @useResult
  $Res call({
    int totalReports,
    int pendingReports,
    int resolvedReports,
    int dismissedReports,
    int totalActions,
    int bannedUsers,
    int mutedUsers,
    double avgReviewTimeHours,
    Map<String, int> reportsByType,
  });
}

/// @nodoc
class _$ModerationStatsCopyWithImpl<$Res, $Val extends ModerationStats>
    implements $ModerationStatsCopyWith<$Res> {
  _$ModerationStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModerationStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalReports = null,
    Object? pendingReports = null,
    Object? resolvedReports = null,
    Object? dismissedReports = null,
    Object? totalActions = null,
    Object? bannedUsers = null,
    Object? mutedUsers = null,
    Object? avgReviewTimeHours = null,
    Object? reportsByType = null,
  }) {
    return _then(
      _value.copyWith(
            totalReports: null == totalReports
                ? _value.totalReports
                : totalReports // ignore: cast_nullable_to_non_nullable
                      as int,
            pendingReports: null == pendingReports
                ? _value.pendingReports
                : pendingReports // ignore: cast_nullable_to_non_nullable
                      as int,
            resolvedReports: null == resolvedReports
                ? _value.resolvedReports
                : resolvedReports // ignore: cast_nullable_to_non_nullable
                      as int,
            dismissedReports: null == dismissedReports
                ? _value.dismissedReports
                : dismissedReports // ignore: cast_nullable_to_non_nullable
                      as int,
            totalActions: null == totalActions
                ? _value.totalActions
                : totalActions // ignore: cast_nullable_to_non_nullable
                      as int,
            bannedUsers: null == bannedUsers
                ? _value.bannedUsers
                : bannedUsers // ignore: cast_nullable_to_non_nullable
                      as int,
            mutedUsers: null == mutedUsers
                ? _value.mutedUsers
                : mutedUsers // ignore: cast_nullable_to_non_nullable
                      as int,
            avgReviewTimeHours: null == avgReviewTimeHours
                ? _value.avgReviewTimeHours
                : avgReviewTimeHours // ignore: cast_nullable_to_non_nullable
                      as double,
            reportsByType: null == reportsByType
                ? _value.reportsByType
                : reportsByType // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ModerationStatsImplCopyWith<$Res>
    implements $ModerationStatsCopyWith<$Res> {
  factory _$$ModerationStatsImplCopyWith(
    _$ModerationStatsImpl value,
    $Res Function(_$ModerationStatsImpl) then,
  ) = __$$ModerationStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalReports,
    int pendingReports,
    int resolvedReports,
    int dismissedReports,
    int totalActions,
    int bannedUsers,
    int mutedUsers,
    double avgReviewTimeHours,
    Map<String, int> reportsByType,
  });
}

/// @nodoc
class __$$ModerationStatsImplCopyWithImpl<$Res>
    extends _$ModerationStatsCopyWithImpl<$Res, _$ModerationStatsImpl>
    implements _$$ModerationStatsImplCopyWith<$Res> {
  __$$ModerationStatsImplCopyWithImpl(
    _$ModerationStatsImpl _value,
    $Res Function(_$ModerationStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ModerationStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalReports = null,
    Object? pendingReports = null,
    Object? resolvedReports = null,
    Object? dismissedReports = null,
    Object? totalActions = null,
    Object? bannedUsers = null,
    Object? mutedUsers = null,
    Object? avgReviewTimeHours = null,
    Object? reportsByType = null,
  }) {
    return _then(
      _$ModerationStatsImpl(
        totalReports: null == totalReports
            ? _value.totalReports
            : totalReports // ignore: cast_nullable_to_non_nullable
                  as int,
        pendingReports: null == pendingReports
            ? _value.pendingReports
            : pendingReports // ignore: cast_nullable_to_non_nullable
                  as int,
        resolvedReports: null == resolvedReports
            ? _value.resolvedReports
            : resolvedReports // ignore: cast_nullable_to_non_nullable
                  as int,
        dismissedReports: null == dismissedReports
            ? _value.dismissedReports
            : dismissedReports // ignore: cast_nullable_to_non_nullable
                  as int,
        totalActions: null == totalActions
            ? _value.totalActions
            : totalActions // ignore: cast_nullable_to_non_nullable
                  as int,
        bannedUsers: null == bannedUsers
            ? _value.bannedUsers
            : bannedUsers // ignore: cast_nullable_to_non_nullable
                  as int,
        mutedUsers: null == mutedUsers
            ? _value.mutedUsers
            : mutedUsers // ignore: cast_nullable_to_non_nullable
                  as int,
        avgReviewTimeHours: null == avgReviewTimeHours
            ? _value.avgReviewTimeHours
            : avgReviewTimeHours // ignore: cast_nullable_to_non_nullable
                  as double,
        reportsByType: null == reportsByType
            ? _value._reportsByType
            : reportsByType // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ModerationStatsImpl implements _ModerationStats {
  const _$ModerationStatsImpl({
    this.totalReports = 0,
    this.pendingReports = 0,
    this.resolvedReports = 0,
    this.dismissedReports = 0,
    this.totalActions = 0,
    this.bannedUsers = 0,
    this.mutedUsers = 0,
    this.avgReviewTimeHours = 0.0,
    final Map<String, int> reportsByType = const {},
  }) : _reportsByType = reportsByType;

  factory _$ModerationStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModerationStatsImplFromJson(json);

  /// عدد التقارير الكلي
  @override
  @JsonKey()
  final int totalReports;

  /// التقارير قيد المراجعة
  @override
  @JsonKey()
  final int pendingReports;

  /// التقارير التي تم حلها
  @override
  @JsonKey()
  final int resolvedReports;

  /// التقارير المرفوضة
  @override
  @JsonKey()
  final int dismissedReports;

  /// عدد الإجراءات المتخذة
  @override
  @JsonKey()
  final int totalActions;

  /// عدد المستخدمين المحظورين
  @override
  @JsonKey()
  final int bannedUsers;

  /// عدد المستخدمين المكتومين
  @override
  @JsonKey()
  final int mutedUsers;

  /// متوسط وقت المراجعة (بالساعات)
  @override
  @JsonKey()
  final double avgReviewTimeHours;

  /// التوزيع حسب النوع
  final Map<String, int> _reportsByType;

  /// التوزيع حسب النوع
  @override
  @JsonKey()
  Map<String, int> get reportsByType {
    if (_reportsByType is EqualUnmodifiableMapView) return _reportsByType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_reportsByType);
  }

  @override
  String toString() {
    return 'ModerationStats(totalReports: $totalReports, pendingReports: $pendingReports, resolvedReports: $resolvedReports, dismissedReports: $dismissedReports, totalActions: $totalActions, bannedUsers: $bannedUsers, mutedUsers: $mutedUsers, avgReviewTimeHours: $avgReviewTimeHours, reportsByType: $reportsByType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModerationStatsImpl &&
            (identical(other.totalReports, totalReports) ||
                other.totalReports == totalReports) &&
            (identical(other.pendingReports, pendingReports) ||
                other.pendingReports == pendingReports) &&
            (identical(other.resolvedReports, resolvedReports) ||
                other.resolvedReports == resolvedReports) &&
            (identical(other.dismissedReports, dismissedReports) ||
                other.dismissedReports == dismissedReports) &&
            (identical(other.totalActions, totalActions) ||
                other.totalActions == totalActions) &&
            (identical(other.bannedUsers, bannedUsers) ||
                other.bannedUsers == bannedUsers) &&
            (identical(other.mutedUsers, mutedUsers) ||
                other.mutedUsers == mutedUsers) &&
            (identical(other.avgReviewTimeHours, avgReviewTimeHours) ||
                other.avgReviewTimeHours == avgReviewTimeHours) &&
            const DeepCollectionEquality().equals(
              other._reportsByType,
              _reportsByType,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalReports,
    pendingReports,
    resolvedReports,
    dismissedReports,
    totalActions,
    bannedUsers,
    mutedUsers,
    avgReviewTimeHours,
    const DeepCollectionEquality().hash(_reportsByType),
  );

  /// Create a copy of ModerationStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModerationStatsImplCopyWith<_$ModerationStatsImpl> get copyWith =>
      __$$ModerationStatsImplCopyWithImpl<_$ModerationStatsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ModerationStatsImplToJson(this);
  }
}

abstract class _ModerationStats implements ModerationStats {
  const factory _ModerationStats({
    final int totalReports,
    final int pendingReports,
    final int resolvedReports,
    final int dismissedReports,
    final int totalActions,
    final int bannedUsers,
    final int mutedUsers,
    final double avgReviewTimeHours,
    final Map<String, int> reportsByType,
  }) = _$ModerationStatsImpl;

  factory _ModerationStats.fromJson(Map<String, dynamic> json) =
      _$ModerationStatsImpl.fromJson;

  /// عدد التقارير الكلي
  @override
  int get totalReports;

  /// التقارير قيد المراجعة
  @override
  int get pendingReports;

  /// التقارير التي تم حلها
  @override
  int get resolvedReports;

  /// التقارير المرفوضة
  @override
  int get dismissedReports;

  /// عدد الإجراءات المتخذة
  @override
  int get totalActions;

  /// عدد المستخدمين المحظورين
  @override
  int get bannedUsers;

  /// عدد المستخدمين المكتومين
  @override
  int get mutedUsers;

  /// متوسط وقت المراجعة (بالساعات)
  @override
  double get avgReviewTimeHours;

  /// التوزيع حسب النوع
  @override
  Map<String, int> get reportsByType;

  /// Create a copy of ModerationStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModerationStatsImplCopyWith<_$ModerationStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
