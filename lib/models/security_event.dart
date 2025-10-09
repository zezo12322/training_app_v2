import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'security_event.freezed.dart';
part 'security_event.g.dart';

@freezed
class SecurityEvent with _$SecurityEvent {
  const SecurityEvent._();
  const factory SecurityEvent({
    required String id,
    required String type, // e.g. permission_denied, payload_suspect
    required String vector, // taxonomy code PRIV_ESC, ENUM_DOC, etc.
    String? docPath,
    @Default('low') String severity,
    @TimestampConverter() DateTime? ts,
    @Default({}) Map<String, dynamic> meta,
  }) = _SecurityEvent;

  factory SecurityEvent.fromJson(Map<String, dynamic> json) =>
      _$SecurityEventFromJson(json);

  factory SecurityEvent.fromDoc(DocumentSnapshot<Map<String, dynamic>> d) {
    final data = d.data() ?? {};
    return SecurityEvent.fromJson({'id': d.id, ...data});
  }
}
