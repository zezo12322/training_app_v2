import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_message.dart';
import '../core/logging.dart';

/// خدمة ربط الردود (Message Threading)
class MessageThreadingService {
  final FirebaseFirestore _firestore;

  MessageThreadingService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// الرد على رسالة (إنشاء thread)
  Future<ChatMessage?> replyToMessage({
    required String parentMessageId,
    required String chatRoomId,
    required String courseId,
    required String institutionId,
    required String companyId,
    required String authorId,
    required String authorName,
    required String authorRole,
    required String content,
    String? imageUrl,
  }) async {
    try {
      // التحقق من وجود الرسالة الأصلية
      final parentDoc = await _firestore
          .collection('chat_messages')
          .doc(parentMessageId)
          .get();

      if (!parentDoc.exists) {
        logger.w('Parent message not found: $parentMessageId');
        return null;
      }

      // إنشاء الرسالة الجديدة كرد
      final messageId = _generateId();
      final now = DateTime.now();

      final replyMessage = ChatMessage(
        id: messageId,
        chatRoomId: chatRoomId,
        courseId: courseId,
        institutionId: institutionId,
        companyId: companyId,
        authorId: authorId,
        authorName: authorName,
        authorRole: authorRole,
        content: content,
        imageUrl: imageUrl,
        createdAt: now,
        parentMessageId: parentMessageId,
        readBy: [authorId],
      );

      // حفظ الرد
      await _firestore
          .collection('chat_messages')
          .doc(messageId)
          .set(replyMessage.toJson());

      // تحديث عداد الردود في الرسالة الأصلية
      await _updateThreadCount(parentMessageId);

      logger.i('Reply created: $messageId -> $parentMessageId');
      return replyMessage;
    } catch (e, stackTrace) {
      logger.e('Error creating reply', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// تحديث عداد الردود
  Future<void> _updateThreadCount(String parentMessageId) async {
    try {
      final repliesCount = await getThreadCount(parentMessageId);
      
      await _firestore.collection('chat_messages').doc(parentMessageId).update({
        'threadCount': repliesCount,
        'hasThread': repliesCount > 0,
      });
    } catch (e) {
      logger.e('Error updating thread count', error: e);
    }
  }

  /// الحصول على عدد الردود
  Future<int> getThreadCount(String parentMessageId) async {
    try {
      final snapshot = await _firestore
          .collection('chat_messages')
          .where('parentMessageId', isEqualTo: parentMessageId)
          .where('isDeleted', isEqualTo: false)
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e) {
      logger.e('Error getting thread count', error: e);
      return 0;
    }
  }

  /// جلب جميع الردود على رسالة
  Future<List<ChatMessage>> getThreadMessages(String parentMessageId) async {
    try {
      final snapshot = await _firestore
          .collection('chat_messages')
          .where('parentMessageId', isEqualTo: parentMessageId)
          .where('isDeleted', isEqualTo: false)
          .orderBy('createdAt', descending: false)
          .get();

      return snapshot.docs
          .map((doc) => ChatMessage.fromJson(doc.data()))
          .toList();
    } catch (e, stackTrace) {
      logger.e('Error fetching thread messages', error: e, stackTrace: stackTrace);
      return [];
    }
  }

  /// Stream للردود (real-time)
  Stream<List<ChatMessage>> streamThreadMessages(String parentMessageId) {
    return _firestore
        .collection('chat_messages')
        .where('parentMessageId', isEqualTo: parentMessageId)
        .where('isDeleted', isEqualTo: false)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ChatMessage.fromJson(doc.data()))
          .toList();
    });
  }

  /// جلب الرسالة الأصلية (parent)
  Future<ChatMessage?> getParentMessage(String parentMessageId) async {
    try {
      final doc = await _firestore
          .collection('chat_messages')
          .doc(parentMessageId)
          .get();

      if (!doc.exists) return null;

      return ChatMessage.fromJson(doc.data()!);
    } catch (e) {
      logger.e('Error fetching parent message', error: e);
      return null;
    }
  }

  /// حذف رد (يقلل العداد)
  Future<bool> deleteReply(String messageId) async {
    try {
      final doc = await _firestore.collection('chat_messages').doc(messageId).get();
      
      if (!doc.exists) return false;

      final message = ChatMessage.fromJson(doc.data()!);
      
      if (message.parentMessageId == null) {
        logger.w('Message is not a reply: $messageId');
        return false;
      }

      // حذف الرد
      await _firestore.collection('chat_messages').doc(messageId).update({
        'isDeleted': true,
        'deletedAt': FieldValue.serverTimestamp(),
      });

      // تحديث العداد في الرسالة الأصلية
      await _updateThreadCount(message.parentMessageId!);

      logger.i('Reply deleted: $messageId');
      return true;
    } catch (e) {
      logger.e('Error deleting reply', error: e);
      return false;
    }
  }

  /// Stream لأحدث 3 ردود (للعرض في القائمة)
  Stream<List<ChatMessage>> streamRecentReplies(String parentMessageId, {int limit = 3}) {
    return _firestore
        .collection('chat_messages')
        .where('parentMessageId', isEqualTo: parentMessageId)
        .where('isDeleted', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      final messages = snapshot.docs
          .map((doc) => ChatMessage.fromJson(doc.data()))
          .toList();
      // عكس الترتيب ليكون الأقدم أولاً
      return messages.reversed.toList();
    });
  }

  String _generateId() {
    return _firestore.collection('chat_messages').doc().id;
  }
}
