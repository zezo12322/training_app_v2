import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/providers/course_providers.dart';
import 'package:training_app/core/logging.dart';

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
      ),
    );
  }

  Future<void> _joinCourse() async {
    final courseCode = _codeController.text.trim().toUpperCase();
    if (courseCode.isEmpty) {
      _showSnackBar('يرجى إدخال كود الكورس');
      return;
    }
    setState(() { _isLoading = true; });

    try {
      final authUser = ref.read(authStateProvider).value;
      if (authUser == null) throw Exception('المستخدم غير مسجل دخوله');

      final result = await ref.read(joinCourseProvider(courseCode).future);
      result.when(
        success: (_) {
          _showSnackBar('تم الانضمام إلى الكورس بنجاح!', isError: false);
          if (mounted) Navigator.of(context).pop();
        },
        failure: (f) {
          logger.w('Join course failed: ${f.message}');
          _showSnackBar(f.message);
        },
      );
    } catch (e) {
      _showSnackBar('حدث خطأ ما: $e');
    } finally {
      if (mounted) setState(() { _isLoading = false; });
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الانضمام إلى كورس')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _codeController,
                // لجعل الحروف كبيرة تلقائياً
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'أدخل كود الكورس',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('انضمام'),
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