// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hris_import.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HRISImport _$HRISImportFromJson(Map<String, dynamic> json) {
  return _HRISImport.fromJson(json);
}

/// @nodoc
mixin _$HRISImport {
  String get id => throw _privateConstructorUsedError;
  String get institutionId => throw _privateConstructorUsedError;
  String? get companyId => throw _privateConstructorUsedError;

  /// معلومات الملف
  ImportFileType get fileType => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  int get totalRows => throw _privateConstructorUsedError;

  /// الحالة
  ImportStatus get status => throw _privateConstructorUsedError;
  int get processedRows => throw _privateConstructorUsedError;
  int get successfulRows => throw _privateConstructorUsedError;
  int get failedRows => throw _privateConstructorUsedError;

  /// تفاصيل الأخطاء
  List<String> get errors => throw _privateConstructorUsedError;
  Map<String, dynamic> get errorDetails => throw _privateConstructorUsedError;

  /// معلومات المستخدم الذي قام بالاستيراد
  String get uploadedBy => throw _privateConstructorUsedError;
  String get uploaderName => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get uploadedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// إعدادات ال Mapping
  FieldMapping get fieldMapping => throw _privateConstructorUsedError;

  /// خيارات الاستيراد
  bool get updateExistingUsers => throw _privateConstructorUsedError;
  bool get skipInvalidRows => throw _privateConstructorUsedError;
  String? get defaultRole => throw _privateConstructorUsedError;
  String? get defaultPassword => throw _privateConstructorUsedError;

  /// Serializes this HRISImport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HRISImport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HRISImportCopyWith<HRISImport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HRISImportCopyWith<$Res> {
  factory $HRISImportCopyWith(
    HRISImport value,
    $Res Function(HRISImport) then,
  ) = _$HRISImportCopyWithImpl<$Res, HRISImport>;
  @useResult
  $Res call({
    String id,
    String institutionId,
    String? companyId,
    ImportFileType fileType,
    String fileName,
    int totalRows,
    ImportStatus status,
    int processedRows,
    int successfulRows,
    int failedRows,
    List<String> errors,
    Map<String, dynamic> errorDetails,
    String uploadedBy,
    String uploaderName,
    @TimestampConverter() DateTime uploadedAt,
    @TimestampConverter() DateTime? completedAt,
    FieldMapping fieldMapping,
    bool updateExistingUsers,
    bool skipInvalidRows,
    String? defaultRole,
    String? defaultPassword,
  });

  $FieldMappingCopyWith<$Res> get fieldMapping;
}

