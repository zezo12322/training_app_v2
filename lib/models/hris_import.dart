import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'hris_import.freezed.dart';
part 'hris_import.g.dart';

/// نوع ملف الاستيراد
enum ImportFileType {
  csv,
  excel,
}

/// حالة عملية الاستيراد
enum ImportStatus {
  pending,
  processing,
  completed,
  failed,
  partialSuccess,
}

/// عملية استيراد HRIS
@freezed
class HRISImport with _$HRISImport {
  const factory HRISImport({
    required String id,
    required String institutionId,
    String? companyId,
    
    /// معلومات الملف
    required ImportFileType fileType,
    required String fileName,
    required int totalRows,
    
    /// الحالة
    required ImportStatus status,
    @Default(0) int processedRows,
    @Default(0) int successfulRows,
    @Default(0) int failedRows,
    
    /// تفاصيل الأخطاء
    @Default([]) List<String> errors,
    @Default({}) Map<String, dynamic> errorDetails,
    
    /// معلومات المستخدم الذي قام بالاستيراد
    required String uploadedBy,
    required String uploaderName,
    @TimestampConverter() required DateTime uploadedAt,
    @TimestampConverter() DateTime? completedAt,
    
    /// إعدادات ال Mapping
    required FieldMapping fieldMapping,
    
    /// خيارات الاستيراد
    @Default(true) bool updateExistingUsers,
    @Default(false) bool skipInvalidRows,
    String? defaultRole,
    String? defaultPassword,
  }) = _HRISImport;

  factory HRISImport.fromJson(Map<String, dynamic> json) =>
      _$HRISImportFromJson(json);
}

/// ربط الحقول
@freezed
class FieldMapping with _$FieldMapping {
  const factory FieldMapping({
    /// حقول إلزامية
    required String emailColumn,
    required String nameColumn,
    
    /// حقول اختيارية
    String? roleColumn,
    String? phoneColumn,
    String? departmentColumn,
    String? jobTitleColumn,
    String? employeeIdColumn,
    String? managerEmailColumn,
    
    /// حقول مخصصة
    @Default({}) Map<String, String> customFields,
  }) = _FieldMapping;

  factory FieldMapping.fromJson(Map<String, dynamic> json) =>
      _$FieldMappingFromJson(json);
}

/// سجل مستخدم مستورد
@freezed
class ImportedUserRecord with _$ImportedUserRecord {
  const factory ImportedUserRecord({
    required int rowNumber,
    required String email,
    required String name,
    
    /// بيانات إضافية
    String? role,
    String? phone,
    String? department,
    String? jobTitle,
    String? employeeId,
    String? managerEmail,
    
    /// حقول مخصصة
    @Default({}) Map<String, dynamic> customData,
    
    /// حالة الاستيراد
    @Default(false) bool isValid,
    @Default([]) List<String> validationErrors,
    @Default(false) bool isProcessed,
    @Default(false) bool isSuccess,
    String? userId,
    String? errorMessage,
  }) = _ImportedUserRecord;

  factory ImportedUserRecord.fromJson(Map<String, dynamic> json) =>
      _$ImportedUserRecordFromJson(json);
}

/// قالب استيراد (template)
@freezed
class ImportTemplate with _$ImportTemplate {
  const factory ImportTemplate({
    required String id,
    required String name,
    String? description,
    required FieldMapping fieldMapping,
    required String institutionId,
    String? companyId,
    @TimestampConverter() required DateTime createdAt,
    required String createdBy,
  }) = _ImportTemplate;

  factory ImportTemplate.fromJson(Map<String, dynamic> json) =>
      _$ImportTemplateFromJson(json);
}
