import '../../models/gamification/gamification_settings.dart';
import '../../models/gamification/user_course_progress.dart';
import '../../models/gamification/points_transaction.dart';
import '../../repositories/gamification/gamification_repository.dart';
import 'points_calculator.dart';
import 'level_system.dart';

/// الخدمة الرئيسية لنظام التقدم والنقاط
/// 
/// تدير منح النقاط، حساب المستويات، والشارات
class GamificationService {
  final GamificationRepository _repository;
  final PointsCalculator _pointsCalculator;
  final LevelSystem _levelSystem;

  GamificationService({
    required GamificationRepository repository,
    required PointsCalculator pointsCalculator,
    required LevelSystem levelSystem,
  })  : _repository = repository,
        _pointsCalculator = pointsCalculator,
        _levelSystem = levelSystem;

  /// منح نقاط للمستخدم عند إتمام نشاط
  /// 
  /// Returns: النقاط الممنوحة فعلياً (0 إذا كان النشاط معطل)
  Future<int> awardPoints({
    required String userId,
    required String courseId,
    required String activityType,
    required String activityName,
    Map<String, dynamic>? metadata,
  }) async {
    // الحصول على إعدادات الكورس
    final settings = await _repository.getSettings(courseId);
    if (settings == null || !settings.isEnabled) {
      return 0; // النظام معطل
    }

    // حساب النقاط بناءً على نوع النشاط
    final points = _pointsCalculator.calculatePoints(
      activityType: activityType,
      activityPoints: settings.activityPoints,
      metadata: metadata,
    );

    if (points == 0) {
      return 0; // النشاط معطل أو لا يمنح نقاط
    }

    // الحصول على تقدم المستخدم الحالي
    var progress = await _repository.getUserProgress(userId, courseId);
    if (progress == null) {
      progress = UserCourseProgress.create(
        userId: userId,
        courseId: courseId,
      );
    }

    // حساب النقاط والمستوى الجديد
    final newTotalPoints = progress.totalPoints + points;
    final levelUpdate = _levelSystem.calculateLevel(
      totalPoints: newTotalPoints,
      levelThresholds: settings.levelThresholds,
    );

    // تحديث عداد النشاط
    final activityCounts = Map<String, int>.from(progress.activityCounts);
    activityCounts[activityType] = (activityCounts[activityType] ?? 0) + 1;

    // إنشاء التقدم المحدث
    final updatedProgress = progress.copyWith(
      totalPoints: newTotalPoints,
      currentLevel: levelUpdate.level,
      pointsToNextLevel: levelUpdate.pointsToNext,
      activityCounts: activityCounts,
      lastActivityAt: DateTime.now(),
    );

    // حفظ التقدم والمعاملة
    await _repository.updateUserProgress(updatedProgress);
    
    final transaction = PointsTransaction.create(
      userId: userId,
      courseId: courseId,
      points: points,
      activityType: activityType,
      activityName: activityName,
      metadata: metadata,
    );
    await _repository.addPointsTransaction(transaction);

    // التحقق من ترقية المستوى
    if (levelUpdate.leveledUp) {
      await _handleLevelUp(
        userId: userId,
        courseId: courseId,
        newLevel: levelUpdate.level,
      );
    }

    return points;
  }

  /// التحقق من ترقية المستوى ومنح شارات
  Future<void> _handleLevelUp({
    required String userId,
    required String courseId,
    required int newLevel,
  }) async {
    // هنا يمكن:
    // 1. إرسال إشعار للمستخدم
    // 2. منح شارة إذا كان هناك شارة لهذا المستوى
    // 3. إضافة تأثيرات بصرية في الواجهة
    
    // TODO: سيتم تطويرها في مراحل قادمة
    print('🎉 تهانينا! وصلت للمستوى $newLevel');
  }

  /// تحديث إعدادات نقاط الكورس (للمدرب فقط)
  Future<void> updateSettings({
    required String courseId,
    required String trainerId,
    required GamificationSettings settings,
  }) async {
    final updatedSettings = settings.copyWith(
      lastUpdatedAt: DateTime.now(),
      lastUpdatedBy: trainerId,
    );
    
    await _repository.updateSettings(courseId, updatedSettings);
  }

