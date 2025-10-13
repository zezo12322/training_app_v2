// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wall_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WallPostImpl _$$WallPostImplFromJson(
  Map<String, dynamic> json,
) => _$WallPostImpl(
  id: json['id'] as String,
  courseId: json['courseId'] as String,
  authorId: json['authorId'] as String,
  content: json['content'] as String,
  authorEmail: json['authorEmail'] as String?,
  authorName: json['authorName'] as String?,
  fileUrl: json['fileUrl'] as String?,
  imageUrl: json['imageUrl'] as String?,
  imageUrls:
      (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isPinned: json['isPinned'] as bool? ?? false,
  isArchived: json['isArchived'] as bool? ?? false,
  isEdited: json['isEdited'] as bool? ?? false,
  reactions:
      (json['reactions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
  reactionUsers:
      (json['reactionUsers'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ) ??
      const {},
  commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
  poll: json['poll'] as Map<String, dynamic>?,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  pinnedAt: const TimestampConverter().fromJson(json['pinnedAt']),
);

Map<String, dynamic> _$$WallPostImplToJson(_$WallPostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'authorId': instance.authorId,
      'content': instance.content,
      'authorEmail': instance.authorEmail,
      'authorName': instance.authorName,
      'fileUrl': instance.fileUrl,
      'imageUrl': instance.imageUrl,
      'imageUrls': instance.imageUrls,
      'isPinned': instance.isPinned,
      'isArchived': instance.isArchived,
      'isEdited': instance.isEdited,
      'reactions': instance.reactions,
      'reactionUsers': instance.reactionUsers,
      'commentCount': instance.commentCount,
      'poll': instance.poll,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'pinnedAt': const TimestampConverter().toJson(instance.pinnedAt),
    };
