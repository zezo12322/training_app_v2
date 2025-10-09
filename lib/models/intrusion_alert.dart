import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'intrusion_alert.freezed.dart';
part 'intrusion_alert.g.dart';

@freezed
class IntrusionAlert with _$IntrusionAlert {
  const IntrusionAlert._();
  const factory IntrusionAlert({
    required String id,
    required String vector,
    required String category, // auth|rules|integrity|enumeration|automation
    @TimestampConverter() DateTime? firstSeen,
    @TimestampConverter() DateTime? lastSeen,
    @Default(0) int count,
    @Default('open') String status, // open|resolved|muted
    @Default('low') String severity, // low|med|high
    @Default(<String>[]) List<String> impactedUsers,
    @Default({}) Map<String, dynamic> meta,
  }) = _IntrusionAlert;

  factory IntrusionAlert.fromJson(Map<String, dynamic> json) =>
      _$IntrusionAlertFromJson(json);
  factory IntrusionAlert.fromDoc(DocumentSnapshot<Map<String, dynamic>> d) =>
      IntrusionAlert.fromJson({'id': d.id, ...?d.data()});
}
