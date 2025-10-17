import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:training_app/models/quiz_submission.dart';
// Removed unused auth_provider import
import 'package:training_app/providers/quiz_providers.dart';
import 'manual_grade_submission_screen.dart';

class ManualGradingSubmissionsScreen extends ConsumerWidget {
  final String quizId;
  const ManualGradingSubmissionsScreen({super.key, required this.quizId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final repo = ref.watch(quizRepositoryProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l.manualGradingReviewTitle)),
      body: StreamBuilder<List<QuizSubmission>>(
        stream: repo.watchSubmissionsNeedingReview(quizId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final subs = snapshot.data!;
          if (subs.isEmpty) {
            return Center(
              child: Text(l.manualGradingNoSubmissions),
            );
          }
          return ListView.builder(
            itemCount: subs.length,
            itemBuilder: (_, i) {
              final s = subs[i];
              return ListTile(
                title: Text(
                  s.traineeEmail.isNotEmpty ? s.traineeEmail : s.traineeId,
                ),
                subtitle: Text(
                  l.manualGradingAutoScoreLabel(s.autoScore.toString(), s.totalQuestions.toString()),
                ),
                trailing: const Icon(Icons.edit),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ManualGradeSubmissionScreen(
                      submissionId: s.id,
                      quizId: quizId,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
