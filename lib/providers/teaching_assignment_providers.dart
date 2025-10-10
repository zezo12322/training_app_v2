import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/teaching_assignment.dart';

final _fs = Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);

// Stream: assignments for a trainer, optionally filtered to active-now via now parameter
final assignmentsByTrainerProvider = StreamProvider.family
    .autoDispose<List<TeachingAssignment>, ({String trainerId, DateTime? now})>(
        (ref, args) {
  final fs = ref.watch(_fs);
  final baseQuery = fs
      .collection('teaching_assignments')
      .where('trainerId', isEqualTo: args.trainerId)
      .orderBy('startAt', descending: true)
      .withConverter<Map<String, dynamic>>(
        fromFirestore: (snap, _) => snap.data() ?? {},
        toFirestore: (value, _) => value,
      );
  return baseQuery.snapshots().map((q) {
    final list = q.docs
        .map((d) => TeachingAssignment.fromDoc(
            d as DocumentSnapshot<Map<String, dynamic>>))
        .toList();
    final now = args.now;
    if (now == null) return list;
    return list
        .where((a) => a.status == 'active' && a.startAt.isBefore(now) && a.endAt.isAfter(now))
        .toList();
  });
});

// Stream: assignments by scope (path/course)
final assignmentsByScopeProvider = StreamProvider.family
    .autoDispose<List<TeachingAssignment>, ({String scopeType, String scopeId, String? status})>(
        (ref, args) {
  final fs = ref.watch(_fs);
  Query<Map<String, dynamic>> q = fs
      .collection('teaching_assignments')
      .where('scopeType', isEqualTo: args.scopeType)
      .where('scopeId', isEqualTo: args.scopeId)
      .withConverter<Map<String, dynamic>>(
        fromFirestore: (snap, _) => snap.data() ?? {},
        toFirestore: (value, _) => value,
      );
  if (args.status != null) {
    q = q.where('status', isEqualTo: args.status);
  }
  return q.orderBy('startAt', descending: true).snapshots().map((qs) => qs.docs
      .map((d) => TeachingAssignment.fromDoc(
          d as DocumentSnapshot<Map<String, dynamic>>))
      .toList());
});

// Stream: assignments by tenant (for admin/manager views)
final assignmentsByTenantProvider = StreamProvider.family
    .autoDispose<List<TeachingAssignment>, ({String tenantType, String tenantId, String? status})>(
        (ref, args) {
  final fs = ref.watch(_fs);
  Query<Map<String, dynamic>> q = fs
      .collection('teaching_assignments')
      .where('tenantType', isEqualTo: args.tenantType)
      .where('tenantId', isEqualTo: args.tenantId)
      .withConverter<Map<String, dynamic>>(
        fromFirestore: (snap, _) => snap.data() ?? {},
        toFirestore: (value, _) => value,
      );
  if (args.status != null) {
    q = q.where('status', isEqualTo: args.status);
  }
  return q.orderBy('startAt', descending: true).limit(100).snapshots().map(
      (qs) => qs.docs
          .map((d) => TeachingAssignment.fromDoc(
              d as DocumentSnapshot<Map<String, dynamic>>))
          .toList());
});

// Mutation: create assignment
final createAssignmentProvider = FutureProvider.family
    .autoDispose<void, ({String tenantType, String tenantId, String scopeType, String scopeId, String trainerId, String? departmentId, DateTime startAt, DateTime endAt})>(
        (ref, args) async {
  final fs = ref.watch(_fs);
  if (!args.startAt.isBefore(args.endAt)) {
    throw StateError('startAt must be before endAt');
  }
  final doc = fs.collection('teaching_assignments').doc();
  await doc.set({
    'tenantType': args.tenantType,
    'tenantId': args.tenantId,
    'scopeType': args.scopeType,
    'scopeId': args.scopeId,
    'trainerId': args.trainerId,
    if (args.departmentId != null) 'departmentId': args.departmentId,
    'startAt': Timestamp.fromDate(args.startAt),
    'endAt': Timestamp.fromDate(args.endAt),
    'status': 'active',
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  });
});

// Mutation: update assignment (subset of fields)
final updateAssignmentProvider = FutureProvider.family
    .autoDispose<void, ({String id, DateTime? endAt, String? status, String? departmentId})>(
        (ref, args) async {
  final fs = ref.watch(_fs);
  final patch = <String, dynamic>{
    if (args.endAt != null) 'endAt': Timestamp.fromDate(args.endAt!),
    if (args.status != null) 'status': args.status,
    if (args.departmentId != null) 'departmentId': args.departmentId,
    'updatedAt': FieldValue.serverTimestamp(),
  };
  await fs.collection('teaching_assignments').doc(args.id).update(patch);
});

// Mutation: cancel assignment (status -> cancelled)
final cancelAssignmentProvider = FutureProvider.family
    .autoDispose<void, String>((ref, id) async {
  final fs = ref.watch(_fs);
  await fs.collection('teaching_assignments').doc(id).update({
    'status': 'cancelled',
    'updatedAt': FieldValue.serverTimestamp(),
  });
});
