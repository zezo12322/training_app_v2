import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/common/index.dart';
import '../utils/ui_helpers.dart';
import '../utils/form_validators.dart';

class JoinCourseScreen extends StatefulWidget {
  const JoinCourseScreen({super.key});

  @override
  State<JoinCourseScreen> createState() => _JoinCourseScreenState();
}

class _JoinCourseScreenState extends State<JoinCourseScreen> {
  final _codeController = TextEditingController();
  bool _isLoading = false;

  Future<void> _joinCourse() async {
    final courseCode = _codeController.text.trim().toUpperCase();
    if (courseCode.isEmpty) {
      UIHelpers.showErrorSnackBar(context, 'يرجى إدخال كود الكورس');
      return;
    }
    setState(() { _isLoading = true; });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('المستخدم غير مسجل دخوله');

      // 1. البحث عن الكورس باستخدام الكود المدخل
      final querySnapshot = await FirebaseFirestore.instance
          .collection('courses')
          .where('courseCode', isEqualTo: courseCode)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // إذا لم يتم العثور على أي كورس بهذا الكود
        UIHelpers.showErrorSnackBar(context, 'الكود الذي أدخلته غير صحيح، يرجى التأكد منه.');
      } else {
        // إذا تم العثور على الكورس
        final courseDoc = querySnapshot.docs.first;

        // 2. تحديث مستند الكورس لإضافة المتدرب الحالي إلى قائمة المتدربين
        await FirebaseFirestore.instance.collection('courses').doc(courseDoc.id).update({
          // arrayUnion تتأكد من إضافة المستخدم مرة واحدة فقط
          'trainees': FieldValue.arrayUnion([user.uid])
        });

        UIHelpers.showSuccessSnackBar(context, 'تم الانضمام إلى الكورس بنجاح!');
        if (mounted) Navigator.of(context).pop(); // الرجوع للشاشة الرئيسية
      }
    } catch (e) {
      UIHelpers.showErrorSnackBar(context, 'حدث خطأ ما: $e');
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
          padding: const EdgeInsets.all(UIHelpers.largePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _codeController,
                labelText: 'أدخل كود الكورس',
                textCapitalization: TextCapitalization.characters,
                validator: FormValidators.required,
              ),
              const SizedBox(height: UIHelpers.largePadding),
              CustomButton(
                onPressed: _joinCourse,
                text: 'انضمام',
                icon: Icons.login,
                isLoading: _isLoading,
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