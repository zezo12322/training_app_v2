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
    String? fileUrl,
    @TimestampConverter() DateTime? createdAt,
  }) = _WallPost;

  factory WallPost.fromJson(Map<String, dynamic> json) =>
      _$WallPostFromJson(json);

  factory WallPost.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return WallPost.fromJson({'id': doc.id, ...data});
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
