import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/moderation.dart';
import '../providers/moderation_providers.dart';
import '../providers/auth_provider.dart';
import '../core/l10n_ext.dart';

/// شاشة قائمة انتظار الإشراف
class ModerationQueueScreen extends ConsumerStatefulWidget {
  const ModerationQueueScreen({super.key});

  @override
  ConsumerState<ModerationQueueScreen> createState() => _ModerationQueueScreenState();
}

class _ModerationQueueScreenState extends ConsumerState<ModerationQueueScreen> {

  String _getReportTypeLabel(ReportType type, BuildContext context) {
    final l = context.l;
    switch (type) {
      case ReportType.inappropriate:
        return l.moderationQueueReasonInappropriate;
      case ReportType.harassment:
        return l.moderationQueueReasonHarassment;
      case ReportType.spam:
        return 'spam';
      case ReportType.misinformation:
        return l.moderationQueueReasonMisinformation;
      case ReportType.harmful:
        return l.moderationQueueReasonHarmful;
      case ReportType.copyright:
        return l.moderationQueueReasonCopyright;
      case ReportType.other:
        return l.moderationQueueReasonOther;
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
        title: Text(context.l.moderationQueueTitle),
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
            data: (stats) => _buildStatsCard(stats, context),
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text(context.l.moderationQueueError(error.toString())),
          ),

          const Divider(height: 1),

          // قائمة التقارير
          Expanded(
            child: reportsAsync.when(
              data: (reports) {
                if (reports.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle, size: 64, color: Colors.green),
                        const SizedBox(height: 16),
                        Text(
                          context.l.moderationQueueNoPending,
                          style: const TextStyle(fontSize: 16),
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
                child: Text(context.l.moderationQueueLoadError(error.toString())),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(ModerationStats stats, BuildContext context) {
    final l = context.l;
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(l.moderationQueuePending, stats.pendingReports, Colors.orange),
            _buildStatItem(l.moderationQueueResolved, stats.resolvedReports, Colors.green),
            _buildStatItem(l.moderationQueueDismissed, stats.dismissedReports, Colors.grey),
            _buildStatItem(l.moderationQueueTotal, stats.totalReports, Colors.blue),
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
    final typeLabel = _getReportTypeLabel(report.type, context);

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
            _buildStatusChip(report.status, context),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(context.l.moderationQueueReportedBy(report.reporterName)),
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
                _buildInfoRow(context.l.moderationQueueReason, report.reason),
                const SizedBox(height: 8),
                
                // التفاصيل
                if (report.description.isNotEmpty)
                  _buildInfoRow(context.l.moderationQueueDetails, report.description),
                
                // نوع المحتوى
                _buildInfoRow(context.l.moderationQueueContentType, report.contentType),
                
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
                      context.l.moderationQueueActionWarn,
                      ModerationAction.warning,
                      Colors.orange,
                      Icons.warning,
                    ),
                    _buildActionButton(
                      context,
                      report,
                      currentUser,
                      context.l.moderationQueueActionDelete,
                      ModerationAction.deleteContent,
                      Colors.red,
                      Icons.delete,
                    ),
                    _buildActionButton(
                      context,
                      report,
                      currentUser,
                      context.l.moderationQueueActionMute,
                      ModerationAction.muteUser,
                      Colors.purple,
                      Icons.volume_off,
                    ),
                    _buildActionButton(
                      context,
                      report,
                      currentUser,
                      context.l.moderationQueueActionBan,
                      ModerationAction.banUser,
                      Colors.black,
                      Icons.block,
                    ),
                    _buildActionButton(
                      context,
                      report,
                      currentUser,
                      context.l.moderationQueueActionDismiss,
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

  Widget _buildStatusChip(ReportStatus status, BuildContext context) {
    final l = context.l;
    Color color;
    String label;
    
    switch (status) {
      case ReportStatus.pending:
        color = Colors.orange;
        label = l.moderationQueueStatusPending;
        break;
      case ReportStatus.investigating:
        color = Colors.blue;
        label = l.moderationQueueStatusInvestigating;
        break;
      case ReportStatus.actionTaken:
        color = Colors.red;
        label = l.moderationQueueStatusActionTaken;
        break;
      case ReportStatus.dismissed:
        color = Colors.grey;
        label = l.moderationQueueStatusDismissed;
        break;
      case ReportStatus.resolved:
        color = Colors.green;
        label = l.moderationQueueStatusResolved;
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
    final l = context.l;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.moderationQueueConfirmTitle(actionLabel)),
        content: Text(l.moderationQueueConfirmMessage(actionLabel)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l.moderationQueueCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l.moderationQueueConfirm),
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
      reviewNotes: l.moderationQueueActionCompleted(actionLabel),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? l.moderationQueueActionSuccess : l.moderationQueueActionFailed),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }
}
