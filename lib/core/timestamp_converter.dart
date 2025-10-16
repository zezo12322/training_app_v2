import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Shared Firestore <-> DateTime nullable converter used by models.
class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is DateTime) return json;
    return null; // unsupported type
  }

  @override
  Object? toJson(DateTime? object) {
    if (object == null) return null;
    return Timestamp.fromDate(object);
  }
}

/// Non-nullable Firestore Timestamp <-> DateTime converter.
/// Use this for required DateTime fields that must convert to/from Firestore Timestamp.
class RequiredTimestampConverter implements JsonConverter<DateTime, Object> {
  const RequiredTimestampConverter();

  @override
  DateTime fromJson(Object json) {
    if (json is Timestamp) return json.toDate();
    if (json is DateTime) return json;
    if (json is String) return DateTime.parse(json); // fallback for ISO strings
    throw ArgumentError('Cannot convert $json to DateTime');
  }

  @override
  Object toJson(DateTime object) {
    return Timestamp.fromDate(object);
  }
}
