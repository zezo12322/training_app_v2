import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../quizzes/quiz_models.dart';
import '../../providers/auth_provider.dart';

/// Stream quizzes for a course (lightweight list)
final courseQuizzesProvider = StreamProvider.family<List<QuizLiteModel>, String>((
  ref,
  courseId,
) {
  final q = FirebaseFirestore.instance
      .collection('quizzes')
      .where('courseId', isEqualTo: courseId)
      // Use descending to match existing composite index (courseId ASC, createdAt DESC) and avoid missing index error
      .orderBy('createdAt', descending: true);
  return q.snapshots().map(
    (s) => s.docs.map((d) => QuizLiteModel.fromDoc(d)).toList(),
  );
});

/// Latest submission per quiz for signed-in trainee (map quizId -> submission)
final latestQuizSubmissionsProvider =
    StreamProvider.family<Map<String, QuizSubmissionLite>, String>((
      ref,
      courseId,
    ) {
      final user = ref.watch(authStateProvider).value;
      if (user == null) return const Stream.empty();
      final q = FirebaseFirestore.instance
          .collection('quiz_submissions')
          .where('traineeId', isEqualTo: user.uid)
          .where('courseId', isEqualTo: courseId)
          .orderBy('submittedAt', descending: true)
          .limit(200); // arbitrary cap
      return q.snapshots().map((snap) {
        final map = <String, QuizSubmissionLite>{};
        for (final d in snap.docs) {
          final sub = QuizSubmissionLite.fromDoc(d);
          // keep first (latest) per quiz
          map.putIfAbsent(sub.quizId, () => sub);
        }
        return map;
      });
    });

/// Derived quiz progress (completed quizzes / total)
final quizProgressForCourseProvider = Provider.family<double, String>((
  ref,
  courseId,
) {
  final quizzes = ref
      .watch(courseQuizzesProvider(courseId))
      .maybeWhen(data: (d) => d, orElse: () => const <QuizLiteModel>[]);
  if (quizzes.isEmpty) return 0;
  final subs = ref
      .watch(latestQuizSubmissionsProvider(courseId))
      .maybeWhen(
        data: (d) => d,
        orElse: () => const <String, QuizSubmissionLite>{},
      );
  final completed = quizzes.where((q) => subs.containsKey(q.id)).length;
  return completed / quizzes.length;
});

/// For trainer: all latest submissions (optionally limited). Map quizId -> list of submissions (ordered desc)
final trainerAllSubmissionsProvider =
    StreamProvider.family<Map<String, List<QuizSubmissionLite>>, String>((
      ref,
      courseId,
    ) {
      // We don't know current user role here; caller should decide to watch
      final q = FirebaseFirestore.instance
          .collection('quiz_submissions')
          .where('courseId', isEqualTo: courseId)
          .orderBy('submittedAt', descending: true)
          .limit(500);
      return q.snapshots().map((snap) {
        final map = <String, List<QuizSubmissionLite>>{};
        for (final d in snap.docs) {
          final sub = QuizSubmissionLite.fromDoc(d);
          map.putIfAbsent(sub.quizId, () => <QuizSubmissionLite>[]).add(sub);
        }
        return map;
      });
    });

/// All submissions for specific quiz by current user (for history / attempts counter)
final quizSubmissionHistoryProvider =
    StreamProvider.family<List<QuizSubmissionLite>, String>((ref, quizId) {
      final user = ref.watch(authStateProvider).value;
      if (user == null) return const Stream.empty();
      final q = FirebaseFirestore.instance
          .collection('quiz_submissions')
          .where('quizId', isEqualTo: quizId)
          .where('traineeId', isEqualTo: user.uid)
          .orderBy('submittedAt', descending: true)
          .limit(10);
      return q.snapshots().map(
        (s) => s.docs.map((d) => QuizSubmissionLite.fromDoc(d)).toList(),
      );
    });
