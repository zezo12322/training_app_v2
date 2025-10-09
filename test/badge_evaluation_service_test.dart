import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:training_app/repositories/points_repository.dart';
import 'package:training_app/providers/gamification_providers.dart';

void main() {
  group('BadgeEvaluationService', () {
    test('awards single threshold badge when crossing 100 points', () async {
      final fake = FakeFirebaseFirestore();
      // seed user points 95 then simulate +10 and evaluate
      await fake.collection('user_points').doc('u1').set({
        'points': 105,
        'badges': [],
      });
      final repo = PointsRepository(firestore: fake);
      final service = BadgeEvaluationService(repo, firestore: fake);
      await service.evaluateAndAward('u1');
      final doc = await fake.collection('user_points').doc('u1').get();
      final badges = List<String>.from(doc.data()!['badges'] ?? []);
      expect(badges.contains('points_100'), isTrue);
      expect(badges.length, 1);
    });

    test(
      'awards multiple badges when jumping directly to high score',
      () async {
        final fake = FakeFirebaseFirestore();
        await fake.collection('user_points').doc('u2').set({
          'points': 1200,
          'badges': [],
        });
        final repo = PointsRepository(firestore: fake);
        final service = BadgeEvaluationService(repo, firestore: fake);
        await service.evaluateAndAward('u2');
        final doc = await fake.collection('user_points').doc('u2').get();
        final badges = List<String>.from(doc.data()!['badges'] ?? []);
        expect(
          badges.toSet(),
          containsAll({'points_100', 'points_500', 'points_1000'}),
        );
      },
    );
  });
}
