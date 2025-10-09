import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/quizzes/quiz_attempt_providers.dart';
import '../core/l10n_ext.dart';
import '../core/theme/answer_choice_theme.dart';

class QuizAttemptScreen extends ConsumerWidget {
  final String quizId;
  final String courseId;
  const QuizAttemptScreen({
    super.key,
    required this.quizId,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionsAsync = ref.watch(quizQuestionsProvider(quizId));
    final answers = ref.watch(quizAttemptAnswersProvider(quizId));

    return Scaffold(
      appBar: AppBar(title: Text(context.l.testsTabLabel)),
      body: questionsAsync.when(
        data: (questions) {
          if (questions.isEmpty) {
            return Center(child: Text(context.l.noQuizzesYet));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: questions.length,
                  itemBuilder: (c, i) {
                    final q = questions[i];
                    final selected = answers[q.id];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${i + 1}. ${q.text}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _AnswerChoices(
                              options: q.options,
                              selected: selected,
                              onSelect: (v) {
                                ref
                                    .read(
                                      quizAttemptAnswersProvider(
                                        quizId,
                                      ).notifier,
                                    )
                                    .state = {
                                  ...answers,
                                  q.id: v,
                                };
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FilledButton.icon(
                    onPressed: questions.isEmpty
                        ? null
                        : () async {
                            try {
                              final sub = await ref.read(
                                submitQuizAttemptProvider(
                                  SubmitQuizAttemptInput(
                                    quizId: quizId,
                                    courseId: courseId,
                                    questions: questions,
                                    answers: answers,
                                  ),
                                ).future,
                              );
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      context.l.quizLastScore(sub.score),
                                    ),
                                  ),
                                );
                                Navigator.pop(context, sub);
                              }
                            } catch (e) {
                              if (!context.mounted) return;
                              final msg =
                                  e.toString().contains('attempts_exceeded')
                                  ? context.l.quizAttemptExceeded
                                  : e.toString();
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(msg)));
                            }
                          },
                    icon: const Icon(Icons.check),
                    label: Text(context.l.quizSubmitAction),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString())),
      ),
    );
  }
}

// Simple custom group to avoid deprecated Radio API usage
class _AnswerChoices extends StatelessWidget {
  final List<String> options;
  final int? selected;
  final ValueChanged<int> onSelect;
  const _AnswerChoices({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < options.length; i++)
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => onSelect(i),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Builder(
                      builder: (ctx) {
                        final ext = Theme.of(
                          ctx,
                        ).extension<AnswerChoiceTheme>();
                        return Icon(
                          selected == i
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: selected == i
                              ? ext?.selectedIcon ??
                                    Theme.of(ctx).colorScheme.primary
                              : ext?.unselectedIcon ??
                                    Theme.of(
                                      ctx,
                                    ).iconTheme.color?.withValues(alpha: .70),
                          size: 22,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: selected == i
                            ? (Theme.of(context)
                                      .extension<AnswerChoiceTheme>()
                                      ?.selectedBackground ??
                                  Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: .08))
                            : null,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selected == i
                              ? (Theme.of(context)
                                        .extension<AnswerChoiceTheme>()
                                        ?.selectedBorder ??
                                    Theme.of(context).colorScheme.primary)
                              : (Theme.of(context)
                                        .extension<AnswerChoiceTheme>()
                                        ?.unselectedBorder ??
                                    Theme.of(
                                      context,
                                    ).dividerColor.withValues(alpha: .4)),
                        ),
                      ),
                      child: Text(
                        options[i],
                        style: selected == i
                            ? (Theme.of(context)
                                      .extension<AnswerChoiceTheme>()
                                      ?.selectedTextStyle ??
                                  const TextStyle(fontWeight: FontWeight.w600))
                            : (Theme.of(context)
                                      .extension<AnswerChoiceTheme>()
                                      ?.unselectedTextStyle ??
                                  const TextStyle()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
