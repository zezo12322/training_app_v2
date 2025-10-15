import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'recommendation.freezed.dart';
part 'recommendation.g.dart';

/// نوع التوصية
enum RecommendationType {
  /// درس مقترح
  lesson,
  
  /// اختبار مقترح
  quiz,
  
  /// مهمة مقترحة
  assignment,
  
  /// وحدة مقترحة
  module,
  
  /// مراجعة محتوى سابق
  review,
  
  /// تحدي إضافي
  challenge,
}

/// سبب التوصية
enum RecommendationReason {
  /// بناءً على الأداء الضعيف
  weakPerformance,
  
  /// بناءً على الاهتمامات
  interests,
  
  /// الخطوة التالية المنطقية
  nextStep,
  
  /// فجوة في المهارات
  skillGap,
  
  /// محتوى شائع بين الأقران
  popularWithPeers,
  
  /// استكمال المسار التعليمي
  pathCompletion,
  
  /// تعزيز نقاط القوة
  strengthenSkill,
}

/// توصية محتوى تعليمي للمستخدم
@freezed
class Recommendation with _$Recommendation {
  const factory Recommendation({
    /// معرف التوصية
    required String id,
    
    /// معرف المستخدم
    required String userId,
    
    /// معرف الكورس
    required String courseId,
    
    /// نوع التوصية
    required RecommendationType type,
    
    /// سبب التوصية
    required RecommendationReason reason,
    
    /// معرف المحتوى الموصى به
    required String contentId,
    
    /// عنوان المحتوى
    required String contentTitle,
    
    /// وصف مختصر
    @Default('') String description,
    
    /// درجة الأولوية (0-100)
    /// كلما زادت الدرجة، كانت التوصية أهم
    @Default(50) int priority,
    
    /// درجة الثقة (0-1)
    /// مدى ثقة النظام في هذه التوصية
    @Default(0.5) double confidence,
    
    /// الوقت المتوقع للإتمام (بالدقائق)
    int? estimatedMinutes,
    
    /// الصعوبة المتوقعة
    @Default('متوسط') String difficulty,
    
    /// هل تم مشاهدة التوصية
    @Default(false) bool isViewed,
    
    /// هل تم قبول التوصية (تم فتح المحتوى)
    @Default(false) bool isAccepted,
    
    /// هل تم رفض التوصية
    @Default(false) bool isDismissed,
    
    /// هل تم إتمام المحتوى
    @Default(false) bool isCompleted,
    
    /// تاريخ الإنشاء
    @TimestampConverter() required DateTime createdAt,
    
    /// تاريخ انتهاء الصلاحية (optional)
    @TimestampConverter() DateTime? expiresAt,
    
    /// تاريخ المشاهدة
    @TimestampConverter() DateTime? viewedAt,
    
    /// تاريخ القبول
    @TimestampConverter() DateTime? acceptedAt,
    
    /// البيانات الإضافية (metadata)
    @Default({}) Map<String, dynamic> metadata,
  }) = _Recommendation;

  factory Recommendation.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFromJson(json);
}

/// معايير التوصية المخصصة
@freezed
class RecommendationCriteria with _$RecommendationCriteria {
  const factory RecommendationCriteria({
    /// معرف المستخدم
    required String userId,
    
    /// معرف الكورس
    required String courseId,
    
    /// أنواع المحتوى المفضلة
    @Default([]) List<RecommendationType> preferredTypes,
    
    /// المهارات المستهدفة
    @Default([]) List<String> targetSkills,
    
    /// مستوى الصعوبة المفضل
    @Default('متوسط') String preferredDifficulty,
    
    /// الحد الأقصى للوقت المتاح (بالدقائق)
    int? maxTimeAvailable,
    
    /// عدد التوصيات المطلوبة
    @Default(5) int limit,
    
    /// استبعاد المحتوى المكتمل
    @Default(true) bool excludeCompleted,
    
    /// استبعاد المحتوى المرفوض
    @Default(true) bool excludeDismissed,
  }) = _RecommendationCriteria;

  factory RecommendationCriteria.fromJson(Map<String, dynamic> json) =>
      _$RecommendationCriteriaFromJson(json);
}

/// إحصائيات فعالية التوصيات
@freezed
class RecommendationStats with _$RecommendationStats {
  const factory RecommendationStats({
    /// عدد التوصيات الكلي
    @Default(0) int totalRecommendations,
    
    /// عدد التوصيات المشاهدة
    @Default(0) int viewedRecommendations,
    
    /// عدد التوصيات المقبولة
    @Default(0) int acceptedRecommendations,
    
    /// عدد التوصيات المرفوضة
    @Default(0) int dismissedRecommendations,
    
    /// عدد التوصيات المكتملة
    @Default(0) int completedRecommendations,
    
    /// نسبة القبول (0-1)
    @Default(0.0) double acceptanceRate,
    
    /// نسبة الإتمام (0-1)
    @Default(0.0) double completionRate,
    
    /// متوسط وقت القبول (بالساعات)
    @Default(0.0) double avgTimeToAccept,
    
    /// متوسط درجة الثقة
    @Default(0.5) double avgConfidence,
  }) = _RecommendationStats;

  factory RecommendationStats.fromJson(Map<String, dynamic> json) =>
      _$RecommendationStatsFromJson(json);
}
