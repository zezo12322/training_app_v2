// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'certificate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Certificate _$CertificateFromJson(Map<String, dynamic> json) {
  return _Certificate.fromJson(json);
}

/// @nodoc
mixin _$Certificate {
  /// معرف الشهادة
  String get id => throw _privateConstructorUsedError;

  /// معرف المستخدم
  String get userId => throw _privateConstructorUsedError;

  /// اسم المستخدم
  String get userName => throw _privateConstructorUsedError;

  /// البريد الإلكتروني
  String get userEmail => throw _privateConstructorUsedError;

  /// معرف الكورس
  String get courseId => throw _privateConstructorUsedError;

  /// اسم الكورس
  String get courseName => throw _privateConstructorUsedError;

  /// نوع الشهادة
  CertificateType get type => throw _privateConstructorUsedError;

  /// حالة الشهادة
  CertificateStatus get status => throw _privateConstructorUsedError;

  /// رقم الشهادة (فريد)
  String get certificateNumber => throw _privateConstructorUsedError;

  /// الدرجة النهائية (0-100)
  double? get finalGrade => throw _privateConstructorUsedError;

  /// نسبة الإتمام (0-100)
  double get completionPercentage => throw _privateConstructorUsedError;

  /// عدد ساعات الدراسة
  double? get studyHours => throw _privateConstructorUsedError;

  /// اسم المدرب
  String? get trainerName => throw _privateConstructorUsedError;

  /// توقيع المدرب (URL)
  String? get trainerSignatureUrl => throw _privateConstructorUsedError;

  /// الشعار (URL)
  String? get logoUrl => throw _privateConstructorUsedError;

  /// URL ملف PDF
  String? get pdfUrl => throw _privateConstructorUsedError;

  /// رمز QR (data URL)
  String? get qrCodeData => throw _privateConstructorUsedError;

  /// URL التحقق
  String? get verificationUrl => throw _privateConstructorUsedError;

  /// تاريخ الإصدار
  @TimestampConverter()
  DateTime get issuedAt => throw _privateConstructorUsedError;

  /// تاريخ انتهاء الصلاحية (optional)
  @TimestampConverter()
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// تاريخ الإلغاء
  @TimestampConverter()
  DateTime? get revokedAt => throw _privateConstructorUsedError;

  /// سبب الإلغاء
  String? get revocationReason => throw _privateConstructorUsedError;

  /// البيانات الإضافية
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Tenant isolation
  String get institutionId => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;

  /// Serializes this Certificate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Certificate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CertificateCopyWith<Certificate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CertificateCopyWith<$Res> {
  factory $CertificateCopyWith(
    Certificate value,
    $Res Function(Certificate) then,
  ) = _$CertificateCopyWithImpl<$Res, Certificate>;
  @useResult
  $Res call({
    String id,
    String userId,
    String userName,
    String userEmail,
    String courseId,
    String courseName,
    CertificateType type,
    CertificateStatus status,
    String certificateNumber,
    double? finalGrade,
    double completionPercentage,
    double? studyHours,
    String? trainerName,
    String? trainerSignatureUrl,
    String? logoUrl,
    String? pdfUrl,
    String? qrCodeData,
    String? verificationUrl,
    @TimestampConverter() DateTime issuedAt,
    @TimestampConverter() DateTime? expiresAt,
    @TimestampConverter() DateTime? revokedAt,
    String? revocationReason,
    Map<String, dynamic> metadata,
    String institutionId,
    String companyId,
  });
}

/// @nodoc
class _$CertificateCopyWithImpl<$Res, $Val extends Certificate>
    implements $CertificateCopyWith<$Res> {
  _$CertificateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Certificate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? userEmail = null,
    Object? courseId = null,
    Object? courseName = null,
    Object? type = null,
    Object? status = null,
    Object? certificateNumber = null,
    Object? finalGrade = freezed,
    Object? completionPercentage = null,
    Object? studyHours = freezed,
    Object? trainerName = freezed,
    Object? trainerSignatureUrl = freezed,
    Object? logoUrl = freezed,
    Object? pdfUrl = freezed,
    Object? qrCodeData = freezed,
    Object? verificationUrl = freezed,
    Object? issuedAt = null,
    Object? expiresAt = freezed,
    Object? revokedAt = freezed,
    Object? revocationReason = freezed,
    Object? metadata = null,
    Object? institutionId = null,
    Object? companyId = null,
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
            userEmail: null == userEmail
                ? _value.userEmail
                : userEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            courseName: null == courseName
                ? _value.courseName
                : courseName // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as CertificateType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as CertificateStatus,
            certificateNumber: null == certificateNumber
                ? _value.certificateNumber
                : certificateNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            finalGrade: freezed == finalGrade
                ? _value.finalGrade
                : finalGrade // ignore: cast_nullable_to_non_nullable
                      as double?,
            completionPercentage: null == completionPercentage
                ? _value.completionPercentage
                : completionPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
            studyHours: freezed == studyHours
                ? _value.studyHours
                : studyHours // ignore: cast_nullable_to_non_nullable
                      as double?,
            trainerName: freezed == trainerName
                ? _value.trainerName
                : trainerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            trainerSignatureUrl: freezed == trainerSignatureUrl
                ? _value.trainerSignatureUrl
                : trainerSignatureUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            logoUrl: freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            pdfUrl: freezed == pdfUrl
                ? _value.pdfUrl
                : pdfUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            qrCodeData: freezed == qrCodeData
                ? _value.qrCodeData
                : qrCodeData // ignore: cast_nullable_to_non_nullable
                      as String?,
            verificationUrl: freezed == verificationUrl
                ? _value.verificationUrl
                : verificationUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            issuedAt: null == issuedAt
                ? _value.issuedAt
                : issuedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            revokedAt: freezed == revokedAt
                ? _value.revokedAt
                : revokedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            revocationReason: freezed == revocationReason
                ? _value.revocationReason
                : revocationReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
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
abstract class _$$CertificateImplCopyWith<$Res>
    implements $CertificateCopyWith<$Res> {
  factory _$$CertificateImplCopyWith(
    _$CertificateImpl value,
    $Res Function(_$CertificateImpl) then,
  ) = __$$CertificateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String userName,
    String userEmail,
    String courseId,
    String courseName,
    CertificateType type,
    CertificateStatus status,
    String certificateNumber,
    double? finalGrade,
    double completionPercentage,
    double? studyHours,
    String? trainerName,
    String? trainerSignatureUrl,
    String? logoUrl,
    String? pdfUrl,
    String? qrCodeData,
    String? verificationUrl,
    @TimestampConverter() DateTime issuedAt,
    @TimestampConverter() DateTime? expiresAt,
    @TimestampConverter() DateTime? revokedAt,
    String? revocationReason,
    Map<String, dynamic> metadata,
    String institutionId,
    String companyId,
  });
}

