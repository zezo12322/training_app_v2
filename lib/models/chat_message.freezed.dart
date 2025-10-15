// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  /// Unique message ID
  String get id => throw _privateConstructorUsedError;

  /// ID of the chat room this message belongs to
  String get chatRoomId => throw _privateConstructorUsedError;

  /// Course ID (for course-level chats)
  String get courseId => throw _privateConstructorUsedError;

  /// Tenant isolation
  String get institutionId => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;

  /// Author information
  String get authorId => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  String get authorRole => throw _privateConstructorUsedError;

  /// Message content
  String get content => throw _privateConstructorUsedError;

  /// Optional: Image URL attachment
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Message metadata
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  /// Status flags
  bool get isEdited => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Read receipts (list of user IDs who read this message)
  List<String> get readBy => throw _privateConstructorUsedError;

  /// Threading support
  String? get parentMessageId => throw _privateConstructorUsedError;
  int get threadCount => throw _privateConstructorUsedError;
  bool get hasThread => throw _privateConstructorUsedError;

  /// Moderation
  bool get isFlagged => throw _privateConstructorUsedError;
  bool get isModerated => throw _privateConstructorUsedError;
  String? get moderatedBy => throw _privateConstructorUsedError;
  String? get moderationReason => throw _privateConstructorUsedError;

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
    ChatMessage value,
    $Res Function(ChatMessage) then,
  ) = _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call({
    String id,
    String chatRoomId,
    String courseId,
    String institutionId,
    String companyId,
    String authorId,
    String authorName,
    String authorRole,
    String content,
    String? imageUrl,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? deletedAt,
    bool isEdited,
    bool isDeleted,
    List<String> readBy,
    String? parentMessageId,
    int threadCount,
    bool hasThread,
    bool isFlagged,
    bool isModerated,
    String? moderatedBy,
    String? moderationReason,
  });
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatRoomId = null,
    Object? courseId = null,
    Object? institutionId = null,
    Object? companyId = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorRole = null,
    Object? content = null,
    Object? imageUrl = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? isEdited = null,
    Object? isDeleted = null,
    Object? readBy = null,
    Object? parentMessageId = freezed,
    Object? threadCount = null,
    Object? hasThread = null,
    Object? isFlagged = null,
    Object? isModerated = null,
    Object? moderatedBy = freezed,
    Object? moderationReason = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            chatRoomId: null == chatRoomId
                ? _value.chatRoomId
                : chatRoomId // ignore: cast_nullable_to_non_nullable
                      as String,
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: null == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String,
            authorId: null == authorId
                ? _value.authorId
                : authorId // ignore: cast_nullable_to_non_nullable
                      as String,
            authorName: null == authorName
                ? _value.authorName
                : authorName // ignore: cast_nullable_to_non_nullable
                      as String,
            authorRole: null == authorRole
                ? _value.authorRole
                : authorRole // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            deletedAt: freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isEdited: null == isEdited
                ? _value.isEdited
                : isEdited // ignore: cast_nullable_to_non_nullable
                      as bool,
            isDeleted: null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            readBy: null == readBy
                ? _value.readBy
                : readBy // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            parentMessageId: freezed == parentMessageId
                ? _value.parentMessageId
                : parentMessageId // ignore: cast_nullable_to_non_nullable
                      as String?,
            threadCount: null == threadCount
                ? _value.threadCount
                : threadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            hasThread: null == hasThread
                ? _value.hasThread
                : hasThread // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFlagged: null == isFlagged
                ? _value.isFlagged
                : isFlagged // ignore: cast_nullable_to_non_nullable
                      as bool,
            isModerated: null == isModerated
                ? _value.isModerated
                : isModerated // ignore: cast_nullable_to_non_nullable
                      as bool,
            moderatedBy: freezed == moderatedBy
                ? _value.moderatedBy
                : moderatedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            moderationReason: freezed == moderationReason
                ? _value.moderationReason
                : moderationReason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
    _$ChatMessageImpl value,
    $Res Function(_$ChatMessageImpl) then,
  ) = __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String chatRoomId,
    String courseId,
    String institutionId,
    String companyId,
    String authorId,
    String authorName,
    String authorRole,
    String content,
    String? imageUrl,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? deletedAt,
    bool isEdited,
    bool isDeleted,
    List<String> readBy,
    String? parentMessageId,
    int threadCount,
    bool hasThread,
    bool isFlagged,
    bool isModerated,
    String? moderatedBy,
    String? moderationReason,
  });
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
    _$ChatMessageImpl _value,
    $Res Function(_$ChatMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatRoomId = null,
    Object? courseId = null,
    Object? institutionId = null,
    Object? companyId = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorRole = null,
    Object? content = null,
    Object? imageUrl = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? isEdited = null,
    Object? isDeleted = null,
    Object? readBy = null,
    Object? parentMessageId = freezed,
    Object? threadCount = null,
    Object? hasThread = null,
    Object? isFlagged = null,
    Object? isModerated = null,
    Object? moderatedBy = freezed,
    Object? moderationReason = freezed,
  }) {
    return _then(
      _$ChatMessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        chatRoomId: null == chatRoomId
            ? _value.chatRoomId
            : chatRoomId // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
        authorId: null == authorId
            ? _value.authorId
            : authorId // ignore: cast_nullable_to_non_nullable
                  as String,
        authorName: null == authorName
            ? _value.authorName
            : authorName // ignore: cast_nullable_to_non_nullable
                  as String,
        authorRole: null == authorRole
            ? _value.authorRole
            : authorRole // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        deletedAt: freezed == deletedAt
            ? _value.deletedAt
            : deletedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isEdited: null == isEdited
            ? _value.isEdited
            : isEdited // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        readBy: null == readBy
            ? _value._readBy
            : readBy // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        parentMessageId: freezed == parentMessageId
            ? _value.parentMessageId
            : parentMessageId // ignore: cast_nullable_to_non_nullable
                  as String?,
        threadCount: null == threadCount
            ? _value.threadCount
            : threadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        hasThread: null == hasThread
            ? _value.hasThread
            : hasThread // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFlagged: null == isFlagged
            ? _value.isFlagged
            : isFlagged // ignore: cast_nullable_to_non_nullable
                  as bool,
        isModerated: null == isModerated
            ? _value.isModerated
            : isModerated // ignore: cast_nullable_to_non_nullable
                  as bool,
        moderatedBy: freezed == moderatedBy
            ? _value.moderatedBy
            : moderatedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        moderationReason: freezed == moderationReason
            ? _value.moderationReason
            : moderationReason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageImpl extends _ChatMessage {
  const _$ChatMessageImpl({
    required this.id,
    required this.chatRoomId,
    required this.courseId,
    required this.institutionId,
    required this.companyId,
    required this.authorId,
    required this.authorName,
    required this.authorRole,
    required this.content,
    this.imageUrl,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() this.updatedAt,
    @TimestampConverter() this.deletedAt,
    this.isEdited = false,
    this.isDeleted = false,
    final List<String> readBy = const [],
    this.parentMessageId,
    this.threadCount = 0,
    this.hasThread = false,
    this.isFlagged = false,
    this.isModerated = false,
    this.moderatedBy,
    this.moderationReason,
  }) : _readBy = readBy,
       super._();

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  /// Unique message ID
  @override
  final String id;

  /// ID of the chat room this message belongs to
  @override
  final String chatRoomId;

  /// Course ID (for course-level chats)
  @override
  final String courseId;

  /// Tenant isolation
  @override
  final String institutionId;
  @override
  final String companyId;

  /// Author information
  @override
  final String authorId;
  @override
  final String authorName;
  @override
  final String authorRole;

  /// Message content
  @override
  final String content;

  /// Optional: Image URL attachment
  @override
  final String? imageUrl;

  /// Message metadata
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;
  @override
  @TimestampConverter()
  final DateTime? deletedAt;

  /// Status flags
  @override
  @JsonKey()
  final bool isEdited;
  @override
  @JsonKey()
  final bool isDeleted;

  /// Read receipts (list of user IDs who read this message)
  final List<String> _readBy;

  /// Read receipts (list of user IDs who read this message)
  @override
  @JsonKey()
  List<String> get readBy {
    if (_readBy is EqualUnmodifiableListView) return _readBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_readBy);
  }

  /// Threading support
  @override
  final String? parentMessageId;
  @override
  @JsonKey()
  final int threadCount;
  @override
  @JsonKey()
  final bool hasThread;

  /// Moderation
  @override
  @JsonKey()
  final bool isFlagged;
  @override
  @JsonKey()
  final bool isModerated;
  @override
  final String? moderatedBy;
  @override
  final String? moderationReason;

  @override
  String toString() {
    return 'ChatMessage(id: $id, chatRoomId: $chatRoomId, courseId: $courseId, institutionId: $institutionId, companyId: $companyId, authorId: $authorId, authorName: $authorName, authorRole: $authorRole, content: $content, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, isEdited: $isEdited, isDeleted: $isDeleted, readBy: $readBy, parentMessageId: $parentMessageId, threadCount: $threadCount, hasThread: $hasThread, isFlagged: $isFlagged, isModerated: $isModerated, moderatedBy: $moderatedBy, moderationReason: $moderationReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.authorRole, authorRole) ||
                other.authorRole == authorRole) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            const DeepCollectionEquality().equals(other._readBy, _readBy) &&
            (identical(other.parentMessageId, parentMessageId) ||
                other.parentMessageId == parentMessageId) &&
            (identical(other.threadCount, threadCount) ||
                other.threadCount == threadCount) &&
            (identical(other.hasThread, hasThread) ||
                other.hasThread == hasThread) &&
            (identical(other.isFlagged, isFlagged) ||
                other.isFlagged == isFlagged) &&
            (identical(other.isModerated, isModerated) ||
                other.isModerated == isModerated) &&
            (identical(other.moderatedBy, moderatedBy) ||
                other.moderatedBy == moderatedBy) &&
            (identical(other.moderationReason, moderationReason) ||
                other.moderationReason == moderationReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    chatRoomId,
    courseId,
    institutionId,
    companyId,
    authorId,
    authorName,
    authorRole,
    content,
    imageUrl,
    createdAt,
    updatedAt,
    deletedAt,
    isEdited,
    isDeleted,
    const DeepCollectionEquality().hash(_readBy),
    parentMessageId,
    threadCount,
    hasThread,
    isFlagged,
    isModerated,
    moderatedBy,
    moderationReason,
  ]);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(this);
  }
}

