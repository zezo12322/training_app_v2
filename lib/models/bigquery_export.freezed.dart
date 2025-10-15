// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bigquery_export.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BigQueryExport _$BigQueryExportFromJson(Map<String, dynamic> json) {
  return _BigQueryExport.fromJson(json);
}

/// @nodoc
mixin _$BigQueryExport {
  String get id => throw _privateConstructorUsedError;
  String get institutionId => throw _privateConstructorUsedError;
  String? get companyId => throw _privateConstructorUsedError;

  /// معلومات التصدير
  ExportType get exportType => throw _privateConstructorUsedError;
  ExportStatus get status => throw _privateConstructorUsedError;
  ExportFrequency get frequency => throw _privateConstructorUsedError;

  /// معلومات BigQuery
  String get projectId => throw _privateConstructorUsedError;
  String get datasetId => throw _privateConstructorUsedError;
  String get tableId => throw _privateConstructorUsedError;

  /// الإحصائيات
  int get totalRecords => throw _privateConstructorUsedError;
  int get exportedRecords => throw _privateConstructorUsedError;
  int get failedRecords => throw _privateConstructorUsedError;

  /// الأخطاء
  List<String> get errors => throw _privateConstructorUsedError;

  /// معلومات التنفيذ
  String get triggeredBy => throw _privateConstructorUsedError;
  String get triggeredByName => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get startedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// الجدولة
  String? get cronExpression => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get nextRunAt => throw _privateConstructorUsedError;
  bool? get isEnabled => throw _privateConstructorUsedError;

  /// Serializes this BigQueryExport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BigQueryExport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BigQueryExportCopyWith<BigQueryExport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BigQueryExportCopyWith<$Res> {
  factory $BigQueryExportCopyWith(
    BigQueryExport value,
    $Res Function(BigQueryExport) then,
  ) = _$BigQueryExportCopyWithImpl<$Res, BigQueryExport>;
  @useResult
  $Res call({
    String id,
    String institutionId,
    String? companyId,
    ExportType exportType,
    ExportStatus status,
    ExportFrequency frequency,
    String projectId,
    String datasetId,
    String tableId,
    int totalRecords,
    int exportedRecords,
    int failedRecords,
    List<String> errors,
    String triggeredBy,
    String triggeredByName,
    @TimestampConverter() DateTime startedAt,
    @TimestampConverter() DateTime? completedAt,
    String? cronExpression,
    @TimestampConverter() DateTime? nextRunAt,
    bool? isEnabled,
  });
}

/// @nodoc
class _$BigQueryExportCopyWithImpl<$Res, $Val extends BigQueryExport>
    implements $BigQueryExportCopyWith<$Res> {
  _$BigQueryExportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BigQueryExport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? exportType = null,
    Object? status = null,
    Object? frequency = null,
    Object? projectId = null,
    Object? datasetId = null,
    Object? tableId = null,
    Object? totalRecords = null,
    Object? exportedRecords = null,
    Object? failedRecords = null,
    Object? errors = null,
    Object? triggeredBy = null,
    Object? triggeredByName = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? cronExpression = freezed,
    Object? nextRunAt = freezed,
    Object? isEnabled = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: freezed == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String?,
            exportType: null == exportType
                ? _value.exportType
                : exportType // ignore: cast_nullable_to_non_nullable
                      as ExportType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ExportStatus,
            frequency: null == frequency
                ? _value.frequency
                : frequency // ignore: cast_nullable_to_non_nullable
                      as ExportFrequency,
            projectId: null == projectId
                ? _value.projectId
                : projectId // ignore: cast_nullable_to_non_nullable
                      as String,
            datasetId: null == datasetId
                ? _value.datasetId
                : datasetId // ignore: cast_nullable_to_non_nullable
                      as String,
            tableId: null == tableId
                ? _value.tableId
                : tableId // ignore: cast_nullable_to_non_nullable
                      as String,
            totalRecords: null == totalRecords
                ? _value.totalRecords
                : totalRecords // ignore: cast_nullable_to_non_nullable
                      as int,
            exportedRecords: null == exportedRecords
                ? _value.exportedRecords
                : exportedRecords // ignore: cast_nullable_to_non_nullable
                      as int,
            failedRecords: null == failedRecords
                ? _value.failedRecords
                : failedRecords // ignore: cast_nullable_to_non_nullable
                      as int,
            errors: null == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            triggeredBy: null == triggeredBy
                ? _value.triggeredBy
                : triggeredBy // ignore: cast_nullable_to_non_nullable
                      as String,
            triggeredByName: null == triggeredByName
                ? _value.triggeredByName
                : triggeredByName // ignore: cast_nullable_to_non_nullable
                      as String,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            cronExpression: freezed == cronExpression
                ? _value.cronExpression
                : cronExpression // ignore: cast_nullable_to_non_nullable
                      as String?,
            nextRunAt: freezed == nextRunAt
                ? _value.nextRunAt
                : nextRunAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isEnabled: freezed == isEnabled
                ? _value.isEnabled
                : isEnabled // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BigQueryExportImplCopyWith<$Res>
    implements $BigQueryExportCopyWith<$Res> {
  factory _$$BigQueryExportImplCopyWith(
    _$BigQueryExportImpl value,
    $Res Function(_$BigQueryExportImpl) then,
  ) = __$$BigQueryExportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String institutionId,
    String? companyId,
    ExportType exportType,
    ExportStatus status,
    ExportFrequency frequency,
    String projectId,
    String datasetId,
    String tableId,
    int totalRecords,
    int exportedRecords,
    int failedRecords,
    List<String> errors,
    String triggeredBy,
    String triggeredByName,
    @TimestampConverter() DateTime startedAt,
    @TimestampConverter() DateTime? completedAt,
    String? cronExpression,
    @TimestampConverter() DateTime? nextRunAt,
    bool? isEnabled,
  });
}