/// @nodoc
class __$$CertificateImplCopyWithImpl<$Res>
    extends _$CertificateCopyWithImpl<$Res, _$CertificateImpl>
    implements _$$CertificateImplCopyWith<$Res> {
  __$$CertificateImplCopyWithImpl(
    _$CertificateImpl _value,
    $Res Function(_$CertificateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Certificate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? userEmail = null,
    Object? courseId = null,
    Object? courseName = null,
    Object? type = null,
    Object? status = null,
    Object? certificateNumber = null,
    Object? finalGrade = freezed,
    Object? completionPercentage = null,
    Object? studyHours = freezed,
    Object? trainerName = freezed,
    Object? trainerSignatureUrl = freezed,
    Object? logoUrl = freezed,
    Object? pdfUrl = freezed,
    Object? qrCodeData = freezed,
    Object? verificationUrl = freezed,
    Object? issuedAt = null,
    Object? expiresAt = freezed,
    Object? revokedAt = freezed,
    Object? revocationReason = freezed,
    Object? metadata = null,
    Object? institutionId = null,
    Object? companyId = null,
  }) {
    return _then(
      _$CertificateImpl(
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
        userEmail: null == userEmail
            ? _value.userEmail
            : userEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        courseName: null == courseName
            ? _value.courseName
            : courseName // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as CertificateType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CertificateStatus,
        certificateNumber: null == certificateNumber
            ? _value.certificateNumber
            : certificateNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        finalGrade: freezed == finalGrade
            ? _value.finalGrade
            : finalGrade // ignore: cast_nullable_to_non_nullable
                  as double?,
        completionPercentage: null == completionPercentage
            ? _value.completionPercentage
            : completionPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
        studyHours: freezed == studyHours
            ? _value.studyHours
            : studyHours // ignore: cast_nullable_to_non_nullable
                  as double?,
        trainerName: freezed == trainerName
            ? _value.trainerName
            : trainerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        trainerSignatureUrl: freezed == trainerSignatureUrl
            ? _value.trainerSignatureUrl
            : trainerSignatureUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        logoUrl: freezed == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        pdfUrl: freezed == pdfUrl
            ? _value.pdfUrl
            : pdfUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        qrCodeData: freezed == qrCodeData
            ? _value.qrCodeData
            : qrCodeData // ignore: cast_nullable_to_non_nullable
                  as String?,
        verificationUrl: freezed == verificationUrl
            ? _value.verificationUrl
            : verificationUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        issuedAt: null == issuedAt
            ? _value.issuedAt
            : issuedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        revokedAt: freezed == revokedAt
            ? _value.revokedAt
            : revokedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        revocationReason: freezed == revocationReason
            ? _value.revocationReason
            : revocationReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
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
class _$CertificateImpl implements _Certificate {
  const _$CertificateImpl({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.courseId,
    required this.courseName,
    required this.type,
    this.status = CertificateStatus.active,
    required this.certificateNumber,
    this.finalGrade,
    this.completionPercentage = 100.0,
    this.studyHours,
    this.trainerName,
    this.trainerSignatureUrl,
    this.logoUrl,
    this.pdfUrl,
    this.qrCodeData,
    this.verificationUrl,
    @TimestampConverter() required this.issuedAt,
    @TimestampConverter() this.expiresAt,
    @TimestampConverter() this.revokedAt,
    this.revocationReason,
    final Map<String, dynamic> metadata = const {},
    required this.institutionId,
    required this.companyId,
  }) : _metadata = metadata;

  factory _$CertificateImpl.fromJson(Map<String, dynamic> json) =>
      _$$CertificateImplFromJson(json);

  /// معرف الشهادة
  @override
  final String id;

  /// معرف المستخدم
  @override
  final String userId;

  /// اسم المستخدم
  @override
  final String userName;

  /// البريد الإلكتروني
  @override
  final String userEmail;

  /// معرف الكورس
  @override
  final String courseId;

  /// اسم الكورس
  @override
  final String courseName;

  /// نوع الشهادة
  @override
  final CertificateType type;

  /// حالة الشهادة
  @override
  @JsonKey()
  final CertificateStatus status;

  /// رقم الشهادة (فريد)
  @override
  final String certificateNumber;

  /// الدرجة النهائية (0-100)
  @override
  final double? finalGrade;

  /// نسبة الإتمام (0-100)
  @override
  @JsonKey()
  final double completionPercentage;

  /// عدد ساعات الدراسة
  @override
  final double? studyHours;

  /// اسم المدرب
  @override
  final String? trainerName;

  /// توقيع المدرب (URL)
  @override
  final String? trainerSignatureUrl;

  /// الشعار (URL)
  @override
  final String? logoUrl;

  /// URL ملف PDF
  @override
  final String? pdfUrl;

  /// رمز QR (data URL)
  @override
  final String? qrCodeData;

  /// URL التحقق
  @override
  final String? verificationUrl;

  /// تاريخ الإصدار
  @override
  @TimestampConverter()
  final DateTime issuedAt;

  /// تاريخ انتهاء الصلاحية (optional)
  @override
  @TimestampConverter()
  final DateTime? expiresAt;

  /// تاريخ الإلغاء
  @override
  @TimestampConverter()
  final DateTime? revokedAt;

  /// سبب الإلغاء
  @override
  final String? revocationReason;

  /// البيانات الإضافية
  final Map<String, dynamic> _metadata;

  /// البيانات الإضافية
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  /// Tenant isolation
  @override
  final String institutionId;
  @override
  final String companyId;

  @override
  String toString() {
    return 'Certificate(id: $id, userId: $userId, userName: $userName, userEmail: $userEmail, courseId: $courseId, courseName: $courseName, type: $type, status: $status, certificateNumber: $certificateNumber, finalGrade: $finalGrade, completionPercentage: $completionPercentage, studyHours: $studyHours, trainerName: $trainerName, trainerSignatureUrl: $trainerSignatureUrl, logoUrl: $logoUrl, pdfUrl: $pdfUrl, qrCodeData: $qrCodeData, verificationUrl: $verificationUrl, issuedAt: $issuedAt, expiresAt: $expiresAt, revokedAt: $revokedAt, revocationReason: $revocationReason, metadata: $metadata, institutionId: $institutionId, companyId: $companyId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CertificateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.certificateNumber, certificateNumber) ||
                other.certificateNumber == certificateNumber) &&
            (identical(other.finalGrade, finalGrade) ||
                other.finalGrade == finalGrade) &&
            (identical(other.completionPercentage, completionPercentage) ||
                other.completionPercentage == completionPercentage) &&
            (identical(other.studyHours, studyHours) ||
                other.studyHours == studyHours) &&
            (identical(other.trainerName, trainerName) ||
                other.trainerName == trainerName) &&
            (identical(other.trainerSignatureUrl, trainerSignatureUrl) ||
                other.trainerSignatureUrl == trainerSignatureUrl) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.pdfUrl, pdfUrl) || other.pdfUrl == pdfUrl) &&
            (identical(other.qrCodeData, qrCodeData) ||
                other.qrCodeData == qrCodeData) &&
            (identical(other.verificationUrl, verificationUrl) ||
                other.verificationUrl == verificationUrl) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.revokedAt, revokedAt) ||
                other.revokedAt == revokedAt) &&
            (identical(other.revocationReason, revocationReason) ||
                other.revocationReason == revocationReason) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
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
    userId,
    userName,
    userEmail,
    courseId,
    courseName,
    type,
    status,
    certificateNumber,
    finalGrade,
    completionPercentage,
    studyHours,
    trainerName,
    trainerSignatureUrl,
    logoUrl,
    pdfUrl,
    qrCodeData,
    verificationUrl,
    issuedAt,
    expiresAt,
    revokedAt,
    revocationReason,
    const DeepCollectionEquality().hash(_metadata),
    institutionId,
    companyId,
  ]);

  /// Create a copy of Certificate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CertificateImplCopyWith<_$CertificateImpl> get copyWith =>
      __$$CertificateImplCopyWithImpl<_$CertificateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CertificateImplToJson(this);
  }
}

