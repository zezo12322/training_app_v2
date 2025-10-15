import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/models/gamification/activity_points.dart';
import 'package:training_app/models/gamification/gamification_settings.dart';
import 'package:training_app/models/gamification/user_course_progress.dart';
import 'package:training_app/models/gamification/learning_module.dart';
import 'package:training_app/models/gamification/points_transaction.dart';

void main() {
  group('Gamification Models Tests', () {
    
    test('ActivityPoints - default settings', () {
      final points = ActivityPoints.defaultSettings();
      
      expect(points.completingLesson, 10);
      expect(points.passingQuiz, 20);
      expect(points.perfectQuizScore, 50);
      expect(points.enableSocialPoints, false);
      expect(points.enableDailyStreak, false);
    });
    
    test('ActivityPoints - custom settings', () {
      final points = ActivityPoints(
        completingLesson: 15,
        passingQuiz: 30,
        enableSocialPoints: true,
      );
      
      expect(points.completingLesson, 15);
      expect(points.passingQuiz, 30);
      expect(points.enableSocialPoints, true);
    });
    
    test('GamificationSettings - default settings', () {
      final settings = GamificationSettings.defaultSettings();
      
      expect(settings.isEnabled, true);
      expect(settings.levelThresholds.length, 10);
      expect(settings.levelThresholds[1], 0);
      expect(settings.levelThresholds[2], 100);
      expect(settings.levelThresholds[10], 11000);
      expect(settings.activityPoints.completingLesson, 10);
    });
    
    test('UserCourseProgress - create new', () {
      final progress = UserCourseProgress.create(
        userId: 'user123',
        courseId: 'course456',
      );
      
      expect(progress.userId, 'user123');
      expect(progress.courseId, 'course456');
      expect(progress.totalPoints, 0);
      expect(progress.currentLevel, 1);
      expect(progress.pointsToNextLevel, 100);
      expect(progress.dailyStreakCount, 0);
      expect(progress.earnedBadges.isEmpty, true);
    });
    
    test('PointsTransaction - create new', () {
      final transaction = PointsTransaction.create(
        userId: 'user123',
        courseId: 'course456',
        points: 20,
        activityType: ActivityType.passingQuiz,
        activityName: 'اجتياز اختبار',
        metadata: {'quizId': 'quiz789', 'score': 85},
      );
      
      expect(transaction.userId, 'user123');
      expect(transaction.courseId, 'course456');
      expect(transaction.points, 20);
      expect(transaction.activityType, ActivityType.passingQuiz);
      expect(transaction.metadata['quizId'], 'quiz789');
      expect(transaction.metadata['score'], 85);
    });
    
    test('ActivityType - get activity name in Arabic', () {
      expect(
        ActivityType.getActivityName(ActivityType.completingLesson),
        'إتمام درس',
      );
      expect(
        ActivityType.getActivityName(ActivityType.passingQuiz),
        'اجتياز اختبار',
      );
      expect(
        ActivityType.getActivityName(ActivityType.dailyStreak),
        'دخول يومي',
      );
    });
    
    test('LearningModule - create with contents', () {
      final module = LearningModule(
        courseId: 'course123',
        title: 'الوحدة الأولى',
        description: 'مقدمة في البرمجة',
        orderIndex: 1,
        contents: [
          ModuleContent(
            id: 'lesson1',
            type: ModuleContentType.lesson,
            title: 'الدرس الأول',
            orderIndex: 1,
            isRequired: true,
          ),
          ModuleContent(
            id: 'quiz1',
            type: ModuleContentType.quiz,
            title: 'اختبار الوحدة',
            orderIndex: 2,
            isRequired: true,
          ),
        ],
        requirements: ModuleRequirements(
          completeLessons: true,
          passAllQuizzes: true,
          minimumQuizScore: 70,
        ),
        completionPoints: 100,
      );
      
      expect(module.title, 'الوحدة الأولى');
      expect(module.contents.length, 2);
      expect(module.contents[0].type, ModuleContentType.lesson);
      expect(module.contents[1].type, ModuleContentType.quiz);
      expect(module.requirements.minimumQuizScore, 70);
      expect(module.completionPoints, 100);
    });
    
    test('ModuleRequirements - default values', () {
      final requirements = ModuleRequirements();
      
      expect(requirements.completeLessons, true);
      expect(requirements.passAllQuizzes, true);
      expect(requirements.minimumQuizScore, 70);
      expect(requirements.completeAssignments, true);
    });
    
    test('ProgressStats - default values', () {
      final stats = ProgressStats();
      
      expect(stats.totalLessonsCompleted, 0);
      expect(stats.totalQuizzesPassed, 0);
      expect(stats.perfectQuizzes, 0);
      expect(stats.averageQuizScore, 0.0);
    });
  });
}
