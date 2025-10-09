import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_points.dart';
import '../models/badge.dart';

class PointsRepository {
  final FirebaseFirestore _db;
  late final CollectionReference _usersRef = _db.collection('user_points');
  late final CollectionReference _badgesRef = _db.collection('badges');

  PointsRepository({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  Future<UserPoints?> getUserPoints(String userId) async {
    final doc = await _usersRef.doc(userId).get();
    if (!doc.exists) return null;
    return UserPoints.fromFirestore(doc);
  }

  Future<void> addPoints(String userId, int points) async {
    await _usersRef.doc(userId).set({
      'points': FieldValue.increment(points),
    }, SetOptions(merge: true));
  }

  /// يسجل نشاط اليوم (لتحديث سلسلة الأيام المتتالية). يرجع قيمة السلسلة الجديدة.
  Future<int> recordDailyActivity(String userId) async {
    return _db.runTransaction((tx) async {
      final ref = _usersRef.doc(userId);
      final snap = await tx.get(ref);
      final data = (snap.data() as Map<String, dynamic>?) ?? {};
      final currentStreak = (data['dailyStreak'] ?? 0) as int;
      Timestamp? lastTs = data['lastActiveDay'] as Timestamp?;
      DateTime? lastDay = lastTs?.toDate();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      int newStreak;
      if (lastDay != null) {
        final lastDate = DateTime(lastDay.year, lastDay.month, lastDay.day);
        final diff = today.difference(lastDate).inDays;
        if (diff == 0) {
          newStreak = currentStreak; // نفس اليوم لا نكرر الزيادة
        } else if (diff == 1) {
          newStreak = currentStreak + 1; // استمرار السلسلة
        } else {
          newStreak = 1; // انقطاع
        }
      } else {
        newStreak = 1; // أول يوم
      }
      tx.set(ref, {
        'dailyStreak': newStreak,
        'lastActiveDay': Timestamp.fromDate(today),
      }, SetOptions(merge: true));
      return newStreak;
    });
  }

  Future<void> addBadge(
    String userId,
    String badgeId, {
    bool recordTimestamp = true,
  }) async {
    // استخدم معاملة لتفادي التنافس على نفس الشارة
    await _db.runTransaction((tx) async {
      final userRef = _usersRef.doc(userId);
      final snap = await tx.get(userRef);
      final data = (snap.data() as Map<String, dynamic>?);
      final currentBadges = List<String>.from(data?['badges'] ?? []);
      if (currentBadges.contains(badgeId)) return; // بالفعل مُنحت
      currentBadges.add(badgeId);
      tx.set(userRef, {'badges': currentBadges}, SetOptions(merge: true));
      if (recordTimestamp) {
        final awardRef = userRef.collection('badge_awards').doc(badgeId);
        tx.set(awardRef, {
          'awardedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
    });
  }

  Future<List<Badge>> getAllBadges() async {
    final snapshot = await _badgesRef.get();
    return snapshot.docs
        .map((doc) => Badge.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<List<UserPoints>> getLeaderboard({int limit = 10}) async {
    final snapshot = await _usersRef
        .orderBy('points', descending: true)
        .limit(limit)
        .get();
    return snapshot.docs.map((doc) => UserPoints.fromFirestore(doc)).toList();
  }
}
