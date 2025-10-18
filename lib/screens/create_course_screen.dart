import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/course_providers.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
import 'package:training_app/widgets/widgets.dart';
import 'package:training_app/core/design/tokens.dart';

class CreateCourseScreen extends ConsumerStatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  ConsumerState<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends ConsumerState<CreateCourseScreen> {
  final _courseNameController = TextEditingController();
  bool _isLoading = false;
  String? _generatedCode;

  void _showSnackBar(String message, {bool isError = true}) {
    if (!mounted) return;
    AppSnackBar.show(context, message, isError: isError);
  }

  Future<void> _createCourse() async {
    final l = context.l; // cache localization
    if (_courseNameController.text.trim().isEmpty) {
      _showSnackBar(l.courseNameLabel);
      return;
    }
    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      final repo = ref.read(courseRepositoryProvider);
      final auth = ref.read(authStateProvider).value;
      final result = await repo.createCourse(
        name: _courseNameController.text.trim(),
        trainerId: auth?.uid ?? '',
      );
      result.when(
        success: (course) {
          if (!mounted) return;
          setState(() => _generatedCode = course.courseCode);
          _showSnackBar(l.courseCreatedSuccess, isError: false);
        },
        failure: (f) => _showSnackBar(l.createCourseFailed(f.message)),
      );
    } catch (e) {
      _showSnackBar(l.createCourseFailed(e.toString()));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _courseNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Scaffold(
      appBar: AppBar(title: Text(l.createCourseTitle)),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(DesignTokens.spacingXl),
          child: _generatedCode == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextField(
                      controller: _courseNameController,
                      label: l.courseNameLabel,
                      prefixIcon: Icons.school_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l.courseNameLabel;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: DesignTokens.spacingXl),
                    _isLoading
                        ? Center(
                            child: Column(
                              children: [
                                const CircularProgressIndicator(),
                                SizedBox(height: DesignTokens.spacingMd),
                                Text(
                                  'Creating course...',
                                  style: DesignTokens.body2(context).copyWith(
                                    color: DesignTokens.textSecondary(context),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : AppButton(
                            text: l.createCourseAction,
                            icon: Icons.add,
                            onPressed: _createCourse,
                            type: AppButtonType.primary,
                            fullWidth: true,
                          ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppCard(
                      padding: EdgeInsets.all(DesignTokens.spacingXl),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(DesignTokens.spacingMd),
                            decoration: BoxDecoration(
                              color: DesignTokens.success.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: DesignTokens.success,
                              size: 64,
                            ),
                          ),
                          SizedBox(height: DesignTokens.spacingLg),
                          Text(
                            l.courseCreatedSuccess,
                            style: DesignTokens.h4(context),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: DesignTokens.spacingXl),
                          Text(
                            l.shareCodeHint,
                            style: DesignTokens.body2(context).copyWith(
                              color: DesignTokens.textSecondary(context),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: DesignTokens.spacingMd),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: DesignTokens.spacingLg,
                              vertical: DesignTokens.spacingMd,
                            ),
                            decoration: BoxDecoration(
                              color: DesignTokens.info.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                              border: Border.all(
                                color: DesignTokens.info.withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: SelectableText(
                              _generatedCode!,
                              style: DesignTokens.h3(context).copyWith(
                                color: DesignTokens.info,
                                letterSpacing: 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: DesignTokens.spacingXl),
                    AppButton(
                      text: l.backToHome,
                      onPressed: () => Navigator.of(context).pop(),
                      type: AppButtonType.secondary,
                      fullWidth: true,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