abstract class _ChatMessage extends ChatMessage {
  const factory _ChatMessage({
    required final String id,
    required final String chatRoomId,
    required final String courseId,
    required final String institutionId,
    required final String companyId,
    required final String authorId,
    required final String authorName,
    required final String authorRole,
    required final String content,
    final String? imageUrl,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() final DateTime? updatedAt,
    @TimestampConverter() final DateTime? deletedAt,
    final bool isEdited,
    final bool isDeleted,
    final List<String> readBy,
    final String? parentMessageId,
    final int threadCount,
    final bool hasThread,
    final bool isFlagged,
    final bool isModerated,
    final String? moderatedBy,
    final String? moderationReason,
  }) = _$ChatMessageImpl;
  const _ChatMessage._() : super._();

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  /// Unique message ID
  @override
  String get id;

  /// ID of the chat room this message belongs to
  @override
  String get chatRoomId;

  /// Course ID (for course-level chats)
  @override
  String get courseId;

  /// Tenant isolation
  @override
  String get institutionId;
  @override
  String get companyId;

  /// Author information
  @override
  String get authorId;
  @override
  String get authorName;
  @override
  String get authorRole;

  /// Message content
  @override
  String get content;

  /// Optional: Image URL attachment
  @override
  String? get imageUrl;

