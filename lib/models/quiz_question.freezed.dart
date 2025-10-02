// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuizQuestion _$QuizQuestionFromJson(Map<String, dynamic> json) {
  return _QuizQuestion.fromJson(json);
}

/// @nodoc
mixin _$QuizQuestion {
  String get id => throw _privateConstructorUsedError;
  String get quizId => throw _privateConstructorUsedError;
  String get questionText => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  List<String>? get options => throw _privateConstructorUsedError;
  int? get correctAnswerIndex =>
      throw _privateConstructorUsedError; // Matching specific
  List<String>? get leftItems => throw _privateConstructorUsedError;
  List<String>? get rightItems => throw _privateConstructorUsedError;
  Map<String, int>? get correctPairs =>
      throw _privateConstructorUsedError; // key: left index (string), value: right index
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this QuizQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizQuestionCopyWith<QuizQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizQuestionCopyWith<$Res> {
  factory $QuizQuestionCopyWith(
    QuizQuestion value,
    $Res Function(QuizQuestion) then,
  ) = _$QuizQuestionCopyWithImpl<$Res, QuizQuestion>;
  @useResult
  $Res call({
    String id,
    String quizId,
    String questionText,
    String type,
    List<String>? options,
    int? correctAnswerIndex,
    List<String>? leftItems,
    List<String>? rightItems,
    Map<String, int>? correctPairs,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$QuizQuestionCopyWithImpl<$Res, $Val extends QuizQuestion>
    implements $QuizQuestionCopyWith<$Res> {
  _$QuizQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? quizId = null,
    Object? questionText = null,
    Object? type = null,
    Object? options = freezed,
    Object? correctAnswerIndex = freezed,
    Object? leftItems = freezed,
    Object? rightItems = freezed,
    Object? correctPairs = freezed,
    Object? createdAt = freezed,
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
            questionText: null == questionText
                ? _value.questionText
                : questionText // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            options: freezed == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            correctAnswerIndex: freezed == correctAnswerIndex
                ? _value.correctAnswerIndex
                : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
                      as int?,
            leftItems: freezed == leftItems
                ? _value.leftItems
                : leftItems // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            rightItems: freezed == rightItems
                ? _value.rightItems
                : rightItems // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            correctPairs: freezed == correctPairs
                ? _value.correctPairs
                : correctPairs // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>?,
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
abstract class _$$QuizQuestionImplCopyWith<$Res>
    implements $QuizQuestionCopyWith<$Res> {
  factory _$$QuizQuestionImplCopyWith(
    _$QuizQuestionImpl value,
    $Res Function(_$QuizQuestionImpl) then,
  ) = __$$QuizQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String quizId,
    String questionText,
    String type,
    List<String>? options,
    int? correctAnswerIndex,
    List<String>? leftItems,
    List<String>? rightItems,
    Map<String, int>? correctPairs,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$QuizQuestionImplCopyWithImpl<$Res>
    extends _$QuizQuestionCopyWithImpl<$Res, _$QuizQuestionImpl>
    implements _$$QuizQuestionImplCopyWith<$Res> {
  __$$QuizQuestionImplCopyWithImpl(
    _$QuizQuestionImpl _value,
    $Res Function(_$QuizQuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? quizId = null,
    Object? questionText = null,
    Object? type = null,
    Object? options = freezed,
    Object? correctAnswerIndex = freezed,
    Object? leftItems = freezed,
    Object? rightItems = freezed,
    Object? correctPairs = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$QuizQuestionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        quizId: null == quizId
            ? _value.quizId
            : quizId // ignore: cast_nullable_to_non_nullable
                  as String,
        questionText: null == questionText
            ? _value.questionText
            : questionText // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        options: freezed == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        correctAnswerIndex: freezed == correctAnswerIndex
            ? _value.correctAnswerIndex
            : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
                  as int?,
        leftItems: freezed == leftItems
            ? _value._leftItems
            : leftItems // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        rightItems: freezed == rightItems
            ? _value._rightItems
            : rightItems // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        correctPairs: freezed == correctPairs
            ? _value._correctPairs
            : correctPairs // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>?,
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
class _$QuizQuestionImpl extends _QuizQuestion {
  const _$QuizQuestionImpl({
    required this.id,
    required this.quizId,
    required this.questionText,
    required this.type,
    final List<String>? options,
    this.correctAnswerIndex,
    final List<String>? leftItems,
    final List<String>? rightItems,
    final Map<String, int>? correctPairs,
    this.createdAt,
  }) : _options = options,
       _leftItems = leftItems,
       _rightItems = rightItems,
       _correctPairs = correctPairs,
       super._();

  factory _$QuizQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizQuestionImplFromJson(json);

  @override
  final String id;
  @override
  final String quizId;
  @override
  final String questionText;
  @override
  final String type;
  final List<String>? _options;
  @override
  List<String>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? correctAnswerIndex;
  // Matching specific
  final List<String>? _leftItems;
  // Matching specific
  @override
  List<String>? get leftItems {
    final value = _leftItems;
    if (value == null) return null;
    if (_leftItems is EqualUnmodifiableListView) return _leftItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _rightItems;
  @override
  List<String>? get rightItems {
    final value = _rightItems;
    if (value == null) return null;
    if (_rightItems is EqualUnmodifiableListView) return _rightItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, int>? _correctPairs;
  @override
  Map<String, int>? get correctPairs {
    final value = _correctPairs;
    if (value == null) return null;
    if (_correctPairs is EqualUnmodifiableMapView) return _correctPairs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  // key: left index (string), value: right index
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'QuizQuestion(id: $id, quizId: $quizId, questionText: $questionText, type: $type, options: $options, correctAnswerIndex: $correctAnswerIndex, leftItems: $leftItems, rightItems: $rightItems, correctPairs: $correctPairs, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizQuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.quizId, quizId) || other.quizId == quizId) &&
            (identical(other.questionText, questionText) ||
                other.questionText == questionText) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.correctAnswerIndex, correctAnswerIndex) ||
                other.correctAnswerIndex == correctAnswerIndex) &&
            const DeepCollectionEquality().equals(
              other._leftItems,
              _leftItems,
            ) &&
            const DeepCollectionEquality().equals(
              other._rightItems,
              _rightItems,
            ) &&
            const DeepCollectionEquality().equals(
              other._correctPairs,
              _correctPairs,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    quizId,
    questionText,
    type,
    const DeepCollectionEquality().hash(_options),
    correctAnswerIndex,
    const DeepCollectionEquality().hash(_leftItems),
    const DeepCollectionEquality().hash(_rightItems),
    const DeepCollectionEquality().hash(_correctPairs),
    createdAt,
  );

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizQuestionImplCopyWith<_$QuizQuestionImpl> get copyWith =>
      __$$QuizQuestionImplCopyWithImpl<_$QuizQuestionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizQuestionImplToJson(this);
  }
}

abstract class _QuizQuestion extends QuizQuestion {
  const factory _QuizQuestion({
    required final String id,
    required final String quizId,
    required final String questionText,
    required final String type,
    final List<String>? options,
    final int? correctAnswerIndex,
    final List<String>? leftItems,
    final List<String>? rightItems,
    final Map<String, int>? correctPairs,
    final DateTime? createdAt,
  }) = _$QuizQuestionImpl;
  const _QuizQuestion._() : super._();

  factory _QuizQuestion.fromJson(Map<String, dynamic> json) =
      _$QuizQuestionImpl.fromJson;

  @override
  String get id;
  @override
  String get quizId;
  @override
  String get questionText;
  @override
  String get type;
  @override
  List<String>? get options;
  @override
  int? get correctAnswerIndex; // Matching specific
  @override
  List<String>? get leftItems;
  @override
  List<String>? get rightItems;
  @override
  Map<String, int>? get correctPairs; // key: left index (string), value: right index
  @override
  DateTime? get createdAt;

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizQuestionImplCopyWith<_$QuizQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
