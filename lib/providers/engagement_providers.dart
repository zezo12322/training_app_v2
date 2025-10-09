import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/engagement_snapshot.dart';

final _fsProvider = Provider<FirebaseFirestore>(
  (_) => FirebaseFirestore.instance,
);

/// Latest engagement snapshot for a user (today) if exists
final engagementSnapshotProvider =
    StreamProvider.family<EngagementSnapshot?, String>((ref, userId) {
      final fs = ref.watch(_fsProvider);
      final today = DateTime.now();
      final dateStr =
          '${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
      final docId = '${userId}_$dateStr';
      return fs
          .collection('engagement_snapshots')
          .doc(docId)
          .snapshots()
          .map((snap) => snap.exists ? EngagementSnapshot.fromDoc(snap) : null);
    });

/// Simple stream of recent snapshots (last 7 days) for a user
final engagementHistoryProvider =
    StreamProvider.family<List<EngagementSnapshot>, String>((ref, userId) {
      final fs = ref.watch(_fsProvider);
      // Using order by createdAt desc limited to ~ last 8 docs (approx 7 days)
      return fs
          .collection('engagement_snapshots')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .limit(8)
          .snapshots()
          .map((q) => q.docs.map(EngagementSnapshot.fromDoc).toList());
    });
