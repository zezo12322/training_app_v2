// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hris_import.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HRISImportImpl _$$HRISImportImplFromJson(Map<String, dynamic> json) =>
    _$HRISImportImpl(
      id: json['id'] as String,
      institutionId: json['institutionId'] as String,
      companyId: json['companyId'] as String?,
      fileType: $enumDecode(_$ImportFileTypeEnumMap, json['fileType']),
      fileName: json['fileName'] as String,
      totalRows: (json['totalRows'] as num).toInt(),
      status: $enumDecode(_$ImportStatusEnumMap, json['status']),
      processedRows: (json['processedRows'] as num?)?.toInt() ?? 0,
      successfulRows: (json['successfulRows'] as num?)?.toInt() ?? 0,
      failedRows: (json['failedRows'] as num?)?.toInt() ?? 0,
      errors:
          (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      errorDetails: json['errorDetails'] as Map<String, dynamic>? ?? const {},
      uploadedBy: json['uploadedBy'] as String,
      uploaderName: json['uploaderName'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      completedAt: const TimestampConverter().fromJson(json['completedAt']),
      fieldMapping: FieldMapping.fromJson(
        json['fieldMapping'] as Map<String, dynamic>,
      ),
      updateExistingUsers: json['updateExistingUsers'] as bool? ?? true,
      skipInvalidRows: json['skipInvalidRows'] as bool? ?? false,
      defaultRole: json['defaultRole'] as String?,
      defaultPassword: json['defaultPassword'] as String?,
    );

Map<String, dynamic> _$$HRISImportImplToJson(_$HRISImportImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'institutionId': instance.institutionId,
      'companyId': instance.companyId,
      'fileType': _$ImportFileTypeEnumMap[instance.fileType]!,
      'fileName': instance.fileName,
      'totalRows': instance.totalRows,
      'status': _$ImportStatusEnumMap[instance.status]!,
      'processedRows': instance.processedRows,
      'successfulRows': instance.successfulRows,
      'failedRows': instance.failedRows,
      'errors': instance.errors,
      'errorDetails': instance.errorDetails,
      'uploadedBy': instance.uploadedBy,
      'uploaderName': instance.uploaderName,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
      'completedAt': const TimestampConverter().toJson(instance.completedAt),
      'fieldMapping': instance.fieldMapping.toJson(),
      'updateExistingUsers': instance.updateExistingUsers,
      'skipInvalidRows': instance.skipInvalidRows,
      'defaultRole': instance.defaultRole,
      'defaultPassword': instance.defaultPassword,
    };

const _$ImportFileTypeEnumMap = {
  ImportFileType.csv: 'csv',
  ImportFileType.excel: 'excel',
};

const _$ImportStatusEnumMap = {
  ImportStatus.pending: 'pending',
  ImportStatus.processing: 'processing',
  ImportStatus.completed: 'completed',
  ImportStatus.failed: 'failed',
  ImportStatus.partialSuccess: 'partialSuccess',
};

_$FieldMappingImpl _$$FieldMappingImplFromJson(Map<String, dynamic> json) =>
    _$FieldMappingImpl(
      emailColumn: json['emailColumn'] as String,
      nameColumn: json['nameColumn'] as String,
      roleColumn: json['roleColumn'] as String?,
      phoneColumn: json['phoneColumn'] as String?,
      departmentColumn: json['departmentColumn'] as String?,
      jobTitleColumn: json['jobTitleColumn'] as String?,
      employeeIdColumn: json['employeeIdColumn'] as String?,
      managerEmailColumn: json['managerEmailColumn'] as String?,
      customFields:
          (json['customFields'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$$FieldMappingImplToJson(_$FieldMappingImpl instance) =>
    <String, dynamic>{
      'emailColumn': instance.emailColumn,
      'nameColumn': instance.nameColumn,
      'roleColumn': instance.roleColumn,
      'phoneColumn': instance.phoneColumn,
      'departmentColumn': instance.departmentColumn,
      'jobTitleColumn': instance.jobTitleColumn,
      'employeeIdColumn': instance.employeeIdColumn,
      'managerEmailColumn': instance.managerEmailColumn,
      'customFields': instance.customFields,
    };

_$ImportedUserRecordImpl _$$ImportedUserRecordImplFromJson(
  Map<String, dynamic> json,
) => _$ImportedUserRecordImpl(
  rowNumber: (json['rowNumber'] as num).toInt(),
  email: json['email'] as String,
  name: json['name'] as String,
  role: json['role'] as String?,
  phone: json['phone'] as String?,
  department: json['department'] as String?,
  jobTitle: json['jobTitle'] as String?,
  employeeId: json['employeeId'] as String?,
  managerEmail: json['managerEmail'] as String?,
  customData: json['customData'] as Map<String, dynamic>? ?? const {},
  isValid: json['isValid'] as bool? ?? false,
  validationErrors:
      (json['validationErrors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  isProcessed: json['isProcessed'] as bool? ?? false,
  isSuccess: json['isSuccess'] as bool? ?? false,
  userId: json['userId'] as String?,
  errorMessage: json['errorMessage'] as String?,
);

Map<String, dynamic> _$$ImportedUserRecordImplToJson(
  _$ImportedUserRecordImpl instance,
) => <String, dynamic>{
  'rowNumber': instance.rowNumber,
  'email': instance.email,
  'name': instance.name,
  'role': instance.role,
  'phone': instance.phone,
  'department': instance.department,
  'jobTitle': instance.jobTitle,
  'employeeId': instance.employeeId,
  'managerEmail': instance.managerEmail,
  'customData': instance.customData,
  'isValid': instance.isValid,
  'validationErrors': instance.validationErrors,
  'isProcessed': instance.isProcessed,
  'isSuccess': instance.isSuccess,
  'userId': instance.userId,
  'errorMessage': instance.errorMessage,
};

_$ImportTemplateImpl _$$ImportTemplateImplFromJson(Map<String, dynamic> json) =>
    _$ImportTemplateImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      fieldMapping: FieldMapping.fromJson(
        json['fieldMapping'] as Map<String, dynamic>,
      ),
      institutionId: json['institutionId'] as String,
      companyId: json['companyId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$$ImportTemplateImplToJson(
  _$ImportTemplateImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'fieldMapping': instance.fieldMapping.toJson(),
  'institutionId': instance.institutionId,
  'companyId': instance.companyId,
  'createdAt': instance.createdAt.toIso8601String(),
  'createdBy': instance.createdBy,
};
