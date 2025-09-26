import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'trainee_report_card_screen.dart'; // <<< استيراد شاشة بطاقة التقرير

class TraineeListScreen extends StatelessWidget {
  final String courseId;
  final List<String> traineeIds;

  const TraineeListScreen({
    super.key,
    required this.courseId,
    required this.traineeIds,
  });

  Future<DocumentSnapshot> _getUserData(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المتدربون'),
      ),
      body: traineeIds.isEmpty
          ? const Center(child: Text('لا يوجد متدربون في هذا الكورس بعد.'))
          : ListView.builder(
        itemCount: traineeIds.length,
        itemBuilder: (context, index) {
          final traineeId = traineeIds[index];
          return FutureBuilder<DocumentSnapshot>(
            future: _getUserData(traineeId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ListTile(title: Text('جار التحميل...'));
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return ListTile(
                  leading: const Icon(Icons.error, color: Colors.red),
                  title: Text('متدرب غير موجود: $traineeId'),
                );
              }

              final userData = snapshot.data!.data() as Map<String, dynamic>;
              final traineeEmail = userData['email'] as String? ?? 'بريد غير معروف';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: Text(traineeEmail),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // --- التعديل هنا ---
                    // الانتقال إلى شاشة بطاقة التقرير
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TraineeReportCardScreen(
                          courseId: courseId,
                          traineeId: traineeId,
                          traineeEmail: traineeEmail,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}