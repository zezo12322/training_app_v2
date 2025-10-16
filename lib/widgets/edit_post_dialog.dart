import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/wall_post.dart';
import '../providers/wall_post_providers.dart';
import '../core/l10n_ext.dart';

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

    final l = context.l;
    
    result.when(
      success: (_) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l.editPostSuccess),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      failure: (error) {
        setState(() => _isUpdating = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l.errorGeneric}: ${error.message}'),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(l.editPostTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              maxLines: 8,
              maxLength: 5000,
              autofocus: true,
              decoration: InputDecoration(
                hintText: l.editPostPlaceholder,
                border: const OutlineInputBorder(),
                counterText: '',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l.editPostCharacterCount
                  .replaceAll('{current}', '${_controller.text.length}')
                  .replaceAll('{max}', '5000'),
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
          child: Text(l.dialogCancelButton),
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
              : Text(l.editPostSaveButton),
        ),
      ],
    );
  }
}
