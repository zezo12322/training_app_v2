import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/course_providers.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';

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
          padding: const EdgeInsets.all(20.0),
          child: _generatedCode == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _courseNameController,
                      decoration: InputDecoration(
                        labelText: l.courseNameLabel,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton.icon(
                            icon: const Icon(Icons.add),
                            label: Text(l.createCourseAction),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: _createCourse,
                          ),
                  ],
                )
              : Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 80,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l.courseCreatedSuccess,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(l.shareCodeHint),
                    const SizedBox(height: 10),
                    SelectableText(
                      _generatedCode!,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(l.backToHome),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
