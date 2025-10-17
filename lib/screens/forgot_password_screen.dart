import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
import 'package:training_app/core/design/tokens.dart';

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
        context.l.forgotPasswordSuccess,
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
      backgroundColor: DesignTokens.background(context),
      appBar: AppBar(
        backgroundColor: DesignTokens.surface(context),
        elevation: 0,
        title: Text(
          l.forgotPasswordTitle,
          style: DesignTokens.h6(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(DesignTokens.spacingLg),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            padding: EdgeInsets.all(DesignTokens.spacingXl),
            decoration: BoxDecoration(
              color: DesignTokens.surface(context),
              borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
              boxShadow: DesignTokens.shadowMd(context),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Icon
                  Icon(
                    Icons.lock_reset,
                    size: 80,
                    color: theme.colorScheme.primary,
                  ),
                  SizedBox(height: DesignTokens.spacingLg),
                  
                  // Title
                  Text(
                    l.forgotPasswordTitle,
                    textAlign: TextAlign.center,
                    style: DesignTokens.h4(context),
                  ),
                  SizedBox(height: DesignTokens.spacingMd),
                  
                  // Description
                  Text(
                    l.forgotPasswordDescription,
                    textAlign: TextAlign.center,
                    style: DesignTokens.body1(context).copyWith(
                      color: DesignTokens.textSecondary(context),
                    ),
                  ),
                  SizedBox(height: DesignTokens.spacingXl),
                
                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    enabled: !_emailSent,
                    style: DesignTokens.body1(context),
                    decoration: InputDecoration(
                      labelText: l.emailLabel,
                      labelStyle: DesignTokens.body1(context),
                      hintText: 'example@email.com',
                      hintStyle: DesignTokens.body1(context).copyWith(
                        color: DesignTokens.textSecondary(context),
                      ),
                      filled: true,
                      fillColor: DesignTokens.fillColor(context),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        borderSide: BorderSide(
                          color: DesignTokens.borderColor(context),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        borderSide: BorderSide(
                          color: DesignTokens.borderColor(context),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.email),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: DesignTokens.spacingLg,
                        vertical: DesignTokens.spacingLg,
                      ),
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
                  SizedBox(height: DesignTokens.spacingLg),
                
                  // Send Button
                  FilledButton.icon(
                    onPressed: (_isLoading || _emailSent) ? null : _sendResetEmail,
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: DesignTokens.textOnColor(context),
                      padding: EdgeInsets.symmetric(
                        vertical: DesignTokens.spacingLg,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                      ),
                    ),
                    icon: AnimatedSwitcher(
                      duration: DesignTokens.durationMedium,
                      child: _isLoading
                          ? SizedBox(
                              key: const ValueKey('prog'),
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: DesignTokens.textOnColor(context),
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
                      style: DesignTokens.button(context),
                    ),
                  ),
                  SizedBox(height: DesignTokens.spacingMd),
                
                  // Back to Login Button
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: DesignTokens.textSecondary(context),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_back, size: 18),
                        SizedBox(width: DesignTokens.spacingXs),
                        Text(
                          l.backToLogin,
                          style: DesignTokens.body1(context),
                        ),
                      ],
                    ),
                  ),
                  
                  // Info Box
                  if (!_emailSent) ...[
                    SizedBox(height: DesignTokens.spacingLg),
                    Container(
                      padding: EdgeInsets.all(DesignTokens.spacingMd),
                      decoration: BoxDecoration(
                        color: DesignTokens.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        border: Border.all(
                          color: DesignTokens.info.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: DesignTokens.info,
                            size: 24,
                          ),
                          SizedBox(width: DesignTokens.spacingMd),
                          Expanded(
                            child: Text(
                              l.forgotPasswordNote,
                              style: DesignTokens.caption(context).copyWith(
                                color: DesignTokens.textPrimary(context),
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
      ),
    );
  }
}
