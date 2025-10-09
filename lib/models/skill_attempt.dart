import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'skill_attempt.freezed.dart';
part 'skill_attempt.g.dart';

@freezed
class SkillAttempt with _$SkillAttempt {
  const SkillAttempt._();
  const factory SkillAttempt({
    required String id,
    required String userId,
    required String skillCode,
    required bool success,
    @TimestampConverter() DateTime? ts,
    @Default(0) int points,
  }) = _SkillAttempt;

  factory SkillAttempt.fromJson(Map<String, dynamic> json) =>
      _$SkillAttemptFromJson(json);
  factory SkillAttempt.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) =>
      SkillAttempt.fromJson({'id': doc.id, ...?doc.data()});
}
