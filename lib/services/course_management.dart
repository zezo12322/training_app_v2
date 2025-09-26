import 'package:cloud_firestore/cloud_firestore.dart';
import '../repositories/interfaces/course_repository_interface.dart';
import '../repositories/implementations/course_repository.dart';

class CourseManagement {
  final CourseRepositoryInterface _courseRepository;

  CourseManagement({CourseRepositoryInterface? courseRepository})
      : _courseRepository = courseRepository ?? CourseRepository();

  // Create a new course with unique code
  Future<String> createCourse({
    required String courseName,
    required String trainerId,
    String? description,
  }) async {
    return await _courseRepository.createCourse(
      courseName: courseName,
      trainerId: trainerId,
      description: description,
    );
  }

  // Join a course using course code
  Future<DocumentSnapshot?> joinCourse({
    required String courseCode,
    required String traineeId,
  }) async {
    return await _courseRepository.joinCourse(
      courseCode: courseCode,
      traineeId: traineeId,
    );
  }

  // Get course details
  Future<DocumentSnapshot?> getCourse(String courseId) async {
    return await _courseRepository.getCourse(courseId);
  }

  // Get courses for trainer
  Future<List<DocumentSnapshot>> getTrainerCourses(String trainerId) async {
    return await _courseRepository.getTrainerCourses(trainerId);
  }

  // Get courses for trainee
  Future<List<DocumentSnapshot>> getTraineeCourses(String traineeId) async {
    return await _courseRepository.getTraineeCourses(traineeId);
  }

  // Update course
  Future<void> updateCourse({
    required String courseId,
    required Map<String, dynamic> data,
  }) async {
    await _courseRepository.updateCourse(courseId: courseId, data: data);
  }

  // Delete course
  Future<void> deleteCourse(String courseId) async {
    await _courseRepository.deleteCourse(courseId);
  }

  // Leave course (for trainee)
  Future<void> leaveCourse({
    required String courseId,
    required String traineeId,
  }) async {
    await _courseRepository.leaveCourse(
      courseId: courseId,
      traineeId: traineeId,
    );
  }

  // Remove trainee from course (for trainer)
  Future<void> removeTraineeFromCourse({
    required String courseId,
    required String traineeId,
  }) async {
    await _courseRepository.removeTraineeFromCourse(
      courseId: courseId,
      traineeId: traineeId,
    );
  }

  // Get course trainees
  Future<List<DocumentSnapshot>> getCourseTrainees(String courseId) async {
    return await _courseRepository.getCourseTrainees(courseId);
  }

  // Search courses
  Future<List<DocumentSnapshot>> searchCourses({
    required String query,
    String? trainerId,
  }) async {
    return await _courseRepository.searchCourses(
      query: query,
      trainerId: trainerId,
    );
  }

  // Get course statistics
  Future<Map<String, dynamic>> getCourseStatistics(String courseId) async {
    return await _courseRepository.getCourseStatistics(courseId);
  }

  // Generate unique course code
  String generateCourseCode() {
    return _courseRepository.generateCourseCode();
  }

  // Check if course code exists
  Future<bool> doesCourseCodeExist(String courseCode) async {
    return await _courseRepository.doesCourseCodeExist(courseCode);
  }
}