// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) {
  return _ChatRoom.fromJson(json);
}

/// @nodoc
mixin _$ChatRoom {
  /// Unique chat room ID
  String get id => throw _privateConstructorUsedError;

  /// Room type
  ChatRoomType get type => throw _privateConstructorUsedError;

  /// For course chats
  String? get courseId => throw _privateConstructorUsedError;
  String? get courseName => throw _privateConstructorUsedError;

  /// Tenant isolation
  String get institutionId => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;

  /// Participants (list of user IDs)
  List<String> get participantIds => throw _privateConstructorUsedError;

  /// Room metadata
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Last message info (for preview)
  String? get lastMessageContent => throw _privateConstructorUsedError;
  String? get lastMessageAuthor => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastMessageAt => throw _privateConstructorUsedError;

  /// Unread counts per user (Map of userId to count)
  Map<String, int> get unreadCounts => throw _privateConstructorUsedError;

  /// Settings
  bool get isActive => throw _privateConstructorUsedError;
  bool get isArchived => throw _privateConstructorUsedError;

  /// Moderation settings
  bool get isMuted => throw _privateConstructorUsedError;
  List<String> get mutedBy =>
      throw _privateConstructorUsedError; // List of user IDs who muted this room
  List<String> get blockedUsers => throw _privateConstructorUsedError;

  /// Serializes this ChatRoom to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatRoomCopyWith<ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomCopyWith<$Res> {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) then) =
      _$ChatRoomCopyWithImpl<$Res, ChatRoom>;
  @useResult
  $Res call({
    String id,
    ChatRoomType type,
    String? courseId,
    String? courseName,
    String institutionId,
    String companyId,
    List<String> participantIds,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime? updatedAt,
    String? lastMessageContent,
    String? lastMessageAuthor,
    @TimestampConverter() DateTime? lastMessageAt,
    Map<String, int> unreadCounts,
    bool isActive,
    bool isArchived,
    bool isMuted,
    List<String> mutedBy,
    List<String> blockedUsers,
  });
}

/// @nodoc
class _$ChatRoomCopyWithImpl<$Res, $Val extends ChatRoom>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? courseId = freezed,
    Object? courseName = freezed,
    Object? institutionId = null,
    Object? companyId = null,
    Object? participantIds = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? lastMessageContent = freezed,
    Object? lastMessageAuthor = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCounts = null,
    Object? isActive = null,
    Object? isArchived = null,
    Object? isMuted = null,
    Object? mutedBy = null,
    Object? blockedUsers = null,
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
                      as ChatRoomType,
            courseId: freezed == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String?,
            courseName: freezed == courseName
                ? _value.courseName
                : courseName // ignore: cast_nullable_to_non_nullable
                      as String?,
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: null == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String,
            participantIds: null == participantIds
                ? _value.participantIds
                : participantIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastMessageContent: freezed == lastMessageContent
                ? _value.lastMessageContent
                : lastMessageContent // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessageAuthor: freezed == lastMessageAuthor
                ? _value.lastMessageAuthor
                : lastMessageAuthor // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessageAt: freezed == lastMessageAt
                ? _value.lastMessageAt
                : lastMessageAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            unreadCounts: null == unreadCounts
                ? _value.unreadCounts
                : unreadCounts // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            isArchived: null == isArchived
                ? _value.isArchived
                : isArchived // ignore: cast_nullable_to_non_nullable
                      as bool,
            isMuted: null == isMuted
                ? _value.isMuted
                : isMuted // ignore: cast_nullable_to_non_nullable
                      as bool,
            mutedBy: null == mutedBy
                ? _value.mutedBy
                : mutedBy // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            blockedUsers: null == blockedUsers
                ? _value.blockedUsers
                : blockedUsers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatRoomImplCopyWith<$Res>
    implements $ChatRoomCopyWith<$Res> {
  factory _$$ChatRoomImplCopyWith(
    _$ChatRoomImpl value,
    $Res Function(_$ChatRoomImpl) then,
  ) = __$$ChatRoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    ChatRoomType type,
    String? courseId,
    String? courseName,
    String institutionId,
    String companyId,
    List<String> participantIds,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime? updatedAt,
    String? lastMessageContent,
    String? lastMessageAuthor,
    @TimestampConverter() DateTime? lastMessageAt,
    Map<String, int> unreadCounts,
    bool isActive,
    bool isArchived,
    bool isMuted,
    List<String> mutedBy,
    List<String> blockedUsers,
  });
}

