// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CertificateImpl _$$CertificateImplFromJson(Map<String, dynamic> json) =>
    _$CertificateImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userEmail: json['userEmail'] as String,
      courseId: json['courseId'] as String,
      courseName: json['courseName'] as String,
      type: $enumDecode(_$CertificateTypeEnumMap, json['type']),
      status:
          $enumDecodeNullable(_$CertificateStatusEnumMap, json['status']) ??
          CertificateStatus.active,
      certificateNumber: json['certificateNumber'] as String,
      finalGrade: (json['finalGrade'] as num?)?.toDouble(),
      completionPercentage:
          (json['completionPercentage'] as num?)?.toDouble() ?? 100.0,
      studyHours: (json['studyHours'] as num?)?.toDouble(),
      trainerName: json['trainerName'] as String?,
      trainerSignatureUrl: json['trainerSignatureUrl'] as String?,
      logoUrl: json['logoUrl'] as String?,
      pdfUrl: json['pdfUrl'] as String?,
      qrCodeData: json['qrCodeData'] as String?,
      verificationUrl: json['verificationUrl'] as String?,
      issuedAt: DateTime.parse(json['issuedAt'] as String),
      expiresAt: const TimestampConverter().fromJson(json['expiresAt']),
      revokedAt: const TimestampConverter().fromJson(json['revokedAt']),
      revocationReason: json['revocationReason'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      institutionId: json['institutionId'] as String,
      companyId: json['companyId'] as String,
    );

Map<String, dynamic> _$$CertificateImplToJson(_$CertificateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'courseId': instance.courseId,
      'courseName': instance.courseName,
      'type': _$CertificateTypeEnumMap[instance.type]!,
      'status': _$CertificateStatusEnumMap[instance.status]!,
      'certificateNumber': instance.certificateNumber,
      'finalGrade': instance.finalGrade,
      'completionPercentage': instance.completionPercentage,
      'studyHours': instance.studyHours,
      'trainerName': instance.trainerName,
      'trainerSignatureUrl': instance.trainerSignatureUrl,
      'logoUrl': instance.logoUrl,
      'pdfUrl': instance.pdfUrl,
      'qrCodeData': instance.qrCodeData,
      'verificationUrl': instance.verificationUrl,
      'issuedAt': instance.issuedAt.toIso8601String(),
      'expiresAt': const TimestampConverter().toJson(instance.expiresAt),
      'revokedAt': const TimestampConverter().toJson(instance.revokedAt),
      'revocationReason': instance.revocationReason,
      'metadata': instance.metadata,
      'institutionId': instance.institutionId,
      'companyId': instance.companyId,
    };

const _$CertificateTypeEnumMap = {
  CertificateType.courseCompletion: 'courseCompletion',
  CertificateType.excellence: 'excellence',
  CertificateType.participation: 'participation',
  CertificateType.specialAchievement: 'specialAchievement',
};

const _$CertificateStatusEnumMap = {
  CertificateStatus.active: 'active',
  CertificateStatus.revoked: 'revoked',
  CertificateStatus.expired: 'expired',
};

