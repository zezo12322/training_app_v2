import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'skill.freezed.dart';
part 'skill.g.dart';

@freezed
class Skill with _$Skill {
  const Skill._();
  const factory Skill({
    required String id,
    required String code,
    required String name,
    String? category,
    @Default(1) int priority,
    @TimestampConverter() DateTime? createdAt,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
  factory Skill.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) =>
      Skill.fromJson({'id': doc.id, ...?doc.data()});
}
