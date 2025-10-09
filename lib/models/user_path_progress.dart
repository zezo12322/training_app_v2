import 'package:cloud_firestore/cloud_firestore.dart';

class UserPathProgress {
  final String id;
  final String userId;
  final String pathId;
  final int completedSteps;
  final int totalSteps;
  const UserPathProgress({
    required this.id,
    required this.userId,
    required this.pathId,
    required this.completedSteps,
    required this.totalSteps,
  });

  factory UserPathProgress.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? {};
    return UserPathProgress(
      id: doc.id,
      userId: (d['userId'] ?? '') as String,
      pathId: (d['pathId'] ?? '') as String,
      completedSteps: (d['completedSteps'] ?? 0) as int,
      totalSteps: (d['totalSteps'] ?? 0) as int,
    );
  }
}
