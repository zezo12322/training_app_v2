import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/anomaly.dart';
import '../providers/anomaly_providers.dart';
import '../providers/user_providers.dart';
import 'anomaly_settings_screen.dart';

/// شاشة لوحة تحكم الشذوذات
class AnomalyDashboardScreen extends ConsumerStatefulWidget {
  const AnomalyDashboardScreen({super.key});

  @override
  ConsumerState<AnomalyDashboardScreen> createState() => _AnomalyDashboardScreenState();
}

class _AnomalyDashboardScreenState extends ConsumerState<AnomalyDashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  InvestigationStatus? _filterStatus;
  AnomalySeverity? _filterSeverity;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).value;
    
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('يجب تسجيل الدخول')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('الكشف عن الشذوذ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AnomalySettingsScreen(),
                ),
              );
            },
          ),
          PopupMenuButton<InvestigationStatus?>(
            icon: const Icon(Icons.filter_list),
            tooltip: 'فلترة حسب الحالة',
            onSelected: (status) {
              setState(() => _filterStatus = status);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: null,
                child: Text('جميع الحالات'),
              ),
              const PopupMenuItem(
                value: InvestigationStatus.pending,
                child: Text('قيد الانتظار'),
              ),
              const PopupMenuItem(
                value: InvestigationStatus.investigating,
                child: Text('قيد التحقيق'),
              ),
              const PopupMenuItem(
                value: InvestigationStatus.resolved,
                child: Text('تم الحل'),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'الكل', icon: Icon(Icons.list)),
            Tab(text: 'عالي', icon: Icon(Icons.priority_high)),
            Tab(text: 'التنبيهات', icon: Icon(Icons.notifications)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAllAnomalies(user.institutionId ?? ''),
          _buildHighSeverity(user.institutionId ?? ''),
          _buildAlerts(user.institutionId ?? ''),
        ],
      ),
    );
  }

  /// جميع الشذوذات
  Widget _buildAllAnomalies(String institutionId) {
    final filter = AnomalyFilter(
      institutionId: institutionId,
      status: _filterStatus,
      severity: _filterSeverity,
    );
    
    final anomaliesAsync = ref.watch(anomaliesProvider(filter));

    return anomaliesAsync.when(
      data: (anomalies) {
        if (anomalies.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, size: 80, color: Colors.green),
                SizedBox(height: 20),
                Text('لا توجد شذوذات مكتشفة'),
                SizedBox(height: 10),
                Text(
                  'النظام يعمل بشكل طبيعي',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: anomalies.length,
          itemBuilder: (context, index) {
            final anomaly = anomalies[index];
            return _AnomalyCard(
              anomaly: anomaly,
              onReview: () => _showReviewDialog(anomaly),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('خطأ: $error'),
      ),
    );
  }

  /// الشذوذات عالية الخطورة
  Widget _buildHighSeverity(String institutionId) {
    final filter = AnomalyFilter(
      institutionId: institutionId,
      status: _filterStatus,
      severity: AnomalySeverity.high,
    );
    
    final anomaliesAsync = ref.watch(anomaliesProvider(filter));

    return anomaliesAsync.when(
      data: (anomalies) {
        if (anomalies.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.security, size: 80, color: Colors.green),
                SizedBox(height: 20),
                Text('لا توجد شذوذات عالية الخطورة'),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: anomalies.length,
          itemBuilder: (context, index) {
            final anomaly = anomalies[index];
            return _AnomalyCard(
              anomaly: anomaly,
              onReview: () => _showReviewDialog(anomaly),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('خطأ: $error'),
      ),
    );
  }

  /// التنبيهات
  Widget _buildAlerts(String institutionId) {
    final alertsAsync = ref.watch(anomalyAlertsProvider(institutionId));

    return alertsAsync.when(
      data: (alerts) {
        if (alerts.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications_off, size: 80, color: Colors.grey),
                SizedBox(height: 20),
                Text('لا توجد تنبيهات'),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: alerts.length,
          itemBuilder: (context, index) {
            final alert = alerts[index];
            return _AlertCard(alert: alert);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('خطأ: $error'),
      ),
    );
  }

  /// عرض حوار المراجعة
  Future<void> _showReviewDialog(AnomalyScore anomaly) async {
    final user = ref.read(currentUserProvider).value;
    if (user == null) return;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _ReviewDialog(anomaly: anomaly),
    );

    if (result != null && mounted) {
      final service = ref.read(anomalyDetectionServiceProvider);
      
      final success = await service.reviewAnomaly(
        anomalyId: anomaly.id,
        status: result['status'] as InvestigationStatus,
        reviewedBy: user.id,
        reviewerName: user.name,
        notes: result['notes'] as String?,
      );

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تمت المراجعة بنجاح')),
          );
          // تحديث القائمة
          ref.invalidate(anomaliesProvider);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('فشلت المراجعة')),
          );
        }
      }
    }
  }
}

