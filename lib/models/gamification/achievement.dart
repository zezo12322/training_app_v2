import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement.freezed.dart';
part 'achievement.g.dart';

/// إنجاز (Achievement/Badge)
@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    /// معرف الإنجاز
    required String id,
    
    /// العنوان
    required String title,
    
    /// الوصف
    required String description,
    
    /// رابط الأيقونة
    required String iconUrl,
    
    /// الفئة
    required AchievementCategory category,
    
    /// المعايير لفتح الإنجاز
    required AchievementCriteria criteria,
    
    /// نقاط المكافأة عند الفتح
    @Default(0) int pointsReward,
    
    /// هل الإنجاز سري (مخفي حتى يتم فتحه)
    @Default(false) bool isSecret,
    
    /// معرف الكورس (null = عام لكل الكورسات)
    String? courseId,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
}

/// فئات الإنجازات
enum AchievementCategory {
  /// إكمال وحدات
  modules,
  
  /// اجتياز اختبارات
  quizzes,
  
  /// التفاعل الاجتماعي
  social,
  
  /// Daily Streak
  streak,
  
  /// إنجازات خاصة
  special,
}

extension AchievementCategoryX on AchievementCategory {
  String get displayName {
    switch (this) {
      case AchievementCategory.modules:
        return 'الوحدات';
      case AchievementCategory.quizzes:
        return 'الاختبارات';
      case AchievementCategory.social:
        return 'التفاعل';
      case AchievementCategory.streak:
        return 'الاستمرارية';
      case AchievementCategory.special:
        return 'خاصة';
    }
  }
  
  String get icon {
    switch (this) {
      case AchievementCategory.modules:
        return '📚';
      case AchievementCategory.quizzes:
        return '📝';
      case AchievementCategory.social:
        return '👥';
      case AchievementCategory.streak:
        return '🔥';
      case AchievementCategory.special:
        return '⭐';
    }
  }
}

/// معايير فتح الإنجاز
@freezed
class AchievementCriteria with _$AchievementCriteria {
  const factory AchievementCriteria({
    /// نوع المعيار
    /// مثال: "modules_completed", "quizzes_passed", "streak_days"
    required String type,
    
    /// القيمة المستهدفة
    /// مثال: 5 (وحدات)، 10 (اختبارات)، 7 (أيام)
    required int targetValue,
    
    /// معرف محدد (اختياري)
    /// مثال: معرف وحدة معينة، معرف اختبار معين
    String? specificId,
    
    /// شروط إضافية (اختياري)
    Map<String, dynamic>? additionalConditions,
  }) = _AchievementCriteria;

  factory AchievementCriteria.fromJson(Map<String, dynamic> json) =>
      _$AchievementCriteriaFromJson(json);
}

/// إنجاز المستخدم (Achievement Unlock)
@freezed
class UserAchievement with _$UserAchievement {
  const factory UserAchievement({
    /// معرف الإنجاز
    required String achievementId,
    
    /// معرف المستخدم
    required String userId,
    
    /// معرف الكورس
    required String courseId,
    
    /// تاريخ الفتح
    required DateTime unlockedAt,
    
    /// هل تم عرضه للمستخدم (لإظهار notification)
    @Default(false) bool isViewed,
    
    /// التقدم الحالي (اختياري - للإنجازات التدريجية)
    @Default(0) int currentProgress,
  }) = _UserAchievement;

  factory UserAchievement.fromJson(Map<String, dynamic> json) =>
      _$UserAchievementFromJson(json);
}

