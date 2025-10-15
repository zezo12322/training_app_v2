import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/moderation.dart';
import '../services/moderation_service.dart';

/// مزود خدمة الإشراف
final moderationServiceProvider = Provider<ModerationService>((ref) {
  return ModerationService(firestore: FirebaseFirestore.instance);
});

/// تقديم تقرير
final submitReportProvider = FutureProvider.family.autoDispose<
    Report?,
    Map<String, dynamic>
>((ref, params) async {
  final service = ref.watch(moderationServiceProvider);
  
  return await service.submitReport(
    reporterId: params['reporterId'] as String,
    reporterName: params['reporterName'] as String,
    type: params['type'] as ReportType,
    contentType: params['contentType'] as String,
    contentId: params['contentId'] as String,
    reportedUserId: params['reportedUserId'] as String,
    reason: params['reason'] as String,
    institutionId: params['institutionId'] as String,
    companyId: params['companyId'] as String,
    description: params['description'] as String?,
    evidenceUrls: params['evidenceUrls'] as List<String>?,
    courseId: params['courseId'] as String?,
  );
});

/// Stream للتقارير قيد المراجعة
final pendingReportsProvider = StreamProvider.family.autoDispose<
    List<Report>,
    String
>((ref, institutionId) {
  final service = ref.watch(moderationServiceProvider);
  return service.streamPendingReports(institutionId);
});

/// إحصائيات الإشراف
final moderationStatsProvider = FutureProvider.family.autoDispose<
    ModerationStats,
    String
>((ref, institutionId) async {
  final service = ref.watch(moderationServiceProvider);
  return await service.getModerationStats(institutionId);
});

/// التحقق من حالة المستخدم
final userRestrictionProvider = FutureProvider.family.autoDispose<
    bool,
    String
>((ref, userId) async {
  final service = ref.watch(moderationServiceProvider);
  return await service.isUserRestricted(userId);
});

/// تصفية المحتوى
final contentFilterProvider = FutureProvider.family.autoDispose<
    bool,
    Map<String, String>
>((ref, params) async {
  final service = ref.watch(moderationServiceProvider);
  return await service.filterContent(
    params['content']!,
    params['institutionId']!,
  );
});
