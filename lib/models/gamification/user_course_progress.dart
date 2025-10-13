import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/timestamp_converter.dart';

part 'user_course_progress.freezed.dart';
part 'user_course_progress.g.dart';

/// تقدم المتدرب في الكورس
/// 
/// يحتوي على كل المعلومات المتعلقة بتقدم المستخدم:
/// - النقاط الكلية والمستوى الحالي
/// - إحصائيات الأنشطة
/// - الشارات المكتسبة
/// - سجل الدخول اليومي
@freezed
class UserCourseProgress with _$UserCourseProgress {
  const factory UserCourseProgress({
    /// معرف المستخدم
    required String userId,
    
    /// معرف الكورس
    required String courseId,
    
    /// إجمالي النقاط المكتسبة
    @Default(0) int totalPoints,
    
    /// المستوى الحالي
    @Default(1) int currentLevel,
    
    /// النقاط المتبقية للمستوى التالي
    @Default(100) int pointsToNextLevel,
    
    /// عدد كل نشاط (activity_type -> count)
    /// مثال: {'completing_lesson': 5, 'passing_quiz': 3}
    @Default({}) Map<String, int> activityCounts,
    
    /// الشارات المكتسبة
    @Default([]) List<String> earnedBadges,
    
    /// آخر نشاط
    @TimestampConverter() required DateTime lastActivityAt,
    
    /// عدد أيام الدخول المتواصل
    @Default(0) int dailyStreakCount,
    
    /// أطول سلسلة دخول متواصلة
    @Default(0) int longestStreak,
    
    /// تاريخ آخر دخول (لحساب الـ streak)
    @TimestampConverter() DateTime? lastStreakCheckDate,
    
    /// تاريخ الإنشاء
    @TimestampConverter() DateTime? createdAt,
    
    /// تاريخ آخر تحديث
    @TimestampConverter() DateTime? updatedAt,
  }) = _UserCourseProgress;

  factory UserCourseProgress.fromJson(Map<String, dynamic> json) =>
      _$UserCourseProgressFromJson(json);
      
  /// إنشاء progress جديد لمستخدم
  factory UserCourseProgress.create({
    required String userId,
    required String courseId,
  }) {
    final now = DateTime.now();
    return UserCourseProgress(
      userId: userId,
      courseId: courseId,
      lastActivityAt: now,
      createdAt: now,
      updatedAt: now,
    );
  }
}

/// إحصائيات تفصيلية للتقدم
@freezed
class ProgressStats with _$ProgressStats {
  const factory ProgressStats({
    /// عدد الدروس المكتملة
    @Default(0) int totalLessonsCompleted,
    
    /// عدد الاختبارات المجتازة
    @Default(0) int totalQuizzesPassed,
    
    /// عدد الاختبارات بدرجة كاملة
    @Default(0) int perfectQuizzes,
    
    /// عدد المهام المكتملة
    @Default(0) int totalAssignmentsCompleted,
    
    /// عدد الوحدات المكتملة
    @Default(0) int totalModulesCompleted,
    
    /// عدد المنشورات
    @Default(0) int totalPosts,
    
    /// عدد التعليقات
    @Default(0) int totalComments,
    
    /// عدد التعليقات المفيدة
    @Default(0) int helpfulCommentsCount,
    
    /// متوسط درجات الاختبارات
    @Default(0.0) double averageQuizScore,
    
    /// أطول سلسلة دخول
    @Default(0) int longestStreak,
    
    /// إجمالي وقت التعلم (بالدقائق)
    @Default(0) int totalLearningMinutes,
  }) = _ProgressStats;

  factory ProgressStats.fromJson(Map<String, dynamic> json) =>
      _$ProgressStatsFromJson(json);
}
