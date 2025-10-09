import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/repositories/evaluation_repository.dart';
import 'package:training_app/models/evaluation.dart';

final evaluationRepositoryProvider = Provider<EvaluationRepository>((ref) {
  // FirebaseStorage dependency removed; repository now internally switches to R2 via AppConfig
  return EvaluationRepository(FirebaseFirestore.instance);
});

final userEvaluationsProvider = StreamProvider.autoDispose
    .family<List<EvaluationModel>, ({String courseId, String traineeId})>((
      ref,
      params,
    ) {
      return ref
          .read(evaluationRepositoryProvider)
          .streamUserEvaluations(
            courseId: params.courseId,
            traineeId: params.traineeId,
          );
    });
