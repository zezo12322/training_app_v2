import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'anomaly.freezed.dart';
part 'anomaly.g.dart';

/// نوع الشذوذ
enum AnomalyType {
  suspiciousLogin,      // تسجيل دخول مشبوه
  unusualQuizScore,     // درجة غير طبيعية في الاختبار
  rapidProgress,        // تقدم سريع جداً
  multipleDevices,      // أجهزة متعددة
  unusualActivity,      // نشاط غير معتاد
  cheatingPattern,      // نمط غش محتمل
  accountSharing,       // مشاركة الحساب
}

/// مستوى الخطورة
enum AnomalySeverity {
  low,      // منخفض
  medium,   // متوسط
  high,     // عالي
  critical, // حرج
}

/// حالة التحقيق
enum InvestigationStatus {
  pending,        // قيد الانتظار
  investigating,  // قيد التحقيق
  resolved,       // تم الحل
  falsePositive,  // إيجابي خاطئ
  confirmed,      // مؤكد
}

/// درجة الشذوذ
@freezed
class AnomalyScore with _$AnomalyScore {
  const factory AnomalyScore({
    required String id,
    required String userId,
    required String userName,
    required String institutionId,
    String? companyId,
    
    /// معلومات الشذوذ
    required AnomalyType type,
    required AnomalySeverity severity,
    required double score,          // 0.0 - 1.0 (1.0 = شذوذ مؤكد)
    required double confidenceLevel, // 0.0 - 1.0 (1.0 = ثقة عالية)
    
    /// البيانات المرتبطة
    required Map<String, dynamic> metadata,
    String? relatedEntityId,         // معرف الدورة/الاختبار/الخ
    String? relatedEntityType,       // course, quiz, etc.
    
    /// الوصف
    required String description,
    required String reason,
    @Default([]) List<String> evidencePoints,
    
    /// الحالة
    required InvestigationStatus status,
    @Default(false) bool isReviewed,
    String? reviewedBy,
    String? reviewerName,
    @TimestampConverter() DateTime? reviewedAt,
    String? reviewNotes,
    
    /// الإجراءات
    @Default(false) bool actionTaken,
    String? action,                  // warning, suspend, etc.
    
    /// التوقيت
    @RequiredTimestampConverter() required DateTime detectedAt,
    @TimestampConverter() DateTime? resolvedAt,
  }) = _AnomalyScore;

  factory AnomalyScore.fromJson(Map<String, dynamic> json) =>
      _$AnomalyScoreFromJson(json);
}

/// تنبيه شذوذ
@freezed
class AnomalyAlert with _$AnomalyAlert {
  const factory AnomalyAlert({
    required String id,
    required String anomalyId,      // مرجع AnomalyScore
    required String institutionId,
    String? companyId,
    
    /// معلومات التنبيه
    required String title,
    required String message,
    required AnomalySeverity severity,
    
    /// المستلمون
    required List<String> recipientIds,
    @Default([]) List<String> readBy,
    
    /// الحالة
    required bool isRead,
    required bool isDismissed,
    String? dismissedBy,
    @TimestampConverter() DateTime? dismissedAt,
    
    /// التوقيت
    @RequiredTimestampConverter() required DateTime createdAt,
    @TimestampConverter() DateTime? expiresAt,
  }) = _AnomalyAlert;

  factory AnomalyAlert.fromJson(Map<String, dynamic> json) =>
      _$AnomalyAlertFromJson(json);
}

/// إعدادات الكشف عن الشذوذ
@freezed
class AnomalyDetectionSettings with _$AnomalyDetectionSettings {
  const factory AnomalyDetectionSettings({
    required String id,
    required String institutionId,
    String? companyId,
    
    /// التفعيل
    required bool isEnabled,
    @Default([]) List<AnomalyType> enabledTypes,
    
    /// الحساسية (0.0 - 1.0)
    @Default(0.7) double sensitivityLevel,
    
    /// الحدود
    @Default(3.0) double rapidProgressThreshold,    // ساعات
    @Default(0.95) double unusualScoreThreshold,    // النسبة المئوية
    @Default(5) int multipleDevicesThreshold,       // عدد الأجهزة
    @Default(100) int unusualActivityThreshold,     // عدد الأحداث/ساعة
    
    /// الإشعارات
    required bool sendAlerts,
    @Default([]) List<String> alertRecipients,      // معرفات المستخدمين
    @Default(AnomalySeverity.medium) AnomalySeverity minAlertSeverity,
    
    /// الإجراءات التلقائية
    required bool autoSuspendCritical,
    required bool autoFlagCheating,
    
    /// التحديث
    @RequiredTimestampConverter() required DateTime updatedAt,
    required String updatedBy,
  }) = _AnomalyDetectionSettings;

