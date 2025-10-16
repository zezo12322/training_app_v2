import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart'; // provides @TimestampConverter

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Represents an application user (trainer or trainee or elevated roles).
@freezed
class AppUser with _$AppUser {
  const AppUser._();
  const factory AppUser({
    required String id,
    required String name,
    required String email,
    // role set now includes: trainer | trainee | super_admin | org_admin | company_admin (future: manager/employee variants)
    required String
    role, // 'trainer' | 'trainee' | 'super_admin' | 'org_admin' | 'company_admin'
    @TimestampConverter() DateTime? createdAt,
    String? oneSignalPlayerId,
    // Optional profile image URL
    String? imageUrl,
    // Multi-tenancy (placeholders, may remain null for B2C phase)
    String? institutionId,
    String? companyId,
    // Blocked users list
    @Default([]) List<String> blockedUsers,
    // FCM token for push notifications
    String? fcmToken,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  factory AppUser.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    // Fallback: if 'name' is missing/null in Firestore, derive a displayable name from email prefix.
    final derivedName = (data['name'] as String?) ??
        ((data['email'] as String?)?.split('@').first ?? '');
    // Fallback: if 'role' is missing/null, use empty string (will trigger role selection)
    final safeRole = (data['role'] as String?) ?? '';
    // Fallback: if 'email' is missing/null, use empty string
    final safeEmail = (data['email'] as String?) ?? '';
    // Ensure required fields like 'id', 'name', 'role', and 'email' are present for JSON parsing.
    return AppUser.fromJson({
      ...data,
      'id': doc.id,
      'name': derivedName,
      'role': safeRole,
      'email': safeEmail,
    });
  }
}

/// Converts Firestore Timestamp to DateTime and back.
// (TimestampConverter moved to core/timestamp_converter.dart)
