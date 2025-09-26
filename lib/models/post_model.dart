import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/app_constants.dart';

class PostModel {
  final String id;
  final String courseId;
  final String content;
  final String authorId;
  final String? authorEmail;
  final String? authorName;
  final String? authorImageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PostModel({
    required this.id,
    required this.courseId,
    required this.content,
    required this.authorId,
    this.authorEmail,
    this.authorName,
    this.authorImageUrl,
    this.createdAt,
    this.updatedAt,
  });

  // Create PostModel from Firestore document
  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return PostModel(
      id: doc.id,
      courseId: data[AppConstants.courseIdField] ?? '',
      content: data[AppConstants.contentField] ?? '',
      authorId: data[AppConstants.authorIdField] ?? '',
      authorEmail: data[AppConstants.authorEmailField],
      authorName: data[AppConstants.authorNameField],
      authorImageUrl: data[AppConstants.authorImageUrlField],
      createdAt: _parseTimestamp(data[AppConstants.createdAtField]),
      updatedAt: _parseTimestamp(data[AppConstants.updatedAtField]),
    );
  }

  // Create PostModel from Map
  factory PostModel.fromMap(Map<String, dynamic> data, String id) {
    return PostModel(
      id: id,
      courseId: data[AppConstants.courseIdField] ?? '',
      content: data[AppConstants.contentField] ?? '',
      authorId: data[AppConstants.authorIdField] ?? '',
      authorEmail: data[AppConstants.authorEmailField],
      authorName: data[AppConstants.authorNameField],
      authorImageUrl: data[AppConstants.authorImageUrlField],
      createdAt: _parseTimestamp(data[AppConstants.createdAtField]),
      updatedAt: _parseTimestamp(data[AppConstants.updatedAtField]),
    );
  }

  // Convert PostModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      AppConstants.courseIdField: courseId,
      AppConstants.contentField: content,
      AppConstants.authorIdField: authorId,
      if (authorEmail != null) AppConstants.authorEmailField: authorEmail,
      if (authorName != null) AppConstants.authorNameField: authorName,
      if (authorImageUrl != null) AppConstants.authorImageUrlField: authorImageUrl,
      AppConstants.createdAtField: createdAt != null 
          ? Timestamp.fromDate(createdAt!) 
          : FieldValue.serverTimestamp(),
      AppConstants.updatedAtField: updatedAt != null 
          ? Timestamp.fromDate(updatedAt!) 
          : FieldValue.serverTimestamp(),
    };
  }

  // Helper method to parse timestamp
  static DateTime? _parseTimestamp(dynamic timestampData) {
    if (timestampData is Timestamp) {
      return timestampData.toDate();
    }
    return null;
  }

  // Copy with method for updating fields
  PostModel copyWith({
    String? content,
    String? authorName,
    String? authorImageUrl,
    DateTime? updatedAt,
  }) {
    return PostModel(
      id: id,
      courseId: courseId,
      content: content ?? this.content,
      authorId: authorId,
      authorEmail: authorEmail,
      authorName: authorName ?? this.authorName,
      authorImageUrl: authorImageUrl ?? this.authorImageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  // Helper methods
  String get displayAuthor => authorName ?? authorEmail ?? 'غير معروف';
  bool get hasAuthorImage => authorImageUrl != null && authorImageUrl!.isNotEmpty;
  bool isAuthoredBy(String userId) => authorId == userId;

  @override
  String toString() {
    return 'PostModel(id: $id, courseId: $courseId, author: $displayAuthor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PostModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
