import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'risk_user_score.freezed.dart';
part 'risk_user_score.g.dart';

@freezed
class RiskUserScore with _$RiskUserScore {
  const RiskUserScore._();
  const factory RiskUserScore({
    required String id, // userId_YYYYMMDD
    required String userId,
    required String date, // YYYY-MM-DD
    @Default(0.0) double score,
    @Default({}) Map<String, dynamic> factors,
    @Default('low') String level, // low|med|high
    @TimestampConverter() DateTime? createdAt,
  }) = _RiskUserScore;

  factory RiskUserScore.fromJson(Map<String, dynamic> json) =>
      _$RiskUserScoreFromJson(json);
  factory RiskUserScore.fromDoc(DocumentSnapshot<Map<String, dynamic>> d) =>
      RiskUserScore.fromJson({'id': d.id, ...?d.data()});
}