/// @nodoc
class __$$BigQueryExportImplCopyWithImpl<$Res>
    extends _$BigQueryExportCopyWithImpl<$Res, _$BigQueryExportImpl>
    implements _$$BigQueryExportImplCopyWith<$Res> {
  __$$BigQueryExportImplCopyWithImpl(
    _$BigQueryExportImpl _value,
    $Res Function(_$BigQueryExportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BigQueryExport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? exportType = null,
    Object? status = null,
    Object? frequency = null,
    Object? projectId = null,
    Object? datasetId = null,
    Object? tableId = null,
    Object? totalRecords = null,
    Object? exportedRecords = null,
    Object? failedRecords = null,
    Object? errors = null,
    Object? triggeredBy = null,
    Object? triggeredByName = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? cronExpression = freezed,
    Object? nextRunAt = freezed,
    Object? isEnabled = freezed,
  }) {
    return _then(
      _$BigQueryExportImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: freezed == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String?,
        exportType: null == exportType
            ? _value.exportType
            : exportType // ignore: cast_nullable_to_non_nullable
                  as ExportType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ExportStatus,
        frequency: null == frequency
            ? _value.frequency
            : frequency // ignore: cast_nullable_to_non_nullable
                  as ExportFrequency,
        projectId: null == projectId
            ? _value.projectId
            : projectId // ignore: cast_nullable_to_non_nullable
                  as String,
        datasetId: null == datasetId
            ? _value.datasetId
            : datasetId // ignore: cast_nullable_to_non_nullable
                  as String,
        tableId: null == tableId
            ? _value.tableId
            : tableId // ignore: cast_nullable_to_non_nullable
                  as String,
        totalRecords: null == totalRecords
            ? _value.totalRecords
            : totalRecords // ignore: cast_nullable_to_non_nullable
                  as int,
        exportedRecords: null == exportedRecords
            ? _value.exportedRecords
            : exportedRecords // ignore: cast_nullable_to_non_nullable
                  as int,
        failedRecords: null == failedRecords
            ? _value.failedRecords
            : failedRecords // ignore: cast_nullable_to_non_nullable
                  as int,
        errors: null == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        triggeredBy: null == triggeredBy
            ? _value.triggeredBy
            : triggeredBy // ignore: cast_nullable_to_non_nullable
                  as String,
        triggeredByName: null == triggeredByName
            ? _value.triggeredByName
            : triggeredByName // ignore: cast_nullable_to_non_nullable
                  as String,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cronExpression: freezed == cronExpression
            ? _value.cronExpression
            : cronExpression // ignore: cast_nullable_to_non_nullable
                  as String?,
        nextRunAt: freezed == nextRunAt
            ? _value.nextRunAt
            : nextRunAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isEnabled: freezed == isEnabled
            ? _value.isEnabled
            : isEnabled // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BigQueryExportImpl implements _BigQueryExport {
  const _$BigQueryExportImpl({
    required this.id,
    required this.institutionId,
    this.companyId,
    required this.exportType,
    required this.status,
    required this.frequency,
    required this.projectId,
    required this.datasetId,
    required this.tableId,
    required this.totalRecords,
    required this.exportedRecords,
    required this.failedRecords,
    final List<String> errors = const [],
    required this.triggeredBy,
    required this.triggeredByName,
    @TimestampConverter() required this.startedAt,
    @TimestampConverter() this.completedAt,
    this.cronExpression,
    @TimestampConverter() this.nextRunAt,
    this.isEnabled,
  }) : _errors = errors;

  factory _$BigQueryExportImpl.fromJson(Map<String, dynamic> json) =>
      _$$BigQueryExportImplFromJson(json);

  @override
  final String id;
  @override
  final String institutionId;
  @override
  final String? companyId;

  /// معلومات التصدير
  @override
  final ExportType exportType;
  @override
  final ExportStatus status;
  @override
  final ExportFrequency frequency;

  /// معلومات BigQuery
  @override
  final String projectId;
  @override
  final String datasetId;
  @override
  final String tableId;

  /// الإحصائيات
  @override
  final int totalRecords;
  @override
  final int exportedRecords;
  @override
  final int failedRecords;

  /// الأخطاء
  final List<String> _errors;

  /// الأخطاء
  @override
  @JsonKey()
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  /// معلومات التنفيذ
  @override
  final String triggeredBy;
  @override
  final String triggeredByName;
  @override
  @TimestampConverter()
  final DateTime startedAt;
  @override
  @TimestampConverter()
  final DateTime? completedAt;

  /// الجدولة
  @override
  final String? cronExpression;
  @override
  @TimestampConverter()
  final DateTime? nextRunAt;
  @override
  final bool? isEnabled;

  @override
  String toString() {
    return 'BigQueryExport(id: $id, institutionId: $institutionId, companyId: $companyId, exportType: $exportType, status: $status, frequency: $frequency, projectId: $projectId, datasetId: $datasetId, tableId: $tableId, totalRecords: $totalRecords, exportedRecords: $exportedRecords, failedRecords: $failedRecords, errors: $errors, triggeredBy: $triggeredBy, triggeredByName: $triggeredByName, startedAt: $startedAt, completedAt: $completedAt, cronExpression: $cronExpression, nextRunAt: $nextRunAt, isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BigQueryExportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.exportType, exportType) ||
                other.exportType == exportType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.datasetId, datasetId) ||
                other.datasetId == datasetId) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.totalRecords, totalRecords) ||
                other.totalRecords == totalRecords) &&
            (identical(other.exportedRecords, exportedRecords) ||
                other.exportedRecords == exportedRecords) &&
            (identical(other.failedRecords, failedRecords) ||
                other.failedRecords == failedRecords) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            (identical(other.triggeredBy, triggeredBy) ||
                other.triggeredBy == triggeredBy) &&
            (identical(other.triggeredByName, triggeredByName) ||
                other.triggeredByName == triggeredByName) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.cronExpression, cronExpression) ||
                other.cronExpression == cronExpression) &&
            (identical(other.nextRunAt, nextRunAt) ||
                other.nextRunAt == nextRunAt) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    institutionId,
    companyId,
    exportType,
    status,
    frequency,
    projectId,
    datasetId,
    tableId,
    totalRecords,
    exportedRecords,
    failedRecords,
    const DeepCollectionEquality().hash(_errors),
    triggeredBy,
    triggeredByName,
    startedAt,
    completedAt,
    cronExpression,
    nextRunAt,
    isEnabled,
  ]);

  /// Create a copy of BigQueryExport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BigQueryExportImplCopyWith<_$BigQueryExportImpl> get copyWith =>
      __$$BigQueryExportImplCopyWithImpl<_$BigQueryExportImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BigQueryExportImplToJson(this);
  }
}

