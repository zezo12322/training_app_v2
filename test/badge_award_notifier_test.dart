import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/gamification_providers.dart';
import 'package:training_app/repositories/points_repository.dart';

void main() {
  group('BadgeAwardNotifier', () {
    test('emits new badge ids when new badge appears', () async {
      final fake = FakeFirebaseFirestore();
      // seed user points document
      await fake.collection('user_points').doc('u1').set({
        'points': 0,
        'badges': [],
      });
      final container = ProviderContainer(
        overrides: [
          pointsRepositoryProvider.overrideWithValue(
            PointsRepository(firestore: fake),
          ),
          firebaseFirestoreProvider.overrideWithValue(fake),
        ],
      );

      final notifier = container.read(badgeAwardEventsProvider('u1').notifier);
      expect(container.read(badgeAwardEventsProvider('u1')), isEmpty);

      // simulate adding badge in Firestore
      await fake.collection('user_points').doc('u1').update({
        'badges': ['b1'],
      });
      // poll up to 200ms
      List<String> events = const [];
      for (int i = 0; i < 20; i++) {
        await Future.delayed(const Duration(milliseconds: 10));
        events = container.read(badgeAwardEventsProvider('u1'));
        if (events.contains('b1')) break;
      }
      expect(events, contains('b1'));

      notifier.consume('b1');
      expect(container.read(badgeAwardEventsProvider('u1')), isEmpty);
    });
  });
}
