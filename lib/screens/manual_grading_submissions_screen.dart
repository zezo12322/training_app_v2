import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/models/quiz_submission.dart';
// Removed unused auth_provider import
import 'package:training_app/providers/quiz_providers.dart';
import 'manual_grade_submission_screen.dart';

class ManualGradingSubmissionsScreen extends ConsumerWidget {
  final String quizId;
  const ManualGradingSubmissionsScreen({super.key, required this.quizId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(quizRepositoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('مراجعة إجابات نصية')), 
      body: StreamBuilder<List<QuizSubmission>>(
        stream: repo.watchSubmissionsNeedingReview(quizId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
            final subs = snapshot.data!;
            if (subs.isEmpty) return const Center(child: Text('لا توجد تسليمات تحتاج تصحيح يدوي.'));
            return ListView.builder(
              itemCount: subs.length,
              itemBuilder: (_, i) {
                final s = subs[i];
                return ListTile(
                  title: Text(s.traineeEmail.isNotEmpty ? s.traineeEmail : s.traineeId),
                  subtitle: Text('درجة آلية: ${s.autoScore} / ${s.totalQuestions}'),
                  trailing: const Icon(Icons.edit),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ManualGradeSubmissionScreen(submissionId: s.id, quizId: quizId),
                  )),
                );
              },
            );
        },
      ),
    );
  }
}