abstract class _Certificate implements Certificate {
  const factory _Certificate({
    required final String id,
    required final String userId,
    required final String userName,
    required final String userEmail,
    required final String courseId,
    required final String courseName,
    required final CertificateType type,
    final CertificateStatus status,
    required final String certificateNumber,
    final double? finalGrade,
    final double completionPercentage,
    final double? studyHours,
    final String? trainerName,
    final String? trainerSignatureUrl,
    final String? logoUrl,
    final String? pdfUrl,
    final String? qrCodeData,
    final String? verificationUrl,
    @TimestampConverter() required final DateTime issuedAt,
    @TimestampConverter() final DateTime? expiresAt,
    @TimestampConverter() final DateTime? revokedAt,
    final String? revocationReason,
    final Map<String, dynamic> metadata,
    required final String institutionId,
    required final String companyId,
  }) = _$CertificateImpl;

  factory _Certificate.fromJson(Map<String, dynamic> json) =
      _$CertificateImpl.fromJson;

  /// معرف الشهادة
  @override
  String get id;

  /// معرف المستخدم
  @override
  String get userId;

  /// اسم المستخدم
  @override
  String get userName;

  /// البريد الإلكتروني
  @override
  String get userEmail;

  /// معرف الكورس
  @override
  String get courseId;

  /// اسم الكورس
  @override
  String get courseName;

  /// نوع الشهادة
  @override
  CertificateType get type;

  /// حالة الشهادة
  @override
  CertificateStatus get status;

  /// رقم الشهادة (فريد)
  @override
  String get certificateNumber;

  /// الدرجة النهائية (0-100)
  @override
  double? get finalGrade;

  /// نسبة الإتمام (0-100)
  @override
  double get completionPercentage;

  /// عدد ساعات الدراسة
  @override
  double? get studyHours;

  /// اسم المدرب
  @override
  String? get trainerName;

  /// توقيع المدرب (URL)
  @override
  String? get trainerSignatureUrl;

  /// الشعار (URL)
  @override
  String? get logoUrl;

  /// URL ملف PDF
  @override
  String? get pdfUrl;

  /// رمز QR (data URL)
  @override
  String? get qrCodeData;

  /// URL التحقق
  @override
  String? get verificationUrl;

  /// تاريخ الإصدار
  @override
  @TimestampConverter()
  DateTime get issuedAt;

  /// تاريخ انتهاء الصلاحية (optional)
  @override
  @TimestampConverter()
  DateTime? get expiresAt;

  /// تاريخ الإلغاء
  @override
  @TimestampConverter()
  DateTime? get revokedAt;

  /// سبب الإلغاء
  @override
  String? get revocationReason;

  /// البيانات الإضافية
  @override
  Map<String, dynamic> get metadata;

  /// Tenant isolation
  @override
  String get institutionId;
  @override
  String get companyId;

  /// Create a copy of Certificate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CertificateImplCopyWith<_$CertificateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CertificateTemplate _$CertificateTemplateFromJson(Map<String, dynamic> json) {
  return _CertificateTemplate.fromJson(json);
}

/// @nodoc
mixin _$CertificateTemplate {
  /// معرف القالب
  String get id => throw _privateConstructorUsedError;

  /// اسم القالب
  String get name => throw _privateConstructorUsedError;

  /// نوع الشهادة
  CertificateType get type => throw _privateConstructorUsedError;

  /// العنوان
  String get title => throw _privateConstructorUsedError;

  /// النص الأساسي (يمكن أن يحتوي على placeholders)
  String get bodyText => throw _privateConstructorUsedError;

  /// اللون الأساسي
  String get primaryColor => throw _privateConstructorUsedError;

  /// اللون الثانوي
  String get secondaryColor => throw _privateConstructorUsedError;

  /// الخط المستخدم
  String get fontFamily => throw _privateConstructorUsedError;

  /// صورة الخلفية (URL)
  String? get backgroundImageUrl => throw _privateConstructorUsedError;

  /// الشعار (URL)
  String? get logoUrl => throw _privateConstructorUsedError;

  /// حجم الشهادة
  String get pageSize => throw _privateConstructorUsedError;

  /// الاتجاه
  String get orientation => throw _privateConstructorUsedError;

  /// هل القالب نشط
  bool get isActive => throw _privateConstructorUsedError;

  /// الإعدادات الإضافية
  Map<String, dynamic> get settings => throw _privateConstructorUsedError;

  /// Serializes this CertificateTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CertificateTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CertificateTemplateCopyWith<CertificateTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CertificateTemplateCopyWith<$Res> {
  factory $CertificateTemplateCopyWith(
    CertificateTemplate value,
    $Res Function(CertificateTemplate) then,
  ) = _$CertificateTemplateCopyWithImpl<$Res, CertificateTemplate>;
  @useResult
  $Res call({
    String id,
    String name,
    CertificateType type,
    String title,
    String bodyText,
    String primaryColor,
    String secondaryColor,
    String fontFamily,
    String? backgroundImageUrl,
    String? logoUrl,
    String pageSize,
    String orientation,
    bool isActive,
    Map<String, dynamic> settings,
  });
}

