import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_point_event.dart';

class PointsEventsRepository {
  final FirebaseFirestore _db;
  PointsEventsRepository({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  Query baseQuery(String userId, {String? type}) {
    var q = _db
        .collection('user_points_events')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true);
    if (type != null) {
      q = q.where('type', isEqualTo: type);
    }
    return q;
  }

  Stream<List<UserPointEvent>> streamRecent(
    String userId, {
    String? type,
    int limit = 20,
  }) {
    return baseQuery(userId, type: type)
        .limit(limit)
        .snapshots()
        .map((snap) => snap.docs.map(UserPointEvent.fromDoc).toList());
  }

  Future<List<UserPointEvent>> fetchPage({
    required String userId,
    String? type,
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    var q = baseQuery(userId, type: type).limit(limit);
    if (startAfter != null) {
      q = q.startAfterDocument(startAfter);
    }
    final snap = await q.get();
    return snap.docs.map(UserPointEvent.fromDoc).toList();
  }

  Future<DocumentSnapshot?> getDoc(String id) async {
    final doc = await _db.collection('user_points_events').doc(id).get();
    return doc.exists ? doc : null;
  }
}
