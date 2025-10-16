import 'package:flutter/material.dart';
import '../core/l10n_ext.dart';

class QuizResultsScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const QuizResultsScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = totalQuestions > 0
        ? (score / totalQuestions) * 100
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.quizResultsTitle),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.l.quizResultsCompleted,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 32),
              Text(
                context.l.quizResultsYourScore,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                context.l.quizResultsScoreDisplay
                    .replaceAll('{score}', score.toString())
                    .replaceAll('{total}', totalQuestions.toString()),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${percentage.toStringAsFixed(1)}%',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                child: Text(context.l.quizResultsBackButton),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
