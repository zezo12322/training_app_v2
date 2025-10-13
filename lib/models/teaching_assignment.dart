import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/timestamp_converter.dart';

class TeachingAssignment {
  final String id;
  final String tenantType; // 'company' | 'institution'
  final String tenantId;
  final String scopeType; // 'path' | 'course'
  final String scopeId;
  final String trainerId;
  final String? departmentId; // optional
  @TimestampConverter()
  final DateTime startAt;
  @TimestampConverter()
  final DateTime endAt;
  final String status; // 'active' | 'ended' | 'cancelled'
  @TimestampConverter()
  final DateTime? createdAt;
  @TimestampConverter()
  final DateTime? updatedAt;
  final String title; // Title of the assignment

  const TeachingAssignment({
    required this.id,
    required this.tenantType,
    required this.tenantId,
    required this.scopeType,
    required this.scopeId,
    required this.trainerId,
    this.departmentId,
    required this.startAt,
    required this.endAt,
    required this.status,
    this.createdAt,
    this.updatedAt,
    required this.title, // Added title property
  });

  factory TeachingAssignment.fromDoc(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? {};
    return TeachingAssignment(
      id: doc.id,
      tenantType: (d['tenantType'] ?? '') as String,
      tenantId: (d['tenantId'] ?? '') as String,
      scopeType: (d['scopeType'] ?? '') as String,
      scopeId: (d['scopeId'] ?? '') as String,
      trainerId: (d['trainerId'] ?? '') as String,
      departmentId: d['departmentId'] as String?,
      startAt: (d['startAt'] as Timestamp).toDate(),
      endAt: (d['endAt'] as Timestamp).toDate(),
      status: (d['status'] ?? 'active') as String,
      createdAt: (d['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (d['updatedAt'] as Timestamp?)?.toDate(),
      title: (d['title'] ?? '') as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tenantType': tenantType,
      'tenantId': tenantId,
      'scopeType': scopeType,
      'scopeId': scopeId,
      'trainerId': trainerId,
      if (departmentId != null) 'departmentId': departmentId,
      'startAt': Timestamp.fromDate(startAt),
      'endAt': Timestamp.fromDate(endAt),
      'status': status,
      if (createdAt != null) 'createdAt': Timestamp.fromDate(createdAt!),
      if (updatedAt != null) 'updatedAt': Timestamp.fromDate(updatedAt!),
      'title': title,
    };
  }
}
