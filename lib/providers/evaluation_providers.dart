import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:training_app/repositories/evaluation_repository.dart';
import 'package:training_app/models/evaluation.dart';

final evaluationRepositoryProvider = Provider<EvaluationRepository>((ref) {
  return EvaluationRepository(FirebaseFirestore.instance, storage: FirebaseStorage.instance);
});

final userEvaluationsProvider = StreamProvider.autoDispose.family<List<EvaluationModel>, ({String courseId, String traineeId})>((ref, params) {
  return ref.read(evaluationRepositoryProvider).streamUserEvaluations(courseId: params.courseId, traineeId: params.traineeId);
});