abstract class _BigQueryExport implements BigQueryExport {
  const factory _BigQueryExport({
    required final String id,
    required final String institutionId,
    final String? companyId,
    required final ExportType exportType,
    required final ExportStatus status,
    required final ExportFrequency frequency,
    required final String projectId,
    required final String datasetId,
    required final String tableId,
    required final int totalRecords,
    required final int exportedRecords,
    required final int failedRecords,
    final List<String> errors,
    required final String triggeredBy,
    required final String triggeredByName,
    @TimestampConverter() required final DateTime startedAt,
    @TimestampConverter() final DateTime? completedAt,
    final String? cronExpression,
    @TimestampConverter() final DateTime? nextRunAt,
    final bool? isEnabled,
  }) = _$BigQueryExportImpl;

  factory _BigQueryExport.fromJson(Map<String, dynamic> json) =
      _$BigQueryExportImpl.fromJson;

  @override
  String get id;
  @override
  String get institutionId;
  @override
  String? get companyId;

  /// معلومات التصدير
  @override
  ExportType get exportType;
  @override
  ExportStatus get status;
  @override
  ExportFrequency get frequency;

  /// معلومات BigQuery
  @override
  String get projectId;
  @override
  String get datasetId;
  @override
  String get tableId;

  /// الإحصائيات
  @override
  int get totalRecords;
  @override
  int get exportedRecords;
  @override
  int get failedRecords;

  /// الأخطاء
  @override
  List<String> get errors;

  /// معلومات التنفيذ
  @override
  String get triggeredBy;
  @override
  String get triggeredByName;
  @override
  @TimestampConverter()
  DateTime get startedAt;
  @override
  @TimestampConverter()
  DateTime? get completedAt;

  /// الجدولة
  @override
  String? get cronExpression;
  @override
  @TimestampConverter()
  DateTime? get nextRunAt;
  @override
  bool? get isEnabled;

  /// Create a copy of BigQueryExport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BigQueryExportImplCopyWith<_$BigQueryExportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BigQueryConfig _$BigQueryConfigFromJson(Map<String, dynamic> json) {
  return _BigQueryConfig.fromJson(json);
}

