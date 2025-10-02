import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/core/result.dart';
import 'package:training_app/models/wall_post.dart';
import 'package:training_app/core/logging.dart';

class WallPostRepository {
  final FirebaseFirestore _firestore;
  WallPostRepository(this._firestore);

  Stream<List<WallPost>> streamPosts(String courseId) {
    return _firestore
        .collection('course_wall')
        .where('courseId', isEqualTo: courseId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => WallPost.fromJson({...d.data(), 'id': d.id})).toList());
  }

  Future<Result<void>> addPost({
    required String courseId,
    required String content,
    required String authorId,
    required String authorEmail,
  }) async {
    try {
      await _firestore.collection('course_wall').add({
        'courseId': courseId,
        'content': content,
        'authorId': authorId,
        'authorEmail': authorEmail,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return const Success(null);
    } on FirebaseException catch (e, st) {
      logger.e('Failed to add wall post', error: e, stackTrace: st);
      return FailureResult(UnknownFailure(e.message ?? 'خطأ غير معروف', cause: e, stack: st));
    } catch (e, st) {
      logger.e('Unexpected error addPost', error: e, stackTrace: st);
      return FailureResult(UnknownFailure(e.toString(), cause: e, stack: st));
    }
  }
}
