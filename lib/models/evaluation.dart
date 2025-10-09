import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'evaluation.freezed.dart';
part 'evaluation.g.dart';

@freezed
class EvaluationModel with _$EvaluationModel {
  const EvaluationModel._();
  const factory EvaluationModel({
    required String id,
    required String courseId,
    required String traineeId,
    required String trainerId,
    required int score,
    required String feedback,
    String? audioUrl,
    @TimestampConverter() DateTime? createdAt,
  }) = _EvaluationModel;

  factory EvaluationModel.fromJson(Map<String, dynamic> json) =>
      _$EvaluationModelFromJson(json);

  factory EvaluationModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return EvaluationModel.fromJson({'id': doc.id, ...data});
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
