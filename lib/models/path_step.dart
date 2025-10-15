import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'path_step.freezed.dart';
part 'path_step.g.dart';

// Helper to convert Firestore Timestamps to/from DateTime
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

enum PathStepType {
  task,
  quiz,
  resource,
}

@freezed
class PathStep with _$PathStep {
  const PathStep._(); // Add this private constructor

  const factory PathStep({
    required String id,
    required String pathId,
    required String title,
    String? description, // Added description
    @Default(PathStepType.task) PathStepType type,
    String? resourceId, // Made optional as it might not always exist
    required int order,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _PathStep;

  factory PathStep.fromJson(Map<String, dynamic> json) =>
      _$PathStepFromJson(json);

  // Added fromDoc factory
  factory PathStep.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PathStep.fromJson(<String, dynamic>{...data, 'id': doc.id});
  }
}
