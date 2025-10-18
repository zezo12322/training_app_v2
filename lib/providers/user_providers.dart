import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

final _fs = Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);
final _auth = Provider<FirebaseAuth>((_) => FirebaseAuth.instance);

/// موفر المستخدم الحالي من Firebase Auth
final firebaseUserProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(_auth);
  return auth.authStateChanges();
});

/// موفر بيانات المستخدم الحالي من Firestore
final currentUserProvider = StreamProvider<AppUser?>((ref) {
  final firebaseUser = ref.watch(firebaseUserProvider).value;
  
  if (firebaseUser == null) {
    return Stream.value(null);
  }
  
  final fs = ref.watch(_fs);
  return fs
      .collection('users')
      .doc(firebaseUser.uid)
      .snapshots()
      .map((doc) => doc.exists ? AppUser.fromDoc(doc) : null);
});

final usersInCompanyProvider =
    FutureProvider.family<List<AppUser>, String>((ref, companyId) async {
  final fs = ref.read(_fs);
  
  // Get current user to determine appropriate limit based on role
  final currentUser = await ref.read(currentUserProvider.future);
  
  // Firestore rules: super_admin/org_admin: 200, company_admin: 500, others: 30
  int limit = 30; // Default for trainers/trainees
  if (currentUser != null) {
    if (currentUser.role == 'super_admin' || currentUser.role == 'org_admin') {
      limit = 200;
    } else if (currentUser.role == 'company_admin') {
      limit = 500;
    }
  }
  
  final q = await fs
      .collection('users')
      .where('companyId', isEqualTo: companyId)
      .limit(limit)
      .get();
  return q.docs
      .map((d) => AppUser.fromDoc(d))
      .toList();
});

/// Provider للمستخدمين في نفس المؤسسة
final usersInSameInstitutionProvider =
    FutureProvider.family<List<AppUser>, String>((ref, institutionId) async {
  final fs = ref.read(_fs);
  
  // Get current user to determine appropriate limit based on role
  final currentUser = await ref.read(currentUserProvider.future);
  
  // Firestore rules: super_admin/org_admin: 200, company_admin: 500, others: 30
  int limit = 30; // Default for trainers/trainees
  if (currentUser != null) {
    if (currentUser.role == 'super_admin' || currentUser.role == 'org_admin') {
      limit = 200;
    } else if (currentUser.role == 'company_admin') {
      limit = 500;
    }
  }
  
  final q = await fs
      .collection('users')
      .where('institutionId', isEqualTo: institutionId)
      .limit(limit)
      .get();
  return q.docs
      .map((d) => AppUser.fromDoc(d))
      .toList();
});
