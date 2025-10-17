import 'package:flutter/material.dart';
import 'package:training_app/core/design/tokens.dart';

/// A reusable empty state widget that follows the app's Design System.
/// 
/// Features:
/// - Icon or custom image
/// - Title and description
/// - Optional action button
/// - Customizable layout
/// - Adaptive colors (Light/Dark Mode)
/// 
/// Example:
/// ```dart
/// AppEmptyState(
///   icon: Icons.inbox,
///   title: 'لا توجد رسائل',
///   description: 'لم تتلقَ أي رسائل بعد',
///   actionLabel: 'إرسال رسالة',
///   onAction: () => sendMessage(),
/// )
/// ```
class AppEmptyState extends StatelessWidget {
  /// Icon to display (ignored if customImage is provided)
  final IconData? icon;
  
  /// Custom image widget (takes priority over icon)
  final Widget? customImage;
  
  /// Title text
  final String title;
  
  /// Description text (optional)
  final String? description;
  
  /// Action button label (optional)
  final String? actionLabel;
  
  /// Action button callback
  final VoidCallback? onAction;
  
  /// Icon size
  final double iconSize;
  
  /// Icon color
  final Color? iconColor;
  
  /// Custom padding
  final EdgeInsetsGeometry? padding;

  const AppEmptyState({
    super.key,
    this.icon,
    this.customImage,
    required this.title,
    this.description,
    this.actionLabel,
    this.onAction,
    this.iconSize = 80,
    this.iconColor,
    this.padding,
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
            // Icon or Custom Image
            if (customImage != null)
              customImage!
            else if (icon != null)
              Icon(
                icon,
                size: iconSize,
                color: iconColor ?? DesignTokens.textSecondary(context),
              ),
            
            SizedBox(height: DesignTokens.spacingLg),
            
            // Title
            Text(
              title,
              style: DesignTokens.h5(context),
              textAlign: TextAlign.center,
            ),
            
            // Description
            if (description != null) ...[
              SizedBox(height: DesignTokens.spacingSm),
              Text(
                description!,
                style: DesignTokens.body1(context).copyWith(
                  color: DesignTokens.textSecondary(context),
                ),
                textAlign: TextAlign.center,
              ),
            ],
            
            // Action Button
            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: DesignTokens.spacingXl),
              ElevatedButton(
                onPressed: onAction,
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
                child: Text(
                  actionLabel!,
                  style: DesignTokens.button(context),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
