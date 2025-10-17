import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/l10n_ext.dart';
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
    final l = context.l;
    
    if (user == null) {
      return Scaffold(
        body: Center(child: Text(l.anomalyDashboardMustLogin)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l.anomalyDashboardTitle),
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
            tooltip: l.anomalyDashboardFilterStatus,
            onSelected: (status) {
              setState(() => _filterStatus = status);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: null,
                child: Text(l.anomalyDashboardAllStates),
              ),
              PopupMenuItem(
                value: InvestigationStatus.pending,
                child: Text(l.anomalyDashboardPending),
              ),
              PopupMenuItem(
                value: InvestigationStatus.investigating,
                child: Text(l.anomalyDashboardInvestigating),
              ),
              PopupMenuItem(
                value: InvestigationStatus.resolved,
                child: Text(l.anomalyDashboardResolved),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: l.anomalyDashboardTabAll, icon: const Icon(Icons.list)),
            Tab(text: l.anomalyDashboardTabHigh, icon: const Icon(Icons.priority_high)),
            Tab(text: l.anomalyDashboardTabAlerts, icon: const Icon(Icons.notifications)),
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, size: 80, color: Colors.green),
                const SizedBox(height: 20),
                Text(context.l.anomalyDashboardNoAnomalies),
                const SizedBox(height: 10),
                Text(
                  context.l.anomalyDashboardSystemNormal,
                  style: const TextStyle(color: Colors.grey),
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
        child: Text(context.l.anomalyDashboardError(error.toString())),
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.security, size: 80, color: Colors.green),
                const SizedBox(height: 20),
                Text(context.l.anomalyDashboardNoHighRisk),
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
        child: Text(context.l.anomalyDashboardError(error.toString())),
      ),
    );
  }

  /// التنبيهات
  Widget _buildAlerts(String institutionId) {
    final alertsAsync = ref.watch(anomalyAlertsProvider(institutionId));

    return alertsAsync.when(
      data: (alerts) {
        if (alerts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.notifications_off, size: 80, color: Colors.grey),
                const SizedBox(height: 20),
                Text(context.l.anomalyDashboardNoAlerts),
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
        child: Text(context.l.anomalyError(error.toString())),
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
        final l = context.l;
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.anomalyDashboardReviewSuccess)),
          );
          // تحديث القائمة
          ref.invalidate(anomaliesProvider);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.anomalyDashboardReviewFailed)),
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
                    label: Text(context.l.anomalyDashboardReviewButton),
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
    final l = context.l;
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
                  _DetailRow(l.anomalyDetailType, _getTypeLabel(anomaly.type, context)),
                  _DetailRow(l.anomalyDetailSeverity, _getSeverityLabel(anomaly.severity, context)),
                  _DetailRow(l.anomalyDetailScore, '${(anomaly.score * 100).toStringAsFixed(1)}%'),
                  _DetailRow(l.anomalyDetailConfidence, '${(anomaly.confidenceLevel * 100).toStringAsFixed(1)}%'),
                  _DetailRow(l.anomalyDetailUser, anomaly.userName),
                  _DetailRow(l.anomalyDetailStatus, _getStatusLabel(anomaly.status, context)),
                  _DetailRow(l.anomalyDetailDetected, _formatDate(anomaly.detectedAt)),
                  const SizedBox(height: 20),
                  Text(
                    l.anomalyDetailEvidence,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    Text(
                      l.anomalyDetailReview,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _DetailRow(l.anomalyDetailReviewer, anomaly.reviewerName ?? ''),
                    _DetailRow(l.anomalyDetailReviewDate, anomaly.reviewedAt != null ? _formatDate(anomaly.reviewedAt!) : ''),
                    if (anomaly.reviewNotes != null)
                      _DetailRow(l.anomalyDetailNotes, anomaly.reviewNotes!),
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

  String _getTypeLabel(AnomalyType type, BuildContext context) {
    final l = context.l;
    switch (type) {
      case AnomalyType.suspiciousLogin:
        return l.anomalyTypeSuspiciousLogin;
      case AnomalyType.unusualQuizScore:
        return l.anomalyTypeAbnormalQuizScore;
      case AnomalyType.rapidProgress:
        return l.anomalyTypeRapidProgress;
      case AnomalyType.multipleDevices:
        return l.anomalyTypeMultipleDevices;
      case AnomalyType.unusualActivity:
        return l.anomalyTypeUnusualActivity;
      case AnomalyType.cheatingPattern:
        return l.anomalyTypeCheatingPattern;
      case AnomalyType.accountSharing:
        return l.anomalyTypeAccountSharing;
    }
  }

  String _getSeverityLabel(AnomalySeverity severity, BuildContext context) {
    final l = context.l;
    switch (severity) {
      case AnomalySeverity.low:
        return l.anomalySeverityLow;
      case AnomalySeverity.medium:
        return l.anomalySeverityMedium;
      case AnomalySeverity.high:
        return l.anomalySeverityHigh;
      case AnomalySeverity.critical:
        return l.anomalySeverityCritical;
    }
  }

  String _getStatusLabel(InvestigationStatus status, BuildContext context) {
    final l = context.l;
    switch (status) {
      case InvestigationStatus.pending:
        return l.anomalyStatusPending;
      case InvestigationStatus.investigating:
        return l.anomalyStatusInvestigating;
      case InvestigationStatus.resolved:
        return l.anomalyStatusResolved;
      case InvestigationStatus.falsePositive:
        return l.anomalyStatusFalsePositive;
      case InvestigationStatus.confirmed:
        return l.anomalyStatusConfirmed;
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
    final l = context.l;
    return AlertDialog(
      title: Text(l.anomalyReviewDialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.anomaly.description),
          const SizedBox(height: 20),
          DropdownButtonFormField<InvestigationStatus>(
            initialValue: _selectedStatus,
            decoration: InputDecoration(
              labelText: l.anomalyReviewStatusLabel,
              border: const OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(
                value: InvestigationStatus.investigating,
                child: Text(l.anomalyStatusInvestigating),
              ),
              DropdownMenuItem(
                value: InvestigationStatus.resolved,
                child: Text(l.anomalyStatusResolved),
              ),
              DropdownMenuItem(
                value: InvestigationStatus.falsePositive,
                child: Text(l.anomalyStatusFalsePositive),
              ),
              DropdownMenuItem(
                value: InvestigationStatus.confirmed,
                child: Text(l.anomalyStatusConfirmed),
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
            decoration: InputDecoration(
              labelText: l.anomalyReviewNotesLabel,
              border: const OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l.dialogCancel),
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
          child: Text(l.dialogSaveButton),
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
    final l = context.l;
    Color color;
    String label;

    switch (severity) {
      case AnomalySeverity.low:
        color = Colors.blue;
        label = l.anomalySeverityLow;
        break;
      case AnomalySeverity.medium:
        color = Colors.orange;
        label = l.anomalySeverityMedium;
        break;
      case AnomalySeverity.high:
        color = Colors.red;
        label = l.anomalySeverityHigh;
        break;
      case AnomalySeverity.critical:
        color = Colors.purple;
        label = l.anomalySeverityCritical;
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
    final l = context.l;
    Color color;
    String label;

    switch (status) {
      case InvestigationStatus.pending:
        color = Colors.orange;
        label = l.anomalyStatusPending;
        break;
      case InvestigationStatus.investigating:
        color = Colors.blue;
        label = l.anomalyStatusInvestigating;
        break;
      case InvestigationStatus.resolved:
        color = Colors.green;
        label = l.anomalyStatusResolved;
        break;
      case InvestigationStatus.falsePositive:
        color = Colors.grey;
        label = l.anomalyStatusFalsePositive;
        break;
      case InvestigationStatus.confirmed:
        color = Colors.red;
        label = l.anomalyStatusConfirmed;
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
