import 'package:flutter/material.dart';
import 'package:training_app/core/design/tokens.dart';

/// Badge types
enum AppBadgeType {
  /// Default badge
  primary,
  
  /// Success badge (green)
  success,
  
  /// Error badge (red)
  error,
  
  /// Warning badge (orange)
  warning,
  
  /// Info badge (blue)
  info,
  
  /// Neutral badge (grey)
  neutral,
}

/// Badge sizes
enum AppBadgeSize {
  /// Small badge
  sm,
  
  /// Medium badge (default)
  md,
  
  /// Large badge
  lg,
}

/// A reusable badge widget that follows the app's Design System.
/// 
/// Features:
/// - Multiple types (primary, success, error, warning, info, neutral)
/// - Multiple sizes (sm, md, lg)
/// - Optional icon
/// - Optional close button
/// - Customizable colors
/// 
/// Example:
/// ```dart
/// AppBadge(
///   text: 'New',
///   type: AppBadgeType.success,
///   size: AppBadgeSize.md,
/// )
/// ```
class AppBadge extends StatelessWidget {
  /// Badge text
  final String text;
  
  /// Badge type
  final AppBadgeType type;
  
  /// Badge size
  final AppBadgeSize size;
  
  /// Optional icon
  final IconData? icon;
  
  /// Whether badge is dismissible
  final bool dismissible;
  
  /// On dismiss callback
  final VoidCallback? onDismiss;
  
  /// Custom background color
  final Color? backgroundColor;
  
  /// Custom text color
  final Color? textColor;

  const AppBadge({
    super.key,
    required this.text,
    this.type = AppBadgeType.primary,
    this.size = AppBadgeSize.md,
    this.icon,
    this.dismissible = false,
    this.onDismiss,
    this.backgroundColor,
    this.textColor,
  });

  Color _getBackgroundColor(BuildContext context) {
    if (backgroundColor != null) return backgroundColor!;
    
    switch (type) {
      case AppBadgeType.primary:
        return Theme.of(context).colorScheme.primary.withOpacity(0.1);
      case AppBadgeType.success:
        return DesignTokens.success.withOpacity(0.1);
      case AppBadgeType.error:
        return DesignTokens.error.withOpacity(0.1);
      case AppBadgeType.warning:
        return DesignTokens.warning.withOpacity(0.1);
      case AppBadgeType.info:
        return DesignTokens.info.withOpacity(0.1);
      case AppBadgeType.neutral:
        return Colors.grey.withOpacity(0.1);
    }
  }

  Color _getTextColor(BuildContext context) {
    if (textColor != null) return textColor!;
    
    switch (type) {
      case AppBadgeType.primary:
        return Theme.of(context).colorScheme.primary;
      case AppBadgeType.success:
        return DesignTokens.success;
      case AppBadgeType.error:
        return DesignTokens.error;
      case AppBadgeType.warning:
        return DesignTokens.warning;
      case AppBadgeType.info:
        return DesignTokens.info;
      case AppBadgeType.neutral:
        return Colors.grey[700]!;
    }
  }

  Color _getBorderColor(BuildContext context) {
    return _getTextColor(context).withOpacity(0.3);
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case AppBadgeSize.sm:
        return EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingXs,
          vertical: DesignTokens.spacingXxs,
        );
      case AppBadgeSize.md:
        return EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingSm,
          vertical: DesignTokens.spacingXs,
        );
      case AppBadgeSize.lg:
        return EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingMd,
          vertical: DesignTokens.spacingSm,
        );
    }
  }

  double _getFontSize() {
    switch (size) {
      case AppBadgeSize.sm:
        return 10;
      case AppBadgeSize.md:
        return 12;
      case AppBadgeSize.lg:
        return 14;
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppBadgeSize.sm:
        return 12;
      case AppBadgeSize.md:
        return 14;
      case AppBadgeSize.lg:
        return 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getTextColor(context);
    
    return Container(
      padding: _getPadding(),
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        border: Border.all(
          color: _getBorderColor(context),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: _getIconSize(),
              color: color,
            ),
            SizedBox(width: DesignTokens.spacingXxs),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: _getFontSize(),
              fontWeight: FontWeight.w600,
              color: color,
              height: 1.2,
            ),
          ),
          if (dismissible) ...[
            SizedBox(width: DesignTokens.spacingXxs),
            InkWell(
              onTap: onDismiss,
              borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
              child: Icon(
                Icons.close,
                size: _getIconSize(),
                color: color,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
