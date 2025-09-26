import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? title;
  final String message;
  final VoidCallback? onRetry;
  final String? retryText;
  final IconData? icon;

  const CustomErrorWidget({
    super.key,
    this.title,
    required this.message,
    this.onRetry,
    this.retryText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.error_outline,
              color: Colors.red[400],
              size: 64,
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            if (title != null) ...[
              Text(
                title!,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.red[700],
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.defaultMargin),
            ],
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppConstants.defaultPadding),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(retryText ?? 'إعادة المحاولة'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class NetworkErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const NetworkErrorWidget({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      title: 'خطأ في الاتصال',
      message: AppConstants.networkErrorMessage,
      icon: Icons.wifi_off,
      onRetry: onRetry,
    );
  }
}

class NotFoundErrorWidget extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const NotFoundErrorWidget({
    super.key,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      title: 'لم يتم العثور على البيانات',
      message: message ?? 'لم يتم العثور على البيانات المطلوبة',
      icon: Icons.search_off,
      onRetry: onRetry,
    );
  }
}

class PermissionErrorWidget extends StatelessWidget {
  final String? message;

  const PermissionErrorWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      title: 'ليس لديك صلاحية',
      message: message ?? 'ليس لديك صلاحية للوصول إلى هذه البيانات',
      icon: Icons.lock_outline,
    );
  }
}
