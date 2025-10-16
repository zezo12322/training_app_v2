// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Poll _$PollFromJson(Map<String, dynamic> json) {
  return _Poll.fromJson(json);
}

/// @nodoc
mixin _$Poll {
  String get id => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  List<PollOption> get options => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  @RequiredTimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get endsAt => throw _privateConstructorUsedError;
  bool get allowMultipleVotes => throw _privateConstructorUsedError;
  bool get showResultsBeforeVoting => throw _privateConstructorUsedError;
  int get totalVotes => throw _privateConstructorUsedError;

  /// Serializes this Poll to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Poll
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PollCopyWith<Poll> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollCopyWith<$Res> {
  factory $PollCopyWith(Poll value, $Res Function(Poll) then) =
      _$PollCopyWithImpl<$Res, Poll>;
  @useResult
  $Res call({
    String id,
    String question,
    List<PollOption> options,
    String createdBy,
    @RequiredTimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime? endsAt,
    bool allowMultipleVotes,
    bool showResultsBeforeVoting,
    int totalVotes,
  });
}

/// @nodoc
class _$PollCopyWithImpl<$Res, $Val extends Poll>
    implements $PollCopyWith<$Res> {
  _$PollCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Poll
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? options = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? endsAt = freezed,
    Object? allowMultipleVotes = null,
    Object? showResultsBeforeVoting = null,
    Object? totalVotes = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<PollOption>,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endsAt: freezed == endsAt
                ? _value.endsAt
                : endsAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            allowMultipleVotes: null == allowMultipleVotes
                ? _value.allowMultipleVotes
                : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
                      as bool,
            showResultsBeforeVoting: null == showResultsBeforeVoting
                ? _value.showResultsBeforeVoting
                : showResultsBeforeVoting // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalVotes: null == totalVotes
                ? _value.totalVotes
                : totalVotes // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PollImplCopyWith<$Res> implements $PollCopyWith<$Res> {
  factory _$$PollImplCopyWith(
    _$PollImpl value,
    $Res Function(_$PollImpl) then,
  ) = __$$PollImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String question,
    List<PollOption> options,
    String createdBy,
    @RequiredTimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime? endsAt,
    bool allowMultipleVotes,
    bool showResultsBeforeVoting,
    int totalVotes,
  });
}

