import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/wall_post.dart';
import '../providers/wall_post_providers.dart';

class EditPostDialog extends ConsumerStatefulWidget {
  final WallPost post;

  const EditPostDialog({
    super.key,
    required this.post,
  });

  @override
  ConsumerState<EditPostDialog> createState() => _EditPostDialogState();
}

class _EditPostDialogState extends ConsumerState<EditPostDialog> {
  late TextEditingController _controller;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.post.content);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final content = _controller.text.trim();
    if (content.isEmpty || content == widget.post.content) {
      Navigator.pop(context);
      return;
    }

    setState(() => _isUpdating = true);

    final result = await ref.read(updatePostProvider)(
      postId: widget.post.id,
      content: content,
      imageUrl: widget.post.imageUrl,
      fileUrl: widget.post.fileUrl,
    );

    if (!mounted) return;

    result.when(
      success: (_) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم تحديث المنشور'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      failure: (error) {
        setState(() => _isUpdating = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ: ${error.message}'),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Text('تعديل المنشور'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              maxLines: 8,
              maxLength: 5000,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'اكتب محتوى المنشور...',
                border: OutlineInputBorder(),
                counterText: '',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${_controller.text.length}/5000 حرف',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isUpdating ? null : () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: _isUpdating ? null : _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: Colors.white,
          ),
          child: _isUpdating
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('حفظ'),
        ),
      ],
    );
  }
}
