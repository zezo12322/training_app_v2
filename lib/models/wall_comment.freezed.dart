// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wall_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WallComment _$WallCommentFromJson(Map<String, dynamic> json) {
  return _WallComment.fromJson(json);
}

/// @nodoc
mixin _$WallComment {
  String get id => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String? get authorEmail => throw _privateConstructorUsedError;
  String? get authorName =>
      throw _privateConstructorUsedError; // Threading support
  String? get parentCommentId =>
      throw _privateConstructorUsedError; // For nested replies
  int get replyCount =>
      throw _privateConstructorUsedError; // Reactions on comments
  Map<String, int> get reactions => throw _privateConstructorUsedError;
  Map<String, List<String>> get reactionUsers =>
      throw _privateConstructorUsedError; // Metadata
  bool get isEdited => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this WallComment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WallComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WallCommentCopyWith<WallComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WallCommentCopyWith<$Res> {
  factory $WallCommentCopyWith(
    WallComment value,
    $Res Function(WallComment) then,
  ) = _$WallCommentCopyWithImpl<$Res, WallComment>;
  @useResult
  $Res call({
    String id,
    String postId,
    String courseId,
    String authorId,
    String content,
    String? authorEmail,
    String? authorName,
    String? parentCommentId,
    int replyCount,
    Map<String, int> reactions,
    Map<String, List<String>> reactionUsers,
    bool isEdited,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  });
}

/// @nodoc
class _$WallCommentCopyWithImpl<$Res, $Val extends WallComment>
    implements $WallCommentCopyWith<$Res> {
  _$WallCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WallComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? courseId = null,
    Object? authorId = null,
    Object? content = null,
    Object? authorEmail = freezed,
    Object? authorName = freezed,
    Object? parentCommentId = freezed,
    Object? replyCount = null,
    Object? reactions = null,
    Object? reactionUsers = null,
    Object? isEdited = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            postId: null == postId
                ? _value.postId
                : postId // ignore: cast_nullable_to_non_nullable
                      as String,
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            authorId: null == authorId
                ? _value.authorId
                : authorId // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            authorEmail: freezed == authorEmail
                ? _value.authorEmail
                : authorEmail // ignore: cast_nullable_to_non_nullable
                      as String?,
            authorName: freezed == authorName
                ? _value.authorName
                : authorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            parentCommentId: freezed == parentCommentId
                ? _value.parentCommentId
                : parentCommentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            replyCount: null == replyCount
                ? _value.replyCount
                : replyCount // ignore: cast_nullable_to_non_nullable
                      as int,
            reactions: null == reactions
                ? _value.reactions
                : reactions // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            reactionUsers: null == reactionUsers
                ? _value.reactionUsers
                : reactionUsers // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<String>>,
            isEdited: null == isEdited
                ? _value.isEdited
                : isEdited // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$WallCommentImplCopyWith<$Res>
    implements $WallCommentCopyWith<$Res> {
  factory _$$WallCommentImplCopyWith(
    _$WallCommentImpl value,
    $Res Function(_$WallCommentImpl) then,
  ) = __$$WallCommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String postId,
    String courseId,
    String authorId,
    String content,
    String? authorEmail,
    String? authorName,
    String? parentCommentId,
    int replyCount,
    Map<String, int> reactions,
    Map<String, List<String>> reactionUsers,
    bool isEdited,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  });
}

