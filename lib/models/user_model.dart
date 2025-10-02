import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Represents an application user (trainer or trainee).
@freezed
class AppUser with _$AppUser {
  const AppUser._();
  const factory AppUser({
    required String id,
    required String name,
    required String email,
    required String role, // 'trainer' | 'trainee'
    @TimestampConverter() DateTime? createdAt,
    String? oneSignalPlayerId,
    // Optional profile image URL
    String? imageUrl,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

  factory AppUser.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return AppUser.fromJson({
      'id': doc.id,
      ...data,
    });
  }
}

/// Converts Firestore Timestamp to DateTime and back.
class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is DateTime) return json;
    return null;
  }

  @override
  Object? toJson(DateTime? object) {
    if (object == null) return null;
    return Timestamp.fromDate(object);
  }
}
