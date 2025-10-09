import 'package:cloud_firestore/cloud_firestore.dart';

class UserDepartmentMap {
  final String id;
  final String userId;
  final String departmentId;
  const UserDepartmentMap({
    required this.id,
    required this.userId,
    required this.departmentId,
  });

  factory UserDepartmentMap.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};
    return UserDepartmentMap(
      id: doc.id,
      userId: (data['userId'] ?? '') as String,
      departmentId: (data['departmentId'] ?? '') as String,
    );
  }
}
