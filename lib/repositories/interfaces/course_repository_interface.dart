import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CourseRepositoryInterface {
  /// Create a new course
  Future<String> createCourse({
    required String courseName,
    required String trainerId,
    String? description,
  });
  
  /// Join a course using course code
  Future<DocumentSnapshot?> joinCourse({
    required String courseCode,
    required String traineeId,
  });
  
  /// Get course details by ID
  Future<DocumentSnapshot?> getCourse(String courseId);
  
  /// Get courses for a trainer
  Future<List<DocumentSnapshot>> getTrainerCourses(String trainerId);
  
  /// Get courses for a trainee
  Future<List<DocumentSnapshot>> getTraineeCourses(String traineeId);
  
  /// Update course details
  Future<void> updateCourse({
    required String courseId,
    required Map<String, dynamic> data,
  });
  
  /// Delete a course
  Future<void> deleteCourse(String courseId);
  
  /// Leave a course (for trainee)
  Future<void> leaveCourse({
    required String courseId,
    required String traineeId,
  });
  
  /// Remove trainee from course (for trainer)
  Future<void> removeTraineeFromCourse({
    required String courseId,
    required String traineeId,
  });
  
  /// Get course trainees
  Future<List<DocumentSnapshot>> getCourseTrainees(String courseId);
  
  /// Check if course code exists
  Future<bool> doesCourseCodeExist(String courseCode);
  
  /// Generate unique course code
  String generateCourseCode();
  
  /// Search courses by name or code
  Future<List<DocumentSnapshot>> searchCourses({
    required String query,
    String? trainerId,
  });
  
  /// Get course statistics
  Future<Map<String, dynamic>> getCourseStatistics(String courseId);
}
