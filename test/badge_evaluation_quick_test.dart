import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/providers/gamification_providers.dart';
import 'package:training_app/repositories/points_repository.dart';

// Fake repository extending real PointsRepository but operating on injected FakeFirebaseFirestore
class _TestPointsRepo extends PointsRepository {
  _TestPointsRepo(FirebaseFirestore fs) : super(firestore: fs);
}

void main() {
  group('BadgeEvaluationService', () {
    test('auto-awards badge when points threshold reached', () async {
      final fs = FakeFirebaseFirestore();
      // Seed user points doc
      await fs.collection('user_points').doc('u1').set({
        'points': 0,
        'badges': [],
        'dailyStreak': 0,
        'quizzesPassed': 0,
        'tasksCompleted': 0,
        'lessonsCompleted': 0,
      });
      // Active auto-award badge requiring 100 points
      await fs.collection('badges').doc('b1').set({
        'name': 'Centurion',
        'description': 'Reach 100 points',
        'iconUrl': 'https://example/icon.png',
        'active': true,
        'autoAward': true,
        'criteria': {'pointsGte': 100},
      });
      final repo = _TestPointsRepo(fs);
      final service = BadgeEvaluationService(repo, firestore: fs);

      // Not yet
      await service.evaluateAndAward('u1');
      var up = await repo.getUserPoints('u1');
      expect(up!.badges.contains('b1'), false);

      // Add 90 (below threshold)
      await repo.addPoints('u1', 90);
      await service.evaluateAndAward('u1');
      up = await repo.getUserPoints('u1');
      expect(up!.badges.contains('b1'), false);

      // Add 20 more (total 110)
      await repo.addPoints('u1', 20);
      await service.evaluateAndAward('u1');
      up = await repo.getUserPoints('u1');
      expect(up!.badges.contains('b1'), true);

      // Re-evaluate (idempotent – no duplicate)
      await service.evaluateAndAward('u1');
      final up2 = await repo.getUserPoints('u1');
      expect(up2!.badges.where((id) => id == 'b1').length, 1);
    });
  });
}
