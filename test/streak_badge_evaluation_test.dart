import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:training_app/repositories/points_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/providers/gamification_providers.dart';

void main() {
  group('Streak badge evaluation', () {
    test('awards streak badges at 3,7,14,30 days', () async {
      final fake = FakeFirebaseFirestore();
      final repo = PointsRepository(firestore: fake);
      final service = BadgeEvaluationService(repo, firestore: fake);
      const userId = 'u1';
      await fake.collection('user_points').doc(userId).set({
        'points': 0,
        'badges': [],
        'dailyStreak': 0,
      });

      Future<void> setStreak(int v) async {
        await fake.collection('user_points').doc(userId).set({
          'dailyStreak': v,
        }, SetOptions(merge: true));
      }

      Future<List<String>> currentBadges() async {
        final doc = await fake.collection('user_points').doc(userId).get();
        return List<String>.from(doc.data()!['badges'] ?? []);
      }

      Future<void> eval() => service.evaluateAndAward(userId);

      await setStreak(2); // below first threshold
      await eval();
      expect(await currentBadges(), isEmpty);

      await setStreak(3);
      await eval();
      expect(await currentBadges(), contains('streak_3'));

      await setStreak(7);
      await eval();
      final b2 = await currentBadges();
      expect(b2, containsAll(['streak_3', 'streak_7']));

      await setStreak(14);
      await eval();
      final b3 = await currentBadges();
      expect(b3, containsAll(['streak_3', 'streak_7', 'streak_14']));

      await setStreak(30);
      await eval();
      final b4 = await currentBadges();
      expect(
        b4,
        containsAll(['streak_3', 'streak_7', 'streak_14', 'streak_30']),
      );
    });
  });
}
