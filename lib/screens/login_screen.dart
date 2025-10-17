import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
// import 'package:training_app/services/sso_service.dart'; // ❌ REMOVED - No more SSO
import 'signup_screen.dart'; // لاستيراد شاشة إنشاء الحساب
import 'forgot_password_screen.dart'; // شاشة نسيت كلمة المرور
import 'package:training_app/core/design/tokens.dart';

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
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: DesignTokens.background(context),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth > 600 ? 100 : 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  
                  // Logo/Brand Name
                  Text(
                    'Training App',
                    style: DesignTokens.h1(context).copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Tagline
                  Text(
                    l.loginWelcomeBack,
                    textAlign: TextAlign.center,
                    style: DesignTokens.h6(context).copyWith(
                      color: DesignTokens.textSecondary(context),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Login Form Card
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    decoration: BoxDecoration(
                      color: DesignTokens.surface(context),
                      borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                      boxShadow: DesignTokens.shadowMd(context),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: DesignTokens.body1(context),
                            decoration: InputDecoration(
                              hintText: l.emailLabel,
                              hintStyle: DesignTokens.body1(context).copyWith(
                                color: DesignTokens.textSecondary(context),
                              ),
                              filled: true,
                              fillColor: DesignTokens.fillColor(context),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                                borderSide: BorderSide(color: DesignTokens.borderColor(context)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                                borderSide: BorderSide(color: DesignTokens.borderColor(context)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                                borderSide: BorderSide(
                                  color: theme.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: DesignTokens.spacingLg,
                                vertical: DesignTokens.spacingLg,
                              ),
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return l.fieldRequired;
                              if (!v.contains('@')) return l.invalidEmail;
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          
                          SizedBox(height: DesignTokens.spacingMd),
                          
                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscure,
                            style: DesignTokens.body1(context),
                            decoration: InputDecoration(
                              hintText: l.passwordLabel,
                              hintStyle: DesignTokens.body1(context).copyWith(
                                color: DesignTokens.textSecondary(context),
                              ),
                              filled: true,
                              fillColor: DesignTokens.fillColor(context),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                                borderSide: BorderSide(color: DesignTokens.borderColor(context)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                                borderSide: BorderSide(color: DesignTokens.borderColor(context)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                                borderSide: BorderSide(
                                  color: theme.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: DesignTokens.spacingLg,
                                vertical: DesignTokens.spacingLg,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => setState(() => _obscure = !_obscure),
                                icon: Icon(
                                  _obscure ? Icons.visibility_off : Icons.visibility,
                                  color: DesignTokens.textSecondary(context),
                                ),
                              ),
                            ),
                            validator: (v) =>
                                (v == null || v.length < 6) ? l.passwordTooShort : null,
                            onFieldSubmitted: (_) => _signIn(),
                          ),
                          
                          SizedBox(height: DesignTokens.spacingXl),
                          
                          // Login Button
                          SizedBox(
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _signIn,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: DesignTokens.textOnColor(context),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                                ),
                                elevation: 0,
                                textStyle: DesignTokens.button(context),
                              ),
                              child: AnimatedSwitcher(
                                duration: DesignTokens.durationMedium,
                                child: _isLoading
                                    ? SizedBox(
                                        key: const ValueKey('prog'),
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          color: DesignTokens.textOnColor(context),
                                        ),
                                      )
                                    : Text(
                                        key: const ValueKey('text'),
                                        l.loginAction,
                                      ),
                              ),
                            ),
                          ),
                          
                          SizedBox(height: DesignTokens.spacingLg),
                          
                          // Forgot Password Link
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: theme.colorScheme.primary,
                              ),
                              child: Text(
                                l.forgotPasswordNavigate,
                                style: DesignTokens.body1(context).copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: DesignTokens.spacingXl),
                  
                  // Create Account Button
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: SizedBox(
                      height: 52,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: DesignTokens.surface(context),
                          foregroundColor: theme.colorScheme.primary,
                          side: BorderSide(color: theme.colorScheme.primary, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                          ),
                          textStyle: DesignTokens.button(context),
                        ),
                        child: Text(l.signupNavigate),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