/// قائمة الإنجازات المحددة مسبقاً
class PredefinedAchievements {
  static const List<Achievement> all = [
    // === Module Achievements ===
    Achievement(
      id: 'first_module',
      title: 'المبتدئ',
      description: 'أكمل وحدتك التعليمية الأولى',
      iconUrl: '🎯',
      category: AchievementCategory.modules,
      criteria: AchievementCriteria(
        type: 'modules_completed',
        targetValue: 1,
      ),
      pointsReward: 50,
    ),
    Achievement(
      id: 'five_modules',
      title: 'المثابر',
      description: 'أكمل 5 وحدات تعليمية',
      iconUrl: '💪',
      category: AchievementCategory.modules,
      criteria: AchievementCriteria(
        type: 'modules_completed',
        targetValue: 5,
      ),
      pointsReward: 200,
    ),
    Achievement(
      id: 'ten_modules',
      title: 'الخبير',
      description: 'أكمل 10 وحدات تعليمية',
      iconUrl: '🏆',
      category: AchievementCategory.modules,
      criteria: AchievementCriteria(
        type: 'modules_completed',
        targetValue: 10,
      ),
      pointsReward: 500,
    ),
    
    // === Quiz Achievements ===
    Achievement(
      id: 'first_quiz',
      title: 'المُجتاز',
      description: 'اجتز اختبارك الأول',
      iconUrl: '✅',
      category: AchievementCategory.quizzes,
      criteria: AchievementCriteria(
        type: 'quizzes_passed',
        targetValue: 1,
      ),
      pointsReward: 30,
    ),
    Achievement(
      id: 'perfect_score',
      title: 'الكمال',
      description: 'احصل على درجة كاملة في اختبار',
      iconUrl: '💯',
      category: AchievementCategory.quizzes,
      criteria: AchievementCriteria(
        type: 'perfect_quiz_score',
        targetValue: 1,
      ),
      pointsReward: 100,
    ),
    Achievement(
      id: 'five_quizzes',
      title: 'العالم',
      description: 'اجتز 5 اختبارات',
      iconUrl: '🎓',
      category: AchievementCategory.quizzes,
      criteria: AchievementCriteria(
        type: 'quizzes_passed',
        targetValue: 5,
      ),
      pointsReward: 250,
    ),
    
    // === Streak Achievements ===
    Achievement(
      id: 'week_streak',
      title: 'المنتظم',
      description: 'حافظ على Daily Streak لمدة 7 أيام',
      iconUrl: '🔥',
      category: AchievementCategory.streak,
      criteria: AchievementCriteria(
        type: 'daily_streak',
        targetValue: 7,
      ),
      pointsReward: 150,
    ),
    Achievement(
      id: 'month_streak',
      title: 'الملتزم',
      description: 'حافظ على Daily Streak لمدة 30 يوم',
      iconUrl: '⚡',
      category: AchievementCategory.streak,
      criteria: AchievementCriteria(
        type: 'daily_streak',
        targetValue: 30,
      ),
      pointsReward: 1000,
    ),
    
    // === Social Achievements ===
    Achievement(
      id: 'helpful_peer',
      title: 'المساعد',
      description: 'ساعد 5 زملاء بتعليقات مفيدة',
      iconUrl: '🤝',
      category: AchievementCategory.social,
      criteria: AchievementCriteria(
        type: 'helpful_comments',
        targetValue: 5,
      ),
      pointsReward: 100,
    ),
    Achievement(
      id: 'social_butterfly',
      title: 'الاجتماعي',
      description: 'شارك 20 منشور أو تعليق',
      iconUrl: '🦋',
      category: AchievementCategory.social,
      criteria: AchievementCriteria(
        type: 'social_interactions',
        targetValue: 20,
      ),
      pointsReward: 200,
    ),
    
    // === Special Achievements ===
    Achievement(
      id: 'top_student',
      title: 'النجم',
      description: 'احتل المركز الأول في لوحة المتصدرين',
      iconUrl: '🌟',
      category: AchievementCategory.special,
      criteria: AchievementCriteria(
        type: 'leaderboard_rank',
        targetValue: 1,
      ),
      pointsReward: 500,
      isSecret: true,
    ),
    Achievement(
      id: 'level_ten',
      title: 'الأسطورة',
      description: 'وصلت إلى المستوى 10',
      iconUrl: '👑',
      category: AchievementCategory.special,
      criteria: AchievementCriteria(
        type: 'level_reached',
        targetValue: 10,
      ),
      pointsReward: 1000,
      isSecret: true,
    ),
  ];
}
