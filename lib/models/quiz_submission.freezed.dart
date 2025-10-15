// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_submission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuizSubmission _$QuizSubmissionFromJson(Map<String, dynamic> json) {
  return _QuizSubmission.fromJson(json);
}

/// @nodoc
mixin _$QuizSubmission {
  String get id => throw _privateConstructorUsedError;
  String get quizId => throw _privateConstructorUsedError;
  String get traineeId => throw _privateConstructorUsedError;
  String get traineeEmail => throw _privateConstructorUsedError;
  int get autoScore => throw _privateConstructorUsedError;
  double? get autoScoreDecimal => throw _privateConstructorUsedError;
  int get manualScore => throw _privateConstructorUsedError;
  int get finalScore => throw _privateConstructorUsedError;
  double? get finalScoreDecimal => throw _privateConstructorUsedError;
  int get totalQuestions => throw _privateConstructorUsedError;
  Map<String, dynamic> get answers => throw _privateConstructorUsedError;
  Map<String, int> get manualScores =>
      throw _privateConstructorUsedError; // per-question manual points
  Map<String, String> get questionTypes =>
      throw _privateConstructorUsedError; // questionId -> type
  bool get needsManualReview => throw _privateConstructorUsedError;
  List<String>? get requiresManualGrading =>
      throw _privateConstructorUsedError; // textual question ids
  DateTime? get submittedAt => throw _privateConstructorUsedError;
  DateTime? get gradedAt => throw _privateConstructorUsedError;
  String? get graderId => throw _privateConstructorUsedError;

  /// Serializes this QuizSubmission to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizSubmission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizSubmissionCopyWith<QuizSubmission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizSubmissionCopyWith<$Res> {
  factory $QuizSubmissionCopyWith(
    QuizSubmission value,
    $Res Function(QuizSubmission) then,
  ) = _$QuizSubmissionCopyWithImpl<$Res, QuizSubmission>;
  @useResult
  $Res call({
    String id,
    String quizId,
    String traineeId,
    String traineeEmail,
    int autoScore,
    double? autoScoreDecimal,
    int manualScore,
    int finalScore,
    double? finalScoreDecimal,
    int totalQuestions,
    Map<String, dynamic> answers,
    Map<String, int> manualScores,
    Map<String, String> questionTypes,
    bool needsManualReview,
    List<String>? requiresManualGrading,
    DateTime? submittedAt,
    DateTime? gradedAt,
    String? graderId,
  });
}

