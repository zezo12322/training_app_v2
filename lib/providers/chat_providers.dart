import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_message.dart';
import '../models/chat_room.dart';
import '../repositories/chat_repository.dart';
import 'auth_provider.dart';

// ==================== Chat Room Providers ====================

/// Provider for getting or creating course chat room
final courseChatRoomProvider = FutureProvider.autoDispose
    .family<ChatRoom, CourseChatRoomParams>((ref, params) async {
  final repository = ref.watch(chatRepositoryProvider);
  final userAsync = ref.watch(currentUserModelProvider);
  final user = userAsync.value;

  if (user == null) {
    throw Exception('User not authenticated');
  }

  return repository.getOrCreateCourseChatRoom(
    courseId: params.courseId,
    courseName: params.courseName,
    institutionId: user.institutionId!,
    companyId: user.companyId!,
    participantIds: [user.id],
  );
});

/// Parameters for course chat room
class CourseChatRoomParams {
  final String courseId;
  final String courseName;

  CourseChatRoomParams({
    required this.courseId,
    required this.courseName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseChatRoomParams &&
          runtimeType == other.runtimeType &&
          courseId == other.courseId &&
          courseName == other.courseName;

  @override
  int get hashCode => courseId.hashCode ^ courseName.hashCode;
}

/// Stream chat room by ID
final chatRoomProvider =
    StreamProvider.autoDispose.family<ChatRoom?, String>((ref, roomId) {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.streamChatRoom(roomId);
});

/// Stream user's chat rooms
final userChatRoomsProvider =
    StreamProvider.autoDispose<List<ChatRoom>>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  final userAsync = ref.watch(currentUserModelProvider);
  final user = userAsync.value;

  if (user == null) {
    return Stream.value([]);
  }

  return repository.streamUserChatRooms(
    userId: user.id,
    institutionId: user.institutionId!,
    companyId: user.companyId!,
  );
});

// ==================== Message Providers ====================

/// Stream messages for a chat room
final chatMessagesProvider = StreamProvider.autoDispose
    .family<List<ChatMessage>, String>((ref, chatRoomId) {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.streamMessages(chatRoomId: chatRoomId);
});

/// Provider for sending a message
final sendMessageProvider =
    Provider.autoDispose<Future<ChatMessage> Function(CreateChatMessageDto)>(
  (ref) {
    final repository = ref.watch(chatRepositoryProvider);
    return (dto) => repository.sendMessage(dto);
  },
);

/// Provider for marking message as read
final markMessageAsReadProvider = Provider.autoDispose<
    Future<void> Function({
  required String chatRoomId,
  required String messageId,
  required String userId,
})>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ({
    required String chatRoomId,
    required String messageId,
    required String userId,
  }) =>
      repository.markMessageAsRead(
        chatRoomId: chatRoomId,
        messageId: messageId,
        userId: userId,
      );
});

/// Provider for marking all messages in room as read
final markAllAsReadProvider = Provider.autoDispose<
    Future<void> Function({
  required String chatRoomId,
  required String userId,
})>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ({
    required String chatRoomId,
    required String userId,
  }) =>
      repository.markAllMessagesAsRead(
        chatRoomId: chatRoomId,
        userId: userId,
      );
});

/// Provider for getting unread count
final unreadCountProvider = FutureProvider.autoDispose
    .family<int, UnreadCountParams>((ref, params) async {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getUnreadCount(
    chatRoomId: params.chatRoomId,
    userId: params.userId,
  );
});

/// Parameters for unread count
class UnreadCountParams {
  final String chatRoomId;
  final String userId;

  UnreadCountParams({
    required this.chatRoomId,
    required this.userId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnreadCountParams &&
          runtimeType == other.runtimeType &&
          chatRoomId == other.chatRoomId &&
          userId == other.userId;

  @override
  int get hashCode => chatRoomId.hashCode ^ userId.hashCode;
}

/// Provider for editing a message
final editMessageProvider = Provider.autoDispose<
    Future<void> Function({
  required String chatRoomId,
  required String messageId,
  required String newContent,
})>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ({
    required String chatRoomId,
    required String messageId,
    required String newContent,
  }) =>
      repository.editMessage(
        chatRoomId: chatRoomId,
        messageId: messageId,
        newContent: newContent,
      );
});

/// Provider for deleting a message
final deleteMessageProvider = Provider.autoDispose<
    Future<void> Function({
  required String chatRoomId,
  required String messageId,
})>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ({
    required String chatRoomId,
    required String messageId,
  }) =>
      repository.deleteMessage(
        chatRoomId: chatRoomId,
        messageId: messageId,
      );
});

/// Provider for flagging a message
final flagMessageProvider = Provider.autoDispose<
    Future<void> Function({
  required String chatRoomId,
  required String messageId,
})>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ({
    required String chatRoomId,
    required String messageId,
  }) =>
      repository.flagMessage(
        chatRoomId: chatRoomId,
        messageId: messageId,
      );
});

// ==================== Total Unread Count ====================

/// Provider for total unread messages across all rooms
final totalUnreadCountProvider = StreamProvider.autoDispose<int>((ref) {
  final chatRoomsAsync = ref.watch(userChatRoomsProvider);

  return chatRoomsAsync.when(
    data: (rooms) {
      final userAsync = ref.watch(currentUserModelProvider);
      final user = userAsync.value;
      if (user == null) return Stream.value(0);

      // Sum unread counts from all rooms
      final total = rooms.fold<int>(
        0,
        (sum, room) => sum + room.unreadCountFor(user.id),
      );

      return Stream.value(total);
    },
    loading: () => Stream.value(0),
    error: (_, __) => Stream.value(0),
  );
});
