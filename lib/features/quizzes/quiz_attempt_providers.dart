import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'quiz_models.dart';
import '../../providers/auth_provider.dart';
import 'quiz_providers.dart';

class QuizQuestionModel {
  final String id;
  final String quizId;
  final String text;
  final List<String> options; // multiple choice
  final int correctIndex; // 0-based
  final int order;
  QuizQuestionModel({
    required this.id,
    required this.quizId,
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.order,
  });
  factory QuizQuestionModel.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final d = doc.data()!;
    return QuizQuestionModel(
      id: doc.id,
      quizId: d['quizId'] as String,
      text: d['text'] as String,
      options: (d['options'] as List<dynamic>? ?? const []).cast<String>(),
      correctIndex: (d['correctIndex'] as int?) ?? 0,
      order: (d['order'] as int?) ?? 0,
    );
  }
}

/// Fetch quiz questions
final quizQuestionsProvider =
    StreamProvider.family<List<QuizQuestionModel>, String>((ref, quizId) {
      final q = FirebaseFirestore.instance
          .collection('quiz_questions')
          .where('quizId', isEqualTo: quizId)
          .orderBy('order', descending: false);
      return q.snapshots().map(
        (s) => s.docs.map((d) => QuizQuestionModel.fromDoc(d)).toList(),
      );
    });

/// Local attempt answers (index by questionId)
final quizAttemptAnswersProvider =
    StateProvider.family<Map<String, int>, String>((ref, quizId) => {});

class SubmitQuizAttemptInput {
  final String quizId;
  final String courseId;
  final List<QuizQuestionModel> questions;
  final Map<String, int> answers; // questionId -> chosen index
  SubmitQuizAttemptInput({
    required this.quizId,
    required this.courseId,
    required this.questions,
    required this.answers,
  });
}

final submitQuizAttemptProvider = FutureProvider.autoDispose
    .family<QuizSubmissionLite, SubmitQuizAttemptInput>((ref, input) async {
      final user = ref.read(authStateProvider).value;
      if (user == null) throw Exception('Not signed in');
      if (input.questions.isEmpty) throw Exception('No questions');
      // Enforce attempt limit: count existing submissions for this quiz & user.
      final quizList = ref
          .read(courseQuizzesProvider(input.courseId))
          .maybeWhen(data: (d) => d, orElse: () => const <QuizLiteModel>[]);
      final quiz = quizList.firstWhere(
        (q) => q.id == input.quizId,
        orElse: () => throw Exception('Quiz not found'),
      );
      // Fetch attempts count (cheap query limited to maxAttempts)
      final attemptsSnap = await FirebaseFirestore.instance
          .collection('quiz_submissions')
          .where('quizId', isEqualTo: input.quizId)
          .where('traineeId', isEqualTo: user.uid)
          .orderBy('submittedAt', descending: false)
          .limit(quiz.maxAttempts)
          .get();
      final attemptsCount = attemptsSnap.docs.length;
      if (attemptsCount >= quiz.maxAttempts) {
        throw Exception('attempts_exceeded');
      }
      int correct = 0;
      for (final q in input.questions) {
        final chosen = input.answers[q.id];
        if (chosen != null && chosen == q.correctIndex) correct++;
      }
      final scorePercent = (correct / input.questions.length * 100).round();
      final doc = FirebaseFirestore.instance
          .collection('quiz_submissions')
          .doc();
      final submissionData = {
        'quizId': input.quizId,
        'courseId': input.courseId,
        'traineeId': user.uid,
        'score': scorePercent,
        'correct': correct,
        'total': input.questions.length,
        'answers': input.answers.map((k, v) => MapEntry(k, v)),
        'submittedAt': FieldValue.serverTimestamp(),
      };
      await doc.set(submissionData);
      // Return lite
      return QuizSubmissionLite(
        id: doc.id,
        quizId: input.quizId,
        traineeId: user.uid,
        score: scorePercent,
        submittedAt: DateTime.now(), // optimistic; serverTimestamp will differ
        answers: input.answers,
      );
    });
