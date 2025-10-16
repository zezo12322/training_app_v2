// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bigquery_export.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BigQueryExportImpl _$$BigQueryExportImplFromJson(Map<String, dynamic> json) =>
    _$BigQueryExportImpl(
      id: json['id'] as String,
      institutionId: json['institutionId'] as String,
      companyId: json['companyId'] as String?,
      exportType: $enumDecode(_$ExportTypeEnumMap, json['exportType']),
      status: $enumDecode(_$ExportStatusEnumMap, json['status']),
      frequency: $enumDecode(_$ExportFrequencyEnumMap, json['frequency']),
      projectId: json['projectId'] as String,
      datasetId: json['datasetId'] as String,
      tableId: json['tableId'] as String,
      totalRecords: (json['totalRecords'] as num).toInt(),
      exportedRecords: (json['exportedRecords'] as num).toInt(),
      failedRecords: (json['failedRecords'] as num).toInt(),
      errors:
          (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      triggeredBy: json['triggeredBy'] as String,
      triggeredByName: json['triggeredByName'] as String,
      startedAt: const RequiredTimestampConverter().fromJson(
        json['startedAt'] as Object,
      ),
      completedAt: const TimestampConverter().fromJson(json['completedAt']),
      cronExpression: json['cronExpression'] as String?,
      nextRunAt: const TimestampConverter().fromJson(json['nextRunAt']),
      isEnabled: json['isEnabled'] as bool?,
    );

Map<String, dynamic> _$$BigQueryExportImplToJson(
  _$BigQueryExportImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'institutionId': instance.institutionId,
  'companyId': instance.companyId,
  'exportType': _$ExportTypeEnumMap[instance.exportType]!,
  'status': _$ExportStatusEnumMap[instance.status]!,
  'frequency': _$ExportFrequencyEnumMap[instance.frequency]!,
  'projectId': instance.projectId,
  'datasetId': instance.datasetId,
  'tableId': instance.tableId,
  'totalRecords': instance.totalRecords,
  'exportedRecords': instance.exportedRecords,
  'failedRecords': instance.failedRecords,
  'errors': instance.errors,
  'triggeredBy': instance.triggeredBy,
  'triggeredByName': instance.triggeredByName,
  'startedAt': const RequiredTimestampConverter().toJson(instance.startedAt),
  'completedAt': const TimestampConverter().toJson(instance.completedAt),
  'cronExpression': instance.cronExpression,
  'nextRunAt': const TimestampConverter().toJson(instance.nextRunAt),
  'isEnabled': instance.isEnabled,
};

const _$ExportTypeEnumMap = {
  ExportType.users: 'users',
  ExportType.courses: 'courses',
  ExportType.enrollments: 'enrollments',
  ExportType.progress: 'progress',
  ExportType.quizResults: 'quizResults',
  ExportType.certificates: 'certificates',
  ExportType.analytics: 'analytics',
  ExportType.gamification: 'gamification',
  ExportType.all: 'all',
};

const _$ExportStatusEnumMap = {
  ExportStatus.pending: 'pending',
  ExportStatus.processing: 'processing',
  ExportStatus.uploading: 'uploading',
  ExportStatus.completed: 'completed',
  ExportStatus.failed: 'failed',
};

const _$ExportFrequencyEnumMap = {
  ExportFrequency.manual: 'manual',
  ExportFrequency.daily: 'daily',
  ExportFrequency.weekly: 'weekly',
  ExportFrequency.monthly: 'monthly',
};

_$BigQueryConfigImpl _$$BigQueryConfigImplFromJson(Map<String, dynamic> json) =>
    _$BigQueryConfigImpl(
      id: json['id'] as String,
      institutionId: json['institutionId'] as String,
      companyId: json['companyId'] as String?,
      projectId: json['projectId'] as String,
      datasetId: json['datasetId'] as String,
      credentialsJson: json['credentialsJson'] as String,
      isEnabled: json['isEnabled'] as bool,
      enabledExports:
          (json['enabledExports'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ExportTypeEnumMap, e))
              .toList() ??
          const [],
      defaultFrequency: $enumDecodeNullable(
        _$ExportFrequencyEnumMap,
        json['defaultFrequency'],
      ),
      defaultCronExpression: json['defaultCronExpression'] as String?,
      createdAt: const RequiredTimestampConverter().fromJson(
        json['createdAt'] as Object,
      ),
      createdBy: json['createdBy'] as String,
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      updatedBy: json['updatedBy'] as String?,
    );

Map<String, dynamic> _$$BigQueryConfigImplToJson(
  _$BigQueryConfigImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'institutionId': instance.institutionId,
  'companyId': instance.companyId,
  'projectId': instance.projectId,
  'datasetId': instance.datasetId,
  'credentialsJson': instance.credentialsJson,
  'isEnabled': instance.isEnabled,
  'enabledExports': instance.enabledExports
      .map((e) => _$ExportTypeEnumMap[e]!)
      .toList(),
  'defaultFrequency': _$ExportFrequencyEnumMap[instance.defaultFrequency],
  'defaultCronExpression': instance.defaultCronExpression,
  'createdAt': const RequiredTimestampConverter().toJson(instance.createdAt),
  'createdBy': instance.createdBy,
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'updatedBy': instance.updatedBy,
};

_$ExportSchemaImpl _$$ExportSchemaImplFromJson(Map<String, dynamic> json) =>
    _$ExportSchemaImpl(
      exportType: $enumDecode(_$ExportTypeEnumMap, json['exportType']),
      tableName: json['tableName'] as String,
      description: json['description'] as String,
      fields: (json['fields'] as List<dynamic>)
          .map((e) => SchemaField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ExportSchemaImplToJson(_$ExportSchemaImpl instance) =>
    <String, dynamic>{
      'exportType': _$ExportTypeEnumMap[instance.exportType]!,
      'tableName': instance.tableName,
      'description': instance.description,
      'fields': instance.fields.map((e) => e.toJson()).toList(),
    };

_$SchemaFieldImpl _$$SchemaFieldImplFromJson(Map<String, dynamic> json) =>
    _$SchemaFieldImpl(
      name: json['name'] as String,
      type: json['type'] as String,
      mode: json['mode'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$SchemaFieldImplToJson(_$SchemaFieldImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'mode': instance.mode,
      'description': instance.description,
    };

_$ExportRecordImpl _$$ExportRecordImplFromJson(Map<String, dynamic> json) =>
    _$ExportRecordImpl(
      exportId: json['exportId'] as String,
      recordId: json['recordId'] as String,
      exportType: $enumDecode(_$ExportTypeEnumMap, json['exportType']),
      data: json['data'] as Map<String, dynamic>,
      exportedAt: const RequiredTimestampConverter().fromJson(
        json['exportedAt'] as Object,
      ),
      isSuccess: json['isSuccess'] as bool?,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$$ExportRecordImplToJson(
  _$ExportRecordImpl instance,
) => <String, dynamic>{
  'exportId': instance.exportId,
  'recordId': instance.recordId,
  'exportType': _$ExportTypeEnumMap[instance.exportType]!,
  'data': instance.data,
  'exportedAt': const RequiredTimestampConverter().toJson(instance.exportedAt),
  'isSuccess': instance.isSuccess,
  'errorMessage': instance.errorMessage,
};