/// بطاقة شذوذ
class _AnomalyCard extends StatelessWidget {
  final AnomalyScore anomaly;
  final VoidCallback onReview;

  const _AnomalyCard({
    required this.anomaly,
    required this.onReview,
  });

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
                      anomaly.description,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _SeverityChip(severity: anomaly.severity),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                anomaly.reason,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _InfoChip(
                    icon: Icons.account_circle,
                    label: anomaly.userName,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  _InfoChip(
                    icon: Icons.speed,
                    label: '${(anomaly.score * 100).toStringAsFixed(0)}%',
                    color: _getScoreColor(anomaly.score),
                  ),
                  const SizedBox(width: 8),
                  _StatusChip(status: anomaly.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _formatDate(anomaly.detectedAt),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              if (!anomaly.isReviewed)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ElevatedButton.icon(
                    onPressed: onReview,
                    icon: const Icon(Icons.rate_review, size: 18),
                    label: const Text('مراجعة'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 36),
                    ),
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
              child: ListView(
                controller: scrollController,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          anomaly.description,
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
                  _DetailRow('النوع', _getTypeLabel(anomaly.type)),
                  _DetailRow('الخطورة', _getSeverityLabel(anomaly.severity)),
                  _DetailRow('الدرجة', '${(anomaly.score * 100).toStringAsFixed(1)}%'),
                  _DetailRow('مستوى الثقة', '${(anomaly.confidenceLevel * 100).toStringAsFixed(1)}%'),
                  _DetailRow('المستخدم', anomaly.userName),
                  _DetailRow('الحالة', _getStatusLabel(anomaly.status)),
                  _DetailRow('تم الكشف', _formatDate(anomaly.detectedAt)),
                  const SizedBox(height: 20),
                  const Text(
                    'الأدلة:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...anomaly.evidencePoints.map((evidence) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• ', style: TextStyle(fontSize: 16)),
                            Expanded(child: Text(evidence)),
                          ],
                        ),
                      )),
                  if (anomaly.isReviewed) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'المراجعة:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _DetailRow('المراجع', anomaly.reviewerName ?? ''),
                    _DetailRow('تاريخ المراجعة', anomaly.reviewedAt != null ? _formatDate(anomaly.reviewedAt!) : ''),
                    if (anomaly.reviewNotes != null)
                      _DetailRow('الملاحظات', anomaly.reviewNotes!),
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

  Color _getScoreColor(double score) {
    if (score >= 0.9) return Colors.red;
    if (score >= 0.7) return Colors.orange;
    if (score >= 0.5) return Colors.amber;
    return Colors.green;
  }

  String _getTypeLabel(AnomalyType type) {
    switch (type) {
      case AnomalyType.suspiciousLogin:
        return 'تسجيل دخول مشبوه';
      case AnomalyType.unusualQuizScore:
        return 'درجة اختبار غير طبيعية';
      case AnomalyType.rapidProgress:
        return 'تقدم سريع';
      case AnomalyType.multipleDevices:
        return 'أجهزة متعددة';
      case AnomalyType.unusualActivity:
        return 'نشاط غير معتاد';
      case AnomalyType.cheatingPattern:
        return 'نمط غش';
      case AnomalyType.accountSharing:
        return 'مشاركة حساب';
    }
  }

  String _getSeverityLabel(AnomalySeverity severity) {
    switch (severity) {
      case AnomalySeverity.low:
        return 'منخفض';
      case AnomalySeverity.medium:
        return 'متوسط';
      case AnomalySeverity.high:
        return 'عالي';
      case AnomalySeverity.critical:
        return 'حرج';
    }
  }

  String _getStatusLabel(InvestigationStatus status) {
    switch (status) {
      case InvestigationStatus.pending:
        return 'قيد الانتظار';
      case InvestigationStatus.investigating:
        return 'قيد التحقيق';
      case InvestigationStatus.resolved:
        return 'تم الحل';
      case InvestigationStatus.falsePositive:
        return 'إيجابي خاطئ';
      case InvestigationStatus.confirmed:
        return 'مؤكد';
    }
  }
}

