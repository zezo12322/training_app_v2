import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/gamification/achievement.dart';
import '../../repositories/gamification/achievement_repository.dart';
import '../../services/gamification/achievement_service.dart';
import 'gamification_providers.dart';

// ==================== Repository & Service Providers ====================

final achievementRepositoryProvider = Provider<AchievementRepository>((ref) {
  return AchievementRepository();
});

final achievementServiceProvider = Provider<AchievementService>((ref) {
  final achievementRepository = ref.watch(achievementRepositoryProvider);
  final gamificationRepository = ref.watch(gamificationRepositoryProvider);

  return AchievementService(
    achievementRepository: achievementRepository,
    progressRepository: gamificationRepository,
  );
});

// ==================== Course Achievements ====================

/// Stream all achievements for a course
final courseAchievementsProvider = StreamProvider.family<List<Achievement>, String>(
  (ref, courseId) {
    final repository = ref.watch(achievementRepositoryProvider);
    return repository.streamCourseAchievements(courseId);
  },
);

/// Get achievement by ID
final achievementProvider = FutureProvider.family<Achievement?, String>(
  (ref, achievementId) async {
    final repository = ref.watch(achievementRepositoryProvider);
    return repository.getAchievement(achievementId);
  },
);

// ==================== User Achievements ====================

/// Stream user's unlocked achievements
final userAchievementsProvider = StreamProvider.family<
    List<UserAchievement>,
    ({String userId, String courseId})>(
  (ref, params) {
    final repository = ref.watch(achievementRepositoryProvider);
    return repository.streamUserAchievements(params.userId, params.courseId);
  },
);

/// Check if achievement is unlocked
final isAchievementUnlockedProvider = FutureProvider.family<
    bool,
    ({String userId, String achievementId})>(
  (ref, params) async {
    final repository = ref.watch(achievementRepositoryProvider);
    return repository.isAchievementUnlocked(
      params.userId,
      params.achievementId,
    );
  },
);

/// Get unviewed achievements count
final unviewedAchievementsCountProvider = FutureProvider.family<
    int,
    ({String userId, String courseId})>(
  (ref, params) async {
    final repository = ref.watch(achievementRepositoryProvider);
    return repository.getUnviewedAchievementsCount(
      params.userId,
      params.courseId,
    );
  },
);

/// Get unviewed achievements
final unviewedAchievementsProvider = FutureProvider.family<
    List<UserAchievement>,
    ({String userId, String courseId})>(
  (ref, params) async {
    final service = ref.watch(achievementServiceProvider);
    return service.getUnviewedAchievements(
      userId: params.userId,
      courseId: params.courseId,
    );
  },
);

// ==================== Achievements with Details ====================

/// Get all achievements with unlock status
final achievementsWithDetailsProvider = FutureProvider.family<
    List<AchievementWithDetails>,
    ({String userId, String courseId})>(
  (ref, params) async {
    final service = ref.watch(achievementServiceProvider);
    return service.getAchievementsWithDetails(
      userId: params.userId,
      courseId: params.courseId,
    );
  },
);

/// Get achievements grouped by category
final achievementsByCategoryProvider = FutureProvider.family<
    Map<AchievementCategory, List<AchievementWithDetails>>,
    ({String userId, String courseId})>(
  (ref, params) async {
    final achievementsWithDetails = await ref.watch(
      achievementsWithDetailsProvider(params).future,
    );

    final grouped = <AchievementCategory, List<AchievementWithDetails>>{};

    for (final achievement in achievementsWithDetails) {
      final category = achievement.achievement.category;
      grouped.putIfAbsent(category, () => []).add(achievement);
    }

    return grouped;
  },
);
