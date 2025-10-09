import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_evaluation_screen.dart'; // سنحتاج هذا للانتقال لإضافة تقييم
import 'evaluation_thread_screen.dart'; // فتح مناقشة التقييم
import 'package:training_app/core/l10n_ext.dart';

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
    final l = context.l;
    return Scaffold(
      appBar: AppBar(title: Text(l.reportTitle(traineeEmail))),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- القسم الأول: التقييمات العامة ---
          _buildSectionTitle(context, l.reportGeneralSection),
          _buildEvaluationsList(),

          const SizedBox(height: 24),

          // --- القسم الثاني: نتائج الاختبارات ---
          _buildSectionTitle(context, l.reportQuizzesSection),
          _buildQuizzesList(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'trainee_report_card_fab', // unique tag
        icon: const Icon(Icons.add_comment_outlined),
        label: Text(l.addEvaluationFab),
        onPressed: () {
          // الانتقال إلى شاشة إضافة تقييم لهذا المتدرب
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEvaluationScreen(
                courseId: courseId,
                traineeId: traineeId,
                traineeEmail: traineeEmail,
              ),
            ),
          );
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
          return Text(context.l.reportNoEvaluations);
        }
        final evaluations = snapshot.data!.docs;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: evaluations.length,
          itemBuilder: (context, index) {
            final eval = evaluations[index];
            DateTime? createdAt;
            final raw = eval['createdAt'];
            if (raw is Timestamp) {
              createdAt = raw.toDate();
            } else if (raw is DateTime) {
              createdAt = raw;
            } else if (raw is int) {
              // في حال تم تخزينها كـ milliseconds
              createdAt = DateTime.fromMillisecondsSinceEpoch(
                raw,
                isUtc: false,
              );
            }
            // fallback لو null (لم تصل بعد قيمة serverTimestamp)
            final createdAtText = createdAt != null
                ? DateFormat('yyyy/MM/dd').format(createdAt)
                : '...';
            final evalId = eval.id;
            final trainerId =
                (eval.data() as Map<String, dynamic>)['trainerId'] as String? ??
                'unknown';
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('${eval['score']}')),
                title: Text(eval['feedback']),
                subtitle: Text(createdAtText),
                trailing: IconButton(
                  tooltip: context.l.discussionButton,
                  icon: const Icon(Icons.forum_outlined),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EvaluationThreadScreen(
                          evaluationId: evalId,
                          traineeId: traineeId,
                          trainerId: trainerId,
                        ),
                      ),
                    );
                  },
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => EvaluationThreadScreen(
                        evaluationId: evalId,
                        traineeId: traineeId,
                        trainerId: trainerId,
                      ),
                    ),
                  );
                },
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
          return Text(context.l.reportNoQuizzes);
        }
        final submissions = snapshot.data!.docs;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: submissions.length,
          itemBuilder: (context, index) {
            final sub = submissions[index];
            DateTime? submittedAt;
            final raw = sub['submittedAt'];
            if (raw is Timestamp) {
              submittedAt = raw.toDate();
            } else if (raw is DateTime) {
              submittedAt = raw;
            } else if (raw is int) {
              submittedAt = DateTime.fromMillisecondsSinceEpoch(
                raw,
                isUtc: false,
              );
            }
            final submittedAtText = submittedAt != null
                ? DateFormat('yyyy/MM/dd').format(submittedAt)
                : '...';
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text('${sub['score']}/${sub['totalQuestions']}'),
                ),
                title: Text(sub['quizTitle']),
                subtitle: Text(submittedAtText),
              ),
            );
          },
        );
      },
    );
  }
}
