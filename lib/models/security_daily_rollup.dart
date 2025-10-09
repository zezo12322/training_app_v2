import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'security_daily_rollup.freezed.dart';
part 'security_daily_rollup.g.dart';

@freezed
class SecurityDailyRollup with _$SecurityDailyRollup {
  const SecurityDailyRollup._();
  const factory SecurityDailyRollup({
    required String id, // date string YYYY-MM-DD
    required String date,
    @Default(0) int totalEvents,
    @Default(0) int permissionDenied,
    @Default(0) int privilegeEscalation,
    @Default(0) int suspectPayload,
    @Default(0) int highSeverity,
    @Default(0) int distinctUsers,
    @TimestampConverter() DateTime? computedAt,
    @Default({}) Map<String, dynamic> meta, // e.g. topVectors: {PRIV_ESC:5,...}
  }) = _SecurityDailyRollup;

  factory SecurityDailyRollup.fromJson(Map<String, dynamic> json) =>
      _$SecurityDailyRollupFromJson(json);
  factory SecurityDailyRollup.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> d,
  ) => SecurityDailyRollup.fromJson({'id': d.id, ...?d.data()});
}
