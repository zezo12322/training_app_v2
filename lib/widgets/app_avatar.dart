import 'package:flutter/material.dart';
import 'package:training_app/core/design/tokens.dart';

/// Avatar sizes
enum AppAvatarSize {
  /// Extra small (24x24)
  xs,
  
  /// Small (32x32)
  sm,
  
  /// Medium (48x48) - default
  md,
  
  /// Large (64x64)
  lg,
  
  /// Extra large (96x96)
  xl,
  
  /// Extra extra large (128x128)
  xxl,
}

/// A reusable avatar widget that follows the app's Design System.
/// 
/// Features:
/// - Multiple sizes (xs to xxl)
/// - Image or initials fallback
/// - Online status indicator
/// - Customizable border
/// - Tap handling
/// 
/// Example:
/// ```dart
/// AppAvatar(
///   imageUrl: 'https://example.com/avatar.jpg',
///   name: 'John Doe',
///   size: AppAvatarSize.md,
///   showOnlineStatus: true,
///   isOnline: true,
/// )
/// ```
class AppAvatar extends StatelessWidget {
  /// Image URL
  final String? imageUrl;
  
  /// User name (used for initials fallback)
  final String? name;
  
  /// Avatar size
  final AppAvatarSize size;
  
  /// Whether to show online status indicator
  final bool showOnlineStatus;
  
  /// Whether user is online
  final bool isOnline;
  
  /// On tap callback
  final VoidCallback? onTap;
  
  /// Custom background color
  final Color? backgroundColor;
  
  /// Custom border color
  final Color? borderColor;
  
  /// Border width
  final double? borderWidth;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = AppAvatarSize.md,
    this.showOnlineStatus = false,
    this.isOnline = false,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
  });

  double _getSize() {
    switch (size) {
      case AppAvatarSize.xs:
        return 24;
      case AppAvatarSize.sm:
        return 32;
      case AppAvatarSize.md:
        return 48;
      case AppAvatarSize.lg:
        return 64;
      case AppAvatarSize.xl:
        return 96;
      case AppAvatarSize.xxl:
        return 128;
    }
  }

  double _getFontSize() {
    switch (size) {
      case AppAvatarSize.xs:
        return 10;
      case AppAvatarSize.sm:
        return 12;
      case AppAvatarSize.md:
        return 18;
      case AppAvatarSize.lg:
        return 24;
      case AppAvatarSize.xl:
        return 36;
      case AppAvatarSize.xxl:
        return 48;
    }
  }

  double _getStatusSize() {
    switch (size) {
      case AppAvatarSize.xs:
      case AppAvatarSize.sm:
        return 8;
      case AppAvatarSize.md:
        return 10;
      case AppAvatarSize.lg:
      case AppAvatarSize.xl:
        return 12;
      case AppAvatarSize.xxl:
        return 16;
    }
  }

  String _getInitials() {
    if (name == null || name!.isEmpty) return '?';
    
    final parts = name!.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name![0].toUpperCase();
  }

  Color _getBackgroundColor(BuildContext context) {
    if (backgroundColor != null) return backgroundColor!;
    
    // Generate color from name
    if (name != null && name!.isNotEmpty) {
      final hash = name!.hashCode;
      final hue = (hash % 360).toDouble();
      return HSLColor.fromAHSL(1.0, hue, 0.5, 0.6).toColor();
    }
    
    return Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    final avatarSize = _getSize();
    final theme = Theme.of(context);
    
    Widget avatar = Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
        shape: BoxShape.circle,
        border: borderColor != null || borderWidth != null
            ? Border.all(
                color: borderColor ?? theme.colorScheme.primary,
                width: borderWidth ?? 2,
              )
            : null,
        image: imageUrl != null && imageUrl!.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageUrl == null || imageUrl!.isEmpty
          ? Center(
              child: Text(
                _getInitials(),
                style: TextStyle(
                  fontSize: _getFontSize(),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            )
          : null,
    );

    // Add online status indicator
    if (showOnlineStatus) {
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: _getStatusSize(),
              height: _getStatusSize(),
              decoration: BoxDecoration(
                color: isOnline ? DesignTokens.success : Colors.grey,
                shape: BoxShape.circle,
                border: Border.all(
                  color: DesignTokens.surface(context),
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Add tap handling
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(avatarSize / 2),
        child: avatar,
      );
    }

    return avatar;
  }
}
