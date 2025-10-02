// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'evaluation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EvaluationModel _$EvaluationModelFromJson(Map<String, dynamic> json) {
  return _EvaluationModel.fromJson(json);
}

/// @nodoc
mixin _$EvaluationModel {
  String get id => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  String get traineeId => throw _privateConstructorUsedError;
  String get trainerId => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  String get feedback => throw _privateConstructorUsedError;
  String? get audioUrl => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this EvaluationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EvaluationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EvaluationModelCopyWith<EvaluationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EvaluationModelCopyWith<$Res> {
  factory $EvaluationModelCopyWith(
    EvaluationModel value,
    $Res Function(EvaluationModel) then,
  ) = _$EvaluationModelCopyWithImpl<$Res, EvaluationModel>;
  @useResult
  $Res call({
    String id,
    String courseId,
    String traineeId,
    String trainerId,
    int score,
    String feedback,
    String? audioUrl,
    @TimestampConverter() DateTime? createdAt,
  });
}

/// @nodoc
class _$EvaluationModelCopyWithImpl<$Res, $Val extends EvaluationModel>
    implements $EvaluationModelCopyWith<$Res> {
  _$EvaluationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EvaluationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? traineeId = null,
    Object? trainerId = null,
    Object? score = null,
    Object? feedback = null,
    Object? audioUrl = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            traineeId: null == traineeId
                ? _value.traineeId
                : traineeId // ignore: cast_nullable_to_non_nullable
                      as String,
            trainerId: null == trainerId
                ? _value.trainerId
                : trainerId // ignore: cast_nullable_to_non_nullable
                      as String,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int,
            feedback: null == feedback
                ? _value.feedback
                : feedback // ignore: cast_nullable_to_non_nullable
                      as String,
            audioUrl: freezed == audioUrl
                ? _value.audioUrl
                : audioUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EvaluationModelImplCopyWith<$Res>
    implements $EvaluationModelCopyWith<$Res> {
  factory _$$EvaluationModelImplCopyWith(
    _$EvaluationModelImpl value,
    $Res Function(_$EvaluationModelImpl) then,
  ) = __$$EvaluationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String courseId,
    String traineeId,
    String trainerId,
    int score,
    String feedback,
    String? audioUrl,
    @TimestampConverter() DateTime? createdAt,
  });
}

/// @nodoc
class __$$EvaluationModelImplCopyWithImpl<$Res>
    extends _$EvaluationModelCopyWithImpl<$Res, _$EvaluationModelImpl>
    implements _$$EvaluationModelImplCopyWith<$Res> {
  __$$EvaluationModelImplCopyWithImpl(
    _$EvaluationModelImpl _value,
    $Res Function(_$EvaluationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EvaluationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? traineeId = null,
    Object? trainerId = null,
    Object? score = null,
    Object? feedback = null,
    Object? audioUrl = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$EvaluationModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        traineeId: null == traineeId
            ? _value.traineeId
            : traineeId // ignore: cast_nullable_to_non_nullable
                  as String,
        trainerId: null == trainerId
            ? _value.trainerId
            : trainerId // ignore: cast_nullable_to_non_nullable
                  as String,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int,
        feedback: null == feedback
            ? _value.feedback
            : feedback // ignore: cast_nullable_to_non_nullable
                  as String,
        audioUrl: freezed == audioUrl
            ? _value.audioUrl
            : audioUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EvaluationModelImpl extends _EvaluationModel {
  const _$EvaluationModelImpl({
    required this.id,
    required this.courseId,
    required this.traineeId,
    required this.trainerId,
    required this.score,
    required this.feedback,
    this.audioUrl,
    @TimestampConverter() this.createdAt,
  }) : super._();

  factory _$EvaluationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EvaluationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String courseId;
  @override
  final String traineeId;
  @override
  final String trainerId;
  @override
  final int score;
  @override
  final String feedback;
  @override
  final String? audioUrl;
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'EvaluationModel(id: $id, courseId: $courseId, traineeId: $traineeId, trainerId: $trainerId, score: $score, feedback: $feedback, audioUrl: $audioUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EvaluationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.traineeId, traineeId) ||
                other.traineeId == traineeId) &&
            (identical(other.trainerId, trainerId) ||
                other.trainerId == trainerId) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    courseId,
    traineeId,
    trainerId,
    score,
    feedback,
    audioUrl,
    createdAt,
  );

  /// Create a copy of EvaluationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EvaluationModelImplCopyWith<_$EvaluationModelImpl> get copyWith =>
      __$$EvaluationModelImplCopyWithImpl<_$EvaluationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EvaluationModelImplToJson(this);
  }
}

abstract class _EvaluationModel extends EvaluationModel {
  const factory _EvaluationModel({
    required final String id,
    required final String courseId,
    required final String traineeId,
    required final String trainerId,
    required final int score,
    required final String feedback,
    final String? audioUrl,
    @TimestampConverter() final DateTime? createdAt,
  }) = _$EvaluationModelImpl;
  const _EvaluationModel._() : super._();

  factory _EvaluationModel.fromJson(Map<String, dynamic> json) =
      _$EvaluationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get courseId;
  @override
  String get traineeId;
  @override
  String get trainerId;
  @override
  int get score;
  @override
  String get feedback;
  @override
  String? get audioUrl;
  @override
  @TimestampConverter()
  DateTime? get createdAt;

  /// Create a copy of EvaluationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EvaluationModelImplCopyWith<_$EvaluationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
