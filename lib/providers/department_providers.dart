import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/department.dart'; // removed duplicate
import 'package:rxdart/rxdart.dart';
import '../models/user_department_map.dart';
import '../models/user_model.dart';
import '../models/department.dart';

final _fs = Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);

final departmentsByCompanyProvider =
    StreamProvider.family<List<Department>, String>((ref, companyId) {
      final fs = ref.watch(_fs);
      return fs
          .collection('departments')
          .where('companyId', isEqualTo: companyId)
          .orderBy('name')
          .withConverter<Map<String, dynamic>>(
            fromFirestore: (snap, _) => snap.data() ?? {},
            toFirestore: (value, _) => value,
          )
          .snapshots()
          .map(
            (q) => q.docs
                .map(
                  (d) => Department.fromDoc(
                    d as DocumentSnapshot<Map<String, dynamic>>,
                  ),
                )
                .toList(),
          );
    });

// Create a new department (company-admin scope)
final createDepartmentProvider = FutureProvider.family<void, ({String companyId, String name})>((ref, args) async {
  final fs = ref.read(_fs);
  await fs.collection('departments').add({
    'companyId': args.companyId,
    'name': args.name,
  });
});

// Create a user_department_map entry (assign user to department)
final addUserToDepartmentProvider = FutureProvider.family<void, ({String userId, String departmentId})>((ref, args) async {
  final fs = ref.read(_fs);
  await fs.collection('user_department_map').add({
    'userId': args.userId,
    'departmentId': args.departmentId,
  });
});

// Find a user by email within a specific company (for company_admin assignment flows)
final findUserByEmailInCompanyProvider = FutureProvider.family<AppUser?, ({String email, String companyId})>((ref, args) async {
  final fs = ref.read(_fs);
  final q = await fs
      .collection('users')
      .where('companyId', isEqualTo: args.companyId)
      .where('email', isEqualTo: args.email)
      .limit(1)
      .get();
  if (q.docs.isEmpty) return null;
  final doc = q.docs.first as DocumentSnapshot<Map<String, dynamic>>;
  return AppUser.fromDoc(doc);
});

// Fetch department by id (one-shot)
final departmentByIdProvider = FutureProvider.family<Department?, String>((ref, deptId) async {
  final fs = ref.read(_fs);
  final snap = await fs.collection('departments').doc(deptId).get();
  if (!snap.exists) return null;
  return Department.fromDoc(snap);
});

// Remove user from department: delete mapping doc(s) for (userId, departmentId)
final removeUserFromDepartmentProvider = FutureProvider.family<void, ({String userId, String departmentId})>((ref, args) async {
  final fs = ref.read(_fs);
  final q = await fs
      .collection('user_department_map')
      .where('userId', isEqualTo: args.userId)
      .where('departmentId', isEqualTo: args.departmentId)
      .get();
  for (final d in q.docs) {
    await d.reference.delete();
  }
});

// Departments for a specific user via user_department_map (manager -> list of departments)
final departmentsForUserProvider =
    StreamProvider.family<List<Department>, String>((ref, userId) {
      final fs = ref.watch(_fs);
      final mappingStream = fs
          .collection('user_department_map')
          .where('userId', isEqualTo: userId)
          .withConverter<Map<String, dynamic>>(
            fromFirestore: (snap, _) => snap.data() ?? {},
            toFirestore: (value, _) => value,
          )
          .snapshots()
          .map(
            (q) => q.docs
                .map(
                  (d) => UserDepartmentMap.fromDoc(
                    d as DocumentSnapshot<Map<String, dynamic>>,
                  ),
                )
                .toList(),
          );

      return mappingStream.switchMap((maps) {
        if (maps.isEmpty) {
          return Stream.value(const <Department>[]);
        }
        final deptIdList = maps.map((m) => m.departmentId).toSet().toList();
        final streams = deptIdList.map((id) {
          return fs
              .collection('departments')
              .doc(id)
              .withConverter<Map<String, dynamic>>(
                fromFirestore: (snap, _) => snap.data() ?? {},
                toFirestore: (value, _) => value,
              )
              .snapshots()
              .map((d) => Department.fromDoc(d));
        }).toList();
        return Rx.combineLatestList<Department>(streams).map((list) {
          final filtered = list.where((d) => d.id.isNotEmpty).toList();
          filtered.sort((a, b) => a.name.compareTo(b.name));
          return filtered;
        });
      });
    });
