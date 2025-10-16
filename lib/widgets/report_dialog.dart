import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/moderation.dart';
import '../providers/moderation_providers.dart';
import '../providers/auth_provider.dart';
import '../core/l10n_ext.dart';

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
    final l = context.l;
    if (_reasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.reportReasonRequired)),
      );
      return;
    }

    final currentUserAsync = ref.read(currentUserModelProvider);
    final currentUser = currentUserAsync.value;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.reportLoginRequired)),
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
          SnackBar(
            content: Text(l.reportSuccess),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l.reportError),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${l.errorGeneric}: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally{
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  String _getReportTypeLabel(ReportType type) {
    final l = context.l;
    switch (type) {
      case ReportType.inappropriate:
        return l.reportTypeInappropriate;
      case ReportType.harassment:
        return l.reportTypeHarassment;
      case ReportType.spam:
        return l.reportTypeSpam;
      case ReportType.misinformation:
        return l.reportTypeMisinformation;
      case ReportType.harmful:
        return l.reportTypeHarmful;
      case ReportType.copyright:
        return l.reportTypeCopyright;
      case ReportType.other:
        return l.reportTypeOther;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final theme = Theme.of(context);

    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.report, color: Colors.red),
          const SizedBox(width: 8),
          Text(l.reportDialogTitle),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // نوع البلاغ
            DropdownButtonFormField<ReportType>(
              initialValue: _selectedType,
              decoration: InputDecoration(
                labelText: l.reportTypeLabel,
                border: const OutlineInputBorder(),
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
              decoration: InputDecoration(
                labelText: l.reportReasonLabel,
                hintText: l.reportReasonHint,
                border: const OutlineInputBorder(),
              ),
              maxLines: 2,
            ),

            const SizedBox(height: 16),

            // التفاصيل
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: l.reportDescriptionLabel,
                hintText: l.reportDescriptionHint,
                border: const OutlineInputBorder(),
              ),
              maxLines: 4,
            ),

            const SizedBox(height: 8),

            Text(
              l.reportReviewNote,
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
          child: Text(l.dialogCancelButton),
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
              : Text(l.reportSubmitButton),
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
    final l = context.l;
    
    return ListTile(
      leading: const Icon(Icons.report, color: Colors.red),
      title: Text(l.reportButtonLabel),
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
