import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/core/result.dart';
import 'package:training_app/models/wall_post.dart';
import 'package:training_app/core/logging.dart';
import 'package:training_app/core/bootstrap.dart';

class WallPostRepository {
  final FirebaseFirestore _firestore;
  WallPostRepository(this._firestore);

  /// Stream all posts for a course (pinned first, then by date)
  Stream<List<WallPost>> streamPosts(String courseId, {bool includeArchived = false}) {
    var query = _firestore
        .collection('course_wall')
        .where('courseId', isEqualTo: courseId);
    
    if (!includeArchived) {
      query = query.where('isArchived', isEqualTo: false);
    }
    
    return query
        .orderBy('isPinned', descending: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((d) => WallPost.fromJson({...d.data(), 'id': d.id}))
              .toList(),
        );
  }

  /// Stream posts with pagination (limit and startAfter)
  Stream<List<WallPost>> streamPostsPaginated(
    String courseId, {
    bool includeArchived = false,
    int limit = 20,
    DocumentSnapshot? startAfterDoc,
  }) {
    var query = _firestore
        .collection('course_wall')
        .where('courseId', isEqualTo: courseId);
    
    if (!includeArchived) {
      query = query.where('isArchived', isEqualTo: false);
    }
    
    query = query
        .orderBy('isPinned', descending: true)
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (startAfterDoc != null) {
      query = query.startAfterDocument(startAfterDoc);
    }
    
    return query.snapshots().map(
          (snap) => snap.docs
              .map((d) => WallPost.fromJson({...d.data(), 'id': d.id}))
              .toList(),
        );
  }

  Future<Result<void>> addPost({
    required String courseId,
    required String content,
    required String authorId,
    required String authorEmail,
    String? authorName,
    String? imageUrl,
    String? fileUrl,
    List<String>? imageUrls,
    Map<String, dynamic>? poll,
  }) async {
    try {
      await traceAsync(
        'wall.addPost',
        () => _firestore.collection('course_wall').add({
          'courseId': courseId,
          'content': content,
          'authorId': authorId,
          'authorEmail': authorEmail,
          'authorName': authorName,
          'imageUrl': imageUrl,
          'fileUrl': fileUrl,
          'imageUrls': imageUrls ?? [],
          'poll': poll,
          'isPinned': false,
          'isArchived': false,
          'isEdited': false,
          'reactions': {},
          'reactionUsers': {},
          'commentCount': 0,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        }),
      );
      return const Success(null);
    } on FirebaseException catch (e, st) {
      logger.e('Failed to add wall post', error: e, stackTrace: st);
      return FailureResult(
        UnknownFailure(e.message ?? 'خطأ غير معروف', cause: e, stack: st),
      );
    } catch (e, st) {
      logger.e('Unexpected error addPost', error: e, stackTrace: st);
      return FailureResult(UnknownFailure(e.toString(), cause: e, stack: st));
    }
  }

  /// Update post content
  Future<Result<void>> updatePost({
    required String postId,
    required String content,
    String? imageUrl,
    String? fileUrl,
  }) async {
    try {
      await _firestore.collection('course_wall').doc(postId).update({
        'content': content,
        'imageUrl': imageUrl,
        'fileUrl': fileUrl,
        'isEdited': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return const Success(null);
    } catch (e, st) {
      logger.e('Failed to update post', error: e, stackTrace: st);
      return FailureResult(UnknownFailure(e.toString(), cause: e, stack: st));
    }
  }

  /// Toggle pin status (trainers only)
  Future<Result<void>> togglePin(String postId, bool isPinned) async {
    try {
      await _firestore.collection('course_wall').doc(postId).update({
        'isPinned': isPinned,
        'pinnedAt': isPinned ? FieldValue.serverTimestamp() : null,
      });
      return const Success(null);
    } catch (e, st) {
      logger.e('Failed to toggle pin', error: e, stackTrace: st);
      return FailureResult(UnknownFailure(e.toString(), cause: e, stack: st));
    }
  }

  /// Toggle archive status
  Future<Result<void>> toggleArchive(String postId, bool isArchived) async {
    try {
      await _firestore.collection('course_wall').doc(postId).update({
        'isArchived': isArchived,
      });
      return const Success(null);
    } catch (e, st) {
      logger.e('Failed to toggle archive', error: e, stackTrace: st);
      return FailureResult(UnknownFailure(e.toString(), cause: e, stack: st));
    }
  }

  /// Delete a post
  Future<Result<void>> deletePost(String postId) async {
    try {
      await _firestore.collection('course_wall').doc(postId).delete();
      return const Success(null);
    } catch (e, st) {
      logger.e('Failed to delete post', error: e, stackTrace: st);
      return FailureResult(UnknownFailure(e.toString(), cause: e, stack: st));
    }
  }

  /// Toggle reaction on a post
  Future<Result<void>> toggleReaction({
    required String postId,
    required String userId,
    required String emoji,
  }) async {
    try {
      await _firestore.runTransaction((transaction) async {
        final postRef = _firestore.collection('course_wall').doc(postId);
        final snapshot = await transaction.get(postRef);
        
        if (!snapshot.exists) {
          throw Exception('Post not found');
        }

        final data = snapshot.data()!;
        final reactions = Map<String, int>.from(data['reactions'] ?? {});
        final reactionUsers = Map<String, List<dynamic>>.from(data['reactionUsers'] ?? {});

        // First, remove any existing reaction from this user
        for (final existingEmoji in reactionUsers.keys.toList()) {
          final userList = List<String>.from(reactionUsers[existingEmoji] ?? []);
          if (userList.contains(userId)) {
            userList.remove(userId);
            reactions[existingEmoji] = (reactions[existingEmoji] ?? 1) - 1;
            
            if (reactions[existingEmoji]! <= 0) {
              reactions.remove(existingEmoji);
              reactionUsers.remove(existingEmoji);
            } else {
              reactionUsers[existingEmoji] = userList;
            }
          }
        }

        // Now check if we should add the new reaction or just remove the old one
        final currentUserList = List<String>.from(reactionUsers[emoji] ?? []);
        
        if (!currentUserList.contains(userId)) {
          // Add the new reaction
          currentUserList.add(userId);
          reactions[emoji] = (reactions[emoji] ?? 0) + 1;
          reactionUsers[emoji] = currentUserList;
        }
        // If user clicked the same emoji they already had (after we removed it above),
        // we don't add it back = toggle off behavior

        transaction.update(postRef, {
          'reactions': reactions,
          'reactionUsers': reactionUsers,
        });
      });
      return const Success(null);
    } catch (e, st) {
      logger.e('Failed to toggle reaction', error: e, stackTrace: st);
      return FailureResult(UnknownFailure(e.toString(), cause: e, stack: st));
    }
  }
}

