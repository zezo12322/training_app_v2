import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/widgets/widgets.dart';
import 'package:training_app/core/design/tokens.dart';
import 'package:training_app/models/gamification/learning_module.dart';
import 'package:training_app/providers/gamification/module_providers.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';

/// Professional Add Module Screen with Design System
/// 
/// Features:
/// - Form validation
/// - AppTextField & AppButton
/// - Professional loading state
/// - Success feedback
/// - DesignTokens for consistency
class AddModuleScreen extends ConsumerStatefulWidget {
  final String courseId;

  const AddModuleScreen({
    super.key,
    required this.courseId,
  });

  @override
  ConsumerState<AddModuleScreen> createState() => _AddModuleScreenState();
}

class _AddModuleScreenState extends ConsumerState<AddModuleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _orderIndexController = TextEditingController(text: '1');
  final _pointsRewardController = TextEditingController(text: '10');
  bool _isLocked = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _orderIndexController.dispose();
    _pointsRewardController.dispose();
    super.dispose();
  }

  Future<void> _createModule() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final module = LearningModule(
        courseId: widget.courseId,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        orderIndex: int.parse(_orderIndexController.text.trim()),
        completionPoints: int.parse(_pointsRewardController.text.trim()),
        requirements: ModuleRequirements(
          completeLessons: true,
          passAllQuizzes: _isLocked,
          minimumQuizScore: _isLocked ? 70 : 0,
        ),
      );

      final repository = ref.read(moduleRepositoryProvider);
      final result = await repository.createModule(module);

      if (!mounted) return;

      AppSnackBar.show(
        context,
        'Module created successfully! ID: $result',
        isError: false,
      );
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      AppSnackBar.show(
        context,
        'Error: ${e.toString()}',
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Module'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(DesignTokens.spacingLg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppCard(
                padding: EdgeInsets.all(DesignTokens.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(DesignTokens.spacingSm),
                          decoration: BoxDecoration(
                            color: DesignTokens.info.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                          ),
                          child: Icon(
                            Icons.school_outlined,
                            color: DesignTokens.info,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: DesignTokens.spacingSm),
                        Text(
                          'Module Details',
                          style: DesignTokens.h5(context),
                        ),
                      ],
                    ),
                    SizedBox(height: DesignTokens.spacingLg),

                    // Title
                    AppTextField(
                      controller: _titleController,
                      label: 'Module Title',
                      hint: 'e.g., Introduction to Flutter',
                      prefixIcon: Icons.title_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Title is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: DesignTokens.spacingMd),

                    // Description
                    AppTextField(
                      controller: _descriptionController,
                      label: 'Description',
                      hint: 'Describe what this module covers...',
                      prefixIcon: Icons.description_outlined,
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Description is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: DesignTokens.spacingMd),

                    // Order Index
                    AppTextField(
                      controller: _orderIndexController,
                      label: 'Order Index',
                      hint: '1, 2, 3...',
                      prefixIcon: Icons.format_list_numbered,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Order index is required';
                        }
                        final number = int.tryParse(value);
                        if (number == null || number < 1) {
                          return 'Must be a positive number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: DesignTokens.spacingMd),

                    // Points Reward
                    AppTextField(
                      controller: _pointsRewardController,
                      label: 'Points Reward',
                      hint: '10, 20, 50...',
                      prefixIcon: Icons.stars_outlined,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Points reward is required';
                        }
                        final number = int.tryParse(value);
                        if (number == null || number < 0) {
                          return 'Must be a non-negative number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: DesignTokens.spacingLg),

                    // Is Locked Switch
                    Row(
                      children: [
                        Icon(
                          _isLocked ? Icons.lock : Icons.lock_open,
                          color: _isLocked 
                              ? DesignTokens.error 
                              : DesignTokens.success,
                          size: 20,
                        ),
                        SizedBox(width: DesignTokens.spacingSm),
                        Expanded(
                          child: Text(
                            'Lock this module',
                            style: DesignTokens.body1(context),
                          ),
                        ),
                        Switch(
                          value: _isLocked,
                          onChanged: (value) {
                            setState(() => _isLocked = value);
                          },
                          activeColor: DesignTokens.error,
                        ),
                      ],
                    ),
                    SizedBox(height: DesignTokens.spacingXs),
                    Padding(
                      padding: EdgeInsets.only(left: DesignTokens.spacingXl),
                      child: Text(
                        _isLocked
                            ? 'Students must complete previous modules first'
                            : 'Students can access this module immediately',
                        style: DesignTokens.caption(context).copyWith(
                          color: DesignTokens.textSecondary(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: DesignTokens.spacingXl),

              // Create Button
              _isLoading
                  ? Center(
                      child: Column(
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(height: DesignTokens.spacingMd),
                          Text(
                            'Creating module...',
                            style: DesignTokens.body2(context).copyWith(
                              color: DesignTokens.textSecondary(context),
                            ),
                          ),
                        ],
                      ),
                    )
                  : AppButton(
                      text: 'Create Module',
                      icon: Icons.add,
                      onPressed: _createModule,
                      type: AppButtonType.primary,
                      fullWidth: true,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
