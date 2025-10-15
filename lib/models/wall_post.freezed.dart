// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wall_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WallPost _$WallPostFromJson(Map<String, dynamic> json) {
  return _WallPost.fromJson(json);
}

/// @nodoc
mixin _$WallPost {
  String get id => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String? get authorEmail => throw _privateConstructorUsedError;
  String? get authorName => throw _privateConstructorUsedError;
  String? get fileUrl => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<String> get imageUrls =>
      throw _privateConstructorUsedError; // Multiple images support
  // Enhanced features
  bool get isPinned => throw _privateConstructorUsedError;
  bool get isArchived => throw _privateConstructorUsedError;
  bool get isEdited => throw _privateConstructorUsedError;
  Map<String, int> get reactions =>
      throw _privateConstructorUsedError; // {'👍': 5, '❤️': 3}
  Map<String, List<String>> get reactionUsers =>
      throw _privateConstructorUsedError; // {'👍': ['uid1', 'uid2']}
  int get commentCount =>
      throw _privateConstructorUsedError; // Poll support (optional)
  Map<String, dynamic>? get poll =>
      throw _privateConstructorUsedError; // Metadata
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get pinnedAt => throw _privateConstructorUsedError;

  /// Serializes this WallPost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WallPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WallPostCopyWith<WallPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WallPostCopyWith<$Res> {
  factory $WallPostCopyWith(WallPost value, $Res Function(WallPost) then) =
      _$WallPostCopyWithImpl<$Res, WallPost>;
  @useResult
  $Res call({
    String id,
    String courseId,
    String authorId,
    String content,
    String? authorEmail,
    String? authorName,
    String? fileUrl,
    String? imageUrl,
    List<String> imageUrls,
    bool isPinned,
    bool isArchived,
    bool isEdited,
    Map<String, int> reactions,
    Map<String, List<String>> reactionUsers,
    int commentCount,
    Map<String, dynamic>? poll,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? pinnedAt,
  });
}

/// @nodoc
class _$WallPostCopyWithImpl<$Res, $Val extends WallPost>
    implements $WallPostCopyWith<$Res> {
  _$WallPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WallPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? authorId = null,
    Object? content = null,
    Object? authorEmail = freezed,
    Object? authorName = freezed,
    Object? fileUrl = freezed,
    Object? imageUrl = freezed,
    Object? imageUrls = null,
    Object? isPinned = null,
    Object? isArchived = null,
    Object? isEdited = null,
    Object? reactions = null,
    Object? reactionUsers = null,
    Object? commentCount = null,
    Object? poll = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? pinnedAt = freezed,
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
            fileUrl: freezed == fileUrl
                ? _value.fileUrl
                : fileUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrls: null == imageUrls
                ? _value.imageUrls
                : imageUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isPinned: null == isPinned
                ? _value.isPinned
                : isPinned // ignore: cast_nullable_to_non_nullable
                      as bool,
            isArchived: null == isArchived
                ? _value.isArchived
                : isArchived // ignore: cast_nullable_to_non_nullable
                      as bool,
            isEdited: null == isEdited
                ? _value.isEdited
                : isEdited // ignore: cast_nullable_to_non_nullable
                      as bool,
            reactions: null == reactions
                ? _value.reactions
                : reactions // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            reactionUsers: null == reactionUsers
                ? _value.reactionUsers
                : reactionUsers // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<String>>,
            commentCount: null == commentCount
                ? _value.commentCount
                : commentCount // ignore: cast_nullable_to_non_nullable
                      as int,
            poll: freezed == poll
                ? _value.poll
                : poll // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            pinnedAt: freezed == pinnedAt
                ? _value.pinnedAt
                : pinnedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WallPostImplCopyWith<$Res>
    implements $WallPostCopyWith<$Res> {
  factory _$$WallPostImplCopyWith(
    _$WallPostImpl value,
    $Res Function(_$WallPostImpl) then,
  ) = __$$WallPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String courseId,
    String authorId,
    String content,
    String? authorEmail,
    String? authorName,
    String? fileUrl,
    String? imageUrl,
    List<String> imageUrls,
    bool isPinned,
    bool isArchived,
    bool isEdited,
    Map<String, int> reactions,
    Map<String, List<String>> reactionUsers,
    int commentCount,
    Map<String, dynamic>? poll,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? pinnedAt,
  });
}

