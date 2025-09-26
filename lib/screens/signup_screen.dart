import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/common/index.dart';
import '../utils/ui_helpers.dart';

enum UserRole { trainer, trainee }

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // --- 1. إضافة Controller جديد للاسم ---
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole? _selectedRole;
  bool _isLoading = false;

  Future<void> _createAccount() async {
    // التحقق من أن جميع الحقول ممتلئة
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      UIHelpers.showErrorSnackBar(context, 'يرجى ملء جميع الحقول');
      return;
    }
    if (_selectedRole == null) {
      UIHelpers.showErrorSnackBar(context, 'يرجى تحديد دورك (مدرب أو متدرب)');
      return;
    }

    setState(() { _isLoading = true; });

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        // --- 2. إضافة حقل الاسم عند حفظ البيانات في Firestore ---
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'name': _nameController.text.trim(), // <-- السطر الجديد هنا
          'email': _emailController.text.trim(),
          'role': _selectedRole == UserRole.trainer ? 'trainer' : 'trainee',
          'createdAt': Timestamp.now(),
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') { 
        UIHelpers.showErrorSnackBar(context, 'كلمة المرور ضعيفة جدًا.'); 
      } else if (e.code == 'email-already-in-use') { 
        UIHelpers.showErrorSnackBar(context, 'هذا البريد الإلكتروني مستخدم بالفعل.'); 
      } else { 
        UIHelpers.showErrorSnackBar(context, 'حدث خطأ: ${e.message}'); 
      }
    } catch (e) {
      UIHelpers.showErrorSnackBar(context, 'حدث خطأ غير متوقع: $e');
    } finally {
      if (mounted) { setState(() { _isLoading = false; }); }
    }
  }

  @override
  void dispose() {
    _nameController.dispose(); // --- لا تنسَ عمل dispose ---
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء حساب جديد')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(UIHelpers.largePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // --- 3. إضافة حقل إدخال الاسم في الواجهة ---
              CustomTextField(
                controller: _nameController,
                labelText: 'الاسم الكامل',
                prefixIcon: Icons.person,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: UIHelpers.defaultSpacing),

              CustomTextField(
                controller: _emailController,
                labelText: 'البريد الإلكتروني',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: UIHelpers.defaultSpacing),
              CustomTextField(
                controller: _passwordController,
                labelText: 'كلمة المرور',
                obscureText: true,
                prefixIcon: Icons.lock,
              ),
              const SizedBox(height: UIHelpers.largePadding),
              const Text('اختر دورك:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<UserRole>(
                      title: const Text('مدرب'), value: UserRole.trainer, groupValue: _selectedRole,
                      onChanged: (value) => setState(() => _selectedRole = value),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<UserRole>(
                      title: const Text('متدرب'), value: UserRole.trainee, groupValue: _selectedRole,
                      onChanged: (value) => setState(() => _selectedRole = value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: UIHelpers.largePadding),
              CustomButton(
                onPressed: _createAccount,
                text: 'إنشاء الحساب',
                isLoading: _isLoading,
              ),
              const SizedBox(height: UIHelpers.defaultSpacing),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('لديك حساب بالفعل؟ تسجيل الدخول'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}