/// @nodoc
class _$HRISImportCopyWithImpl<$Res, $Val extends HRISImport>
    implements $HRISImportCopyWith<$Res> {
  _$HRISImportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HRISImport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? fileType = null,
    Object? fileName = null,
    Object? totalRows = null,
    Object? status = null,
    Object? processedRows = null,
    Object? successfulRows = null,
    Object? failedRows = null,
    Object? errors = null,
    Object? errorDetails = null,
    Object? uploadedBy = null,
    Object? uploaderName = null,
    Object? uploadedAt = null,
    Object? completedAt = freezed,
    Object? fieldMapping = null,
    Object? updateExistingUsers = null,
    Object? skipInvalidRows = null,
    Object? defaultRole = freezed,
    Object? defaultPassword = freezed,
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
            fileType: null == fileType
                ? _value.fileType
                : fileType // ignore: cast_nullable_to_non_nullable
                      as ImportFileType,
            fileName: null == fileName
                ? _value.fileName
                : fileName // ignore: cast_nullable_to_non_nullable
                      as String,
            totalRows: null == totalRows
                ? _value.totalRows
                : totalRows // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ImportStatus,
            processedRows: null == processedRows
                ? _value.processedRows
                : processedRows // ignore: cast_nullable_to_non_nullable
                      as int,
            successfulRows: null == successfulRows
                ? _value.successfulRows
                : successfulRows // ignore: cast_nullable_to_non_nullable
                      as int,
            failedRows: null == failedRows
                ? _value.failedRows
                : failedRows // ignore: cast_nullable_to_non_nullable
                      as int,
            errors: null == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            errorDetails: null == errorDetails
                ? _value.errorDetails
                : errorDetails // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            uploadedBy: null == uploadedBy
                ? _value.uploadedBy
                : uploadedBy // ignore: cast_nullable_to_non_nullable
                      as String,
            uploaderName: null == uploaderName
                ? _value.uploaderName
                : uploaderName // ignore: cast_nullable_to_non_nullable
                      as String,
            uploadedAt: null == uploadedAt
                ? _value.uploadedAt
                : uploadedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            fieldMapping: null == fieldMapping
                ? _value.fieldMapping
                : fieldMapping // ignore: cast_nullable_to_non_nullable
                      as FieldMapping,
            updateExistingUsers: null == updateExistingUsers
                ? _value.updateExistingUsers
                : updateExistingUsers // ignore: cast_nullable_to_non_nullable
                      as bool,
            skipInvalidRows: null == skipInvalidRows
                ? _value.skipInvalidRows
                : skipInvalidRows // ignore: cast_nullable_to_non_nullable
                      as bool,
            defaultRole: freezed == defaultRole
                ? _value.defaultRole
                : defaultRole // ignore: cast_nullable_to_non_nullable
                      as String?,
            defaultPassword: freezed == defaultPassword
                ? _value.defaultPassword
                : defaultPassword // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of HRISImport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FieldMappingCopyWith<$Res> get fieldMapping {
    return $FieldMappingCopyWith<$Res>(_value.fieldMapping, (value) {
      return _then(_value.copyWith(fieldMapping: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HRISImportImplCopyWith<$Res>
    implements $HRISImportCopyWith<$Res> {
  factory _$$HRISImportImplCopyWith(
    _$HRISImportImpl value,
    $Res Function(_$HRISImportImpl) then,
  ) = __$$HRISImportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String institutionId,
    String? companyId,
    ImportFileType fileType,
    String fileName,
    int totalRows,
    ImportStatus status,
    int processedRows,
    int successfulRows,
    int failedRows,
    List<String> errors,
    Map<String, dynamic> errorDetails,
    String uploadedBy,
    String uploaderName,
    @TimestampConverter() DateTime uploadedAt,
    @TimestampConverter() DateTime? completedAt,
    FieldMapping fieldMapping,
    bool updateExistingUsers,
    bool skipInvalidRows,
    String? defaultRole,
    String? defaultPassword,
  });

  @override
  $FieldMappingCopyWith<$Res> get fieldMapping;
}

/// @nodoc
class __$$HRISImportImplCopyWithImpl<$Res>
    extends _$HRISImportCopyWithImpl<$Res, _$HRISImportImpl>
    implements _$$HRISImportImplCopyWith<$Res> {
  __$$HRISImportImplCopyWithImpl(
    _$HRISImportImpl _value,
    $Res Function(_$HRISImportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HRISImport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? fileType = null,
    Object? fileName = null,
    Object? totalRows = null,
    Object? status = null,
    Object? processedRows = null,
    Object? successfulRows = null,
    Object? failedRows = null,
    Object? errors = null,
    Object? errorDetails = null,
    Object? uploadedBy = null,
    Object? uploaderName = null,
    Object? uploadedAt = null,
    Object? completedAt = freezed,
    Object? fieldMapping = null,
    Object? updateExistingUsers = null,
    Object? skipInvalidRows = null,
    Object? defaultRole = freezed,
    Object? defaultPassword = freezed,
  }) {
    return _then(
      _$HRISImportImpl(
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
        fileType: null == fileType
            ? _value.fileType
            : fileType // ignore: cast_nullable_to_non_nullable
                  as ImportFileType,
        fileName: null == fileName
            ? _value.fileName
            : fileName // ignore: cast_nullable_to_non_nullable
                  as String,
        totalRows: null == totalRows
            ? _value.totalRows
            : totalRows // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ImportStatus,
        processedRows: null == processedRows
            ? _value.processedRows
            : processedRows // ignore: cast_nullable_to_non_nullable
                  as int,
        successfulRows: null == successfulRows
            ? _value.successfulRows
            : successfulRows // ignore: cast_nullable_to_non_nullable
                  as int,
        failedRows: null == failedRows
            ? _value.failedRows
            : failedRows // ignore: cast_nullable_to_non_nullable
                  as int,
        errors: null == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        errorDetails: null == errorDetails
            ? _value._errorDetails
            : errorDetails // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        uploadedBy: null == uploadedBy
            ? _value.uploadedBy
            : uploadedBy // ignore: cast_nullable_to_non_nullable
                  as String,
        uploaderName: null == uploaderName
            ? _value.uploaderName
            : uploaderName // ignore: cast_nullable_to_non_nullable
                  as String,
        uploadedAt: null == uploadedAt
            ? _value.uploadedAt
            : uploadedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        fieldMapping: null == fieldMapping
            ? _value.fieldMapping
            : fieldMapping // ignore: cast_nullable_to_non_nullable
                  as FieldMapping,
        updateExistingUsers: null == updateExistingUsers
            ? _value.updateExistingUsers
            : updateExistingUsers // ignore: cast_nullable_to_non_nullable
                  as bool,
        skipInvalidRows: null == skipInvalidRows
            ? _value.skipInvalidRows
            : skipInvalidRows // ignore: cast_nullable_to_non_nullable
                  as bool,
        defaultRole: freezed == defaultRole
            ? _value.defaultRole
            : defaultRole // ignore: cast_nullable_to_non_nullable
                  as String?,
        defaultPassword: freezed == defaultPassword
            ? _value.defaultPassword
            : defaultPassword // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HRISImportImpl implements _HRISImport {
  const _$HRISImportImpl({
    required this.id,
    required this.institutionId,
    this.companyId,
    required this.fileType,
    required this.fileName,
    required this.totalRows,
    required this.status,
    this.processedRows = 0,
    this.successfulRows = 0,
    this.failedRows = 0,
    final List<String> errors = const [],
    final Map<String, dynamic> errorDetails = const {},
    required this.uploadedBy,
    required this.uploaderName,
    @TimestampConverter() required this.uploadedAt,
    @TimestampConverter() this.completedAt,
    required this.fieldMapping,
    this.updateExistingUsers = true,
    this.skipInvalidRows = false,
    this.defaultRole,
    this.defaultPassword,
  }) : _errors = errors,
       _errorDetails = errorDetails;

  factory _$HRISImportImpl.fromJson(Map<String, dynamic> json) =>
      _$$HRISImportImplFromJson(json);

  @override
  final String id;
  @override
  final String institutionId;
  @override
  final String? companyId;

  /// معلومات الملف
  @override
  final ImportFileType fileType;
  @override
  final String fileName;
  @override
  final int totalRows;

  /// الحالة
  @override
  final ImportStatus status;
  @override
  @JsonKey()
  final int processedRows;
  @override
  @JsonKey()
  final int successfulRows;
  @override
  @JsonKey()
  final int failedRows;

  /// تفاصيل الأخطاء
  final List<String> _errors;

  /// تفاصيل الأخطاء
  @override
  @JsonKey()
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  final Map<String, dynamic> _errorDetails;
  @override
  @JsonKey()
  Map<String, dynamic> get errorDetails {
    if (_errorDetails is EqualUnmodifiableMapView) return _errorDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_errorDetails);
  }

  /// معلومات المستخدم الذي قام بالاستيراد
  @override
  final String uploadedBy;
  @override
  final String uploaderName;
  @override
  @TimestampConverter()
  final DateTime uploadedAt;
  @override
  @TimestampConverter()
  final DateTime? completedAt;

  /// إعدادات ال Mapping
  @override
  final FieldMapping fieldMapping;

  /// خيارات الاستيراد
  @override
  @JsonKey()
  final bool updateExistingUsers;
  @override
  @JsonKey()
  final bool skipInvalidRows;
  @override
  final String? defaultRole;
  @override
  final String? defaultPassword;

  @override
  String toString() {
    return 'HRISImport(id: $id, institutionId: $institutionId, companyId: $companyId, fileType: $fileType, fileName: $fileName, totalRows: $totalRows, status: $status, processedRows: $processedRows, successfulRows: $successfulRows, failedRows: $failedRows, errors: $errors, errorDetails: $errorDetails, uploadedBy: $uploadedBy, uploaderName: $uploaderName, uploadedAt: $uploadedAt, completedAt: $completedAt, fieldMapping: $fieldMapping, updateExistingUsers: $updateExistingUsers, skipInvalidRows: $skipInvalidRows, defaultRole: $defaultRole, defaultPassword: $defaultPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HRISImportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.fileType, fileType) ||
                other.fileType == fileType) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.totalRows, totalRows) ||
                other.totalRows == totalRows) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.processedRows, processedRows) ||
                other.processedRows == processedRows) &&
            (identical(other.successfulRows, successfulRows) ||
                other.successfulRows == successfulRows) &&
            (identical(other.failedRows, failedRows) ||
                other.failedRows == failedRows) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            const DeepCollectionEquality().equals(
              other._errorDetails,
              _errorDetails,
            ) &&
            (identical(other.uploadedBy, uploadedBy) ||
                other.uploadedBy == uploadedBy) &&
            (identical(other.uploaderName, uploaderName) ||
                other.uploaderName == uploaderName) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.fieldMapping, fieldMapping) ||
                other.fieldMapping == fieldMapping) &&
            (identical(other.updateExistingUsers, updateExistingUsers) ||
                other.updateExistingUsers == updateExistingUsers) &&
            (identical(other.skipInvalidRows, skipInvalidRows) ||
                other.skipInvalidRows == skipInvalidRows) &&
            (identical(other.defaultRole, defaultRole) ||
                other.defaultRole == defaultRole) &&
            (identical(other.defaultPassword, defaultPassword) ||
                other.defaultPassword == defaultPassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    institutionId,
    companyId,
    fileType,
    fileName,
    totalRows,
    status,
    processedRows,
    successfulRows,
    failedRows,
    const DeepCollectionEquality().hash(_errors),
    const DeepCollectionEquality().hash(_errorDetails),
    uploadedBy,
    uploaderName,
    uploadedAt,
    completedAt,
    fieldMapping,
    updateExistingUsers,
    skipInvalidRows,
    defaultRole,
    defaultPassword,
  ]);

  /// Create a copy of HRISImport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HRISImportImplCopyWith<_$HRISImportImpl> get copyWith =>
      __$$HRISImportImplCopyWithImpl<_$HRISImportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HRISImportImplToJson(this);
  }
}

