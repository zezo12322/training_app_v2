import 'package:flutter/material.dart';
import 'package:training_app/core/design/tokens.dart';

/// A reusable card widget that follows the app's Design System.
/// 
/// Features:
/// - Adaptive colors (Light/Dark Mode)
/// - Consistent spacing and shadows
/// - Optional tap handling
/// - Optional child widget
/// 
/// Example:
/// ```dart
/// AppCard(
///   child: Text('Content'),
///   onTap: () => print('Tapped'),
/// )
/// ```
class AppCard extends StatelessWidget {
  /// The widget to display inside the card
  final Widget? child;
  
  /// Callback when the card is tapped (makes card tappable)
  final VoidCallback? onTap;
  
  /// Custom padding (defaults to Design Token spacing)
  final EdgeInsetsGeometry? padding;
  
  /// Custom margin
  final EdgeInsetsGeometry? margin;
  
  /// Custom background color (defaults to Design Token surface color)
  final Color? backgroundColor;
  
  /// Custom border radius (defaults to Design Token radius)
  final BorderRadiusGeometry? borderRadius;
  
  /// Custom elevation/shadow (defaults to Design Token shadow)
  final List<BoxShadow>? boxShadow;
  
  /// Custom border
  final Border? border;
  
  /// Width of the card
  final double? width;
  
  /// Height of the card
  final double? height;

  const AppCard({
    super.key,
    this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.border,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final widget = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? EdgeInsets.all(DesignTokens.spacingLg),
      decoration: BoxDecoration(
        color: backgroundColor ?? DesignTokens.surface(context),
        borderRadius: borderRadius ?? BorderRadius.circular(DesignTokens.radiusLg),
        boxShadow: boxShadow ?? DesignTokens.shadowMd(context),
        border: border,
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius as BorderRadius? ?? 
              BorderRadius.circular(DesignTokens.radiusLg),
          child: widget,
        ),
      );
    }

    return widget;
  }
}
