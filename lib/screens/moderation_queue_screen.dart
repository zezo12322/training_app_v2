import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/moderation.dart';
import '../providers/moderation_providers.dart';
import '../providers/auth_provider.dart';

/// شاشة قائمة انتظار الإشراف
class ModerationQueueScreen extends ConsumerStatefulWidget {
  const ModerationQueueScreen({super.key});

  @override
  ConsumerState<ModerationQueueScreen> createState() => _ModerationQueueScreenState();
}

class _ModerationQueueScreenState extends ConsumerState<ModerationQueueScreen> {

  String _getReportTypeLabel(ReportType type) {
    switch (type) {
      case ReportType.inappropriate:
        return 'محتوى غير لائق';
      case ReportType.harassment:
        return 'تحرش';
      case ReportType.spam:
        return 'spam';
      case ReportType.misinformation:
        return 'معلومات مضللة';
      case ReportType.harmful:
        return 'محتوى ضار';
      case ReportType.copyright:
        return 'انتهاك حقوق النشر';
      case ReportType.other:
        return 'أخرى';
    }
  }

  IconData _getReportTypeIcon(ReportType type) {
    switch (type) {
      case ReportType.inappropriate:
        return Icons.warning_amber;
      case ReportType.harassment:
        return Icons.person_off;
      case ReportType.spam:
        return Icons.block;
      case ReportType.misinformation:
        return Icons.fact_check;
      case ReportType.harmful:
        return Icons.dangerous;
      case ReportType.copyright:
        return Icons.copyright;
      case ReportType.other:
        return Icons.help_outline;
    }
  }

  Color _getReportTypeColor(ReportType type) {
    switch (type) {
      case ReportType.inappropriate:
        return Colors.orange;
      case ReportType.harassment:
        return Colors.red;
      case ReportType.spam:
        return Colors.grey;
      case ReportType.misinformation:
        return Colors.purple;
      case ReportType.harmful:
        return Colors.deepOrange;
      case ReportType.copyright:
        return Colors.blue;
      case ReportType.other:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserAsync = ref.watch(currentUserModelProvider);
    final currentUser = currentUserAsync.value;
    
    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final reportsAsync = ref.watch(
      pendingReportsProvider(currentUser.institutionId ?? '')
    );

    final statsAsync = ref.watch(
      moderationStatsProvider(currentUser.institutionId ?? '')
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الإشراف'),
        actions: [
          // إحصائيات سريعة
          statsAsync.when(
            data: (stats) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Badge(
                  label: Text('${stats.pendingReports}'),
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.pending_actions),
                ),
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: Column(
        children: [
          // إحصائيات
          statsAsync.when(
            data: (stats) => _buildStatsCard(stats),
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('خطأ: $error'),
          ),

          const Divider(height: 1),

          // قائمة التقارير
          Expanded(
            child: reportsAsync.when(
              data: (reports) {
                if (reports.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, size: 64, color: Colors.green),
                        SizedBox(height: 16),
                        Text(
                          'لا توجد تقارير قيد المراجعة',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: reports.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    return _buildReportCard(context, reports[index], currentUser);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('خطأ في تحميل التقارير: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(ModerationStats stats) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('قيد المراجعة', stats.pendingReports, Colors.orange),
            _buildStatItem('تم الحل', stats.resolvedReports, Colors.green),
            _buildStatItem('مرفوض', stats.dismissedReports, Colors.grey),
            _buildStatItem('الإجمالي', stats.totalReports, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildReportCard(BuildContext context, Report report, currentUser) {
    final typeColor = _getReportTypeColor(report.type);
    final typeIcon = _getReportTypeIcon(report.type);
    final typeLabel = _getReportTypeLabel(report.type);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: typeColor.withValues(alpha: 0.2),
          child: Icon(typeIcon, color: typeColor),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                typeLabel,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            _buildStatusChip(report.status),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('بلّغ عنه: ${report.reporterName}'),
            Text(
              timeago.format(report.createdAt, locale: 'ar'),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // السبب
                _buildInfoRow('السبب', report.reason),
                const SizedBox(height: 8),
                
                // التفاصيل
                if (report.description.isNotEmpty)
                  _buildInfoRow('التفاصيل', report.description),
                
                // نوع المحتوى
                _buildInfoRow('نوع المحتوى', report.contentType),
                
                const Divider(height: 24),
                
                // أزرار الإجراءات
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildActionButton(
                      context,
                      report,
                      currentUser,
                      'تحذير',
                      ModerationAction.warning,
                      Colors.orange,
                      Icons.warning,
                    ),
                    _buildActionButton(
                      context,
                      report,
                      currentUser,
                      'حذف المحتوى',
                      ModerationAction.deleteContent,
                      Colors.red,
                      Icons.delete,
                    ),
                    _buildActionButton(
                      context,
                      report,
                      currentUser,
                      'كتم',
                      ModerationAction.muteUser,
                      Colors.purple,
                      Icons.volume_off,
                    ),
                    _buildActionButton(
                      context,
                      report,
                      currentUser,
                      'حظر',
                      ModerationAction.banUser,
                      Colors.black,
                      Icons.block,
                    ),
                    _buildActionButton(
                      context,
                      report,
                      currentUser,
                      'رفض البلاغ',
                      ModerationAction.none,
                      Colors.grey,
                      Icons.close,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(ReportStatus status) {
    Color color;
    String label;
    
    switch (status) {
      case ReportStatus.pending:
        color = Colors.orange;
        label = 'قيد المراجعة';
        break;
      case ReportStatus.investigating:
        color = Colors.blue;
        label = 'جاري التحقيق';
        break;
      case ReportStatus.actionTaken:
        color = Colors.red;
        label = 'تم اتخاذ إجراء';
        break;
      case ReportStatus.dismissed:
        color = Colors.grey;
        label = 'مرفوض';
        break;
      case ReportStatus.resolved:
        color = Colors.green;
        label = 'تم الحل';
        break;
    }

    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: color.withValues(alpha: 0.2),
      padding: EdgeInsets.zero,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: Text(value)),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    Report report,
    currentUser,
    String label,
    ModerationAction action,
    Color color,
    IconData icon,
  ) {
    return OutlinedButton.icon(
      onPressed: () => _showActionConfirmation(
        context,
        report,
        currentUser,
        action,
        label,
      ),
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color),
      ),
    );
  }

  Future<void> _showActionConfirmation(
    BuildContext context,
    Report report,
    currentUser,
    ModerationAction action,
    String actionLabel,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تأكيد الإجراء: $actionLabel'),
        content: Text('هل أنت متأكد من $actionLabel؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    // تنفيذ الإجراء
    final service = ref.read(moderationServiceProvider);
    final success = await service.reviewReport(
      reportId: report.id,
      reviewerId: currentUser.id,
      reviewerName: currentUser.name,
      newStatus: action == ModerationAction.none
          ? ReportStatus.dismissed
          : ReportStatus.actionTaken,
      action: action,
      reviewNotes: 'تم $actionLabel',
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? 'تم تنفيذ الإجراء بنجاح' : 'فشل تنفيذ الإجراء'),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }
}