/// @nodoc
mixin _$BigQueryConfig {
  String get id => throw _privateConstructorUsedError;
  String get institutionId => throw _privateConstructorUsedError;
  String? get companyId => throw _privateConstructorUsedError;

  /// بيانات الاتصال
  String get projectId => throw _privateConstructorUsedError;
  String get datasetId => throw _privateConstructorUsedError;
  String get credentialsJson => throw _privateConstructorUsedError;

  /// الإعدادات
  bool get isEnabled => throw _privateConstructorUsedError;
  List<ExportType> get enabledExports => throw _privateConstructorUsedError;

  /// الجدولة الافتراضية
  ExportFrequency? get defaultFrequency => throw _privateConstructorUsedError;
  String? get defaultCronExpression => throw _privateConstructorUsedError;

  /// معلومات الإنشاء
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get updatedBy => throw _privateConstructorUsedError;

  /// Serializes this BigQueryConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BigQueryConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BigQueryConfigCopyWith<BigQueryConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BigQueryConfigCopyWith<$Res> {
  factory $BigQueryConfigCopyWith(
    BigQueryConfig value,
    $Res Function(BigQueryConfig) then,
  ) = _$BigQueryConfigCopyWithImpl<$Res, BigQueryConfig>;
  @useResult
  $Res call({
    String id,
    String institutionId,
    String? companyId,
    String projectId,
    String datasetId,
    String credentialsJson,
    bool isEnabled,
    List<ExportType> enabledExports,
    ExportFrequency? defaultFrequency,
    String? defaultCronExpression,
    @TimestampConverter() DateTime createdAt,
    String createdBy,
    @TimestampConverter() DateTime? updatedAt,
    String? updatedBy,
  });
}

/// @nodoc
class _$BigQueryConfigCopyWithImpl<$Res, $Val extends BigQueryConfig>
    implements $BigQueryConfigCopyWith<$Res> {
  _$BigQueryConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BigQueryConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? projectId = null,
    Object? datasetId = null,
    Object? credentialsJson = null,
    Object? isEnabled = null,
    Object? enabledExports = null,
    Object? defaultFrequency = freezed,
    Object? defaultCronExpression = freezed,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? updatedAt = freezed,
    Object? updatedBy = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: freezed == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String?,
            projectId: null == projectId
                ? _value.projectId
                : projectId // ignore: cast_nullable_to_non_nullable
                      as String,
            datasetId: null == datasetId
                ? _value.datasetId
                : datasetId // ignore: cast_nullable_to_non_nullable
                      as String,
            credentialsJson: null == credentialsJson
                ? _value.credentialsJson
                : credentialsJson // ignore: cast_nullable_to_non_nullable
                      as String,
            isEnabled: null == isEnabled
                ? _value.isEnabled
                : isEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            enabledExports: null == enabledExports
                ? _value.enabledExports
                : enabledExports // ignore: cast_nullable_to_non_nullable
                      as List<ExportType>,
            defaultFrequency: freezed == defaultFrequency
                ? _value.defaultFrequency
                : defaultFrequency // ignore: cast_nullable_to_non_nullable
                      as ExportFrequency?,
            defaultCronExpression: freezed == defaultCronExpression
                ? _value.defaultCronExpression
                : defaultCronExpression // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedBy: freezed == updatedBy
                ? _value.updatedBy
                : updatedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BigQueryConfigImplCopyWith<$Res>
    implements $BigQueryConfigCopyWith<$Res> {
  factory _$$BigQueryConfigImplCopyWith(
    _$BigQueryConfigImpl value,
    $Res Function(_$BigQueryConfigImpl) then,
  ) = __$$BigQueryConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String institutionId,
    String? companyId,
    String projectId,
    String datasetId,
    String credentialsJson,
    bool isEnabled,
    List<ExportType> enabledExports,
    ExportFrequency? defaultFrequency,
    String? defaultCronExpression,
    @TimestampConverter() DateTime createdAt,
    String createdBy,
    @TimestampConverter() DateTime? updatedAt,
    String? updatedBy,
  });
}

