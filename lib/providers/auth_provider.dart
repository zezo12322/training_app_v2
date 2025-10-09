import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';
import '../models/user_model.dart';
import 'package:flutter/foundation.dart';

// Lazy trigger for user model fetch (to defer heavy Firestore call until after first frame if desired)
final _currentUserLoadTrigger = StateProvider<bool>((_) => false);

// Expose repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// Raw FirebaseAuth state stream
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

// Current user model (one-shot fetch). Will refetch when auth uid changes.
final currentUserModelProvider = FutureProvider<AppUser?>((ref) async {
  final trigger = ref.watch(_currentUserLoadTrigger);
  if (!trigger) return null; // not requested yet
  final authAsync = ref.watch(authStateProvider);
  final user = authAsync.value;
  if (user == null) return null;
  return ref.watch(authRepositoryProvider).fetchCurrentUser();
});

// A separate provider for forcing a manual refresh (e.g. after profile update)
final currentUserRefresherProvider = FutureProvider.autoDispose<AppUser?>((
  ref,
) async {
  final authAsync = ref.watch(authStateProvider);
  final user = authAsync.value;
  if (user == null) return null;
  return ref.watch(authRepositoryProvider).refreshUser(user.uid);
});

void requestCurrentUserLoad(WidgetRef ref) {
  final cur = ref.read(_currentUserLoadTrigger);
  if (!cur) ref.read(_currentUserLoadTrigger.notifier).state = true;
}

// ================= Role Helpers =================
extension AppUserRoleX on AppUser? {
  bool get isTrainer => this?.role == 'trainer';
  bool get isTrainee => this?.role == 'trainee';
  bool get isSuperAdmin => this?.role == 'super_admin';
}

/// Synchronous role snapshot (null until model loaded)
final currentUserRoleProvider = Provider<String?>((ref) {
  final asyncUser = ref.watch(currentUserModelProvider);
  return asyncUser.asData?.value?.role;
});

final isSuperAdminProvider = Provider<bool>((ref) {
  final role = ref.watch(currentUserRoleProvider);
  return role == 'super_admin';
});

// Debug print helper (optional; remove in prod) for quick inspection
void debugPrintCurrentUserRole(WidgetRef ref) {
  if (kDebugMode) {
    final r = ref.read(currentUserRoleProvider);
    debugPrint('[auth] current role=$r');
  }
}
