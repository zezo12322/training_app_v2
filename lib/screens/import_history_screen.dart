import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/hris_import.dart';
import '../providers/user_providers.dart';
import 'hris_import_screen.dart';
import '../core/l10n_ext.dart';

/// شاشة سجل الاستيرادات
class ImportHistoryScreen extends ConsumerWidget {
  const ImportHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider).value;
    
    if (user == null) {
      return Scaffold(
        body: Center(child: Text(context.l.importHistoryAuthRequired)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.importHistoryTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HRISImportScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('hris_imports')
            .where('institutionId', isEqualTo: user.institutionId ?? '')
            .orderBy('uploadedAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(context.l.importHistoryError(snapshot.error.toString())));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final imports = snapshot.data!.docs
              .map((doc) => HRISImport.fromJson(doc.data() as Map<String, dynamic>))
              .toList();

          if (imports.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.history, size: 80, color: Colors.grey),
                  const SizedBox(height: 20),
                  Text(context.l.importHistoryEmpty),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HRISImportScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: Text(context.l.importHistoryNewImport),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: imports.length,
            itemBuilder: (context, index) {
              final import = imports[index];
              return _ImportCard(import: import);
            },
          );
        },
      ),
    );
  }
}

/// بطاقة استيراد
class _ImportCard extends StatelessWidget {
  final HRISImport import;

  const _ImportCard({required this.import});

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
                      import.fileName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _StatusChip(status: import.status),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _InfoChip(
                    icon: Icons.person,
                    label: '${import.totalRows}',
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  _InfoChip(
                    icon: Icons.check_circle,
                    label: '${import.successfulRows}',
                    color: Colors.green,
                  ),
                  const SizedBox(width: 8),
                  _InfoChip(
                    icon: Icons.error,
                    label: '${import.failedRows}',
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
                      import.uploaderName,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  Text(
                    _formatDate(import.uploadedAt),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              if (import.status == ImportStatus.processing)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: LinearProgressIndicator(
                    value: import.totalRows > 0
                        ? import.processedRows / import.totalRows
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
                          import.fileName,
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
                  _DetailRow(context.l.importHistoryStatus, _getStatusText(import.status, context)),
                  _DetailRow(context.l.importHistoryTotalRows, '${import.totalRows}'),
                  _DetailRow(context.l.importHistoryProcessed, '${import.processedRows}'),
                  _DetailRow(context.l.importHistorySuccessful, '${import.successfulRows}'),
                  _DetailRow(context.l.importHistoryFailed, '${import.failedRows}'),
                  _DetailRow(context.l.importHistoryUploader, import.uploaderName),
                  _DetailRow(context.l.importHistoryDate, _formatDate(import.uploadedAt)),
                  if (import.completedAt != null)
                    _DetailRow(context.l.importHistoryCompletedAt, _formatDate(import.completedAt!)),
                  const SizedBox(height: 20),
                  if (import.errors.isNotEmpty) ...[
                    Text(
                      context.l.importHistoryErrors,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: import.errors.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.red.shade50,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                import.errors[index],
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

  String _getStatusText(ImportStatus status, BuildContext context) {
    switch (status) {
      case ImportStatus.pending:
        return context.l.importHistoryStatusPending;
      case ImportStatus.processing:
        return context.l.importHistoryStatusProcessing;
      case ImportStatus.completed:
        return context.l.importHistoryStatusCompleted;
      case ImportStatus.failed:
        return context.l.importHistoryStatusFailed;
      case ImportStatus.partialSuccess:
        return context.l.importHistoryStatusPartial;
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
  final ImportStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    Color color;
    String label;

    switch (status) {
      case ImportStatus.pending:
        color = Colors.orange;
        label = l.importHistoryStatusPending;
        break;
      case ImportStatus.processing:
        color = Colors.blue;
        label = l.importHistoryStatusProcessing;
        break;
      case ImportStatus.completed:
        color = Colors.green;
        label = l.importHistoryStatusCompleted;
        break;
      case ImportStatus.failed:
        color = Colors.red;
        label = l.importHistoryStatusFailed;
        break;
      case ImportStatus.partialSuccess:
        color = Colors.amber;
        label = l.importHistoryStatusPartial;
        break;
    }

    return Chip(
      label: Text(label),
      backgroundColor: color.withValues(alpha: 0.2),
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
        color: color.withValues(alpha: 0.1),
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