/// @nodoc
class _$CertificateTemplateCopyWithImpl<$Res, $Val extends CertificateTemplate>
    implements $CertificateTemplateCopyWith<$Res> {
  _$CertificateTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CertificateTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? title = null,
    Object? bodyText = null,
    Object? primaryColor = null,
    Object? secondaryColor = null,
    Object? fontFamily = null,
    Object? backgroundImageUrl = freezed,
    Object? logoUrl = freezed,
    Object? pageSize = null,
    Object? orientation = null,
    Object? isActive = null,
    Object? settings = null,
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
                      as CertificateType,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            bodyText: null == bodyText
                ? _value.bodyText
                : bodyText // ignore: cast_nullable_to_non_nullable
                      as String,
            primaryColor: null == primaryColor
                ? _value.primaryColor
                : primaryColor // ignore: cast_nullable_to_non_nullable
                      as String,
            secondaryColor: null == secondaryColor
                ? _value.secondaryColor
                : secondaryColor // ignore: cast_nullable_to_non_nullable
                      as String,
            fontFamily: null == fontFamily
                ? _value.fontFamily
                : fontFamily // ignore: cast_nullable_to_non_nullable
                      as String,
            backgroundImageUrl: freezed == backgroundImageUrl
                ? _value.backgroundImageUrl
                : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            logoUrl: freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            pageSize: null == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                      as String,
            orientation: null == orientation
                ? _value.orientation
                : orientation // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            settings: null == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CertificateTemplateImplCopyWith<$Res>
    implements $CertificateTemplateCopyWith<$Res> {
  factory _$$CertificateTemplateImplCopyWith(
    _$CertificateTemplateImpl value,
    $Res Function(_$CertificateTemplateImpl) then,
  ) = __$$CertificateTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    CertificateType type,
    String title,
    String bodyText,
    String primaryColor,
    String secondaryColor,
    String fontFamily,
    String? backgroundImageUrl,
    String? logoUrl,
    String pageSize,
    String orientation,
    bool isActive,
    Map<String, dynamic> settings,
  });
}

/// @nodoc
class __$$CertificateTemplateImplCopyWithImpl<$Res>
    extends _$CertificateTemplateCopyWithImpl<$Res, _$CertificateTemplateImpl>
    implements _$$CertificateTemplateImplCopyWith<$Res> {
  __$$CertificateTemplateImplCopyWithImpl(
    _$CertificateTemplateImpl _value,
    $Res Function(_$CertificateTemplateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CertificateTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? title = null,
    Object? bodyText = null,
    Object? primaryColor = null,
    Object? secondaryColor = null,
    Object? fontFamily = null,
    Object? backgroundImageUrl = freezed,
    Object? logoUrl = freezed,
    Object? pageSize = null,
    Object? orientation = null,
    Object? isActive = null,
    Object? settings = null,
  }) {
    return _then(
      _$CertificateTemplateImpl(
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
                  as CertificateType,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        bodyText: null == bodyText
            ? _value.bodyText
            : bodyText // ignore: cast_nullable_to_non_nullable
                  as String,
        primaryColor: null == primaryColor
            ? _value.primaryColor
            : primaryColor // ignore: cast_nullable_to_non_nullable
                  as String,
        secondaryColor: null == secondaryColor
            ? _value.secondaryColor
            : secondaryColor // ignore: cast_nullable_to_non_nullable
                  as String,
        fontFamily: null == fontFamily
            ? _value.fontFamily
            : fontFamily // ignore: cast_nullable_to_non_nullable
                  as String,
        backgroundImageUrl: freezed == backgroundImageUrl
            ? _value.backgroundImageUrl
            : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        logoUrl: freezed == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        pageSize: null == pageSize
            ? _value.pageSize
            : pageSize // ignore: cast_nullable_to_non_nullable
                  as String,
        orientation: null == orientation
            ? _value.orientation
            : orientation // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        settings: null == settings
            ? _value._settings
            : settings // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CertificateTemplateImpl implements _CertificateTemplate {
  const _$CertificateTemplateImpl({
    required this.id,
    required this.name,
    required this.type,
    required this.title,
    required this.bodyText,
    this.primaryColor = '#1976D2',
    this.secondaryColor = '#FFC107',
    this.fontFamily = 'Cairo',
    this.backgroundImageUrl,
    this.logoUrl,
    this.pageSize = 'A4',
    this.orientation = 'landscape',
    this.isActive = true,
    final Map<String, dynamic> settings = const {},
  }) : _settings = settings;

  factory _$CertificateTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$CertificateTemplateImplFromJson(json);

  /// معرف القالب
  @override
  final String id;

  /// اسم القالب
  @override
  final String name;

  /// نوع الشهادة
  @override
  final CertificateType type;

  /// العنوان
  @override
  final String title;

  /// النص الأساسي (يمكن أن يحتوي على placeholders)
  @override
  final String bodyText;

  /// اللون الأساسي
  @override
  @JsonKey()
  final String primaryColor;

  /// اللون الثانوي
  @override
  @JsonKey()
  final String secondaryColor;

  /// الخط المستخدم
  @override
  @JsonKey()
  final String fontFamily;

  /// صورة الخلفية (URL)
  @override
  final String? backgroundImageUrl;

  /// الشعار (URL)
  @override
  final String? logoUrl;

  /// حجم الشهادة
  @override
  @JsonKey()
  final String pageSize;

  /// الاتجاه
  @override
  @JsonKey()
  final String orientation;

  /// هل القالب نشط
  @override
  @JsonKey()
  final bool isActive;

  /// الإعدادات الإضافية
  final Map<String, dynamic> _settings;

  /// الإعدادات الإضافية
  @override
  @JsonKey()
  Map<String, dynamic> get settings {
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_settings);
  }

  @override
  String toString() {
    return 'CertificateTemplate(id: $id, name: $name, type: $type, title: $title, bodyText: $bodyText, primaryColor: $primaryColor, secondaryColor: $secondaryColor, fontFamily: $fontFamily, backgroundImageUrl: $backgroundImageUrl, logoUrl: $logoUrl, pageSize: $pageSize, orientation: $orientation, isActive: $isActive, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CertificateTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.bodyText, bodyText) ||
                other.bodyText == bodyText) &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.secondaryColor, secondaryColor) ||
                other.secondaryColor == secondaryColor) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(other.backgroundImageUrl, backgroundImageUrl) ||
                other.backgroundImageUrl == backgroundImageUrl) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.orientation, orientation) ||
                other.orientation == orientation) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._settings, _settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    title,
    bodyText,
    primaryColor,
    secondaryColor,
    fontFamily,
    backgroundImageUrl,
    logoUrl,
    pageSize,
    orientation,
    isActive,
    const DeepCollectionEquality().hash(_settings),
  );

  /// Create a copy of CertificateTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CertificateTemplateImplCopyWith<_$CertificateTemplateImpl> get copyWith =>
      __$$CertificateTemplateImplCopyWithImpl<_$CertificateTemplateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CertificateTemplateImplToJson(this);
  }
}

abstract class _CertificateTemplate implements CertificateTemplate {
  const factory _CertificateTemplate({
    required final String id,
    required final String name,
    required final CertificateType type,
    required final String title,
    required final String bodyText,
    final String primaryColor,
    final String secondaryColor,
    final String fontFamily,
    final String? backgroundImageUrl,
    final String? logoUrl,
    final String pageSize,
    final String orientation,
    final bool isActive,
    final Map<String, dynamic> settings,
  }) = _$CertificateTemplateImpl;

  factory _CertificateTemplate.fromJson(Map<String, dynamic> json) =
      _$CertificateTemplateImpl.fromJson;

  /// معرف القالب
  @override
  String get id;

  /// اسم القالب
  @override
  String get name;

  /// نوع الشهادة
  @override
  CertificateType get type;

  /// العنوان
  @override
  String get title;

