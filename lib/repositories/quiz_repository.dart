import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/core/result.dart';
import 'package:training_app/models/quiz_question.dart';
import 'package:training_app/models/quiz_submission.dart';

class QuizRepository {
  final FirebaseFirestore _db;
  QuizRepository(this._db);

  CollectionReference<Map<String, dynamic>> get _questionsCol => _db.collection('quiz_questions');
  CollectionReference<Map<String, dynamic>> get _submissionsCol => _db.collection('quiz_submissions');

  Stream<List<QuizQuestion>> watchQuestions(String quizId) {
    return _questionsCol
        .where('quizId', isEqualTo: quizId)
        .orderBy('createdAt')
        .snapshots()
        .map((snap) => snap.docs.map((d) => QuizQuestion.fromFirestore(d)).toList());
  }

  Future<Result<void>> addMultipleChoice({
    required String quizId,
    required String questionText,
    required List<String> options,
    required int correctAnswerIndex,
  }) async {
    try {
      await _questionsCol.add({
        'quizId': quizId,
        'questionText': questionText,
        'type': QuizQuestionType.multipleChoice,
        'options': options,
        'correctAnswerIndex': correctAnswerIndex,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return const Success(null);
    } catch (e, st) {
      return FailureResult(UnknownFailure(e.toString(), cause: e, stack: st));
    }
  }

  Future<Result<void>> addTextQuestion({
    required String quizId,
    required String questionText,
    required String type, // short_text or long_text
  }) async {
    try {
      await _questionsCol.add({
        'quizId': quizId,
        'questionText': questionText,
        'type': type,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return const Success(null);
    } catch (e, st) {
      return FailureResult(UnknownFailure(e.toString(), cause: e, stack: st));
    }
  }

  Future<Result<void>> addMatchingQuestion({
    required String quizId,
    required String questionText,
    required List<String> leftItems,
    required List<String> rightItems,
  }) async {
    try {
      assert(leftItems.length == rightItems.length, 'Left & Right lists must have same length');
      final correctPairs = <String, int>{};
      for (int i = 0; i < leftItems.length; i++) {
        correctPairs[i.toString()] = i; // identity mapping by default
      }
      await _questionsCol.add({
        'quizId': quizId,
        'questionText': questionText,
        'type': QuizQuestionType.matching,
        'leftItems': leftItems,
        'rightItems': rightItems,
        'correctPairs': correctPairs,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return const Success(null);
    } catch (e, st) {
      return FailureResult(UnknownFailure(e.toString(), cause: e, stack: st));
    }
  }

  Future<List<QuizQuestion>> fetchQuestionsOnce(String quizId) async {
    final snap = await _questionsCol.where('quizId', isEqualTo: quizId).orderBy('createdAt').get();
    return snap.docs.map((d) => QuizQuestion.fromFirestore(d)).toList();
  }

  Future<Result<String>> submitQuiz({
    required String quizId,
    required String quizTitle,
    required String traineeId,
    required String traineeEmail,
    required List<QuizQuestion> questions,
    required Map<String, dynamic> userAnswers,
  }) async {
    try {
      int autoScore = 0;
      final questionTypes = <String, String>{};
      final requiresManual = <String>[];
      for (final q in questions) {
        questionTypes[q.id] = q.type;
        if (q.type == QuizQuestionType.multipleChoice) {
          final user = userAnswers[q.id] as int?;
          if (user != null && user == q.correctAnswerIndex) autoScore++;
        } else if (q.type == QuizQuestionType.matching) {
          final ans = userAnswers[q.id];
            if (ans is Map) {
              bool allCorrect = true;
              q.correctPairs?.forEach((k, v) {
                final userV = ans[k];
                if (userV != v) allCorrect = false;
              });
              if (allCorrect) autoScore++; // full credit only when all pairs correct
            }
        } else {
          requiresManual.add(q.id);
        }
      }
      final needsManualReview = requiresManual.isNotEmpty;
      final finalScore = autoScore; // manualScore = 0 now
      final ref = await _submissionsCol.add({
        'quizId': quizId,
        'quizTitle': quizTitle,
        'traineeId': traineeId,
        'traineeEmail': traineeEmail,
        'autoScore': autoScore,
        'manualScore': 0,
        'finalScore': finalScore,
        'totalQuestions': questions.length,
        'answers': userAnswers,
        'manualScores': {},
        'questionTypes': questionTypes,
        'needsManualReview': needsManualReview,
        'requiresManualGrading': requiresManual,
        'submittedAt': FieldValue.serverTimestamp(),
      });
      return Success(ref.id);
    } catch (e, st) {
      return FailureResult(UnknownFailure(e.toString(), cause: e, stack: st));
    }
  }

  Stream<List<QuizSubmission>> watchSubmissionsNeedingReview(String quizId) {
    return _submissionsCol
        .where('quizId', isEqualTo: quizId)
        .where('needsManualReview', isEqualTo: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => QuizSubmission.fromFirestore(d)).toList());
  }

  Future<Result<void>> gradeSubmission({
    required String submissionId,
    required Map<String, int> manualScores,
    required String graderId,
  }) async {
    try {
      final docRef = _submissionsCol.doc(submissionId);
      final snap = await docRef.get();
      if (!snap.exists) {
        return FailureResult(UnknownFailure('Submission not found'));
      }
      final data = snap.data()!;
      final autoScore = data['autoScore'] as int? ?? 0;
      final manualScore = manualScores.values.fold<int>(0, (p, e) => p + e);
      final finalScore = autoScore + manualScore;
      await docRef.update({
        'manualScores': manualScores,
        'manualScore': manualScore,
        'finalScore': finalScore,
        'needsManualReview': false,
        'gradedAt': FieldValue.serverTimestamp(),
        'graderId': graderId,
      });
      return const Success(null);
    } catch (e, st) {
      return FailureResult(UnknownFailure(e.toString(), cause: e, stack: st));
    }
  }
}
