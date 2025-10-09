import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/timestamp_converter.dart';

class LearningPath {
  final String id;
  final String tenantType; // 'company' | 'institution' | ''
  final String? tenantId;
  final String title;
  final String? description;
  final bool active;
  @TimestampConverter()
  final DateTime? createdAt;
  const LearningPath({
    required this.id,
    required this.tenantType,
    required this.tenantId,
    required this.title,
    this.description,
    this.active = true,
    this.createdAt,
  });

  factory LearningPath.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? {};
    return LearningPath(
      id: doc.id,
      tenantType: (d['tenantType'] ?? '') as String,
      tenantId: d['tenantId'] as String?,
      title: (d['title'] ?? '') as String,
      description: d['description'] as String?,
      active: (d['active'] ?? true) as bool,
      createdAt: (d['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
