/// نظام المستويات
/// 
/// يدير حساب المستويات والترقية
class LevelSystem {
  /// حساب المستوى الحالي بناءً على النقاط
  LevelCalculation calculateLevel({
    required int totalPoints,
    required Map<int, int> levelThresholds,
  }) {
    // ترتيب المستويات تصاعدياً
    final sortedLevels = levelThresholds.keys.toList()..sort();
    
    int currentLevel = 1;
    int pointsToNext = 0;
    bool leveledUp = false;
    
    // إيجاد المستوى الحالي
    for (final level in sortedLevels) {
      final threshold = levelThresholds[level]!;
      
      if (totalPoints >= threshold) {
        currentLevel = level;
      } else {
        // وصلنا للمستوى التالي
        pointsToNext = threshold - totalPoints;
        break;
      }
    }
    
    // التحقق إذا وصل للمستوى الأقصى
    final maxLevel = sortedLevels.last;
    if (currentLevel >= maxLevel) {
      pointsToNext = 0; // وصل للمستوى الأقصى
    }
    
    return LevelCalculation(
      level: currentLevel,
      pointsToNext: pointsToNext,
      leveledUp: leveledUp,
      isMaxLevel: currentLevel >= maxLevel,
    );
  }

  /// حساب نسبة التقدم للمستوى التالي
  double calculateLevelProgress({
    required int totalPoints,
    required int currentLevel,
    required Map<int, int> levelThresholds,
  }) {
    // إذا وصل للمستوى الأقصى
    final sortedLevels = levelThresholds.keys.toList()..sort();
    final maxLevel = sortedLevels.last;
    if (currentLevel >= maxLevel) {
      return 1.0; // 100%
    }
    
    // النقاط المطلوبة للمستوى الحالي
    final currentLevelPoints = levelThresholds[currentLevel] ?? 0;
    
    // النقاط المطلوبة للمستوى التالي
    final nextLevel = currentLevel + 1;
    final nextLevelPoints = levelThresholds[nextLevel] ?? currentLevelPoints;
    
    // حساب التقدم
    final pointsInCurrentLevel = totalPoints - currentLevelPoints;
    final pointsNeeded = nextLevelPoints - currentLevelPoints;
    
    if (pointsNeeded == 0) return 1.0;
    
    final progress = pointsInCurrentLevel / pointsNeeded;
    return progress.clamp(0.0, 1.0);
  }

  /// الحصول على اسم المستوى (مثلاً: مبتدئ، متوسط، خبير)
  String getLevelTitle(int level) {
    if (level >= 10) return '🏆 خبير محترف';
    if (level >= 8) return '⭐ خبير';
    if (level >= 6) return '🔥 متقدم';
    if (level >= 4) return '📈 متوسط';
    if (level >= 2) return '🌱 مبتدئ';
    return '👶 جديد';
  }

  /// الحصول على رمز المستوى (emoji)
  String getLevelEmoji(int level) {
    if (level >= 10) return '🏆';
    if (level >= 8) return '⭐';
    if (level >= 6) return '🔥';
    if (level >= 4) return '📈';
    if (level >= 2) return '🌱';
    return '👶';
  }

  /// الحصول على لون المستوى (للعرض في الواجهة)
  /// Returns hex color string
  String getLevelColor(int level) {
    if (level >= 10) return '#FFD700'; // ذهبي
    if (level >= 8) return '#C0C0C0';  // فضي
    if (level >= 6) return '#CD7F32';  // برونزي
    if (level >= 4) return '#4CAF50';  // أخضر
    if (level >= 2) return '#2196F3';  // أزرق
    return '#9E9E9E';                   // رمادي
  }

  /// إنشاء عتبات مستويات افتراضية
  static Map<int, int> createDefaultThresholds({
    int levels = 10,
    int basePoints = 100,
    double multiplier = 1.5,
  }) {
    final thresholds = <int, int>{1: 0};
    
    var currentPoints = 0;
    for (var level = 2; level <= levels; level++) {
      currentPoints = (currentPoints + basePoints * (level - 1)).round();
      thresholds[level] = currentPoints;
      basePoints = (basePoints * multiplier).round();
    }
    
    return thresholds;
  }

  /// حساب إجمالي النقاط المطلوبة للوصول لمستوى معين
  int getTotalPointsForLevel({
    required int targetLevel,
    required Map<int, int> levelThresholds,
  }) {
    return levelThresholds[targetLevel] ?? 0;
  }

  /// الحصول على تفاصيل كل المستويات
  List<LevelInfo> getAllLevelsInfo(Map<int, int> levelThresholds) {
    final sortedLevels = levelThresholds.keys.toList()..sort();
    
    return sortedLevels.map((level) {
      final points = levelThresholds[level]!;
      return LevelInfo(
        level: level,
        requiredPoints: points,
        title: getLevelTitle(level),
        emoji: getLevelEmoji(level),
        color: getLevelColor(level),
      );
    }).toList();
  }
}

/// نتيجة حساب المستوى
class LevelCalculation {
  final int level;
  final int pointsToNext;
  final bool leveledUp;
  final bool isMaxLevel;

  LevelCalculation({
    required this.level,
    required this.pointsToNext,
    required this.leveledUp,
    required this.isMaxLevel,
  });
}

/// معلومات مستوى معين
class LevelInfo {
  final int level;
  final int requiredPoints;
  final String title;
  final String emoji;
  final String color;

  LevelInfo({
    required this.level,
    required this.requiredPoints,
    required this.title,
    required this.emoji,
    required this.color,
  });
}
