import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_evaluation_screen.dart'; // سنحتاج هذا للانتقال لإضافة تقييم

class TraineeReportCardScreen extends StatelessWidget {
  final String courseId;
  final String traineeId;
  final String traineeEmail;

  const TraineeReportCardScreen({
    super.key,
    required this.courseId,
    required this.traineeId,
    required this.traineeEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تقرير: $traineeEmail'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- القسم الأول: التقييمات العامة ---
          _buildSectionTitle(context, 'التقييمات العامة'),
          _buildEvaluationsList(),

          const SizedBox(height: 24),

          // --- القسم الثاني: نتائج الاختبارات ---
          _buildSectionTitle(context, 'نتائج الاختبارات'),
          _buildQuizzesList(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_comment_outlined),
        label: const Text('إضافة تقييم جديد'),
        onPressed: () {
          // الانتقال إلى شاشة إضافة تقييم لهذا المتدرب
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddEvaluationScreen(
              courseId: courseId,
              traineeId: traineeId,
              traineeEmail: traineeEmail,
            ),
          ));
        },
      ),
    );
  }

  // دالة مساعدة لتنسيق العناوين
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Widget لعرض قائمة التقييمات
  Widget _buildEvaluationsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('evaluations')
          .where('courseId', isEqualTo: courseId)
          .where('traineeId', isEqualTo: traineeId)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('لا توجد تقييمات عامة لهذا المتدرب بعد.');
        }
        final evaluations = snapshot.data!.docs;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: evaluations.length,
          itemBuilder: (context, index) {
            final eval = evaluations[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('${eval['score']}')),
                title: Text(eval['feedback']),
                subtitle: Text(
                  DateFormat('yyyy/MM/dd').format((eval['createdAt'] as Timestamp).toDate()),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Widget لعرض قائمة نتائج الاختبارات
  Widget _buildQuizzesList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('quiz_submissions')
          .where('courseId', isEqualTo: courseId)
          .where('traineeId', isEqualTo: traineeId)
          .orderBy('submittedAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('لم يقم المتدرب بتسليم أي اختبارات بعد.');
        }
        final submissions = snapshot.data!.docs;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: submissions.length,
          itemBuilder: (context, index) {
            final sub = submissions[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('${sub['score']}/${sub['totalQuestions']}')),
                title: Text(sub['quizTitle']),
                subtitle: Text(
                  DateFormat('yyyy/MM/dd').format((sub['submittedAt'] as Timestamp).toDate()),
                ),
              ),
            );
          },
        );
      },
    );
  }
}