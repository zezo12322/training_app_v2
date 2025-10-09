import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/learning_path.dart';
import '../models/user_path_progress.dart';

final _fs = Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);

final companyLearningPathsProvider =
    StreamProvider.family<List<LearningPath>, String>((ref, companyId) {
      final fs = ref.watch(_fs);
      return fs
          .collection('learning_paths')
          .where('tenantType', isEqualTo: 'company')
          .where('tenantId', isEqualTo: companyId)
          .orderBy('createdAt', descending: true)
          .withConverter<Map<String, dynamic>>(
            fromFirestore: (snap, _) => snap.data() ?? {},
            toFirestore: (value, _) => value,
          )
          .snapshots()
          .map(
            (q) => q.docs
                .map(
                  (d) => LearningPath.fromDoc(
                    d as DocumentSnapshot<Map<String, dynamic>>,
                  ),
                )
                .toList(),
          );
    });

/// Current user's progress for a given path (read-only)
final userPathProgressProvider =
    StreamProvider.family<UserPathProgress?, ({String userId, String pathId})>(
        (ref, args) {
  final fs = ref.watch(_fs);
  return fs
      .collection('user_path_progress')
      .where('userId', isEqualTo: args.userId)
      .where('pathId', isEqualTo: args.pathId)
      .limit(1)
      .withConverter<Map<String, dynamic>>(
        fromFirestore: (snap, _) => snap.data() ?? {},
        toFirestore: (value, _) => value,
      )
      .snapshots()
      .map((q) => q.docs.isEmpty
          ? null
          : UserPathProgress.fromDoc(
              q.docs.first as DocumentSnapshot<Map<String, dynamic>>,
            ));
});
