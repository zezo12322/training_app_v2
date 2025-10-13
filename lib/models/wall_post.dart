import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wall_post.freezed.dart';
part 'wall_post.g.dart';

@freezed
class WallPost with _$WallPost {
  const WallPost._();
  const factory WallPost({
    required String id,
    required String courseId,
    required String authorId,
    required String content,
    String? authorEmail,
    String? authorName,
    String? fileUrl,
    String? imageUrl,
    @Default([]) List<String> imageUrls, // Multiple images support
    
    // Enhanced features
    @Default(false) bool isPinned,
    @Default(false) bool isArchived,
    @Default(false) bool isEdited,
    @Default({}) Map<String, int> reactions, // {'👍': 5, '❤️': 3}
    @Default({}) Map<String, List<String>> reactionUsers, // {'👍': ['uid1', 'uid2']}
    @Default(0) int commentCount,
    
    // Poll support (optional)
    Map<String, dynamic>? poll,
    
    // Metadata
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? pinnedAt,
  }) = _WallPost;

  factory WallPost.fromJson(Map<String, dynamic> json) =>
      _$WallPostFromJson(json);

  factory WallPost.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return WallPost.fromJson({'id': doc.id, ...data});
  }
  
  // Helpers
  int get totalReactions => reactions.values.fold(0, (s, c) => s + c);
  bool hasUserReacted(String userId, String emoji) {
    return reactionUsers[emoji]?.contains(userId) ?? false;
  }
}

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
