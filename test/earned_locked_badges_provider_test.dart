import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/gamification_providers.dart';
import 'package:training_app/repositories/points_repository.dart';

void main() {
  test('earnedLockedBadgesProvider splits earned and locked', () async {
    final fake = FakeFirebaseFirestore();
    // seed badges collection
    final badges = [
      {
        'id': 'points_100',
        'name': '100 Points',
        'description': 'Reach 100 points',
      },
      {
        'id': 'streak_3',
        'name': '3 Day Streak',
        'description': 'Maintain 3-day streak',
      },
      {
        'id': 'streak_7',
        'name': '7 Day Streak',
        'description': 'Maintain 7-day streak',
      },
    ];
    for (final b in badges) {
      await fake.collection('badges').doc(b['id']!).set({
        'name': b['name'],
        'description': b['description'],
        'iconUrl': '',
      });
    }
    await fake.collection('user_points').doc('u1').set({
      'points': 150,
      'badges': ['points_100', 'streak_3'],
      'dailyStreak': 4,
    });

    final container = ProviderContainer(
      overrides: [
        pointsRepositoryProvider.overrideWithValue(
          PointsRepository(firestore: fake),
        ),
        firebaseFirestoreProvider.overrideWithValue(fake),
      ],
    );

    // The provider is now synchronous (Provider) built atop a badges stream provider.
    // Pump a short delay to allow the stream to emit first snapshot.
    await Future<void>.delayed(const Duration(milliseconds: 10));
    final tuple = container.read(earnedLockedBadgesProvider('u1'));
    final earned = tuple.$1.map((b) => b.id).toSet();
    final locked = tuple.$2.map((b) => b.id).toSet();

    expect(earned, containsAll(['points_100', 'streak_3']));
    expect(locked, contains('streak_7'));
  });
}
