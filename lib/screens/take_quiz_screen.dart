import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'quiz_results_screen.dart'; // استيراد شاشة النتائج

class TakeQuizScreen extends StatefulWidget {
  final String quizId;
  final String quizTitle;

  const TakeQuizScreen({
    super.key,
    required this.quizId,
    required this.quizTitle,
  });

  @override
  State<TakeQuizScreen> createState() => _TakeQuizScreenState();
}

class _TakeQuizScreenState extends State<TakeQuizScreen> {
  List<QueryDocumentSnapshot> _questions = [];
  bool _isLoading = true;
  int _currentQuestionIndex = 0;

  // Map لتخزين إجابات المستخدم (Key: questionId, Value: selectedOptionIndex)
  final Map<String, int> _userAnswers = {};

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('quiz_questions')
          .where('quizId', isEqualTo: widget.quizId)
          .orderBy('createdAt')
          .get();
      setState(() {
        _questions = snapshot.docs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() { _isLoading = false; });
      print(e);
    }
  }

  void _submitQuiz() async {
    setState(() { _isLoading = true; });

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    // 1. حساب النتيجة
    int score = 0;
    for (var question in _questions) {
      final correctAnswerIndex = question['correctAnswerIndex'] as int;
      final userAnswerIndex = _userAnswers[question.id];
      if (userAnswerIndex != null && userAnswerIndex == correctAnswerIndex) {
        score++;
      }
    }

    try {
      // 2. حفظ نتيجة التسليم في قاعدة البيانات
      await FirebaseFirestore.instance.collection('quiz_submissions').add({
        'quizId': widget.quizId,
        'quizTitle': widget.quizTitle,
        'traineeId': currentUser.uid,
        'traineeEmail': currentUser.email,
        'score': score,
        'totalQuestions': _questions.length,
        'submittedAt': FieldValue.serverTimestamp(),
        'answers': _userAnswers,
      });

      // 3. الانتقال إلى شاشة عرض النتيجة
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => QuizResultsScreen(
              score: score,
              totalQuestions: _questions.length,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('حدث خطأ أثناء تسليم الإجابات: $e')));
      }
    } finally {
      if(mounted) setState(() { _isLoading = false; });
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
      appBar: AppBar(
        title: Text(widget.quizTitle),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _questions.isEmpty
          ? const Center(child: Text('لا توجد أسئلة في هذا الاختبار بعد.'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'السؤال ${_currentQuestionIndex + 1} من ${_questions.length}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              _questions[_currentQuestionIndex]['questionText'],
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Divider(height: 32),

            ...(_questions[_currentQuestionIndex]['options'] as List<dynamic>).asMap().entries.map((entry) {
              int optionIndex = entry.key;
              String optionText = entry.value;
              return RadioListTile<int>(
                title: Text(optionText),
                value: optionIndex,
                groupValue: _userAnswers[_questions[_currentQuestionIndex].id],
                onChanged: (value) {
                  setState(() {
                    _userAnswers[_questions[_currentQuestionIndex].id] = value!;
                  });
                },
              );
            }).toList(),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentQuestionIndex > 0)
                  TextButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('السابق'),
                    onPressed: _previousQuestion,
                  ),
                const Spacer(), // Spacer to push next/submit to the right
                if (_currentQuestionIndex < _questions.length - 1)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('التالي'),
                    onPressed: _nextQuestion,
                  ),

                if (_currentQuestionIndex == _questions.length - 1)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.check_circle),
                    label: const Text('تسليم الإجابات'),
                    onPressed: _submitQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Colors.white,
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}