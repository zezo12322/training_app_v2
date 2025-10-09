import 'package:cloud_firestore/cloud_firestore.dart';

class Department {
  final String id;
  final String companyId;
  final String name;
  const Department({
    required this.id,
    required this.companyId,
    required this.name,
  });

  factory Department.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return Department(
      id: doc.id,
      companyId: (data['companyId'] ?? '') as String,
      name: (data['name'] ?? '') as String,
    );
  }
}
