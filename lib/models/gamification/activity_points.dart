import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_points.freezed.dart';
part 'activity_points.g.dart';

/// نظام النقاط للأنشطة المختلفة في الكورس
/// 
/// يسمح للمدرب بتخصيص النقاط لكل نشاط
/// مع إمكانية تفعيل/تعطيل الأنشطة الاختيارية
@freezed
class ActivityPoints with _$ActivityPoints {
  const factory ActivityPoints({
    // ⭐ الأساسيات (Core) - إلزامية
    /// نقاط إتمام درس واحد
    @Default(10) int completingLesson,
    
    /// نقاط اجتياز اختبار (70% أو أكثر)
    @Default(20) int passingQuiz,
    
    /// نقاط الحصول على درجة كاملة في اختبار
    @Default(50) int perfectQuizScore,
    
    /// نقاط إتمام مهمة/تكليف
    @Default(30) int completingAssignment,
    
    /// نقاط إتمام وحدة تعليمية كاملة
    @Default(100) int completingModule,
    
    // 🎮 التفاعل الاجتماعي (Social) - اختياري
    /// نقاط إنشاء منشور في حائط الكورس
    @Default(5) int creatingPost,
    
    /// نقاط التعليق على منشور
    @Default(2) int commentingOnPost,
    
    /// نقاط مساعدة زميل (رد مفيد)
    @Default(15) int helpingPeer,
    
    /// نقاط الحصول على reaction
    @Default(1) int receivingReaction,
    
    // 🔥 Daily Streak - اختياري
    /// نقاط الدخول اليومي المتواصل
    @Default(5) int dailyStreak,
    
    /// مكافأة الأسبوع المتواصل (7 أيام)
    @Default(50) int weeklyStreak,
    
    // ⚙️ الإعدادات
    /// تفعيل نقاط التفاعل الاجتماعي
    @Default(false) bool enableSocialPoints,
    
    /// تفعيل نقاط الدخول اليومي
    @Default(false) bool enableDailyStreak,
  }) = _ActivityPoints;

  factory ActivityPoints.fromJson(Map<String, dynamic> json) =>
      _$ActivityPointsFromJson(json);
      
  /// الإعدادات الافتراضية
  factory ActivityPoints.defaultSettings() => const ActivityPoints();
}