/// @nodoc
class __$$WallPostImplCopyWithImpl<$Res>
    extends _$WallPostCopyWithImpl<$Res, _$WallPostImpl>
    implements _$$WallPostImplCopyWith<$Res> {
  __$$WallPostImplCopyWithImpl(
    _$WallPostImpl _value,
    $Res Function(_$WallPostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WallPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? authorId = null,
    Object? content = null,
    Object? authorEmail = freezed,
    Object? authorName = freezed,
    Object? fileUrl = freezed,
    Object? imageUrl = freezed,
    Object? imageUrls = null,
    Object? isPinned = null,
    Object? isArchived = null,
    Object? isEdited = null,
    Object? reactions = null,
    Object? reactionUsers = null,
    Object? commentCount = null,
    Object? poll = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? pinnedAt = freezed,
  }) {
    return _then(
      _$WallPostImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
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
        fileUrl: freezed == fileUrl
            ? _value.fileUrl
            : fileUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrls: null == imageUrls
            ? _value._imageUrls
            : imageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                  as bool,
        isArchived: null == isArchived
            ? _value.isArchived
            : isArchived // ignore: cast_nullable_to_non_nullable
                  as bool,
        isEdited: null == isEdited
            ? _value.isEdited
            : isEdited // ignore: cast_nullable_to_non_nullable
                  as bool,
        reactions: null == reactions
            ? _value._reactions
            : reactions // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        reactionUsers: null == reactionUsers
            ? _value._reactionUsers
            : reactionUsers // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<String>>,
        commentCount: null == commentCount
            ? _value.commentCount
            : commentCount // ignore: cast_nullable_to_non_nullable
                  as int,
        poll: freezed == poll
            ? _value._poll
            : poll // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        pinnedAt: freezed == pinnedAt
            ? _value.pinnedAt
            : pinnedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WallPostImpl extends _WallPost {
  const _$WallPostImpl({
    required this.id,
    required this.courseId,
    required this.authorId,
    required this.content,
    this.authorEmail,
    this.authorName,
    this.fileUrl,
    this.imageUrl,
    final List<String> imageUrls = const [],
    this.isPinned = false,
    this.isArchived = false,
    this.isEdited = false,
    final Map<String, int> reactions = const {},
    final Map<String, List<String>> reactionUsers = const {},
    this.commentCount = 0,
    final Map<String, dynamic>? poll,
    @TimestampConverter() this.createdAt,
    @TimestampConverter() this.updatedAt,
    @TimestampConverter() this.pinnedAt,
  }) : _imageUrls = imageUrls,
       _reactions = reactions,
       _reactionUsers = reactionUsers,
       _poll = poll,
       super._();

  factory _$WallPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$WallPostImplFromJson(json);

  @override
  final String id;
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
  @override
  final String? fileUrl;
  @override
  final String? imageUrl;
  final List<String> _imageUrls;
  @override
  @JsonKey()
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  // Multiple images support
  // Enhanced features
  @override
  @JsonKey()
  final bool isPinned;
  @override
  @JsonKey()
  final bool isArchived;
  @override
  @JsonKey()
  final bool isEdited;
  final Map<String, int> _reactions;
  @override
  @JsonKey()
  Map<String, int> get reactions {
    if (_reactions is EqualUnmodifiableMapView) return _reactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_reactions);
  }

  // {'👍': 5, '❤️': 3}
  final Map<String, List<String>> _reactionUsers;
  // {'👍': 5, '❤️': 3}
  @override
  @JsonKey()
  Map<String, List<String>> get reactionUsers {
    if (_reactionUsers is EqualUnmodifiableMapView) return _reactionUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_reactionUsers);
  }

  // {'👍': ['uid1', 'uid2']}
  @override
  @JsonKey()
  final int commentCount;
  // Poll support (optional)
  final Map<String, dynamic>? _poll;
  // Poll support (optional)
  @override
  Map<String, dynamic>? get poll {
    final value = _poll;
    if (value == null) return null;
    if (_poll is EqualUnmodifiableMapView) return _poll;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  // Metadata
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;
  @override
  @TimestampConverter()
  final DateTime? pinnedAt;

  @override
  String toString() {
    return 'WallPost(id: $id, courseId: $courseId, authorId: $authorId, content: $content, authorEmail: $authorEmail, authorName: $authorName, fileUrl: $fileUrl, imageUrl: $imageUrl, imageUrls: $imageUrls, isPinned: $isPinned, isArchived: $isArchived, isEdited: $isEdited, reactions: $reactions, reactionUsers: $reactionUsers, commentCount: $commentCount, poll: $poll, createdAt: $createdAt, updatedAt: $updatedAt, pinnedAt: $pinnedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WallPostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorEmail, authorEmail) ||
                other.authorEmail == authorEmail) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            const DeepCollectionEquality().equals(
              other._reactions,
              _reactions,
            ) &&
            const DeepCollectionEquality().equals(
              other._reactionUsers,
              _reactionUsers,
            ) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            const DeepCollectionEquality().equals(other._poll, _poll) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.pinnedAt, pinnedAt) ||
                other.pinnedAt == pinnedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    courseId,
    authorId,
    content,
    authorEmail,
    authorName,
    fileUrl,
    imageUrl,
    const DeepCollectionEquality().hash(_imageUrls),
    isPinned,
    isArchived,
    isEdited,
    const DeepCollectionEquality().hash(_reactions),
    const DeepCollectionEquality().hash(_reactionUsers),
    commentCount,
    const DeepCollectionEquality().hash(_poll),
    createdAt,
    updatedAt,
    pinnedAt,
  ]);

  /// Create a copy of WallPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WallPostImplCopyWith<_$WallPostImpl> get copyWith =>
      __$$WallPostImplCopyWithImpl<_$WallPostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WallPostImplToJson(this);
  }
}

