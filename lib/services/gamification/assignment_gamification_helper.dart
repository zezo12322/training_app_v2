import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/gamification/points_transaction.dart';
import '../../providers/gamification/gamification_providers.dart';

/// Helper لمنح نقاط عند تسليم assignments
/// 
/// هذا placeholder للمستقبل - عندما يتم تطوير Assignment system
/// يمكن استخدام هذا الكلاس مباشرة
class AssignmentGamificationHelper {
  final Ref _ref;
  
  AssignmentGamificationHelper(this._ref);
  
  /// منح نقاط عند تسليم assignment
  /// 
  /// [userId] - معرف المستخدم
  /// [courseId] - معرف الكورس
  /// [assignmentId] - معرف المهمة
  /// [assignmentTitle] - عنوان المهمة (اختياري)
  /// [grade] - الدرجة المستلمة (اختياري)
  /// 
  /// Returns: النقاط الممنوحة فعلياً
  Future<int> awardSubmissionPoints({
    required String userId,
    required String courseId,
    required String assignmentId,
    String? assignmentTitle,
    int? grade,
  }) async {
    final gamificationService = _ref.read(gamificationServiceProvider);
    
    // Award base points for submission
    final basePoints = await gamificationService.awardPoints(
      userId: userId,
      courseId: courseId,
      activityType: ActivityType.completingAssignment,
      activityName: 'تسليم مهمة${assignmentTitle != null ? ": $assignmentTitle" : ""}',
      metadata: {
        'assignmentId': assignmentId,
        if (grade != null) 'grade': grade,
      },
    );
    
    var totalPoints = basePoints;
    
    // Award bonus points for excellent grades (95% or higher)
    if (grade != null && grade >= 95) {
      final bonusAwarded = await gamificationService.awardPoints(
        userId: userId,
        courseId: courseId,
        activityType: ActivityType.completingAssignment,
        activityName: 'مكافأة تميز في المهمة',
        metadata: {
          'assignmentId': assignmentId,
          'grade': grade,
          'bonus': true,
          'bonusPercentage': 50,
        },
      );
      
      totalPoints += bonusAwarded;
    }
    
    return totalPoints;
  }
  
  /// منح نقاط عند مراجعة assignment من المدرب
  /// 
  /// يمكن استخدامها لمنح نقاط إضافية بناءً على الملاحظات
  Future<int> awardReviewBonus({
    required String userId,
    required String courseId,
    required String assignmentId,
    required int grade,
    String? feedback,
  }) async {
    // Only award bonus for grades above 90%
    if (grade < 90) return 0;
    
    final gamificationService = _ref.read(gamificationServiceProvider);
    
    // Calculate bonus based on grade range
    int bonusPercentage;
    if (grade >= 98) {
      bonusPercentage = 100; // Double points for near-perfect work
    } else if (grade >= 95) {
      bonusPercentage = 50;
    } else {
      bonusPercentage = 25;
    }
    
    // Get base points for assignment
    final settings = await _ref.read(gamificationRepositoryProvider)
        .getSettings(courseId);
    final basePoints = settings?.activityPoints.completingAssignment ?? 30;
    
    final bonusPoints = (basePoints * (bonusPercentage / 100)).round();
    
    return await gamificationService.awardPoints(
      userId: userId,
      courseId: courseId,
      activityType: ActivityType.completingAssignment,
      activityName: 'مكافأة أداء متميز',
      metadata: {
        'assignmentId': assignmentId,
        'grade': grade,
        'bonusPercentage': bonusPercentage,
        'bonusPoints': bonusPoints,
        if (feedback != null) 'feedback': feedback,
      },
    );
  }
}

// Provider
final assignmentGamificationHelperProvider = Provider<AssignmentGamificationHelper>((ref) {
  return AssignmentGamificationHelper(ref);
});