abstract class _HRISImport implements HRISImport {
  const factory _HRISImport({
    required final String id,
    required final String institutionId,
    final String? companyId,
    required final ImportFileType fileType,
    required final String fileName,
    required final int totalRows,
    required final ImportStatus status,
    final int processedRows,
    final int successfulRows,
    final int failedRows,
    final List<String> errors,
    final Map<String, dynamic> errorDetails,
    required final String uploadedBy,
    required final String uploaderName,
    @TimestampConverter() required final DateTime uploadedAt,
    @TimestampConverter() final DateTime? completedAt,
    required final FieldMapping fieldMapping,
    final bool updateExistingUsers,
    final bool skipInvalidRows,
    final String? defaultRole,
    final String? defaultPassword,
  }) = _$HRISImportImpl;

  factory _HRISImport.fromJson(Map<String, dynamic> json) =
      _$HRISImportImpl.fromJson;

  @override
  String get id;
  @override
  String get institutionId;
  @override
  String? get companyId;

  /// معلومات الملف
  @override
  ImportFileType get fileType;
  @override
  String get fileName;
  @override
  int get totalRows;

  /// الحالة
  @override
  ImportStatus get status;
  @override
  int get processedRows;
  @override
  int get successfulRows;
  @override
  int get failedRows;

  /// تفاصيل الأخطاء
  @override
  List<String> get errors;
  @override
  Map<String, dynamic> get errorDetails;

