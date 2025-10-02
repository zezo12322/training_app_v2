import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/course.dart';
import '../core/result.dart';

class CourseRepository {
  CourseRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col => _firestore.collection('courses');

  Future<Result<Course>> createCourse({required String name, required String trainerId}) async {
    try {
      final code = await _generateUniqueCode();
      final docRef = await _col.add({
        'name': name,
        'trainerId': trainerId,
        'courseCode': code,
        'createdAt': FieldValue.serverTimestamp(),
        'trainees': <String>[],
      });
      final snap = await docRef.get();
      return Success(Course.fromDoc(snap));
    } catch (e, st) {
      return FailureResult(UnknownFailure('Failed to create course', cause: e, stack: st));
    }
  }

  Future<Result<Course>> joinCourse({required String courseCode, required String traineeId}) async {
    try {
      final query = await _col.where('courseCode', isEqualTo: courseCode).limit(1).get();
      if (query.docs.isEmpty) {
        return FailureResult(NotFoundFailure('Course not found'));
      }
      final doc = query.docs.first.reference;
      await doc.update({'trainees': FieldValue.arrayUnion([traineeId])});
      final updated = await doc.get();
      return Success(Course.fromDoc(updated));
    } catch (e, st) {
      return FailureResult(UnknownFailure('Failed to join course', cause: e, stack: st));
    }
  }

  Future<Result<List<Course>>> listTrainerCourses(String trainerId) async {
    try {
      final query = await _col.where('trainerId', isEqualTo: trainerId).orderBy('createdAt', descending: true).get();
      return Success(query.docs.map((d) => Course.fromDoc(d)).toList());
    } catch (e, st) {
      return FailureResult(UnknownFailure('Failed to load courses', cause: e, stack: st));
    }
  }

  Future<Result<List<Course>>> listTraineeCourses(String traineeId) async {
    try {
      final query = await _col.where('trainees', arrayContains: traineeId).orderBy('createdAt', descending: true).get();
      return Success(query.docs.map((d) => Course.fromDoc(d)).toList());
    } catch (e, st) {
      return FailureResult(UnknownFailure('Failed to load joined courses', cause: e, stack: st));
    }
  }

  Future<String> _generateUniqueCode() async {
    // Simple retry loop to reduce collision probability.
    for (var i = 0; i < 5; i++) {
      final code = _randomCode();
      final exists = await _col.where('courseCode', isEqualTo: code).limit(1).get();
      if (exists.docs.isEmpty) return code;
    }
    // Fallback with timestamp suffix
    return '${_randomCode()}${DateTime.now().millisecondsSinceEpoch % 1000}';
  }

  String _randomCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();
    return List.generate(6, (_) => chars[rand.nextInt(chars.length)]).join();
  }
}
