import 'package:cloud_firestore/cloud_firestore.dart';

class PathStep {
  final String id;
  final String pathId;
  final String title;
  final String? description;
  final int order;
  final String? type; // optional: 'course'|'task'|'custom'
  const PathStep({
    required this.id,
    required this.pathId,
    required this.title,
    this.description,
    required this.order,
    this.type,
  });

  factory PathStep.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? {};
    return PathStep(
      id: doc.id,
      pathId: (d['pathId'] ?? '') as String,
      title: (d['title'] ?? '') as String,
      description: d['description'] as String?,
      order: (d['order'] ?? 0) as int,
      type: d['type'] as String?,
    );
  }
}