/// @nodoc
class _$QuizSubmissionCopyWithImpl<$Res, $Val extends QuizSubmission>
    implements $QuizSubmissionCopyWith<$Res> {
  _$QuizSubmissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizSubmission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? quizId = null,
    Object? traineeId = null,
    Object? traineeEmail = null,
    Object? autoScore = null,
    Object? autoScoreDecimal = freezed,
    Object? manualScore = null,
    Object? finalScore = null,
    Object? finalScoreDecimal = freezed,
    Object? totalQuestions = null,
    Object? answers = null,
    Object? manualScores = null,
    Object? questionTypes = null,
    Object? needsManualReview = null,
    Object? requiresManualGrading = freezed,
    Object? submittedAt = freezed,
    Object? gradedAt = freezed,
    Object? graderId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            quizId: null == quizId
                ? _value.quizId
                : quizId // ignore: cast_nullable_to_non_nullable
                      as String,
            traineeId: null == traineeId
                ? _value.traineeId
                : traineeId // ignore: cast_nullable_to_non_nullable
                      as String,
            traineeEmail: null == traineeEmail
                ? _value.traineeEmail
                : traineeEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            autoScore: null == autoScore
                ? _value.autoScore
                : autoScore // ignore: cast_nullable_to_non_nullable
                      as int,
            autoScoreDecimal: freezed == autoScoreDecimal
                ? _value.autoScoreDecimal
                : autoScoreDecimal // ignore: cast_nullable_to_non_nullable
                      as double?,
            manualScore: null == manualScore
                ? _value.manualScore
                : manualScore // ignore: cast_nullable_to_non_nullable
                      as int,
            finalScore: null == finalScore
                ? _value.finalScore
                : finalScore // ignore: cast_nullable_to_non_nullable
                      as int,
            finalScoreDecimal: freezed == finalScoreDecimal
                ? _value.finalScoreDecimal
                : finalScoreDecimal // ignore: cast_nullable_to_non_nullable
                      as double?,
            totalQuestions: null == totalQuestions
                ? _value.totalQuestions
                : totalQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            answers: null == answers
                ? _value.answers
                : answers // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            manualScores: null == manualScores
                ? _value.manualScores
                : manualScores // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            questionTypes: null == questionTypes
                ? _value.questionTypes
                : questionTypes // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            needsManualReview: null == needsManualReview
                ? _value.needsManualReview
                : needsManualReview // ignore: cast_nullable_to_non_nullable
                      as bool,
            requiresManualGrading: freezed == requiresManualGrading
                ? _value.requiresManualGrading
                : requiresManualGrading // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            submittedAt: freezed == submittedAt
                ? _value.submittedAt
                : submittedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            gradedAt: freezed == gradedAt
                ? _value.gradedAt
                : gradedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            graderId: freezed == graderId
                ? _value.graderId
                : graderId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuizSubmissionImplCopyWith<$Res>
    implements $QuizSubmissionCopyWith<$Res> {
  factory _$$QuizSubmissionImplCopyWith(
    _$QuizSubmissionImpl value,
    $Res Function(_$QuizSubmissionImpl) then,
  ) = __$$QuizSubmissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String quizId,
    String traineeId,
    String traineeEmail,
    int autoScore,
    double? autoScoreDecimal,
    int manualScore,
    int finalScore,
    double? finalScoreDecimal,
    int totalQuestions,
    Map<String, dynamic> answers,
    Map<String, int> manualScores,
    Map<String, String> questionTypes,
    bool needsManualReview,
    List<String>? requiresManualGrading,
    DateTime? submittedAt,
    DateTime? gradedAt,
    String? graderId,
  });
}

