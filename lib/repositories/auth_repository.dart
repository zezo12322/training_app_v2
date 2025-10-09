import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../core/bootstrap.dart';

class AuthRepository {
  AuthRepository({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AppUser? _cachedUser;
  DateTime? _cacheTime;
  static const _cacheTTL = Duration(minutes: 5);

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<AppUser?> fetchCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    // Serve from cache if still fresh.
    if (_cachedUser != null &&
        _cacheTime != null &&
        DateTime.now().difference(_cacheTime!) < _cacheTTL) {
      if (_cachedUser!.id == user.uid) return _cachedUser;
    }
    final ref = _firestore.collection('users').doc(user.uid);
    // Try fast local cache first (won't hit network). If not present, ignore error and continue.
    try {
      final cacheDoc = await traceAsync(
        'auth.fetchCurrentUser.cache(${user.uid})',
        () => ref.get(const GetOptions(source: Source.cache)),
      );
      if (cacheDoc.exists) {
        final parsed = AppUser.fromDoc(cacheDoc);
        _cachedUser = parsed;
        _cacheTime = DateTime.now();
        // Kick off background server refresh to update stale data if any.
        // (No await so UI can proceed.)
        // ignore: unawaited_futures
        traceAsync(
          'auth.fetchCurrentUser.serverRefresh(${user.uid})',
          () async {
            final fresh = await ref.get();
            if (fresh.exists) {
              final p = AppUser.fromDoc(fresh);
              _cachedUser = p;
              _cacheTime = DateTime.now();
            }
            return true;
          },
        );
        return parsed;
      }
    } catch (_) {
      // No cached doc; proceed to server.
    }
    final doc = await traceAsync(
      'auth.fetchCurrentUser.server(${user.uid})',
      () => ref.get(),
    );
    if (!doc.exists) return null;
    final parsed = AppUser.fromDoc(doc);
    _cachedUser = parsed;
    _cacheTime = DateTime.now();
    return parsed;
  }

  Future<AppUser?> refreshUser(String uid) async {
    final doc = await traceAsync(
      'auth.refreshUser.get($uid)',
      () => _firestore.collection('users').doc(uid).get(),
    );
    if (!doc.exists) return null;
    final parsed = AppUser.fromDoc(doc);
    _cachedUser = parsed;
    _cacheTime = DateTime.now();
    return parsed;
  }

  Future<AppUser?> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final uid = credential.user?.uid;
    if (uid == null) return null;
    return fetchCurrentUser();
  }

  Future<AppUser?> signUp({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final uid = credential.user!.uid;
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return fetchCurrentUser();
  }

  Future<void> signOut() async => _auth.signOut();
}
