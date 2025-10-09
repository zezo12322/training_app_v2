import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // حزمة لتنسيق التاريخ

class QuizSubmissionsScreen extends StatelessWidget {
  final String quizId;
  final String quizTitle;

  const QuizSubmissionsScreen({
    super.key,
    required this.quizId,
    required this.quizTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تسليمات: $quizTitle')),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 150));
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('quiz_submissions')
              .where('quizId', isEqualTo: quizId)
              .orderBy('submittedAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'حدث خطأ. تأكد من إنشاء الفهرس المطلوب.\n\n${snapshot.error}',
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 120),
                  Center(
                    child: Text('لم يقم أي متدرب بتسليم هذا الاختبار بعد.'),
                  ),
                ],
              );
            }

            final submissions = snapshot.data!.docs;

            return ListView.builder(
              itemCount: submissions.length,
              itemBuilder: (context, index) {
                final submission = submissions[index];
                // Some legacy docs may not have 'score'; use finalScore or autoScore fallback.
                final data = submission.data() as Map<String, dynamic>;
                final score =
                    data['finalScore'] ??
                    data['autoScore'] ??
                    data['score'] ??
                    0;
                final totalQuestions = data['totalQuestions'] ?? 0;
                final traineeEmail = submission['traineeEmail'];
                final Timestamp timestamp =
                    data['submittedAt'] as Timestamp? ?? Timestamp.now();

                // تنسيق التاريخ والوقت
                final formattedDate = DateFormat(
                  'yyyy/MM/dd – hh:mm a',
                ).format(timestamp.toDate());

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('$score')),
                    title: Text(
                      traineeEmail,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'النتيجة: $score من $totalQuestions\nتم التسليم في: $formattedDate',
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
