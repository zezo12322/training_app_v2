import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/app_constants.dart';

class CourseModel {
  final String id;
  final String name;
  final String trainerId;
  final String courseCode;
  final String? description;
  final List<String> trainees;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CourseModel({
    required this.id,
    required this.name,
    required this.trainerId,
    required this.courseCode,
    this.description,
    this.trainees = const [],
    this.createdAt,
    this.updatedAt,
  });

  // Create CourseModel from Firestore document
  factory CourseModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return CourseModel(
      id: doc.id,
      name: data[AppConstants.nameField] ?? '',
      trainerId: data[AppConstants.trainerIdField] ?? '',
      courseCode: data[AppConstants.courseCodeField] ?? '',
      description: data['description'],
      trainees: List<String>.from(data[AppConstants.traineesField] ?? []),
      createdAt: _parseTimestamp(data[AppConstants.createdAtField]),
      updatedAt: _parseTimestamp(data[AppConstants.updatedAtField]),
    );
  }

  // Create CourseModel from Map
  factory CourseModel.fromMap(Map<String, dynamic> data, String id) {
    return CourseModel(
      id: id,
      name: data[AppConstants.nameField] ?? '',
      trainerId: data[AppConstants.trainerIdField] ?? '',
      courseCode: data[AppConstants.courseCodeField] ?? '',
      description: data['description'],
      trainees: List<String>.from(data[AppConstants.traineesField] ?? []),
      createdAt: _parseTimestamp(data[AppConstants.createdAtField]),
      updatedAt: _parseTimestamp(data[AppConstants.updatedAtField]),
    );
  }

  // Convert CourseModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      AppConstants.nameField: name,
      AppConstants.trainerIdField: trainerId,
      AppConstants.courseCodeField: courseCode,
      if (description != null) 'description': description,
      AppConstants.traineesField: trainees,
      AppConstants.createdAtField: createdAt != null 
          ? Timestamp.fromDate(createdAt!) 
          : FieldValue.serverTimestamp(),
      AppConstants.updatedAtField: updatedAt != null 
          ? Timestamp.fromDate(updatedAt!) 
          : FieldValue.serverTimestamp(),
    };
  }

  // Helper method to parse timestamp
  static DateTime? _parseTimestamp(dynamic timestampData) {
    if (timestampData is Timestamp) {
      return timestampData.toDate();
    }
    return null;
  }

  // Copy with method for updating fields
  CourseModel copyWith({
    String? name,
    String? description,
    List<String>? trainees,
    DateTime? updatedAt,
  }) {
    return CourseModel(
      id: id,
      name: name ?? this.name,
      trainerId: trainerId,
      courseCode: courseCode,
      description: description ?? this.description,
      trainees: trainees ?? this.trainees,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  // Helper methods
  bool hasTrainee(String traineeId) => trainees.contains(traineeId);
  int get traineeCount => trainees.length;
  bool get hasDescription => description != null && description!.isNotEmpty;

  // Add trainee
  CourseModel addTrainee(String traineeId) {
    if (hasTrainee(traineeId)) return this;
    
    final updatedTrainees = List<String>.from(trainees)..add(traineeId);
    return copyWith(trainees: updatedTrainees);
  }

  // Remove trainee
  CourseModel removeTrainee(String traineeId) {
    if (!hasTrainee(traineeId)) return this;
    
    final updatedTrainees = List<String>.from(trainees)..remove(traineeId);
    return copyWith(trainees: updatedTrainees);
  }

  @override
  String toString() {
    return 'CourseModel(id: $id, name: $name, courseCode: $courseCode, traineeCount: $traineeCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CourseModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
