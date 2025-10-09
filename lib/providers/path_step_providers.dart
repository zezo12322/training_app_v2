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