/// @nodoc
class __$$BigQueryConfigImplCopyWithImpl<$Res>
    extends _$BigQueryConfigCopyWithImpl<$Res, _$BigQueryConfigImpl>
    implements _$$BigQueryConfigImplCopyWith<$Res> {
  __$$BigQueryConfigImplCopyWithImpl(
    _$BigQueryConfigImpl _value,
    $Res Function(_$BigQueryConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BigQueryConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? projectId = null,
    Object? datasetId = null,
    Object? credentialsJson = null,
    Object? isEnabled = null,
    Object? enabledExports = null,
    Object? defaultFrequency = freezed,
    Object? defaultCronExpression = freezed,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? updatedAt = freezed,
    Object? updatedBy = freezed,
  }) {
    return _then(
      _$BigQueryConfigImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: freezed == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String?,
        projectId: null == projectId
            ? _value.projectId
            : projectId // ignore: cast_nullable_to_non_nullable
                  as String,
        datasetId: null == datasetId
            ? _value.datasetId
            : datasetId // ignore: cast_nullable_to_non_nullable
                  as String,
        credentialsJson: null == credentialsJson
            ? _value.credentialsJson
            : credentialsJson // ignore: cast_nullable_to_non_nullable
                  as String,
        isEnabled: null == isEnabled
            ? _value.isEnabled
            : isEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        enabledExports: null == enabledExports
            ? _value._enabledExports
            : enabledExports // ignore: cast_nullable_to_non_nullable
                  as List<ExportType>,
        defaultFrequency: freezed == defaultFrequency
            ? _value.defaultFrequency
            : defaultFrequency // ignore: cast_nullable_to_non_nullable
                  as ExportFrequency?,
        defaultCronExpression: freezed == defaultCronExpression
            ? _value.defaultCronExpression
            : defaultCronExpression // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedBy: freezed == updatedBy
            ? _value.updatedBy
            : updatedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BigQueryConfigImpl implements _BigQueryConfig {
  const _$BigQueryConfigImpl({
    required this.id,
    required this.institutionId,
    this.companyId,
    required this.projectId,
    required this.datasetId,
    required this.credentialsJson,
    required this.isEnabled,
    final List<ExportType> enabledExports = const [],
    this.defaultFrequency,
    this.defaultCronExpression,
    @TimestampConverter() required this.createdAt,
    required this.createdBy,
    @TimestampConverter() this.updatedAt,
    this.updatedBy,
  }) : _enabledExports = enabledExports;

  factory _$BigQueryConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$BigQueryConfigImplFromJson(json);

  @override
  final String id;
  @override
  final String institutionId;
  @override
  final String? companyId;

  /// بيانات الاتصال
  @override
  final String projectId;
  @override
  final String datasetId;
  @override
  final String credentialsJson;

  /// الإعدادات
  @override
  final bool isEnabled;
  final List<ExportType> _enabledExports;
  @override
  @JsonKey()
  List<ExportType> get enabledExports {
    if (_enabledExports is EqualUnmodifiableListView) return _enabledExports;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_enabledExports);
  }

  /// الجدولة الافتراضية
  @override
  final ExportFrequency? defaultFrequency;
  @override
  final String? defaultCronExpression;

  /// معلومات الإنشاء
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  final String createdBy;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;
  @override
  final String? updatedBy;

  @override
  String toString() {
    return 'BigQueryConfig(id: $id, institutionId: $institutionId, companyId: $companyId, projectId: $projectId, datasetId: $datasetId, credentialsJson: $credentialsJson, isEnabled: $isEnabled, enabledExports: $enabledExports, defaultFrequency: $defaultFrequency, defaultCronExpression: $defaultCronExpression, createdAt: $createdAt, createdBy: $createdBy, updatedAt: $updatedAt, updatedBy: $updatedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BigQueryConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.datasetId, datasetId) ||
                other.datasetId == datasetId) &&
            (identical(other.credentialsJson, credentialsJson) ||
                other.credentialsJson == credentialsJson) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            const DeepCollectionEquality().equals(
              other._enabledExports,
              _enabledExports,
            ) &&
            (identical(other.defaultFrequency, defaultFrequency) ||
                other.defaultFrequency == defaultFrequency) &&
            (identical(other.defaultCronExpression, defaultCronExpression) ||
                other.defaultCronExpression == defaultCronExpression) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    institutionId,
    companyId,
    projectId,
    datasetId,
    credentialsJson,
    isEnabled,
    const DeepCollectionEquality().hash(_enabledExports),
    defaultFrequency,
    defaultCronExpression,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
  );

  /// Create a copy of BigQueryConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BigQueryConfigImplCopyWith<_$BigQueryConfigImpl> get copyWith =>
      __$$BigQueryConfigImplCopyWithImpl<_$BigQueryConfigImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BigQueryConfigImplToJson(this);
  }
}

abstract class _BigQueryConfig implements BigQueryConfig {
  const factory _BigQueryConfig({
    required final String id,
    required final String institutionId,
    final String? companyId,
    required final String projectId,
    required final String datasetId,
    required final String credentialsJson,
    required final bool isEnabled,
    final List<ExportType> enabledExports,
    final ExportFrequency? defaultFrequency,
    final String? defaultCronExpression,
    @TimestampConverter() required final DateTime createdAt,
    required final String createdBy,
    @TimestampConverter() final DateTime? updatedAt,
    final String? updatedBy,
  }) = _$BigQueryConfigImpl;

  factory _BigQueryConfig.fromJson(Map<String, dynamic> json) =
      _$BigQueryConfigImpl.fromJson;

  @override
  String get id;
  @override
  String get institutionId;
  @override
  String? get companyId;

