import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
// import 'package:training_app/services/sso_service.dart'; // ❌ REMOVED - No more SSO
import 'signup_screen.dart'; // لاستيراد شاشة إنشاء الحساب
import 'forgot_password_screen.dart'; // شاشة نسيت كلمة المرور

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscure = true;

  void _showSnackBar(String message, {bool isError = true}) {
    if (!mounted) return;
    AppSnackBar.show(context, message, isError: isError);
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    if (mounted) {
      setState(() => _isLoading = true);
    }
    final l = context.l; // cache before async gaps
    try {
      await ref
          .read(authRepositoryProvider)
          .signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
      // No explicit navigation here. AuthWrapper listens to auth state and
      // will rebuild to the correct destination automatically.
      if (!mounted) return; // context safety after await
    } on FirebaseAuthException catch (e) {
      // معالجة أخطاء Firebase بشكل محدد
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = l.authErrorUserNotFound;
          break;
        case 'wrong-password':
        case 'invalid-credential':
        case 'invalid-email':
          errorMessage = l.authErrorWrongPassword;
          break;
        case 'user-disabled':
          errorMessage = l.authErrorUserDisabled;
          break;
        case 'too-many-requests':
          errorMessage = l.authErrorTooManyRequests;
          break;
        case 'network-request-failed':
          errorMessage = l.authErrorNetworkFailed;
          break;
        default:
          errorMessage = l.authErrorDefault;
      }
      _showSnackBar(errorMessage);
    } on Exception catch (e) {
      _showSnackBar(l.loginFailed(e.toString()));
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

  // ❌ REMOVED: _signInWithGoogle() and _signInWithApple()
  // Using Email/Password authentication only

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Scaffold(
      appBar: AppBar(title: Text(l.loginTitle)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  l.loginWelcomeBack,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
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
                  textInputAction: TextInputAction.next,
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
                  onFieldSubmitted: (_) => _signIn(),
                ),
                const SizedBox(height: 8),
                // زر نسيت كلمة المرور
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(l.forgotPasswordNavigate),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _isLoading ? null : _signIn,
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
                        : Text(key: const ValueKey('text'), l.loginAction),
                  ),
                ),
                const SizedBox(height: 24),
                // ❌ REMOVED: Google & Apple Sign-In buttons
                // Using Email/Password authentication only
                TextButton(
                  onPressed: () {
                    // الانتقال إلى شاشة إنشاء حساب
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.person_add_outlined, size: 18),
                      const SizedBox(width: 6),
                      Text(l.signupNavigate),
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
