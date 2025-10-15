import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_analytics.freezed.dart';
part 'course_analytics.g.dart';

/// تحليلات الكورس (للمدرب)
@freezed
class CourseAnalytics with _$CourseAnalytics {
  const factory CourseAnalytics({
    /// معرف الكورس
    required String courseId,
    
    /// إجمالي عدد الطلاب
    required int totalStudents,
    
    /// الطلاب النشطون (آخر 7 أيام)
    required int activeStudents,
    
    /// متوسط النقاط
    required double avgPoints,
    
    /// متوسط المستوى
    required double avgLevel,
    
    /// توزيع الأنشطة (Activity Breakdown)
    /// مثال: {"modules": 45, "quizzes": 30, "social": 25}
    required Map<String, int> activityBreakdown,
    
    /// أفضل الطلاب (Top 5)
    required List<TopStudent> topStudents,
    
    /// معدل التفاعل (Engagement Rate)
    /// مثال: {"daily": 0.75, "weekly": 0.90}
    required Map<String, double> engagementRate,
    
    /// إجمالي النقاط الممنوحة
    @Default(0) int totalPointsAwarded,
    
    /// إجمالي الإنجازات المفتوحة
    @Default(0) int totalAchievementsUnlocked,
    
    /// آخر تحديث
    DateTime? lastUpdated,
  }) = _CourseAnalytics;

  factory CourseAnalytics.fromJson(Map<String, dynamic> json) =>
      _$CourseAnalyticsFromJson(json);
}

/// أفضل طالب
@freezed
class TopStudent with _$TopStudent {
  const factory TopStudent({
    /// معرف المستخدم
    required String userId,
    
    /// اسم المستخدم
    required String userName,
    
    /// النقاط
    required int points,
    
    /// المستوى
    required int level,
    
    /// صورة المستخدم (اختياري)
    String? userAvatar,
    
    /// الترتيب
    @Default(1) int rank,
  }) = _TopStudent;

  factory TopStudent.fromJson(Map<String, dynamic> json) =>
      _$TopStudentFromJson(json);
}

/// إحصائيات النشاط
@freezed
class ActivityStats with _$ActivityStats {
  const factory ActivityStats({
    /// نوع النشاط
    required String activityType,
    
    /// العدد
    required int count,
    
    /// النسبة المئوية
    required double percentage,
    
    /// إجمالي النقاط من هذا النشاط
    @Default(0) int totalPoints,
  }) = _ActivityStats;

  factory ActivityStats.fromJson(Map<String, dynamic> json) =>
      _$ActivityStatsFromJson(json);
}
