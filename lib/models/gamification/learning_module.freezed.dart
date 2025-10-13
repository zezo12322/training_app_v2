// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learning_module.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LearningModule _$LearningModuleFromJson(Map<String, dynamic> json) {
  return _LearningModule.fromJson(json);
}

/// @nodoc
mixin _$LearningModule {
  /// معرف الوحدة
  String? get id => throw _privateConstructorUsedError;

  /// معرف الكورس
  String get courseId => throw _privateConstructorUsedError;

  /// عنوان الوحدة
  String get title => throw _privateConstructorUsedError;

  /// وصف الوحدة
  String get description => throw _privateConstructorUsedError;

  /// ترتيب الوحدة في الكورس
  int get orderIndex => throw _privateConstructorUsedError;

  /// محتويات الوحدة
  List<ModuleContent> get contents => throw _privateConstructorUsedError;

  /// متطلبات إتمام الوحدة
  ModuleRequirements get requirements => throw _privateConstructorUsedError;

  /// نقاط إتمام الوحدة
  int get completionPoints => throw _privateConstructorUsedError;

  /// هل الوحدة نشطة
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this LearningModule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LearningModule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LearningModuleCopyWith<LearningModule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LearningModuleCopyWith<$Res> {
  factory $LearningModuleCopyWith(
    LearningModule value,
    $Res Function(LearningModule) then,
  ) = _$LearningModuleCopyWithImpl<$Res, LearningModule>;
  @useResult
  $Res call({
    String? id,
    String courseId,
    String title,
    String description,
    int orderIndex,
    List<ModuleContent> contents,
    ModuleRequirements requirements,
    int completionPoints,
    bool isActive,
  });

  $ModuleRequirementsCopyWith<$Res> get requirements;
}

/// @nodoc
class _$LearningModuleCopyWithImpl<$Res, $Val extends LearningModule>
    implements $LearningModuleCopyWith<$Res> {
  _$LearningModuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LearningModule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? courseId = null,
    Object? title = null,
    Object? description = null,
    Object? orderIndex = null,
    Object? contents = null,
    Object? requirements = null,
    Object? completionPoints = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            orderIndex: null == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            contents: null == contents
                ? _value.contents
                : contents // ignore: cast_nullable_to_non_nullable
                      as List<ModuleContent>,
            requirements: null == requirements
                ? _value.requirements
                : requirements // ignore: cast_nullable_to_non_nullable
                      as ModuleRequirements,
            completionPoints: null == completionPoints
                ? _value.completionPoints
                : completionPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of LearningModule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ModuleRequirementsCopyWith<$Res> get requirements {
    return $ModuleRequirementsCopyWith<$Res>(_value.requirements, (value) {
      return _then(_value.copyWith(requirements: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LearningModuleImplCopyWith<$Res>
    implements $LearningModuleCopyWith<$Res> {
  factory _$$LearningModuleImplCopyWith(
    _$LearningModuleImpl value,
    $Res Function(_$LearningModuleImpl) then,
  ) = __$$LearningModuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String courseId,
    String title,
    String description,
    int orderIndex,
    List<ModuleContent> contents,
    ModuleRequirements requirements,
    int completionPoints,
    bool isActive,
  });

  @override
  $ModuleRequirementsCopyWith<$Res> get requirements;
}

/// @nodoc
class __$$LearningModuleImplCopyWithImpl<$Res>
    extends _$LearningModuleCopyWithImpl<$Res, _$LearningModuleImpl>
    implements _$$LearningModuleImplCopyWith<$Res> {
  __$$LearningModuleImplCopyWithImpl(
    _$LearningModuleImpl _value,
    $Res Function(_$LearningModuleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LearningModule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? courseId = null,
    Object? title = null,
    Object? description = null,
    Object? orderIndex = null,
    Object? contents = null,
    Object? requirements = null,
    Object? completionPoints = null,
    Object? isActive = null,
  }) {
    return _then(
      _$LearningModuleImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        orderIndex: null == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        contents: null == contents
            ? _value._contents
            : contents // ignore: cast_nullable_to_non_nullable
                  as List<ModuleContent>,
        requirements: null == requirements
            ? _value.requirements
            : requirements // ignore: cast_nullable_to_non_nullable
                  as ModuleRequirements,
        completionPoints: null == completionPoints
            ? _value.completionPoints
            : completionPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LearningModuleImpl implements _LearningModule {
  const _$LearningModuleImpl({
    this.id,
    required this.courseId,
    required this.title,
    this.description = '',
    required this.orderIndex,
    final List<ModuleContent> contents = const [],
    required this.requirements,
    this.completionPoints = 100,
    this.isActive = true,
  }) : _contents = contents;

  factory _$LearningModuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$LearningModuleImplFromJson(json);

  /// معرف الوحدة
  @override
  final String? id;

  /// معرف الكورس
  @override
  final String courseId;

  /// عنوان الوحدة
  @override
  final String title;

  /// وصف الوحدة
  @override
  @JsonKey()
  final String description;

  /// ترتيب الوحدة في الكورس
  @override
  final int orderIndex;

  /// محتويات الوحدة
  final List<ModuleContent> _contents;

  /// محتويات الوحدة
  @override
  @JsonKey()
  List<ModuleContent> get contents {
    if (_contents is EqualUnmodifiableListView) return _contents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contents);
  }

  /// متطلبات إتمام الوحدة
  @override
  final ModuleRequirements requirements;

  /// نقاط إتمام الوحدة
  @override
  @JsonKey()
  final int completionPoints;

  /// هل الوحدة نشطة
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'LearningModule(id: $id, courseId: $courseId, title: $title, description: $description, orderIndex: $orderIndex, contents: $contents, requirements: $requirements, completionPoints: $completionPoints, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LearningModuleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            const DeepCollectionEquality().equals(other._contents, _contents) &&
            (identical(other.requirements, requirements) ||
                other.requirements == requirements) &&
            (identical(other.completionPoints, completionPoints) ||
                other.completionPoints == completionPoints) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    courseId,
    title,
    description,
    orderIndex,
    const DeepCollectionEquality().hash(_contents),
    requirements,
    completionPoints,
    isActive,
  );

  /// Create a copy of LearningModule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LearningModuleImplCopyWith<_$LearningModuleImpl> get copyWith =>
      __$$LearningModuleImplCopyWithImpl<_$LearningModuleImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LearningModuleImplToJson(this);
  }
}

abstract class _LearningModule implements LearningModule {
  const factory _LearningModule({
    final String? id,
    required final String courseId,
    required final String title,
    final String description,
    required final int orderIndex,
    final List<ModuleContent> contents,
    required final ModuleRequirements requirements,
    final int completionPoints,
    final bool isActive,
  }) = _$LearningModuleImpl;

  factory _LearningModule.fromJson(Map<String, dynamic> json) =
      _$LearningModuleImpl.fromJson;

  /// معرف الوحدة
  @override
  String? get id;

  /// معرف الكورس
  @override
  String get courseId;

  /// عنوان الوحدة
  @override
  String get title;

  /// وصف الوحدة
  @override
  String get description;

  /// ترتيب الوحدة في الكورس
  @override
  int get orderIndex;

  /// محتويات الوحدة
  @override
  List<ModuleContent> get contents;

  /// متطلبات إتمام الوحدة
  @override
  ModuleRequirements get requirements;

  /// نقاط إتمام الوحدة
  @override
  int get completionPoints;

  /// هل الوحدة نشطة
  @override
  bool get isActive;

  /// Create a copy of LearningModule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LearningModuleImplCopyWith<_$LearningModuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ModuleContent _$ModuleContentFromJson(Map<String, dynamic> json) {
  return _ModuleContent.fromJson(json);
}

/// @nodoc
mixin _$ModuleContent {
  /// معرف المحتوى
  String get id => throw _privateConstructorUsedError;

  /// نوع المحتوى
  ModuleContentType get type => throw _privateConstructorUsedError;

  /// العنوان
  String get title => throw _privateConstructorUsedError;

  /// الترتيب داخل الوحدة
  int get orderIndex => throw _privateConstructorUsedError;

  /// هل المحتوى إجباري
  bool get isRequired => throw _privateConstructorUsedError;

  /// هل تم إتمامه
  bool get isCompleted => throw _privateConstructorUsedError;

  /// Serializes this ModuleContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ModuleContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModuleContentCopyWith<ModuleContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModuleContentCopyWith<$Res> {
  factory $ModuleContentCopyWith(
    ModuleContent value,
    $Res Function(ModuleContent) then,
  ) = _$ModuleContentCopyWithImpl<$Res, ModuleContent>;
  @useResult
  $Res call({
    String id,
    ModuleContentType type,
    String title,
    int orderIndex,
    bool isRequired,
    bool isCompleted,
  });
}

/// @nodoc
class _$ModuleContentCopyWithImpl<$Res, $Val extends ModuleContent>
    implements $ModuleContentCopyWith<$Res> {
  _$ModuleContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModuleContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? orderIndex = null,
    Object? isRequired = null,
    Object? isCompleted = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ModuleContentType,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            orderIndex: null == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            isRequired: null == isRequired
                ? _value.isRequired
                : isRequired // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ModuleContentImplCopyWith<$Res>
    implements $ModuleContentCopyWith<$Res> {
  factory _$$ModuleContentImplCopyWith(
    _$ModuleContentImpl value,
    $Res Function(_$ModuleContentImpl) then,
  ) = __$$ModuleContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    ModuleContentType type,
    String title,
    int orderIndex,
    bool isRequired,
    bool isCompleted,
  });
}

/// @nodoc
class __$$ModuleContentImplCopyWithImpl<$Res>
    extends _$ModuleContentCopyWithImpl<$Res, _$ModuleContentImpl>
    implements _$$ModuleContentImplCopyWith<$Res> {
  __$$ModuleContentImplCopyWithImpl(
    _$ModuleContentImpl _value,
    $Res Function(_$ModuleContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ModuleContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? orderIndex = null,
    Object? isRequired = null,
    Object? isCompleted = null,
  }) {
    return _then(
      _$ModuleContentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ModuleContentType,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        orderIndex: null == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        isRequired: null == isRequired
            ? _value.isRequired
            : isRequired // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ModuleContentImpl implements _ModuleContent {
  const _$ModuleContentImpl({
    required this.id,
    required this.type,
    required this.title,
    required this.orderIndex,
    this.isRequired = true,
    this.isCompleted = false,
  });

  factory _$ModuleContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModuleContentImplFromJson(json);

  /// معرف المحتوى
  @override
  final String id;

  /// نوع المحتوى
  @override
  final ModuleContentType type;

  /// العنوان
  @override
  final String title;

  /// الترتيب داخل الوحدة
  @override
  final int orderIndex;

  /// هل المحتوى إجباري
  @override
  @JsonKey()
  final bool isRequired;

  /// هل تم إتمامه
  @override
  @JsonKey()
  final bool isCompleted;

  @override
  String toString() {
    return 'ModuleContent(id: $id, type: $type, title: $title, orderIndex: $orderIndex, isRequired: $isRequired, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModuleContentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    title,
    orderIndex,
    isRequired,
    isCompleted,
  );

  /// Create a copy of ModuleContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModuleContentImplCopyWith<_$ModuleContentImpl> get copyWith =>
      __$$ModuleContentImplCopyWithImpl<_$ModuleContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModuleContentImplToJson(this);
  }
}

abstract class _ModuleContent implements ModuleContent {
  const factory _ModuleContent({
    required final String id,
    required final ModuleContentType type,
    required final String title,
    required final int orderIndex,
    final bool isRequired,
    final bool isCompleted,
  }) = _$ModuleContentImpl;

  factory _ModuleContent.fromJson(Map<String, dynamic> json) =
      _$ModuleContentImpl.fromJson;

  /// معرف المحتوى
  @override
  String get id;

  /// نوع المحتوى
  @override
  ModuleContentType get type;

  /// العنوان
  @override
  String get title;

  /// الترتيب داخل الوحدة
  @override
  int get orderIndex;

  /// هل المحتوى إجباري
  @override
  bool get isRequired;

  /// هل تم إتمامه
  @override
  bool get isCompleted;

  /// Create a copy of ModuleContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModuleContentImplCopyWith<_$ModuleContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ModuleRequirements _$ModuleRequirementsFromJson(Map<String, dynamic> json) {
  return _ModuleRequirements.fromJson(json);
}

/// @nodoc
mixin _$ModuleRequirements {
  /// إتمام كل الدروس الإجبارية
  bool get completeLessons => throw _privateConstructorUsedError;

  /// اجتياز كل الاختبارات
  bool get passAllQuizzes => throw _privateConstructorUsedError;

  /// النسبة المئوية المطلوبة في الاختبارات
  int get minimumQuizScore => throw _privateConstructorUsedError;

  /// إتمام المهام الإجبارية
  bool get completeAssignments => throw _privateConstructorUsedError;

  /// Serializes this ModuleRequirements to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ModuleRequirements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModuleRequirementsCopyWith<ModuleRequirements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModuleRequirementsCopyWith<$Res> {
  factory $ModuleRequirementsCopyWith(
    ModuleRequirements value,
    $Res Function(ModuleRequirements) then,
  ) = _$ModuleRequirementsCopyWithImpl<$Res, ModuleRequirements>;
  @useResult
  $Res call({
    bool completeLessons,
    bool passAllQuizzes,
    int minimumQuizScore,
    bool completeAssignments,
  });
}

/// @nodoc
class _$ModuleRequirementsCopyWithImpl<$Res, $Val extends ModuleRequirements>
    implements $ModuleRequirementsCopyWith<$Res> {
  _$ModuleRequirementsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModuleRequirements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completeLessons = null,
    Object? passAllQuizzes = null,
    Object? minimumQuizScore = null,
    Object? completeAssignments = null,
  }) {
    return _then(
      _value.copyWith(
            completeLessons: null == completeLessons
                ? _value.completeLessons
                : completeLessons // ignore: cast_nullable_to_non_nullable
                      as bool,
            passAllQuizzes: null == passAllQuizzes
                ? _value.passAllQuizzes
                : passAllQuizzes // ignore: cast_nullable_to_non_nullable
                      as bool,
            minimumQuizScore: null == minimumQuizScore
                ? _value.minimumQuizScore
                : minimumQuizScore // ignore: cast_nullable_to_non_nullable
                      as int,
            completeAssignments: null == completeAssignments
                ? _value.completeAssignments
                : completeAssignments // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ModuleRequirementsImplCopyWith<$Res>
    implements $ModuleRequirementsCopyWith<$Res> {
  factory _$$ModuleRequirementsImplCopyWith(
    _$ModuleRequirementsImpl value,
    $Res Function(_$ModuleRequirementsImpl) then,
  ) = __$$ModuleRequirementsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool completeLessons,
    bool passAllQuizzes,
    int minimumQuizScore,
    bool completeAssignments,
  });
}

/// @nodoc
class __$$ModuleRequirementsImplCopyWithImpl<$Res>
    extends _$ModuleRequirementsCopyWithImpl<$Res, _$ModuleRequirementsImpl>
    implements _$$ModuleRequirementsImplCopyWith<$Res> {
  __$$ModuleRequirementsImplCopyWithImpl(
    _$ModuleRequirementsImpl _value,
    $Res Function(_$ModuleRequirementsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ModuleRequirements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completeLessons = null,
    Object? passAllQuizzes = null,
    Object? minimumQuizScore = null,
    Object? completeAssignments = null,
  }) {
    return _then(
      _$ModuleRequirementsImpl(
        completeLessons: null == completeLessons
            ? _value.completeLessons
            : completeLessons // ignore: cast_nullable_to_non_nullable
                  as bool,
        passAllQuizzes: null == passAllQuizzes
            ? _value.passAllQuizzes
            : passAllQuizzes // ignore: cast_nullable_to_non_nullable
                  as bool,
        minimumQuizScore: null == minimumQuizScore
            ? _value.minimumQuizScore
            : minimumQuizScore // ignore: cast_nullable_to_non_nullable
                  as int,
        completeAssignments: null == completeAssignments
            ? _value.completeAssignments
            : completeAssignments // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ModuleRequirementsImpl implements _ModuleRequirements {
  const _$ModuleRequirementsImpl({
    this.completeLessons = true,
    this.passAllQuizzes = true,
    this.minimumQuizScore = 70,
    this.completeAssignments = true,
  });

  factory _$ModuleRequirementsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModuleRequirementsImplFromJson(json);

  /// إتمام كل الدروس الإجبارية
  @override
  @JsonKey()
  final bool completeLessons;

  /// اجتياز كل الاختبارات
  @override
  @JsonKey()
  final bool passAllQuizzes;

  /// النسبة المئوية المطلوبة في الاختبارات
  @override
  @JsonKey()
  final int minimumQuizScore;

  /// إتمام المهام الإجبارية
  @override
  @JsonKey()
  final bool completeAssignments;

  @override
  String toString() {
    return 'ModuleRequirements(completeLessons: $completeLessons, passAllQuizzes: $passAllQuizzes, minimumQuizScore: $minimumQuizScore, completeAssignments: $completeAssignments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModuleRequirementsImpl &&
            (identical(other.completeLessons, completeLessons) ||
                other.completeLessons == completeLessons) &&
            (identical(other.passAllQuizzes, passAllQuizzes) ||
                other.passAllQuizzes == passAllQuizzes) &&
            (identical(other.minimumQuizScore, minimumQuizScore) ||
                other.minimumQuizScore == minimumQuizScore) &&
            (identical(other.completeAssignments, completeAssignments) ||
                other.completeAssignments == completeAssignments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    completeLessons,
    passAllQuizzes,
    minimumQuizScore,
    completeAssignments,
  );

  /// Create a copy of ModuleRequirements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModuleRequirementsImplCopyWith<_$ModuleRequirementsImpl> get copyWith =>
      __$$ModuleRequirementsImplCopyWithImpl<_$ModuleRequirementsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ModuleRequirementsImplToJson(this);
  }
}

abstract class _ModuleRequirements implements ModuleRequirements {
  const factory _ModuleRequirements({
    final bool completeLessons,
    final bool passAllQuizzes,
    final int minimumQuizScore,
    final bool completeAssignments,
  }) = _$ModuleRequirementsImpl;

  factory _ModuleRequirements.fromJson(Map<String, dynamic> json) =
      _$ModuleRequirementsImpl.fromJson;

  /// إتمام كل الدروس الإجبارية
  @override
  bool get completeLessons;

  /// اجتياز كل الاختبارات
  @override
  bool get passAllQuizzes;

  /// النسبة المئوية المطلوبة في الاختبارات
  @override
  int get minimumQuizScore;

  /// إتمام المهام الإجبارية
  @override
  bool get completeAssignments;

  /// Create a copy of ModuleRequirements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModuleRequirementsImplCopyWith<_$ModuleRequirementsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
