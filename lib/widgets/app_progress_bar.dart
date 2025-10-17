import 'package:flutter/material.dart';
import 'package:training_app/core/design/tokens.dart';

/// Progress bar styles
enum AppProgressBarStyle {
  /// Linear progress bar (default)
  linear,
  
  /// Circular progress indicator
  circular,
}

/// A reusable progress bar widget that follows the app's Design System.
/// 
/// Features:
/// - Linear and circular styles
/// - Color coding based on progress
/// - Optional label with percentage
/// - Customizable colors
/// - Adaptive colors (Light/Dark Mode)
/// 
/// Example:
/// ```dart
/// AppProgressBar(
///   progress: 0.75, // 75%
///   showLabel: true,
///   style: AppProgressBarStyle.linear,
/// )
/// ```
class AppProgressBar extends StatelessWidget {
  /// Progress value (0.0 to 1.0)
  final double progress;
  
  /// Progress bar style
  final AppProgressBarStyle style;
  
  /// Whether to show label with percentage
  final bool showLabel;
  
  /// Label position (only for linear style)
  final bool labelOnTop;
  
  /// Custom label text (overrides percentage)
  final String? customLabel;
  
  /// Custom progress color
  final Color? progressColor;
  
  /// Custom background color
  final Color? backgroundColor;
  
  /// Height for linear progress bar
  final double? height;
  
  /// Size for circular progress indicator
  final double? size;
  
  /// Stroke width for circular progress
  final double? strokeWidth;

  const AppProgressBar({
    super.key,
    required this.progress,
    this.style = AppProgressBarStyle.linear,
    this.showLabel = false,
    this.labelOnTop = false,
    this.customLabel,
    this.progressColor,
    this.backgroundColor,
    this.height,
    this.size,
    this.strokeWidth,
  });

  Color _getProgressColor() {
    if (progressColor != null) return progressColor!;
    
    // Color coding based on progress
    if (progress < 0.3) return DesignTokens.error;
    if (progress < 0.7) return DesignTokens.warning;
    return DesignTokens.success;
  }

  String _getLabel() {
    if (customLabel != null) return customLabel!;
    return '${(progress * 100).toInt()}%';
  }

  Widget _buildLinearProgress(BuildContext context) {
    final progressHeight = height ?? 6.0;
    
    Widget progressBar = ClipRRect(
      borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: backgroundColor ?? DesignTokens.fillColor(context),
        valueColor: AlwaysStoppedAnimation(_getProgressColor()),
        minHeight: progressHeight,
      ),
    );

    if (showLabel) {
      if (labelOnTop) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  customLabel ?? 'التقدم',
                  style: DesignTokens.caption(context),
                ),
                Text(
                  _getLabel(),
                  style: DesignTokens.caption(context).copyWith(
                    fontWeight: FontWeight.w600,
                    color: _getProgressColor(),
                  ),
                ),
              ],
            ),
            SizedBox(height: DesignTokens.spacingXs),
            progressBar,
          ],
        );
      } else {
        return Row(
          children: [
            Expanded(child: progressBar),
            SizedBox(width: DesignTokens.spacingSm),
            Text(
              _getLabel(),
              style: DesignTokens.caption(context).copyWith(
                fontWeight: FontWeight.w600,
                color: _getProgressColor(),
              ),
            ),
          ],
        );
      }
    }

    return progressBar;
  }

  Widget _buildCircularProgress(BuildContext context) {
    final progressSize = size ?? 48.0;
    final width = strokeWidth ?? 4.0;
    
    Widget circularProgress = SizedBox(
      width: progressSize,
      height: progressSize,
      child: CircularProgressIndicator(
        value: progress,
        backgroundColor: backgroundColor ?? DesignTokens.fillColor(context),
        valueColor: AlwaysStoppedAnimation(_getProgressColor()),
        strokeWidth: width,
      ),
    );

    if (showLabel) {
      return Stack(
        alignment: Alignment.center,
        children: [
          circularProgress,
          Text(
            _getLabel(),
            style: TextStyle(
              fontSize: progressSize * 0.25,
              fontWeight: FontWeight.w600,
              color: _getProgressColor(),
            ),
          ),
        ],
      );
    }

    return circularProgress;
  }

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case AppProgressBarStyle.linear:
        return _buildLinearProgress(context);
      case AppProgressBarStyle.circular:
        return _buildCircularProgress(context);
    }
  }
}
