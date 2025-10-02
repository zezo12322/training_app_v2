import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/repositories/quiz_repository.dart';

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return QuizRepository(FirebaseFirestore.instance);
});
