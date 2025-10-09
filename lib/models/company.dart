import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'company.freezed.dart';
part 'company.g.dart';

@freezed
class Company with _$Company {
  const Company._();
  const factory Company({
    required String id,
    required String name,
    @Default('starter') String planTier,
    @Default(true) bool active,
    @TimestampConverter() DateTime? createdAt,
    @Default({}) Map<String, dynamic> meta,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
  factory Company.fromDoc(DocumentSnapshot<Map<String, dynamic>> d) =>
      Company.fromJson({'id': d.id, ...?d.data()});
}
