import '../models/gamification/activity_points.dart';
import '../models/gamification/points_transaction.dart';

/// حاسبة النقاط
/// 
/// تحسب عدد النقاط المستحقة لكل نشاط
class PointsCalculator {
  /// حساب النقاط بناءً على نوع النشاط
  int calculatePoints({
    required String activityType,
    required ActivityPoints activityPoints,
    Map<String, dynamic>? metadata,
  }) {
    switch (activityType) {
      // Core Activities (دائماً مفعلة)
      case ActivityType.completingLesson:
        return activityPoints.completingLesson;
        
      case ActivityType.passingQuiz:
        return activityPoints.passingQuiz;
        
      case ActivityType.perfectQuiz:
        // التحقق من الدرجة الكاملة
        final score = metadata?['score'] as int?;
        if (score != null && score >= 100) {
          return activityPoints.perfectQuizScore;
        }
        return 0;
        
      case ActivityType.completingAssignment:
        return activityPoints.completingAssignment;
        
      case ActivityType.completingModule:
        return activityPoints.completingModule;

      // Social Activities (اختيارية - بناءً على enableSocialPoints)
      case ActivityType.creatingPost:
        return activityPoints.enableSocialPoints 
            ? activityPoints.creatingPost 
            : 0;
            
      case ActivityType.commenting:
        return activityPoints.enableSocialPoints 
            ? activityPoints.commentingOnPost 
            : 0;
            
      case ActivityType.helpfulComment:
        return activityPoints.enableSocialPoints 
            ? activityPoints.helpingPeer 
            : 0;
            
      case ActivityType.receivingReaction:
        return activityPoints.enableSocialPoints 
            ? activityPoints.receivingReaction 
            : 0;

      // Streak Activities (اختيارية - بناءً على enableDailyStreak)
      case ActivityType.dailyStreak:
        return activityPoints.enableDailyStreak 
            ? activityPoints.dailyStreak 
            : 0;
            
      case ActivityType.weeklyStreak:
        return activityPoints.enableDailyStreak 
            ? activityPoints.weeklyStreak 
            : 0;

      default:
        return 0;
    }
  }

  /// حساب نقاط إضافية بناءً على جودة الأداء
  int calculateBonusPoints({
    required String activityType,
    required Map<String, dynamic> metadata,
  }) {
    if (activityType == ActivityType.passingQuiz) {
      final score = metadata['score'] as int?;
      if (score == null) return 0;
      
      // منح نقاط إضافية للدرجات العالية
      if (score >= 95) {
        return 10; // ممتاز جداً
      } else if (score >= 90) {
        return 5; // ممتاز
      } else if (score >= 85) {
        return 2; // جيد جداً
      }
    }
    
    return 0;
  }

  /// حساب النقاط الكلية لإتمام وحدة
  int calculateModuleCompletionPoints({
    required int basePoints,
    required int lessonsCompleted,
    required int quizzesPassed,
    required double averageQuizScore,
  }) {
    var totalPoints = basePoints;
    
    // مكافأة على الأداء الجيد
    if (averageQuizScore >= 90) {
      totalPoints = (totalPoints * 1.2).round(); // +20%
    } else if (averageQuizScore >= 80) {
      totalPoints = (totalPoints * 1.1).round(); // +10%
    }
    
    return totalPoints;
  }

  /// حساب النقاط اليومية المحتملة
  /// (للعرض في الواجهة - كم ممكن تكسب اليوم)
  int calculateDailyPotential({
    required ActivityPoints activityPoints,
    required int lessonsAvailable,
    required int quizzesAvailable,
  }) {
    var potential = 0;
    
    // الدروس
    potential += lessonsAvailable * activityPoints.completingLesson;
    
    // الاختبارات
    potential += quizzesAvailable * activityPoints.passingQuiz;
    
    // Daily Streak
    if (activityPoints.enableDailyStreak) {
      potential += activityPoints.dailyStreak;
    }
    
    // التفاعل الاجتماعي
    if (activityPoints.enableSocialPoints) {
      potential += activityPoints.creatingPost * 2; // افترض منشورين
      potential += activityPoints.commentingOnPost * 3; // 3 تعليقات
    }
    
    return potential;
  }
}
