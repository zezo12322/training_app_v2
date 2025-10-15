import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/gamification/leaderboard_entry.dart';
import '../../core/logging.dart';

/// Repository لإدارة لوحة المتصدرين
class LeaderboardRepository {
  final FirebaseFirestore _firestore;

  LeaderboardRepository(this._firestore);

  /// Get leaderboard for a course (real-time stream)
  Stream<List<LeaderboardEntry>> streamLeaderboard({
    required String courseId,
    required LeaderboardTimeframe timeframe,
    int limit = 50,
  }) {
    appLogger.i('Streaming leaderboard for course: $courseId, timeframe: $timeframe');

    try {
      Query query = _firestore
          .collection('user_course_progress')
          .where('courseId', isEqualTo: courseId);

      // Filter by timeframe if needed
      if (timeframe != LeaderboardTimeframe.allTime) {
        final startDate = timeframe.startDate;
        query = query.where('lastActivityDate',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate));
      }

      // Order by points descending
      query = query.orderBy('totalPoints', descending: true).limit(limit);

      return query.snapshots().asyncMap((snapshot) async {
        final entries = <LeaderboardEntry>[];
        int rank = 1;

        for (final doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          
          // Get user info
          final userId = data['userId'] as String;
          final userDoc = await _firestore.collection('users').doc(userId).get();
          final userName = userDoc.data()?['name'] as String? ?? 'Unknown';
          final userAvatar = userDoc.data()?['photoURL'] as String?;

          // Create entry
          final entry = LeaderboardEntry(
            userId: userId,
            userName: userName,
            userAvatar: userAvatar,
            totalPoints: data['totalPoints'] as int? ?? 0,
            currentLevel: data['currentLevel'] as int? ?? 1,
            levelName: data['levelName'] as String? ?? 'مبتدئ',
            rank: rank++,
            moduleCount: (data['activityCounts'] as Map?)?['completedModules'] as int? ?? 0,
            quizCount: (data['activityCounts'] as Map?)?['passedQuizzes'] as int? ?? 0,
            streakCount: data['dailyStreakCount'] as int? ?? 0,
            lastActivity: (data['lastActivityDate'] as Timestamp?)?.toDate(),
          );

          entries.add(entry);
        }

        appLogger.i('Leaderboard loaded: ${entries.length} entries');
        return entries;
      });
    } catch (e, stackTrace) {
      appLogger.e('Error streaming leaderboard', error: e, stackTrace: stackTrace);
      return Stream.error(e);
    }
  }

  /// Get user's rank in leaderboard
  Future<int?> getUserRank({
    required String userId,
    required String courseId,
    required LeaderboardTimeframe timeframe,
  }) async {
    appLogger.i('Getting rank for user: $userId');

    try {
      // Get user's points
      final userDoc = await _firestore
          .collection('user_course_progress')
          .doc('${userId}_$courseId')
          .get();

      if (!userDoc.exists) {
        return null;
      }

      final userPoints = userDoc.data()?['totalPoints'] as int? ?? 0;

      // Count users with more points
      Query query = _firestore
          .collection('user_course_progress')
          .where('courseId', isEqualTo: courseId)
          .where('totalPoints', isGreaterThan: userPoints);

      if (timeframe != LeaderboardTimeframe.allTime) {
        final startDate = timeframe.startDate;
        query = query.where('lastActivityDate',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate));
      }

      final snapshot = await query.count().get();
      final rank = (snapshot.count ?? 0) + 1;

      appLogger.i('User rank: $rank');
      return rank;
    } catch (e, stackTrace) {
      appLogger.e('Error getting user rank', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// Get top N students
  Future<List<LeaderboardEntry>> getTopStudents({
    required String courseId,
    int limit = 5,
  }) async {
    appLogger.i('Getting top $limit students for course: $courseId');

    try {
      final query = _firestore
          .collection('user_course_progress')
          .where('courseId', isEqualTo: courseId)
          .orderBy('totalPoints', descending: true)
          .limit(limit);

      final snapshot = await query.get();
      final entries = <LeaderboardEntry>[];
      int rank = 1;

      for (final doc in snapshot.docs) {
        final data = doc.data();
        
        // Get user info
        final userId = data['userId'] as String;
        final userDoc = await _firestore.collection('users').doc(userId).get();
        final userName = userDoc.data()?['name'] as String? ?? 'Unknown';
        final userAvatar = userDoc.data()?['photoURL'] as String?;

        final entry = LeaderboardEntry(
          userId: userId,
          userName: userName,
          userAvatar: userAvatar,
          totalPoints: data['totalPoints'] as int? ?? 0,
          currentLevel: data['currentLevel'] as int? ?? 1,
          levelName: data['levelName'] as String? ?? 'مبتدئ',
          rank: rank++,
          moduleCount: (data['activityCounts'] as Map?)?['completedModules'] as int? ?? 0,
          quizCount: (data['activityCounts'] as Map?)?['passedQuizzes'] as int? ?? 0,
          streakCount: data['dailyStreakCount'] as int? ?? 0,
          lastActivity: (data['lastActivityDate'] as Timestamp?)?.toDate(),
        );

        entries.add(entry);
      }

      return entries;
    } catch (e, stackTrace) {
      appLogger.e('Error getting top students', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
