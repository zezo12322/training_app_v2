import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'bigquery_export.freezed.dart';
part 'bigquery_export.g.dart';

/// نوع التصدير
enum ExportType {
  users,           // بيانات المستخدمين
  courses,         // بيانات الدورات
  enrollments,     // التسجيلات
  progress,        // التقدم
  quizResults,     // نتائج الاختبارات
  certificates,    // الشهادات
  analytics,       // التحليلات
  gamification,    // نقاط وإنجازات
  all,             // جميع البيانات
}

/// حالة التصدير
enum ExportStatus {
  pending,         // في الانتظار
  processing,      // قيد المعالجة
  uploading,       // جاري الرفع
  completed,       // مكتمل
  failed,          // فشل
}

/// تكرار التصدير
enum ExportFrequency {
  manual,          // يدوي
  daily,           // يومي
  weekly,          // أسبوعي
  monthly,         // شهري
}

/// عملية تصدير BigQuery
@freezed
class BigQueryExport with _$BigQueryExport {
  const factory BigQueryExport({
    required String id,
    required String institutionId,
    String? companyId,
    
    /// معلومات التصدير
    required ExportType exportType,
    required ExportStatus status,
    required ExportFrequency frequency,
    
    /// معلومات BigQuery
    required String projectId,
    required String datasetId,
    required String tableId,
    
    /// الإحصائيات
    required int totalRecords,
    required int exportedRecords,
    required int failedRecords,
    
    /// الأخطاء
    @Default([]) List<String> errors,
    
    /// معلومات التنفيذ
    required String triggeredBy,
    required String triggeredByName,
    @TimestampConverter() required DateTime startedAt,
    @TimestampConverter() DateTime? completedAt,
    
    /// الجدولة
    String? cronExpression,
    @TimestampConverter() DateTime? nextRunAt,
    bool? isEnabled,
  }) = _BigQueryExport;

  factory BigQueryExport.fromJson(Map<String, dynamic> json) =>
      _$BigQueryExportFromJson(json);
}

/// إعدادات BigQuery
@freezed
class BigQueryConfig with _$BigQueryConfig {
  const factory BigQueryConfig({
    required String id,
    required String institutionId,
    String? companyId,
    
    /// بيانات الاتصال
    required String projectId,
    required String datasetId,
    required String credentialsJson,
    
    /// الإعدادات
    required bool isEnabled,
    @Default([]) List<ExportType> enabledExports,
    
    /// الجدولة الافتراضية
    ExportFrequency? defaultFrequency,
    String? defaultCronExpression,
    
    /// معلومات الإنشاء
    @TimestampConverter() required DateTime createdAt,
    required String createdBy,
    @TimestampConverter() DateTime? updatedAt,
    String? updatedBy,
  }) = _BigQueryConfig;

  factory BigQueryConfig.fromJson(Map<String, dynamic> json) =>
      _$BigQueryConfigFromJson(json);
}

/// مخطط بيانات التصدير
@freezed
class ExportSchema with _$ExportSchema {
  const factory ExportSchema({
    required ExportType exportType,
    required String tableName,
    required String description,
    required List<SchemaField> fields,
  }) = _ExportSchema;

  factory ExportSchema.fromJson(Map<String, dynamic> json) =>
      _$ExportSchemaFromJson(json);
}

/// حقل في مخطط البيانات
@freezed
class SchemaField with _$SchemaField {
  const factory SchemaField({
    required String name,
    required String type,      // STRING, INTEGER, FLOAT, BOOLEAN, TIMESTAMP, etc.
    required String mode,      // REQUIRED, NULLABLE, REPEATED
    String? description,
  }) = _SchemaField;

  factory SchemaField.fromJson(Map<String, dynamic> json) =>
      _$SchemaFieldFromJson(json);
}

/// سجل بيانات مُصدّر
@freezed
class ExportRecord with _$ExportRecord {
  const factory ExportRecord({
    required String exportId,
    required String recordId,
    required ExportType exportType,
    required Map<String, dynamic> data,
    @TimestampConverter() required DateTime exportedAt,
    bool? isSuccess,
    String? errorMessage,
  }) = _ExportRecord;

  factory ExportRecord.fromJson(Map<String, dynamic> json) =>
      _$ExportRecordFromJson(json);
}

/// مخططات البيانات المحددة مسبقاً
class BigQuerySchemas {
  /// مخطط بيانات المستخدمين
  static ExportSchema get usersSchema => const ExportSchema(
    exportType: ExportType.users,
    tableName: 'users',
    description: 'User account information',
    fields: [
      SchemaField(name: 'user_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'email', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'name', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'role', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'institution_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'company_id', type: 'STRING', mode: 'NULLABLE'),
      SchemaField(name: 'created_at', type: 'TIMESTAMP', mode: 'REQUIRED'),
      SchemaField(name: 'last_login_at', type: 'TIMESTAMP', mode: 'NULLABLE'),
    ],
  );

