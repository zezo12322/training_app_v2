import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

import '../../models/gamification/course_analytics.dart';
import '../../models/gamification/user_course_progress.dart';

/// Repository لتحليل إحصائيات الكورس
///
/// يوفر:
/// - Course analytics (students, avg points, engagement)
/// - Activity breakdown
/// - Top students
/// - Engagement metrics
class AnalyticsRepository {
  final FirebaseFirestore _firestore;
  final Logger _logger = Logger('AnalyticsRepository');

  AnalyticsRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  // ==================== Collections ====================

  CollectionReference<Map<String, dynamic>> get _progressCollection =>
      _firestore.collection('user_course_progress');

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  // ==================== Course Analytics ====================

  /// Get comprehensive course analytics
  Future<CourseAnalytics> getCourseAnalytics(String courseId) async {
    try {
      _logger.info('Getting course analytics for course: $courseId');

      // Get all students' progress
      final progressSnapshot = await _progressCollection
          .where('courseId', isEqualTo: courseId)
          .get();

      if (progressSnapshot.docs.isEmpty) {
        _logger.warning('No students found for course: $courseId');
        return _emptyAnalytics(courseId);
      }

      final progressList = progressSnapshot.docs
          .map((doc) {
            try {
              return UserCourseProgress.fromJson({
                'id': doc.id,
                ...doc.data(),
              });
            } catch (e) {
              _logger.warning('Error parsing progress ${doc.id}: $e');
              return null;
            }
          })
          .whereType<UserCourseProgress>()
          .toList();

      // Calculate metrics
      final totalStudents = progressList.length;
      final activeStudents = _countActiveStudents(progressList);
      final avgPoints = _calculateAveragePoints(progressList);
      final avgLevel = _calculateAverageLevel(progressList);
      final totalPointsAwarded = _calculateTotalPoints(progressList);
      
      // Get activity breakdown
      final activityBreakdown = _calculateActivityBreakdown(progressList);
      
      // Get top students
      final topStudents = await _getTopStudents(progressList, limit: 10);
      
      // Calculate engagement rate
      final engagementRate = _calculateEngagementRate(progressList);
      
      // Get total achievements unlocked
      final totalAchievementsUnlocked = await _getTotalAchievements(courseId);

      final analytics = CourseAnalytics(
        courseId: courseId,
        totalStudents: totalStudents,
        activeStudents: activeStudents,
        avgPoints: avgPoints,
        avgLevel: avgLevel,
        activityBreakdown: activityBreakdown,
        topStudents: topStudents,
        engagementRate: engagementRate,
        totalPointsAwarded: totalPointsAwarded,
        totalAchievementsUnlocked: totalAchievementsUnlocked,
      );

      _logger.info('Course analytics calculated: $totalStudents students');

      return analytics;
    } catch (e, stackTrace) {
      _logger.severe('Error getting course analytics', e, stackTrace);
      rethrow;
    }
  }

  /// Get activity breakdown for specific timeframe
  Future<List<ActivityStats>> getActivityBreakdown({
    required String courseId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      var query = _progressCollection.where('courseId', isEqualTo: courseId);

      if (startDate != null) {
        query = query.where('lastActivityDate', isGreaterThanOrEqualTo: startDate);
      }

      if (endDate != null) {
        query = query.where('lastActivityDate', isLessThanOrEqualTo: endDate);
      }

      final snapshot = await query.get();

      final progressList = snapshot.docs
          .map((doc) {
            try {
              return UserCourseProgress.fromJson({
                'id': doc.id,
                ...doc.data(),
              });
            } catch (e) {
              return null;
            }
          })
          .whereType<UserCourseProgress>()
          .toList();

      return _calculateActivityBreakdown(progressList);
    } catch (e, stackTrace) {
      _logger.severe('Error getting activity breakdown', e, stackTrace);
      rethrow;
    }
  }

  /// Get top students by category
  Future<List<TopStudent>> getTopStudentsByCategory({
    required String courseId,
    required String category,
    int limit = 10,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _progressCollection
          .where('courseId', isEqualTo: courseId);

      // Order by category
      switch (category) {
        case 'points':
          query = query.orderBy('totalPoints', descending: true);
          break;
        case 'level':
          query = query.orderBy('currentLevel', descending: true);
          break;
        case 'modules':
          query = query.orderBy('completedModules', descending: true);
          break;
        case 'quizzes':
          query = query.orderBy('passedQuizzes', descending: true);
          break;
        case 'streak':
          query = query.orderBy('currentStreak', descending: true);
          break;
        default:
          query = query.orderBy('totalPoints', descending: true);
      }

      query = query.limit(limit);

      final snapshot = await query.get();

      final progressList = snapshot.docs
          .map((doc) {
            try {
              return UserCourseProgress.fromJson({
                'id': doc.id,
                ...doc.data(),
              });
            } catch (e) {
              return null;
            }
          })
          .whereType<UserCourseProgress>()
          .toList();

      return await _getTopStudents(progressList, limit: limit);
    } catch (e, stackTrace) {
      _logger.severe('Error getting top students by category', e, stackTrace);
      rethrow;
    }
  }

