import 'package:flutter/material.dart';
import 'package:training_app/core/design/tokens.dart';

/// A reusable error state widget that follows the app's Design System.
/// 
/// Features:
/// - Error icon
/// - Title and error message
/// - Retry button
/// - Customizable layout
/// - Adaptive colors (Light/Dark Mode)
/// 
/// Example:
/// ```dart
/// AppErrorState(
///   title: 'حدث خطأ',
///   message: 'فشل في تحميل البيانات',
///   onRetry: () => loadData(),
/// )
/// ```
class AppErrorState extends StatelessWidget {
  /// Title text (defaults to 'حدث خطأ')
  final String? title;
  
  /// Error message
  final String message;
  
  /// Retry button callback
  final VoidCallback? onRetry;
  
  /// Retry button label (defaults to 'حاول مرة أخرى')
  final String? retryLabel;
  
  /// Custom icon (defaults to error_outline)
  final IconData? icon;
  
  /// Icon size
  final double iconSize;
  
  /// Custom padding
  final EdgeInsetsGeometry? padding;
  
  /// Whether to show icon
  final bool showIcon;

  const AppErrorState({
    super.key,
    this.title,
    required this.message,
    this.onRetry,
    this.retryLabel,
    this.icon,
    this.iconSize = 80,
    this.padding,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: padding ?? EdgeInsets.all(DesignTokens.spacingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error Icon
            if (showIcon)
              Icon(
                icon ?? Icons.error_outline,
                size: iconSize,
                color: DesignTokens.error,
              ),
            
            if (showIcon)
              SizedBox(height: DesignTokens.spacingLg),
            
            // Title
            Text(
              title ?? 'حدث خطأ',
              style: DesignTokens.h5(context),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: DesignTokens.spacingSm),
            
            // Error Message
            Text(
              message,
              style: DesignTokens.body1(context).copyWith(
                color: DesignTokens.textSecondary(context),
              ),
              textAlign: TextAlign.center,
            ),
            
            // Retry Button
            if (onRetry != null) ...[
              SizedBox(height: DesignTokens.spacingXl),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(
                  retryLabel ?? 'حاول مرة أخرى',
                  style: DesignTokens.button(context),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: DesignTokens.textOnColor(context),
                  padding: EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacingXl,
                    vertical: DesignTokens.spacingMd,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
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
