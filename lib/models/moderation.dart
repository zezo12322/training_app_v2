import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'moderation.freezed.dart';
part 'moderation.g.dart';

/// نوع التقرير
enum ReportType {
  /// محتوى غير لائق
  inappropriate,
  
  /// إساءة أو تنمر
  harassment,
  
  /// سبام
  spam,
  
  /// معلومات خاطئة
  misinformation,
  
  /// محتوى ضار
  harmful,
  
  /// انتهاك حقوق
  copyright,
  
  /// أخرى
  other,
}

/// حالة التقرير
enum ReportStatus {
  /// قيد المراجعة
  pending,
  
  /// قيد التحقيق
  investigating,
  
  /// تم اتخاذ إجراء
  actionTaken,
  
  /// مرفوض (لا يوجد انتهاك)
  dismissed,
  
  /// تم الحل
  resolved,
}

/// نوع الإجراء
enum ModerationAction {
  /// لا يوجد إجراء
  none,
  
  /// تحذير
  warning,
  
  /// حذف المحتوى
  deleteContent,
  
  /// إخفاء المحتوى
  hideContent,
  
  /// كتم المستخدم (مؤقت)
  muteUser,
  
  /// حظر المستخدم (دائم)
  banUser,
  
  /// تقييد النشر
  restrictPosting,
}

/// تقرير عن محتوى أو مستخدم
@freezed
class Report with _$Report {
  const factory Report({
    /// معرف التقرير
    required String id,
    
    /// نوع التقرير
    required ReportType type,
    
    /// حالة التقرير
    @Default(ReportStatus.pending) ReportStatus status,
    
    /// معرف المُبلِّغ
    required String reporterId,
    
    /// اسم المُبلِّغ
    required String reporterName,
    
    /// نوع المحتوى المبلغ عنه
    required String contentType, // 'message', 'post', 'comment', 'user'
    
    /// معرف المحتوى المبلغ عنه
    required String contentId,
    
    /// معرف صاحب المحتوى
    required String reportedUserId,
    
    /// اسم صاحب المحتوى
    String? reportedUserName,
    
    /// سبب التقرير
    required String reason,
    
    /// وصف تفصيلي
    @Default('') String description,
    
    /// لقطة شاشة أو دليل
    @Default([]) List<String> evidenceUrls,
    
    /// معرف الكورس (إن وُجد)
    String? courseId,
    
    /// معرف المراجع
    String? reviewerId,
    
    /// اسم المراجع
    String? reviewerName,
    
    /// الإجراء المتخذ
    @Default(ModerationAction.none) ModerationAction action,
    
    /// ملاحظات المراجع
    String? reviewNotes,
    
    /// تاريخ الإنشاء
    @TimestampConverter() required DateTime createdAt,
    
    /// تاريخ المراجعة
    @TimestampConverter() DateTime? reviewedAt,
    
    /// تاريخ الحل
    @TimestampConverter() DateTime? resolvedAt,
    
    /// Tenant isolation
    required String institutionId,
    required String companyId,
  }) = _Report;

  factory Report.fromJson(Map<String, dynamic> json) =>
      _$ReportFromJson(json);
}

/// سجل الإجراءات التأديبية
@freezed
class ModerationLog with _$ModerationLog {
  const factory ModerationLog({
    /// معرف السجل
    required String id,
    
    /// معرف المستخدم المُجرى عليه الإجراء
    required String targetUserId,
    
    /// اسم المستخدم
    required String targetUserName,
    
    /// الإجراء المتخذ
    required ModerationAction action,
    
    /// سبب الإجراء
    required String reason,
    
    /// مدة الإجراء (للإجراءات المؤقتة)
    int? durationDays,
    
    /// تاريخ البدء
    @TimestampConverter() required DateTime startDate,
    
    /// تاريخ الانتهاء
    @TimestampConverter() DateTime? endDate,
    
    /// معرف المشرف
    required String moderatorId,
    
    /// اسم المشرف
    required String moderatorName,
    
    /// معرف التقرير المرتبط
    String? relatedReportId,
    
    /// ملاحظات
    @Default('') String notes,
    
    /// هل الإجراء نشط
    @Default(true) bool isActive,
    
    /// تاريخ الإلغاء
    @TimestampConverter() DateTime? cancelledAt,
    
    /// سبب الإلغاء
    String? cancellationReason,
    
    /// Tenant isolation
    required String institutionId,
    required String companyId,
  }) = _ModerationLog;

  factory ModerationLog.fromJson(Map<String, dynamic> json) =>
      _$ModerationLogFromJson(json);
}

/// تصفية المحتوى التلقائية
@freezed
class ContentFilter with _$ContentFilter {
  const factory ContentFilter({
    /// معرف الفلتر
    required String id,
    
    /// الكلمات المحظورة
    @Default([]) List<String> bannedWords,
    
    /// الأنماط المحظورة (regex)
    @Default([]) List<String> bannedPatterns,
    
    /// الروابط المسموحة (whitelist)
    @Default([]) List<String> allowedDomains,
    
    /// هل التصفية نشطة
    @Default(true) bool isActive,
    
    /// حساسية التصفية (1-10)
    @Default(5) int sensitivity,
    
    /// إجراء تلقائي عند الكشف
    @Default(ModerationAction.hideContent) ModerationAction autoAction,
    
    /// إشعار المشرف تلقائياً
    @Default(true) bool notifyModerator,
    
    /// Tenant isolation
    required String institutionId,
    required String companyId,
  }) = _ContentFilter;

  factory ContentFilter.fromJson(Map<String, dynamic> json) =>
      _$ContentFilterFromJson(json);
}

/// إحصائيات الإشراف
@freezed
class ModerationStats with _$ModerationStats {
  const factory ModerationStats({
    /// عدد التقارير الكلي
    @Default(0) int totalReports,
    
    /// التقارير قيد المراجعة
    @Default(0) int pendingReports,
    
    /// التقارير التي تم حلها
    @Default(0) int resolvedReports,
    
    /// التقارير المرفوضة
    @Default(0) int dismissedReports,
    
    /// عدد الإجراءات المتخذة
    @Default(0) int totalActions,
    
    /// عدد المستخدمين المحظورين
    @Default(0) int bannedUsers,
    
    /// عدد المستخدمين المكتومين
    @Default(0) int mutedUsers,
    
    /// متوسط وقت المراجعة (بالساعات)
    @Default(0.0) double avgReviewTimeHours,
    
    /// التوزيع حسب النوع
    @Default({}) Map<String, int> reportsByType,
  }) = _ModerationStats;

  factory ModerationStats.fromJson(Map<String, dynamic> json) =>
      _$ModerationStatsFromJson(json);
}
