import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_message.dart';
import '../models/chat_room.dart';
import '../services/direct_message_service.dart';

/// Provider لخدمة المحادثات المباشرة
final directMessageServiceProvider = Provider<DirectMessageService>((ref) {
  return DirectMessageService();
});

/// Provider لإنشاء أو جلب غرفة محادثة مباشرة
final getOrCreateDirectRoomProvider = FutureProvider.family<
    ChatRoom?,
    ({
      String user1Id,
      String user2Id,
      String institutionId,
      String companyId,
    })>((ref, params) async {
  final service = ref.read(directMessageServiceProvider);
  return service.getOrCreateDirectRoom(
    user1Id: params.user1Id,
    user2Id: params.user2Id,
    institutionId: params.institutionId,
    companyId: params.companyId,
  );
});

/// Provider لبث رسائل غرفة محددة
final roomMessagesProvider = StreamProvider.family<
    List<ChatMessage>,
    ({String roomId, int limit})>((ref, params) {
  final service = ref.read(directMessageServiceProvider);
  return service.streamRoomMessages(
    roomId: params.roomId,
    limit: params.limit,
  );
});

/// Provider لبث غرف المحادثات المباشرة للمستخدم
final userDirectRoomsProvider = StreamProvider.family<List<ChatRoom>, String>((ref, userId) {
  final service = ref.read(directMessageServiceProvider);
  return service.streamUserDirectRooms(userId);
});

/// Provider لبث حالة الكتابة
final typingUsersProvider = StreamProvider.family<
    List<String>,
    ({String roomId, String currentUserId})>((ref, params) {
  final service = ref.read(directMessageServiceProvider);
  return service.streamTypingUsers(
    roomId: params.roomId,
    currentUserId: params.currentUserId,
  );
});

/// Provider لإرسال رسالة مباشرة
final sendDirectMessageProvider = Provider<
    Future<ChatMessage?> Function({
      required String roomId,
      required String senderId,
      required String senderName,
      required String senderRole,
      required String recipientId,
      required String content,
      required String institutionId,
      required String companyId,
      String? imageUrl,
    })>((ref) {
  final service = ref.read(directMessageServiceProvider);
  return ({
    required String roomId,
    required String senderId,
    required String senderName,
    required String senderRole,
    required String recipientId,
    required String content,
    required String institutionId,
    required String companyId,
    String? imageUrl,
  }) async {
    return service.sendDirectMessage(
      roomId: roomId,
      senderId: senderId,
      senderName: senderName,
      senderRole: senderRole,
      recipientId: recipientId,
      content: content,
      institutionId: institutionId,
      companyId: companyId,
      imageUrl: imageUrl,
    );
  };
});

/// Provider لتحديث حالة القراءة
final markAsReadProvider = Provider<
    Future<void> Function({
      required String messageId,
      required String userId,
    })>((ref) {
  final service = ref.read(directMessageServiceProvider);
  return ({
    required String messageId,
    required String userId,
  }) async {
    await service.markAsRead(messageId: messageId, userId: userId);
  };
});

/// Provider لتحديث حالة الكتابة
final updateTypingStatusProvider = Provider<
    Future<void> Function({
      required String roomId,
      required String userId,
      required bool isTyping,
    })>((ref) {
  final service = ref.read(directMessageServiceProvider);
  return ({
    required String roomId,
    required String userId,
    required bool isTyping,
  }) async {
    await service.updateTypingStatus(
      roomId: roomId,
      userId: userId,
      isTyping: isTyping,
    );
  };
});

/// Provider لتعديل رسالة
final editMessageProvider = Provider<
    Future<bool> Function({
      required String messageId,
      required String userId,
      required String newContent,
    })>((ref) {
  final service = ref.read(directMessageServiceProvider);
  return ({
    required String messageId,
    required String userId,
    required String newContent,
  }) async {
    return service.editMessage(
      messageId: messageId,
      userId: userId,
      newContent: newContent,
    );
  };
});

/// Provider لحذف رسالة
final deleteMessageProvider = Provider<
    Future<bool> Function({
      required String messageId,
      required String userId,
    })>((ref) {
  final service = ref.read(directMessageServiceProvider);
  return ({
    required String messageId,
    required String userId,
  }) async {
    return service.deleteMessage(
      messageId: messageId,
      userId: userId,
    );
  };
});

/// Provider لأرشفة غرفة
final archiveRoomProvider = Provider<
    Future<void> Function({
      required String roomId,
      required bool archive,
    })>((ref) {
  final service = ref.read(directMessageServiceProvider);
  return ({
    required String roomId,
    required bool archive,
  }) async {
    await service.archiveRoom(roomId: roomId, archive: archive);
  };
});

/// Provider لكتم غرفة
final muteRoomProvider = Provider<
    Future<void> Function({
      required String roomId,
      required String userId,
      required bool mute,
    })>((ref) {
  final service = ref.read(directMessageServiceProvider);
  return ({
    required String roomId,
    required String userId,
    required bool mute,
  }) async {
    await service.muteRoom(roomId: roomId, userId: userId, mute: mute);
  };
});
