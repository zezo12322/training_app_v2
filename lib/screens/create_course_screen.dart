import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/course_providers.dart';
import 'package:training_app/providers/auth_provider.dart';

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
      ),
    );
  }

  Future<void> _createCourse() async {
    if (_courseNameController.text.trim().isEmpty) {
      _showSnackBar('يرجى إدخال اسم للكورس');
      return;
    }
    setState(() { _isLoading = true; });

    try {
      final result = await ref.read(courseRepositoryProvider).createCourse(
            name: _courseNameController.text.trim(),
            trainerId: ref.read(authStateProvider).value?.uid ?? '',
          );
      result.when(
        success: (course) {
          setState(() { _generatedCode = course.courseCode; });
          _showSnackBar('تم إنشاء الكورس بنجاح!', isError: false);
        },
        failure: (f) => _showSnackBar('فشل إنشاء الكورس: ${f.message}'),
      );

    } catch (e) {
      _showSnackBar('حدث خطأ أثناء إنشاء الكورس: $e');
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  @override
  void dispose() {
    _courseNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء كورس جديد')),
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
                decoration: const InputDecoration(
                  labelText: 'اسم الكورس',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('إنشاء الكورس'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: _createCourse,
              ),
            ],
          )
              : Column(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 16),
              const Text('تم إنشاء الكورس بنجاح!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text('شارك هذا الكود مع متدربيك للانضمام:'),
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
                child: const Text('العودة إلى الرئيسية'),
              )
            ],
          ),
        ),
      ),
    );
  }
}