/// @nodoc
class __$$QuizSubmissionImplCopyWithImpl<$Res>
    extends _$QuizSubmissionCopyWithImpl<$Res, _$QuizSubmissionImpl>
    implements _$$QuizSubmissionImplCopyWith<$Res> {
  __$$QuizSubmissionImplCopyWithImpl(
    _$QuizSubmissionImpl _value,
    $Res Function(_$QuizSubmissionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizSubmission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? quizId = null,
    Object? traineeId = null,
    Object? traineeEmail = null,
    Object? autoScore = null,
    Object? autoScoreDecimal = freezed,
    Object? manualScore = null,
    Object? finalScore = null,
    Object? finalScoreDecimal = freezed,
    Object? totalQuestions = null,
    Object? answers = null,
    Object? manualScores = null,
    Object? questionTypes = null,
    Object? needsManualReview = null,
    Object? requiresManualGrading = freezed,
    Object? submittedAt = freezed,
    Object? gradedAt = freezed,
    Object? graderId = freezed,
  }) {
    return _then(
      _$QuizSubmissionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        quizId: null == quizId
            ? _value.quizId
            : quizId // ignore: cast_nullable_to_non_nullable
                  as String,
        traineeId: null == traineeId
            ? _value.traineeId
            : traineeId // ignore: cast_nullable_to_non_nullable
                  as String,
        traineeEmail: null == traineeEmail
            ? _value.traineeEmail
            : traineeEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        autoScore: null == autoScore
            ? _value.autoScore
            : autoScore // ignore: cast_nullable_to_non_nullable
                  as int,
        autoScoreDecimal: freezed == autoScoreDecimal
            ? _value.autoScoreDecimal
            : autoScoreDecimal // ignore: cast_nullable_to_non_nullable
                  as double?,
        manualScore: null == manualScore
            ? _value.manualScore
            : manualScore // ignore: cast_nullable_to_non_nullable
                  as int,
        finalScore: null == finalScore
            ? _value.finalScore
            : finalScore // ignore: cast_nullable_to_non_nullable
                  as int,
        finalScoreDecimal: freezed == finalScoreDecimal
            ? _value.finalScoreDecimal
            : finalScoreDecimal // ignore: cast_nullable_to_non_nullable
                  as double?,
        totalQuestions: null == totalQuestions
            ? _value.totalQuestions
            : totalQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        answers: null == answers
            ? _value._answers
            : answers // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        manualScores: null == manualScores
            ? _value._manualScores
            : manualScores // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        questionTypes: null == questionTypes
            ? _value._questionTypes
            : questionTypes // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        needsManualReview: null == needsManualReview
            ? _value.needsManualReview
            : needsManualReview // ignore: cast_nullable_to_non_nullable
                  as bool,
        requiresManualGrading: freezed == requiresManualGrading
            ? _value._requiresManualGrading
            : requiresManualGrading // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        submittedAt: freezed == submittedAt
            ? _value.submittedAt
            : submittedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        gradedAt: freezed == gradedAt
            ? _value.gradedAt
            : gradedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        graderId: freezed == graderId
            ? _value.graderId
            : graderId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizSubmissionImpl extends _QuizSubmission {
  const _$QuizSubmissionImpl({
    required this.id,
    required this.quizId,
    required this.traineeId,
    required this.traineeEmail,
    required this.autoScore,
    this.autoScoreDecimal,
    required this.manualScore,
    required this.finalScore,
    this.finalScoreDecimal,
    required this.totalQuestions,
    required final Map<String, dynamic> answers,
    required final Map<String, int> manualScores,
    required final Map<String, String> questionTypes,
    required this.needsManualReview,
    final List<String>? requiresManualGrading,
    this.submittedAt,
    this.gradedAt,
    this.graderId,
  }) : _answers = answers,
       _manualScores = manualScores,
       _questionTypes = questionTypes,
       _requiresManualGrading = requiresManualGrading,
       super._();

  factory _$QuizSubmissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizSubmissionImplFromJson(json);

  @override
  final String id;
  @override
  final String quizId;
  @override
  final String traineeId;
  @override
  final String traineeEmail;
  @override
  final int autoScore;
  @override
  final double? autoScoreDecimal;
  @override
  final int manualScore;
  @override
  final int finalScore;
  @override
  final double? finalScoreDecimal;
  @override
  final int totalQuestions;
  final Map<String, dynamic> _answers;
  @override
  Map<String, dynamic> get answers {
    if (_answers is EqualUnmodifiableMapView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_answers);
  }

  final Map<String, int> _manualScores;
  @override
  Map<String, int> get manualScores {
    if (_manualScores is EqualUnmodifiableMapView) return _manualScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_manualScores);
  }

  // per-question manual points
  final Map<String, String> _questionTypes;
  // per-question manual points
  @override
  Map<String, String> get questionTypes {
    if (_questionTypes is EqualUnmodifiableMapView) return _questionTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_questionTypes);
  }

  // questionId -> type
  @override
  final bool needsManualReview;
  final List<String>? _requiresManualGrading;
  @override
  List<String>? get requiresManualGrading {
    final value = _requiresManualGrading;
    if (value == null) return null;
    if (_requiresManualGrading is EqualUnmodifiableListView)
      return _requiresManualGrading;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // textual question ids
  @override
  final DateTime? submittedAt;
  @override
  final DateTime? gradedAt;
  @override
  final String? graderId;

  @override
  String toString() {
    return 'QuizSubmission(id: $id, quizId: $quizId, traineeId: $traineeId, traineeEmail: $traineeEmail, autoScore: $autoScore, autoScoreDecimal: $autoScoreDecimal, manualScore: $manualScore, finalScore: $finalScore, finalScoreDecimal: $finalScoreDecimal, totalQuestions: $totalQuestions, answers: $answers, manualScores: $manualScores, questionTypes: $questionTypes, needsManualReview: $needsManualReview, requiresManualGrading: $requiresManualGrading, submittedAt: $submittedAt, gradedAt: $gradedAt, graderId: $graderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizSubmissionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.quizId, quizId) || other.quizId == quizId) &&
            (identical(other.traineeId, traineeId) ||
                other.traineeId == traineeId) &&
            (identical(other.traineeEmail, traineeEmail) ||
                other.traineeEmail == traineeEmail) &&
            (identical(other.autoScore, autoScore) ||
                other.autoScore == autoScore) &&
            (identical(other.autoScoreDecimal, autoScoreDecimal) ||
                other.autoScoreDecimal == autoScoreDecimal) &&
            (identical(other.manualScore, manualScore) ||
                other.manualScore == manualScore) &&
            (identical(other.finalScore, finalScore) ||
                other.finalScore == finalScore) &&
            (identical(other.finalScoreDecimal, finalScoreDecimal) ||
                other.finalScoreDecimal == finalScoreDecimal) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            const DeepCollectionEquality().equals(
              other._manualScores,
              _manualScores,
            ) &&
            const DeepCollectionEquality().equals(
              other._questionTypes,
              _questionTypes,
            ) &&
            (identical(other.needsManualReview, needsManualReview) ||
                other.needsManualReview == needsManualReview) &&
            const DeepCollectionEquality().equals(
              other._requiresManualGrading,
              _requiresManualGrading,
            ) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.gradedAt, gradedAt) ||
                other.gradedAt == gradedAt) &&
            (identical(other.graderId, graderId) ||
                other.graderId == graderId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    quizId,
    traineeId,
    traineeEmail,
    autoScore,
    autoScoreDecimal,
    manualScore,
    finalScore,
    finalScoreDecimal,
    totalQuestions,
    const DeepCollectionEquality().hash(_answers),
    const DeepCollectionEquality().hash(_manualScores),
    const DeepCollectionEquality().hash(_questionTypes),
    needsManualReview,
    const DeepCollectionEquality().hash(_requiresManualGrading),
    submittedAt,
    gradedAt,
    graderId,
  );

  /// Create a copy of QuizSubmission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizSubmissionImplCopyWith<_$QuizSubmissionImpl> get copyWith =>
      __$$QuizSubmissionImplCopyWithImpl<_$QuizSubmissionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizSubmissionImplToJson(this);
  }
}

