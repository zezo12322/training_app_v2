import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskStatus { open, done, skipped }

class TaskModel {
  final String id;
  final String title;
  final String? description;
  final TaskStatus status;
  final String createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? dueDate;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.dueDate,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map, {required String id}) =>
      TaskModel(
        id: id,
        title: map['title'] ?? '',
        description: map['description'] as String?,
        status: _status(map['status']),
        createdBy: map['createdBy'] ?? '',
        createdAt: _ts(map['createdAt']),
        updatedAt: _ts(map['updatedAt']),
        dueDate: _ts(map['dueDate']),
      );

  factory TaskModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) =>
      TaskModel.fromMap(doc.data() ?? {}, id: doc.id);

  static DateTime? _ts(dynamic v) {
    if (v == null) return null;
    if (v is Timestamp) return v.toDate();
    if (v is DateTime) return v;
    return null;
  }

  static TaskStatus _status(dynamic v) {
    switch (v) {
      case 'done':
        return TaskStatus.done;
      case 'skipped':
        return TaskStatus.skipped;
      default:
        return TaskStatus.open;
    }
  }

  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'status': status.name,
    'createdBy': createdBy,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'dueDate': dueDate,
  };
}
