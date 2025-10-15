import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/wall_comment.dart';
import '../repositories/wall_comment_repository.dart';

// Repository Provider
final wallCommentRepositoryProvider = Provider<WallCommentRepository>((ref) {
  return WallCommentRepository(FirebaseFirestore.instance);
});

// Stream comments for a post
final wallCommentsStreamProvider = StreamProvider.autoDispose
    .family<List<WallComment>, String>((ref, postId) {
  return ref.read(wallCommentRepositoryProvider).streamComments(postId);
});

// Add comment provider
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
    return ref.read(wallCommentRepositoryProvider).addComment(
          postId: postId,
          courseId: courseId,
          authorId: authorId,
          content: content,
          authorEmail: authorEmail,
          authorName: authorName,
          parentCommentId: parentCommentId,
        );
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

// Toggle comment reaction provider
final toggleCommentReactionProvider = Provider((ref) {
  return ({
    required String postId,
    required String commentId,
    required String userId,
    required String emoji,
  }) async {
    return ref.read(wallCommentRepositoryProvider).toggleCommentReaction(
          postId: postId,
          commentId: commentId,
          userId: userId,
          emoji: emoji,
        );
  };
});
