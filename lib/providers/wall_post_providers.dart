import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:training_app/repositories/wall_post_repository.dart';
import 'package:training_app/models/wall_post.dart';
import 'package:training_app/models/gamification/points_transaction.dart';
import 'package:training_app/providers/gamification/gamification_providers.dart';

final wallPostRepositoryProvider = Provider<WallPostRepository>((ref) {
  return WallPostRepository(FirebaseFirestore.instance);
});

final wallPostsStreamProvider = StreamProvider.autoDispose
    .family<List<WallPost>, String>((ref, courseId) {
      return ref.read(wallPostRepositoryProvider).streamPosts(courseId);
    });

// Add post (with gamification)
final addPostProvider = Provider((ref) {
  return ({
    required String courseId,
    required String content,
    required String authorId,
    required String authorEmail,
    String? authorName,
    String? imageUrl,
    String? fileUrl,
    List<String>? imageUrls,
  }) async {
    // Create the post first
    final result = await ref.read(wallPostRepositoryProvider).addPost(
          courseId: courseId,
          content: content,
          authorId: authorId,
          authorEmail: authorEmail,
          authorName: authorName,
          imageUrl: imageUrl,
          fileUrl: fileUrl,
          imageUrls: imageUrls,
        );
    
    // Award points for creating post (don't block on failure)
    try {
      final gamificationService = ref.read(gamificationServiceProvider);
      final contentPreview = content.length > 30 
          ? '${content.substring(0, 30)}...' 
          : content;
      
      await gamificationService.awardPoints(
        userId: authorId,
        courseId: courseId,
        activityType: ActivityType.creatingPost,
        activityName: 'نشر منشور: $contentPreview',
        metadata: {
          'courseId': courseId,
          'contentLength': content.length,
        },
      );
    } catch (e) {
      debugPrint('⚠️ Error awarding points for wall post: $e');
      // Don't block post creation if points fail
    }
    
    return result;
  };
});

// Toggle post reaction (with gamification)
final togglePostReactionProvider = Provider((ref) {
  return ({
    required String postId,
    required String userId,
    required String emoji,
    required String courseId, // Added for gamification
    String? authorId, // Added for gamification
  }) async {
    // Toggle the reaction first
    final result = await ref.read(wallPostRepositoryProvider).toggleReaction(
          postId: postId,
          userId: userId,
          emoji: emoji,
        );
    
    // Award points to post author for receiving reaction (don't block on failure)
    // Only award if it's not a self-reaction
    if (authorId != null && authorId != userId) {
      try {
        final gamificationService = ref.read(gamificationServiceProvider);
        
        // Check if this is adding a reaction (not removing)
        // We'll award points optimistically - if removed, points won't be deducted
        await gamificationService.awardPoints(
          userId: authorId,
          courseId: courseId,
          activityType: ActivityType.receivingReaction,
          activityName: 'تلقى تفاعل $emoji',
          metadata: {
            'postId': postId,
            'reactionType': emoji,
            'fromUserId': userId,
          },
        );
      } catch (e) {
        debugPrint('⚠️ Error awarding points for reaction: $e');
      }
    }
    
    return result;
  };
});

// Update post
final updatePostProvider = Provider((ref) {
  return ({
    required String postId,
    required String content,
    String? imageUrl,
    String? fileUrl,
  }) async {
    return ref.read(wallPostRepositoryProvider).updatePost(
          postId: postId,
          content: content,
          imageUrl: imageUrl,
          fileUrl: fileUrl,
        );
  };
});

// Toggle pin
final togglePinProvider = Provider((ref) {
  return (String postId, bool isPinned) async {
    return ref.read(wallPostRepositoryProvider).togglePin(postId, isPinned);
  };
});

// Toggle archive
final toggleArchiveProvider = Provider((ref) {
  return (String postId, bool isArchived) async {
    return ref.read(wallPostRepositoryProvider).toggleArchive(postId, isArchived);
  };
});

// Delete post
final deletePostProvider = Provider((ref) {
  return (String postId) async {
    return ref.read(wallPostRepositoryProvider).deletePost(postId);
  };
});
