import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/app_constants.dart';
import '../utils/error_handler.dart';
import '../utils/validators.dart';

enum UserRole { trainer, trainee }

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole? _selectedRole;
  bool _isLoading = false;

  Future<void> _createAccount() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    if (_selectedRole == null) {
      context.showErrorSnackBar(AppConstants.selectRoleMessage);
      return;
    }

    setState(() { _isLoading = true; });

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      
      if (userCredential.user != null) {
        await FirebaseFirestore.instance
            .collection(AppConstants.usersCollection)
            .doc(userCredential.user!.uid)
            .set({
          AppConstants.uidField: userCredential.user!.uid,
          AppConstants.nameField: _nameController.text.trim(),
          AppConstants.emailField: _emailController.text.trim(),
          AppConstants.roleField: _selectedRole == UserRole.trainer 
              ? AppConstants.trainerRole 
              : AppConstants.traineeRole,
          AppConstants.createdAtField: Timestamp.now(),
        });
        
        if (mounted) {
          context.showSuccessSnackBar(AppConstants.accountCreatedMessage);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        context.showErrorSnackBar(ErrorHandler.getFirebaseAuthErrorMessage(e));
      }
    } catch (e) {
      ErrorHandler.logError('SignupScreen._createAccount', e);
      if (mounted) {
        context.showErrorSnackBar(ErrorHandler.getGenericErrorMessage(e));
      }
    } finally {
      if (mounted) { 
        setState(() { _isLoading = false; }); 
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
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
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'مرحباً بك!', 
                  textAlign: TextAlign.center, 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  validator: Validators.validateName,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'الاسم الكامل',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  validator: Validators.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  validator: Validators.validatePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
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