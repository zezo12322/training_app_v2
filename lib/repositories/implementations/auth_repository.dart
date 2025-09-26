import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../interfaces/auth_repository_interface.dart';
import '../../constants/app_constants.dart';
import '../../utils/error_handler.dart';

class AuthRepository implements AuthRepositoryInterface {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      ErrorHandler.logError('AuthRepository.signInWithEmailAndPassword', e);
      rethrow;
    } catch (e) {
      ErrorHandler.logError('AuthRepository.signInWithEmailAndPassword', e);
      rethrow;
    }
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      ErrorHandler.logError('AuthRepository.createUserWithEmailAndPassword', e);
      rethrow;
    } catch (e) {
      ErrorHandler.logError('AuthRepository.createUserWithEmailAndPassword', e);
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      ErrorHandler.logError('AuthRepository.signOut', e);
      rethrow;
    }
  }

  @override
  Future<DocumentSnapshot?> getUserDetails(String uid) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .get();
      return doc.exists ? doc : null;
    } catch (e) {
      ErrorHandler.logError('AuthRepository.getUserDetails', e);
      rethrow;
    }
  }

  @override
  Future<void> saveUserDetails({
    required String uid,
    required String name,
    required String email,
    required String role,
  }) async {
    try {
      await _firestore.collection(AppConstants.usersCollection).doc(uid).set({
        AppConstants.uidField: uid,
        AppConstants.nameField: name.trim(),
        AppConstants.emailField: email.trim(),
        AppConstants.roleField: role,
        AppConstants.createdAtField: FieldValue.serverTimestamp(),
      });
    } catch (e) {
      ErrorHandler.logError('AuthRepository.saveUserDetails', e);
      rethrow;
    }
  }

  @override
  Future<void> updateUserProfile({
    required String uid,
    Map<String, dynamic>? data,
  }) async {
    if (data == null || data.isEmpty) return;
    
    try {
      final updateData = Map<String, dynamic>.from(data);
      updateData[AppConstants.updatedAtField] = FieldValue.serverTimestamp();
      
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .update(updateData);
    } catch (e) {
      ErrorHandler.logError('AuthRepository.updateUserProfile', e);
      rethrow;
    }
  }

  @override
  Future<void> deleteUserAccount() async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No user is currently signed in');
    }

    try {
      // Delete user document from Firestore
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .delete();
      
      // Delete Firebase Auth user
      await user.delete();
    } catch (e) {
      ErrorHandler.logError('AuthRepository.deleteUserAccount', e);
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      ErrorHandler.logError('AuthRepository.sendPasswordResetEmail', e);
      rethrow;
    } catch (e) {
      ErrorHandler.logError('AuthRepository.sendPasswordResetEmail', e);
      rethrow;
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No user is currently signed in');
    }

    try {
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      ErrorHandler.logError('AuthRepository.updatePassword', e);
      rethrow;
    } catch (e) {
      ErrorHandler.logError('AuthRepository.updatePassword', e);
      rethrow;
    }
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No user is currently signed in');
    }

    try {
      await user.updateEmail(newEmail.trim());
      
      // Update email in Firestore as well
      await updateUserProfile(
        uid: user.uid,
        data: {AppConstants.emailField: newEmail.trim()},
      );
    } on FirebaseAuthException catch (e) {
      ErrorHandler.logError('AuthRepository.updateEmail', e);
      rethrow;
    } catch (e) {
      ErrorHandler.logError('AuthRepository.updateEmail', e);
      rethrow;
    }
  }
}
