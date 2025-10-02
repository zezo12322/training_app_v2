import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';
import '../models/user_model.dart';

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
  final authAsync = ref.watch(authStateProvider);
  final user = authAsync.value;
  if (user == null) return null;
  return ref.watch(authRepositoryProvider).fetchCurrentUser();
});

// A separate provider for forcing a manual refresh (e.g. after profile update)
final currentUserRefresherProvider = FutureProvider.autoDispose<AppUser?>((ref) async {
  final authAsync = ref.watch(authStateProvider);
  final user = authAsync.value;
  if (user == null) return null;
  return ref.watch(authRepositoryProvider).refreshUser(user.uid);
});