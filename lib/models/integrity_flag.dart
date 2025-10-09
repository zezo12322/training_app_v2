import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'integrity_flag.freezed.dart';
part 'integrity_flag.g.dart';

@freezed
class IntegrityFlag with _$IntegrityFlag {
  const IntegrityFlag._();
  const factory IntegrityFlag({
    required String id,
    required String userId,
    required String type, // e.g. points_spike, rapid_badge_attempts
    @TimestampConverter() DateTime? ts,
    @Default('low') String severity,
    @Default({}) Map<String, dynamic> details,
    @Default(false) bool resolved,
  }) = _IntegrityFlag;

  factory IntegrityFlag.fromJson(Map<String, dynamic> json) =>
      _$IntegrityFlagFromJson(json);
  factory IntegrityFlag.fromDoc(DocumentSnapshot<Map<String, dynamic>> d) =>
      IntegrityFlag.fromJson({'id': d.id, ...?d.data()});
}
