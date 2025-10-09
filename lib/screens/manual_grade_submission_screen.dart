import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/core/logging.dart';
import 'package:training_app/models/quiz_submission.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/providers/quiz_providers.dart';
import 'package:training_app/models/quiz_question.dart';

class ManualGradeSubmissionScreen extends ConsumerStatefulWidget {
  final String submissionId;
  final String quizId;
  const ManualGradeSubmissionScreen({
    super.key,
    required this.submissionId,
    required this.quizId,
  });

  @override
  ConsumerState<ManualGradeSubmissionScreen> createState() =>
      _ManualGradeSubmissionScreenState();
}

class _ManualGradeSubmissionScreenState
    extends ConsumerState<ManualGradeSubmissionScreen> {
  QuizSubmission? submission;
  List<QuizQuestion> questions = [];
  bool loading = true;
  final Map<String, TextEditingController> _scoreCtrls = {};

  @override
  void dispose() {
    for (final c in _scoreCtrls.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final db = FirebaseFirestore.instance;
      final subSnap = await db
          .collection('quiz_submissions')
          .doc(widget.submissionId)
          .get();
      if (!subSnap.exists) {
        setState(() {
          loading = false;
        });
        return;
      }
      submission = QuizSubmission.fromFirestore(subSnap);
      final qSnap = await db
          .collection('quiz_questions')
          .where('quizId', isEqualTo: widget.quizId)
          .get();
      questions = qSnap.docs
          .map(
            (d) => QuizQuestion.fromFirestore(
              d as DocumentSnapshot<Map<String, dynamic>>,
            ),
          )
          .toList();
      for (final q in questions) {
        if (q.type == QuizQuestionType.shortText ||
            q.type == QuizQuestionType.longText) {
          final existing = submission!.manualScores[q.id];
          _scoreCtrls[q.id] = TextEditingController(
            text: existing?.toString() ?? '0',
          );
        }
      }
    } catch (e, st) {
      logger.e(
        'Failed loading submission / questions',
        error: e,
        stackTrace: st,
      );
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<void> _save() async {
    final repo = ref.read(quizRepositoryProvider);
    final graderId = ref.read(authStateProvider).value?.uid;
    if (graderId == null || submission == null) return;
    final manualScores = <String, int>{};
    _scoreCtrls.forEach((qid, ctrl) {
      manualScores[qid] = int.tryParse(ctrl.text.trim()) ?? 0;
    });
    final res = await repo.gradeSubmission(
      submissionId: submission!.id,
      manualScores: manualScores,
      graderId: graderId,
    );
    res.when(
      success: (_) {
        if (mounted) {
          AppSnackBar.show(context, 'تم حفظ التصحيح', isError: false);
          Navigator.of(context).pop();
        }
      },
      failure: (f) {
        if (mounted) {
          AppSnackBar.show(context, 'فشل: ${f.message}');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تصحيح يدوي')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : submission == null
          ? const Center(child: Text('التسليم غير موجود'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'المتدرب: ${submission!.traineeEmail.isNotEmpty ? submission!.traineeEmail : submission!.traineeId}',
                ),
                const SizedBox(height: 12),
                Text('درجة آلية: ${submission!.autoScore}'),
                const Divider(height: 32),
                ...questions
                    .where(
                      (q) =>
                          q.type == QuizQuestionType.shortText ||
                          q.type == QuizQuestionType.longText,
                    )
                    .map((q) {
                      final answer = submission!.answers[q.id];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                q.questionText,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(answer?.toString() ?? 'لا توجد إجابة'),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _scoreCtrls[q.id],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'درجة السؤال (عدد صحيح)',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('حفظ التصحيح'),
                  onPressed: _save,
                ),
              ],
            ),
    );
  }
}
