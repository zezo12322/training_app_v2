// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/auth_provider.dart';

enum UserRole { trainer, trainee }

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  // --- 1. إضافة Controller جديد للاسم ---
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole? _selectedRole;
  bool _isLoading = false;

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  Future<void> _createAccount() async {
    // التحقق من أن جميع الحقول ممتلئة
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      _showSnackBar('يرجى ملء جميع الحقول');
      return;
    }
    if (_selectedRole == null) {
      _showSnackBar('يرجى تحديد دورك (مدرب أو متدرب)');
      return;
    }

    setState(() { _isLoading = true; });

    try {
      await ref.read(authRepositoryProvider).signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            name: _nameController.text.trim(),
            role: _selectedRole == UserRole.trainer ? 'trainer' : 'trainee',
          );
    } on Exception catch (e) {
      _showSnackBar('فشل إنشاء الحساب: ${e.toString()}');
    } catch (e) {
      _showSnackBar('حدث خطأ غير متوقع: $e');
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // --- 3. إضافة حقل إدخال الاسم في الواجهة ---
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'الاسم الكامل',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 12),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'البريد الإلكتروني', border: OutlineInputBorder(), prefixIcon: Icon(Icons.email)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'كلمة المرور', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                onPressed: _createAccount,
                child: const Text('إنشاء الحساب'),
              ),
              const SizedBox(height: 12),
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