  /// تفعيل/تعطيل نظام النقاط للكورس
  Future<void> toggleGamification({
    required String courseId,
    required bool enabled,
  }) async {
    final settings = await _repository.getSettings(courseId);
    if (settings == null) {
      // إنشاء إعدادات افتراضية
      final defaultSettings = GamificationSettings.defaultSettings().copyWith(
        isEnabled: enabled,
      );
      await _repository.updateSettings(courseId, defaultSettings);
    } else {
      final updatedSettings = settings.copyWith(isEnabled: enabled);
      await _repository.updateSettings(courseId, updatedSettings);
    }
  }

  /// الحصول على تقدم المستخدم في الكورس
  Future<UserCourseProgress?> getUserProgress(
    String userId,
    String courseId,
  ) async {
    return await _repository.getUserProgress(userId, courseId);
  }

  /// الحصول على سجل النقاط للمستخدم
  Stream<List<PointsTransaction>> getPointsHistory(
    String userId,
    String courseId, {
    int limit = 20,
  }) {
    return _repository.getPointsTransactions(
      userId: userId,
      courseId: courseId,
      limit: limit,
    );
  }

  /// الحصول على قائمة المتصدرين (Leaderboard)
  Future<List<UserCourseProgress>> getLeaderboard(
    String courseId, {
    int limit = 10,
  }) async {
    return await _repository.getTopUsers(courseId, limit: limit);
  }

  /// تحديث Daily Streak
  Future<void> checkAndUpdateDailyStreak(
    String userId,
    String courseId,
  ) async {
    final settings = await _repository.getSettings(courseId);
    if (settings == null || 
        !settings.isEnabled || 
        !settings.activityPoints.enableDailyStreak) {
      return; // Daily Streak معطل
    }

    final progress = await _repository.getUserProgress(userId, courseId);
    if (progress == null) return;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    if (progress.lastStreakCheckDate == null) {
      // أول مرة يدخل
      final updatedProgress = progress.copyWith(
        dailyStreakCount: 1,
        longestStreak: 1,
        lastStreakCheckDate: today,
      );
      await _repository.updateUserProgress(updatedProgress);
      
      // منح نقاط Daily Streak
      await awardPoints(
        userId: userId,
        courseId: courseId,
        activityType: ActivityType.dailyStreak,
        activityName: ActivityType.getActivityName(ActivityType.dailyStreak),
      );
      return;
    }

    final lastCheck = DateTime(
      progress.lastStreakCheckDate!.year,
      progress.lastStreakCheckDate!.month,
      progress.lastStreakCheckDate!.day,
    );

    final daysDifference = today.difference(lastCheck).inDays;

    if (daysDifference == 1) {
      // دخل في اليوم التالي - استمرار السلسلة
      final newStreak = progress.dailyStreakCount + 1;
      final updatedProgress = progress.copyWith(
        dailyStreakCount: newStreak,
        longestStreak: newStreak > progress.longestStreak 
            ? newStreak 
            : progress.longestStreak,
        lastStreakCheckDate: today,
      );
      await _repository.updateUserProgress(updatedProgress);
      
      await awardPoints(
        userId: userId,
        courseId: courseId,
        activityType: ActivityType.dailyStreak,
        activityName: ActivityType.getActivityName(ActivityType.dailyStreak),
        metadata: {'streak': newStreak},
      );
      
      // التحقق من Weekly Streak
      if (newStreak % 7 == 0) {
        await awardPoints(
          userId: userId,
          courseId: courseId,
          activityType: ActivityType.weeklyStreak,
          activityName: ActivityType.getActivityName(ActivityType.weeklyStreak),
          metadata: {'weeks': newStreak ~/ 7},
        );
      }
    } else if (daysDifference > 1) {
      // انقطعت السلسلة - إعادة البدء
      final updatedProgress = progress.copyWith(
        dailyStreakCount: 1,
        lastStreakCheckDate: today,
      );
      await _repository.updateUserProgress(updatedProgress);
      
      await awardPoints(
        userId: userId,
        courseId: courseId,
        activityType: ActivityType.dailyStreak,
        activityName: ActivityType.getActivityName(ActivityType.dailyStreak),
      );
    }
    // daysDifference == 0 means already checked today, do nothing
  }
}
