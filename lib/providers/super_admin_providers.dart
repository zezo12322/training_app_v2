import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import 'auth_provider.dart';
import '../models/system_settings.dart';
import '../models/institution.dart';
import '../models/company.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue;

/// Global stats lightweight aggregation (client-side approximation until CF aggregation exists)
class GlobalStats {
  final int totalUsers;
  final int trainers;
  final int trainees;
  const GlobalStats({
    required this.totalUsers,
    required this.trainers,
    required this.trainees,
  });
}

final _firestoreProvider = Provider<FirebaseFirestore>(
  (_) => FirebaseFirestore.instance,
);

/// Stream system settings (single doc: system_settings/global)
final systemSettingsProvider = StreamProvider<SystemSettings?>((ref) {
  final fs = ref.watch(_firestoreProvider);
  final docRef = fs.collection('system_settings').doc('global');
  return docRef.snapshots().map(
    (snap) => snap.exists ? SystemSettings.fromDoc(snap) : null,
  );
});

/// Simple users page fetch (pagination placeholder)
final superAdminUsersProvider = StreamProvider<List<AppUser>>((ref) {
  final fs = ref.watch(_firestoreProvider);
  // Basic limit 50; future: cursor pagination
  return fs
      .collection('users')
      .limit(50)
      .snapshots()
      .map((snap) => snap.docs.map(AppUser.fromDoc).toList());
});

final institutionsProvider = StreamProvider<List<Institution>>((ref) {
  final fs = ref.watch(_firestoreProvider);
  return fs
      .collection('institutions')
      .limit(50)
      .snapshots()
      .map((snap) => snap.docs.map((d) => Institution.fromDoc(d)).toList());
});

final companiesProvider = StreamProvider<List<Company>>((ref) {
  final fs = ref.watch(_firestoreProvider);
  return fs
      .collection('companies')
      .limit(50)
      .snapshots()
      .map((snap) => snap.docs.map((d) => Company.fromDoc(d)).toList());
});

final createInstitutionProvider = FutureProvider.family<void, ({String name, String planTier})>((ref, args) async {
  final fs = ref.read(_firestoreProvider);
  final data = {
    'name': args.name,
    'planTier': args.planTier,
    'active': true,
    'createdAt': FieldValue.serverTimestamp(),
  };
  await fs.collection('institutions').add(data);
});

final createCompanyProvider = FutureProvider.family<void, ({String name, String planTier})>((ref, args) async {
  final fs = ref.read(_firestoreProvider);
  final data = {
    'name': args.name,
    'planTier': args.planTier,
    'active': true,
    'createdAt': FieldValue.serverTimestamp(),
  };
  await fs.collection('companies').add(data);
});

final globalStatsProvider = Provider<GlobalStats?>((ref) {
  final usersAsync = ref.watch(superAdminUsersProvider);
  if (!usersAsync.hasValue) return null;
  final users = usersAsync.value!;
  final trainers = users.where((u) => u.role == 'trainer').length;
  final trainees = users.where((u) => u.role == 'trainee').length;
  return GlobalStats(
    totalUsers: users.length,
    trainers: trainers,
    trainees: trainees,
  );
});

/// Gate provider to ensure only super admin screens build
final ensureSuperAdminProvider = Provider<bool>(
  (ref) => ref.watch(isSuperAdminProvider),
);

/// Find any user by email (global), super_admin use only in UI
final findUserByEmailProvider = FutureProvider.family<AppUser?, String>((ref, email) async {
  final fs = ref.read(_firestoreProvider);
  final q = await fs
      .collection('users')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();
  if (q.docs.isEmpty) return null;
  final doc = q.docs.first as DocumentSnapshot<Map<String, dynamic>>;
  return AppUser.fromDoc(doc);
});

/// Update a user's role and optional tenant linkage fields
final updateUserRoleProvider = FutureProvider.family<void, ({String userId, String role, String? institutionId, String? companyId})>((ref, args) async {
  final fs = ref.read(_firestoreProvider);
  final data = <String, dynamic>{
    'role': args.role,
    'updatedAt': FieldValue.serverTimestamp(),
  };
  // Clear both first then set the relevant one to avoid stale links
  data['institutionId'] = args.institutionId ?? FieldValue.delete();
  data['companyId'] = args.companyId ?? FieldValue.delete();
  await fs.collection('users').doc(args.userId).update(data);
});
