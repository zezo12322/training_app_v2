import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import '../widgets/common/index.dart';
import '../utils/ui_helpers.dart';
import '../utils/form_validators.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final _courseNameController = TextEditingController();
  bool _isLoading = false;
  String? _generatedCode;

  String _generateUniqueCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();
    return List.generate(6, (index) => chars[rand.nextInt(chars.length)]).join();
  }

  Future<void> _createCourse() async {
    if (_courseNameController.text.trim().isEmpty) {
      UIHelpers.showErrorSnackBar(context, 'يرجى إدخال اسم للكورس');
      return;
    }
    setState(() { _isLoading = true; });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('المستخدم غير مسجل دخوله');
      }

      final courseCode = _generateUniqueCode();

      await FirebaseFirestore.instance.collection('courses').add({
        'name': _courseNameController.text.trim(),
        'trainerId': user.uid,
        'trainerEmail': user.email,
        'courseCode': courseCode,
        'createdAt': FieldValue.serverTimestamp(), // <<<--- تم تصحيح الخطأ هنا
        'trainees': [],
      });

      setState(() {
        _generatedCode = courseCode;
      });
      UIHelpers.showSuccessSnackBar(context, 'تم إنشاء الكورس بنجاح!');

    } catch (e) {
      UIHelpers.showErrorSnackBar(context, 'حدث خطأ أثناء إنشاء الكورس: $e');
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
          padding: const EdgeInsets.all(UIHelpers.largePadding),
          child: _generatedCode == null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _courseNameController,
                labelText: 'اسم الكورس',
                validator: FormValidators.required,
              ),
              const SizedBox(height: UIHelpers.largePadding),
              CustomButton(
                onPressed: _createCourse,
                text: 'إنشاء الكورس',
                icon: Icons.add,
                isLoading: _isLoading,
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