import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/poll_providers.dart';
import '../core/l10n_ext.dart';

class CreatePollDialog extends ConsumerStatefulWidget {
  final String postId;
  final String userId;
  final String courseId;
  final String? authorEmail;
  final String? authorName;

  const CreatePollDialog({
    super.key,
    required this.postId,
    required this.userId,
    required this.courseId,
    this.authorEmail,
    this.authorName,
  });

  @override
  ConsumerState<CreatePollDialog> createState() => _CreatePollDialogState();
}

class _CreatePollDialogState extends ConsumerState<CreatePollDialog> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  bool _allowMultipleVotes = false;
  bool _showResultsBeforeVoting = false;
  DateTime? _endsAt;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _questionController.dispose();
    for (final controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addOption() {
    final l = context.l;
    if (_optionControllers.length >= 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.createPollMaxOptionsError)),
      );
      return;
    }
    setState(() {
      _optionControllers.add(TextEditingController());
    });
  }

  void _removeOption(int index) {
    final l = context.l;
    if (_optionControllers.length <= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.createPollMinOptionsError)),
      );
      return;
    }
    setState(() {
      _optionControllers[index].dispose();
      _optionControllers.removeAt(index);
    });
  }

  Future<void> _selectEndDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 7)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );

    if (pickedDate != null && mounted) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null && mounted) {
        setState(() {
          _endsAt = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _submit() async {
    final l = context.l;
    if (!_formKey.currentState!.validate()) return;

    final options = _optionControllers
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    if (options.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.createPollMinOptionsSubmitError)),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // ✅ STEP 1: Create the wall post FIRST (empty, ready to receive poll)
      await FirebaseFirestore.instance.collection('course_wall').doc(widget.postId).set({
        'courseId': widget.courseId,
        'authorId': widget.userId,
        'authorEmail': widget.authorEmail ?? '',
        'authorName': widget.authorName,
        'content': '', // Empty content for poll posts
        'reactions': {},
        'reactionUsers': {},
        'commentCount': 0,
        'isPinned': false,
        'isArchived': false,
        'isEdited': false,
        'imageUrls': [],
        'createdAt': Timestamp.now(), // Use Timestamp.now() instead of serverTimestamp
      });

      // ✅ STEP 2: Create the poll and attach it to the existing post
      final poll = await ref.read(createPollProvider)(
        postId: widget.postId,
        question: _questionController.text.trim(),
        options: options,
        createdBy: widget.userId,
        endsAt: _endsAt,
        allowMultipleVotes: _allowMultipleVotes,
        showResultsBeforeVoting: _showResultsBeforeVoting,
      );

      if (mounted) {
        Navigator.of(context).pop(poll); // Return the created poll
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.createPollSuccess)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l.errorGeneric}: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.poll_outlined,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    l.createPollTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Form
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    // Question
                    TextFormField(
                      controller: _questionController,
                      decoration: InputDecoration(
                        labelText: l.createPollQuestionLabel,
                        hintText: l.createPollQuestionHint,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.question_mark),
                      ),
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l.createPollQuestionRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Options
                    Text(
                      l.createPollOptionsTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),

                    ..._optionControllers.asMap().entries.map((entry) {
                      final index = entry.key;
                      final controller = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller,
                                decoration: InputDecoration(
                                  labelText: l.createPollOptionLabel.replaceAll('{number}', '${index + 1}'),
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.check_box_outline_blank),
                                ),
                                validator: (value) {
                                  if (index < 2 && (value == null || value.trim().isEmpty)) {
                                    return l.createPollOptionRequired;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            if (_optionControllers.length > 2)
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => _removeOption(index),
                                color: Theme.of(context).colorScheme.error,
                              ),
                          ],
                        ),
                      );
                    }),

                    // Add Option Button
                    OutlinedButton.icon(
                      onPressed: _addOption,
                      icon: const Icon(Icons.add),
                      label: Text(l.createPollAddOption),
                    ),
                    const SizedBox(height: 24),

                    // Settings
                    Text(
                      l.createPollSettingsTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),

                    SwitchListTile(
                      title: Text(l.createPollAllowMultiple),
                      value: _allowMultipleVotes,
                      onChanged: (value) {
                        setState(() => _allowMultipleVotes = value);
                      },
                    ),

                    SwitchListTile(
                      title: Text(l.createPollShowResults),
                      value: _showResultsBeforeVoting,
                      onChanged: (value) {
                        setState(() => _showResultsBeforeVoting = value);
                      },
                    ),

                    // End Date
                    ListTile(
                      title: Text(l.createPollEndDateLabel),
                      subtitle: _endsAt != null
                          ? Text(
                              '${_endsAt!.year}-${_endsAt!.month.toString().padLeft(2, '0')}-${_endsAt!.day.toString().padLeft(2, '0')} ${_endsAt!.hour.toString().padLeft(2, '0')}:${_endsAt!.minute.toString().padLeft(2, '0')}',
                            )
                          : Text(l.createPollEndDateNone),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_endsAt != null)
                            IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() => _endsAt = null);
                              },
                            ),
                          IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: _selectEndDate,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Actions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
                    child: Text(l.dialogCancelButton),
                  ),
                  const SizedBox(width: 12),
                  FilledButton.icon(
                    onPressed: _isSubmitting ? null : _submit,
                    icon: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.check),
                    label: Text(_isSubmitting ? l.createPollCreatingButton : l.createPollCreateButton),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
