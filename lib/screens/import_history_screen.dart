import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/hris_import.dart';
import '../providers/user_providers.dart';
import 'hris_import_screen.dart';

/// شاشة سجل الاستيرادات
class ImportHistoryScreen extends ConsumerWidget {
  const ImportHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider).value;
    
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('يجب تسجيل الدخول')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الاستيرادات'),
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
            return Center(child: Text('خطأ: ${snapshot.error}'));
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
                  const Text('لا توجد عمليات استيراد'),
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
                    label: const Text('استيراد جديد'),
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
                  _DetailRow('الحالة', _getStatusText(import.status)),
                  _DetailRow('إجمالي الصفوف', '${import.totalRows}'),
                  _DetailRow('تم معالجتها', '${import.processedRows}'),
                  _DetailRow('نجحت', '${import.successfulRows}'),
                  _DetailRow('فشلت', '${import.failedRows}'),
                  _DetailRow('المستخدم', import.uploaderName),
                  _DetailRow('التاريخ', _formatDate(import.uploadedAt)),
                  if (import.completedAt != null)
                    _DetailRow('اكتملت في', _formatDate(import.completedAt!)),
                  const SizedBox(height: 20),
                  if (import.errors.isNotEmpty) ...[
                    const Text(
                      'الأخطاء:',
                      style: TextStyle(
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

  String _getStatusText(ImportStatus status) {
    switch (status) {
      case ImportStatus.pending:
        return 'قيد الانتظار';
      case ImportStatus.processing:
        return 'جاري المعالجة';
      case ImportStatus.completed:
        return 'مكتمل';
      case ImportStatus.failed:
        return 'فشل';
      case ImportStatus.partialSuccess:
        return 'نجاح جزئي';
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
    Color color;
    String label;

    switch (status) {
      case ImportStatus.pending:
        color = Colors.orange;
        label = 'قيد الانتظار';
        break;
      case ImportStatus.processing:
        color = Colors.blue;
        label = 'جاري المعالجة';
        break;
      case ImportStatus.completed:
        color = Colors.green;
        label = 'مكتمل';
        break;
      case ImportStatus.failed:
        color = Colors.red;
        label = 'فشل';
        break;
      case ImportStatus.partialSuccess:
        color = Colors.amber;
        label = 'نجاح جزئي';
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
