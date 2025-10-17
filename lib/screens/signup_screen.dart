// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
import 'package:training_app/core/design/tokens.dart';
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
                    style: DesignTokens.h2(context).copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Signup Card
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    margin: EdgeInsets.only(top: DesignTokens.spacingXl),
                    decoration: BoxDecoration(
                      color: DesignTokens.surface(context),
                      borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                      boxShadow: DesignTokens.shadowMd(context),
                    ),
                    padding: EdgeInsets.all(DesignTokens.spacingXl),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Title
                          Text(
                            l.signupTitle,
                            textAlign: TextAlign.center,
                            style: DesignTokens.h4(context),
                          ),
                          
                          SizedBox(height: DesignTokens.spacingSm),
                          
                          Text(
                            "It's quick and easy.",
                            textAlign: TextAlign.center,
                            style: DesignTokens.body1(context).copyWith(
                              color: DesignTokens.textSecondary(context),
                            ),
                          ),
                          
                          Divider(height: DesignTokens.spacingXxl),
                          
                          // Name Field
                          TextFormField(
                            controller: _nameController,
                            textCapitalization: TextCapitalization.words,
                            style: DesignTokens.body1(context),
                            decoration: InputDecoration(
                              hintText: l.fullNameLabel,
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
                            validator: (v) =>
                                (v == null || v.trim().isEmpty) ? l.fieldRequired : null,
                            textInputAction: TextInputAction.next,
                          ),
                          
                          SizedBox(height: DesignTokens.spacingMd),
                          
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
                          ),
                          
                          SizedBox(height: DesignTokens.spacingLg),
                          
                          // Role Selection
                          Text(
                            l.chooseRole,
                            style: DesignTokens.body1(context).copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          
                          SizedBox(height: DesignTokens.spacingSm),
                          
                          Row(
                            children: [
                              Expanded(
                                child: Material(
                                  color: _selectedRole == UserRole.trainer
                                      ? theme.colorScheme.primary.withOpacity(0.1)
                                      : DesignTokens.fillColor(context),
                                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                                  child: InkWell(
                                    onTap: () => setState(() => _selectedRole = UserRole.trainer),
                                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: DesignTokens.spacingMd,
                                        horizontal: DesignTokens.spacingMd,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                                        border: Border.all(
                                          color: _selectedRole == UserRole.trainer
                                              ? theme.colorScheme.primary
                                              : DesignTokens.borderColor(context),
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Radio<UserRole>(
                                            value: UserRole.trainer,
                                            groupValue: _selectedRole,
                                            onChanged: (value) =>
                                                setState(() => _selectedRole = value),
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          ),
                                          const SizedBox(width: 4),
                                          Flexible(
                                            child: Text(
                                              l.roleTrainer,
                                              style: DesignTokens.body1(context).copyWith(
                                                fontWeight: _selectedRole == UserRole.trainer
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: DesignTokens.spacingMd),
                              Expanded(
                                child: Material(
                                  color: _selectedRole == UserRole.trainee
                                      ? theme.colorScheme.primary.withOpacity(0.1)
                                      : DesignTokens.fillColor(context),
                                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                                  child: InkWell(
                                    onTap: () => setState(() => _selectedRole = UserRole.trainee),
                                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: DesignTokens.spacingMd,
                                        horizontal: DesignTokens.spacingMd,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                                        border: Border.all(
                                          color: _selectedRole == UserRole.trainee
                                              ? theme.colorScheme.primary
                                              : DesignTokens.borderColor(context),
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Radio<UserRole>(
                                            value: UserRole.trainee,
                                            groupValue: _selectedRole,
                                            onChanged: (value) =>
                                                setState(() => _selectedRole = value),
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          ),
                                          const SizedBox(width: 4),
                                          Flexible(
                                            child: Text(
                                              l.roleTrainee,
                                              style: DesignTokens.body1(context).copyWith(
                                                fontWeight: _selectedRole == UserRole.trainee
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: DesignTokens.spacingXl),
                          
                          // Sign Up Button
                          SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _createAccount,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: DesignTokens.success,
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
                                        l.signupAction,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: DesignTokens.spacingXl),
                  
                  // Already have account link
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: theme.colorScheme.primary,
                      backgroundColor: DesignTokens.surface(context),
                      padding: EdgeInsets.symmetric(
                        horizontal: DesignTokens.spacingXl,
                        vertical: DesignTokens.spacingMd,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                      ),
                    ),
                    child: Text(
                      l.haveAccountLogin,
                      style: DesignTokens.body1(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
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
