import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/auth_provider.dart';
import '../core/ui/snackbar_helper.dart';
import '../core/l10n_ext.dart';

/// شاشة التحقق من البريد الإلكتروني
class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  ConsumerState<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends ConsumerState<EmailVerificationScreen> {
  bool _isChecking = false;
  bool _isResending = false;

  Future<void> _checkVerification() async {
    setState(() => _isChecking = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Reload user to get latest email verification status
      await user.reload();
      final updatedUser = FirebaseAuth.instance.currentUser;

      if (!mounted) return;

      if (updatedUser?.emailVerified == true) {
        // تحديث Firestore
        await ref.read(authRepositoryProvider).updateEmailVerified(user.uid);
        
        // Success - AuthWrapper will handle navigation
        if (!mounted) return;
        AppSnackBar.show(
          context,
          context.l.emailVerificationSuccess,
          isError: false,
        );
        
        // Invalidate auth state to trigger rebuild
        ref.invalidate(authStateProvider);
      } else {
        if (!mounted) return;
        AppSnackBar.show(
          context,
          context.l.emailVerificationPending,
        );
      }
    } catch (e) {
      if (!mounted) return;
      AppSnackBar.show(context, context.l.emailVerificationError(e.toString()));
    } finally {
      if (mounted) setState(() => _isChecking = false);
    }
  }

  Future<void> _resendEmail() async {
    setState(() => _isResending = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        
        if (!mounted) return;
        AppSnackBar.show(
          context,
          context.l.emailVerificationLinkSent(user.email ?? ''),
          isError: false,
        );
      }
    } catch (e) {
      if (!mounted) return;
      AppSnackBar.show(context, context.l.emailVerificationSendError(e.toString()));
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).value;
    final l = context.l;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l.emailVerificationTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: l.emailVerificationLogout,
            onPressed: () async {
              await ref.read(authRepositoryProvider).signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mark_email_unread_outlined,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                l.emailVerificationTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                l.emailVerificationSentTo,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  user?.email ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l.emailVerificationInstructions,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                l.emailVerificationSpamNote,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: _isChecking ? null : _checkVerification,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                icon: _isChecking
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.check_circle_outline),
                label: Text(_isChecking ? l.emailVerificationChecking : l.emailVerificationChecked),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: _isResending ? null : _resendEmail,
                icon: _isResending
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.email_outlined, size: 20),
                label: Text(_isResending ? l.emailVerificationResending : l.emailVerificationResend),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue.shade700),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l.emailVerificationWhy,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