abstract class _QuizSubmission extends QuizSubmission {
  const factory _QuizSubmission({
    required final String id,
    required final String quizId,
    required final String traineeId,
    required final String traineeEmail,
    required final int autoScore,
    final double? autoScoreDecimal,
    required final int manualScore,
    required final int finalScore,
    final double? finalScoreDecimal,
    required final int totalQuestions,
    required final Map<String, dynamic> answers,
    required final Map<String, int> manualScores,
    required final Map<String, String> questionTypes,
    required final bool needsManualReview,
    final List<String>? requiresManualGrading,
    final DateTime? submittedAt,
    final DateTime? gradedAt,
    final String? graderId,
  }) = _$QuizSubmissionImpl;
  const _QuizSubmission._() : super._();

  factory _QuizSubmission.fromJson(Map<String, dynamic> json) =
      _$QuizSubmissionImpl.fromJson;

  @override
  String get id;
  @override
  String get quizId;
  @override
  String get traineeId;
  @override
  String get traineeEmail;
  @override
  int get autoScore;
  @override
  double? get autoScoreDecimal;
  @override
  int get manualScore;
  @override
  int get finalScore;
  @override
  double? get finalScoreDecimal;
  @override
  int get totalQuestions;
  @override
  Map<String, dynamic> get answers;
  @override
  Map<String, int> get manualScores; // per-question manual points
  @override
  Map<String, String> get questionTypes; // questionId -> type
  @override
  bool get needsManualReview;
  @override
  List<String>? get requiresManualGrading; // textual question ids
  @override
  DateTime? get submittedAt;
  @override
  DateTime? get gradedAt;
  @override
  String? get graderId;

  /// Create a copy of QuizSubmission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizSubmissionImplCopyWith<_$QuizSubmissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
