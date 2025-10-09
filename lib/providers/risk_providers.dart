import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/risk_user_score.dart';

final _fsRisk = Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);

final latestRiskScoreProvider = StreamProvider.family<RiskUserScore?, String>((
  ref,
  userId,
) {
  final fs = ref.watch(_fsRisk);
  // Grab latest 1 by createdAt desc
  return fs
      .collection('risk_user_scores')
      .where('userId', isEqualTo: userId)
      .orderBy('createdAt', descending: true)
      .limit(1)
      .snapshots()
      .map((q) => q.docs.isEmpty ? null : RiskUserScore.fromDoc(q.docs.first));
});

final highRiskUsersProvider = StreamProvider<List<RiskUserScore>>((ref) {
  final fs = ref.watch(_fsRisk);
  final cutoff = DateTime.now().subtract(const Duration(days: 1));
  return fs
      .collection('risk_user_scores')
      .where('createdAt', isGreaterThan: cutoff)
      .where('level', isEqualTo: 'high')
      .limit(100)
      .snapshots()
      .map((q) => q.docs.map(RiskUserScore.fromDoc).toList());
});
