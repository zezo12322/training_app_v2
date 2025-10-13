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
                .map((d) => LearningPath.fromDoc(d))
                .toList(),
          );
    });

/// Current user's progress for a given path (read-only)
final userPathProgressProvider =
    StreamProvider.family<UserPathProgress?, ({String userId, String pathId})>(
        (ref, args) {
  final fs = ref.watch(_fs);
  final docId = '${args.userId}_${args.pathId}';
  return fs
      .collection('user_path_progress')
      .doc(docId)
      .withConverter<Map<String, dynamic>>(
        fromFirestore: (snap, _) => snap.data() ?? {},
        toFirestore: (value, _) => value,
      )
      .snapshots()
      .map((snap) => snap.exists ? UserPathProgress.fromDoc(snap) : null);
});

// Create a new learning path (admin scope)
final createLearningPathProvider = FutureProvider.family
    .autoDispose<String, ({String tenantType, String tenantId, String title, String? description, bool active})>((ref, args) async {
  final fs = ref.read(_fs);
  final doc = fs.collection('learning_paths').doc();
  await doc.set({
    'tenantType': args.tenantType,
    'tenantId': args.tenantId,
    'title': args.title,
    if (args.description != null) 'description': args.description,
    'active': args.active,
    // Use request.time sentinel (rules expect createdAt == request.time)
    'createdAt': FieldValue.serverTimestamp(),
    'stepsCount': 0,
  });
  return doc.id;
});

// Update an existing learning path (admin scope)
final updateLearningPathProvider = FutureProvider.family
    .autoDispose<void, ({String id, String? title, String? description, bool? active, int? stepsCount})>((ref, args) async {
  final fs = ref.read(_fs);
  final patch = <String, dynamic>{
    if (args.title != null) 'title': args.title,
    if (args.description != null) 'description': args.description,
    if (args.active != null) 'active': args.active,
    if (args.stepsCount != null) 'stepsCount': args.stepsCount,
  };
  if (patch.isEmpty) return;
  await fs.collection('learning_paths').doc(args.id).update(patch);
});