/// @nodoc
class __$$WallCommentImplCopyWithImpl<$Res>
    extends _$WallCommentCopyWithImpl<$Res, _$WallCommentImpl>
    implements _$$WallCommentImplCopyWith<$Res> {
  __$$WallCommentImplCopyWithImpl(
    _$WallCommentImpl _value,
    $Res Function(_$WallCommentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WallComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? courseId = null,
    Object? authorId = null,
    Object? content = null,
    Object? authorEmail = freezed,
    Object? authorName = freezed,
    Object? parentCommentId = freezed,
    Object? replyCount = null,
    Object? reactions = null,
    Object? reactionUsers = null,
    Object? isEdited = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$WallCommentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        postId: null == postId
            ? _value.postId
            : postId // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        authorId: null == authorId
            ? _value.authorId
            : authorId // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        authorEmail: freezed == authorEmail
            ? _value.authorEmail
            : authorEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        authorName: freezed == authorName
            ? _value.authorName
            : authorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        parentCommentId: freezed == parentCommentId
            ? _value.parentCommentId
            : parentCommentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        replyCount: null == replyCount
            ? _value.replyCount
            : replyCount // ignore: cast_nullable_to_non_nullable
                  as int,
        reactions: null == reactions
            ? _value._reactions
            : reactions // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        reactionUsers: null == reactionUsers
            ? _value._reactionUsers
            : reactionUsers // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<String>>,
        isEdited: null == isEdited
            ? _value.isEdited
            : isEdited // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$WallCommentImpl extends _WallComment {
  const _$WallCommentImpl({
    required this.id,
    required this.postId,
    required this.courseId,
    required this.authorId,
    required this.content,
    this.authorEmail,
    this.authorName,
    this.parentCommentId,
    this.replyCount = 0,
    final Map<String, int> reactions = const {},
    final Map<String, List<String>> reactionUsers = const {},
    this.isEdited = false,
    @TimestampConverter() this.createdAt,
    @TimestampConverter() this.updatedAt,
  }) : _reactions = reactions,
       _reactionUsers = reactionUsers,
       super._();

  factory _$WallCommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$WallCommentImplFromJson(json);

  @override
  final String id;
  @override
  final String postId;
  @override
  final String courseId;
  @override
  final String authorId;
  @override
  final String content;
  @override
  final String? authorEmail;
  @override
  final String? authorName;
  // Threading support
  @override
  final String? parentCommentId;
  // For nested replies
  @override
  @JsonKey()
  final int replyCount;
  // Reactions on comments
  final Map<String, int> _reactions;
  // Reactions on comments
  @override
  @JsonKey()
  Map<String, int> get reactions {
    if (_reactions is EqualUnmodifiableMapView) return _reactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_reactions);
  }

  final Map<String, List<String>> _reactionUsers;
  @override
  @JsonKey()
  Map<String, List<String>> get reactionUsers {
    if (_reactionUsers is EqualUnmodifiableMapView) return _reactionUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_reactionUsers);
  }

  // Metadata
  @override
  @JsonKey()
  final bool isEdited;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'WallComment(id: $id, postId: $postId, courseId: $courseId, authorId: $authorId, content: $content, authorEmail: $authorEmail, authorName: $authorName, parentCommentId: $parentCommentId, replyCount: $replyCount, reactions: $reactions, reactionUsers: $reactionUsers, isEdited: $isEdited, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WallCommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorEmail, authorEmail) ||
                other.authorEmail == authorEmail) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.parentCommentId, parentCommentId) ||
                other.parentCommentId == parentCommentId) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount) &&
            const DeepCollectionEquality().equals(
              other._reactions,
              _reactions,
            ) &&
            const DeepCollectionEquality().equals(
              other._reactionUsers,
              _reactionUsers,
            ) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
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
    postId,
    courseId,
    authorId,
    content,
    authorEmail,
    authorName,
    parentCommentId,
    replyCount,
    const DeepCollectionEquality().hash(_reactions),
    const DeepCollectionEquality().hash(_reactionUsers),
    isEdited,
    createdAt,
    updatedAt,
  );

  /// Create a copy of WallComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WallCommentImplCopyWith<_$WallCommentImpl> get copyWith =>
      __$$WallCommentImplCopyWithImpl<_$WallCommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WallCommentImplToJson(this);
  }
}

abstract class _WallComment extends WallComment {
  const factory _WallComment({
    required final String id,
    required final String postId,
    required final String courseId,
    required final String authorId,
    required final String content,
    final String? authorEmail,
    final String? authorName,
    final String? parentCommentId,
    final int replyCount,
    final Map<String, int> reactions,
    final Map<String, List<String>> reactionUsers,
    final bool isEdited,
    @TimestampConverter() final DateTime? createdAt,
    @TimestampConverter() final DateTime? updatedAt,
  }) = _$WallCommentImpl;
  const _WallComment._() : super._();

  factory _WallComment.fromJson(Map<String, dynamic> json) =
      _$WallCommentImpl.fromJson;

  @override
  String get id;
  @override
  String get postId;
  @override
  String get courseId;
  @override
  String get authorId;
  @override
  String get content;
  @override
  String? get authorEmail;
  @override
  String? get authorName; // Threading support
  @override
  String? get parentCommentId; // For nested replies
  @override
  int get replyCount; // Reactions on comments
  @override
  Map<String, int> get reactions;
  @override
  Map<String, List<String>> get reactionUsers; // Metadata
  @override
  bool get isEdited;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;

  /// Create a copy of WallComment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WallCommentImplCopyWith<_$WallCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
