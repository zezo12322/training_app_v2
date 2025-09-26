import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_question_screen.dart';
import 'create_quiz_screen.dart';
import 'take_quiz_screen.dart'; // <<< تأكد من وجود هذا الاستيراد
import 'quiz_submissions_screen.dart';

class QuizListScreen extends StatelessWidget {
  final String courseId;
  final bool isTrainer;

  const QuizListScreen({
    super.key,
    required this.courseId,
    required this.isTrainer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الاختبارات'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('quizzes')
            .where('courseId', isEqualTo: courseId)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ. تأكد من إنشاء الفهرس المطلوب.\n\n${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('لم يتم إنشاء أي اختبارات بعد.'));
          }

          final quizzes = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              final quiz = quizzes[index];
              // --- هذا هو السطر المهم الذي تم تعريفه هنا ---
              final quizTitle = quiz['title'] as String;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.quiz_outlined),
                  title: Text(quizTitle),
                  trailing: isTrainer
                      ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.bar_chart_outlined),
                        tooltip: 'عرض التسليمات',
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => QuizSubmissionsScreen(
                              quizId: quiz.id,
                              quizTitle: quizTitle,
                            ),
                          ));
                        },
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  )
                      : const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    if (isTrainer) {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddQuestionScreen(quizId: quiz.id)),
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TakeQuizScreen(quizId: quiz.id, quizTitle: quizTitle)),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: isTrainer
          ? FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('إنشاء اختبار'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreateQuizScreen(courseId: courseId)),
          );
        },
      )
          : null,
    );
  }
}