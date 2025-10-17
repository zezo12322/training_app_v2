import 'package:flutter/material.dart';

/// Design Tokens - نظام موحد للألوان، المسافات، الخطوط، والظلال
/// يتكيف تلقائياً مع Light و Dark Mode
class DesignTokens {
  // ========== ألوان تتكيف مع الـ Theme ==========
  
  /// الحصول على لون الخلفية الرئيسي حسب الـ Theme
  static Color background(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light
        ? const Color(0xFFF0F2F5) // Facebook light grey
        : const Color(0xFF18191A); // Facebook dark grey
  }
  
  /// لون السطح (الكروت والمربعات)
  static Color surface(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light
        ? Colors.white
        : const Color(0xFF242526); // Facebook dark surface
  }
  
  /// لون الخلفية للحقول (TextField fill)
  static Color fillColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light
        ? const Color(0xFFF0F2F5) // Light grey
        : const Color(0xFF3A3B3C); // Dark grey
  }
  
  /// لون الحدود
  static Color borderColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light
        ? const Color(0xFFCED0D4) // Light grey border
        : const Color(0xFF3E4042); // Dark grey border
  }
  
  /// لون النص الأساسي
  static Color textPrimary(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light
        ? const Color(0xFF050505) // Almost black
        : const Color(0xFFE4E6EB); // Light grey text
  }
  
  /// لون النص الثانوي
  static Color textSecondary(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light
        ? const Color(0xFF65676B) // Grey text
        : const Color(0xFFB0B3B8); // Light grey text
  }
  
  /// لون النص على خلفية ملونة (مثل الأزرار)
  static Color textOnColor(BuildContext context) {
    return Colors.white; // دائماً أبيض على الأزرار الملونة
  }
  
  // ========== ألوان ثابتة (Status Colors) ==========
  static const Color success = Color(0xFF42B72A); // Green
  static const Color error = Color(0xFFE41E3F); // Red
  static const Color warning = Color(0xFFFFC107); // Amber
  static const Color info = Color(0xFF1877F2); // Blue
  
  // ========== المسافات (Spacing) ==========
  static const double spacingXxs = 2.0;
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 12.0;
  static const double spacingLg = 16.0;
  static const double spacingXl = 24.0;
  static const double spacingXxl = 32.0;
  static const double spacing3xl = 48.0;
  
  // ========== Border Radius ==========
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 10.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radiusFull = 999.0;
  
  // ========== Typography (Text Styles) ==========
  static TextStyle h1(BuildContext context) => TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.bold,
        letterSpacing: -1.5,
        color: textPrimary(context),
      );
  
  static TextStyle h2(BuildContext context) => TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        letterSpacing: -1.0,
        color: textPrimary(context),
      );
  
  static TextStyle h3(BuildContext context) => TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        color: textPrimary(context),
      );
  
  static TextStyle h4(BuildContext context) => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textPrimary(context),
      );
  
  static TextStyle h5(BuildContext context) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary(context),
      );
  
  static TextStyle h6(BuildContext context) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary(context),
      );
  
  static TextStyle body1(BuildContext context) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textPrimary(context),
      );
  
  static TextStyle body2(BuildContext context) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textPrimary(context),
      );
  
  static TextStyle caption(BuildContext context) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: textSecondary(context),
      );
  
  static TextStyle button(BuildContext context) => const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
      );
  
  // ========== Elevation (Shadows) ==========
  static List<BoxShadow> shadowSm(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return [
      BoxShadow(
        color: brightness == Brightness.light
            ? Colors.black.withOpacity(0.05)
            : Colors.black.withOpacity(0.3),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ];
  }
  
  static List<BoxShadow> shadowMd(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return [
      BoxShadow(
        color: brightness == Brightness.light
            ? Colors.black.withOpacity(0.1)
            : Colors.black.withOpacity(0.4),
        blurRadius: 20,
        offset: const Offset(0, 4),
      ),
    ];
  }
  
  static List<BoxShadow> shadowLg(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return [
      BoxShadow(
        color: brightness == Brightness.light
            ? Colors.black.withOpacity(0.15)
            : Colors.black.withOpacity(0.5),
        blurRadius: 40,
        offset: const Offset(0, 8),
      ),
    ];
  }
  
  // ========== Animation Durations ==========
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationMedium = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);
}
