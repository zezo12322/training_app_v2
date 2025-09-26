import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'add_question_screen.dart'; // سنقوم بإنشاء هذه الشاشة لاحقًا
import '../widgets/common/index.dart';
import '../utils/ui_helpers.dart';
import '../utils/form_validators.dart';

class CreateQuizScreen extends StatefulWidget {
  final String courseId;

  const CreateQuizScreen({super.key, required this.courseId});

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _createQuizAndProceed() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() { _isLoading = true; });

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      // التعامل مع حالة عدم وجود مستخدم
      setState(() { _isLoading = false; });
      return;
    }

    try {
      // 1. إضافة مستند الاختبار الجديد إلى Firestore
      final quizDocRef = await FirebaseFirestore.instance.collection('quizzes').add({
        'title': _titleController.text.trim(),
        'courseId': widget.courseId,
        'trainerId': currentUser.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 2. بعد الإنشاء بنجاح، انتقل إلى شاشة إضافة الأسئلة
      if (mounted) {
         Navigator.of(context).pushReplacement(
           MaterialPageRoute(
             builder: (context) => AddQuestionScreen(quizId: quizDocRef.id),
           ),
         );
        // سنقوم بتفعيل هذا الكود بعد إنشاء الشاشة التالية
        UIHelpers.showSuccessSnackBar(
            context, 'تم إنشاء الاختبار بنجاح! الخطوة التالية هي إضافة الأسئلة.'
        );
        Navigator.of(context).pop();
      }

    } catch (e) {
      if(mounted) {
        UIHelpers.showErrorSnackBar(context, 'حدث خطأ: $e');
      }
    } finally {
      if(mounted) setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء اختبار جديد'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(UIHelpers.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _titleController,
                labelText: 'عنوان الاختبار',
                hintText: 'مثال: اختبار أساسيات Flutter',
                validator: FormValidators.required,
              ),
              const SizedBox(height: UIHelpers.largeSpacing),
              CustomButton(
                onPressed: _createQuizAndProceed,
                text: 'التالي: إضافة الأسئلة',
                icon: Icons.arrow_forward,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}