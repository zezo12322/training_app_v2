import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/timestamp_converter.dart';

part 'points_transaction.freezed.dart';
part 'points_transaction.g.dart';

/// سجل معاملة نقاط
/// 
/// يسجل كل مرة يكسب فيها المستخدم نقاطاً
/// لعرضها في سجل النقاط والتحليلات
@freezed
class PointsTransaction with _$PointsTransaction {
  const factory PointsTransaction({
    /// معرف المعاملة
    String? id,
    
    /// معرف المستخدم
    required String userId,
    
    /// معرف الكورس
    required String courseId,
    
    /// عدد النقاط المكتسبة
    required int points,
    
    /// نوع النشاط
    required String activityType,
    
    /// اسم النشاط (للعرض)
    required String activityName,
    
    /// بيانات إضافية
    @Default({}) Map<String, dynamic> metadata,
    
    /// تاريخ المعاملة
    @TimestampConverter() required DateTime timestamp,
  }) = _PointsTransaction;

  factory PointsTransaction.fromJson(Map<String, dynamic> json) =>
      _$PointsTransactionFromJson(json);
      
  /// إنشاء transaction جديدة
  factory PointsTransaction.create({
    required String userId,
    required String courseId,
    required int points,
    required String activityType,
    required String activityName,
    Map<String, dynamic>? metadata,
  }) {
    return PointsTransaction(
      userId: userId,
      courseId: courseId,
      points: points,
      activityType: activityType,
      activityName: activityName,
      metadata: metadata ?? {},
      timestamp: DateTime.now(),
    );
  }
}

/// أنواع الأنشطة
class ActivityType {
  // Core Activities
  static const String completingLesson = 'completing_lesson';
  static const String passingQuiz = 'passing_quiz';
  static const String perfectQuiz = 'perfect_quiz';
  static const String completingAssignment = 'completing_assignment';
  static const String completingModule = 'completing_module';
  
  // Social Activities
  static const String creatingPost = 'creating_post';
  static const String commenting = 'commenting';
  static const String helpfulComment = 'helpful_comment';
  static const String receivingReaction = 'receiving_reaction';
  
  // Streak Activities
  static const String dailyStreak = 'daily_streak';
  static const String weeklyStreak = 'weekly_streak';
  
  /// الحصول على اسم النشاط بالعربية
  static String getActivityName(String type) {
    switch (type) {
      case completingLesson:
        return 'إتمام درس';
      case passingQuiz:
        return 'اجتياز اختبار';
      case perfectQuiz:
        return 'درجة كاملة في اختبار';
      case completingAssignment:
        return 'إتمام مهمة';
      case completingModule:
        return 'إتمام وحدة';
      case creatingPost:
        return 'إنشاء منشور';
      case commenting:
        return 'تعليق';
      case helpfulComment:
        return 'مساعدة زميل';
      case receivingReaction:
        return 'الحصول على reaction';
      case dailyStreak:
        return 'دخول يومي';
      case weeklyStreak:
        return 'أسبوع متواصل';
      default:
        return 'نشاط غير معروف';
    }
  }
}
