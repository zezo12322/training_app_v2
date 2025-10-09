import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/repositories/points_repository.dart';

void main() {
  group('Daily streak logic', () {
    test(
      'initial day creates streak=1 then consecutive day increments',
      () async {
        final fake = FakeFirebaseFirestore();
        final repo = PointsRepository(firestore: fake);
        final userId = 'u1';
        await fake.collection('user_points').doc(userId).set({
          'points': 0,
          'badges': [],
        });

        // Day 1
        final d1 = await repo.recordDailyActivity(userId);
        expect(d1, 1);

        // Same day repeat should not increment
        final sameDay = await repo.recordDailyActivity(userId);
        expect(sameDay, 1);

        // Simulate next day by adjusting stored timestamp backwards 1 day
        final docRef = fake.collection('user_points').doc(userId);
        final snap = await docRef.get();
        final data = snap.data()!;
        final ts =
            data['lastActiveDay']
                as Timestamp; // ignore: cast_nullable_to_non_nullable
        final prev = ts.toDate().subtract(const Duration(days: 1));
        await docRef.set({
          'lastActiveDay': Timestamp.fromDate(prev),
        }, SetOptions(merge: true));

        final d2 = await repo.recordDailyActivity(userId);
        expect(d2, 2);

        // Break streak (simulate gap of 2 days)
        final snap2 = await docRef.get();
        final ts2 = snap2.data()!['lastActiveDay'] as Timestamp;
        final prev2 = ts2.toDate().subtract(const Duration(days: 3));
        await docRef.set({
          'lastActiveDay': Timestamp.fromDate(prev2),
        }, SetOptions(merge: true));

        final reset = await repo.recordDailyActivity(userId);
        expect(reset, 1);
      },
    );
  });
}
