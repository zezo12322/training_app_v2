// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/core/logging.dart';
import 'package:training_app/models/quiz_question.dart';
import 'package:training_app/providers/quiz_providers.dart';
import 'quiz_results_screen.dart';
import '../core/l10n_ext.dart';

class TakeQuizScreen extends ConsumerStatefulWidget {
  final String quizId;
  final String quizTitle;

  const TakeQuizScreen({
    super.key,
    required this.quizId,
    required this.quizTitle,
  });

  @override
  @override
  ConsumerState<TakeQuizScreen> createState() => _TakeQuizScreenState();
}

class _TakeQuizScreenState extends ConsumerState<TakeQuizScreen> {
  List<QuizQuestion> _questions = [];
  bool _isLoading = true;
  int _currentQuestionIndex = 0;

  // إجابات: للاختيار من متعدد نخزن index، وللنصي نخزن النص.
  final Map<String, dynamic> _userAnswers = {};

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    try {
      final repo = ref.read(quizRepositoryProvider);
      final qs = await repo.fetchQuestionsOnce(widget.quizId);
      setState(() {
        _questions = qs;
        _isLoading = false;
      });
    } catch (e, st) {
      setState(() {
        _isLoading = false;
      });
      logger.e('Failed loading quiz questions', error: e, stackTrace: st);
    }
  }

  void _submitQuiz() async {
    setState(() {
      _isLoading = true;
    });

    final currentUser = ref.read(authStateProvider).value;
    if (currentUser == null) return;
    try {
      final repo = ref.read(quizRepositoryProvider);
      final res = await repo.submitQuiz(
        quizId: widget.quizId,
        quizTitle: widget.quizTitle,
        traineeId: currentUser.uid,
        traineeEmail: currentUser.email ?? '',
        questions: _questions,
        userAnswers: _userAnswers,
      );
      res.when(
        success: (_) {
          int autoScore = 0;
          for (final q in _questions) {
            if (q.type == QuizQuestionType.multipleChoice) {
              final user = _userAnswers[q.id] as int?;
              if (user != null && user == q.correctAnswerIndex) autoScore++;
            } else if (q.type == QuizQuestionType.matching) {
              final ans = _userAnswers[q.id];
              if (ans is Map) {
                bool allCorrect = true;
                q.correctPairs?.forEach((k, v) {
                  if (ans[k] != v) allCorrect = false;
                });
                if (allCorrect) autoScore++;
              }
            }
          }
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => QuizResultsScreen(
                  score: autoScore,
                  totalQuestions: _questions.length,
                ),
              ),
            );
          }
        },
        failure: (f) {
          if (mounted) {
            AppSnackBar.show(context, context.l.takeQuizSubmissionFailed(f.message));
          }
        },
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.quizTitle)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _questions.isEmpty
          ? Center(child: Text(context.l.takeQuizNoQuestions))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.l.takeQuizQuestionProgress((_currentQuestionIndex + 1).toString(), _questions.length.toString()),
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _questions[_currentQuestionIndex].questionText,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Divider(height: 32),
                  Builder(
                    builder: (_) {
                      final q = _questions[_currentQuestionIndex];
                      final type = q.type;
                      if (type == QuizQuestionType.multipleChoice) {
                        final opts = q.options ?? [];
                        return Column(
                          children: opts.asMap().entries.map((entry) {
                            final optionIndex = entry.key;
                            final optionText = entry.value;
                            return RadioListTile<int>(
                              title: Text(optionText),
                              value: optionIndex,
                              groupValue: _userAnswers[q.id] as int?,
                              onChanged: (value) {
                                setState(() {
                                  _userAnswers[q.id] = value!;
                                });
                              },
                            );
                          }).toList(),
                        );
                      } else if (type == QuizQuestionType.shortText) {
                        return TextFormField(
                          initialValue: _userAnswers[q.id] as String?,
                          decoration: InputDecoration(
                            labelText: context.l.takeQuizShortAnswerLabel,
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (val) => _userAnswers[q.id] = val,
                        );
                      } else if (type == QuizQuestionType.longText) {
                        return TextFormField(
                          initialValue: _userAnswers[q.id] as String?,
                          maxLines: 6,
                          decoration: InputDecoration(
                            labelText: context.l.takeQuizEssayAnswerLabel,
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (val) => _userAnswers[q.id] = val,
                        );
                      } else if (type == QuizQuestionType.matching) {
                        // Display each left item with dropdown of right items
                        final left = q.leftItems ?? [];
                        final right = q.rightItems ?? [];
                        _userAnswers[q.id] ??= <String, int>{};
                        return Column(
                          children: left.asMap().entries.map((entry) {
                            final leftIndex = entry.key;
                            final leftText = entry.value;
                            final currentMap =
                                _userAnswers[q.id] as Map<String, int>;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(child: Text(leftText)),
                                  const SizedBox(width: 12),
                                  DropdownButton<int>(
                                    value: currentMap[leftIndex.toString()],
                                    hint: Text(context.l.takeQuizMatchingSelect),
                                    items: right
                                        .asMap()
                                        .entries
                                        .map(
                                          (e) => DropdownMenuItem<int>(
                                            value: e.key,
                                            child: Text(e.value),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        currentMap[leftIndex.toString()] =
                                            val ?? 0;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }
                      return Text(context.l.takeQuizUnsupportedType);
                    },
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentQuestionIndex > 0)
                        TextButton.icon(
                          icon: const Icon(Icons.arrow_back),
                          label: Text(context.l.takeQuizPreviousButton),
                          onPressed: _previousQuestion,
                        ),
                      const Spacer(),
                      if (_currentQuestionIndex < _questions.length - 1)
                        ElevatedButton.icon(
                          icon: const Icon(Icons.arrow_forward),
                          label: Text(context.l.takeQuizNextButton),
                          onPressed: _nextQuestion,
                        ),

                      if (_currentQuestionIndex == _questions.length - 1)
                        ElevatedButton.icon(
                          icon: const Icon(Icons.check_circle),
                          label: Text(context.l.takeQuizSubmitButton),
                          onPressed: _submitQuiz,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.secondary,
                            foregroundColor: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
