// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wall_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WallCommentImpl _$$WallCommentImplFromJson(Map<String, dynamic> json) =>
    _$WallCommentImpl(
      id: json['id'] as String,
      postId: json['postId'] as String,
      courseId: json['courseId'] as String,
      authorId: json['authorId'] as String,
      content: json['content'] as String,
      authorEmail: json['authorEmail'] as String?,
      authorName: json['authorName'] as String?,
      parentCommentId: json['parentCommentId'] as String?,
      replyCount: (json['replyCount'] as num?)?.toInt() ?? 0,
      reactions:
          (json['reactions'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      reactionUsers:
          (json['reactionUsers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              (e as List<dynamic>).map((e) => e as String).toList(),
            ),
          ) ??
          const {},
      isEdited: json['isEdited'] as bool? ?? false,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$WallCommentImplToJson(_$WallCommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'courseId': instance.courseId,
      'authorId': instance.authorId,
      'content': instance.content,
      'authorEmail': instance.authorEmail,
      'authorName': instance.authorName,
      'parentCommentId': instance.parentCommentId,
      'replyCount': instance.replyCount,
      'reactions': instance.reactions,
      'reactionUsers': instance.reactionUsers,
      'isEdited': instance.isEdited,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