  /// بيانات الاتصال
  @override
  String get projectId;
  @override
  String get datasetId;
  @override
  String get credentialsJson;

  /// الإعدادات
  @override
  bool get isEnabled;
  @override
  List<ExportType> get enabledExports;

  /// الجدولة الافتراضية
  @override
  ExportFrequency? get defaultFrequency;
  @override
  String? get defaultCronExpression;

  /// معلومات الإنشاء
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  String get createdBy;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  String? get updatedBy;

  /// Create a copy of BigQueryConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BigQueryConfigImplCopyWith<_$BigQueryConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExportSchema _$ExportSchemaFromJson(Map<String, dynamic> json) {
  return _ExportSchema.fromJson(json);
}

/// @nodoc
mixin _$ExportSchema {
  ExportType get exportType => throw _privateConstructorUsedError;
  String get tableName => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<SchemaField> get fields => throw _privateConstructorUsedError;

  /// Serializes this ExportSchema to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExportSchema
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExportSchemaCopyWith<ExportSchema> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExportSchemaCopyWith<$Res> {
  factory $ExportSchemaCopyWith(
    ExportSchema value,
    $Res Function(ExportSchema) then,
  ) = _$ExportSchemaCopyWithImpl<$Res, ExportSchema>;
  @useResult
  $Res call({
    ExportType exportType,
    String tableName,
    String description,
    List<SchemaField> fields,
  });
}

/// @nodoc
class _$ExportSchemaCopyWithImpl<$Res, $Val extends ExportSchema>
    implements $ExportSchemaCopyWith<$Res> {
  _$ExportSchemaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExportSchema
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exportType = null,
    Object? tableName = null,
    Object? description = null,
    Object? fields = null,
  }) {
    return _then(
      _value.copyWith(
            exportType: null == exportType
                ? _value.exportType
                : exportType // ignore: cast_nullable_to_non_nullable
                      as ExportType,
            tableName: null == tableName
                ? _value.tableName
                : tableName // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            fields: null == fields
                ? _value.fields
                : fields // ignore: cast_nullable_to_non_nullable
                      as List<SchemaField>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExportSchemaImplCopyWith<$Res>
    implements $ExportSchemaCopyWith<$Res> {
  factory _$$ExportSchemaImplCopyWith(
    _$ExportSchemaImpl value,
    $Res Function(_$ExportSchemaImpl) then,
  ) = __$$ExportSchemaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ExportType exportType,
    String tableName,
    String description,
    List<SchemaField> fields,
  });
}

/// @nodoc
class __$$ExportSchemaImplCopyWithImpl<$Res>
    extends _$ExportSchemaCopyWithImpl<$Res, _$ExportSchemaImpl>
    implements _$$ExportSchemaImplCopyWith<$Res> {
  __$$ExportSchemaImplCopyWithImpl(
    _$ExportSchemaImpl _value,
    $Res Function(_$ExportSchemaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExportSchema
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exportType = null,
    Object? tableName = null,
    Object? description = null,
    Object? fields = null,
  }) {
    return _then(
      _$ExportSchemaImpl(
        exportType: null == exportType
            ? _value.exportType
            : exportType // ignore: cast_nullable_to_non_nullable
                  as ExportType,
        tableName: null == tableName
            ? _value.tableName
            : tableName // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        fields: null == fields
            ? _value._fields
            : fields // ignore: cast_nullable_to_non_nullable
                  as List<SchemaField>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExportSchemaImpl implements _ExportSchema {
  const _$ExportSchemaImpl({
    required this.exportType,
    required this.tableName,
    required this.description,
    required final List<SchemaField> fields,
  }) : _fields = fields;

  factory _$ExportSchemaImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExportSchemaImplFromJson(json);

  @override
  final ExportType exportType;
  @override
  final String tableName;
  @override
  final String description;
  final List<SchemaField> _fields;
  @override
  List<SchemaField> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  @override
  String toString() {
    return 'ExportSchema(exportType: $exportType, tableName: $tableName, description: $description, fields: $fields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExportSchemaImpl &&
            (identical(other.exportType, exportType) ||
                other.exportType == exportType) &&
            (identical(other.tableName, tableName) ||
                other.tableName == tableName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    exportType,
    tableName,
    description,
    const DeepCollectionEquality().hash(_fields),
  );

  /// Create a copy of ExportSchema
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExportSchemaImplCopyWith<_$ExportSchemaImpl> get copyWith =>
      __$$ExportSchemaImplCopyWithImpl<_$ExportSchemaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExportSchemaImplToJson(this);
  }
}

abstract class _ExportSchema implements ExportSchema {
  const factory _ExportSchema({
    required final ExportType exportType,
    required final String tableName,
    required final String description,
    required final List<SchemaField> fields,
  }) = _$ExportSchemaImpl;

  factory _ExportSchema.fromJson(Map<String, dynamic> json) =
      _$ExportSchemaImpl.fromJson;

  @override
  ExportType get exportType;
  @override
  String get tableName;
  @override
  String get description;
  @override
  List<SchemaField> get fields;

  /// Create a copy of ExportSchema
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExportSchemaImplCopyWith<_$ExportSchemaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SchemaField _$SchemaFieldFromJson(Map<String, dynamic> json) {
  return _SchemaField.fromJson(json);
}

/// @nodoc
mixin _$SchemaField {
  String get name => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // STRING, INTEGER, FLOAT, BOOLEAN, TIMESTAMP, etc.
  String get mode =>
      throw _privateConstructorUsedError; // REQUIRED, NULLABLE, REPEATED
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this SchemaField to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SchemaField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SchemaFieldCopyWith<SchemaField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchemaFieldCopyWith<$Res> {
  factory $SchemaFieldCopyWith(
    SchemaField value,
    $Res Function(SchemaField) then,
  ) = _$SchemaFieldCopyWithImpl<$Res, SchemaField>;
  @useResult
  $Res call({String name, String type, String mode, String? description});
}

/// @nodoc
class _$SchemaFieldCopyWithImpl<$Res, $Val extends SchemaField>
    implements $SchemaFieldCopyWith<$Res> {
  _$SchemaFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SchemaField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? mode = null,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            mode: null == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SchemaFieldImplCopyWith<$Res>
    implements $SchemaFieldCopyWith<$Res> {
  factory _$$SchemaFieldImplCopyWith(
    _$SchemaFieldImpl value,
    $Res Function(_$SchemaFieldImpl) then,
  ) = __$$SchemaFieldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String type, String mode, String? description});
}

/// @nodoc
class __$$SchemaFieldImplCopyWithImpl<$Res>
    extends _$SchemaFieldCopyWithImpl<$Res, _$SchemaFieldImpl>
    implements _$$SchemaFieldImplCopyWith<$Res> {
  __$$SchemaFieldImplCopyWithImpl(
    _$SchemaFieldImpl _value,
    $Res Function(_$SchemaFieldImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SchemaField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? mode = null,
    Object? description = freezed,
  }) {
    return _then(
      _$SchemaFieldImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        mode: null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SchemaFieldImpl implements _SchemaField {
  const _$SchemaFieldImpl({
    required this.name,
    required this.type,
    required this.mode,
    this.description,
  });

  factory _$SchemaFieldImpl.fromJson(Map<String, dynamic> json) =>
      _$$SchemaFieldImplFromJson(json);

  @override
  final String name;
  @override
  final String type;
  // STRING, INTEGER, FLOAT, BOOLEAN, TIMESTAMP, etc.
  @override
  final String mode;
  // REQUIRED, NULLABLE, REPEATED
  @override
  final String? description;

  @override
  String toString() {
    return 'SchemaField(name: $name, type: $type, mode: $mode, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SchemaFieldImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, type, mode, description);

  /// Create a copy of SchemaField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SchemaFieldImplCopyWith<_$SchemaFieldImpl> get copyWith =>
      __$$SchemaFieldImplCopyWithImpl<_$SchemaFieldImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SchemaFieldImplToJson(this);
  }
}

abstract class _SchemaField implements SchemaField {
  const factory _SchemaField({
    required final String name,
    required final String type,
    required final String mode,
    final String? description,
  }) = _$SchemaFieldImpl;

  factory _SchemaField.fromJson(Map<String, dynamic> json) =
      _$SchemaFieldImpl.fromJson;

  @override
  String get name;
  @override
  String get type; // STRING, INTEGER, FLOAT, BOOLEAN, TIMESTAMP, etc.
  @override
  String get mode; // REQUIRED, NULLABLE, REPEATED
  @override
  String? get description;

  /// Create a copy of SchemaField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SchemaFieldImplCopyWith<_$SchemaFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExportRecord _$ExportRecordFromJson(Map<String, dynamic> json) {
  return _ExportRecord.fromJson(json);
}

/// @nodoc
mixin _$ExportRecord {
  String get exportId => throw _privateConstructorUsedError;
  String get recordId => throw _privateConstructorUsedError;
  ExportType get exportType => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get exportedAt => throw _privateConstructorUsedError;
  bool? get isSuccess => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Serializes this ExportRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExportRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExportRecordCopyWith<ExportRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExportRecordCopyWith<$Res> {
  factory $ExportRecordCopyWith(
    ExportRecord value,
    $Res Function(ExportRecord) then,
  ) = _$ExportRecordCopyWithImpl<$Res, ExportRecord>;
  @useResult
  $Res call({
    String exportId,
    String recordId,
    ExportType exportType,
    Map<String, dynamic> data,
    @TimestampConverter() DateTime exportedAt,
    bool? isSuccess,
    String? errorMessage,
  });
}

/// @nodoc
class _$ExportRecordCopyWithImpl<$Res, $Val extends ExportRecord>
    implements $ExportRecordCopyWith<$Res> {
  _$ExportRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExportRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exportId = null,
    Object? recordId = null,
    Object? exportType = null,
    Object? data = null,
    Object? exportedAt = null,
    Object? isSuccess = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            exportId: null == exportId
                ? _value.exportId
                : exportId // ignore: cast_nullable_to_non_nullable
                      as String,
            recordId: null == recordId
                ? _value.recordId
                : recordId // ignore: cast_nullable_to_non_nullable
                      as String,
            exportType: null == exportType
                ? _value.exportType
                : exportType // ignore: cast_nullable_to_non_nullable
                      as ExportType,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            exportedAt: null == exportedAt
                ? _value.exportedAt
                : exportedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isSuccess: freezed == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                      as bool?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExportRecordImplCopyWith<$Res>
    implements $ExportRecordCopyWith<$Res> {
  factory _$$ExportRecordImplCopyWith(
    _$ExportRecordImpl value,
    $Res Function(_$ExportRecordImpl) then,
  ) = __$$ExportRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String exportId,
    String recordId,
    ExportType exportType,
    Map<String, dynamic> data,
    @TimestampConverter() DateTime exportedAt,
    bool? isSuccess,
    String? errorMessage,
  });
}

/// @nodoc
class __$$ExportRecordImplCopyWithImpl<$Res>
    extends _$ExportRecordCopyWithImpl<$Res, _$ExportRecordImpl>
    implements _$$ExportRecordImplCopyWith<$Res> {
  __$$ExportRecordImplCopyWithImpl(
    _$ExportRecordImpl _value,
    $Res Function(_$ExportRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExportRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exportId = null,
    Object? recordId = null,
    Object? exportType = null,
    Object? data = null,
    Object? exportedAt = null,
    Object? isSuccess = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$ExportRecordImpl(
        exportId: null == exportId
            ? _value.exportId
            : exportId // ignore: cast_nullable_to_non_nullable
                  as String,
        recordId: null == recordId
            ? _value.recordId
            : recordId // ignore: cast_nullable_to_non_nullable
                  as String,
        exportType: null == exportType
            ? _value.exportType
            : exportType // ignore: cast_nullable_to_non_nullable
                  as ExportType,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        exportedAt: null == exportedAt
            ? _value.exportedAt
            : exportedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isSuccess: freezed == isSuccess
            ? _value.isSuccess
            : isSuccess // ignore: cast_nullable_to_non_nullable
                  as bool?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExportRecordImpl implements _ExportRecord {
  const _$ExportRecordImpl({
    required this.exportId,
    required this.recordId,
    required this.exportType,
    required final Map<String, dynamic> data,
    @TimestampConverter() required this.exportedAt,
    this.isSuccess,
    this.errorMessage,
  }) : _data = data;

  factory _$ExportRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExportRecordImplFromJson(json);

  @override
  final String exportId;
  @override
  final String recordId;
  @override
  final ExportType exportType;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  @TimestampConverter()
  final DateTime exportedAt;
  @override
  final bool? isSuccess;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ExportRecord(exportId: $exportId, recordId: $recordId, exportType: $exportType, data: $data, exportedAt: $exportedAt, isSuccess: $isSuccess, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExportRecordImpl &&
            (identical(other.exportId, exportId) ||
                other.exportId == exportId) &&
            (identical(other.recordId, recordId) ||
                other.recordId == recordId) &&
            (identical(other.exportType, exportType) ||
                other.exportType == exportType) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.exportedAt, exportedAt) ||
                other.exportedAt == exportedAt) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    exportId,
    recordId,
    exportType,
    const DeepCollectionEquality().hash(_data),
    exportedAt,
    isSuccess,
    errorMessage,
  );

  /// Create a copy of ExportRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExportRecordImplCopyWith<_$ExportRecordImpl> get copyWith =>
      __$$ExportRecordImplCopyWithImpl<_$ExportRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExportRecordImplToJson(this);
  }
}

abstract class _ExportRecord implements ExportRecord {
  const factory _ExportRecord({
    required final String exportId,
    required final String recordId,
    required final ExportType exportType,
    required final Map<String, dynamic> data,
    @TimestampConverter() required final DateTime exportedAt,
    final bool? isSuccess,
    final String? errorMessage,
  }) = _$ExportRecordImpl;

  factory _ExportRecord.fromJson(Map<String, dynamic> json) =
      _$ExportRecordImpl.fromJson;

  @override
  String get exportId;
  @override
  String get recordId;
  @override
  ExportType get exportType;
  @override
  Map<String, dynamic> get data;
  @override
  @TimestampConverter()
  DateTime get exportedAt;
  @override
  bool? get isSuccess;
  @override
  String? get errorMessage;

  /// Create a copy of ExportRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExportRecordImplCopyWith<_$ExportRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
