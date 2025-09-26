import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../interfaces/course_repository_interface.dart';
import '../../constants/app_constants.dart';
import '../../utils/error_handler.dart';

class CourseRepository implements CourseRepositoryInterface {
  final FirebaseFirestore _firestore;

  CourseRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<String> createCourse({
    required String courseName,
    required String trainerId,
    String? description,
  }) async {
    try {
      String courseCode = generateCourseCode();
      
      // Ensure course code is unique
      while (await doesCourseCodeExist(courseCode)) {
        courseCode = generateCourseCode();
      }

      final docRef = await _firestore.collection(AppConstants.coursesCollection).add({
        AppConstants.nameField: courseName.trim(),
        AppConstants.trainerIdField: trainerId,
        AppConstants.courseCodeField: courseCode,
        AppConstants.traineesField: <String>[],
        if (description != null) 'description': description.trim(),
        AppConstants.createdAtField: FieldValue.serverTimestamp(),
        AppConstants.updatedAtField: FieldValue.serverTimestamp(),
      });

      return docRef.id;
    } catch (e) {
      ErrorHandler.logError('CourseRepository.createCourse', e);
      rethrow;
    }
  }

  @override
  Future<DocumentSnapshot?> joinCourse({
    required String courseCode,
    required String traineeId,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection(AppConstants.coursesCollection)
          .where(AppConstants.courseCodeField, isEqualTo: courseCode.toUpperCase())
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      final courseDoc = querySnapshot.docs.first;
      final courseData = courseDoc.data() as Map<String, dynamic>;
      final trainees = List<String>.from(courseData[AppConstants.traineesField] ?? []);

      // Check if trainee is already enrolled
      if (trainees.contains(traineeId)) {
        throw Exception('المتدرب مسجل بالفعل في هذا الكورس');
      }

      // Add trainee to course
      await _firestore.collection(AppConstants.coursesCollection).doc(courseDoc.id).update({
        AppConstants.traineesField: FieldValue.arrayUnion([traineeId]),
        AppConstants.updatedAtField: FieldValue.serverTimestamp(),
      });

      return courseDoc;
    } catch (e) {
      ErrorHandler.logError('CourseRepository.joinCourse', e);
      rethrow;
    }
  }

