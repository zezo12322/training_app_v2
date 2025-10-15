import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'certificate.freezed.dart';
part 'certificate.g.dart';

/// نوع الشهادة
enum CertificateType {
  /// شهادة إتمام كورس
  courseCompletion,
  
  /// شهادة تميز
  excellence,
  
  /// شهادة مشاركة
  participation,
  
  /// شهادة إنجاز خاص
  specialAchievement,
}

/// حالة الشهادة
enum CertificateStatus {
  /// نشطة وصالحة
  active,
  
  /// ملغاة
  revoked,
  
  /// منتهية الصلاحية
  expired,
}

/// شهادة إتمام/تميز
@freezed
class Certificate with _$Certificate {
  const factory Certificate({
    /// معرف الشهادة
    required String id,
    
    /// معرف المستخدم
    required String userId,
    
    /// اسم المستخدم
    required String userName,
    
    /// البريد الإلكتروني
    required String userEmail,
    
    /// معرف الكورس
    required String courseId,
    
    /// اسم الكورس
    required String courseName,
    
    /// نوع الشهادة
    required CertificateType type,
    
    /// حالة الشهادة
    @Default(CertificateStatus.active) CertificateStatus status,
    
    /// رقم الشهادة (فريد)
    required String certificateNumber,
    
    /// الدرجة النهائية (0-100)
    double? finalGrade,
    
    /// نسبة الإتمام (0-100)
    @Default(100.0) double completionPercentage,
    
    /// عدد ساعات الدراسة
    double? studyHours,
    
    /// اسم المدرب
    String? trainerName,
    
    /// توقيع المدرب (URL)
    String? trainerSignatureUrl,
    
    /// الشعار (URL)
    String? logoUrl,
    
    /// URL ملف PDF
    String? pdfUrl,
    
    /// رمز QR (data URL)
    String? qrCodeData,
    
    /// URL التحقق
    String? verificationUrl,
    
    /// تاريخ الإصدار
    @TimestampConverter() required DateTime issuedAt,
    
    /// تاريخ انتهاء الصلاحية (optional)
    @TimestampConverter() DateTime? expiresAt,
    
    /// تاريخ الإلغاء
    @TimestampConverter() DateTime? revokedAt,
    
    /// سبب الإلغاء
    String? revocationReason,
    
    /// البيانات الإضافية
    @Default({}) Map<String, dynamic> metadata,
    
    /// Tenant isolation
    required String institutionId,
    required String companyId,
  }) = _Certificate;

  factory Certificate.fromJson(Map<String, dynamic> json) =>
      _$CertificateFromJson(json);
}

/// قالب الشهادة
@freezed
class CertificateTemplate with _$CertificateTemplate {
  const factory CertificateTemplate({
    /// معرف القالب
    required String id,
    
    /// اسم القالب
    required String name,
    
    /// نوع الشهادة
    required CertificateType type,
    
    /// العنوان
    required String title,
    
    /// النص الأساسي (يمكن أن يحتوي على placeholders)
    required String bodyText,
    
    /// اللون الأساسي
    @Default('#1976D2') String primaryColor,
    
    /// اللون الثانوي
    @Default('#FFC107') String secondaryColor,
    
    /// الخط المستخدم
    @Default('Cairo') String fontFamily,
    
    /// صورة الخلفية (URL)
    String? backgroundImageUrl,
    
    /// الشعار (URL)
    String? logoUrl,
    
    /// حجم الشهادة
    @Default('A4') String pageSize,
    
    /// الاتجاه
    @Default('landscape') String orientation,
    
    /// هل القالب نشط
    @Default(true) bool isActive,
    
    /// الإعدادات الإضافية
    @Default({}) Map<String, dynamic> settings,
  }) = _CertificateTemplate;

  factory CertificateTemplate.fromJson(Map<String, dynamic> json) =>
      _$CertificateTemplateFromJson(json);
}

/// متطلبات الحصول على الشهادة
@freezed
class CertificateRequirements with _$CertificateRequirements {
  const factory CertificateRequirements({
    /// معرف الكورس
    required String courseId,
    
    /// نسبة الإتمام المطلوبة (0-100)
    @Default(100.0) double minimumCompletion,
    
    /// الدرجة الدنيا المطلوبة (0-100)
    double? minimumGrade,
    
    /// الحد الأدنى من الحضور (%)
    double? minimumAttendance,
    
    /// الحد الأدنى من النقاط
    int? minimumPoints,
    
    /// المدة الزمنية المطلوبة (بالساعات)
    double? minimumStudyHours,
    
    /// الاختبارات المطلوبة
    @Default([]) List<String> requiredQuizzes,
    
    /// المهام المطلوبة
    @Default([]) List<String> requiredAssignments,
    
    /// الإنجازات المطلوبة
    @Default([]) List<String> requiredAchievements,
  }) = _CertificateRequirements;

  factory CertificateRequirements.fromJson(Map<String, dynamic> json) =>
      _$CertificateRequirementsFromJson(json);
}

/// نتيجة التحقق من شهادة
@freezed
class CertificateVerification with _$CertificateVerification {
  const factory CertificateVerification({
    /// هل الشهادة صالحة
    required bool isValid,
    
    /// معلومات الشهادة (إذا كانت صالحة)
    Certificate? certificate,
    
    /// سبب عدم الصلاحية
    String? invalidReason,
    
    /// تاريخ التحقق
    @TimestampConverter() required DateTime verifiedAt,
  }) = _CertificateVerification;

  factory CertificateVerification.fromJson(Map<String, dynamic> json) =>
      _$CertificateVerificationFromJson(json);
}

/// إحصائيات الشهادات
@freezed
class CertificateStats with _$CertificateStats {
  const factory CertificateStats({
    /// إجمالي الشهادات الصادرة
    @Default(0) int totalIssued,
    
    /// الشهادات النشطة
    @Default(0) int activeCount,
    
    /// الشهادات الملغاة
    @Default(0) int revokedCount,
    
    /// الشهادات المنتهية
    @Default(0) int expiredCount,
    
    /// التوزيع حسب النوع
    @Default({}) Map<String, int> byType,
    
    /// متوسط الدرجة
    @Default(0.0) double averageGrade,
    
    /// معدل الإصدار اليومي
    @Default(0.0) double dailyIssuanceRate,
  }) = _CertificateStats;

  factory CertificateStats.fromJson(Map<String, dynamic> json) =>
      _$CertificateStatsFromJson(json);
}