  /// النص الأساسي (يمكن أن يحتوي على placeholders)
  @override
  String get bodyText;

  /// اللون الأساسي
  @override
  String get primaryColor;

  /// اللون الثانوي
  @override
  String get secondaryColor;

  /// الخط المستخدم
  @override
  String get fontFamily;

  /// صورة الخلفية (URL)
  @override
  String? get backgroundImageUrl;

  /// الشعار (URL)
  @override
  String? get logoUrl;

  /// حجم الشهادة
  @override
  String get pageSize;

  /// الاتجاه
  @override
  String get orientation;

  /// هل القالب نشط
  @override
  bool get isActive;

  /// الإعدادات الإضافية
  @override
  Map<String, dynamic> get settings;

  /// Create a copy of CertificateTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CertificateTemplateImplCopyWith<_$CertificateTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CertificateRequirements _$CertificateRequirementsFromJson(
  Map<String, dynamic> json,
) {
  return _CertificateRequirements.fromJson(json);
}

/// @nodoc
mixin _$CertificateRequirements {
  /// معرف الكورس
  String get courseId => throw _privateConstructorUsedError;

  /// نسبة الإتمام المطلوبة (0-100)
  double get minimumCompletion => throw _privateConstructorUsedError;

  /// الدرجة الدنيا المطلوبة (0-100)
  double? get minimumGrade => throw _privateConstructorUsedError;

  /// الحد الأدنى من الحضور (%)
  double? get minimumAttendance => throw _privateConstructorUsedError;

  /// الحد الأدنى من النقاط
  int? get minimumPoints => throw _privateConstructorUsedError;

  /// المدة الزمنية المطلوبة (بالساعات)
  double? get minimumStudyHours => throw _privateConstructorUsedError;

  /// الاختبارات المطلوبة
  List<String> get requiredQuizzes => throw _privateConstructorUsedError;

  /// المهام المطلوبة
  List<String> get requiredAssignments => throw _privateConstructorUsedError;

  /// الإنجازات المطلوبة
  List<String> get requiredAchievements => throw _privateConstructorUsedError;

  /// Serializes this CertificateRequirements to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CertificateRequirements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CertificateRequirementsCopyWith<CertificateRequirements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CertificateRequirementsCopyWith<$Res> {
  factory $CertificateRequirementsCopyWith(
    CertificateRequirements value,
    $Res Function(CertificateRequirements) then,
  ) = _$CertificateRequirementsCopyWithImpl<$Res, CertificateRequirements>;
  @useResult
  $Res call({
    String courseId,
    double minimumCompletion,
    double? minimumGrade,
    double? minimumAttendance,
    int? minimumPoints,
    double? minimumStudyHours,
    List<String> requiredQuizzes,
    List<String> requiredAssignments,
    List<String> requiredAchievements,
  });
}

/// @nodoc
class _$CertificateRequirementsCopyWithImpl<
  $Res,
  $Val extends CertificateRequirements
