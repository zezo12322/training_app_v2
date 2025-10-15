import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/repositories/wall_post_repository.dart';
import 'package:training_app/models/wall_post.dart';

final wallPostRepositoryProvider = Provider<WallPostRepository>((ref) {
  return WallPostRepository(FirebaseFirestore.instance);
});

final wallPostsStreamProvider = StreamProvider.autoDispose
    .family<List<WallPost>, String>((ref, courseId) {
      return ref.read(wallPostRepositoryProvider).streamPosts(courseId);
    });

// Add post
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
    return ref.read(wallPostRepositoryProvider).addPost(
          courseId: courseId,
          content: content,
          authorId: authorId,
          authorEmail: authorEmail,
          authorName: authorName,
          imageUrl: imageUrl,
          fileUrl: fileUrl,
          imageUrls: imageUrls,
        );
  };
});

// Toggle post reaction
final togglePostReactionProvider = Provider((ref) {
  return ({
    required String postId,
    required String userId,
    required String emoji,
  }) async {
    return ref.read(wallPostRepositoryProvider).toggleReaction(
          postId: postId,
          userId: userId,
          emoji: emoji,
        );
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
