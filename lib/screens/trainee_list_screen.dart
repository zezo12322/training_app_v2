import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'trainee_report_card_screen.dart'; // <<< استيراد شاشة بطاقة التقرير
import '../core/l10n_ext.dart';

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
    final l = context.l;
    return Scaffold(
      appBar: AppBar(title: Text(l.traineeListTitle)),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 150));
        },
        child: traineeIds.isEmpty
            ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 120),
                  Center(child: Text(l.traineeListEmpty)),
                ],
              )
            : ListView.builder(
                itemCount: traineeIds.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final traineeId = traineeIds[index];
                  return FutureBuilder<DocumentSnapshot>(
                    future: _getUserData(traineeId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListTile(title: Text(l.traineeListLoading));
                      }
                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return ListTile(
                          leading: const Icon(Icons.error, color: Colors.red),
                          title: Text(l.traineeListNotFound(traineeId)),
                        );
                      }

                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      final traineeEmail =
                          userData['email'] as String? ?? l.traineeListUnknownEmail;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.person_outline),
                          title: Text(traineeEmail),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          onTap: () {
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
      ),
    );
  }
}
