import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../models/wall_comment.dart';
import '../repositories/wall_comment_repository.dart';
import '../models/gamification/points_transaction.dart';
import 'gamification/gamification_providers.dart';

// Repository Provider
final wallCommentRepositoryProvider = Provider<WallCommentRepository>((ref) {
  return WallCommentRepository(FirebaseFirestore.instance);
});

// Stream comments for a post
final wallCommentsStreamProvider = StreamProvider.autoDispose
    .family<List<WallComment>, String>((ref, postId) {
  return ref.read(wallCommentRepositoryProvider).streamComments(postId);
});

// Add comment provider (with gamification)
final addWallCommentProvider = Provider((ref) {
  return ({
    required String postId,
    required String courseId,
    required String authorId,
    required String content,
    String? authorEmail,
    String? authorName,
    String? parentCommentId,
  }) async {
    // Create the comment first
    final result = await ref.read(wallCommentRepositoryProvider).addComment(
          postId: postId,
          courseId: courseId,
          authorId: authorId,
          content: content,
          authorEmail: authorEmail,
          authorName: authorName,
          parentCommentId: parentCommentId,
        );
    
    // Award points for commenting (don't block on failure)
    try {
      final gamificationService = ref.read(gamificationServiceProvider);
      
      await gamificationService.awardPoints(
        userId: authorId,
        courseId: courseId,
        activityType: ActivityType.commenting,
        activityName: 'تعليق على منشور',
        metadata: {
          'postId': postId,
          'isReply': parentCommentId != null,
        },
      );
    } catch (e) {
      debugPrint('⚠️ Error awarding points for comment: $e');
    }
    
    return result;
  };
});

// Update comment provider
final updateWallCommentProvider = Provider((ref) {
  return ({
    required String postId,
    required String commentId,
    required String content,
  }) async {
    return ref.read(wallCommentRepositoryProvider).updateComment(
          postId: postId,
          commentId: commentId,
          content: content,
        );
  };
});

// Delete comment provider
final deleteWallCommentProvider = Provider((ref) {
  return ({
    required String postId,
    required String commentId,
    String? parentCommentId,
  }) async {
    return ref.read(wallCommentRepositoryProvider).deleteComment(
          postId: postId,
          commentId: commentId,
          parentCommentId: parentCommentId,
        );
  };
});

// Toggle comment reaction provider (with gamification for helpful comments)
final toggleCommentReactionProvider = Provider((ref) {
  return ({
    required String postId,
    required String commentId,
    required String userId,
    required String emoji,
    required String courseId, // Added for gamification
    String? commentAuthorId, // Added for gamification
  }) async {
    // Toggle the reaction first
    final result = await ref.read(wallCommentRepositoryProvider).toggleCommentReaction(
          postId: postId,
          commentId: commentId,
          userId: userId,
          emoji: emoji,
        );
    
    // Award "helpful peer" points for 👍 on comment (don't block on failure)
    // Only award if it's not a self-reaction and it's a thumbs up
    if (commentAuthorId != null && commentAuthorId != userId && emoji == '👍') {
      try {
        final gamificationService = ref.read(gamificationServiceProvider);
        
        await gamificationService.awardPoints(
          userId: commentAuthorId,
          courseId: courseId,
          activityType: ActivityType.helpfulComment,
          activityName: 'تعليق مفيد',
          metadata: {
            'postId': postId,
            'commentId': commentId,
            'fromUserId': userId,
          },
        );
      } catch (e) {
        debugPrint('⚠️ Error awarding points for helpful comment: $e');
      }
    }
    
    return result;
  };
});
