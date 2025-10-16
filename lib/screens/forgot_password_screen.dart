import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  void _showSnackBar(String message, {bool isError = true}) {
    if (!mounted) return;
    AppSnackBar.show(context, message, isError: isError);
  }

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (mounted) {
      setState(() => _isLoading = true);
    }
    
    final email = _emailController.text.trim();
    
    try {
      await ref.read(authRepositoryProvider).resetPassword(email);
      
      if (!mounted) return;
      
      setState(() {
        _emailSent = true;
        _isLoading = false;
      });
      
      _showSnackBar(
        'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك',
        isError: false,
      );
      
      // Wait 2 seconds then navigate back
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.of(context).pop();
      
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      final l = context.l;
      // معالجة أخطاء Firebase بشكل محدد
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = l.authErrorUserNotFound;
          break;
        case 'invalid-email':
          errorMessage = l.authErrorInvalidEmail;
          break;
        case 'too-many-requests':
          errorMessage = l.authErrorTooManyRequests;
          break;
        case 'network-request-failed':
          errorMessage = l.authErrorNetworkFailed;
          break;
        default:
          errorMessage = l.passwordResetFailed;
      }
      _showSnackBar(errorMessage);
    } on Exception catch (e) {
      if (!mounted) return;
      final l = context.l;
      _showSnackBar('${l.passwordResetFailed}: ${e.toString()}');
    } catch (e) {
      if (!mounted) return;
      final l = context.l;
      _showSnackBar(l.authErrorDefault);
    } finally {
      if (mounted && !_emailSent) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = context.l;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l.forgotPasswordTitle),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Icon
                Icon(
                  Icons.lock_reset,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 24),
                
                // Title
                Text(
                  l.forgotPasswordTitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Description
                Text(
                  l.forgotPasswordDescription,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),
                
                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  enabled: !_emailSent,
                  decoration: InputDecoration(
                    labelText: l.emailLabel,
                    hintText: 'example@email.com',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return l.fieldRequired;
                    }
                    if (!v.contains('@')) {
                      return l.invalidEmail;
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _sendResetEmail(),
                ),
                const SizedBox(height: 24),
                
                // Send Button
                FilledButton.icon(
                  onPressed: (_isLoading || _emailSent) ? null : _sendResetEmail,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _isLoading
                        ? const SizedBox(
                            key: ValueKey('prog'),
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Icon(
                            key: const ValueKey('icon'),
                            _emailSent ? Icons.check_circle : Icons.send,
                          ),
                  ),
                  label: Text(
                    _emailSent 
                        ? l.emailSent
                        : l.sendResetEmail,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Back to Login Button
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back, size: 18),
                      const SizedBox(width: 6),
                      Text(l.backToLogin),
                    ],
                  ),
                ),
                
                // Info Box
                if (!_emailSent) ...[
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.blue.shade700,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            l.forgotPasswordNote,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
