import 'package:flutter/material.dart';
import 'package:training_app/core/design/tokens.dart';
import 'package:training_app/widgets/widgets.dart';

/// Professional loading skeletons for dashboard components
/// 
/// These are production-ready skeleton loaders that provide
/// a better UX than simple CircularProgressIndicator
class DashboardSkeletons {
  DashboardSkeletons._();
  
  /// Skeleton for stats card with shimmer effect
  static Widget statsCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Points and Level Row
        Row(
          children: [
            Expanded(
              child: AppLoadingSkeleton(
                type: AppSkeletonType.text,
                height: 24,
                width: 150,
              ),
            ),
            AppLoadingSkeleton(
              type: AppSkeletonType.roundedRectangle,
              height: 28,
              width: 60,
            ),
            SizedBox(width: DesignTokens.spacingSm),
            AppLoadingSkeleton(
              type: AppSkeletonType.roundedRectangle,
              height: 28,
              width: 50,
            ),
          ],
        ),
        SizedBox(height: DesignTokens.spacingMd),
        
        // Progress Bar
        AppLoadingSkeleton(
          type: AppSkeletonType.roundedRectangle,
          height: 8,
        ),
        SizedBox(height: DesignTokens.spacingSm),
        
        // Next Badge Text
        AppLoadingSkeleton(
          type: AppSkeletonType.text,
          height: 14,
          width: 200,
        ),
      ],
    );
  }
  
  /// Skeleton for course card
  static Widget courseCard() {
    return SizedBox(
      width: 160,
      height: 140,
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Title (2 lines)
            AppLoadingSkeleton(
              type: AppSkeletonType.text,
              height: 16,
            ),
            SizedBox(height: DesignTokens.spacingXs),
            AppLoadingSkeleton(
              type: AppSkeletonType.text,
              height: 16,
              width: 120,
            ),
            const Spacer(),
            // Course Code
            AppLoadingSkeleton(
              type: AppSkeletonType.text,
              height: 12,
              width: 80,
            ),
          ],
        ),
      ),
    );
  }
}

/// Professional error handler for dashboard
/// 
/// Provides user-friendly error messages instead of raw exceptions
class DashboardErrorHandler {
  DashboardErrorHandler._();
  
  /// Convert error to user-friendly message
  static String getUserFriendlyMessage(Object error, String fallback) {
    final errorStr = error.toString().toLowerCase();
    
    // Network errors
    if (errorStr.contains('network') || 
        errorStr.contains('socket') ||
        errorStr.contains('connection')) {
      return 'No internet connection. Please check your network.';
    }
    
    // Permission errors
    if (errorStr.contains('permission') || errorStr.contains('denied')) {
      return 'Access denied. Please check your permissions.';
    }
    
    // Timeout errors
    if (errorStr.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    
    // Firebase errors
    if (errorStr.contains('firebase')) {
      return 'Service temporarily unavailable. Please try again later.';
    }
    
    // Default fallback
    return fallback;
  }
}
