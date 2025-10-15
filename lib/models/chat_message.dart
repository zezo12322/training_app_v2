import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

/// Represents a chat message in a course chat room
@freezed
class ChatMessage with _$ChatMessage {
  const ChatMessage._();

  const factory ChatMessage({
    /// Unique message ID
    required String id,

    /// ID of the chat room this message belongs to
    required String chatRoomId,

    /// Course ID (for course-level chats)
    required String courseId,

    /// Tenant isolation
    required String institutionId,
    required String companyId,

    /// Author information
    required String authorId,
    required String authorName,
    required String authorRole,

    /// Message content
    required String content,

    /// Optional: Image URL attachment
    String? imageUrl,

    /// Message metadata
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? deletedAt,

    /// Status flags
    @Default(false) bool isEdited,
    @Default(false) bool isDeleted,

    /// Read receipts (list of user IDs who read this message)
    @Default([]) List<String> readBy,

    /// Moderation
    @Default(false) bool isFlagged,
    @Default(false) bool isModerated,
    String? moderatedBy,
    String? moderationReason,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  /// Check if message was read by a specific user
  bool isReadBy(String userId) => readBy.contains(userId);

  /// Check if message is visible (not deleted or moderated)
  bool get isVisible => !isDeleted && !isModerated;

  /// Get display content
  String get displayContent {
    if (isDeleted) return 'رسالة محذوفة';
    if (isModerated) return 'رسالة مخالفة للقواعد';
    return content;
  }
}

/// DTO for creating a new chat message
@freezed
class CreateChatMessageDto with _$CreateChatMessageDto {
  const factory CreateChatMessageDto({
    required String chatRoomId,
    required String courseId,
    required String institutionId,
    required String companyId,
    required String authorId,
    required String authorName,
    required String authorRole,
    required String content,
    String? imageUrl,
  }) = _CreateChatMessageDto;

  factory CreateChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$CreateChatMessageDtoFromJson(json);
}