>
    implements $CertificateRequirementsCopyWith<$Res> {
  _$CertificateRequirementsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CertificateRequirements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? minimumCompletion = null,
    Object? minimumGrade = freezed,
    Object? minimumAttendance = freezed,
    Object? minimumPoints = freezed,
    Object? minimumStudyHours = freezed,
    Object? requiredQuizzes = null,
    Object? requiredAssignments = null,
    Object? requiredAchievements = null,
  }) {
    return _then(
      _value.copyWith(
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            minimumCompletion: null == minimumCompletion
                ? _value.minimumCompletion
                : minimumCompletion // ignore: cast_nullable_to_non_nullable
                      as double,
            minimumGrade: freezed == minimumGrade
                ? _value.minimumGrade
                : minimumGrade // ignore: cast_nullable_to_non_nullable
                      as double?,
            minimumAttendance: freezed == minimumAttendance
                ? _value.minimumAttendance
                : minimumAttendance // ignore: cast_nullable_to_non_nullable
                      as double?,
            minimumPoints: freezed == minimumPoints
                ? _value.minimumPoints
                : minimumPoints // ignore: cast_nullable_to_non_nullable
                      as int?,
            minimumStudyHours: freezed == minimumStudyHours
                ? _value.minimumStudyHours
                : minimumStudyHours // ignore: cast_nullable_to_non_nullable
                      as double?,
            requiredQuizzes: null == requiredQuizzes
                ? _value.requiredQuizzes
                : requiredQuizzes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            requiredAssignments: null == requiredAssignments
                ? _value.requiredAssignments
                : requiredAssignments // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            requiredAchievements: null == requiredAchievements
                ? _value.requiredAchievements
                : requiredAchievements // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CertificateRequirementsImplCopyWith<$Res>
    implements $CertificateRequirementsCopyWith<$Res> {
  factory _$$CertificateRequirementsImplCopyWith(
    _$CertificateRequirementsImpl value,
    $Res Function(_$CertificateRequirementsImpl) then,
  ) = __$$CertificateRequirementsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String courseId,
    double minimumCompletion,
    double? minimumGrade,
    double? minimumAttendance,
    int? minimumPoints,
    double? minimumStudyHours,
    List<String> requiredQuizzes,
    List<String> requiredAssignments,
    List<String> requiredAchievements,
  });
}

/// @nodoc
class __$$CertificateRequirementsImplCopyWithImpl<$Res>
    extends
        _$CertificateRequirementsCopyWithImpl<
          $Res,
          _$CertificateRequirementsImpl
        >
    implements _$$CertificateRequirementsImplCopyWith<$Res> {
  __$$CertificateRequirementsImplCopyWithImpl(
    _$CertificateRequirementsImpl _value,
    $Res Function(_$CertificateRequirementsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CertificateRequirements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? minimumCompletion = null,
    Object? minimumGrade = freezed,
    Object? minimumAttendance = freezed,
    Object? minimumPoints = freezed,
    Object? minimumStudyHours = freezed,
    Object? requiredQuizzes = null,
    Object? requiredAssignments = null,
    Object? requiredAchievements = null,
  }) {
    return _then(
      _$CertificateRequirementsImpl(
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        minimumCompletion: null == minimumCompletion
            ? _value.minimumCompletion
            : minimumCompletion // ignore: cast_nullable_to_non_nullable
                  as double,
        minimumGrade: freezed == minimumGrade
            ? _value.minimumGrade
            : minimumGrade // ignore: cast_nullable_to_non_nullable
                  as double?,
        minimumAttendance: freezed == minimumAttendance
            ? _value.minimumAttendance
            : minimumAttendance // ignore: cast_nullable_to_non_nullable
                  as double?,
        minimumPoints: freezed == minimumPoints
            ? _value.minimumPoints
            : minimumPoints // ignore: cast_nullable_to_non_nullable
                  as int?,
        minimumStudyHours: freezed == minimumStudyHours
            ? _value.minimumStudyHours
            : minimumStudyHours // ignore: cast_nullable_to_non_nullable
                  as double?,
        requiredQuizzes: null == requiredQuizzes
            ? _value._requiredQuizzes
            : requiredQuizzes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        requiredAssignments: null == requiredAssignments
            ? _value._requiredAssignments
            : requiredAssignments // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        requiredAchievements: null == requiredAchievements
            ? _value._requiredAchievements
            : requiredAchievements // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CertificateRequirementsImpl implements _CertificateRequirements {
  const _$CertificateRequirementsImpl({
    required this.courseId,
    this.minimumCompletion = 100.0,
    this.minimumGrade,
    this.minimumAttendance,
    this.minimumPoints,
    this.minimumStudyHours,
    final List<String> requiredQuizzes = const [],
    final List<String> requiredAssignments = const [],
    final List<String> requiredAchievements = const [],
  }) : _requiredQuizzes = requiredQuizzes,
       _requiredAssignments = requiredAssignments,
       _requiredAchievements = requiredAchievements;

  factory _$CertificateRequirementsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CertificateRequirementsImplFromJson(json);

  /// معرف الكورس
  @override
  final String courseId;

  /// نسبة الإتمام المطلوبة (0-100)
  @override
  @JsonKey()
  final double minimumCompletion;

  /// الدرجة الدنيا المطلوبة (0-100)
  @override
  final double? minimumGrade;

  /// الحد الأدنى من الحضور (%)
  @override
  final double? minimumAttendance;

  /// الحد الأدنى من النقاط
  @override
  final int? minimumPoints;

  /// المدة الزمنية المطلوبة (بالساعات)
  @override
  final double? minimumStudyHours;

  /// الاختبارات المطلوبة
  final List<String> _requiredQuizzes;

  /// الاختبارات المطلوبة
  @override
  @JsonKey()
  List<String> get requiredQuizzes {
    if (_requiredQuizzes is EqualUnmodifiableListView) return _requiredQuizzes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredQuizzes);
  }

  /// المهام المطلوبة
  final List<String> _requiredAssignments;

  /// المهام المطلوبة
  @override
  @JsonKey()
  List<String> get requiredAssignments {
    if (_requiredAssignments is EqualUnmodifiableListView)
      return _requiredAssignments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredAssignments);
  }

  /// الإنجازات المطلوبة
  final List<String> _requiredAchievements;

  /// الإنجازات المطلوبة
  @override
  @JsonKey()
  List<String> get requiredAchievements {
    if (_requiredAchievements is EqualUnmodifiableListView)
      return _requiredAchievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredAchievements);
  }

  @override
  String toString() {
    return 'CertificateRequirements(courseId: $courseId, minimumCompletion: $minimumCompletion, minimumGrade: $minimumGrade, minimumAttendance: $minimumAttendance, minimumPoints: $minimumPoints, minimumStudyHours: $minimumStudyHours, requiredQuizzes: $requiredQuizzes, requiredAssignments: $requiredAssignments, requiredAchievements: $requiredAchievements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CertificateRequirementsImpl &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.minimumCompletion, minimumCompletion) ||
                other.minimumCompletion == minimumCompletion) &&
            (identical(other.minimumGrade, minimumGrade) ||
                other.minimumGrade == minimumGrade) &&
            (identical(other.minimumAttendance, minimumAttendance) ||
                other.minimumAttendance == minimumAttendance) &&
            (identical(other.minimumPoints, minimumPoints) ||
                other.minimumPoints == minimumPoints) &&
            (identical(other.minimumStudyHours, minimumStudyHours) ||
                other.minimumStudyHours == minimumStudyHours) &&
            const DeepCollectionEquality().equals(
              other._requiredQuizzes,
              _requiredQuizzes,
            ) &&
            const DeepCollectionEquality().equals(
              other._requiredAssignments,
              _requiredAssignments,
            ) &&
            const DeepCollectionEquality().equals(
              other._requiredAchievements,
              _requiredAchievements,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    courseId,
    minimumCompletion,
    minimumGrade,
    minimumAttendance,
    minimumPoints,
    minimumStudyHours,
    const DeepCollectionEquality().hash(_requiredQuizzes),
    const DeepCollectionEquality().hash(_requiredAssignments),
    const DeepCollectionEquality().hash(_requiredAchievements),
  );

  /// Create a copy of CertificateRequirements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CertificateRequirementsImplCopyWith<_$CertificateRequirementsImpl>
  get copyWith =>
      __$$CertificateRequirementsImplCopyWithImpl<
        _$CertificateRequirementsImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CertificateRequirementsImplToJson(this);
  }
}

abstract class _CertificateRequirements implements CertificateRequirements {
  const factory _CertificateRequirements({
    required final String courseId,
    final double minimumCompletion,
    final double? minimumGrade,
    final double? minimumAttendance,
    final int? minimumPoints,
    final double? minimumStudyHours,
    final List<String> requiredQuizzes,
    final List<String> requiredAssignments,
    final List<String> requiredAchievements,
  }) = _$CertificateRequirementsImpl;

  factory _CertificateRequirements.fromJson(Map<String, dynamic> json) =
      _$CertificateRequirementsImpl.fromJson;

  /// معرف الكورس
  @override
  String get courseId;

  /// نسبة الإتمام المطلوبة (0-100)
  @override
  double get minimumCompletion;

  /// الدرجة الدنيا المطلوبة (0-100)
  @override
  double? get minimumGrade;

  /// الحد الأدنى من الحضور (%)
  @override
  double? get minimumAttendance;

  /// الحد الأدنى من النقاط
  @override
  int? get minimumPoints;

  /// المدة الزمنية المطلوبة (بالساعات)
  @override
  double? get minimumStudyHours;

  /// الاختبارات المطلوبة
  @override
  List<String> get requiredQuizzes;

  /// المهام المطلوبة
  @override
  List<String> get requiredAssignments;

  /// الإنجازات المطلوبة
  @override
  List<String> get requiredAchievements;

  /// Create a copy of CertificateRequirements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CertificateRequirementsImplCopyWith<_$CertificateRequirementsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CertificateVerification _$CertificateVerificationFromJson(
  Map<String, dynamic> json,
) {
  return _CertificateVerification.fromJson(json);
}

/// @nodoc
mixin _$CertificateVerification {
  /// هل الشهادة صالحة
  bool get isValid => throw _privateConstructorUsedError;

  /// معلومات الشهادة (إذا كانت صالحة)
  Certificate? get certificate => throw _privateConstructorUsedError;

  /// سبب عدم الصلاحية
  String? get invalidReason => throw _privateConstructorUsedError;

  /// تاريخ التحقق
  @TimestampConverter()
  DateTime get verifiedAt => throw _privateConstructorUsedError;

  /// Serializes this CertificateVerification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CertificateVerification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CertificateVerificationCopyWith<CertificateVerification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CertificateVerificationCopyWith<$Res> {
  factory $CertificateVerificationCopyWith(
    CertificateVerification value,
    $Res Function(CertificateVerification) then,
  ) = _$CertificateVerificationCopyWithImpl<$Res, CertificateVerification>;
  @useResult
  $Res call({
    bool isValid,
    Certificate? certificate,
    String? invalidReason,
    @TimestampConverter() DateTime verifiedAt,
  });

  $CertificateCopyWith<$Res>? get certificate;
}

