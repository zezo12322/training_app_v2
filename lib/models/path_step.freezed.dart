// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'path_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PathStep _$PathStepFromJson(Map<String, dynamic> json) {
  return _PathStep.fromJson(json);
}

/// @nodoc
mixin _$PathStep {
  String get id => throw _privateConstructorUsedError;
  String get pathId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description =>
      throw _privateConstructorUsedError; // Added description
  PathStepType get type => throw _privateConstructorUsedError;
  String? get resourceId =>
      throw _privateConstructorUsedError; // Made optional as it might not always exist
  int get order => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PathStep to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PathStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PathStepCopyWith<PathStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PathStepCopyWith<$Res> {
  factory $PathStepCopyWith(PathStep value, $Res Function(PathStep) then) =
      _$PathStepCopyWithImpl<$Res, PathStep>;
  @useResult
  $Res call({
    String id,
    String pathId,
    String title,
    String? description,
    PathStepType type,
    String? resourceId,
    int order,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  });
}

/// @nodoc
class _$PathStepCopyWithImpl<$Res, $Val extends PathStep>
    implements $PathStepCopyWith<$Res> {
  _$PathStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PathStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pathId = null,
    Object? title = null,
    Object? description = freezed,
    Object? type = null,
    Object? resourceId = freezed,
    Object? order = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            pathId: null == pathId
                ? _value.pathId
                : pathId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as PathStepType,
            resourceId: freezed == resourceId
                ? _value.resourceId
                : resourceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PathStepImplCopyWith<$Res>
    implements $PathStepCopyWith<$Res> {
  factory _$$PathStepImplCopyWith(
    _$PathStepImpl value,
    $Res Function(_$PathStepImpl) then,
  ) = __$$PathStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String pathId,
    String title,
    String? description,
    PathStepType type,
    String? resourceId,
    int order,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  });
}

/// @nodoc
class __$$PathStepImplCopyWithImpl<$Res>
    extends _$PathStepCopyWithImpl<$Res, _$PathStepImpl>
    implements _$$PathStepImplCopyWith<$Res> {
  __$$PathStepImplCopyWithImpl(
    _$PathStepImpl _value,
    $Res Function(_$PathStepImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PathStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pathId = null,
    Object? title = null,
    Object? description = freezed,
    Object? type = null,
    Object? resourceId = freezed,
    Object? order = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$PathStepImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        pathId: null == pathId
            ? _value.pathId
            : pathId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as PathStepType,
        resourceId: freezed == resourceId
            ? _value.resourceId
            : resourceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PathStepImpl extends _PathStep {
  const _$PathStepImpl({
    required this.id,
    required this.pathId,
    required this.title,
    this.description,
    this.type = PathStepType.task,
    this.resourceId,
    required this.order,
    @TimestampConverter() this.createdAt,
    @TimestampConverter() this.updatedAt,
  }) : super._();

  factory _$PathStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$PathStepImplFromJson(json);

  @override
  final String id;
  @override
  final String pathId;
  @override
  final String title;
  @override
  final String? description;
  // Added description
  @override
  @JsonKey()
  final PathStepType type;
  @override
  final String? resourceId;
  // Made optional as it might not always exist
  @override
  final int order;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PathStep(id: $id, pathId: $pathId, title: $title, description: $description, type: $type, resourceId: $resourceId, order: $order, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PathStepImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pathId, pathId) || other.pathId == pathId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.resourceId, resourceId) ||
                other.resourceId == resourceId) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    pathId,
    title,
    description,
    type,
    resourceId,
    order,
    createdAt,
    updatedAt,
  );

  /// Create a copy of PathStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PathStepImplCopyWith<_$PathStepImpl> get copyWith =>
      __$$PathStepImplCopyWithImpl<_$PathStepImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PathStepImplToJson(this);
  }
}

abstract class _PathStep extends PathStep {
  const factory _PathStep({
    required final String id,
    required final String pathId,
    required final String title,
    final String? description,
    final PathStepType type,
    final String? resourceId,
    required final int order,
    @TimestampConverter() final DateTime? createdAt,
    @TimestampConverter() final DateTime? updatedAt,
  }) = _$PathStepImpl;
  const _PathStep._() : super._();

  factory _PathStep.fromJson(Map<String, dynamic> json) =
      _$PathStepImpl.fromJson;

  @override
  String get id;
  @override
  String get pathId;
  @override
  String get title;
  @override
  String? get description; // Added description
  @override
  PathStepType get type;
  @override
  String? get resourceId; // Made optional as it might not always exist
  @override
  int get order;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;

  /// Create a copy of PathStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PathStepImplCopyWith<_$PathStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