/// @nodoc
class __$$PollImplCopyWithImpl<$Res>
    extends _$PollCopyWithImpl<$Res, _$PollImpl>
    implements _$$PollImplCopyWith<$Res> {
  __$$PollImplCopyWithImpl(_$PollImpl _value, $Res Function(_$PollImpl) _then)
    : super(_value, _then);

  /// Create a copy of Poll
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? options = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? endsAt = freezed,
    Object? allowMultipleVotes = null,
    Object? showResultsBeforeVoting = null,
    Object? totalVotes = null,
  }) {
    return _then(
      _$PollImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<PollOption>,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endsAt: freezed == endsAt
            ? _value.endsAt
            : endsAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        allowMultipleVotes: null == allowMultipleVotes
            ? _value.allowMultipleVotes
            : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
                  as bool,
        showResultsBeforeVoting: null == showResultsBeforeVoting
            ? _value.showResultsBeforeVoting
            : showResultsBeforeVoting // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalVotes: null == totalVotes
            ? _value.totalVotes
            : totalVotes // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PollImpl extends _Poll {
  const _$PollImpl({
    required this.id,
    required this.question,
    required final List<PollOption> options,
    required this.createdBy,
    @RequiredTimestampConverter() required this.createdAt,
    @TimestampConverter() this.endsAt,
    this.allowMultipleVotes = false,
    this.showResultsBeforeVoting = false,
    this.totalVotes = 0,
  }) : _options = options,
       super._();

  factory _$PollImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollImplFromJson(json);

  @override
  final String id;
  @override
  final String question;
  final List<PollOption> _options;
  @override
  List<PollOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final String createdBy;
  @override
  @RequiredTimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime? endsAt;
  @override
  @JsonKey()
  final bool allowMultipleVotes;
  @override
  @JsonKey()
  final bool showResultsBeforeVoting;
  @override
  @JsonKey()
  final int totalVotes;

  @override
  String toString() {
    return 'Poll(id: $id, question: $question, options: $options, createdBy: $createdBy, createdAt: $createdAt, endsAt: $endsAt, allowMultipleVotes: $allowMultipleVotes, showResultsBeforeVoting: $showResultsBeforeVoting, totalVotes: $totalVotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt) &&
            (identical(other.allowMultipleVotes, allowMultipleVotes) ||
                other.allowMultipleVotes == allowMultipleVotes) &&
            (identical(
                  other.showResultsBeforeVoting,
                  showResultsBeforeVoting,
                ) ||
                other.showResultsBeforeVoting == showResultsBeforeVoting) &&
            (identical(other.totalVotes, totalVotes) ||
                other.totalVotes == totalVotes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    question,
    const DeepCollectionEquality().hash(_options),
    createdBy,
    createdAt,
    endsAt,
    allowMultipleVotes,
    showResultsBeforeVoting,
    totalVotes,
  );

  /// Create a copy of Poll
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PollImplCopyWith<_$PollImpl> get copyWith =>
      __$$PollImplCopyWithImpl<_$PollImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollImplToJson(this);
  }
}

abstract class _Poll extends Poll {
  const factory _Poll({
    required final String id,
    required final String question,
    required final List<PollOption> options,
    required final String createdBy,
    @RequiredTimestampConverter() required final DateTime createdAt,
    @TimestampConverter() final DateTime? endsAt,
    final bool allowMultipleVotes,
    final bool showResultsBeforeVoting,
    final int totalVotes,
  }) = _$PollImpl;
  const _Poll._() : super._();

  factory _Poll.fromJson(Map<String, dynamic> json) = _$PollImpl.fromJson;

  @override
  String get id;
  @override
  String get question;
  @override
  List<PollOption> get options;
  @override
  String get createdBy;
  @override
  @RequiredTimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime? get endsAt;
  @override
  bool get allowMultipleVotes;
  @override
  bool get showResultsBeforeVoting;
  @override
  int get totalVotes;

  /// Create a copy of Poll
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PollImplCopyWith<_$PollImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PollOption _$PollOptionFromJson(Map<String, dynamic> json) {
  return _PollOption.fromJson(json);
}

/// @nodoc
mixin _$PollOption {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  List<String> get voters => throw _privateConstructorUsedError;

  /// Serializes this PollOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PollOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PollOptionCopyWith<PollOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollOptionCopyWith<$Res> {
  factory $PollOptionCopyWith(
    PollOption value,
    $Res Function(PollOption) then,
  ) = _$PollOptionCopyWithImpl<$Res, PollOption>;
  @useResult
  $Res call({String id, String text, List<String> voters});
}

/// @nodoc
class _$PollOptionCopyWithImpl<$Res, $Val extends PollOption>
    implements $PollOptionCopyWith<$Res> {
  _$PollOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PollOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? text = null, Object? voters = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            voters: null == voters
                ? _value.voters
                : voters // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PollOptionImplCopyWith<$Res>
    implements $PollOptionCopyWith<$Res> {
  factory _$$PollOptionImplCopyWith(
    _$PollOptionImpl value,
    $Res Function(_$PollOptionImpl) then,
  ) = __$$PollOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String text, List<String> voters});
}

/// @nodoc
class __$$PollOptionImplCopyWithImpl<$Res>
    extends _$PollOptionCopyWithImpl<$Res, _$PollOptionImpl>
    implements _$$PollOptionImplCopyWith<$Res> {
  __$$PollOptionImplCopyWithImpl(
    _$PollOptionImpl _value,
    $Res Function(_$PollOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PollOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? text = null, Object? voters = null}) {
    return _then(
      _$PollOptionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        voters: null == voters
            ? _value._voters
            : voters // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PollOptionImpl extends _PollOption {
  const _$PollOptionImpl({
    required this.id,
    required this.text,
    final List<String> voters = const [],
  }) : _voters = voters,
       super._();

  factory _$PollOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollOptionImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  final List<String> _voters;
  @override
  @JsonKey()
  List<String> get voters {
    if (_voters is EqualUnmodifiableListView) return _voters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_voters);
  }

  @override
  String toString() {
    return 'PollOption(id: $id, text: $text, voters: $voters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._voters, _voters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    text,
    const DeepCollectionEquality().hash(_voters),
  );

  /// Create a copy of PollOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PollOptionImplCopyWith<_$PollOptionImpl> get copyWith =>
      __$$PollOptionImplCopyWithImpl<_$PollOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollOptionImplToJson(this);
  }
}

abstract class _PollOption extends PollOption {
  const factory _PollOption({
    required final String id,
    required final String text,
    final List<String> voters,
  }) = _$PollOptionImpl;
  const _PollOption._() : super._();

  factory _PollOption.fromJson(Map<String, dynamic> json) =
      _$PollOptionImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  List<String> get voters;

  /// Create a copy of PollOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PollOptionImplCopyWith<_$PollOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
