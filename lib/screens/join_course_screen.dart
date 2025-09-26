import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JoinCourseScreen extends StatefulWidget {
  const JoinCourseScreen({super.key});

  @override
  State<JoinCourseScreen> createState() => _JoinCourseScreenState();
}

class _JoinCourseScreenState extends State<JoinCourseScreen> {
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
        _showSnackBar('الكود الذي أدخلته غير صحيح، يرجى التأكد منه.');
      } else {
        // إذا تم العثور على الكورس
        final courseDoc = querySnapshot.docs.first;

        // 2. تحديث مستند الكورس لإضافة المتدرب الحالي إلى قائمة المتدربين
        await FirebaseFirestore.instance.collection('courses').doc(courseDoc.id).update({
          // arrayUnion تتأكد من إضافة المستخدم مرة واحدة فقط
          'trainees': FieldValue.arrayUnion([user.uid])
        });

        _showSnackBar('تم الانضمام إلى الكورس بنجاح!', isError: false);
        if (mounted) Navigator.of(context).pop(); // الرجوع للشاشة الرئيسية
      }
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