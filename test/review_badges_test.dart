import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:training_app/repositories/points_repository.dart';
import 'package:training_app/providers/gamification_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  test(
    'awards first_review and reviews_10 badges based on written reviews count',
    () async {
      final fake = FakeFirebaseFirestore();
      final repo = PointsRepository(firestore: fake);
      final service = BadgeEvaluationService(
        repo,
        firestore: fake as FirebaseFirestore,
      );
      const userId = 'revUser';
      await fake.collection('user_points').doc(userId).set({
        'points': 0,
        'badges': [],
        'dailyStreak': 0,
      });

      Future<void> addReview(int i) async {
        await fake.collection('user_reviews').add({
          'reviewerId': userId,
          'targetId': 't$i',
          'rating': 4.5,
          'comment': 'c$i',
          'date': DateTime.now(),
        });
      }

      // No reviews yet
      await service.evaluateAndAward(userId);
      var doc = await fake.collection('user_points').doc(userId).get();
      expect(List<String>.from(doc.data()!['badges'] ?? []), isEmpty);

      // First review
      await addReview(1);
      await service.evaluateAndAward(userId);
      doc = await fake.collection('user_points').doc(userId).get();
      expect(
        List<String>.from(doc.data()!['badges']),
        contains('first_review'),
      );

      // Add up to 10
      for (int i = 2; i <= 10; i++) {
        await addReview(i);
      }
      await service.evaluateAndAward(userId);
      doc = await fake.collection('user_points').doc(userId).get();
      final badges = List<String>.from(doc.data()!['badges']);
      expect(badges, containsAll(['first_review', 'reviews_10']));
    },
  );
}
