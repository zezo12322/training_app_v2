import 'package:flutter/material.dart';
import 'package:training_app/core/design/tokens.dart';

/// Skeleton types
enum AppSkeletonType {
  /// Text line skeleton
  text,
  
  /// Circle skeleton (for avatars)
  circle,
  
  /// Rectangle skeleton (for images/cards)
  rectangle,
  
  /// Rounded rectangle skeleton
  roundedRectangle,
}

/// A reusable loading skeleton widget that follows the app's Design System.
/// 
/// Features:
/// - Multiple skeleton types
/// - Shimmer animation effect
/// - Customizable size
/// - Adaptive colors (Light/Dark Mode)
/// 
/// Example:
/// ```dart
/// // Text skeleton
/// AppLoadingSkeleton(
///   type: AppSkeletonType.text,
///   width: 200,
///   height: 20,
/// )
/// 
/// // Avatar skeleton
/// AppLoadingSkeleton(
///   type: AppSkeletonType.circle,
///   width: 48,
///   height: 48,
/// )
/// ```
class AppLoadingSkeleton extends StatefulWidget {
  /// Skeleton type
  final AppSkeletonType type;
  
  /// Width
  final double? width;
  
  /// Height
  final double? height;
  
  /// Custom border radius (for rectangle types)
  final double? borderRadius;

  const AppLoadingSkeleton({
    super.key,
    this.type = AppSkeletonType.rectangle,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  State<AppLoadingSkeleton> createState() => _AppLoadingSkeletonState();
}

class _AppLoadingSkeletonState extends State<AppLoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  BorderRadius? _getBorderRadius() {
    switch (widget.type) {
      case AppSkeletonType.text:
        return BorderRadius.circular(DesignTokens.radiusXs);
      case AppSkeletonType.circle:
        return null; // Will use BoxShape.circle
      case AppSkeletonType.rectangle:
        return null;
      case AppSkeletonType.roundedRectangle:
        return BorderRadius.circular(
          widget.borderRadius ?? DesignTokens.radiusMd,
        );
    }
  }

  BoxShape _getShape() {
    return widget.type == AppSkeletonType.circle
        ? BoxShape.circle
        : BoxShape.rectangle;
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = DesignTokens.fillColor(context);
    final highlightColor = Theme.of(context).brightness == Brightness.light
        ? Colors.grey[100]!
        : Colors.grey[800]!;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            shape: _getShape(),
            borderRadius: _getShape() == BoxShape.circle
                ? null
                : _getBorderRadius(),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((e) => e.clamp(0.0, 1.0)).toList(),
            ),
          ),
        );
      },
    );
  }
}

/// Pre-built skeleton layouts for common use cases
class AppSkeletonLayouts {
  /// Skeleton for a list item with avatar and text
  static Widget listItem({
    bool showAvatar = true,
    int textLines = 2,
  }) {
    return Padding(
      padding: EdgeInsets.all(DesignTokens.spacingMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showAvatar) ...[
            const AppLoadingSkeleton(
              type: AppSkeletonType.circle,
              width: 48,
              height: 48,
            ),
            SizedBox(width: DesignTokens.spacingMd),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                textLines,
                (index) => Padding(
                  padding: EdgeInsets.only(
                    bottom: index < textLines - 1
                        ? DesignTokens.spacingSm
                        : 0,
                  ),
                  child: AppLoadingSkeleton(
                    type: AppSkeletonType.text,
                    height: 16,
                    width: index == textLines - 1 ? 150 : null,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Skeleton for a card with image and content
  static Widget card(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DesignTokens.surface(context),
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppLoadingSkeleton(
            type: AppSkeletonType.rectangle,
            height: 150,
          ),
          Padding(
            padding: EdgeInsets.all(DesignTokens.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppLoadingSkeleton(
                  type: AppSkeletonType.text,
                  height: 20,
                ),
                SizedBox(height: DesignTokens.spacingSm),
                const AppLoadingSkeleton(
                  type: AppSkeletonType.text,
                  height: 16,
                  width: 200,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
