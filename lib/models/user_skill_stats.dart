import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'user_skill_stats.freezed.dart';
part 'user_skill_stats.g.dart';

@freezed
class UserSkillStats with _$UserSkillStats {
  const UserSkillStats._();
  const factory UserSkillStats({
    required String id,
    required String userId,
    required String skillCode,
    @Default(0) double masteryScore,
    @Default(0) int attempts,
    @TimestampConverter() DateTime? lastUpdate,
    @Default(0) double delta14d,
    @TimestampConverter() DateTime? createdAt,
  }) = _UserSkillStats;

  factory UserSkillStats.fromJson(Map<String, dynamic> json) =>
      _$UserSkillStatsFromJson(json);
  factory UserSkillStats.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) =>
      UserSkillStats.fromJson({'id': doc.id, ...?doc.data()});
}
