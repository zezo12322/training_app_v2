import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/app_constants.dart';

class ErrorHandler {
  static void showSnackBar(BuildContext context, String message, {bool isError = true}) {
    if (!context.mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppConstants.defaultPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        ),
      ),
    );
  }

  static String getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return AppConstants.weakPasswordMessage;
      case 'email-already-in-use':
        return AppConstants.emailAlreadyInUseMessage;
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return AppConstants.invalidEmailPasswordMessage;
      case 'invalid-email':
        return 'البريد الإلكتروني غير صحيح';
      case 'user-disabled':
        return 'تم تعطيل هذا الحساب';
      case 'too-many-requests':
        return 'تم حظر الوصول مؤقتاً بسبب كثرة المحاولات';
      case 'operation-not-allowed':
        return 'هذه العملية غير مسموحة';
      case 'network-request-failed':
        return AppConstants.networkErrorMessage;
      default:
        return '${AppConstants.authErrorMessage}: ${e.message}';
    }
  }

  static String getGenericErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      return getFirebaseAuthErrorMessage(error);
    }
    
    String errorString = error.toString().toLowerCase();
    
    if (errorString.contains('network') || errorString.contains('connection')) {
      return AppConstants.networkErrorMessage;
    }
    
    if (errorString.contains('permission') || errorString.contains('denied')) {
      return 'ليس لديك صلاحية للقيام بهذا الإجراء';
    }
    
    if (errorString.contains('not found')) {
      return 'لم يتم العثور على البيانات المطلوبة';
    }
    
    return '${AppConstants.genericErrorMessage}: $error';
  }

  static void logError(String context, dynamic error, [StackTrace? stackTrace]) {
    debugPrint('=== Error in $context ===');
    debugPrint('Error: $error');
    if (stackTrace != null) {
      debugPrint('Stack trace: $stackTrace');
    }
    debugPrint('========================');
  }

  static void showErrorDialog(BuildContext context, String title, String message) {
    if (!context.mounted) return;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('حسناً'),
            ),
          ],
        );
      },
    );
  }
}

// Extension to add error handling to BuildContext
extension ErrorHandlerExtension on BuildContext {
  void showErrorSnackBar(String message) {
    ErrorHandler.showSnackBar(this, message, isError: true);
  }
  
  void showSuccessSnackBar(String message) {
    ErrorHandler.showSnackBar(this, message, isError: false);
  }
  
  void showErrorDialog(String title, String message) {
    ErrorHandler.showErrorDialog(this, title, message);
  }
}