  /// Calculate engagement rate for specific timeframe
  Future<double> calculateEngagementRate({
    required String courseId,
    DateTime? startDate,
  }) async {
    try {
      // Get all students
      final allStudentsSnapshot = await _progressCollection
          .where('courseId', isEqualTo: courseId)
          .get();

      if (allStudentsSnapshot.docs.isEmpty) {
        return 0.0;
      }

      // Get active students (within timeframe)
      var activeQuery = _progressCollection
          .where('courseId', isEqualTo: courseId);

      if (startDate != null) {
        activeQuery = activeQuery.where(
          'lastActivityDate',
          isGreaterThanOrEqualTo: startDate,
        );
      }

      final activeStudentsSnapshot = await activeQuery.get();

      final totalStudents = allStudentsSnapshot.docs.length;
      final activeStudents = activeStudentsSnapshot.docs.length;

      return (activeStudents / totalStudents) * 100;
    } catch (e, stackTrace) {
      _logger.severe('Error calculating engagement rate', e, stackTrace);
      rethrow;
    }
  }

  // ==================== Helper Methods ====================

  CourseAnalytics _emptyAnalytics(String courseId) {
    return CourseAnalytics(
      courseId: courseId,
      totalStudents: 0,
      activeStudents: 0,
      avgPoints: 0,
      avgLevel: 1,
      activityBreakdown: [],
      topStudents: [],
      engagementRate: 0.0,
      totalPointsAwarded: 0,
      totalAchievementsUnlocked: 0,
    );
  }

  int _countActiveStudents(List<UserCourseProgress> progressList) {
    // Active = activity in last 7 days
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

    return progressList
        .where((p) =>
            p.lastActivityDate != null &&
            p.lastActivityDate!.isAfter(sevenDaysAgo))
        .length;
  }

  double _calculateAveragePoints(List<UserCourseProgress> progressList) {
    if (progressList.isEmpty) return 0.0;

    final totalPoints = progressList.fold<int>(
      0,
      (sum, p) => sum + (p.totalPoints ?? 0),
    );

    return totalPoints / progressList.length;
  }

  double _calculateAverageLevel(List<UserCourseProgress> progressList) {
    if (progressList.isEmpty) return 1.0;

    final totalLevel = progressList.fold<int>(
      0,
      (sum, p) => sum + (p.currentLevel ?? 1),
    );

    return totalLevel / progressList.length;
  }

  int _calculateTotalPoints(List<UserCourseProgress> progressList) {
    return progressList.fold<int>(
      0,
      (sum, p) => sum + (p.totalPoints ?? 0),
    );
  }

  List<ActivityStats> _calculateActivityBreakdown(
    List<UserCourseProgress> progressList,
  ) {
    if (progressList.isEmpty) return [];

    // Calculate totals
    int totalModules = 0;
    int totalQuizzes = 0;
    int totalStreaks = 0;
    int totalModulePoints = 0;
    int totalQuizPoints = 0;
    int totalStreakPoints = 0;

    for (final progress in progressList) {
      totalModules += progress.completedModules.length;
      totalQuizzes += progress.passedQuizzes.length;
      totalStreaks += progress.currentStreak ?? 0;

      // Estimate points per activity type
      // Module = 100 pts, Quiz = 50 pts, Streak day = 10 pts
      totalModulePoints += progress.completedModules.length * 100;
      totalQuizPoints += progress.passedQuizzes.length * 50;
      totalStreakPoints += (progress.currentStreak ?? 0) * 10;
    }

    final totalActivities = totalModules + totalQuizzes + totalStreaks;
    if (totalActivities == 0) return [];

    return [
      ActivityStats(
        activityType: 'modules',
        count: totalModules,
        percentage: (totalModules / totalActivities) * 100,
        totalPoints: totalModulePoints,
      ),
      ActivityStats(
        activityType: 'quizzes',
        count: totalQuizzes,
        percentage: (totalQuizzes / totalActivities) * 100,
        totalPoints: totalQuizPoints,
      ),
      ActivityStats(
        activityType: 'streaks',
        count: totalStreaks,
        percentage: (totalStreaks / totalActivities) * 100,
        totalPoints: totalStreakPoints,
      ),
    ];
  }

  Future<List<TopStudent>> _getTopStudents(
    List<UserCourseProgress> progressList, {
    required int limit,
  }) async {
    // Sort by points
    progressList.sort((a, b) {
      final pointsA = a.totalPoints ?? 0;
      final pointsB = b.totalPoints ?? 0;
      return pointsB.compareTo(pointsA);
    });

    // Take top N
    final topProgress = progressList.take(limit).toList();

    // Fetch user info
    final topStudents = <TopStudent>[];
    int rank = 1;

    for (final progress in topProgress) {
      try {
        // Get user info
        final userDoc = await _usersCollection.doc(progress.userId).get();

        if (!userDoc.exists) {
          _logger.warning('User not found: ${progress.userId}');
          continue;
        }

        final userData = userDoc.data()!;

        topStudents.add(
          TopStudent(
            userId: progress.userId,
            userName: userData['name'] as String? ?? 'مستخدم',
            points: progress.totalPoints ?? 0,
            level: progress.currentLevel ?? 1,
            userAvatar: userData['photoUrl'] as String?,
            rank: rank,
          ),
        );

        rank++;
      } catch (e) {
        _logger.warning('Error fetching user ${progress.userId}: $e');
        continue;
      }
    }

    return topStudents;
  }

  double _calculateEngagementRate(List<UserCourseProgress> progressList) {
    if (progressList.isEmpty) return 0.0;

    final activeStudents = _countActiveStudents(progressList);
    return (activeStudents / progressList.length) * 100;
  }

  Future<int> _getTotalAchievements(String courseId) async {
    try {
      final snapshot = await _firestore
          .collection('user_achievements')
          .where('courseId', isEqualTo: courseId)
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e) {
      _logger.warning('Error getting total achievements: $e');
      return 0;
    }
  }
}
