import 'package:logging/logging.dart';

import '../../models/gamification/achievement.dart';
import '../../models/gamification/points_transaction.dart';
import '../../models/gamification/user_course_progress.dart';
import '../../repositories/gamification/achievement_repository.dart';
import '../../repositories/gamification/gamification_repository.dart';

/// Service للتحقق التلقائي من الإنجازات وفتحها
///
/// يوفر:
/// - Auto-check achievements after activities
/// - Criteria evaluation logic
/// - Achievement unlock notifications
/// - Progress tracking
class AchievementService {
  final AchievementRepository _achievementRepository;
  final GamificationRepository _gamificationRepository;
  final Logger _logger = Logger('AchievementService');

  AchievementService({
    required AchievementRepository achievementRepository,
    required GamificationRepository progressRepository,
  })  : _achievementRepository = achievementRepository,
        _gamificationRepository = progressRepository;

  // ==================== Check and Award ====================

  /// التحقق من جميع الإنجازات وفتح ما يستوفي الشروط
  ///
  /// يجب استدعاؤه بعد:
  /// - إكمال module
  /// - اجتياز quiz
  /// - تحديث streak
  /// - Level up
  /// - أي نشاط يؤثر على الإنجازات
  ///
  /// Returns: List of newly unlocked achievements
  Future<List<Achievement>> checkAndAwardAchievements({
    required String userId,
    required String courseId,
  }) async {
    try {
      _logger.info(
        'Checking achievements for user: $userId, course: $courseId',
      );

      // Get user progress
      final progress = await _gamificationRepository.getUserProgress(
        userId,
        courseId,
      );

      if (progress == null) {
        _logger.warning('No progress found for user: $userId');
        return [];
      }

      // Get all course achievements
      final allAchievements = await _achievementRepository
          .streamCourseAchievements(courseId)
          .first;

      // Get already unlocked achievements
      final unlockedAchievements = await _achievementRepository
          .streamUserAchievements(userId, courseId)
          .first;

      final unlockedIds = unlockedAchievements
          .map((ua) => ua.achievementId)
          .toSet();

      // Find achievements to unlock
      final newlyUnlocked = <Achievement>[];

      for (final achievement in allAchievements) {
        // Skip if already unlocked
        if (unlockedIds.contains(achievement.id)) {
          continue;
        }

        // Check if criteria is met
        final isMet = await _evaluateCriteria(
          criteria: achievement.criteria,
          progress: progress,
        );

        if (isMet) {
          _logger.info('Achievement criteria met: ${achievement.id}');

          // Unlock achievement
          await _achievementRepository.unlockAchievement(
            userId: userId,
            achievementId: achievement.id,
            courseId: courseId,
          );

          // Award points
          await _awardAchievementPoints(
            userId: userId,
            courseId: courseId,
            points: achievement.pointsReward,
          );

          newlyUnlocked.add(achievement);

          _logger.info(
            'Achievement unlocked: ${achievement.title} (+${achievement.pointsReward} pts)',
          );
        }
      }

      _logger.info('Unlocked ${newlyUnlocked.length} new achievements');

      return newlyUnlocked;
    } catch (e, stackTrace) {
      _logger.severe('Error checking and awarding achievements', e, stackTrace);
      rethrow;
    }
  }

