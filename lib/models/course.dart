import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
    return Course.fromJson({
      'id': doc.id,
      ...data,
    });
  }
}

class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();
  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is DateTime) return json;
    return null;
  }
  @override
  Object? toJson(DateTime? object) {
    if (object == null) return null;
    return Timestamp.fromDate(object);
  }
}
