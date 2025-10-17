import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bigquery_export.dart';
import '../providers/bigquery_providers.dart';
import '../providers/user_providers.dart';
import '../core/logging.dart';
import '../core/l10n_ext.dart';
import 'bigquery_settings_screen.dart';

/// شاشة تصدير BigQuery
class BigQueryExportScreen extends ConsumerStatefulWidget {
  const BigQueryExportScreen({super.key});

  @override
  ConsumerState<BigQueryExportScreen> createState() => _BigQueryExportScreenState();
}

class _BigQueryExportScreenState extends ConsumerState<BigQueryExportScreen> {
  ExportType _selectedType = ExportType.users;
  bool _isExporting = false;

  Future<void> _startExport() async {
    final user = ref.read(currentUserProvider).value;
    if (user == null) return;

    // التحقق من الإعدادات
    final config = await ref.read(bigQueryConfigProvider(user.institutionId ?? '').future);
    
    if (config == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.bigqueryExportNotConfigured)),
        );
      }
      return;
    }

    if (!config.isEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.bigqueryExportNotEnabled)),
        );
      }
      return;
    }

    setState(() => _isExporting = true);

    try {
      final service = ref.read(bigQueryExportServiceProvider);
      
      await service.startExport(
        exportType: _selectedType,
        institutionId: user.institutionId ?? '',
        companyId: user.companyId,
        userId: user.id,
        userName: user.name,
        config: config,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.bigqueryExportStarted)),
        );
      }
    } catch (e) {
      logger.e('Error starting export', error: e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.bigqueryExportError(e.toString()))),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final user = ref.watch(currentUserProvider).value;
    
    if (user == null) {
      return Scaffold(
        body: Center(child: Text(l.bigqueryExportAuthRequired)),
      );
    }

    final exportsAsync = ref.watch(exportsHistoryProvider(user.institutionId ?? ''));

    return Scaffold(
      appBar: AppBar(
        title: Text(l.bigqueryExportTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BigQuerySettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // قسم التصدير الجديد
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l.bigqueryExportNewExport,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<ExportType>(
                    initialValue: _selectedType,
                    decoration: InputDecoration(
                      labelText: l.bigqueryExportDataType,
                      border: const OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: ExportType.users,
                        child: Text(l.bigqueryExportUsers),
                      ),
                      DropdownMenuItem(
                        value: ExportType.courses,
                        child: Text(l.bigqueryExportCourses),
                      ),
                      DropdownMenuItem(
                        value: ExportType.enrollments,
                        child: Text(l.bigqueryExportEnrollments),
                      ),
                      DropdownMenuItem(
                        value: ExportType.quizResults,
                        child: Text(l.bigqueryExportQuizResults),
                      ),
                      DropdownMenuItem(
                        value: ExportType.certificates,
                        child: Text(l.bigqueryExportCertificates),
                      ),
                      DropdownMenuItem(
                        value: ExportType.gamification,
                        child: Text(l.bigqueryExportPointsAchievements),
                      ),
                      DropdownMenuItem(
                        value: ExportType.all,
                        child: Text(l.bigqueryExportAll),
                      ),
                    ],
                    onChanged: _isExporting
                        ? null
                        : (value) {
                            if (value != null) {
                              setState(() => _selectedType = value);
                            }
                          },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _isExporting ? null : _startExport,
                    icon: _isExporting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.cloud_upload),
                    label: Text(_isExporting ? l.bigqueryExportExporting : l.bigqueryExportStart),
                  ),
                ],
              ),
            ),
          ),
          
          // قسم السجل
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  l.bigqueryExportHistory,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    ref.invalidate(exportsHistoryProvider(user.institutionId ?? ''));
                  },
                  icon: const Icon(Icons.refresh),
                  label: Text(l.bigqueryExportRefresh),
                ),
              ],
            ),
          ),
          
          // قائمة السجل
          Expanded(
            child: exportsAsync.when(
              data: (exports) {
                if (exports.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.history, size: 80, color: Colors.grey),
                        const SizedBox(height: 20),
                        Text(l.bigqueryExportNoExports),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: exports.length,
                  itemBuilder: (context, index) {
                    final export = exports[index];
                    return _ExportCard(export: export);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(l.bigqueryExportError(error.toString())),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// بطاقة تصدير
class _ExportCard extends StatelessWidget {
  final BigQueryExport export;

  const _ExportCard({required this.export});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showDetails(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _getTypeLabel(export.exportType, context),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _StatusChip(status: export.status),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _InfoChip(
                    icon: Icons.storage,
                    label: '${export.totalRecords}',
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  _InfoChip(
                    icon: Icons.check_circle,
                    label: '${export.exportedRecords}',
                    color: Colors.green,
                  ),
                  const SizedBox(width: 8),
                  if (export.failedRecords > 0)
                    _InfoChip(
                      icon: Icons.error,
                      label: '${export.failedRecords}',
                      color: Colors.red,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      export.triggeredByName,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  Text(
                    _formatDate(export.startedAt),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              if (export.status == ExportStatus.processing ||
                  export.status == ExportStatus.uploading)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: LinearProgressIndicator(
                    value: export.totalRecords > 0
                        ? export.exportedRecords / export.totalRecords
                        : 0,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _getTypeLabel(export.exportType, context),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _DetailRow(context.l.bigqueryExportDetailStatus, _getStatusText(export.status, context)),
                  _DetailRow(context.l.bigqueryExportDetailType, _getTypeLabel(export.exportType, context)),
                  _DetailRow(context.l.bigqueryExportDetailTotal, '${export.totalRecords}'),
                  _DetailRow(context.l.bigqueryExportDetailExported, '${export.exportedRecords}'),
                  _DetailRow(context.l.bigqueryExportDetailFailed, '${export.failedRecords}'),
                  _DetailRow('Project ID', export.projectId),
                  _DetailRow('Dataset ID', export.datasetId),
                  _DetailRow('Table ID', export.tableId),
                  _DetailRow(context.l.bigqueryExportDetailUser, export.triggeredByName),
                  _DetailRow(context.l.bigqueryExportDetailStarted, _formatDate(export.startedAt)),
                  if (export.completedAt != null)
                    _DetailRow(context.l.bigqueryExportDetailCompleted, _formatDate(export.completedAt!)),
                  const SizedBox(height: 20),
                  if (export.errors.isNotEmpty) ...[
                    Text(
                      context.l.bigqueryExportDetailErrors,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: export.errors.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.red.shade50,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                export.errors[index],
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _getTypeLabel(ExportType type, BuildContext context) {
    final l = context.l;
    switch (type) {
      case ExportType.users:
        return l.bigqueryExportUsers;
      case ExportType.courses:
        return l.bigqueryExportCourses;
      case ExportType.enrollments:
        return l.bigqueryExportEnrollments;
      case ExportType.quizResults:
        return l.bigqueryExportQuizResults;
      case ExportType.certificates:
        return l.bigqueryExportCertificates;
      case ExportType.gamification:
        return l.bigqueryExportPointsAchievements;
      case ExportType.analytics:
        return l.bigqueryExportAnalytics;
      case ExportType.progress:
        return l.bigqueryExportProgress;
      case ExportType.all:
        return l.bigqueryExportAll;
    }
  }

  String _getStatusText(ExportStatus status, BuildContext context) {
    final l = context.l;
    switch (status) {
      case ExportStatus.pending:
        return l.bigqueryExportStatusPending;
      case ExportStatus.processing:
        return l.bigqueryExportStatusProcessing;
      case ExportStatus.uploading:
        return l.bigqueryExportStatusUploading;
      case ExportStatus.completed:
        return l.bigqueryExportStatusCompleted;
      case ExportStatus.failed:
        return l.bigqueryExportStatusFailed;
    }
  }
}

/// صف تفاصيل
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

/// رقاقة الحالة
class _StatusChip extends StatelessWidget {
  final ExportStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    Color color;
    String label;

    switch (status) {
      case ExportStatus.pending:
        color = Colors.orange;
        label = l.bigqueryExportStatusPending;
        break;
      case ExportStatus.processing:
        color = Colors.blue;
        label = l.bigqueryExportStatusProcessing;
        break;
      case ExportStatus.uploading:
        color = Colors.purple;
        label = l.bigqueryExportStatusUploading;
        break;
      case ExportStatus.completed:
        color = Colors.green;
        label = l.bigqueryExportStatusCompleted;
        break;
      case ExportStatus.failed:
        color = Colors.red;
        label = l.bigqueryExportStatusFailed;
        break;
    }

    return Chip(
      label: Text(label),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color),
    );
  }
}

/// رقاقة معلومات
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      ),
    );
  }
}
