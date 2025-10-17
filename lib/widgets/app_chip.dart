import 'package:flutter/material.dart';
import 'package:training_app/core/design/tokens.dart';

/// Chip styles
enum AppChipStyle {
  /// Filled chip (default)
  filled,
  
  /// Outlined chip
  outlined,
  
  /// Flat chip (no border or background)
  flat,
}

/// A reusable chip widget that follows the app's Design System.
/// 
/// Features:
/// - Multiple styles (filled, outlined, flat)
/// - Optional icon or avatar
/// - Optional delete button
/// - Optional selection state
/// - Customizable colors
/// 
/// Example:
/// ```dart
/// AppChip(
///   label: 'Flutter',
///   icon: Icons.code,
///   style: AppChipStyle.filled,
///   onDeleted: () => removeTag('Flutter'),
/// )
/// ```
class AppChip extends StatelessWidget {
  /// Chip label
  final String label;
  
  /// Chip style
  final AppChipStyle style;
  
  /// Optional icon
  final IconData? icon;
  
  /// Optional avatar (takes priority over icon)
  final Widget? avatar;
  
  /// Whether chip is selected
  final bool selected;
  
  /// On tap callback
  final VoidCallback? onTap;
  
  /// On deleted callback (shows delete button if provided)
  final VoidCallback? onDeleted;
  
  /// Custom background color
  final Color? backgroundColor;
  
  /// Custom text color
  final Color? textColor;
  
  /// Custom selected background color
  final Color? selectedBackgroundColor;

  const AppChip({
    super.key,
    required this.label,
    this.style = AppChipStyle.filled,
    this.icon,
    this.avatar,
    this.selected = false,
    this.onTap,
    this.onDeleted,
    this.backgroundColor,
    this.textColor,
    this.selectedBackgroundColor,
  });

  Color _getBackgroundColor(BuildContext context) {
    if (selected && selectedBackgroundColor != null) {
      return selectedBackgroundColor!;
    }
    if (backgroundColor != null) return backgroundColor!;
    
    switch (style) {
      case AppChipStyle.filled:
        return selected
            ? Theme.of(context).colorScheme.primary
            : DesignTokens.fillColor(context);
      case AppChipStyle.outlined:
      case AppChipStyle.flat:
        return selected
            ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
            : Colors.transparent;
    }
  }

  Color _getTextColor(BuildContext context) {
    if (textColor != null) return textColor!;
    
    if (selected && style == AppChipStyle.filled) {
      return DesignTokens.textOnColor(context);
    }
    
    return selected
        ? Theme.of(context).colorScheme.primary
        : DesignTokens.textPrimary(context);
  }

  BorderSide? _getBorderSide(BuildContext context) {
    switch (style) {
      case AppChipStyle.outlined:
        return BorderSide(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : DesignTokens.borderColor(context),
          width: 1.5,
        );
      case AppChipStyle.filled:
      case AppChipStyle.flat:
        return BorderSide.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColorValue = _getTextColor(context);
    
    Widget chip = Container(
      padding: EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingMd,
        vertical: DesignTokens.spacingSm,
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
        borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
        border: Border.fromBorderSide(
          _getBorderSide(context) ?? BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar or Icon
          if (avatar != null)
            Padding(
              padding: EdgeInsets.only(right: DesignTokens.spacingXs),
              child: avatar,
            )
          else if (icon != null) ...[
            Icon(
              icon,
              size: 18,
              color: textColorValue,
            ),
            SizedBox(width: DesignTokens.spacingXs),
          ],
          
          // Label
          Text(
            label,
            style: DesignTokens.body2(context).copyWith(
              fontWeight: FontWeight.w600,
              color: textColorValue,
            ),
          ),
          
          // Delete Button
          if (onDeleted != null) ...[
            SizedBox(width: DesignTokens.spacingXs),
            InkWell(
              onTap: onDeleted,
              borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
              child: Icon(
                Icons.close,
                size: 18,
                color: textColorValue,
              ),
            ),
          ],
        ],
      ),
    );

    // Add tap handling
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
        child: chip,
      );
    }

    return chip;
  }
}

/// Wrap multiple chips with proper spacing
class AppChipGroup extends StatelessWidget {
  /// List of chips
  final List<Widget> chips;
  
  /// Spacing between chips
  final double spacing;
  
  /// Run spacing (vertical spacing between rows)
  final double runSpacing;
  
  /// Alignment
  final WrapAlignment alignment;

  const AppChipGroup({
    super.key,
    required this.chips,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.alignment = WrapAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      alignment: alignment,
      children: chips,
    );
  }
}
