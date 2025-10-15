import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

import '../../models/gamification/achievement.dart';

/// Repository لإدارة الإنجازات (Achievements)
///
/// يوفر:
/// - CRUD operations للإنجازات
/// - Stream للإنجازات المتاحة
/// - Stream لإنجازات المستخدم
/// - Unlock achievement logic
/// - Progress tracking
class AchievementRepository {
  final FirebaseFirestore _firestore;
  final Logger _logger = Logger('AchievementRepository');

  AchievementRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  // ==================== Collections ====================

  CollectionReference<Map<String, dynamic>> get _achievementsCollection =>
      _firestore.collection('achievements');

  CollectionReference<Map<String, dynamic>> get _userAchievementsCollection =>
      _firestore.collection('user_achievements');

  // ==================== Course Achievements ====================

  /// Stream جميع إنجازات الكورس
  ///
  /// يجلب جميع الإنجازات المتاحة للكورس (من PredefinedAchievements)
  Stream<List<Achievement>> streamCourseAchievements(String courseId) {
    try {
      _logger.info('Streaming course achievements for course: $courseId');

      return _achievementsCollection
          .where('courseId', isEqualTo: courseId)
          .orderBy('category')
          .orderBy('pointsReward', descending: true)
          .snapshots()
          .map((snapshot) {
        final achievements = snapshot.docs
            .map((doc) {
              try {
                return Achievement.fromJson({
                  'id': doc.id,
                  ...doc.data(),
                });
              } catch (e) {
                _logger.warning('Error parsing achievement ${doc.id}: $e');
                return null;
              }
            })
            .whereType<Achievement>()
            .toList();

        _logger.fine('Loaded ${achievements.length} course achievements');
        return achievements;
      });
    } catch (e, stackTrace) {
      _logger.severe('Error streaming course achievements', e, stackTrace);
      rethrow;
    }
  }

  /// Get achievement by ID
  Future<Achievement?> getAchievement(String achievementId) async {
    try {
      _logger.fine('Getting achievement: $achievementId');

      final doc = await _achievementsCollection.doc(achievementId).get();

      if (!doc.exists) {
        _logger.warning('Achievement not found: $achievementId');
        return null;
      }

      return Achievement.fromJson({
        'id': doc.id,
        ...doc.data()!,
      });
    } catch (e, stackTrace) {
      _logger.severe('Error getting achievement', e, stackTrace);
      rethrow;
    }
  }

  // ==================== User Achievements ====================

  /// Stream إنجازات المستخدم في كورس معين
  ///
  /// يجلب جميع الإنجازات المفتوحة للمستخدم
  Stream<List<UserAchievement>> streamUserAchievements(
    String userId,
    String courseId,
  ) {
    try {
      _logger.info(
        'Streaming user achievements for user: $userId, course: $courseId',
      );

      return _userAchievementsCollection
          .where('userId', isEqualTo: userId)
          .where('courseId', isEqualTo: courseId)
          .orderBy('unlockedAt', descending: true)
          .snapshots()
          .map((snapshot) {
        final userAchievements = snapshot.docs
            .map((doc) {
              try {
                return UserAchievement.fromJson({
                  'id': doc.id,
                  ...doc.data(),
                });
              } catch (e) {
                _logger.warning(
                  'Error parsing user achievement ${doc.id}: $e',
                );
                return null;
              }
            })
            .whereType<UserAchievement>()
            .toList();

        _logger.fine('Loaded ${userAchievements.length} user achievements');
        return userAchievements;
      });
    } catch (e, stackTrace) {
      _logger.severe('Error streaming user achievements', e, stackTrace);
      rethrow;
    }
  }

  /// Check if achievement is unlocked
  Future<bool> isAchievementUnlocked(
    String userId,
    String achievementId,
  ) async {
    try {
      final snapshot = await _userAchievementsCollection
          .where('userId', isEqualTo: userId)
          .where('achievementId', isEqualTo: achievementId)
          .limit(1)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e, stackTrace) {
      _logger.severe('Error checking if achievement is unlocked', e, stackTrace);
      rethrow;
    }
  }

