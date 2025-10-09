import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/providers/course_providers.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:training_app/core/logging.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';

class JoinCourseScreen extends ConsumerStatefulWidget {
  const JoinCourseScreen({super.key});

  @override
  @override
  ConsumerState<JoinCourseScreen> createState() => _JoinCourseScreenState();
}

class _JoinCourseScreenState extends ConsumerState<JoinCourseScreen> {
  final _codeController = TextEditingController();
  bool _isLoading = false;

  void _showSnackBar(String message, {bool isError = true}) {
    if (!mounted) return;
    AppSnackBar.show(context, message, isError: isError);
  }

  Future<void> _joinCourse() async {
    final l = context.l; // cache localization
    final courseCode = _codeController.text.trim().toUpperCase();
    if (courseCode.isEmpty) {
      _showSnackBar(l.enterCourseCodeError);
      return;
    }
    if (mounted) {
      setState(() => _isLoading = true);
    }

    try {
      final authUser = ref.read(authStateProvider).value;
      if (authUser == null) throw Exception(l.userNotLoggedIn);

      final result = await ref.read(joinCourseProvider(courseCode).future);
      result.when(
        success: (_) {
          if (!mounted) return;
          _showSnackBar(l.joinCourseSuccess, isError: false);
          try {
            ref.invalidate(traineeCoursesProvider);
            requestTraineeCoursesLoad(ref);
          } catch (_) {}
          if (mounted) Navigator.of(context).pop();
        },
        failure: (f) {
          logger.w('Join course failed: ${f.message}');
          _showSnackBar(f.message);
        },
      );
    } catch (e) {
      _showSnackBar(l.unexpectedError(e.toString()));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Scaffold(
      appBar: AppBar(title: Text(l.joinCourseTitle)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _codeController,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: l.enterCourseCode,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      icon: const Icon(Icons.login),
                      label: Text(l.joinCourseAction),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: _joinCourse,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