abstract class _WallPost extends WallPost {
  const factory _WallPost({
    required final String id,
    required final String courseId,
    required final String authorId,
    required final String content,
    final String? authorEmail,
    final String? authorName,
    final String? fileUrl,
    final String? imageUrl,
    final List<String> imageUrls,
    final bool isPinned,
    final bool isArchived,
    final bool isEdited,
    final Map<String, int> reactions,
    final Map<String, List<String>> reactionUsers,
    final int commentCount,
    final Map<String, dynamic>? poll,
    @TimestampConverter() final DateTime? createdAt,
    @TimestampConverter() final DateTime? updatedAt,
    @TimestampConverter() final DateTime? pinnedAt,
  }) = _$WallPostImpl;
  const _WallPost._() : super._();

  factory _WallPost.fromJson(Map<String, dynamic> json) =
      _$WallPostImpl.fromJson;

  @override
  String get id;
  @override
  String get courseId;
  @override
  String get authorId;
  @override
  String get content;
  @override
  String? get authorEmail;
  @override
  String? get authorName;
  @override
  String? get fileUrl;
  @override
  String? get imageUrl;
  @override
  List<String> get imageUrls; // Multiple images support
  // Enhanced features
  @override
  bool get isPinned;
  @override
  bool get isArchived;
  @override
  bool get isEdited;
  @override
  Map<String, int> get reactions; // {'👍': 5, '❤️': 3}
  @override
  Map<String, List<String>> get reactionUsers; // {'👍': ['uid1', 'uid2']}
  @override
  int get commentCount; // Poll support (optional)
  @override
  Map<String, dynamic>? get poll; // Metadata
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @TimestampConverter()
  DateTime? get pinnedAt;

  /// Create a copy of WallPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WallPostImplCopyWith<_$WallPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
