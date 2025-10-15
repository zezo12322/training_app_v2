import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/gamification/course_analytics.dart';
import '../../repositories/gamification/analytics_repository.dart';

// ==================== Repository Provider ====================

final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  return AnalyticsRepository();
});

// ==================== Course Analytics ====================

/// Get comprehensive course analytics
final courseAnalyticsProvider = FutureProvider.family<CourseAnalytics, String>(
  (ref, courseId) async {
    final repository = ref.watch(analyticsRepositoryProvider);
    return repository.getCourseAnalytics(courseId);
  },
);

/// Get activity breakdown
final activityBreakdownProvider = FutureProvider.family<
    Map<String, int>,
    ({String courseId, DateTime? startDate, DateTime? endDate})>(
  (ref, params) async {
    final repository = ref.watch(analyticsRepositoryProvider);

    return repository.getActivityBreakdown(
      courseId: params.courseId,
      startDate: params.startDate,
      endDate: params.endDate,
    );
  },
);

/// Get top students by category
final topStudentsByCategoryProvider = FutureProvider.family<
    List<TopStudent>,
    ({String courseId, String category, int limit})>(
  (ref, params) async {
    final repository = ref.watch(analyticsRepositoryProvider);

    return repository.getTopStudentsByCategory(
      courseId: params.courseId,
      category: params.category,
      limit: params.limit,
    );
  },
);

/// Calculate engagement rate
final engagementRateProvider = FutureProvider.family<
    double,
    ({String courseId, DateTime? startDate})>(
  (ref, params) async {
    final repository = ref.watch(analyticsRepositoryProvider);

    return repository.calculateEngagementRate(
      courseId: params.courseId,
      startDate: params.startDate,
    );
  },
);

// ==================== Specific Metrics ====================

/// Get total students count
final totalStudentsCountProvider = FutureProvider.family<int, String>(
  (ref, courseId) async {
    final analytics = await ref.watch(
      courseAnalyticsProvider(courseId).future,
    );
    return analytics.totalStudents;
  },
);

/// Get active students count
final activeStudentsCountProvider = FutureProvider.family<int, String>(
  (ref, courseId) async {
    final analytics = await ref.watch(
      courseAnalyticsProvider(courseId).future,
    );
    return analytics.activeStudents;
  },
);

/// Get average points
final averagePointsProvider = FutureProvider.family<double, String>(
  (ref, courseId) async {
    final analytics = await ref.watch(
      courseAnalyticsProvider(courseId).future,
    );
    return analytics.avgPoints;
  },
);

/// Get average level
final averageLevelProvider = FutureProvider.family<double, String>(
  (ref, courseId) async {
    final analytics = await ref.watch(
      courseAnalyticsProvider(courseId).future,
    );
    return analytics.avgLevel;
  },
);

/// Get total points awarded
final totalPointsAwardedProvider = FutureProvider.family<int, String>(
  (ref, courseId) async {
    final analytics = await ref.watch(
      courseAnalyticsProvider(courseId).future,
    );
    return analytics.totalPointsAwarded;
  },
);

/// Get total achievements unlocked
final totalAchievementsUnlockedProvider = FutureProvider.family<int, String>(
  (ref, courseId) async {
    final analytics = await ref.watch(
      courseAnalyticsProvider(courseId).future,
    );
    return analytics.totalAchievementsUnlocked;
  },
);

// ==================== Weekly/Monthly Analytics ====================

/// Get weekly engagement rate
final weeklyEngagementRateProvider = FutureProvider.family<double, String>(
  (ref, courseId) async {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

    final repository = ref.watch(analyticsRepositoryProvider);

    return repository.calculateEngagementRate(
      courseId: courseId,
      startDate: sevenDaysAgo,
    );
  },
);

/// Get monthly engagement rate
final monthlyEngagementRateProvider = FutureProvider.family<double, String>(
  (ref, courseId) async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

    final repository = ref.watch(analyticsRepositoryProvider);

    return repository.calculateEngagementRate(
      courseId: courseId,
      startDate: thirtyDaysAgo,
    );
  },
);

/// Get weekly activity breakdown
final weeklyActivityBreakdownProvider = FutureProvider.family<Map<String, int>, String>(
  (ref, courseId) async {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

    final repository = ref.watch(analyticsRepositoryProvider);

    return repository.getActivityBreakdown(
      courseId: courseId,
      startDate: sevenDaysAgo,
      endDate: DateTime.now(),
    );
  },
);

/// Get monthly activity breakdown
final monthlyActivityBreakdownProvider = FutureProvider.family<Map<String, int>, String>(
  (ref, courseId) async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

    final repository = ref.watch(analyticsRepositoryProvider);

    return repository.getActivityBreakdown(
      courseId: courseId,
      startDate: thirtyDaysAgo,
      endDate: DateTime.now(),
    );
  },
);
