import 'package:flutter/material.dart';

/// Helper widget to show network status
class NetworkStatusBanner extends StatelessWidget {
  final bool isOnline;
  
  const NetworkStatusBanner({
    super.key,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    if (isOnline) return const SizedBox.shrink();
    
    return MaterialBanner(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      content: Row(
        children: [
          Icon(
            Icons.cloud_off,
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'لا يوجد اتصال بالإنترنت - العمل في وضع عدم الاتصال',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
      actions: const [SizedBox.shrink()],
    );
  }
}

/// Helper to check Firebase availability
class FirebaseErrorHandler {
  static bool isUnavailableError(dynamic error) {
    final errorStr = error.toString().toLowerCase();
    return errorStr.contains('unavailable') || 
           errorStr.contains('timeout') ||
           errorStr.contains('network');
  }
  
  static String getUserFriendlyMessage(dynamic error) {
    if (isUnavailableError(error)) {
      return 'لا يوجد اتصال بالإنترنت. تحقق من الاتصال وحاول مرة أخرى.';
    }
    
    final errorStr = error.toString();
    if (errorStr.contains('permission-denied')) {
      return 'ليس لديك صلاحية للوصول لهذه البيانات';
    }
    
    if (errorStr.contains('not-found')) {
      return 'البيانات المطلوبة غير موجودة';
    }
    
    return 'حدث خطأ غير متوقع. حاول مرة أخرى.';
  }
  
  static Widget buildErrorWidget(
    BuildContext context,
    dynamic error, {
    VoidCallback? onRetry,
  }) {
    final isOffline = isUnavailableError(error);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isOffline ? Icons.cloud_off : Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              getUserFriendlyMessage(error),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('إعادة المحاولة'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
