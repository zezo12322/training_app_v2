import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/path_step.dart';

final _fs = Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);

final pathStepsProvider = StreamProvider.family<List<PathStep>, String>((
  ref,
  pathId,
) {
  final fs = ref.watch(_fs);
  return fs
      .collection('path_steps')
      .where('pathId', isEqualTo: pathId)
      .orderBy('order')
      .withConverter<Map<String, dynamic>>(
        fromFirestore: (snap, _) => snap.data() ?? {},
        toFirestore: (value, _) => value,
      )
      .snapshots()
      .map(
        (q) => q.docs
            .map(
              (d) =>
                  PathStep.fromDoc(d as DocumentSnapshot<Map<String, dynamic>>),
            )
            .toList(),
      );
});

// Add a new step at the end
final addPathStepProvider = FutureProvider.family
    .autoDispose<void, ({String pathId, String title, String? description, String? type, int currentCount})>((ref, args) async {
  final fs = ref.read(_fs);
  final doc = fs.collection('path_steps').doc();
  await doc.set({
    'pathId': args.pathId,
    'title': args.title,
    if (args.description != null) 'description': args.description,
    if (args.type != null) 'type': args.type,
    'order': args.currentCount, // append at end
  });
  // bump stepsCount on path
  await fs.collection('learning_paths').doc(args.pathId).update({
    'stepsCount': args.currentCount + 1,
  });
});

// Update existing step
final updatePathStepProvider = FutureProvider.family
    .autoDispose<void, ({String id, String? title, String? description, String? type})>((ref, args) async {
  final fs = ref.read(_fs);
  final patch = <String, dynamic>{
    if (args.title != null) 'title': args.title,
    if (args.description != null) 'description': args.description,
    if (args.type != null) 'type': args.type,
  };
  if (patch.isEmpty) return;
  await fs.collection('path_steps').doc(args.id).update(patch);
});

// Delete step: reindex orders simply client-side after delete
final deletePathStepProvider = FutureProvider.family
    .autoDispose<void, ({String id, String pathId, int currentCount})>((ref, args) async {
  final fs = ref.read(_fs);
  await fs.collection('path_steps').doc(args.id).delete();
  // decrement stepsCount
  await fs.collection('learning_paths').doc(args.pathId).update({
    'stepsCount': (args.currentCount - 1).clamp(0, args.currentCount),
  });
});

// Reorder steps: supply new ordered list of (id, newOrder)
final reorderPathStepsProvider = FutureProvider.family
    .autoDispose<void, List<({String id, int order})>>((ref, ordered) async {
  final fs = ref.read(_fs);
  final batch = fs.batch();
  for (final item in ordered) {
    final refDoc = fs.collection('path_steps').doc(item.id);
    batch.update(refDoc, {'order': item.order});
  }
  await batch.commit();
});
