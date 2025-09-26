import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthRepositoryInterface {
  /// Stream to listen for authentication state changes
  Stream<User?> get authStateChanges;
  
  /// Get current authenticated user
  User? get currentUser;
  
  /// Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  /// Create account with email and password
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  /// Sign out current user
  Future<void> signOut();
  
  /// Get user details from Firestore
  Future<DocumentSnapshot?> getUserDetails(String uid);
  
  /// Save user details to Firestore
  Future<void> saveUserDetails({
    required String uid,
    required String name,
    required String email,
    required String role,
  });
  
  /// Update user profile
  Future<void> updateUserProfile({
    required String uid,
    Map<String, dynamic>? data,
  });
  
  /// Delete user account
  Future<void> deleteUserAccount();
  
  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email);
  
  /// Update user password
  Future<void> updatePassword(String newPassword);
  
  /// Update user email
  Future<void> updateEmail(String newEmail);
}