  /// Message metadata
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @TimestampConverter()
  DateTime? get deletedAt;

  /// Status flags
  @override
  bool get isEdited;
  @override
  bool get isDeleted;

  /// Read receipts (list of user IDs who read this message)
  @override
  List<String> get readBy;

  /// Threading support
  @override
  String? get parentMessageId;
  @override
  int get threadCount;
  @override
  bool get hasThread;

  /// Moderation
  @override
  bool get isFlagged;
  @override
  bool get isModerated;
  @override
  String? get moderatedBy;
  @override
  String? get moderationReason;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateChatMessageDto _$CreateChatMessageDtoFromJson(Map<String, dynamic> json) {
  return _CreateChatMessageDto.fromJson(json);
}

/// @nodoc
mixin _$CreateChatMessageDto {
  String get chatRoomId => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  String get institutionId => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  String get authorRole => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this CreateChatMessageDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateChatMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateChatMessageDtoCopyWith<CreateChatMessageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateChatMessageDtoCopyWith<$Res> {
  factory $CreateChatMessageDtoCopyWith(
    CreateChatMessageDto value,
    $Res Function(CreateChatMessageDto) then,
  ) = _$CreateChatMessageDtoCopyWithImpl<$Res, CreateChatMessageDto>;
  @useResult
  $Res call({
    String chatRoomId,
    String courseId,
    String institutionId,
    String companyId,
    String authorId,
    String authorName,
    String authorRole,
    String content,
    String? imageUrl,
  });
}

/// @nodoc
class _$CreateChatMessageDtoCopyWithImpl<
  $Res,
  $Val extends CreateChatMessageDto
>
    implements $CreateChatMessageDtoCopyWith<$Res> {
  _$CreateChatMessageDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateChatMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRoomId = null,
    Object? courseId = null,
    Object? institutionId = null,
    Object? companyId = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorRole = null,
    Object? content = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            chatRoomId: null == chatRoomId
                ? _value.chatRoomId
                : chatRoomId // ignore: cast_nullable_to_non_nullable
                      as String,
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: null == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String,
            authorId: null == authorId
                ? _value.authorId
                : authorId // ignore: cast_nullable_to_non_nullable
                      as String,
            authorName: null == authorName
                ? _value.authorName
                : authorName // ignore: cast_nullable_to_non_nullable
                      as String,
            authorRole: null == authorRole
                ? _value.authorRole
                : authorRole // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateChatMessageDtoImplCopyWith<$Res>
    implements $CreateChatMessageDtoCopyWith<$Res> {
  factory _$$CreateChatMessageDtoImplCopyWith(
    _$CreateChatMessageDtoImpl value,
    $Res Function(_$CreateChatMessageDtoImpl) then,
  ) = __$$CreateChatMessageDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String chatRoomId,
    String courseId,
    String institutionId,
    String companyId,
    String authorId,
    String authorName,
    String authorRole,
    String content,
    String? imageUrl,
  });
}

/// @nodoc
class __$$CreateChatMessageDtoImplCopyWithImpl<$Res>
    extends _$CreateChatMessageDtoCopyWithImpl<$Res, _$CreateChatMessageDtoImpl>
    implements _$$CreateChatMessageDtoImplCopyWith<$Res> {
  __$$CreateChatMessageDtoImplCopyWithImpl(
    _$CreateChatMessageDtoImpl _value,
    $Res Function(_$CreateChatMessageDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateChatMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRoomId = null,
    Object? courseId = null,
    Object? institutionId = null,
    Object? companyId = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorRole = null,
    Object? content = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$CreateChatMessageDtoImpl(
        chatRoomId: null == chatRoomId
            ? _value.chatRoomId
            : chatRoomId // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
        authorId: null == authorId
            ? _value.authorId
            : authorId // ignore: cast_nullable_to_non_nullable
                  as String,
        authorName: null == authorName
            ? _value.authorName
            : authorName // ignore: cast_nullable_to_non_nullable
                  as String,
        authorRole: null == authorRole
            ? _value.authorRole
            : authorRole // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateChatMessageDtoImpl implements _CreateChatMessageDto {
  const _$CreateChatMessageDtoImpl({
    required this.chatRoomId,
    required this.courseId,
    required this.institutionId,
    required this.companyId,
    required this.authorId,
    required this.authorName,
    required this.authorRole,
    required this.content,
    this.imageUrl,
  });

  factory _$CreateChatMessageDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateChatMessageDtoImplFromJson(json);

  @override
  final String chatRoomId;
  @override
  final String courseId;
  @override
  final String institutionId;
  @override
  final String companyId;
  @override
  final String authorId;
  @override
  final String authorName;
  @override
  final String authorRole;
  @override
  final String content;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'CreateChatMessageDto(chatRoomId: $chatRoomId, courseId: $courseId, institutionId: $institutionId, companyId: $companyId, authorId: $authorId, authorName: $authorName, authorRole: $authorRole, content: $content, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateChatMessageDtoImpl &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.authorRole, authorRole) ||
                other.authorRole == authorRole) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    chatRoomId,
    courseId,
    institutionId,
    companyId,
    authorId,
    authorName,
    authorRole,
    content,
    imageUrl,
  );

  /// Create a copy of CreateChatMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateChatMessageDtoImplCopyWith<_$CreateChatMessageDtoImpl>
  get copyWith =>
      __$$CreateChatMessageDtoImplCopyWithImpl<_$CreateChatMessageDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateChatMessageDtoImplToJson(this);
  }
}

abstract class _CreateChatMessageDto implements CreateChatMessageDto {
  const factory _CreateChatMessageDto({
    required final String chatRoomId,
    required final String courseId,
    required final String institutionId,
    required final String companyId,
    required final String authorId,
    required final String authorName,
    required final String authorRole,
    required final String content,
    final String? imageUrl,
  }) = _$CreateChatMessageDtoImpl;

  factory _CreateChatMessageDto.fromJson(Map<String, dynamic> json) =
      _$CreateChatMessageDtoImpl.fromJson;

  @override
  String get chatRoomId;
  @override
  String get courseId;
  @override
  String get institutionId;
  @override
  String get companyId;
  @override
  String get authorId;
  @override
  String get authorName;
  @override
  String get authorRole;
  @override
  String get content;
  @override
  String? get imageUrl;

  /// Create a copy of CreateChatMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateChatMessageDtoImplCopyWith<_$CreateChatMessageDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
