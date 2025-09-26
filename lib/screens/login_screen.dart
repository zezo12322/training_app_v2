import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_screen.dart'; // لاستيراد شاشة إنشاء الحساب
import '../widgets/common/index.dart';
import '../utils/ui_helpers.dart';
import '../utils/form_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      UIHelpers.showErrorSnackBar(context, 'يرجى ملء جميع الحقول');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // StreamBuilder في main.dart سيتولى الباقي
    } on FirebaseAuthException {
      UIHelpers.showErrorSnackBar(context, 'البريد الإلكتروني أو كلمة المرور غير صحيحة.');
    } catch (e) {
      UIHelpers.showErrorSnackBar(context, 'حدث خطأ غير متوقع: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل الدخول')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(UIHelpers.largePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('مرحباً بعودتك!', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: UIHelpers.largeSpacing),
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
              const SizedBox(height: UIHelpers.largeSpacing),
              CustomButton(
                onPressed: _signIn,
                text: 'تسجيل الدخول',
                isLoading: _isLoading,
              ),
              const SizedBox(height: UIHelpers.defaultSpacing),
              TextButton(
                onPressed: () {
                  // الانتقال إلى شاشة إنشاء حساب
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SignupScreen()),
                  );
                },
                child: const Text('ليس لديك حساب؟ إنشاء حساب جديد'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}