  /// Check specific achievement
  ///
  /// Useful for testing or manual checks
  Future<bool> checkSpecificAchievement({
    required String userId,
    required String courseId,
    required String achievementId,
  }) async {
    try {
      // Check if already unlocked
      final isUnlocked = await _achievementRepository.isAchievementUnlocked(
        userId,
        achievementId,
      );

      if (isUnlocked) {
        _logger.fine('Achievement already unlocked: $achievementId');
        return false;
      }

      // Get achievement
      final achievement = await _achievementRepository.getAchievement(
        achievementId,
      );

      if (achievement == null) {
        _logger.warning('Achievement not found: $achievementId');
        return false;
      }

      // Get user progress
      final progress = await _gamificationRepository.getUserProgress(
        userId,
        courseId,
      );

      if (progress == null) {
        return false;
      }

      // Check criteria
      final isMet = await _evaluateCriteria(
        criteria: achievement.criteria,
        progress: progress,
      );

      if (isMet) {
        // Unlock achievement
        await _achievementRepository.unlockAchievement(
          userId: userId,
          achievementId: achievement.id,
          courseId: courseId,
        );

        // Award points
        await _awardAchievementPoints(
          userId: userId,
          courseId: courseId,
          points: achievement.pointsReward,
        );

        _logger.info('Achievement unlocked: ${achievement.title}');
        return true;
      }

      return false;
    } catch (e, stackTrace) {
      _logger.severe('Error checking specific achievement', e, stackTrace);
      rethrow;
    }
  }

  // ==================== Criteria Evaluation ====================

  /// تقييم معايير الإنجاز
  ///
  /// Checks if user progress meets achievement criteria
  Future<bool> _evaluateCriteria({
    required AchievementCriteria criteria,
    required UserCourseProgress progress,
  }) async {
    try {
      switch (criteria.type) {
        case 'module_completion':
          return _checkModuleCompletion(criteria, progress);

        case 'quiz_completion':
          return _checkQuizCompletion(criteria, progress);

        case 'quiz_perfect_score':
          return _checkQuizPerfectScore(criteria, progress);

        case 'streak_days':
          return _checkStreakDays(criteria, progress);

        case 'level_reached':
          return _checkLevelReached(criteria, progress);

        case 'total_points':
          return _checkTotalPoints(criteria, progress);

        case 'social_interactions':
          return _checkSocialInteractions(criteria, progress);

        case 'helpful_count':
          return _checkHelpfulCount(criteria, progress);

        case 'leaderboard_rank':
          return await _checkLeaderboardRank(criteria, progress);

        default:
          _logger.warning('Unknown criteria type: ${criteria.type}');
          return false;
      }
    } catch (e, stackTrace) {
      _logger.severe('Error evaluating criteria', e, stackTrace);
      return false;
    }
  }

  // ==================== Criteria Checkers ====================

  bool _checkModuleCompletion(
    AchievementCriteria criteria,
    UserCourseProgress progress,
  ) {
    // Check activityCounts for completed lessons/modules
    final completedLessons = progress.activityCounts['completing_lesson'] ?? 0;
    final completedModules = progress.activityCounts['completing_module'] ?? 0;
    final total = completedLessons + completedModules;
    return total >= criteria.targetValue;
  }

  bool _checkQuizCompletion(
    AchievementCriteria criteria,
    UserCourseProgress progress,
  ) {
    final passedQuizzes = progress.activityCounts['passing_quiz'] ?? 0;
    return passedQuizzes >= criteria.targetValue;
  }

  bool _checkQuizPerfectScore(
    AchievementCriteria criteria,
    UserCourseProgress progress,
  ) {
    // Check if user has any perfect quiz badge
    final perfectQuizzes = progress.activityCounts['perfect_quiz'] ?? 0;
    return perfectQuizzes >= criteria.targetValue;
  }

  bool _checkStreakDays(
    AchievementCriteria criteria,
    UserCourseProgress progress,
  ) {
    final currentStreak = progress.dailyStreakCount;
    return currentStreak >= criteria.targetValue;
  }

  bool _checkLevelReached(
    AchievementCriteria criteria,
    UserCourseProgress progress,
  ) {
    final currentLevel = progress.currentLevel;
    return currentLevel >= criteria.targetValue;
  }

  bool _checkTotalPoints(
    AchievementCriteria criteria,
    UserCourseProgress progress,
  ) {
    final totalPoints = progress.totalPoints;
    return totalPoints >= criteria.targetValue;
  }

