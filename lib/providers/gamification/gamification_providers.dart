import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/gamification/gamification_settings.dart';
import '../../models/gamification/user_course_progress.dart';
import '../../models/gamification/points_transaction.dart';
import '../../repositories/gamification/gamification_repository.dart';
import '../../services/gamification/gamification_service.dart';
import '../../services/gamification/points_calculator.dart';
import '../../services/gamification/level_system.dart';
import '../auth_provider.dart';

// ==================== Repository Provider ====================

final gamificationRepositoryProvider = Provider<GamificationRepository>((ref) {
  return GamificationRepository();
});

// ==================== Service Providers ====================

final pointsCalculatorProvider = Provider<PointsCalculator>((ref) {
  return PointsCalculator();
});

final levelSystemProvider = Provider<LevelSystem>((ref) {
  return LevelSystem();
});

final gamificationServiceProvider = Provider<GamificationService>((ref) {
  return GamificationService(
    repository: ref.watch(gamificationRepositoryProvider),
    pointsCalculator: ref.watch(pointsCalculatorProvider),
    levelSystem: ref.watch(levelSystemProvider),
  );
});

// ==================== Settings Provider ====================

/// الحصول على إعدادات نظام النقاط للكورس
final gamificationSettingsProvider = FutureProvider.family<GamificationSettings?, String>(
  (ref, courseId) async {
    final repository = ref.watch(gamificationRepositoryProvider);
    return await repository.getSettings(courseId);
  },
);

// ==================== User Progress Providers ====================

/// الحصول على تقدم المستخدم في الكورس (Stream - Real-time)
final userCourseProgressProvider = StreamProvider.family<UserCourseProgress?, ({String userId, String courseId})>(
  (ref, params) {
    final repository = ref.watch(gamificationRepositoryProvider);
    return repository.watchUserProgress(params.userId, params.courseId);
  },
);

/// الحصول على تقدم المستخدم الحالي في الكورس
final currentUserProgressProvider = StreamProvider.family<UserCourseProgress?, String>(
  (ref, courseId) {
    final authState = ref.watch(authStateProvider);
    final userId = authState.value?.uid;

    if (userId == null) {
      return Stream.value(null);
    }

    final repository = ref.watch(gamificationRepositoryProvider);
    return repository.watchUserProgress(userId, courseId);
  },
);

// ==================== Leaderboard Provider ====================

/// المتصدرين في الكورس (Stream - Real-time)
final courseLeaderboardProvider = StreamProvider.family<List<UserCourseProgress>, String>(
  (ref, courseId) {
    final repository = ref.watch(gamificationRepositoryProvider);
    return repository.watchLeaderboard(courseId, limit: 10);
  },
);

/// المتصدرين (top 3 للعرض السريع)
final topThreeLeaderboardProvider = StreamProvider.family<List<UserCourseProgress>, String>(
  (ref, courseId) {
    final repository = ref.watch(gamificationRepositoryProvider);
    return repository.watchLeaderboard(courseId, limit: 3);
  },
);

// ==================== Points History Provider ====================

/// سجل النقاط للمستخدم الحالي
final currentUserPointsHistoryProvider = StreamProvider.family<List<PointsTransaction>, String>(
  (ref, courseId) {
    final authState = ref.watch(authStateProvider);
    final userId = authState.value?.uid;

    if (userId == null) {
      return Stream.value([]);
    }

    final repository = ref.watch(gamificationRepositoryProvider);
    return repository.getPointsTransactions(
      userId: userId,
      courseId: courseId,
      limit: 20,
    );
  },
);

/// آخر المعاملات في الكورس (لجميع المستخدمين - للمدرب)
final recentCourseTransactionsProvider = StreamProvider.family<List<PointsTransaction>, String>(
  (ref, courseId) {
    final repository = ref.watch(gamificationRepositoryProvider);
    return repository.getRecentTransactions(courseId, limit: 50);
  },
);

// ==================== Action Providers ====================

/// منح نقاط للمستخدم
final awardPointsProvider = Provider<Future<int> Function({
  required String userId,
  required String courseId,
  required String activityType,
  required String activityName,
  Map<String, dynamic>? metadata,
})>((ref) {
  return ({
    required String userId,
    required String courseId,
    required String activityType,
    required String activityName,
    Map<String, dynamic>? metadata,
  }) async {
    final service = ref.read(gamificationServiceProvider);
    return await service.awardPoints(
      userId: userId,
      courseId: courseId,
      activityType: activityType,
      activityName: activityName,
      metadata: metadata,
    );
  };
});

/// تحديث Daily Streak
final updateDailyStreakProvider = Provider<Future<void> Function(String userId, String courseId)>((ref) {
  return (String userId, String courseId) async {
    final service = ref.read(gamificationServiceProvider);
    await service.checkAndUpdateDailyStreak(userId, courseId);
  };
});

/// تحديث إعدادات النظام (للمدرب)
final updateGamificationSettingsProvider = Provider<Future<void> Function({
  required String courseId,
  required String trainerId,
  required GamificationSettings settings,
})>((ref) {
  return ({
    required String courseId,
    required String trainerId,
    required GamificationSettings settings,
  }) async {
    final service = ref.read(gamificationServiceProvider);
    await service.updateSettings(
      courseId: courseId,
      trainerId: trainerId,
      settings: settings,
    );
  };
});

/// تفعيل/تعطيل نظام النقاط
final toggleGamificationProvider = Provider<Future<void> Function({
  required String courseId,
  required bool enabled,
})>((ref) {
  return ({
    required String courseId,
    required bool enabled,
  }) async {
    final service = ref.read(gamificationServiceProvider);
    await service.toggleGamification(
      courseId: courseId,
      enabled: enabled,
    );
  };
});

// ==================== Computed Providers ====================

/// التحقق من تفعيل نظام النقاط في الكورس
final isGamificationEnabledProvider = FutureProvider.family<bool, String>(
  (ref, courseId) async {
    final settings = await ref.watch(gamificationSettingsProvider(courseId).future);
    return settings?.isEnabled ?? false;
  },
);

/// حساب نسبة التقدم للمستوى التالي
final levelProgressProvider = Provider.family<double, ({String userId, String courseId})>(
  (ref, params) {
    final progressAsync = ref.watch(userCourseProgressProvider(params));
    final settingsAsync = ref.watch(gamificationSettingsProvider(params.courseId));

    return progressAsync.when(
      data: (progress) {
        if (progress == null) return 0.0;

        return settingsAsync.when(
          data: (settings) {
            if (settings == null) return 0.0;

            final levelSystem = ref.read(levelSystemProvider);
            return levelSystem.calculateLevelProgress(
              totalPoints: progress.totalPoints,
              currentLevel: progress.currentLevel,
              levelThresholds: settings.levelThresholds,
            );
          },
          loading: () => 0.0,
          error: (_, __) => 0.0,
        );
      },
      loading: () => 0.0,
      error: (_, __) => 0.0,
    );
  },
);

/// معلومات المستوى الحالي (title, emoji, color)
final currentLevelInfoProvider = Provider.family<Map<String, String>, int>(
  (ref, level) {
    final levelSystem = ref.read(levelSystemProvider);
    return {
      'title': levelSystem.getLevelTitle(level),
      'emoji': levelSystem.getLevelEmoji(level),
      'color': levelSystem.getLevelColor(level),
    };
  },
);