_$CertificateTemplateImpl _$$CertificateTemplateImplFromJson(
  Map<String, dynamic> json,
) => _$CertificateTemplateImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  type: $enumDecode(_$CertificateTypeEnumMap, json['type']),
  title: json['title'] as String,
  bodyText: json['bodyText'] as String,
  primaryColor: json['primaryColor'] as String? ?? '#1976D2',
  secondaryColor: json['secondaryColor'] as String? ?? '#FFC107',
  fontFamily: json['fontFamily'] as String? ?? 'Cairo',
  backgroundImageUrl: json['backgroundImageUrl'] as String?,
  logoUrl: json['logoUrl'] as String?,
  pageSize: json['pageSize'] as String? ?? 'A4',
  orientation: json['orientation'] as String? ?? 'landscape',
  isActive: json['isActive'] as bool? ?? true,
  settings: json['settings'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$$CertificateTemplateImplToJson(
  _$CertificateTemplateImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'type': _$CertificateTypeEnumMap[instance.type]!,
  'title': instance.title,
  'bodyText': instance.bodyText,
  'primaryColor': instance.primaryColor,
  'secondaryColor': instance.secondaryColor,
  'fontFamily': instance.fontFamily,
  'backgroundImageUrl': instance.backgroundImageUrl,
  'logoUrl': instance.logoUrl,
  'pageSize': instance.pageSize,
  'orientation': instance.orientation,
  'isActive': instance.isActive,
  'settings': instance.settings,
};

_$CertificateRequirementsImpl _$$CertificateRequirementsImplFromJson(
  Map<String, dynamic> json,
) => _$CertificateRequirementsImpl(
  courseId: json['courseId'] as String,
  minimumCompletion: (json['minimumCompletion'] as num?)?.toDouble() ?? 100.0,
  minimumGrade: (json['minimumGrade'] as num?)?.toDouble(),
  minimumAttendance: (json['minimumAttendance'] as num?)?.toDouble(),
  minimumPoints: (json['minimumPoints'] as num?)?.toInt(),
  minimumStudyHours: (json['minimumStudyHours'] as num?)?.toDouble(),
  requiredQuizzes:
      (json['requiredQuizzes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  requiredAssignments:
      (json['requiredAssignments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  requiredAchievements:
      (json['requiredAchievements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$CertificateRequirementsImplToJson(
  _$CertificateRequirementsImpl instance,
) => <String, dynamic>{
  'courseId': instance.courseId,
  'minimumCompletion': instance.minimumCompletion,
  'minimumGrade': instance.minimumGrade,
  'minimumAttendance': instance.minimumAttendance,
  'minimumPoints': instance.minimumPoints,
  'minimumStudyHours': instance.minimumStudyHours,
  'requiredQuizzes': instance.requiredQuizzes,
  'requiredAssignments': instance.requiredAssignments,
  'requiredAchievements': instance.requiredAchievements,
};

_$CertificateVerificationImpl _$$CertificateVerificationImplFromJson(
  Map<String, dynamic> json,
) => _$CertificateVerificationImpl(
  isValid: json['isValid'] as bool,
  certificate: json['certificate'] == null
      ? null
      : Certificate.fromJson(json['certificate'] as Map<String, dynamic>),
  invalidReason: json['invalidReason'] as String?,
  verifiedAt: DateTime.parse(json['verifiedAt'] as String),
);

Map<String, dynamic> _$$CertificateVerificationImplToJson(
  _$CertificateVerificationImpl instance,
) => <String, dynamic>{
  'isValid': instance.isValid,
  'certificate': instance.certificate?.toJson(),
  'invalidReason': instance.invalidReason,
  'verifiedAt': instance.verifiedAt.toIso8601String(),
};

_$CertificateStatsImpl _$$CertificateStatsImplFromJson(
  Map<String, dynamic> json,
) => _$CertificateStatsImpl(
  totalIssued: (json['totalIssued'] as num?)?.toInt() ?? 0,
  activeCount: (json['activeCount'] as num?)?.toInt() ?? 0,
  revokedCount: (json['revokedCount'] as num?)?.toInt() ?? 0,
  expiredCount: (json['expiredCount'] as num?)?.toInt() ?? 0,
  byType:
      (json['byType'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
  averageGrade: (json['averageGrade'] as num?)?.toDouble() ?? 0.0,
  dailyIssuanceRate: (json['dailyIssuanceRate'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$CertificateStatsImplToJson(
  _$CertificateStatsImpl instance,
) => <String, dynamic>{
  'totalIssued': instance.totalIssued,
  'activeCount': instance.activeCount,
  'revokedCount': instance.revokedCount,
  'expiredCount': instance.expiredCount,
  'byType': instance.byType,
  'averageGrade': instance.averageGrade,
  'dailyIssuanceRate': instance.dailyIssuanceRate,
};