/// @nodoc
class __$$ChatRoomImplCopyWithImpl<$Res>
    extends _$ChatRoomCopyWithImpl<$Res, _$ChatRoomImpl>
    implements _$$ChatRoomImplCopyWith<$Res> {
  __$$ChatRoomImplCopyWithImpl(
    _$ChatRoomImpl _value,
    $Res Function(_$ChatRoomImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? courseId = freezed,
    Object? courseName = freezed,
    Object? institutionId = null,
    Object? companyId = null,
    Object? participantIds = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? lastMessageContent = freezed,
    Object? lastMessageAuthor = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCounts = null,
    Object? isActive = null,
    Object? isArchived = null,
    Object? isMuted = null,
    Object? mutedBy = null,
    Object? blockedUsers = null,
  }) {
    return _then(
      _$ChatRoomImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ChatRoomType,
        courseId: freezed == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String?,
        courseName: freezed == courseName
            ? _value.courseName
            : courseName // ignore: cast_nullable_to_non_nullable
                  as String?,
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
        participantIds: null == participantIds
            ? _value._participantIds
            : participantIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastMessageContent: freezed == lastMessageContent
            ? _value.lastMessageContent
            : lastMessageContent // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessageAuthor: freezed == lastMessageAuthor
            ? _value.lastMessageAuthor
            : lastMessageAuthor // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessageAt: freezed == lastMessageAt
            ? _value.lastMessageAt
            : lastMessageAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        unreadCounts: null == unreadCounts
            ? _value._unreadCounts
            : unreadCounts // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        isArchived: null == isArchived
            ? _value.isArchived
            : isArchived // ignore: cast_nullable_to_non_nullable
                  as bool,
        isMuted: null == isMuted
            ? _value.isMuted
            : isMuted // ignore: cast_nullable_to_non_nullable
                  as bool,
        mutedBy: null == mutedBy
            ? _value._mutedBy
            : mutedBy // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        blockedUsers: null == blockedUsers
            ? _value._blockedUsers
            : blockedUsers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatRoomImpl extends _ChatRoom {
  const _$ChatRoomImpl({
    required this.id,
    required this.type,
    this.courseId,
    this.courseName,
    required this.institutionId,
    required this.companyId,
    required final List<String> participantIds,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() this.updatedAt,
    this.lastMessageContent,
    this.lastMessageAuthor,
    @TimestampConverter() this.lastMessageAt,
    final Map<String, int> unreadCounts = const {},
    this.isActive = true,
    this.isArchived = false,
    this.isMuted = false,
    final List<String> mutedBy = const [],
    final List<String> blockedUsers = const [],
  }) : _participantIds = participantIds,
       _unreadCounts = unreadCounts,
       _mutedBy = mutedBy,
       _blockedUsers = blockedUsers,
       super._();

  factory _$ChatRoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomImplFromJson(json);

  /// Unique chat room ID
  @override
  final String id;

  /// Room type
  @override
  final ChatRoomType type;

  /// For course chats
  @override
  final String? courseId;
  @override
  final String? courseName;

  /// Tenant isolation
  @override
  final String institutionId;
  @override
  final String companyId;

  /// Participants (list of user IDs)
  final List<String> _participantIds;

  /// Participants (list of user IDs)
  @override
  List<String> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  /// Room metadata
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  /// Last message info (for preview)
  @override
  final String? lastMessageContent;
  @override
  final String? lastMessageAuthor;
  @override
  @TimestampConverter()
  final DateTime? lastMessageAt;

  /// Unread counts per user (Map of userId to count)
  final Map<String, int> _unreadCounts;

  /// Unread counts per user (Map of userId to count)
  @override
  @JsonKey()
  Map<String, int> get unreadCounts {
    if (_unreadCounts is EqualUnmodifiableMapView) return _unreadCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_unreadCounts);
  }

  /// Settings
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isArchived;

  /// Moderation settings
  @override
  @JsonKey()
  final bool isMuted;
  final List<String> _mutedBy;
  @override
  @JsonKey()
  List<String> get mutedBy {
    if (_mutedBy is EqualUnmodifiableListView) return _mutedBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mutedBy);
  }

  // List of user IDs who muted this room
  final List<String> _blockedUsers;
  // List of user IDs who muted this room
  @override
  @JsonKey()
  List<String> get blockedUsers {
    if (_blockedUsers is EqualUnmodifiableListView) return _blockedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blockedUsers);
  }

  @override
  String toString() {
    return 'ChatRoom(id: $id, type: $type, courseId: $courseId, courseName: $courseName, institutionId: $institutionId, companyId: $companyId, participantIds: $participantIds, createdAt: $createdAt, updatedAt: $updatedAt, lastMessageContent: $lastMessageContent, lastMessageAuthor: $lastMessageAuthor, lastMessageAt: $lastMessageAt, unreadCounts: $unreadCounts, isActive: $isActive, isArchived: $isArchived, isMuted: $isMuted, mutedBy: $mutedBy, blockedUsers: $blockedUsers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            const DeepCollectionEquality().equals(
              other._participantIds,
              _participantIds,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastMessageContent, lastMessageContent) ||
                other.lastMessageContent == lastMessageContent) &&
            (identical(other.lastMessageAuthor, lastMessageAuthor) ||
                other.lastMessageAuthor == lastMessageAuthor) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt) &&
            const DeepCollectionEquality().equals(
              other._unreadCounts,
              _unreadCounts,
            ) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted) &&
            const DeepCollectionEquality().equals(other._mutedBy, _mutedBy) &&
            const DeepCollectionEquality().equals(
              other._blockedUsers,
              _blockedUsers,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    courseId,
    courseName,
    institutionId,
    companyId,
    const DeepCollectionEquality().hash(_participantIds),
    createdAt,
    updatedAt,
    lastMessageContent,
    lastMessageAuthor,
    lastMessageAt,
    const DeepCollectionEquality().hash(_unreadCounts),
    isActive,
    isArchived,
    isMuted,
    const DeepCollectionEquality().hash(_mutedBy),
    const DeepCollectionEquality().hash(_blockedUsers),
  );

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      __$$ChatRoomImplCopyWithImpl<_$ChatRoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomImplToJson(this);
  }
}