/// بطاقة تنبيه
class _AlertCard extends StatelessWidget {
  final AnomalyAlert alert;

  const _AlertCard({required this.alert});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: _getSeverityColor(alert.severity).withOpacity(0.1),
      child: ListTile(
        leading: Icon(
          Icons.warning,
          color: _getSeverityColor(alert.severity),
          size: 32,
        ),
        title: Text(
          alert.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(alert.message),
            const SizedBox(height: 4),
            Text(
              _formatDate(alert.createdAt),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Color _getSeverityColor(AnomalySeverity severity) {
    switch (severity) {
      case AnomalySeverity.low:
        return Colors.blue;
      case AnomalySeverity.medium:
        return Colors.orange;
      case AnomalySeverity.high:
        return Colors.red;
      case AnomalySeverity.critical:
        return Colors.purple;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

/// حوار المراجعة
class _ReviewDialog extends StatefulWidget {
  final AnomalyScore anomaly;

  const _ReviewDialog({required this.anomaly});

  @override
  State<_ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<_ReviewDialog> {
  late InvestigationStatus _selectedStatus;
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.anomaly.status;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('مراجعة الشذوذ'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.anomaly.description),
          const SizedBox(height: 20),
          DropdownButtonFormField<InvestigationStatus>(
            initialValue: _selectedStatus,
            decoration: const InputDecoration(
              labelText: 'الحالة',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: InvestigationStatus.investigating,
                child: Text('قيد التحقيق'),
              ),
              DropdownMenuItem(
                value: InvestigationStatus.resolved,
                child: Text('تم الحل'),
              ),
              DropdownMenuItem(
                value: InvestigationStatus.falsePositive,
                child: Text('إيجابي خاطئ'),
              ),
              DropdownMenuItem(
                value: InvestigationStatus.confirmed,
                child: Text('مؤكد'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedStatus = value);
              }
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(
              labelText: 'ملاحظات (اختياري)',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, {
              'status': _selectedStatus,
              'notes': _notesController.text.trim().isEmpty
                  ? null
                  : _notesController.text.trim(),
            });
          },
          child: const Text('حفظ'),
        ),
      ],
    );
  }
}

// Widgets مساعدة
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

class _SeverityChip extends StatelessWidget {
  final AnomalySeverity severity;

  const _SeverityChip({required this.severity});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (severity) {
      case AnomalySeverity.low:
        color = Colors.blue;
        label = 'منخفض';
        break;
      case AnomalySeverity.medium:
        color = Colors.orange;
        label = 'متوسط';
        break;
      case AnomalySeverity.high:
        color = Colors.red;
        label = 'عالي';
        break;
      case AnomalySeverity.critical:
        color = Colors.purple;
        label = 'حرج';
        break;
    }

    return Chip(
      label: Text(label),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final InvestigationStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case InvestigationStatus.pending:
        color = Colors.orange;
        label = 'قيد الانتظار';
        break;
      case InvestigationStatus.investigating:
        color = Colors.blue;
        label = 'قيد التحقيق';
        break;
      case InvestigationStatus.resolved:
        color = Colors.green;
        label = 'تم الحل';
        break;
      case InvestigationStatus.falsePositive:
        color = Colors.grey;
        label = 'إيجابي خاطئ';
        break;
      case InvestigationStatus.confirmed:
        color = Colors.red;
        label = 'مؤكد';
        break;
    }

    return Chip(
      label: Text(label),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color, fontSize: 12),
    );
  }
}

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
