import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/super_admin_providers.dart';
import 'package:training_app/models/user_model.dart';

// Minimal fake to inject user stream via overrides would normally mock Firestore.
// Here we validate that provider logic counting roles works in isolation using a manual container override.

void main() {
  test('globalStatsProvider counts trainer/trainee', () async {
    final container = ProviderContainer(
      overrides: [
        superAdminUsersProvider.overrideWith((ref) async* {
          yield [
            AppUser(id: '1', name: 'A', email: 'a@x', role: 'trainer'),
            AppUser(id: '2', name: 'B', email: 'b@x', role: 'trainee'),
            AppUser(id: '3', name: 'C', email: 'c@x', role: 'trainee'),
          ];
        }),
      ],
    );
    addTearDown(container.dispose);
    // need to first listen to populate
    await container.read(superAdminUsersProvider.future);
    final stats = container.read(globalStatsProvider);
    expect(stats?.totalUsers, 3);
    expect(stats?.trainers, 1);
    expect(stats?.trainees, 2);
  });
}