abstract class _ChatRoom extends ChatRoom {
  const factory _ChatRoom({
    required final String id,
    required final ChatRoomType type,
    final String? courseId,
    final String? courseName,
    required final String institutionId,
    required final String companyId,
    required final List<String> participantIds,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() final DateTime? updatedAt,
    final String? lastMessageContent,
    final String? lastMessageAuthor,
    @TimestampConverter() final DateTime? lastMessageAt,
    final Map<String, int> unreadCounts,
    final bool isActive,
    final bool isArchived,
    final bool isMuted,
    final List<String> mutedBy,
    final List<String> blockedUsers,
  }) = _$ChatRoomImpl;
  const _ChatRoom._() : super._();

  factory _ChatRoom.fromJson(Map<String, dynamic> json) =
      _$ChatRoomImpl.fromJson;

  /// Unique chat room ID
  @override
  String get id;

  /// Room type
  @override
  ChatRoomType get type;

  /// For course chats
  @override
  String? get courseId;
  @override
  String? get courseName;

  /// Tenant isolation
  @override
  String get institutionId;
  @override
  String get companyId;

  /// Participants (list of user IDs)
  @override
  List<String> get participantIds;

  /// Room metadata
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;

  /// Last message info (for preview)
  @override
  String? get lastMessageContent;
  @override
  String? get lastMessageAuthor;
  @override
  @TimestampConverter()
  DateTime? get lastMessageAt;

  /// Unread counts per user (Map of userId to count)
  @override
  Map<String, int> get unreadCounts;

  /// Settings
  @override
  bool get isActive;
  @override
  bool get isArchived;

  /// Moderation settings
  @override
  bool get isMuted;
  @override
  List<String> get mutedBy; // List of user IDs who muted this room
  @override
  List<String> get blockedUsers;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateChatRoomDto _$CreateChatRoomDtoFromJson(Map<String, dynamic> json) {
  return _CreateChatRoomDto.fromJson(json);
}

/// @nodoc
mixin _$CreateChatRoomDto {
  ChatRoomType get type => throw _privateConstructorUsedError;
  String? get courseId => throw _privateConstructorUsedError;
  String? get courseName => throw _privateConstructorUsedError;
  String get institutionId => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  List<String> get participantIds => throw _privateConstructorUsedError;

  /// Serializes this CreateChatRoomDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateChatRoomDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateChatRoomDtoCopyWith<CreateChatRoomDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateChatRoomDtoCopyWith<$Res> {
  factory $CreateChatRoomDtoCopyWith(
    CreateChatRoomDto value,
    $Res Function(CreateChatRoomDto) then,
  ) = _$CreateChatRoomDtoCopyWithImpl<$Res, CreateChatRoomDto>;
  @useResult
  $Res call({
    ChatRoomType type,
    String? courseId,
    String? courseName,
    String institutionId,
    String companyId,
    List<String> participantIds,
  });
}

/// @nodoc
class _$CreateChatRoomDtoCopyWithImpl<$Res, $Val extends CreateChatRoomDto>
    implements $CreateChatRoomDtoCopyWith<$Res> {
  _$CreateChatRoomDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateChatRoomDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? courseId = freezed,
    Object? courseName = freezed,
    Object? institutionId = null,
    Object? companyId = null,
    Object? participantIds = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ChatRoomType,
            courseId: freezed == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String?,
            courseName: freezed == courseName
                ? _value.courseName
                : courseName // ignore: cast_nullable_to_non_nullable
                      as String?,
            institutionId: null == institutionId
                ? _value.institutionId
                : institutionId // ignore: cast_nullable_to_non_nullable
                      as String,
            companyId: null == companyId
                ? _value.companyId
                : companyId // ignore: cast_nullable_to_non_nullable
                      as String,
            participantIds: null == participantIds
                ? _value.participantIds
                : participantIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateChatRoomDtoImplCopyWith<$Res>
    implements $CreateChatRoomDtoCopyWith<$Res> {
  factory _$$CreateChatRoomDtoImplCopyWith(
    _$CreateChatRoomDtoImpl value,
    $Res Function(_$CreateChatRoomDtoImpl) then,
  ) = __$$CreateChatRoomDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ChatRoomType type,
    String? courseId,
    String? courseName,
    String institutionId,
    String companyId,
    List<String> participantIds,
  });
}

