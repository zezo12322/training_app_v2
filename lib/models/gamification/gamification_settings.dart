import 'package:freezed_annotation/freezed_annotation.dart';
import 'activity_points.dart';

part 'gamification_settings.freezed.dart';
part 'gamification_settings.g.dart';

/// إعدادات نظام الـ Gamification للكورس
/// 
/// يحتوي على كل الإعدادات التي يحددها المدرب:
/// - نقاط الأنشطة
/// - مستويات وعتبات النقاط
/// - الشارات المتاحة
@freezed
class GamificationSettings with _$GamificationSettings {
  const factory GamificationSettings({
    /// إعدادات نقاط الأنشطة
    required ActivityPoints activityPoints,
    
    /// عتبات المستويات (Level -> Required Points)
    /// مثال: {1: 0, 2: 100, 3: 250, 4: 500, 5: 1000}
    required Map<int, int> levelThresholds,
    
    /// الشارات المتاحة في هذا الكورس
    @Default([]) List<String> availableBadges,
    
    /// هل النظام مفعّل؟
    @Default(true) bool isEnabled,
    
    /// تاريخ آخر تحديث
    DateTime? lastUpdatedAt,
    
    /// ID المدرب الذي عدّل الإعدادات
    String? lastUpdatedBy,
  }) = _GamificationSettings;

  factory GamificationSettings.fromJson(Map<String, dynamic> json) =>
      _$GamificationSettingsFromJson(json);
      
  /// الإعدادات الافتراضية
  factory GamificationSettings.defaultSettings() {
    return GamificationSettings(
      activityPoints: ActivityPoints.defaultSettings(),
      levelThresholds: {
        1: 0,
        2: 100,
        3: 250,
        4: 500,
        5: 1000,
        6: 2000,
        7: 3500,
        8: 5500,
        9: 8000,
        10: 11000,
      },
      availableBadges: [
        'first_quiz',
        'perfect_score',
        'helping_hand',
        'social_butterfly',
        'streak_master',
        'module_master',
      ],
    );
  }
}
