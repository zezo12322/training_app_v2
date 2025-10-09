import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'system_settings.freezed.dart';
part 'system_settings.g.dart';

/// Global system settings (feature flags, thresholds, etc.)
@freezed
class SystemSettings with _$SystemSettings {
  const SystemSettings._();
  const factory SystemSettings({
    required String id, // document id (e.g. "global")
    @Default({}) Map<String, dynamic> featureFlags,
    @Default({}) Map<String, dynamic> thresholds,
    @TimestampConverter() DateTime? updatedAt,
  }) = _SystemSettings;

  factory SystemSettings.fromJson(Map<String, dynamic> json) =>
      _$SystemSettingsFromJson(json);

  factory SystemSettings.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return SystemSettings.fromJson({'id': doc.id, ...data});
  }
}

extension SystemSettingsX on SystemSettings {
  bool get enforceTenantReads => featureFlags['enforceTenantReads'] == true;
  bool get enforceTenantWrites => featureFlags['enforceTenantWrites'] == true;
}
