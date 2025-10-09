import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/course.dart';
import '../core/result.dart';
import '../core/bootstrap.dart';
import '../core/logging.dart';
import '../models/user_model.dart';

class CourseRepository {
  CourseRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('courses');

  Future<Result<Course>> createCourse({
    required String name,
    required String trainerId,
  }) async {
    try {
      // Role validation: only trainers can create courses
      final userSnap = await traceAsync(
        'course.create.user($trainerId)',
        () => _firestore.collection('users').doc(trainerId).get(),
      );
      if (!userSnap.exists) {
        return FailureResult(NotFoundFailure('User not found'));
      }
      final user = AppUser.fromDoc(userSnap);
      if (user.role != 'trainer') {
        return FailureResult(
          PermissionFailure('Only trainers can create courses'),
        );
      }
      final code = await _generateUniqueCode();
      final docRef = await _col.add({
        'name': name,
        'trainerId': trainerId,
        'courseCode': code,
        'createdAt': FieldValue.serverTimestamp(),
        'trainees': <String>[],
      });
      final snap = await traceAsync(
        'course.create.get(${docRef.id})',
        () => docRef.get(),
      );
      return Success(Course.fromDoc(snap));
    } catch (e, st) {
      return FailureResult(
        UnknownFailure('Failed to create course', cause: e, stack: st),
      );
    }
  }

  Future<Result<Course>> joinCourse({
    required String courseCode,
    required String traineeId,
  }) async {
    try {
      // Role validation: only trainees can join
      final userSnap = await traceAsync(
        'course.join.user($traineeId)',
        () => _firestore.collection('users').doc(traineeId).get(),
      );
      if (!userSnap.exists) {
        return FailureResult(NotFoundFailure('User not found'));
      }
      final user = AppUser.fromDoc(userSnap);
      if (user.role != 'trainee') {
        return FailureResult(
          PermissionFailure('Only trainees can join courses'),
        );
      }
      final query = await traceAsync(
        'course.join.query($courseCode)',
        () => _col.where('courseCode', isEqualTo: courseCode).limit(1).get(),
      );
      if (query.docs.isEmpty) {
        return FailureResult(NotFoundFailure('Course not found'));
      }
      final doc = query.docs.first.reference;
      await doc.update({
        'trainees': FieldValue.arrayUnion([traineeId]),
      });
      final updated = await traceAsync(
        'course.join.updated(${doc.id})',
        () => doc.get(),
      );
      return Success(Course.fromDoc(updated));
    } catch (e, st) {
      return FailureResult(
        UnknownFailure('Failed to join course', cause: e, stack: st),
      );
    }
  }

  Future<Result<List<Course>>> listTrainerCourses(
    String trainerId, {
    int limit = 20,
  }) async {
    try {
      final query = await traceAsync(
        'course.listTrainer($trainerId,limit=$limit)',
        () => _col
            .where('trainerId', isEqualTo: trainerId)
            .orderBy('createdAt', descending: true)
            .limit(limit)
            .get(),
      );
      return Success(query.docs.map((d) => Course.fromDoc(d)).toList());
    } catch (e, st) {
      return FailureResult(
        UnknownFailure('Failed to load courses', cause: e, stack: st),
      );
    }
  }

  Future<Result<List<Course>>> listTraineeCourses(
    String traineeId, {
    int limit = 20,
  }) async {
    try {
      // ملاحظة: إزالة orderBy('createdAt') لتجنب الحاجة إلى فهرس مركب (trainees + createdAt) في حال عدم إنشائه بعد.
      final query = await traceAsync(
        'course.listTrainee($traineeId,limit=$limit)',
        () =>
            _col.where('trainees', arrayContains: traineeId).limit(limit).get(),
      );
      final courses = query.docs.map((d) => Course.fromDoc(d)).toList();
      // فرز محلي تنازلياً حسب createdAt (null في النهاية)
      courses.sort(
        (a, b) => (b.createdAt?.millisecondsSinceEpoch ?? 0).compareTo(
          a.createdAt?.millisecondsSinceEpoch ?? 0,
        ),
      );
      return Success(courses);
    } catch (e, st) {
      // يمكن أن يكون السبب الرئيسي هنا نقص فهرس مركب: trainees (array) + createdAt
      logger.w('listTraineeCourses failed (likely missing index) $e');
      return FailureResult(
        UnknownFailure('Failed to load joined courses', cause: e, stack: st),
      );
    }
  }

  Future<String> _generateUniqueCode() async {
    // Simple retry loop to reduce collision probability.
    for (var i = 0; i < 5; i++) {
      final code = _randomCode();
      final exists = await traceAsync(
        'course.code.exists($code)',
        () => _col.where('courseCode', isEqualTo: code).limit(1).get(),
      );
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