  factory AnomalyDetectionSettings.fromJson(Map<String, dynamic> json) =>
      _$AnomalyDetectionSettingsFromJson(json);
}

/// نموذج ML للكشف
@freezed
class AnomalyDetectionModel with _$AnomalyDetectionModel {
  const factory AnomalyDetectionModel({
    required String id,
    required String name,
    required AnomalyType type,
    
    /// معلومات النموذج
    required String version,
    required String modelPath,       // مسار ملف .tflite
    @Default(0.0) double accuracy,
    @Default(0.0) double precision,
    @Default(0.0) double recall,
    
    /// التدريب
    required int trainingDataSize,
    @RequiredTimestampConverter() required DateTime trainedAt,
    String? trainedBy,
    
    /// الحالة
    required bool isActive,
    @TimestampConverter() DateTime? lastUsedAt,
    
    /// البيانات الوصفية
    required Map<String, dynamic> metadata,
  }) = _AnomalyDetectionModel;

  factory AnomalyDetectionModel.fromJson(Map<String, dynamic> json) =>
      _$AnomalyDetectionModelFromJson(json);
}

/// نمط السلوك
@freezed
class BehaviorPattern with _$BehaviorPattern {
  const factory BehaviorPattern({
    required String userId,
    required String institutionId,
    
    /// أنماط الاختبارات
    @Default(0.0) double avgQuizScore,
    @Default(0.0) double quizScoreStdDev,
    @Default(0) int totalQuizzesTaken,
    @Default(0.0) double avgQuizCompletionTime, // دقائق
    
    /// أنماط الدورات
    @Default(0.0) double avgCourseProgress,
    @Default(0) int totalCoursesEnrolled,
    @Default(0) int totalCoursesCompleted,
    @Default(0.0) double avgLessonDuration,     // دقائق
    
    /// أنماط تسجيل الدخول
    @Default([]) List<String> commonLoginTimes,  // "09:00", "14:00", etc.
    @Default([]) List<String> commonDevices,
    @Default([]) List<String> commonLocations,   // IP regions
    @Default(0) int totalLoginSessions,
    
    /// أنماط النشاط
    @Default(0) int totalActivities,
    @Default(0.0) double avgSessionDuration,     // دقائق
    @Default([]) List<String> peakActivityHours,
    
    /// التحديث
    @RequiredTimestampConverter() required DateTime lastUpdatedAt,
    @RequiredTimestampConverter() required DateTime createdAt,
  }) = _BehaviorPattern;

  factory BehaviorPattern.fromJson(Map<String, dynamic> json) =>
      _$BehaviorPatternFromJson(json);
}

/// حدث نشاط
@freezed
class ActivityEvent with _$ActivityEvent {
  const factory ActivityEvent({
    required String id,
    required String userId,
    required String institutionId,
    
    /// معلومات الحدث
    required String eventType,       // login, quiz_submit, lesson_view, etc.
    required Map<String, dynamic> eventData,
    
    /// السياق
    String? deviceId,
    String? deviceType,             // mobile, web, tablet
    String? ipAddress,
    String? location,               // من IP
    String? userAgent,
    
    /// التوقيت
    @RequiredTimestampConverter() required DateTime timestamp,
    
    /// التحليل
    @Default(false) bool isFlagged,
    double? anomalyScore,
  }) = _ActivityEvent;

  factory ActivityEvent.fromJson(Map<String, dynamic> json) =>
      _$ActivityEventFromJson(json);
}

/// إحصائيات الكشف
@freezed
class DetectionStatistics with _$DetectionStatistics {
  const factory DetectionStatistics({
    required String institutionId,
    String? companyId,
    
    /// الفترة
    @RequiredTimestampConverter() required DateTime startDate,
    @RequiredTimestampConverter() required DateTime endDate,
    
    /// الأعداد
    required int totalAnomaliesDetected,
    required int confirmedAnomalies,
    required int falsePositives,
    required int pendingReview,
    
    /// حسب النوع
    required Map<AnomalyType, int> anomaliesByType,
    required Map<AnomalySeverity, int> anomaliesBySeverity,
    
    /// الدقة
    @Default(0.0) double detectionAccuracy,
    @Default(0.0) double falsePositiveRate,
    @Default(0.0) double truePositiveRate,
    
    /// الأداء
    @Default(0.0) double avgDetectionTime,  // ثواني
    @Default(0.0) double avgReviewTime,     // ساعات
    
    /// التحديث
    @RequiredTimestampConverter() required DateTime generatedAt,
  }) = _DetectionStatistics;

  factory DetectionStatistics.fromJson(Map<String, dynamic> json) =>
      _$DetectionStatisticsFromJson(json);
}
