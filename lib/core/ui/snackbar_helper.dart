import 'package:flutter/material.dart';

/// Centralized helper for showing SnackBars to ensure consistent styling
/// and prevent duplicate code across screens.
class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context,
    String message, {
    bool isError = true,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    if (message.trim().isEmpty) return;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final backgroundColor = isError
        ? colorScheme.errorContainer.withValues(alpha: 0.95)
        : colorScheme.primaryContainer.withValues(alpha: 0.95);
    final foregroundColor = isError
        ? colorScheme.onErrorContainer
        : colorScheme.onPrimaryContainer;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: foregroundColor)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
      ),
    );
  }
}