/// @nodoc
class __$$CreateChatRoomDtoImplCopyWithImpl<$Res>
    extends _$CreateChatRoomDtoCopyWithImpl<$Res, _$CreateChatRoomDtoImpl>
    implements _$$CreateChatRoomDtoImplCopyWith<$Res> {
  __$$CreateChatRoomDtoImplCopyWithImpl(
    _$CreateChatRoomDtoImpl _value,
    $Res Function(_$CreateChatRoomDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateChatRoomDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? courseId = freezed,
    Object? courseName = freezed,
    Object? institutionId = null,
    Object? companyId = null,
    Object? participantIds = null,
  }) {
    return _then(
      _$CreateChatRoomDtoImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ChatRoomType,
        courseId: freezed == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String?,
        courseName: freezed == courseName
            ? _value.courseName
            : courseName // ignore: cast_nullable_to_non_nullable
                  as String?,
        institutionId: null == institutionId
            ? _value.institutionId
            : institutionId // ignore: cast_nullable_to_non_nullable
                  as String,
        companyId: null == companyId
            ? _value.companyId
            : companyId // ignore: cast_nullable_to_non_nullable
                  as String,
        participantIds: null == participantIds
            ? _value._participantIds
            : participantIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateChatRoomDtoImpl implements _CreateChatRoomDto {
  const _$CreateChatRoomDtoImpl({
    required this.type,
    this.courseId,
    this.courseName,
    required this.institutionId,
    required this.companyId,
    required final List<String> participantIds,
  }) : _participantIds = participantIds;

  factory _$CreateChatRoomDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateChatRoomDtoImplFromJson(json);

  @override
  final ChatRoomType type;
  @override
  final String? courseId;
  @override
  final String? courseName;
  @override
  final String institutionId;
  @override
  final String companyId;
  final List<String> _participantIds;
  @override
  List<String> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  @override
  String toString() {
    return 'CreateChatRoomDto(type: $type, courseId: $courseId, courseName: $courseName, institutionId: $institutionId, companyId: $companyId, participantIds: $participantIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateChatRoomDtoImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.institutionId, institutionId) ||
                other.institutionId == institutionId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            const DeepCollectionEquality().equals(
              other._participantIds,
              _participantIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    courseId,
    courseName,
    institutionId,
    companyId,
    const DeepCollectionEquality().hash(_participantIds),
  );

  /// Create a copy of CreateChatRoomDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateChatRoomDtoImplCopyWith<_$CreateChatRoomDtoImpl> get copyWith =>
      __$$CreateChatRoomDtoImplCopyWithImpl<_$CreateChatRoomDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateChatRoomDtoImplToJson(this);
  }
}

abstract class _CreateChatRoomDto implements CreateChatRoomDto {
  const factory _CreateChatRoomDto({
    required final ChatRoomType type,
    final String? courseId,
    final String? courseName,
    required final String institutionId,
    required final String companyId,
    required final List<String> participantIds,
  }) = _$CreateChatRoomDtoImpl;

  factory _CreateChatRoomDto.fromJson(Map<String, dynamic> json) =
      _$CreateChatRoomDtoImpl.fromJson;

  @override
  ChatRoomType get type;
  @override
  String? get courseId;
  @override
  String? get courseName;
  @override
  String get institutionId;
  @override
  String get companyId;
  @override
  List<String> get participantIds;

  /// Create a copy of CreateChatRoomDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateChatRoomDtoImplCopyWith<_$CreateChatRoomDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
