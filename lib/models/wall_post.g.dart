// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wall_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WallPostImpl _$$WallPostImplFromJson(Map<String, dynamic> json) =>
    _$WallPostImpl(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      authorId: json['authorId'] as String,
      content: json['content'] as String,
      fileUrl: json['fileUrl'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$WallPostImplToJson(_$WallPostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'authorId': instance.authorId,
      'content': instance.content,
      'fileUrl': instance.fileUrl,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
