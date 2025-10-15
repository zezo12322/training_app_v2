// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_reaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MessageReaction _$MessageReactionFromJson(Map<String, dynamic> json) {
  return _MessageReaction.fromJson(json);
}

/// @nodoc
mixin _$MessageReaction {
  String get emoji => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this MessageReaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageReactionCopyWith<MessageReaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageReactionCopyWith<$Res> {
  factory $MessageReactionCopyWith(
    MessageReaction value,
    $Res Function(MessageReaction) then,
  ) = _$MessageReactionCopyWithImpl<$Res, MessageReaction>;
  @useResult
  $Res call({
    String emoji,
    String userId,
    String userName,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$MessageReactionCopyWithImpl<$Res, $Val extends MessageReaction>
    implements $MessageReactionCopyWith<$Res> {
  _$MessageReactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emoji = null,
    Object? userId = null,
    Object? userName = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            emoji: null == emoji
                ? _value.emoji
                : emoji // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessageReactionImplCopyWith<$Res>
    implements $MessageReactionCopyWith<$Res> {
  factory _$$MessageReactionImplCopyWith(
    _$MessageReactionImpl value,
    $Res Function(_$MessageReactionImpl) then,
  ) = __$$MessageReactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String emoji,
    String userId,
    String userName,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$MessageReactionImplCopyWithImpl<$Res>
    extends _$MessageReactionCopyWithImpl<$Res, _$MessageReactionImpl>
    implements _$$MessageReactionImplCopyWith<$Res> {
  __$$MessageReactionImplCopyWithImpl(
    _$MessageReactionImpl _value,
    $Res Function(_$MessageReactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emoji = null,
    Object? userId = null,
    Object? userName = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$MessageReactionImpl(
        emoji: null == emoji
            ? _value.emoji
            : emoji // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageReactionImpl implements _MessageReaction {
  const _$MessageReactionImpl({
    required this.emoji,
    required this.userId,
    required this.userName,
    @TimestampConverter() required this.createdAt,
  });

  factory _$MessageReactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageReactionImplFromJson(json);

  @override
  final String emoji;
  @override
  final String userId;
  @override
  final String userName;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'MessageReaction(emoji: $emoji, userId: $userId, userName: $userName, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageReactionImpl &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, emoji, userId, userName, createdAt);

  /// Create a copy of MessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageReactionImplCopyWith<_$MessageReactionImpl> get copyWith =>
      __$$MessageReactionImplCopyWithImpl<_$MessageReactionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageReactionImplToJson(this);
  }
}

abstract class _MessageReaction implements MessageReaction {
  const factory _MessageReaction({
    required final String emoji,
    required final String userId,
    required final String userName,
    @TimestampConverter() required final DateTime createdAt,
  }) = _$MessageReactionImpl;

  factory _MessageReaction.fromJson(Map<String, dynamic> json) =
      _$MessageReactionImpl.fromJson;

  @override
  String get emoji;
  @override
  String get userId;
  @override
  String get userName;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of MessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageReactionImplCopyWith<_$MessageReactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReactionSummary _$ReactionSummaryFromJson(Map<String, dynamic> json) {
  return _ReactionSummary.fromJson(json);
}

/// @nodoc
mixin _$ReactionSummary {
  /// Map من emoji -> عدد التفاعلات
  Map<String, int> get counts => throw _privateConstructorUsedError;

  /// Map من emoji -> قائمة أسماء المستخدمين
  Map<String, List<String>> get userNames => throw _privateConstructorUsedError;

  /// هل تفاعل المستخدم الحالي؟ (emoji -> bool)
  Map<String, bool> get currentUserReactions =>
      throw _privateConstructorUsedError;

  /// إجمالي التفاعلات
  int get totalCount => throw _privateConstructorUsedError;

  /// Serializes this ReactionSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReactionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReactionSummaryCopyWith<ReactionSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReactionSummaryCopyWith<$Res> {
  factory $ReactionSummaryCopyWith(
    ReactionSummary value,
    $Res Function(ReactionSummary) then,
  ) = _$ReactionSummaryCopyWithImpl<$Res, ReactionSummary>;
  @useResult
  $Res call({
    Map<String, int> counts,
    Map<String, List<String>> userNames,
    Map<String, bool> currentUserReactions,
    int totalCount,
  });
}

/// @nodoc
class _$ReactionSummaryCopyWithImpl<$Res, $Val extends ReactionSummary>
    implements $ReactionSummaryCopyWith<$Res> {
  _$ReactionSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReactionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? counts = null,
    Object? userNames = null,
    Object? currentUserReactions = null,
    Object? totalCount = null,
  }) {
    return _then(
      _value.copyWith(
            counts: null == counts
                ? _value.counts
                : counts // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            userNames: null == userNames
                ? _value.userNames
                : userNames // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<String>>,
            currentUserReactions: null == currentUserReactions
                ? _value.currentUserReactions
                : currentUserReactions // ignore: cast_nullable_to_non_nullable
                      as Map<String, bool>,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReactionSummaryImplCopyWith<$Res>
    implements $ReactionSummaryCopyWith<$Res> {
  factory _$$ReactionSummaryImplCopyWith(
    _$ReactionSummaryImpl value,
    $Res Function(_$ReactionSummaryImpl) then,
  ) = __$$ReactionSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Map<String, int> counts,
    Map<String, List<String>> userNames,
    Map<String, bool> currentUserReactions,
    int totalCount,
  });
}

/// @nodoc
class __$$ReactionSummaryImplCopyWithImpl<$Res>
    extends _$ReactionSummaryCopyWithImpl<$Res, _$ReactionSummaryImpl>
    implements _$$ReactionSummaryImplCopyWith<$Res> {
  __$$ReactionSummaryImplCopyWithImpl(
    _$ReactionSummaryImpl _value,
    $Res Function(_$ReactionSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReactionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? counts = null,
    Object? userNames = null,
    Object? currentUserReactions = null,
    Object? totalCount = null,
  }) {
    return _then(
      _$ReactionSummaryImpl(
        counts: null == counts
            ? _value._counts
            : counts // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        userNames: null == userNames
            ? _value._userNames
            : userNames // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<String>>,
        currentUserReactions: null == currentUserReactions
            ? _value._currentUserReactions
            : currentUserReactions // ignore: cast_nullable_to_non_nullable
                  as Map<String, bool>,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReactionSummaryImpl implements _ReactionSummary {
  const _$ReactionSummaryImpl({
    final Map<String, int> counts = const {},
    final Map<String, List<String>> userNames = const {},
    final Map<String, bool> currentUserReactions = const {},
    this.totalCount = 0,
  }) : _counts = counts,
       _userNames = userNames,
       _currentUserReactions = currentUserReactions;

  factory _$ReactionSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReactionSummaryImplFromJson(json);

  /// Map من emoji -> عدد التفاعلات
  final Map<String, int> _counts;

  /// Map من emoji -> عدد التفاعلات
  @override
  @JsonKey()
  Map<String, int> get counts {
    if (_counts is EqualUnmodifiableMapView) return _counts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_counts);
  }

  /// Map من emoji -> قائمة أسماء المستخدمين
  final Map<String, List<String>> _userNames;

  /// Map من emoji -> قائمة أسماء المستخدمين
  @override
  @JsonKey()
  Map<String, List<String>> get userNames {
    if (_userNames is EqualUnmodifiableMapView) return _userNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_userNames);
  }

  /// هل تفاعل المستخدم الحالي؟ (emoji -> bool)
  final Map<String, bool> _currentUserReactions;

  /// هل تفاعل المستخدم الحالي؟ (emoji -> bool)
  @override
  @JsonKey()
  Map<String, bool> get currentUserReactions {
    if (_currentUserReactions is EqualUnmodifiableMapView)
      return _currentUserReactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_currentUserReactions);
  }

  /// إجمالي التفاعلات
  @override
  @JsonKey()
  final int totalCount;

  @override
  String toString() {
    return 'ReactionSummary(counts: $counts, userNames: $userNames, currentUserReactions: $currentUserReactions, totalCount: $totalCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReactionSummaryImpl &&
            const DeepCollectionEquality().equals(other._counts, _counts) &&
            const DeepCollectionEquality().equals(
              other._userNames,
              _userNames,
            ) &&
            const DeepCollectionEquality().equals(
              other._currentUserReactions,
              _currentUserReactions,
            ) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_counts),
    const DeepCollectionEquality().hash(_userNames),
    const DeepCollectionEquality().hash(_currentUserReactions),
    totalCount,
  );

  /// Create a copy of ReactionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReactionSummaryImplCopyWith<_$ReactionSummaryImpl> get copyWith =>
      __$$ReactionSummaryImplCopyWithImpl<_$ReactionSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ReactionSummaryImplToJson(this);
  }
}

abstract class _ReactionSummary implements ReactionSummary {
  const factory _ReactionSummary({
    final Map<String, int> counts,
    final Map<String, List<String>> userNames,
    final Map<String, bool> currentUserReactions,
    final int totalCount,
  }) = _$ReactionSummaryImpl;

  factory _ReactionSummary.fromJson(Map<String, dynamic> json) =
      _$ReactionSummaryImpl.fromJson;

  /// Map من emoji -> عدد التفاعلات
  @override
  Map<String, int> get counts;

  /// Map من emoji -> قائمة أسماء المستخدمين
  @override
  Map<String, List<String>> get userNames;

  /// هل تفاعل المستخدم الحالي؟ (emoji -> bool)
  @override
  Map<String, bool> get currentUserReactions;

  /// إجمالي التفاعلات
  @override
  int get totalCount;

  /// Create a copy of ReactionSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReactionSummaryImplCopyWith<_$ReactionSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