/// @nodoc
class _$CertificateVerificationCopyWithImpl<
  $Res,
  $Val extends CertificateVerification
>
    implements $CertificateVerificationCopyWith<$Res> {
  _$CertificateVerificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CertificateVerification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isValid = null,
    Object? certificate = freezed,
    Object? invalidReason = freezed,
    Object? verifiedAt = null,
  }) {
    return _then(
      _value.copyWith(
            isValid: null == isValid
                ? _value.isValid
                : isValid // ignore: cast_nullable_to_non_nullable
                      as bool,
            certificate: freezed == certificate
                ? _value.certificate
                : certificate // ignore: cast_nullable_to_non_nullable
                      as Certificate?,
            invalidReason: freezed == invalidReason
                ? _value.invalidReason
                : invalidReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            verifiedAt: null == verifiedAt
                ? _value.verifiedAt
                : verifiedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of CertificateVerification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CertificateCopyWith<$Res>? get certificate {
    if (_value.certificate == null) {
      return null;
    }

    return $CertificateCopyWith<$Res>(_value.certificate!, (value) {
      return _then(_value.copyWith(certificate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CertificateVerificationImplCopyWith<$Res>
    implements $CertificateVerificationCopyWith<$Res> {
  factory _$$CertificateVerificationImplCopyWith(
    _$CertificateVerificationImpl value,
    $Res Function(_$CertificateVerificationImpl) then,
  ) = __$$CertificateVerificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isValid,
    Certificate? certificate,
    String? invalidReason,
    @TimestampConverter() DateTime verifiedAt,
  });

  @override
  $CertificateCopyWith<$Res>? get certificate;
}

/// @nodoc
class __$$CertificateVerificationImplCopyWithImpl<$Res>
    extends
        _$CertificateVerificationCopyWithImpl<
          $Res,
          _$CertificateVerificationImpl
        >
    implements _$$CertificateVerificationImplCopyWith<$Res> {
  __$$CertificateVerificationImplCopyWithImpl(
    _$CertificateVerificationImpl _value,
    $Res Function(_$CertificateVerificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CertificateVerification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isValid = null,
    Object? certificate = freezed,
    Object? invalidReason = freezed,
    Object? verifiedAt = null,
  }) {
    return _then(
      _$CertificateVerificationImpl(
        isValid: null == isValid
            ? _value.isValid
            : isValid // ignore: cast_nullable_to_non_nullable
                  as bool,
        certificate: freezed == certificate
            ? _value.certificate
            : certificate // ignore: cast_nullable_to_non_nullable
                  as Certificate?,
        invalidReason: freezed == invalidReason
            ? _value.invalidReason
            : invalidReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        verifiedAt: null == verifiedAt
            ? _value.verifiedAt
            : verifiedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CertificateVerificationImpl implements _CertificateVerification {
  const _$CertificateVerificationImpl({
    required this.isValid,
    this.certificate,
    this.invalidReason,
    @TimestampConverter() required this.verifiedAt,
  });

  factory _$CertificateVerificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CertificateVerificationImplFromJson(json);

  /// هل الشهادة صالحة
  @override
  final bool isValid;

  /// معلومات الشهادة (إذا كانت صالحة)
  @override
  final Certificate? certificate;

  /// سبب عدم الصلاحية
  @override
  final String? invalidReason;

  /// تاريخ التحقق
  @override
  @TimestampConverter()
  final DateTime verifiedAt;

  @override
  String toString() {
    return 'CertificateVerification(isValid: $isValid, certificate: $certificate, invalidReason: $invalidReason, verifiedAt: $verifiedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CertificateVerificationImpl &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.certificate, certificate) ||
                other.certificate == certificate) &&
            (identical(other.invalidReason, invalidReason) ||
                other.invalidReason == invalidReason) &&
            (identical(other.verifiedAt, verifiedAt) ||
                other.verifiedAt == verifiedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isValid, certificate, invalidReason, verifiedAt);

  /// Create a copy of CertificateVerification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CertificateVerificationImplCopyWith<_$CertificateVerificationImpl>
  get copyWith =>
      __$$CertificateVerificationImplCopyWithImpl<
        _$CertificateVerificationImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CertificateVerificationImplToJson(this);
  }
}

abstract class _CertificateVerification implements CertificateVerification {
  const factory _CertificateVerification({
    required final bool isValid,
    final Certificate? certificate,
    final String? invalidReason,
    @TimestampConverter() required final DateTime verifiedAt,
  }) = _$CertificateVerificationImpl;

  factory _CertificateVerification.fromJson(Map<String, dynamic> json) =
      _$CertificateVerificationImpl.fromJson;

  /// هل الشهادة صالحة
  @override
  bool get isValid;

  /// معلومات الشهادة (إذا كانت صالحة)
  @override
  Certificate? get certificate;

  /// سبب عدم الصلاحية
  @override
  String? get invalidReason;

  /// تاريخ التحقق
  @override
  @TimestampConverter()
  DateTime get verifiedAt;

  /// Create a copy of CertificateVerification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CertificateVerificationImplCopyWith<_$CertificateVerificationImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CertificateStats _$CertificateStatsFromJson(Map<String, dynamic> json) {
  return _CertificateStats.fromJson(json);
}

/// @nodoc
mixin _$CertificateStats {
  /// إجمالي الشهادات الصادرة
  int get totalIssued => throw _privateConstructorUsedError;

  /// الشهادات النشطة
  int get activeCount => throw _privateConstructorUsedError;

  /// الشهادات الملغاة
  int get revokedCount => throw _privateConstructorUsedError;

  /// الشهادات المنتهية
  int get expiredCount => throw _privateConstructorUsedError;

  /// التوزيع حسب النوع
  Map<String, int> get byType => throw _privateConstructorUsedError;

  /// متوسط الدرجة
  double get averageGrade => throw _privateConstructorUsedError;

  /// معدل الإصدار اليومي
  double get dailyIssuanceRate => throw _privateConstructorUsedError;

  /// Serializes this CertificateStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CertificateStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CertificateStatsCopyWith<CertificateStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CertificateStatsCopyWith<$Res> {
  factory $CertificateStatsCopyWith(
    CertificateStats value,
    $Res Function(CertificateStats) then,
  ) = _$CertificateStatsCopyWithImpl<$Res, CertificateStats>;
  @useResult
  $Res call({
    int totalIssued,
    int activeCount,
    int revokedCount,
    int expiredCount,
    Map<String, int> byType,
    double averageGrade,
    double dailyIssuanceRate,
  });
}

/// @nodoc
class _$CertificateStatsCopyWithImpl<$Res, $Val extends CertificateStats>
    implements $CertificateStatsCopyWith<$Res> {
  _$CertificateStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CertificateStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIssued = null,
    Object? activeCount = null,
    Object? revokedCount = null,
    Object? expiredCount = null,
    Object? byType = null,
    Object? averageGrade = null,
    Object? dailyIssuanceRate = null,
  }) {
    return _then(
      _value.copyWith(
            totalIssued: null == totalIssued
                ? _value.totalIssued
                : totalIssued // ignore: cast_nullable_to_non_nullable
                      as int,
            activeCount: null == activeCount
                ? _value.activeCount
                : activeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            revokedCount: null == revokedCount
                ? _value.revokedCount
                : revokedCount // ignore: cast_nullable_to_non_nullable
                      as int,
            expiredCount: null == expiredCount
                ? _value.expiredCount
                : expiredCount // ignore: cast_nullable_to_non_nullable
                      as int,
            byType: null == byType
                ? _value.byType
                : byType // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            averageGrade: null == averageGrade
                ? _value.averageGrade
                : averageGrade // ignore: cast_nullable_to_non_nullable
                      as double,
            dailyIssuanceRate: null == dailyIssuanceRate
                ? _value.dailyIssuanceRate
                : dailyIssuanceRate // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CertificateStatsImplCopyWith<$Res>
    implements $CertificateStatsCopyWith<$Res> {
  factory _$$CertificateStatsImplCopyWith(
    _$CertificateStatsImpl value,
    $Res Function(_$CertificateStatsImpl) then,
  ) = __$$CertificateStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalIssued,
    int activeCount,
    int revokedCount,
    int expiredCount,
    Map<String, int> byType,
    double averageGrade,
    double dailyIssuanceRate,
  });
}

/// @nodoc
class __$$CertificateStatsImplCopyWithImpl<$Res>
    extends _$CertificateStatsCopyWithImpl<$Res, _$CertificateStatsImpl>
    implements _$$CertificateStatsImplCopyWith<$Res> {
  __$$CertificateStatsImplCopyWithImpl(
    _$CertificateStatsImpl _value,
    $Res Function(_$CertificateStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CertificateStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIssued = null,
    Object? activeCount = null,
    Object? revokedCount = null,
    Object? expiredCount = null,
    Object? byType = null,
    Object? averageGrade = null,
    Object? dailyIssuanceRate = null,
  }) {
    return _then(
      _$CertificateStatsImpl(
        totalIssued: null == totalIssued
            ? _value.totalIssued
            : totalIssued // ignore: cast_nullable_to_non_nullable
                  as int,
        activeCount: null == activeCount
            ? _value.activeCount
            : activeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        revokedCount: null == revokedCount
            ? _value.revokedCount
            : revokedCount // ignore: cast_nullable_to_non_nullable
                  as int,
        expiredCount: null == expiredCount
            ? _value.expiredCount
            : expiredCount // ignore: cast_nullable_to_non_nullable
                  as int,
        byType: null == byType
            ? _value._byType
            : byType // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        averageGrade: null == averageGrade
            ? _value.averageGrade
            : averageGrade // ignore: cast_nullable_to_non_nullable
                  as double,
        dailyIssuanceRate: null == dailyIssuanceRate
            ? _value.dailyIssuanceRate
            : dailyIssuanceRate // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CertificateStatsImpl implements _CertificateStats {
  const _$CertificateStatsImpl({
    this.totalIssued = 0,
    this.activeCount = 0,
    this.revokedCount = 0,
    this.expiredCount = 0,
    final Map<String, int> byType = const {},
    this.averageGrade = 0.0,
    this.dailyIssuanceRate = 0.0,
  }) : _byType = byType;

  factory _$CertificateStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CertificateStatsImplFromJson(json);

  /// إجمالي الشهادات الصادرة
  @override
  @JsonKey()
  final int totalIssued;

  /// الشهادات النشطة
  @override
  @JsonKey()
  final int activeCount;

  /// الشهادات الملغاة
  @override
  @JsonKey()
  final int revokedCount;

  /// الشهادات المنتهية
  @override
  @JsonKey()
  final int expiredCount;

  /// التوزيع حسب النوع
  final Map<String, int> _byType;

  /// التوزيع حسب النوع
  @override
  @JsonKey()
  Map<String, int> get byType {
    if (_byType is EqualUnmodifiableMapView) return _byType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_byType);
  }

  /// متوسط الدرجة
  @override
  @JsonKey()
  final double averageGrade;

  /// معدل الإصدار اليومي
  @override
  @JsonKey()
  final double dailyIssuanceRate;

  @override
  String toString() {
    return 'CertificateStats(totalIssued: $totalIssued, activeCount: $activeCount, revokedCount: $revokedCount, expiredCount: $expiredCount, byType: $byType, averageGrade: $averageGrade, dailyIssuanceRate: $dailyIssuanceRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CertificateStatsImpl &&
            (identical(other.totalIssued, totalIssued) ||
                other.totalIssued == totalIssued) &&
            (identical(other.activeCount, activeCount) ||
                other.activeCount == activeCount) &&
            (identical(other.revokedCount, revokedCount) ||
                other.revokedCount == revokedCount) &&
            (identical(other.expiredCount, expiredCount) ||
                other.expiredCount == expiredCount) &&
            const DeepCollectionEquality().equals(other._byType, _byType) &&
            (identical(other.averageGrade, averageGrade) ||
                other.averageGrade == averageGrade) &&
            (identical(other.dailyIssuanceRate, dailyIssuanceRate) ||
                other.dailyIssuanceRate == dailyIssuanceRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalIssued,
    activeCount,
    revokedCount,
    expiredCount,
    const DeepCollectionEquality().hash(_byType),
    averageGrade,
    dailyIssuanceRate,
  );

  /// Create a copy of CertificateStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CertificateStatsImplCopyWith<_$CertificateStatsImpl> get copyWith =>
      __$$CertificateStatsImplCopyWithImpl<_$CertificateStatsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CertificateStatsImplToJson(this);
  }
}

abstract class _CertificateStats implements CertificateStats {
  const factory _CertificateStats({
    final int totalIssued,
    final int activeCount,
    final int revokedCount,
    final int expiredCount,
    final Map<String, int> byType,
    final double averageGrade,
    final double dailyIssuanceRate,
  }) = _$CertificateStatsImpl;

  factory _CertificateStats.fromJson(Map<String, dynamic> json) =
      _$CertificateStatsImpl.fromJson;

  /// إجمالي الشهادات الصادرة
  @override
  int get totalIssued;

  /// الشهادات النشطة
  @override
  int get activeCount;

  /// الشهادات الملغاة
  @override
  int get revokedCount;

  /// الشهادات المنتهية
  @override
  int get expiredCount;

  /// التوزيع حسب النوع
  @override
  Map<String, int> get byType;

  /// متوسط الدرجة
  @override
  double get averageGrade;

  /// معدل الإصدار اليومي
  @override
  double get dailyIssuanceRate;

  /// Create a copy of CertificateStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CertificateStatsImplCopyWith<_$CertificateStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
