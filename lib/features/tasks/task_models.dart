import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskParentType { evaluation, course, quiz }

extension TaskParentTypeX on TaskParentType {
  String get key => switch (this) {
    TaskParentType.evaluation => 'evaluation',
    TaskParentType.course => 'course',
    TaskParentType.quiz => 'quiz',
  };
  static TaskParentType from(String v) {
    switch (v) {
      case 'course':
        return TaskParentType.course;
      case 'quiz':
        return TaskParentType.quiz;
      default:
        return TaskParentType.evaluation;
    }
  }
}

enum AppTaskStatus { pending, inProgress, done, skipped }

extension AppTaskStatusX on AppTaskStatus {
  String get key => switch (this) {
    AppTaskStatus.pending => 'pending',
    AppTaskStatus.inProgress => 'in_progress',
    AppTaskStatus.done => 'done',
    AppTaskStatus.skipped => 'skipped',
  };
  static AppTaskStatus from(String? v) {
    switch (v) {
      case 'in_progress':
        return AppTaskStatus.inProgress;
      case 'done':
        return AppTaskStatus.done;
      case 'skipped':
        return AppTaskStatus.skipped;
      default:
        return AppTaskStatus.pending;
    }
  }
}

class AppTask {
  final String id;
  final TaskParentType parentType;
  final String parentId;
  final String title;
  final String? details;
  final AppTaskStatus status;
  final String createdBy;
  final String? assignedTo;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? dueDate;
  final int pointsOnComplete;
  final String priority; // low | med | high

  AppTask({
    required this.id,
    required this.parentType,
    required this.parentId,
    required this.title,
    required this.details,
    required this.status,
    required this.createdBy,
    required this.assignedTo,
    required this.createdAt,
    required this.updatedAt,
    required this.dueDate,
    required this.pointsOnComplete,
    required this.priority,
  });

  factory AppTask.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return AppTask(
      id: doc.id,
      parentType: TaskParentTypeX.from(
        data['parentType'] as String? ?? 'evaluation',
      ),
      parentId: data['parentId'] ?? '',
      title: data['title'] ?? '',
      details: data['details'] as String?,
      status: AppTaskStatusX.from(data['status'] as String?),
      createdBy: data['createdBy'] ?? '',
      assignedTo: data['assignedTo'] as String?,
      createdAt: _dt(data['createdAt']) ?? DateTime.now(),
      updatedAt: _dt(data['updatedAt']),
      dueDate: _dt(data['dueDate']),
      pointsOnComplete: (data['pointsOnComplete'] as int?) ?? 0,
      priority: data['priority'] as String? ?? 'low',
    );
  }

  static DateTime? _dt(dynamic v) {
    if (v == null) return null;
    if (v is Timestamp) return v.toDate();
    if (v is DateTime) return v;
    return null;
  }

  Map<String, dynamic> toMap() => {
    'parentType': parentType.key,
    'parentId': parentId,
    'title': title,
    'details': details,
    'status': status.key,
    'createdBy': createdBy,
    'assignedTo': assignedTo,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'dueDate': dueDate,
    'pointsOnComplete': pointsOnComplete,
    'priority': priority,
  };

  AppTask copyWith({
    String? title,
    String? details,
    AppTaskStatus? status,
    String? assignedTo,
    DateTime? updatedAt,
    DateTime? dueDate,
    int? pointsOnComplete,
    String? priority,
  }) => AppTask(
    id: id,
    parentType: parentType,
    parentId: parentId,
    title: title ?? this.title,
    details: details ?? this.details,
    status: status ?? this.status,
    createdBy: createdBy,
    assignedTo: assignedTo ?? this.assignedTo,
    createdAt: createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    dueDate: dueDate ?? this.dueDate,
    pointsOnComplete: pointsOnComplete ?? this.pointsOnComplete,
    priority: priority ?? this.priority,
  );
}
