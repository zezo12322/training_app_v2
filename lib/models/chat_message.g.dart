// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as String,
      chatRoomId: json['chatRoomId'] as String,
      courseId: json['courseId'] as String,
      institutionId: json['institutionId'] as String,
      companyId: json['companyId'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      authorRole: json['authorRole'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      deletedAt: const TimestampConverter().fromJson(json['deletedAt']),
      isEdited: json['isEdited'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      readBy:
          (json['readBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      parentMessageId: json['parentMessageId'] as String?,
      threadCount: (json['threadCount'] as num?)?.toInt() ?? 0,
      hasThread: json['hasThread'] as bool? ?? false,
      isFlagged: json['isFlagged'] as bool? ?? false,
      isModerated: json['isModerated'] as bool? ?? false,
      moderatedBy: json['moderatedBy'] as String?,
      moderationReason: json['moderationReason'] as String?,
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatRoomId': instance.chatRoomId,
      'courseId': instance.courseId,
      'institutionId': instance.institutionId,
      'companyId': instance.companyId,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorRole': instance.authorRole,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'deletedAt': const TimestampConverter().toJson(instance.deletedAt),
      'isEdited': instance.isEdited,
      'isDeleted': instance.isDeleted,
      'readBy': instance.readBy,
      'parentMessageId': instance.parentMessageId,
      'threadCount': instance.threadCount,
      'hasThread': instance.hasThread,
      'isFlagged': instance.isFlagged,
      'isModerated': instance.isModerated,
      'moderatedBy': instance.moderatedBy,
      'moderationReason': instance.moderationReason,
    };

_$CreateChatMessageDtoImpl _$$CreateChatMessageDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CreateChatMessageDtoImpl(
  chatRoomId: json['chatRoomId'] as String,
  courseId: json['courseId'] as String,
  institutionId: json['institutionId'] as String,
  companyId: json['companyId'] as String,
  authorId: json['authorId'] as String,
  authorName: json['authorName'] as String,
  authorRole: json['authorRole'] as String,
  content: json['content'] as String,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$$CreateChatMessageDtoImplToJson(
  _$CreateChatMessageDtoImpl instance,
) => <String, dynamic>{
  'chatRoomId': instance.chatRoomId,
  'courseId': instance.courseId,
  'institutionId': instance.institutionId,
  'companyId': instance.companyId,
  'authorId': instance.authorId,
  'authorName': instance.authorName,
  'authorRole': instance.authorRole,
  'content': instance.content,
  'imageUrl': instance.imageUrl,
};
