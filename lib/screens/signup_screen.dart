// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
// import 'package:training_app/services/sso_service.dart'; // ❌ REMOVED - No more SSO

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
  bool _obscure = true;
  final _formKey = GlobalKey<FormState>();

  void _showSnackBar(String message, {bool isError = true}) {
    if (!mounted) return;
    AppSnackBar.show(context, message, isError: isError);
  }

  Future<void> _createAccount() async {
    if (!_formKey.currentState!.validate()) return;
    final l = context.l; // cache localization early
    if (_selectedRole == null) {
      _showSnackBar(l.selectRoleError);
      return;
    }

    if (mounted) {
      setState(() => _isLoading = true);
    }

    try {
      await ref
          .read(authRepositoryProvider)
          .signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            name: _nameController.text.trim(),
            role: _selectedRole == UserRole.trainer ? 'trainer' : 'trainee',
          );
      if (!mounted) return; // user may have left screen
      
      // Show success message
      _showSnackBar(l.signupSuccessCheckEmail, isError: false);
      
      // Wait a moment for the message to be visible, then navigate
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;
      
      // Pop back to login/auth wrapper - Firebase authState will trigger navigation to EmailVerificationScreen
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      // معالجة أخطاء Firebase بشكل محدد
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = l.authErrorEmailInUse;
          break;
        case 'invalid-email':
          errorMessage = l.authErrorInvalidEmail;
          break;
        case 'operation-not-allowed':
          errorMessage = l.authErrorOperationNotAllowed;
          break;
        case 'weak-password':
          errorMessage = l.authErrorWeakPassword;
          break;
        case 'network-request-failed':
          errorMessage = l.authErrorNetworkFailed;
          break;
        default:
          errorMessage = l.authErrorDefault;
      }
      _showSnackBar(errorMessage);
    } on Exception catch (e) {
      _showSnackBar(l.signupFailed(e.toString()));
    } catch (e) {
      _showSnackBar(l.unexpectedError(e.toString()));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // ❌ REMOVED: _signUpWithGoogle() and _signUpWithApple() methods - No more SSO

  @override
  void dispose() {
    _nameController.dispose(); // --- لا تنسَ عمل dispose ---
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Scaffold(
      appBar: AppBar(title: Text(l.signupTitle)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // --- 3. إضافة حقل إدخال الاسم في الواجهة ---
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: l.fullNameLabel,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? l.fieldRequired : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: l.emailLabel,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return l.fieldRequired;
                    if (!v.contains('@')) return l.invalidEmail;
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: l.passwordLabel,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => _obscure = !_obscure),
                      icon: Icon(
                        _obscure ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: (v) =>
                      (v == null || v.length < 6) ? l.passwordTooShort : null,
                ),
                const SizedBox(height: 20),
                Text(
                  l.chooseRole,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<UserRole>(
                        title: Text(l.roleTrainer),
                        value: UserRole.trainer,
                        groupValue: _selectedRole,
                        onChanged: (value) =>
                            setState(() => _selectedRole = value),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<UserRole>(
                        title: Text(l.roleTrainee),
                        value: UserRole.trainee,
                        groupValue: _selectedRole,
                        onChanged: (value) =>
                            setState(() => _selectedRole = value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _isLoading ? null : _createAccount,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _isLoading
                        ? const SizedBox(
                            key: ValueKey('prog'),
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(key: const ValueKey('text'), l.signupAction),
                  ),
                ),
                const SizedBox(height: 12),
                // ❌ REMOVED: SSO buttons (Google Sign-In, Apple Sign-In) - No more SSO
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.login, size: 18),
                      const SizedBox(width: 6),
                      Text(l.haveAccountLogin),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