  /// معلومات المستخدم الذي قام بالاستيراد
  @override
  String get uploadedBy;
  @override
  String get uploaderName;
  @override
  @TimestampConverter()
  DateTime get uploadedAt;
  @override
  @TimestampConverter()
  DateTime? get completedAt;

  /// إعدادات ال Mapping
  @override
  FieldMapping get fieldMapping;

  /// خيارات الاستيراد
  @override
  bool get updateExistingUsers;
  @override
  bool get skipInvalidRows;
  @override
  String? get defaultRole;
  @override
  String? get defaultPassword;

  /// Create a copy of HRISImport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HRISImportImplCopyWith<_$HRISImportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FieldMapping _$FieldMappingFromJson(Map<String, dynamic> json) {
  return _FieldMapping.fromJson(json);
}

/// @nodoc
mixin _$FieldMapping {
  /// حقول إلزامية
  String get emailColumn => throw _privateConstructorUsedError;
  String get nameColumn => throw _privateConstructorUsedError;

  /// حقول اختيارية
  String? get roleColumn => throw _privateConstructorUsedError;
  String? get phoneColumn => throw _privateConstructorUsedError;
  String? get departmentColumn => throw _privateConstructorUsedError;
  String? get jobTitleColumn => throw _privateConstructorUsedError;
  String? get employeeIdColumn => throw _privateConstructorUsedError;
  String? get managerEmailColumn => throw _privateConstructorUsedError;

  /// حقول مخصصة
  Map<String, String> get customFields => throw _privateConstructorUsedError;

  /// Serializes this FieldMapping to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FieldMapping
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FieldMappingCopyWith<FieldMapping> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldMappingCopyWith<$Res> {
  factory $FieldMappingCopyWith(
    FieldMapping value,
    $Res Function(FieldMapping) then,
  ) = _$FieldMappingCopyWithImpl<$Res, FieldMapping>;
  @useResult
  $Res call({
    String emailColumn,
    String nameColumn,
    String? roleColumn,
    String? phoneColumn,
    String? departmentColumn,
    String? jobTitleColumn,
    String? employeeIdColumn,
    String? managerEmailColumn,
    Map<String, String> customFields,
  });
}

/// @nodoc
class _$FieldMappingCopyWithImpl<$Res, $Val extends FieldMapping>
    implements $FieldMappingCopyWith<$Res> {
  _$FieldMappingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FieldMapping
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailColumn = null,
    Object? nameColumn = null,
    Object? roleColumn = freezed,
    Object? phoneColumn = freezed,
    Object? departmentColumn = freezed,
    Object? jobTitleColumn = freezed,
    Object? employeeIdColumn = freezed,
    Object? managerEmailColumn = freezed,
    Object? customFields = null,
  }) {
    return _then(
      _value.copyWith(
            emailColumn: null == emailColumn
                ? _value.emailColumn
                : emailColumn // ignore: cast_nullable_to_non_nullable
                      as String,
            nameColumn: null == nameColumn
                ? _value.nameColumn
                : nameColumn // ignore: cast_nullable_to_non_nullable
                      as String,
            roleColumn: freezed == roleColumn
                ? _value.roleColumn
                : roleColumn // ignore: cast_nullable_to_non_nullable
                      as String?,
            phoneColumn: freezed == phoneColumn
                ? _value.phoneColumn
                : phoneColumn // ignore: cast_nullable_to_non_nullable
                      as String?,
            departmentColumn: freezed == departmentColumn
                ? _value.departmentColumn
                : departmentColumn // ignore: cast_nullable_to_non_nullable
                      as String?,
            jobTitleColumn: freezed == jobTitleColumn
                ? _value.jobTitleColumn
                : jobTitleColumn // ignore: cast_nullable_to_non_nullable
                      as String?,
            employeeIdColumn: freezed == employeeIdColumn
                ? _value.employeeIdColumn
                : employeeIdColumn // ignore: cast_nullable_to_non_nullable
                      as String?,
            managerEmailColumn: freezed == managerEmailColumn
                ? _value.managerEmailColumn
                : managerEmailColumn // ignore: cast_nullable_to_non_nullable
                      as String?,
            customFields: null == customFields
                ? _value.customFields
                : customFields // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FieldMappingImplCopyWith<$Res>
    implements $FieldMappingCopyWith<$Res> {
  factory _$$FieldMappingImplCopyWith(
    _$FieldMappingImpl value,
    $Res Function(_$FieldMappingImpl) then,
  ) = __$$FieldMappingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String emailColumn,
    String nameColumn,
    String? roleColumn,
    String? phoneColumn,
    String? departmentColumn,
    String? jobTitleColumn,
    String? employeeIdColumn,
    String? managerEmailColumn,
    Map<String, String> customFields,
  });
}

/// @nodoc
class __$$FieldMappingImplCopyWithImpl<$Res>
    extends _$FieldMappingCopyWithImpl<$Res, _$FieldMappingImpl>
    implements _$$FieldMappingImplCopyWith<$Res> {
  __$$FieldMappingImplCopyWithImpl(
    _$FieldMappingImpl _value,
    $Res Function(_$FieldMappingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FieldMapping
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailColumn = null,
    Object? nameColumn = null,
    Object? roleColumn = freezed,
    Object? phoneColumn = freezed,
    Object? departmentColumn = freezed,
    Object? jobTitleColumn = freezed,
    Object? employeeIdColumn = freezed,
    Object? managerEmailColumn = freezed,
    Object? customFields = null,
  }) {
    return _then(
      _$FieldMappingImpl(
        emailColumn: null == emailColumn
            ? _value.emailColumn
            : emailColumn // ignore: cast_nullable_to_non_nullable
                  as String,
        nameColumn: null == nameColumn
            ? _value.nameColumn
            : nameColumn // ignore: cast_nullable_to_non_nullable
                  as String,
        roleColumn: freezed == roleColumn
            ? _value.roleColumn
            : roleColumn // ignore: cast_nullable_to_non_nullable
                  as String?,
        phoneColumn: freezed == phoneColumn
            ? _value.phoneColumn
            : phoneColumn // ignore: cast_nullable_to_non_nullable
                  as String?,
        departmentColumn: freezed == departmentColumn
            ? _value.departmentColumn
            : departmentColumn // ignore: cast_nullable_to_non_nullable
                  as String?,
        jobTitleColumn: freezed == jobTitleColumn
            ? _value.jobTitleColumn
            : jobTitleColumn // ignore: cast_nullable_to_non_nullable
                  as String?,
        employeeIdColumn: freezed == employeeIdColumn
            ? _value.employeeIdColumn
            : employeeIdColumn // ignore: cast_nullable_to_non_nullable
                  as String?,
        managerEmailColumn: freezed == managerEmailColumn
            ? _value.managerEmailColumn
            : managerEmailColumn // ignore: cast_nullable_to_non_nullable
                  as String?,
        customFields: null == customFields
            ? _value._customFields
            : customFields // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FieldMappingImpl implements _FieldMapping {
  const _$FieldMappingImpl({
    required this.emailColumn,
    required this.nameColumn,
    this.roleColumn,
    this.phoneColumn,
    this.departmentColumn,
    this.jobTitleColumn,
    this.employeeIdColumn,
    this.managerEmailColumn,
    final Map<String, String> customFields = const {},
  }) : _customFields = customFields;

  factory _$FieldMappingImpl.fromJson(Map<String, dynamic> json) =>
      _$$FieldMappingImplFromJson(json);

  /// حقول إلزامية
  @override
  final String emailColumn;
  @override
  final String nameColumn;

  /// حقول اختيارية
  @override
  final String? roleColumn;
  @override
  final String? phoneColumn;
  @override
  final String? departmentColumn;
  @override
  final String? jobTitleColumn;
  @override
  final String? employeeIdColumn;
  @override
  final String? managerEmailColumn;

  /// حقول مخصصة
  final Map<String, String> _customFields;

  /// حقول مخصصة
  @override
  @JsonKey()
  Map<String, String> get customFields {
    if (_customFields is EqualUnmodifiableMapView) return _customFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customFields);
  }

  @override
  String toString() {
    return 'FieldMapping(emailColumn: $emailColumn, nameColumn: $nameColumn, roleColumn: $roleColumn, phoneColumn: $phoneColumn, departmentColumn: $departmentColumn, jobTitleColumn: $jobTitleColumn, employeeIdColumn: $employeeIdColumn, managerEmailColumn: $managerEmailColumn, customFields: $customFields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldMappingImpl &&
            (identical(other.emailColumn, emailColumn) ||
                other.emailColumn == emailColumn) &&
            (identical(other.nameColumn, nameColumn) ||
                other.nameColumn == nameColumn) &&
            (identical(other.roleColumn, roleColumn) ||
                other.roleColumn == roleColumn) &&
            (identical(other.phoneColumn, phoneColumn) ||
                other.phoneColumn == phoneColumn) &&
            (identical(other.departmentColumn, departmentColumn) ||
                other.departmentColumn == departmentColumn) &&
            (identical(other.jobTitleColumn, jobTitleColumn) ||
                other.jobTitleColumn == jobTitleColumn) &&
            (identical(other.employeeIdColumn, employeeIdColumn) ||
                other.employeeIdColumn == employeeIdColumn) &&
            (identical(other.managerEmailColumn, managerEmailColumn) ||
                other.managerEmailColumn == managerEmailColumn) &&
            const DeepCollectionEquality().equals(
              other._customFields,
              _customFields,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    emailColumn,
    nameColumn,
    roleColumn,
    phoneColumn,
    departmentColumn,
    jobTitleColumn,
    employeeIdColumn,
    managerEmailColumn,
    const DeepCollectionEquality().hash(_customFields),
  );

  /// Create a copy of FieldMapping
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldMappingImplCopyWith<_$FieldMappingImpl> get copyWith =>
      __$$FieldMappingImplCopyWithImpl<_$FieldMappingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FieldMappingImplToJson(this);
  }
}

abstract class _FieldMapping implements FieldMapping {
  const factory _FieldMapping({
    required final String emailColumn,
    required final String nameColumn,
    final String? roleColumn,
    final String? phoneColumn,
    final String? departmentColumn,
    final String? jobTitleColumn,
    final String? employeeIdColumn,
    final String? managerEmailColumn,
    final Map<String, String> customFields,
  }) = _$FieldMappingImpl;

  factory _FieldMapping.fromJson(Map<String, dynamic> json) =
      _$FieldMappingImpl.fromJson;

  /// حقول إلزامية
  @override
  String get emailColumn;
  @override
  String get nameColumn;

  /// حقول اختيارية
  @override
  String? get roleColumn;
  @override
  String? get phoneColumn;
  @override
  String? get departmentColumn;
  @override
  String? get jobTitleColumn;
  @override
  String? get employeeIdColumn;
  @override
  String? get managerEmailColumn;

  /// حقول مخصصة
  @override
  Map<String, String> get customFields;

  /// Create a copy of FieldMapping
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FieldMappingImplCopyWith<_$FieldMappingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ImportedUserRecord _$ImportedUserRecordFromJson(Map<String, dynamic> json) {
  return _ImportedUserRecord.fromJson(json);
}

/// @nodoc
mixin _$ImportedUserRecord {
  int get rowNumber => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// بيانات إضافية
  String? get role => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get department => throw _privateConstructorUsedError;
  String? get jobTitle => throw _privateConstructorUsedError;
  String? get employeeId => throw _privateConstructorUsedError;
  String? get managerEmail => throw _privateConstructorUsedError;

  /// حقول مخصصة
  Map<String, dynamic> get customData => throw _privateConstructorUsedError;

  /// حالة الاستيراد
  bool get isValid => throw _privateConstructorUsedError;
  List<String> get validationErrors => throw _privateConstructorUsedError;
  bool get isProcessed => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Serializes this ImportedUserRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImportedUserRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImportedUserRecordCopyWith<ImportedUserRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImportedUserRecordCopyWith<$Res> {
  factory $ImportedUserRecordCopyWith(
    ImportedUserRecord value,
    $Res Function(ImportedUserRecord) then,
  ) = _$ImportedUserRecordCopyWithImpl<$Res, ImportedUserRecord>;
  @useResult
  $Res call({
    int rowNumber,
    String email,
    String name,
    String? role,
    String? phone,
    String? department,
    String? jobTitle,
    String? employeeId,
    String? managerEmail,
    Map<String, dynamic> customData,
    bool isValid,
    List<String> validationErrors,
    bool isProcessed,
    bool isSuccess,
    String? userId,
    String? errorMessage,
  });
}

/// @nodoc
class _$ImportedUserRecordCopyWithImpl<$Res, $Val extends ImportedUserRecord>
    implements $ImportedUserRecordCopyWith<$Res> {
  _$ImportedUserRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImportedUserRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rowNumber = null,
    Object? email = null,
    Object? name = null,
    Object? role = freezed,
    Object? phone = freezed,
    Object? department = freezed,
    Object? jobTitle = freezed,
    Object? employeeId = freezed,
    Object? managerEmail = freezed,
    Object? customData = null,
    Object? isValid = null,
    Object? validationErrors = null,
    Object? isProcessed = null,
    Object? isSuccess = null,
    Object? userId = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            rowNumber: null == rowNumber
                ? _value.rowNumber
                : rowNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            department: freezed == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as String?,
            jobTitle: freezed == jobTitle
                ? _value.jobTitle
                : jobTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            employeeId: freezed == employeeId
                ? _value.employeeId
                : employeeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            managerEmail: freezed == managerEmail
                ? _value.managerEmail
                : managerEmail // ignore: cast_nullable_to_non_nullable
                      as String?,
            customData: null == customData
                ? _value.customData
                : customData // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            isValid: null == isValid
                ? _value.isValid
                : isValid // ignore: cast_nullable_to_non_nullable
                      as bool,
            validationErrors: null == validationErrors
                ? _value.validationErrors
                : validationErrors // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isProcessed: null == isProcessed
                ? _value.isProcessed
                : isProcessed // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSuccess: null == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$ImportedUserRecordImplCopyWith<$Res>
    implements $ImportedUserRecordCopyWith<$Res> {
  factory _$$ImportedUserRecordImplCopyWith(
    _$ImportedUserRecordImpl value,
    $Res Function(_$ImportedUserRecordImpl) then,
  ) = __$$ImportedUserRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int rowNumber,
    String email,
    String name,
    String? role,
    String? phone,
    String? department,
    String? jobTitle,
    String? employeeId,
    String? managerEmail,
    Map<String, dynamic> customData,
    bool isValid,
    List<String> validationErrors,
    bool isProcessed,
    bool isSuccess,
    String? userId,
    String? errorMessage,
  });
}

/// @nodoc
class __$$ImportedUserRecordImplCopyWithImpl<$Res>
    extends _$ImportedUserRecordCopyWithImpl<$Res, _$ImportedUserRecordImpl>
    implements _$$ImportedUserRecordImplCopyWith<$Res> {
  __$$ImportedUserRecordImplCopyWithImpl(
    _$ImportedUserRecordImpl _value,
    $Res Function(_$ImportedUserRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImportedUserRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rowNumber = null,
    Object? email = null,
    Object? name = null,
    Object? role = freezed,
    Object? phone = freezed,
    Object? department = freezed,
    Object? jobTitle = freezed,
    Object? employeeId = freezed,
    Object? managerEmail = freezed,
    Object? customData = null,
    Object? isValid = null,
    Object? validationErrors = null,
    Object? isProcessed = null,
    Object? isSuccess = null,
    Object? userId = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$ImportedUserRecordImpl(
        rowNumber: null == rowNumber
            ? _value.rowNumber
            : rowNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        department: freezed == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
                  as String?,
        jobTitle: freezed == jobTitle
            ? _value.jobTitle
            : jobTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        employeeId: freezed == employeeId
            ? _value.employeeId
            : employeeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        managerEmail: freezed == managerEmail
            ? _value.managerEmail
            : managerEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        customData: null == customData
            ? _value._customData
            : customData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        isValid: null == isValid
            ? _value.isValid
            : isValid // ignore: cast_nullable_to_non_nullable
                  as bool,
        validationErrors: null == validationErrors
            ? _value._validationErrors
            : validationErrors // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isProcessed: null == isProcessed
            ? _value.isProcessed
            : isProcessed // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSuccess: null == isSuccess
            ? _value.isSuccess
            : isSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$ImportedUserRecordImpl implements _ImportedUserRecord {
  const _$ImportedUserRecordImpl({
    required this.rowNumber,
    required this.email,
    required this.name,
    this.role,
    this.phone,
    this.department,
    this.jobTitle,
    this.employeeId,
    this.managerEmail,
    final Map<String, dynamic> customData = const {},
    this.isValid = false,
    final List<String> validationErrors = const [],
    this.isProcessed = false,
    this.isSuccess = false,
    this.userId,
    this.errorMessage,
  }) : _customData = customData,
       _validationErrors = validationErrors;

  factory _$ImportedUserRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImportedUserRecordImplFromJson(json);

  @override
  final int rowNumber;
  @override
  final String email;
  @override
  final String name;

  /// بيانات إضافية
  @override
  final String? role;
  @override
  final String? phone;
  @override
  final String? department;
  @override
  final String? jobTitle;
  @override
  final String? employeeId;
  @override
  final String? managerEmail;

  /// حقول مخصصة
  final Map<String, dynamic> _customData;

  /// حقول مخصصة
  @override
  @JsonKey()
  Map<String, dynamic> get customData {
    if (_customData is EqualUnmodifiableMapView) return _customData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customData);
  }

  /// حالة الاستيراد
  @override
  @JsonKey()
  final bool isValid;
  final List<String> _validationErrors;
  @override
  @JsonKey()
  List<String> get validationErrors {
    if (_validationErrors is EqualUnmodifiableListView)
      return _validationErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_validationErrors);
  }

  @override
  @JsonKey()
  final bool isProcessed;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  final String? userId;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ImportedUserRecord(rowNumber: $rowNumber, email: $email, name: $name, role: $role, phone: $phone, department: $department, jobTitle: $jobTitle, employeeId: $employeeId, managerEmail: $managerEmail, customData: $customData, isValid: $isValid, validationErrors: $validationErrors, isProcessed: $isProcessed, isSuccess: $isSuccess, userId: $userId, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImportedUserRecordImpl &&
            (identical(other.rowNumber, rowNumber) ||
                other.rowNumber == rowNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.managerEmail, managerEmail) ||
                other.managerEmail == managerEmail) &&
            const DeepCollectionEquality().equals(
              other._customData,
              _customData,
            ) &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            const DeepCollectionEquality().equals(
              other._validationErrors,
              _validationErrors,
            ) &&
            (identical(other.isProcessed, isProcessed) ||
                other.isProcessed == isProcessed) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    rowNumber,
    email,
    name,
    role,
    phone,
    department,
    jobTitle,
    employeeId,
    managerEmail,
    const DeepCollectionEquality().hash(_customData),
    isValid,
    const DeepCollectionEquality().hash(_validationErrors),
    isProcessed,
    isSuccess,
    userId,
    errorMessage,
  );

  /// Create a copy of ImportedUserRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImportedUserRecordImplCopyWith<_$ImportedUserRecordImpl> get copyWith =>
      __$$ImportedUserRecordImplCopyWithImpl<_$ImportedUserRecordImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ImportedUserRecordImplToJson(this);
  }
}

abstract class _ImportedUserRecord implements ImportedUserRecord {
  const factory _ImportedUserRecord({
    required final int rowNumber,
    required final String email,
    required final String name,
    final String? role,
    final String? phone,
    final String? department,
    final String? jobTitle,
    final String? employeeId,
    final String? managerEmail,
    final Map<String, dynamic> customData,
    final bool isValid,
    final List<String> validationErrors,
    final bool isProcessed,
    final bool isSuccess,
    final String? userId,
    final String? errorMessage,
  }) = _$ImportedUserRecordImpl;

  factory _ImportedUserRecord.fromJson(Map<String, dynamic> json) =
      _$ImportedUserRecordImpl.fromJson;

  @override
  int get rowNumber;
  @override
  String get email;
  @override
  String get name;

  /// بيانات إضافية
  @override
  String? get role;
  @override
  String? get phone;
  @override
  String? get department;
  @override
  String? get jobTitle;
  @override
  String? get employeeId;
  @override
  String? get managerEmail;

  /// حقول مخصصة
  @override
  Map<String, dynamic> get customData;

  /// حالة الاستيراد
  @override
  bool get isValid;
  @override
  List<String> get validationErrors;
  @override
  bool get isProcessed;
  @override
  bool get isSuccess;
  @override
  String? get userId;
  @override
  String? get errorMessage;

  /// Create a copy of ImportedUserRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImportedUserRecordImplCopyWith<_$ImportedUserRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ImportTemplate _$ImportTemplateFromJson(Map<String, dynamic> json) {
  return _ImportTemplate.fromJson(json);
}

/// @nodoc
mixin _$ImportTemplate {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  FieldMapping get fieldMapping => throw _privateConstructorUsedError;
  String get institutionId => throw _privateConstructorUsedError;
  String? get companyId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;

  /// Serializes this ImportTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImportTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImportTemplateCopyWith<ImportTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImportTemplateCopyWith<$Res> {
  factory $ImportTemplateCopyWith(
    ImportTemplate value,
    $Res Function(ImportTemplate) then,
  ) = _$ImportTemplateCopyWithImpl<$Res, ImportTemplate>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    FieldMapping fieldMapping,
    String institutionId,
    String? companyId,
    @TimestampConverter() DateTime createdAt,
    String createdBy,
  });

  $FieldMappingCopyWith<$Res> get fieldMapping;
}

/// @nodoc
class _$ImportTemplateCopyWithImpl<$Res, $Val extends ImportTemplate>
    implements $ImportTemplateCopyWith<$Res> {
  _$ImportTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImportTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? fieldMapping = null,
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? createdAt = null,
    Object? createdBy = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            fieldMapping: null == fieldMapping
                ? _value.fieldMapping
                : fieldMapping // ignore: cast_nullable_to_non_nullable
                      as FieldMapping,
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: freezed == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of ImportTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FieldMappingCopyWith<$Res> get fieldMapping {
    return $FieldMappingCopyWith<$Res>(_value.fieldMapping, (value) {
      return _then(_value.copyWith(fieldMapping: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ImportTemplateImplCopyWith<$Res>
    implements $ImportTemplateCopyWith<$Res> {
  factory _$$ImportTemplateImplCopyWith(
    _$ImportTemplateImpl value,
    $Res Function(_$ImportTemplateImpl) then,
  ) = __$$ImportTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    FieldMapping fieldMapping,
    String institutionId,
    String? companyId,
    @TimestampConverter() DateTime createdAt,
    String createdBy,
  });

  @override
  $FieldMappingCopyWith<$Res> get fieldMapping;
}

/// @nodoc
class __$$ImportTemplateImplCopyWithImpl<$Res>
    extends _$ImportTemplateCopyWithImpl<$Res, _$ImportTemplateImpl>
    implements _$$ImportTemplateImplCopyWith<$Res> {
  __$$ImportTemplateImplCopyWithImpl(
    _$ImportTemplateImpl _value,
    $Res Function(_$ImportTemplateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImportTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? fieldMapping = null,
    Object? institutionId = null,
    Object? companyId = freezed,
    Object? createdAt = null,
    Object? createdBy = null,
  }) {
    return _then(
      _$ImportTemplateImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        fieldMapping: null == fieldMapping
            ? _value.fieldMapping
            : fieldMapping // ignore: cast_nullable_to_non_nullable
                  as FieldMapping,
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: freezed == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ImportTemplateImpl implements _ImportTemplate {
  const _$ImportTemplateImpl({
    required this.id,
    required this.name,
    this.description,
    required this.fieldMapping,
    required this.institutionId,
    this.companyId,
    @TimestampConverter() required this.createdAt,
    required this.createdBy,
  });

  factory _$ImportTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImportTemplateImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final FieldMapping fieldMapping;
  @override
  final String institutionId;
  @override
  final String? companyId;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  final String createdBy;

  @override
  String toString() {
    return 'ImportTemplate(id: $id, name: $name, description: $description, fieldMapping: $fieldMapping, institutionId: $institutionId, companyId: $companyId, createdAt: $createdAt, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImportTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.fieldMapping, fieldMapping) ||
                other.fieldMapping == fieldMapping) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    fieldMapping,
    institutionId,
    companyId,
    createdAt,
    createdBy,
  );

  /// Create a copy of ImportTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImportTemplateImplCopyWith<_$ImportTemplateImpl> get copyWith =>
      __$$ImportTemplateImplCopyWithImpl<_$ImportTemplateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ImportTemplateImplToJson(this);
  }
}

abstract class _ImportTemplate implements ImportTemplate {
  const factory _ImportTemplate({
    required final String id,
    required final String name,
    final String? description,
    required final FieldMapping fieldMapping,
    required final String institutionId,
    final String? companyId,
    @TimestampConverter() required final DateTime createdAt,
    required final String createdBy,
  }) = _$ImportTemplateImpl;

  factory _ImportTemplate.fromJson(Map<String, dynamic> json) =
      _$ImportTemplateImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  FieldMapping get fieldMapping;
  @override
  String get institutionId;
  @override
  String? get companyId;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  String get createdBy;

  /// Create a copy of ImportTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImportTemplateImplCopyWith<_$ImportTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
