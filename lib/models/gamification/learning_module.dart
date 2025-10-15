import 'package:freezed_annotation/freezed_annotation.dart';

part 'learning_module.freezed.dart';
part 'learning_module.g.dart';

/// وحدة تعليمية (Module) داخل الكورس
/// 
/// تحتوي على مجموعة من الدروس والاختبارات والمهام
/// المتدرب يحصل على نقاط عند إتمام كل الوحدة
@freezed
class LearningModule with _$LearningModule {
  const factory LearningModule({
    /// معرف الوحدة
    String? id,
    
    /// معرف الكورس
    required String courseId,
    
    /// عنوان الوحدة
    required String title,
    
    /// وصف الوحدة
    @Default('') String description,
    
    /// ترتيب الوحدة في الكورس
    required int orderIndex,
    
    /// محتويات الوحدة
    @Default([]) List<ModuleContent> contents,
    
    /// متطلبات إتمام الوحدة
    required ModuleRequirements requirements,
    
    /// نقاط إتمام الوحدة
    @Default(100) int completionPoints,
    
    /// هل الوحدة نشطة
    @Default(true) bool isActive,
  }) = _LearningModule;

  factory LearningModule.fromJson(Map<String, dynamic> json) =>
      _$LearningModuleFromJson(json);
}

/// محتوى داخل الوحدة (درس، اختبار، مهمة)
@freezed
class ModuleContent with _$ModuleContent {
  const factory ModuleContent({
    /// معرف المحتوى
    required String id,
    
    /// نوع المحتوى
    required ModuleContentType type,
    
    /// العنوان
    required String title,
    
    /// الترتيب داخل الوحدة
    required int orderIndex,
    
    /// هل المحتوى إجباري
    @Default(true) bool isRequired,
    
    /// هل تم إتمامه
    @Default(false) bool isCompleted,
  }) = _ModuleContent;

  factory ModuleContent.fromJson(Map<String, dynamic> json) =>
      _$ModuleContentFromJson(json);
}

/// متطلبات إتمام الوحدة
@freezed
class ModuleRequirements with _$ModuleRequirements {
  const factory ModuleRequirements({
    /// إتمام كل الدروس الإجبارية
    @Default(true) bool completeLessons,
    
    /// اجتياز كل الاختبارات
    @Default(true) bool passAllQuizzes,
    
    /// النسبة المئوية المطلوبة في الاختبارات
    @Default(70) int minimumQuizScore,
    
    /// إتمام المهام الإجبارية
    @Default(true) bool completeAssignments,
  }) = _ModuleRequirements;

  factory ModuleRequirements.fromJson(Map<String, dynamic> json) =>
      _$ModuleRequirementsFromJson(json);
}

/// أنواع المحتوى في الوحدة
enum ModuleContentType {
  /// درس
  lesson,
  
  /// اختبار
  quiz,
  
  /// مهمة/تكليف
  assignment,
  
  /// مادة تعليمية (فيديو، ملف، إلخ)
  resource,
}
