import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/app_constants.dart';

enum UserRole { trainer, trainee }

class UserModel {
  final String uid;
  final String name;
  final String email;
  final UserRole role;
  final String? imageUrl;
  final String? oneSignalPlayerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.imageUrl,
    this.oneSignalPlayerId,
    this.createdAt,
    this.updatedAt,
  });

  // Create UserModel from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return UserModel(
      uid: doc.id,
      name: data[AppConstants.nameField] ?? '',
      email: data[AppConstants.emailField] ?? '',
      role: _parseRole(data[AppConstants.roleField]),
      imageUrl: data['imageUrl'],
      oneSignalPlayerId: data[AppConstants.oneSignalPlayerIdField],
      createdAt: _parseTimestamp(data[AppConstants.createdAtField]),
      updatedAt: _parseTimestamp(data[AppConstants.updatedAtField]),
    );
  }

  // Create UserModel from Map
  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      name: data[AppConstants.nameField] ?? '',
      email: data[AppConstants.emailField] ?? '',
      role: _parseRole(data[AppConstants.roleField]),
      imageUrl: data['imageUrl'],
      oneSignalPlayerId: data[AppConstants.oneSignalPlayerIdField],
      createdAt: _parseTimestamp(data[AppConstants.createdAtField]),
      updatedAt: _parseTimestamp(data[AppConstants.updatedAtField]),
    );
  }

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      AppConstants.uidField: uid,
      AppConstants.nameField: name,
      AppConstants.emailField: email,
      AppConstants.roleField: role == UserRole.trainer 
          ? AppConstants.trainerRole 
          : AppConstants.traineeRole,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (oneSignalPlayerId != null) 
        AppConstants.oneSignalPlayerIdField: oneSignalPlayerId,
      AppConstants.createdAtField: createdAt != null 
          ? Timestamp.fromDate(createdAt!) 
          : FieldValue.serverTimestamp(),
      AppConstants.updatedAtField: updatedAt != null 
          ? Timestamp.fromDate(updatedAt!) 
          : FieldValue.serverTimestamp(),
    };
  }

  // Helper method to parse role from string
  static UserRole _parseRole(dynamic roleData) {
    if (roleData == AppConstants.trainerRole) {
      return UserRole.trainer;
    }
    return UserRole.trainee;
  }

  // Helper method to parse timestamp
  static DateTime? _parseTimestamp(dynamic timestampData) {
    if (timestampData is Timestamp) {
      return timestampData.toDate();
    }
    return null;
  }

  // Copy with method for updating fields
  UserModel copyWith({
    String? name,
    String? email,
    UserRole? role,
    String? imageUrl,
    String? oneSignalPlayerId,
    DateTime? updatedAt,
  }) {
    return UserModel(
      uid: uid,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
      oneSignalPlayerId: oneSignalPlayerId ?? this.oneSignalPlayerId,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  // Getters for convenience
  bool get isTrainer => role == UserRole.trainer;
  bool get isTrainee => role == UserRole.trainee;
  String get roleString => role == UserRole.trainer 
      ? AppConstants.trainerRole 
      : AppConstants.traineeRole;

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, role: $roleString)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.uid == uid;
  }

  @override
  int get hashCode => uid.hashCode;
}
