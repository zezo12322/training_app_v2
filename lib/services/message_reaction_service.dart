import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_reaction.dart';
import '../core/logging.dart';

/// خدمة التفاعلات على الرسائل
class MessageReactionService {
  final FirebaseFirestore _firestore;

  MessageReactionService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// إضافة تفاعل
  Future<bool> addReaction({
    required String messageId,
    required String emoji,
    required String userId,
    required String userName,
  }) async {
    try {
      // التحقق من عدم وجود نفس التفاعل مسبقاً
      final existing = await _getReaction(messageId, emoji, userId);
      
      if (existing != null) {
        logger.i('Reaction already exists');
        return true; // Already reacted
      }

      // إضافة التفاعل
      final reaction = MessageReaction(
        emoji: emoji,
        userId: userId,
        userName: userName,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('chat_messages')
          .doc(messageId)
          .collection('reactions')
          .doc('${emoji}_$userId')
          .set(reaction.toJson());

      logger.i('Reaction added: $emoji by $userId on $messageId');
      return true;
    } catch (e) {
      logger.e('Error adding reaction', error: e);
      return false;
    }
  }

  /// إزالة تفاعل
  Future<bool> removeReaction({
    required String messageId,
    required String emoji,
    required String userId,
  }) async {
    try {
      await _firestore
          .collection('chat_messages')
          .doc(messageId)
          .collection('reactions')
          .doc('${emoji}_$userId')
          .delete();

      logger.i('Reaction removed: $emoji by $userId on $messageId');
      return true;
    } catch (e) {
      logger.e('Error removing reaction', error: e);
      return false;
    }
  }

  /// Toggle تفاعل (إضافة أو إزالة)
  Future<bool> toggleReaction({
    required String messageId,
    required String emoji,
    required String userId,
    required String userName,
  }) async {
    try {
      final existing = await _getReaction(messageId, emoji, userId);
      
      if (existing != null) {
        // إزالة التفاعل
        return await removeReaction(
          messageId: messageId,
          emoji: emoji,
          userId: userId,
        );
      } else {
        // إضافة التفاعل
        return await addReaction(
          messageId: messageId,
          emoji: emoji,
          userId: userId,
          userName: userName,
        );
      }
    } catch (e) {
      logger.e('Error toggling reaction', error: e);
      return false;
    }
  }

  /// التحقق من وجود تفاعل محدد
  Future<MessageReaction?> _getReaction(
    String messageId,
    String emoji,
    String userId,
  ) async {
    try {
      final doc = await _firestore
          .collection('chat_messages')
          .doc(messageId)
          .collection('reactions')
          .doc('${emoji}_$userId')
          .get();

      if (!doc.exists) return null;

      return MessageReaction.fromJson(doc.data()!);
    } catch (e) {
      logger.e('Error getting reaction', error: e);
      return null;
    }
  }

  /// جلب جميع التفاعلات على رسالة
  Future<List<MessageReaction>> getReactions(String messageId) async {
    try {
      final snapshot = await _firestore
          .collection('chat_messages')
          .doc(messageId)
          .collection('reactions')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => MessageReaction.fromJson(doc.data()))
          .toList();
    } catch (e) {
      logger.e('Error getting reactions', error: e);
      return [];
    }
  }

  /// Stream للتفاعلات (real-time)
  Stream<List<MessageReaction>> streamReactions(String messageId) {
    return _firestore
        .collection('chat_messages')
        .doc(messageId)
        .collection('reactions')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MessageReaction.fromJson(doc.data()))
          .toList();
    });
  }

  /// بناء ملخص التفاعلات
  Future<ReactionSummary> getReactionSummary({
    required String messageId,
    required String currentUserId,
  }) async {
    try {
      final reactions = await getReactions(messageId);
      
      final counts = <String, int>{};
      final userNames = <String, List<String>>{};
      final currentUserReactions = <String, bool>{};

      for (final reaction in reactions) {
        // Count
        counts[reaction.emoji] = (counts[reaction.emoji] ?? 0) + 1;

        // User names
        if (userNames[reaction.emoji] == null) {
          userNames[reaction.emoji] = [];
        }
        userNames[reaction.emoji]!.add(reaction.userName);

        // Current user
        if (reaction.userId == currentUserId) {
          currentUserReactions[reaction.emoji] = true;
        }
      }

      return ReactionSummary(
        counts: counts,
        userNames: userNames,
        currentUserReactions: currentUserReactions,
        totalCount: reactions.length,
      );
    } catch (e) {
      logger.e('Error getting reaction summary', error: e);
      return const ReactionSummary();
    }
  }

  /// Stream لملخص التفاعلات (real-time)
  Stream<ReactionSummary> streamReactionSummary({
    required String messageId,
    required String currentUserId,
  }) {
    return streamReactions(messageId).map((reactions) {
      final counts = <String, int>{};
      final userNames = <String, List<String>>{};
      final currentUserReactions = <String, bool>{};

      for (final reaction in reactions) {
        counts[reaction.emoji] = (counts[reaction.emoji] ?? 0) + 1;

        if (userNames[reaction.emoji] == null) {
          userNames[reaction.emoji] = [];
        }
        userNames[reaction.emoji]!.add(reaction.userName);

        if (reaction.userId == currentUserId) {
          currentUserReactions[reaction.emoji] = true;
        }
      }

      return ReactionSummary(
        counts: counts,
        userNames: userNames,
        currentUserReactions: currentUserReactions,
        totalCount: reactions.length,
      );
    });
  }

  /// حذف جميع التفاعلات على رسالة (عند حذف الرسالة)
  Future<void> deleteAllReactions(String messageId) async {
    try {
      final snapshot = await _firestore
          .collection('chat_messages')
          .doc(messageId)
          .collection('reactions')
          .get();

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      logger.i('All reactions deleted for message: $messageId');
    } catch (e) {
      logger.e('Error deleting all reactions', error: e);
    }
  }
}
