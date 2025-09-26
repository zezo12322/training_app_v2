import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../repositories/interfaces/auth_repository_interface.dart';
import '../repositories/implementations/auth_repository.dart';

class AuthService {
  final AuthRepositoryInterface _authRepository;

  AuthService({AuthRepositoryInterface? authRepository})
      : _authRepository = authRepository ?? AuthRepository();

  // Stream to listen for auth changes
  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  // Get current user
  User? get currentUser => _authRepository.currentUser;

  // Sign In with Email and Password
  Future<UserCredential> signInWithEmail(String email, String password) async {
    return await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign Up with Email and Password
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required String userType,
  }) async {
    final userCredential = await _authRepository.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Save user details to Firestore
    if (userCredential.user != null) {
      await _authRepository.saveUserDetails(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        role: userType,
      );
    }

    return userCredential;
  }

  // Sign Out
  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  // Get current user's data
  Future<DocumentSnapshot?> getUserDetails() async {
    final user = currentUser;
    if (user != null) {
      return await _authRepository.getUserDetails(user.uid);
    }
    throw Exception("User not logged in");
  }

  // Update user profile
  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    final user = currentUser;
    if (user != null) {
      await _authRepository.updateUserProfile(uid: user.uid, data: data);
    } else {
      throw Exception("User not logged in");
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _authRepository.sendPasswordResetEmail(email);
  }

  // Update password
  Future<void> updatePassword(String newPassword) async {
    await _authRepository.updatePassword(newPassword);
  }

  // Update email
  Future<void> updateEmail(String newEmail) async {
    await _authRepository.updateEmail(newEmail);
  }

  // Delete user account
  Future<void> deleteUserAccount() async {
    await _authRepository.deleteUserAccount();
  }
}