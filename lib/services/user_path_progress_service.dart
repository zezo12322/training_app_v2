import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider = Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);

class UserPathProgressService {
  final FirebaseFirestore _fs;
  UserPathProgressService(this._fs);

  Future<void> setProgress({
    required String userId,
    required String pathId,
    required int completedSteps,
    required int totalSteps,
  }) async {
  final docId = '${userId}_$pathId';
    final ref = _fs.collection('user_path_progress').doc(docId);
    await ref.set({
      'userId': userId,
      'pathId': pathId,
      'completedSteps': completedSteps,
      'totalSteps': totalSteps,
      'updatedAt': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}

final userPathProgressServiceProvider = Provider<UserPathProgressService>((ref) {
  final fs = ref.watch(firestoreProvider);
  return UserPathProgressService(fs);
});
