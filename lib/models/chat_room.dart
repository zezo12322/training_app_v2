import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'chat_room.freezed.dart';
part 'chat_room.g.dart';

/// Types of chat rooms
enum ChatRoomType {
  course,       // Chat within a course
  direct,       // Direct message between two users (future)
  group,        // Group chat (future)
}

/// Represents a chat room
@freezed
class ChatRoom with _$ChatRoom {
  const ChatRoom._();

  const factory ChatRoom({
    /// Unique chat room ID
    required String id,

    /// Room type
    required ChatRoomType type,

    /// For course chats
    String? courseId,
    String? courseName,

    /// Tenant isolation
    required String institutionId,
    required String companyId,

    /// Participants (list of user IDs)
    required List<String> participantIds,

    /// Room metadata
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() DateTime? updatedAt,

    /// Last message info (for preview)
    String? lastMessageContent,
    String? lastMessageAuthor,
    @TimestampConverter() DateTime? lastMessageAt,

    /// Unread counts per user (Map of userId to count)
    @Default({}) Map<String, int> unreadCounts,

    /// Settings
    @Default(true) bool isActive,
    @Default(false) bool isArchived,

    /// Moderation settings
    @Default(false) bool isMuted,
    @Default([]) List<String> mutedBy, // List of user IDs who muted this room
    @Default([]) List<String> blockedUsers, // Users blocked from posting
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  /// Get unread count for a specific user
  int unreadCountFor(String userId) => unreadCounts[userId] ?? 0;

  /// Check if user is participant
  bool hasParticipant(String userId) => participantIds.contains(userId);

  /// Check if user is muted
  bool isMutedBy(String userId) => mutedBy.contains(userId);

  /// Check if user is blocked
  bool isUserBlocked(String userId) => blockedUsers.contains(userId);
}

/// DTO for creating a new chat room
@freezed
class CreateChatRoomDto with _$CreateChatRoomDto {
  const factory CreateChatRoomDto({
    required ChatRoomType type,
    String? courseId,
    String? courseName,
    required String institutionId,
    required String companyId,
    required List<String> participantIds,
  }) = _CreateChatRoomDto;

  factory CreateChatRoomDto.fromJson(Map<String, dynamic> json) =>
      _$CreateChatRoomDtoFromJson(json);
}
