import 'package:cloud_firestore/cloud_firestore.dart';

class Evaluation {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // دالة لإضافة تقييم جديد
  Future<void> addEvaluation(String courseId, String traineeId, int score, String feedback, {required String trainerId}) async {
    try {
      await _firestore.collection('evaluations').add({
        'courseId': courseId,
        'traineeId': traineeId,
        'trainerId': trainerId, // مهم لمعرفة من قام بالتقييم
        'score': score,
        'feedback': feedback,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add evaluation: $e');
    }
  }

  // دالة لجلب كل التقييمات الخاصة بكورس معين
  Future<List<DocumentSnapshot>> getEvaluations(String courseId) async {
    try {
      final querySnapshot = await _firestore
          .collection('evaluations')
          .where('courseId', isEqualTo: courseId)
          .orderBy('createdAt', descending: true) // ترتيبها حسب الأحدث
          .get();

      return querySnapshot.docs;
    } catch (e) {
      throw Exception('Failed to fetch evaluations: $e');
    }
  }
}