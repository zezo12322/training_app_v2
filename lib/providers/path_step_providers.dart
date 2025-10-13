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
        (q) => q.docs.map((d) => PathStep.fromDoc(d)).toList(),
      );
});

// Add a new step at the end
final addPathStepProvider = FutureProvider.family
    .autoDispose<void, ({String pathId, String title, String? description, String? type})>((ref, args) async {
  final fs = ref.read(_fs);
  await fs.runTransaction((tx) async {
    final pathRef = fs.collection('learning_paths').doc(args.pathId);
    final pathSnap = await tx.get(pathRef);
    if (!pathSnap.exists) return;
  final data = pathSnap.data() ?? {};
    final currentCount = (data['stepsCount'] as int?) ?? 0;
    final stepRef = fs.collection('path_steps').doc();
    tx.set(stepRef, {
      'pathId': args.pathId,
      'title': args.title,
      if (args.description != null) 'description': args.description,
      if (args.type != null) 'type': args.type,
      'order': currentCount, // append at end
    });
    tx.update(pathRef, {
      'stepsCount': FieldValue.increment(1),
    });
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
    .autoDispose<void, ({String id, String pathId})>((ref, args) async {
  final fs = ref.read(_fs);
  await fs.runTransaction((tx) async {
    final pathRef = fs.collection('learning_paths').doc(args.pathId);
    tx.delete(fs.collection('path_steps').doc(args.id));
    tx.update(pathRef, {
      'stepsCount': FieldValue.increment(-1),
    });
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
