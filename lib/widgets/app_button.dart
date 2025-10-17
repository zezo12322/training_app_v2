import 'package:flutter/material.dart';
import 'package:training_app/core/design/tokens.dart';

/// Button types for AppButton
enum AppButtonType {
  /// Primary filled button (default)
  primary,
  
  /// Secondary outlined button
  secondary,
  
  /// Text-only button
  text,
  
  /// Success button (green)
  success,
  
  /// Error/Danger button (red)
  error,
  
  /// Warning button (orange)
  warning,
  
  /// Info button (blue)
  info,
}

/// A reusable button widget that follows the app's Design System.
/// 
/// Features:
/// - Multiple button types (primary, secondary, text, etc.)
/// - Adaptive colors (Light/Dark Mode)
/// - Loading state support
/// - Icon support
/// - Consistent styling
/// 
/// Example:
/// ```dart
/// AppButton(
///   text: 'Submit',
///   onPressed: () => print('Pressed'),
///   type: AppButtonType.primary,
///   isLoading: false,
/// )
/// ```
class AppButton extends StatelessWidget {
  /// The button text
  final String text;
  
  /// Callback when button is pressed
  final VoidCallback? onPressed;
  
  /// Button type (primary, secondary, etc.)
  final AppButtonType type;
  
  /// Whether button is in loading state
  final bool isLoading;
  
  /// Optional icon to display before text
  final IconData? icon;
  
  /// Custom text style
  final TextStyle? textStyle;
  
  /// Expand button to fill width
  final bool fullWidth;
  
  /// Custom padding
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.textStyle,
    this.fullWidth = false,
    this.padding,
  });

  Color _getBackgroundColor(BuildContext context) {
    switch (type) {
      case AppButtonType.primary:
        return Theme.of(context).colorScheme.primary;
      case AppButtonType.success:
        return DesignTokens.success;
      case AppButtonType.error:
        return DesignTokens.error;
      case AppButtonType.warning:
        return DesignTokens.warning;
      case AppButtonType.info:
        return DesignTokens.info;
      case AppButtonType.secondary:
      case AppButtonType.text:
        return Colors.transparent;
    }
  }

  Color _getForegroundColor(BuildContext context) {
    switch (type) {
      case AppButtonType.primary:
      case AppButtonType.success:
      case AppButtonType.error:
      case AppButtonType.warning:
      case AppButtonType.info:
        return DesignTokens.textOnColor(context);
      case AppButtonType.secondary:
        return Theme.of(context).colorScheme.primary;
      case AppButtonType.text:
        return DesignTokens.textSecondary(context);
    }
  }

  BorderSide? _getBorderSide(BuildContext context) {
    if (type == AppButtonType.secondary) {
      return BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 1.5,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = type == AppButtonType.text
        ? TextButton.styleFrom(
            foregroundColor: _getForegroundColor(context),
            padding: padding ?? EdgeInsets.symmetric(
              horizontal: DesignTokens.spacingLg,
              vertical: DesignTokens.spacingMd,
            ),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: _getBackgroundColor(context),
            foregroundColor: _getForegroundColor(context),
            padding: padding ?? EdgeInsets.symmetric(
              horizontal: DesignTokens.spacingXl,
              vertical: DesignTokens.spacingLg,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              side: _getBorderSide(context) ?? BorderSide.none,
            ),
            elevation: type == AppButtonType.secondary ? 0 : 2,
          );

    Widget buttonChild = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _getForegroundColor(context),
            ),
          )
        : Row(
            mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                SizedBox(width: DesignTokens.spacingSm),
              ],
              Text(
                text,
                style: textStyle ?? DesignTokens.button(context),
              ),
            ],
          );

    if (type == AppButtonType.text) {
      return TextButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: buttonChild,
      );
    }

    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: buttonStyle,
      child: buttonChild,
    );

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }
}
