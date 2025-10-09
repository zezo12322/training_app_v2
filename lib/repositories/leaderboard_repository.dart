import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardEntry {
  final String userId;
  final int points;
  final List<String> badges;
  final String? name;
  final String? imageUrl;
  final int rank; // 1-based
  LeaderboardEntry({
    required this.userId,
    required this.points,
    required this.badges,
    required this.rank,
    this.name,
    this.imageUrl,
  });
}

class LeaderboardRepository {
  final _points = FirebaseFirestore.instance.collection('user_points');
  final _users = FirebaseFirestore.instance.collection('users');

  Future<List<LeaderboardEntry>> topUsers({int limit = 20}) async {
    final snapshot = await _points
        .orderBy('points', descending: true)
        .limit(limit)
        .get();
    final entries = <LeaderboardEntry>[];
    var position = 0;
    for (final doc in snapshot.docs) {
      position++;
      final data = doc.data();
      final userSnap = await _users.doc(doc.id).get();
      final userData = userSnap.data();
      entries.add(
        LeaderboardEntry(
          userId: doc.id,
          points: data['points'] ?? 0,
          badges: List<String>.from(data['badges'] ?? const []),
          rank: position,
          name: userData != null ? userData['name'] as String? : null,
          imageUrl: userData != null ? userData['imageUrl'] as String? : null,
        ),
      );
    }
    return entries;
  }
}
