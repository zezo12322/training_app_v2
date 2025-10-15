import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/moderation.dart';
import '../providers/moderation_providers.dart';
import '../providers/auth_provider.dart';

/// حوار الإبلاغ عن محتوى
class ReportDialog extends ConsumerStatefulWidget {
  final String contentType;
  final String contentId;
  final String reportedUserId;
  final String? courseId;

  const ReportDialog({
    super.key,
    required this.contentType,
    required this.contentId,
    required this.reportedUserId,
    this.courseId,
  });

  @override
  ConsumerState<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends ConsumerState<ReportDialog> {
  ReportType _selectedType = ReportType.inappropriate;
  final _reasonController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _reasonController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitReport() async {
    if (_reasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال سبب الإبلاغ')),
      );
      return;
    }

    final currentUserAsync = ref.read(currentUserModelProvider);
    final currentUser = currentUserAsync.value;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يجب تسجيل الدخول أولاً')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final params = {
        'reporterId': currentUser.id,
        'reporterName': currentUser.name,
        'type': _selectedType,
        'contentType': widget.contentType,
        'contentId': widget.contentId,
        'reportedUserId': widget.reportedUserId,
        'reason': _reasonController.text.trim(),
        'description': _descriptionController.text.trim(),
        'institutionId': currentUser.institutionId ?? '',
        'companyId': currentUser.companyId ?? '',
        'courseId': widget.courseId,
      };

      final result = await ref.read(submitReportProvider(params).future);

      if (!mounted) return;

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إرسال البلاغ بنجاح. سيتم مراجعته من قبل المشرفين.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('حدث خطأ أثناء إرسال البلاغ'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطأ: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  String _getReportTypeLabel(ReportType type) {
    switch (type) {
      case ReportType.inappropriate:
        return 'محتوى غير لائق';
      case ReportType.harassment:
        return 'تحرش أو مضايقة';
      case ReportType.spam:
        return 'رسائل غير مرغوب فيها';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.report, color: Colors.red),
          SizedBox(width: 8),
          Text('الإبلاغ عن محتوى'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // نوع البلاغ
            DropdownButtonFormField<ReportType>(
              value: _selectedType,
              decoration: const InputDecoration(
                labelText: 'نوع البلاغ',
                border: OutlineInputBorder(),
              ),
              items: ReportType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(_getReportTypeLabel(type)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedType = value);
                }
              },
            ),

            const SizedBox(height: 16),

            // السبب
            TextField(
              controller: _reasonController,
              decoration: const InputDecoration(
                labelText: 'السبب *',
                hintText: 'أدخل سبب الإبلاغ',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),

            const SizedBox(height: 16),

            // التفاصيل
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'تفاصيل إضافية (اختياري)',
                hintText: 'أضف أي تفاصيل إضافية تساعد في المراجعة',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),

            const SizedBox(height: 8),

            Text(
              'سيتم مراجعة البلاغ من قبل فريق الإشراف',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submitReport,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: _isSubmitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('إرسال البلاغ'),
        ),
      ],
    );
  }
}

/// زر الإبلاغ (يمكن إضافته في قائمة الرسالة)
class ReportButton extends StatelessWidget {
  final String contentType;
  final String contentId;
  final String reportedUserId;
  final String? courseId;

  const ReportButton({
    super.key,
    required this.contentType,
    required this.contentId,
    required this.reportedUserId,
    this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.report, color: Colors.red),
      title: const Text('الإبلاغ'),
      onTap: () {
        Navigator.of(context).pop(); // إغلاق القائمة
        showDialog(
          context: context,
          builder: (context) => ReportDialog(
            contentType: contentType,
            contentId: contentId,
            reportedUserId: reportedUserId,
            courseId: courseId,
          ),
        );
      },
    );
  }
}
