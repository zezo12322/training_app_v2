import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:training_app/repositories/points_repository.dart';

void main() {
  group('PointsRepository.addBadge', () {
    test('creates subcollection timestamp on first award only', () async {
      final fake = FakeFirebaseFirestore();
      final repo = PointsRepository(firestore: fake);
      await fake.collection('user_points').doc('u').set({
        'points': 0,
        'badges': [],
      });

      await repo.addBadge('u', 'badge_x');
      await repo.addBadge('u', 'badge_x'); // second call should be idempotent

      final userDoc = await fake.collection('user_points').doc('u').get();
      final badges = List<String>.from(userDoc.data()!['badges']);
      expect(badges, ['badge_x']);
      final awardDoc = await fake
          .collection('user_points')
          .doc('u')
          .collection('badge_awards')
          .doc('badge_x')
          .get();
      expect(awardDoc.exists, isTrue);
    });
  });
}