  /// مخطط بيانات الدورات
  static ExportSchema get coursesSchema => const ExportSchema(
    exportType: ExportType.courses,
    tableName: 'courses',
    description: 'Course information',
    fields: [
      SchemaField(name: 'course_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'title', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'description', type: 'STRING', mode: 'NULLABLE'),
      SchemaField(name: 'category', type: 'STRING', mode: 'NULLABLE'),
      SchemaField(name: 'level', type: 'STRING', mode: 'NULLABLE'),
      SchemaField(name: 'duration_hours', type: 'FLOAT', mode: 'NULLABLE'),
      SchemaField(name: 'instructor_id', type: 'STRING', mode: 'NULLABLE'),
      SchemaField(name: 'institution_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'created_at', type: 'TIMESTAMP', mode: 'REQUIRED'),
    ],
  );

  /// مخطط بيانات التسجيلات
  static ExportSchema get enrollmentsSchema => const ExportSchema(
    exportType: ExportType.enrollments,
    tableName: 'enrollments',
    description: 'User course enrollments',
    fields: [
      SchemaField(name: 'enrollment_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'user_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'course_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'enrolled_at', type: 'TIMESTAMP', mode: 'REQUIRED'),
      SchemaField(name: 'completed_at', type: 'TIMESTAMP', mode: 'NULLABLE'),
      SchemaField(name: 'progress_percentage', type: 'FLOAT', mode: 'NULLABLE'),
      SchemaField(name: 'status', type: 'STRING', mode: 'REQUIRED'),
    ],
  );

  /// مخطط بيانات نتائج الاختبارات
  static ExportSchema get quizResultsSchema => const ExportSchema(
    exportType: ExportType.quizResults,
    tableName: 'quiz_results',
    description: 'Quiz attempt results',
    fields: [
      SchemaField(name: 'result_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'user_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'quiz_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'course_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'score', type: 'FLOAT', mode: 'REQUIRED'),
      SchemaField(name: 'max_score', type: 'FLOAT', mode: 'REQUIRED'),
      SchemaField(name: 'percentage', type: 'FLOAT', mode: 'REQUIRED'),
      SchemaField(name: 'passed', type: 'BOOLEAN', mode: 'REQUIRED'),
      SchemaField(name: 'completed_at', type: 'TIMESTAMP', mode: 'REQUIRED'),
      SchemaField(name: 'time_spent_seconds', type: 'INTEGER', mode: 'NULLABLE'),
    ],
  );

  /// مخطط بيانات الشهادات
  static ExportSchema get certificatesSchema => const ExportSchema(
    exportType: ExportType.certificates,
    tableName: 'certificates',
    description: 'Issued certificates',
    fields: [
      SchemaField(name: 'certificate_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'user_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'course_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'certificate_number', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'issued_at', type: 'TIMESTAMP', mode: 'REQUIRED'),
      SchemaField(name: 'verification_code', type: 'STRING', mode: 'REQUIRED'),
    ],
  );

  /// مخطط بيانات النقاط والإنجازات
  static ExportSchema get gamificationSchema => const ExportSchema(
    exportType: ExportType.gamification,
    tableName: 'gamification',
    description: 'Points and achievements data',
    fields: [
      SchemaField(name: 'record_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'user_id', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'event_type', type: 'STRING', mode: 'REQUIRED'),
      SchemaField(name: 'points_earned', type: 'INTEGER', mode: 'NULLABLE'),
      SchemaField(name: 'total_points', type: 'INTEGER', mode: 'NULLABLE'),
      SchemaField(name: 'achievement_id', type: 'STRING', mode: 'NULLABLE'),
      SchemaField(name: 'occurred_at', type: 'TIMESTAMP', mode: 'REQUIRED'),
    ],
  );

  /// الحصول على جميع المخططات
  static List<ExportSchema> get allSchemas => [
    usersSchema,
    coursesSchema,
    enrollmentsSchema,
    quizResultsSchema,
    certificatesSchema,
    gamificationSchema,
  ];

  /// الحصول على مخطط حسب النوع
  static ExportSchema? getSchema(ExportType type) {
    switch (type) {
      case ExportType.users:
        return usersSchema;
      case ExportType.courses:
        return coursesSchema;
      case ExportType.enrollments:
        return enrollmentsSchema;
      case ExportType.quizResults:
        return quizResultsSchema;
      case ExportType.certificates:
        return certificatesSchema;
      case ExportType.gamification:
        return gamificationSchema;
      default:
        return null;
    }
  }
}
