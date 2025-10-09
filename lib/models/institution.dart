import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'institution.freezed.dart';
part 'institution.g.dart';

@freezed
class Institution with _$Institution {
  const Institution._();
  const factory Institution({
    required String id,
    required String name,
    @Default('free') String planTier,
    @Default(true) bool active,
    @TimestampConverter() DateTime? createdAt,
    @Default({}) Map<String, dynamic> meta,
  }) = _Institution;

  factory Institution.fromJson(Map<String, dynamic> json) =>
      _$InstitutionFromJson(json);
  factory Institution.fromDoc(DocumentSnapshot<Map<String, dynamic>> d) =>
      Institution.fromJson({'id': d.id, ...?d.data()});
}
