import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/gamification_providers.dart';
import 'package:training_app/repositories/points_repository.dart';

void main() {
  test('consumeAll clears all pending badge award events', () async {
    final fake = FakeFirebaseFirestore();
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

    // add two badges
    await fake.collection('user_points').doc('u1').update({
      'badges': ['b1'],
    });
    await Future.delayed(const Duration(milliseconds: 30));
    await fake.collection('user_points').doc('u1').update({
      'badges': ['b1', 'b2'],
    });

    // wait until both appear
    List<String> events = const [];
    for (int i = 0; i < 30; i++) {
      await Future.delayed(const Duration(milliseconds: 10));
      events = container.read(badgeAwardEventsProvider('u1'));
      if (events.contains('b1') && events.contains('b2')) break;
    }
    expect(events, containsAll(['b1', 'b2']));

    notifier.consumeAll();
    expect(container.read(badgeAwardEventsProvider('u1')), isEmpty);
  });
}