  @override
  Future<DocumentSnapshot?> getCourse(String courseId) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.coursesCollection)
          .doc(courseId)
          .get();
      return doc.exists ? doc : null;
    } catch (e) {
      ErrorHandler.logError('CourseRepository.getCourse', e);
      rethrow;
    }
  }

  @override
  Future<List<DocumentSnapshot>> getTrainerCourses(String trainerId) async {
    try {
      final querySnapshot = await _firestore
          .collection(AppConstants.coursesCollection)
          .where(AppConstants.trainerIdField, isEqualTo: trainerId)
          .orderBy(AppConstants.createdAtField, descending: true)
          .get();

      return querySnapshot.docs;
    } catch (e) {
      ErrorHandler.logError('CourseRepository.getTrainerCourses', e);
      rethrow;
    }
  }

  @override
  Future<List<DocumentSnapshot>> getTraineeCourses(String traineeId) async {
    try {
      final querySnapshot = await _firestore
          .collection(AppConstants.coursesCollection)
          .where(AppConstants.traineesField, arrayContains: traineeId)
          .orderBy(AppConstants.createdAtField, descending: true)
          .get();

      return querySnapshot.docs;
    } catch (e) {
      ErrorHandler.logError('CourseRepository.getTraineeCourses', e);
      rethrow;
    }
  }

  @override
  Future<void> updateCourse({
    required String courseId,
    required Map<String, dynamic> data,
  }) async {
    if (data.isEmpty) return;

    try {
      final updateData = Map<String, dynamic>.from(data);
      updateData[AppConstants.updatedAtField] = FieldValue.serverTimestamp();

      await _firestore
          .collection(AppConstants.coursesCollection)
          .doc(courseId)
          .update(updateData);
    } catch (e) {
      ErrorHandler.logError('CourseRepository.updateCourse', e);
      rethrow;
    }
  }

  @override
  Future<void> deleteCourse(String courseId) async {
    try {
      // TODO: Should also delete related data (posts, comments, evaluations, etc.)
      await _firestore
          .collection(AppConstants.coursesCollection)
          .doc(courseId)
          .delete();
    } catch (e) {
      ErrorHandler.logError('CourseRepository.deleteCourse', e);
      rethrow;
    }
  }

  @override
  Future<void> leaveCourse({
    required String courseId,
    required String traineeId,
  }) async {
    try {
      await _firestore.collection(AppConstants.coursesCollection).doc(courseId).update({
        AppConstants.traineesField: FieldValue.arrayRemove([traineeId]),
        AppConstants.updatedAtField: FieldValue.serverTimestamp(),
      });
    } catch (e) {
      ErrorHandler.logError('CourseRepository.leaveCourse', e);
      rethrow;
    }
  }

  @override
  Future<void> removeTraineeFromCourse({
    required String courseId,
    required String traineeId,
  }) async {
    try {
      await leaveCourse(courseId: courseId, traineeId: traineeId);
    } catch (e) {
      ErrorHandler.logError('CourseRepository.removeTraineeFromCourse', e);
      rethrow;
    }
  }

  @override
  Future<List<DocumentSnapshot>> getCourseTrainees(String courseId) async {
    try {
      final courseDoc = await getCourse(courseId);
      if (courseDoc == null) {
        return [];
      }

      final courseData = courseDoc.data() as Map<String, dynamic>;
      final traineeIds = List<String>.from(courseData[AppConstants.traineesField] ?? []);

      if (traineeIds.isEmpty) {
        return [];
      }

      final usersSnapshot = await _firestore
          .collection(AppConstants.usersCollection)
          .where(FieldPath.documentId, whereIn: traineeIds)
          .get();

      return usersSnapshot.docs;
    } catch (e) {
      ErrorHandler.logError('CourseRepository.getCourseTrainees', e);
      rethrow;
    }
  }

  @override
  Future<bool> doesCourseCodeExist(String courseCode) async {
    try {
      final querySnapshot = await _firestore
          .collection(AppConstants.coursesCollection)
          .where(AppConstants.courseCodeField, isEqualTo: courseCode.toUpperCase())
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      ErrorHandler.logError('CourseRepository.doesCourseCodeExist', e);
      return false;
    }
  }

  @override
  String generateCourseCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(
      AppConstants.courseCodeLength,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }

  @override
  Future<List<DocumentSnapshot>> searchCourses({
    required String query,
    String? trainerId,
  }) async {
    try {
      Query courseQuery = _firestore.collection(AppConstants.coursesCollection);

      if (trainerId != null) {
        courseQuery = courseQuery.where(AppConstants.trainerIdField, isEqualTo: trainerId);
      }

      final querySnapshot = await courseQuery.get();

      // Filter results by name or code (Firestore doesn't support full-text search)
      final filteredDocs = querySnapshot.docs.where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final name = (data[AppConstants.nameField] as String? ?? '').toLowerCase();
        final code = (data[AppConstants.courseCodeField] as String? ?? '').toLowerCase();
        final searchQuery = query.toLowerCase();

        return name.contains(searchQuery) || code.contains(searchQuery);
      }).toList();

      return filteredDocs;
    } catch (e) {
      ErrorHandler.logError('CourseRepository.searchCourses', e);
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getCourseStatistics(String courseId) async {
    try {
      final courseDoc = await getCourse(courseId);
      if (courseDoc == null) {
        return {};
      }

      final courseData = courseDoc.data() as Map<String, dynamic>;
      final traineeIds = List<String>.from(courseData[AppConstants.traineesField] ?? []);

      // Get posts count
      final postsSnapshot = await _firestore
          .collection(AppConstants.courseWallCollection)
          .where(AppConstants.courseIdField, isEqualTo: courseId)
          .get();

      // Get evaluations count
      final evaluationsSnapshot = await _firestore
          .collection(AppConstants.evaluationsCollection)
          .where(AppConstants.courseIdField, isEqualTo: courseId)
          .get();

      return {
        'traineeCount': traineeIds.length,
        'postsCount': postsSnapshot.docs.length,
        'evaluationsCount': evaluationsSnapshot.docs.length,
        'createdAt': courseData[AppConstants.createdAtField],
      };
    } catch (e) {
      ErrorHandler.logError('CourseRepository.getCourseStatistics', e);
      rethrow;
    }
  }
}
