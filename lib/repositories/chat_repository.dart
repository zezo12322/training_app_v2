import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/logging.dart';
import '../models/chat_message.dart';
import '../models/chat_room.dart';

/// Provider for ChatRepository
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(FirebaseFirestore.instance);
});

/// Repository for managing chat operations
class ChatRepository {
  final FirebaseFirestore _firestore;

  ChatRepository(this._firestore);

  // Collections
  CollectionReference<Map<String, dynamic>> get _chatRoomsCollection =>
      _firestore.collection('chat_rooms');

  CollectionReference<Map<String, dynamic>> _messagesCollection(
          String chatRoomId) =>
      _chatRoomsCollection.doc(chatRoomId).collection('messages');

  // ==================== Chat Rooms ====================

  /// Get or create a course chat room
  Future<ChatRoom> getOrCreateCourseChatRoom({
    required String courseId,
    required String courseName,
    required String institutionId,
    required String companyId,
    required List<String> participantIds,
  }) async {
    try {
      // Check if room already exists
      final querySnapshot = await _chatRoomsCollection
          .where('type', isEqualTo: ChatRoomType.course.name)
          .where('courseId', isEqualTo: courseId)
          .where('institutionId', isEqualTo: institutionId)
          .where('companyId', isEqualTo: companyId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Room exists, update participants if needed
        final roomDoc = querySnapshot.docs.first;
        final room = ChatRoom.fromJson(roomDoc.data());

        // Add new participants
        final updatedParticipants =
            {...room.participantIds, ...participantIds}.toList();

        if (updatedParticipants.length != room.participantIds.length) {
          await roomDoc.reference.update({
            'participantIds': updatedParticipants,
            'updatedAt': FieldValue.serverTimestamp(),
          });
        }

        return room.copyWith(participantIds: updatedParticipants);
      }

      // Create new room
      final roomRef = _chatRoomsCollection.doc();
      final now = DateTime.now();

      final newRoom = ChatRoom(
        id: roomRef.id,
        type: ChatRoomType.course,
        courseId: courseId,
        courseName: courseName,
        institutionId: institutionId,
        companyId: companyId,
        participantIds: participantIds,
        createdAt: now,
      );

      await roomRef.set(newRoom.toJson());
      logger.i('Created course chat room: ${roomRef.id} for course: $courseId');

      return newRoom;
    } catch (e, stack) {
      logger.e('Error getting/creating course chat room', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Stream chat room by ID
  Stream<ChatRoom?> streamChatRoom(String roomId) {
    return _chatRoomsCollection.doc(roomId).snapshots().map((snapshot) {
      if (!snapshot.exists) return null;
      return ChatRoom.fromJson(snapshot.data()!);
    });
  }

  /// Stream user's chat rooms
  Stream<List<ChatRoom>> streamUserChatRooms({
    required String userId,
    required String institutionId,
    required String companyId,
  }) {
    return _chatRoomsCollection
        .where('institutionId', isEqualTo: institutionId)
        .where('companyId', isEqualTo: companyId)
        .where('participantIds', arrayContains: userId)
        .where('isActive', isEqualTo: true)
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatRoom.fromJson(doc.data()))
            .toList());
  }

  // ==================== Messages ====================

  /// Send a new message
  Future<ChatMessage> sendMessage(CreateChatMessageDto dto) async {
    try {
      final messageRef = _messagesCollection(dto.chatRoomId).doc();
      final now = DateTime.now();

      final message = ChatMessage(
        id: messageRef.id,
        chatRoomId: dto.chatRoomId,
        courseId: dto.courseId,
        institutionId: dto.institutionId,
        companyId: dto.companyId,
        authorId: dto.authorId,
        authorName: dto.authorName,
        authorRole: dto.authorRole,
        content: dto.content,
        imageUrl: dto.imageUrl,
        createdAt: now,
      );

      // Write message
      await messageRef.set(message.toJson());

      // Update chat room last message info
      await _chatRoomsCollection.doc(dto.chatRoomId).update({
        'lastMessageContent': dto.content,
        'lastMessageAuthor': dto.authorName,
        'lastMessageAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      logger.i('Message sent: ${message.id} in room: ${dto.chatRoomId}');
      return message;
    } catch (e, stack) {
      logger.e('Error sending message', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Stream messages for a chat room
  Stream<List<ChatMessage>> streamMessages({
    required String chatRoomId,
    int limit = 50,
  }) {
    return _messagesCollection(chatRoomId)
        .where('isDeleted', isEqualTo: false)
        .where('isModerated', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessage.fromJson(doc.data()))
            .toList()
            .reversed // Show oldest first
            .toList());
  }

  /// Mark message as read
  Future<void> markMessageAsRead({
    required String chatRoomId,
    required String messageId,
    required String userId,
  }) async {
    try {
      await _messagesCollection(chatRoomId).doc(messageId).update({
        'readBy': FieldValue.arrayUnion([userId]),
      });
    } catch (e, stack) {
      logger.e('Error marking message as read', error: e, stackTrace: stack);
    }
  }

  /// Mark all messages in room as read
  Future<void> markAllMessagesAsRead({
    required String chatRoomId,
    required String userId,
  }) async {
    try {
      // Get unread messages
      final unreadMessages = await _messagesCollection(chatRoomId)
          .where('readBy', whereNotIn: [
            [userId]
          ])
          .get();

      // Batch update
      final batch = _firestore.batch();
      for (final doc in unreadMessages.docs) {
        batch.update(doc.reference, {
          'readBy': FieldValue.arrayUnion([userId]),
        });
      }

      // Reset unread count in room
      batch.update(_chatRoomsCollection.doc(chatRoomId), {
        'unreadCounts.$userId': 0,
      });

      await batch.commit();
      logger.i('Marked all messages as read in room: $chatRoomId');
    } catch (e, stack) {
      logger.e('Error marking all messages as read', error: e, stackTrace: stack);
    }
  }

  /// Get unread message count for a room
  Future<int> getUnreadCount({
    required String chatRoomId,
    required String userId,
  }) async {
    try {
      final snapshot = await _messagesCollection(chatRoomId)
          .where('authorId', isNotEqualTo: userId) // Not my own messages
          .get();

      return snapshot.docs
          .map((doc) => ChatMessage.fromJson(doc.data()))
          .where((msg) => !msg.isReadBy(userId))
          .length;
    } catch (e, stack) {
      logger.e('Error getting unread count', error: e, stackTrace: stack);
      return 0;
    }
  }

  /// Edit a message
  Future<void> editMessage({
    required String chatRoomId,
    required String messageId,
    required String newContent,
  }) async {
    try {
      await _messagesCollection(chatRoomId).doc(messageId).update({
        'content': newContent,
        'isEdited': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      logger.i('Message edited: $messageId');
    } catch (e, stack) {
      logger.e('Error editing message', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Delete a message (soft delete)
  Future<void> deleteMessage({
    required String chatRoomId,
    required String messageId,
  }) async {
    try {
      await _messagesCollection(chatRoomId).doc(messageId).update({
        'isDeleted': true,
        'deletedAt': FieldValue.serverTimestamp(),
      });

      logger.i('Message deleted: $messageId');
    } catch (e, stack) {
      logger.e('Error deleting message', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Flag a message for moderation
  Future<void> flagMessage({
    required String chatRoomId,
    required String messageId,
  }) async {
    try {
      await _messagesCollection(chatRoomId).doc(messageId).update({
        'isFlagged': true,
      });

      logger.i('Message flagged: $messageId');
    } catch (e, stack) {
      logger.e('Error flagging message', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
