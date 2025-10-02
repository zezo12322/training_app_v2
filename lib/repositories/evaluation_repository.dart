import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:training_app/core/result.dart';
import 'package:training_app/models/evaluation.dart';
import 'package:training_app/core/logging.dart';

class EvaluationRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  EvaluationRepository(this._firestore, {FirebaseStorage? storage}) : _storage = storage ?? FirebaseStorage.instance;

  Stream<List<EvaluationModel>> streamUserEvaluations({required String courseId, required String traineeId}) {
    return _firestore
        .collection('evaluations')
        .where('courseId', isEqualTo: courseId)
        .where('traineeId', isEqualTo: traineeId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => EvaluationModel.fromJson({...d.data(), 'id': d.id})).toList());
  }

  Future<Result<void>> addEvaluation({
    required String courseId,
    required String traineeId,
    required String traineeEmail,
    required int score,
    required String feedback,
    required String trainerId,
    File? audioFile,
  }) async {
    try {
      String? audioUrl;
      if (audioFile != null) {
        final ref = _storage.ref().child('evaluation_audio/$courseId/${DateTime.now().millisecondsSinceEpoch}.m4a');
        await ref.putFile(audioFile);
        audioUrl = await ref.getDownloadURL();
      }
      await _firestore.collection('evaluations').add({
        'courseId': courseId,
        'traineeId': traineeId,
        'traineeEmail': traineeEmail,
        'score': score,
        'feedback': feedback,
        'audioUrl': audioUrl,
        'trainerId': trainerId,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return const Success(null);
    } on FirebaseException catch (e, st) {
      logger.e('Failed to add evaluation', error: e, stackTrace: st);
      return FailureResult(UnknownFailure(e.message ?? 'خطأ غير معروف', cause: e, stack: st));
    } catch (e, st) {
      logger.e('Unexpected error addEvaluation', error: e, stackTrace: st);
      return FailureResult(UnknownFailure(e.toString(), cause: e, stack: st));
    }
  }
}
