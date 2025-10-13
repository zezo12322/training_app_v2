import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'wall_comment.freezed.dart';
part 'wall_comment.g.dart';

@freezed
class WallComment with _$WallComment {
  const WallComment._();
  const factory WallComment({
    required String id,
    required String postId,
    required String courseId,
    required String authorId,
    required String content,
    String? authorEmail,
    String? authorName,
    
    // Threading support
    String? parentCommentId, // For nested replies
    @Default(0) int replyCount,
    
    // Reactions on comments
    @Default({}) Map<String, int> reactions,
    @Default({}) Map<String, List<String>> reactionUsers,
    
    // Metadata
    @Default(false) bool isEdited,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _WallComment;

  factory WallComment.fromJson(Map<String, dynamic> json) =>
      _$WallCommentFromJson(json);

  factory WallComment.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return WallComment.fromJson({'id': doc.id, ...data});
  }
  
  // Helpers
  int get totalReactions => reactions.values.fold(0, (s, c) => s + c);
  bool hasUserReacted(String userId, String emoji) {
    return reactionUsers[emoji]?.contains(userId) ?? false;
  }
  bool get isReply => parentCommentId != null;
}