  bool _checkSocialInteractions(
    AchievementCriteria criteria,
    UserCourseProgress progress,
  ) {
    // Check activityCounts for social interactions
    final interactions = progress.activityCounts['social_interaction'] ?? 0;
    return interactions >= criteria.targetValue;
  }

  bool _checkHelpfulCount(
    AchievementCriteria criteria,
    UserCourseProgress progress,
  ) {
    // Check activityCounts for helpful reactions
    final helpfulCount = progress.activityCounts['helpful_reaction'] ?? 0;
    return helpfulCount >= criteria.targetValue;
  }

  Future<bool> _checkLeaderboardRank(
    AchievementCriteria criteria,
    UserCourseProgress progress,
  ) async {
    // This requires checking leaderboard - implement if needed
    // For now, return false
    _logger.fine('Leaderboard rank check not implemented yet');
    return false;
  }

  // ==================== Award Points ====================

  /// Award points for achievement unlock
  Future<void> _awardAchievementPoints({
    required String userId,
    required String courseId,
    required int points,
  }) async {
    try {
      _logger.info('Awarding $points points to user: $userId');

      // Get current progress
      final progress = await _gamificationRepository.getUserProgress(
        userId,
        courseId,
      );

      if (progress == null) {
        _logger.warning('Cannot award points: No progress found');
        return;
      }

      // Update total points
      final updatedProgress = progress.copyWith(
        totalPoints: progress.totalPoints + points,
        lastActivityAt: DateTime.now(),
      );

      // Save updated progress
      await _gamificationRepository.updateUserProgress(updatedProgress);

      // Log transaction
      final transaction = PointsTransaction.create(
        userId: userId,
        courseId: courseId,
        points: points,
        activityType: 'achievement',
        activityName: 'Achievement Unlocked',
      );
      
      await _gamificationRepository.addPointsTransaction(transaction);
    } catch (e, stackTrace) {
      _logger.severe('Error awarding achievement points', e, stackTrace);
      // Don't rethrow - achievement is already unlocked
    }
  }

  // ==================== Notifications ====================

  /// Get newly unlocked achievements (unviewed)
  Future<List<UserAchievement>> getUnviewedAchievements({
    required String userId,
    required String courseId,
  }) async {
    try {
      final allUserAchievements = await _achievementRepository
          .streamUserAchievements(userId, courseId)
          .first;

      return allUserAchievements
          .where((ua) => !ua.isViewed)
          .toList();
    } catch (e, stackTrace) {
      _logger.severe('Error getting unviewed achievements', e, stackTrace);
      rethrow;
    }
  }

  /// Get achievement details for display
  Future<List<AchievementWithDetails>> getAchievementsWithDetails({
    required String userId,
    required String courseId,
  }) async {
    try {
      // Get all course achievements
      final allAchievements = await _achievementRepository
          .streamCourseAchievements(courseId)
          .first;

      // Get unlocked achievements
      final unlockedAchievements = await _achievementRepository
          .streamUserAchievements(userId, courseId)
          .first;

      // Create map of unlocked achievements
      final unlockedMap = <String, UserAchievement>{};
      for (final ua in unlockedAchievements) {
        unlockedMap[ua.achievementId] = ua;
      }

      // Combine data
      final result = <AchievementWithDetails>[];
      for (final achievement in allAchievements) {
        final userAchievement = unlockedMap[achievement.id];
        result.add(
          AchievementWithDetails(
            achievement: achievement,
            userAchievement: userAchievement,
            isUnlocked: userAchievement != null,
          ),
        );
      }

      return result;
    } catch (e, stackTrace) {
      _logger.severe('Error getting achievements with details', e, stackTrace);
      rethrow;
    }
  }
}

/// Achievement with unlock status
class AchievementWithDetails {
  final Achievement achievement;
  final UserAchievement? userAchievement;
  final bool isUnlocked;

  AchievementWithDetails({
    required this.achievement,
    required this.userAchievement,
    required this.isUnlocked,
  });
}