  /// Get user achievement progress
  ///
  /// Returns null if achievement not unlocked yet
  Future<UserAchievement?> getUserAchievementProgress(
    String userId,
    String achievementId,
  ) async {
    try {
      final snapshot = await _userAchievementsCollection
          .where('userId', isEqualTo: userId)
          .where('achievementId', isEqualTo: achievementId)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      return UserAchievement.fromJson({
        'id': snapshot.docs.first.id,
        ...snapshot.docs.first.data(),
      });
    } catch (e, stackTrace) {
      _logger.severe(
        'Error getting user achievement progress',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  /// Get unviewed achievements count
  Future<int> getUnviewedAchievementsCount(
    String userId,
    String courseId,
  ) async {
    try {
      final snapshot = await _userAchievementsCollection
          .where('userId', isEqualTo: userId)
          .where('courseId', isEqualTo: courseId)
          .where('isViewed', isEqualTo: false)
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e, stackTrace) {
      _logger.severe(
        'Error getting unviewed achievements count',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  // ==================== Unlock Achievement ====================

  /// Unlock achievement for user
  ///
  /// يفتح الإنجاز للمستخدم ويسجله في Firestore
  Future<UserAchievement> unlockAchievement({
    required String userId,
    required String achievementId,
    required String courseId,
    int? currentProgress,
  }) async {
    try {
      _logger.info(
        'Unlocking achievement: $achievementId for user: $userId',
      );

      // Check if already unlocked
      final isUnlocked = await isAchievementUnlocked(userId, achievementId);
      if (isUnlocked) {
        _logger.warning('Achievement already unlocked: $achievementId');
        final existing = await getUserAchievementProgress(userId, achievementId);
        return existing!;
      }

      // Create user achievement
      final userAchievement = UserAchievement(
        achievementId: achievementId,
        userId: userId,
        courseId: courseId,
        unlockedAt: DateTime.now(),
        isViewed: false,
        currentProgress: currentProgress ?? 0,
      );

      // Save to Firestore
      final docRef = await _userAchievementsCollection.add(
        userAchievement.toJson(),
      );

      _logger.info('Achievement unlocked successfully: ${docRef.id}');

      return userAchievement;
    } catch (e, stackTrace) {
      _logger.severe('Error unlocking achievement', e, stackTrace);
      rethrow;
    }
  }

  /// Mark achievement as viewed
  Future<void> markAchievementAsViewed(String userAchievementId) async {
    try {
      await _userAchievementsCollection.doc(userAchievementId).update({
        'isViewed': true,
      });

      _logger.fine('Achievement marked as viewed: $userAchievementId');
    } catch (e, stackTrace) {
      _logger.severe('Error marking achievement as viewed', e, stackTrace);
      rethrow;
    }
  }

  /// Mark all achievements as viewed
  Future<void> markAllAchievementsAsViewed(
    String userId,
    String courseId,
  ) async {
    try {
      final snapshot = await _userAchievementsCollection
          .where('userId', isEqualTo: userId)
          .where('courseId', isEqualTo: courseId)
          .where('isViewed', isEqualTo: false)
          .get();

      // Batch update
      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.update(doc.reference, {'isViewed': true});
      }

      await batch.commit();

      _logger.info('Marked ${snapshot.docs.length} achievements as viewed');
    } catch (e, stackTrace) {
      _logger.severe('Error marking all achievements as viewed', e, stackTrace);
      rethrow;
    }
  }

  // ==================== Initialize Predefined Achievements ====================

  /// Initialize predefined achievements for a course
  ///
  /// يستخدم لتهيئة الإنجازات المعرّفة مسبقاً لكورس جديد
  /// يجب استدعاؤه مرة واحدة فقط عند إنشاء الكورس
  Future<void> initializePredefinedAchievements(String courseId) async {
    try {
      _logger.info('Initializing predefined achievements for course: $courseId');

      // Check if already initialized
      final existing = await _achievementsCollection
          .where('courseId', isEqualTo: courseId)
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        _logger.warning('Achievements already initialized for course: $courseId');
        return;
      }

      // Get all predefined achievements
      final predefinedAchievements = PredefinedAchievements.all;

      // Batch write
      final batch = _firestore.batch();

      for (final achievement in predefinedAchievements) {
        // Add courseId to achievement
        final achievementWithCourse = Achievement(
          id: achievement.id,
          title: achievement.title,
          description: achievement.description,
          iconUrl: achievement.iconUrl,
          category: achievement.category,
          criteria: achievement.criteria,
          pointsReward: achievement.pointsReward,
          isSecret: achievement.isSecret,
          courseId: courseId,
        );

        final docRef = _achievementsCollection.doc(achievement.id);
        batch.set(docRef, achievementWithCourse.toJson());
      }

      await batch.commit();

      _logger.info(
        'Initialized ${predefinedAchievements.length} achievements for course: $courseId',
      );
    } catch (e, stackTrace) {
      _logger.severe('Error initializing predefined achievements', e, stackTrace);
      rethrow;
    }
  }

  // ==================== Delete Operations ====================

  /// Delete all achievements for a course
  ///
  /// ⚠️ Use with caution - deletes all achievements and user achievements
  Future<void> deleteAllCourseAchievements(String courseId) async {
    try {
      _logger.warning('Deleting all achievements for course: $courseId');

      // Delete achievements
      final achievementsSnapshot = await _achievementsCollection
          .where('courseId', isEqualTo: courseId)
          .get();

      final batch1 = _firestore.batch();
      for (final doc in achievementsSnapshot.docs) {
        batch1.delete(doc.reference);
      }
      await batch1.commit();

      // Delete user achievements
      final userAchievementsSnapshot = await _userAchievementsCollection
          .where('courseId', isEqualTo: courseId)
          .get();

      final batch2 = _firestore.batch();
      for (final doc in userAchievementsSnapshot.docs) {
        batch2.delete(doc.reference);
      }
      await batch2.commit();

      _logger.warning(
        'Deleted ${achievementsSnapshot.docs.length} achievements and '
        '${userAchievementsSnapshot.docs.length} user achievements',
      );
    } catch (e, stackTrace) {
      _logger.severe('Error deleting course achievements', e, stackTrace);
      rethrow;
    }
  }
}
