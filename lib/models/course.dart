import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'course.freezed.dart';
part 'course.g.dart';

@freezed
class Course with _$Course {
  const Course._();
  const factory Course({
    required String id,
    required String name,
    required String trainerId,
    required String courseCode,
    @Default([]) List<String> trainees,
    @TimestampConverter() DateTime? createdAt,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  factory Course.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return Course.fromJson({'id': doc.id, ...data});
  }
}

// (TimestampConverter moved to core/timestamp_converter.dart)
