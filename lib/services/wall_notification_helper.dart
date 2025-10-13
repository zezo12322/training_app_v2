import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/fcm_notification_service.dart';
import '../core/logging.dart';

class WallNotificationHelper {
  final FcmNotificationService _fcmService;
  final FirebaseFirestore _firestore;

  WallNotificationHelper(this._fcmService, this._firestore);

  /// Send notification for new post
  Future<void> notifyNewPost({
    required String courseId,
    required String postId,
    required String authorName,
    required String content,
  }) async {
    try {
      // Get course trainees
      final courseDoc = await _firestore.collection('courses').doc(courseId).get();
      if (!courseDoc.exists) return;

      final trainees = (courseDoc.data()?['trainees'] as List?)?.cast<String>() ?? [];
      if (trainees.isEmpty) return;

      // Prepare notification
      final title = 'منشور جديد من $authorName';
      final body = content.length > 100 
          ? '${content.substring(0, 100)}...' 
          : content;

      await _fcmService.sendNotification(
        userIds: trainees,
        title: title,
        body: body,
        data: {
          'type': 'new_post',
          'courseId': courseId,
          'postId': postId,
        },
      );

      logger.i('[WallNotif] Sent new post notification to ${trainees.length} users');
    } catch (e, st) {
      logger.e('[WallNotif] Error sending new post notification', error: e, stackTrace: st);
    }
  }

  /// Send notification for new poll
  Future<void> notifyNewPoll({
    required String courseId,
    required String postId,
    required String authorName,
    required String question,
  }) async {
    try {
      final courseDoc = await _firestore.collection('courses').doc(courseId).get();
      if (!courseDoc.exists) return;

      final trainees = (courseDoc.data()?['trainees'] as List?)?.cast<String>() ?? [];
      if (trainees.isEmpty) return;

      final title = 'استطلاع جديد من $authorName';
      final body = question;

      await _fcmService.sendNotification(
        userIds: trainees,
        title: title,
        body: body,
        data: {
          'type': 'new_poll',
          'courseId': courseId,
          'postId': postId,
        },
      );

      logger.i('[WallNotif] Sent new poll notification to ${trainees.length} users');
    } catch (e, st) {
      logger.e('[WallNotif] Error sending new poll notification', error: e, stackTrace: st);
    }
  }

  /// Send notification for new comment
  Future<void> notifyNewComment({
    required String courseId,
    required String postId,
    required String postAuthorId,
    required String commenterName,
    required String content,
  }) async {
    try {
      // Notify post author only
      if (postAuthorId.isEmpty) return;

      final title = 'تعليق جديد من $commenterName';
      final body = content.length > 100 
          ? '${content.substring(0, 100)}...' 
          : content;

      await _fcmService.sendNotification(
        userIds: [postAuthorId],
        title: title,
        body: body,
        data: {
          'type': 'new_comment',
          'courseId': courseId,
          'postId': postId,
        },
      );

      logger.i('[WallNotif] Sent new comment notification to post author');
    } catch (e, st) {
      logger.e('[WallNotif] Error sending new comment notification', error: e, stackTrace: st);
    }
  }

  /// Send notification for new reply
  Future<void> notifyNewReply({
    required String courseId,
    required String postId,
    required String parentCommentAuthorId,
    required String replierName,
    required String content,
  }) async {
    try {
      // Notify parent comment author
      if (parentCommentAuthorId.isEmpty) return;

      final title = 'رد جديد من $replierName';
      final body = content.length > 100 
          ? '${content.substring(0, 100)}...' 
          : content;

      await _fcmService.sendNotification(
        userIds: [parentCommentAuthorId],
        title: title,
        body: body,
        data: {
          'type': 'new_reply',
          'courseId': courseId,
          'postId': postId,
        },
      );

      logger.i('[WallNotif] Sent new reply notification to comment author');
    } catch (e, st) {
      logger.e('[WallNotif] Error sending new reply notification', error: e, stackTrace: st);
    }
  }

  /// Send notification for new reaction on post
  Future<void> notifyPostReaction({
    required String courseId,
    required String postId,
    required String postAuthorId,
    required String reactorName,
    required String emoji,
  }) async {
    try {
      if (postAuthorId.isEmpty) return;

      final title = 'تفاعل جديد من $reactorName';
      final body = 'تفاعل بـ $emoji على منشورك';

      await _fcmService.sendNotification(
        userIds: [postAuthorId],
        title: title,
        body: body,
        data: {
          'type': 'post_reaction',
          'courseId': courseId,
          'postId': postId,
        },
      );

      logger.i('[WallNotif] Sent post reaction notification');
    } catch (e, st) {
      logger.e('[WallNotif] Error sending post reaction notification', error: e, stackTrace: st);
    }
  }

  /// Send notification for new reaction on comment
  Future<void> notifyCommentReaction({
    required String courseId,
    required String postId,
    required String commentAuthorId,
    required String reactorName,
    required String emoji,
  }) async {
    try {
      if (commentAuthorId.isEmpty) return;

      final title = 'تفاعل جديد من $reactorName';
      final body = 'تفاعل بـ $emoji على تعليقك';

      await _fcmService.sendNotification(
        userIds: [commentAuthorId],
        title: title,
        body: body,
        data: {
          'type': 'comment_reaction',
          'courseId': courseId,
          'postId': postId,
        },
      );

      logger.i('[WallNotif] Sent comment reaction notification');
    } catch (e, st) {
      logger.e('[WallNotif] Error sending comment reaction notification', error: e, stackTrace: st);
    }
  }

  /// Send notification for poll vote
  Future<void> notifyPollVote({
    required String courseId,
    required String postId,
    required String pollCreatorId,
    required String voterName,
  }) async {
    try {
      if (pollCreatorId.isEmpty) return;

      final title = 'صوت جديد في استطلاعك';
      final body = '$voterName صوّت في استطلاعك';

      await _fcmService.sendNotification(
        userIds: [pollCreatorId],
        title: title,
        body: body,
        data: {
          'type': 'poll_vote',
          'courseId': courseId,
          'postId': postId,
        },
      );

      logger.i('[WallNotif] Sent poll vote notification');
    } catch (e, st) {
      logger.e('[WallNotif] Error sending poll vote notification', error: e, stackTrace: st);
    }
  }
}
