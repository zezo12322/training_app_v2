import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/providers/gamification_providers.dart';

void main() {
  test('badgeAwardsHistoryProvider emits ordered history', () async {
    final fake = FakeFirebaseFirestore();
    final userRef = fake.collection('user_points').doc('u1');
    await userRef.set({'points': 0, 'badges': []});

    // Manually create subcollection entries with incremental timestamps
    final now = DateTime.now();
    await userRef.collection('badge_awards').doc('b1').set({
      'awardedAt': Timestamp.fromDate(now.subtract(const Duration(minutes: 2))),
    });
    await userRef.collection('badge_awards').doc('b2').set({
      'awardedAt': Timestamp.fromDate(now.subtract(const Duration(minutes: 1))),
    });

    final container = ProviderContainer(
      overrides: [firebaseFirestoreProvider.overrideWithValue(fake)],
    );

    final completer =
        Completer<
          List<dynamic>
        >(); // underlying provider returns a list of model instances
    late ProviderSubscription sub;
    sub = container.listen(badgeAwardsHistoryProvider('u1'), (prev, next) {
      next.when(
        data: (items) {
          if (items.length == 2 && !completer.isCompleted) {
            completer.complete(items);
            sub.close();
          }
        },
        loading: () {},
        error: (_, __) {},
      );
    });
    final history = await completer.future;

    expect(history[0].badgeId, 'b1');
    expect(history[1].badgeId, 'b2');
    expect(history[0].awardedAt!.isBefore(history[1].awardedAt!), isTrue);
  });
}
