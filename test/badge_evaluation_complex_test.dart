import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/providers/gamification_providers.dart';
import 'package:training_app/repositories/points_repository.dart';

class _TestPointsRepo extends PointsRepository {
  _TestPointsRepo(FirebaseFirestore fs) : super(firestore: fs);
}

void main() {
  group('BadgeEvaluationService complex criteria', () {
    test('requires multiple counters (points + streak + tasks)', () async {
      final fs = FakeFirebaseFirestore();
      await fs.collection('user_points').doc('u1').set({
        'points': 0,
        'badges': [],
        'dailyStreak': 0,
        'quizzesPassed': 0,
        'tasksCompleted': 0,
        'lessonsCompleted': 0,
      });
      await fs.collection('badges').doc('multi1').set({
        'name': 'All-Rounder',
        'description': 'Points>=150 & Streak>=3 & Tasks>=5',
        'iconUrl': '',
        'active': true,
        'autoAward': true,
        'criteria': {
          'pointsGte': 150,
          'dailyStreakGte': 3,
          'tasksCompletedGte': 5,
        },
      });
      final repo = _TestPointsRepo(fs);
      final service = BadgeEvaluationService(repo, firestore: fs);

      // Progressively satisfy criteria
      await repo.addPoints('u1', 150); // points ok
      await fs.collection('user_points').doc('u1').set({
        'dailyStreak': 2,
      }, SetOptions(merge: true));
      await fs.collection('user_points').doc('u1').set({
        'tasksCompleted': 4,
      }, SetOptions(merge: true));
      await service.evaluateAndAward('u1');
      var up = await repo.getUserPoints('u1');
      expect(
        up!.badges.contains('multi1'),
        false,
        reason: 'streak & tasks not fully met',
      );

      // Complete streak criteria only
      await fs.collection('user_points').doc('u1').set({
        'dailyStreak': 3,
      }, SetOptions(merge: true));
      await service.evaluateAndAward('u1');
      up = await repo.getUserPoints('u1');
      expect(
        up!.badges.contains('multi1'),
        false,
        reason: 'tasks still insufficient',
      );

      // Complete tasks criteria
      await fs.collection('user_points').doc('u1').set({
        'tasksCompleted': 5,
      }, SetOptions(merge: true));
      await service.evaluateAndAward('u1');
      up = await repo.getUserPoints('u1');
      expect(up!.badges.contains('multi1'), true);
    });
  });
}
