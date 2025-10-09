import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:training_app/repositories/points_repository.dart';
import 'package:training_app/providers/gamification_providers.dart';

void main() {
  test('awards reviews_25 and reviews_50 progressively', () async {
    final fake = FakeFirebaseFirestore();
    final repo = PointsRepository(firestore: fake);
    final service = BadgeEvaluationService(repo, firestore: fake);
    const userId = 'revUserX';
    await fake.collection('user_points').doc(userId).set({
      'points': 0,
      'badges': [],
      'dailyStreak': 0,
    });

    Future<void> addReview(int i) async {
      await fake.collection('user_reviews').add({
        'reviewerId': userId,
        'targetId': 't$i',
        'rating': 5,
        'comment': 'r$i',
        'date': DateTime.now(),
      });
    }

    for (int i = 1; i <= 25; i++) {
      await addReview(i);
    }
    await service.evaluateAndAward(userId);
    var badges = List<String>.from(
      (await fake.collection('user_points').doc(userId).get())
          .data()!['badges'],
    );
    expect(badges, containsAll(['first_review', 'reviews_10', 'reviews_25']));
    expect(badges.contains('reviews_50'), isFalse);

    for (int i = 26; i <= 50; i++) {
      await addReview(i);
    }
    await service.evaluateAndAward(userId);
    badges = List<String>.from(
      (await fake.collection('user_points').doc(userId).get())
          .data()!['badges'],
    );
    expect(
      badges,
      containsAll(['first_review', 'reviews_10', 'reviews_25', 'reviews_50']),
    );
  });
}
