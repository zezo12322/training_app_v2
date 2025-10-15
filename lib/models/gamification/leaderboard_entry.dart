import 'package:freezed_annotation/freezed_annotation.dart';

part 'leaderboard_entry.freezed.dart';
part 'leaderboard_entry.g.dart';

/// إدخال في لوحة المتصدرين
@freezed
class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    /// معرف المستخدم
    required String userId,
    
    /// اسم المستخدم
    required String userName,
    
    /// صورة المستخدم (اختياري)
    String? userAvatar,
    
    /// إجمالي النقاط
    required int totalPoints,
    
    /// المستوى الحالي
    required int currentLevel,
    
    /// اسم المستوى
    required String levelName,
    
    /// الترتيب
    required int rank,
    
    /// عدد الوحدات المكتملة
    @Default(0) int moduleCount,
    
    /// عدد الاختبارات المكتملة
    @Default(0) int quizCount,
    
    /// عدد أيام Daily Streak
    @Default(0) int streakCount,
    
    /// آخر نشاط
    DateTime? lastActivity,
  }) = _LeaderboardEntry;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryFromJson(json);
}

/// الفترة الزمنية للوحة المتصدرين
enum LeaderboardTimeframe {
  /// الأسبوع الحالي
  weekly,
  
  /// الشهر الحالي
  monthly,
  
  /// كل الوقت
  allTime,
}

extension LeaderboardTimeframeX on LeaderboardTimeframe {
  String get displayName {
    switch (this) {
      case LeaderboardTimeframe.weekly:
        return 'الأسبوع';
      case LeaderboardTimeframe.monthly:
        return 'الشهر';
      case LeaderboardTimeframe.allTime:
        return 'الكل';
    }
  }
  
  /// حساب تاريخ البداية للفترة
  DateTime get startDate {
    final now = DateTime.now();
    switch (this) {
      case LeaderboardTimeframe.weekly:
        // بداية الأسبوع (الأحد)
        return now.subtract(Duration(days: now.weekday % 7));
      case LeaderboardTimeframe.monthly:
        // بداية الشهر
        return DateTime(now.year, now.month, 1);
      case LeaderboardTimeframe.allTime:
        // بداية الزمن (2000)
        return DateTime(2000, 1, 1);
    }
  }
}
