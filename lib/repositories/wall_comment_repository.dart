import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/wall_comment.dart';

class WallCommentRepository {
  final FirebaseFirestore _firestore;

  WallCommentRepository(this._firestore);

  /// Stream comments for a specific post
  Stream<List<WallComment>> streamComments(String postId) {
    return _firestore
        .collection('course_wall')
        .doc(postId)
        .collection('comments')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => WallComment.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  /// Add a comment to a post
  Future<void> addComment({
    required String postId,
    required String courseId,
    required String authorId,
    required String content,
    String? authorEmail,
    String? authorName,
    String? parentCommentId,
  }) async {
    final batch = _firestore.batch();

    // Create comment
    final commentRef = _firestore
        .collection('course_wall')
        .doc(postId)
        .collection('comments')
        .doc();

    final now = Timestamp.now();
    
    batch.set(commentRef, {
      'postId': postId,
      'courseId': courseId,
      'authorId': authorId,
      'content': content,
      'authorEmail': authorEmail,
      'authorName': authorName,
      'parentCommentId': parentCommentId,
      'replyCount': 0,
      'reactions': {},
      'reactionUsers': {},
      'isEdited': false,
      'createdAt': now,
      'updatedAt': now,
    });

    // Increment comment count on post
    final postRef = _firestore.collection('course_wall').doc(postId);
    batch.update(postRef, {
      'commentCount': FieldValue.increment(1),
    });

    // If reply, increment reply count on parent comment
    if (parentCommentId != null) {
      final parentRef = _firestore
          .collection('course_wall')
          .doc(postId)
          .collection('comments')
          .doc(parentCommentId);
      batch.update(parentRef, {
        'replyCount': FieldValue.increment(1),
      });
    }

    await batch.commit();
  }

  /// Update a comment
  Future<void> updateComment({
    required String postId,
    required String commentId,
    required String content,
  }) async {
    await _firestore
        .collection('course_wall')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .update({
      'content': content,
      'isEdited': true,
      'updatedAt': Timestamp.now(),
    });
  }

  /// Delete a comment
  Future<void> deleteComment({
    required String postId,
    required String commentId,
    String? parentCommentId,
  }) async {
    final batch = _firestore.batch();

    // Delete comment
    final commentRef = _firestore
        .collection('course_wall')
        .doc(postId)
        .collection('comments')
        .doc(commentId);
    batch.delete(commentRef);

    // Decrement comment count on post
    final postRef = _firestore.collection('course_wall').doc(postId);
    batch.update(postRef, {
      'commentCount': FieldValue.increment(-1),
    });

    // If reply, decrement reply count on parent comment
    if (parentCommentId != null) {
      final parentRef = _firestore
          .collection('course_wall')
          .doc(postId)
          .collection('comments')
          .doc(parentCommentId);
      batch.update(parentRef, {
        'replyCount': FieldValue.increment(-1),
      });
    }

    await batch.commit();
  }

  /// Toggle reaction on a comment
  Future<void> toggleCommentReaction({
    required String postId,
    required String commentId,
    required String userId,
    required String emoji,
  }) async {
    final commentRef = _firestore
        .collection('course_wall')
        .doc(postId)
        .collection('comments')
        .doc(commentId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(commentRef);
      if (!snapshot.exists) return;

      final data = snapshot.data()!;
      final reactions = Map<String, int>.from(data['reactions'] ?? {});
      final reactionUsers =
          Map<String, List<dynamic>>.from(data['reactionUsers'] ?? {});

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

      transaction.update(commentRef, {
        'reactions': reactions,
        'reactionUsers': reactionUsers,
      });
    });
  }
}
