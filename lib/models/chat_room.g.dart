// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomImpl _$$ChatRoomImplFromJson(Map<String, dynamic> json) =>
    _$ChatRoomImpl(
      id: json['id'] as String,
      type: $enumDecode(_$ChatRoomTypeEnumMap, json['type']),
      courseId: json['courseId'] as String?,
      courseName: json['courseName'] as String?,
      institutionId: json['institutionId'] as String,
      companyId: json['companyId'] as String,
      participantIds: (json['participantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      lastMessageContent: json['lastMessageContent'] as String?,
      lastMessageAuthor: json['lastMessageAuthor'] as String?,
      lastMessageAt: const TimestampConverter().fromJson(json['lastMessageAt']),
      unreadCounts:
          (json['unreadCounts'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      isActive: json['isActive'] as bool? ?? true,
      isArchived: json['isArchived'] as bool? ?? false,
      isMuted: json['isMuted'] as bool? ?? false,
      mutedBy:
          (json['mutedBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      blockedUsers:
          (json['blockedUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ChatRoomImplToJson(
  _$ChatRoomImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$ChatRoomTypeEnumMap[instance.type]!,
  'courseId': instance.courseId,
  'courseName': instance.courseName,
  'institutionId': instance.institutionId,
  'companyId': instance.companyId,
  'participantIds': instance.participantIds,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'lastMessageContent': instance.lastMessageContent,
  'lastMessageAuthor': instance.lastMessageAuthor,
  'lastMessageAt': const TimestampConverter().toJson(instance.lastMessageAt),
  'unreadCounts': instance.unreadCounts,
  'isActive': instance.isActive,
  'isArchived': instance.isArchived,
  'isMuted': instance.isMuted,
  'mutedBy': instance.mutedBy,
  'blockedUsers': instance.blockedUsers,
};

const _$ChatRoomTypeEnumMap = {
  ChatRoomType.course: 'course',
  ChatRoomType.direct: 'direct',
  ChatRoomType.group: 'group',
};

_$CreateChatRoomDtoImpl _$$CreateChatRoomDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CreateChatRoomDtoImpl(
  type: $enumDecode(_$ChatRoomTypeEnumMap, json['type']),
  courseId: json['courseId'] as String?,
  courseName: json['courseName'] as String?,
  institutionId: json['institutionId'] as String,
  companyId: json['companyId'] as String,
  participantIds: (json['participantIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$$CreateChatRoomDtoImplToJson(
  _$CreateChatRoomDtoImpl instance,
) => <String, dynamic>{
  'type': _$ChatRoomTypeEnumMap[instance.type]!,
  'courseId': instance.courseId,
  'courseName': instance.courseName,
  'institutionId': instance.institutionId,
  'companyId': instance.companyId,
  'participantIds': instance.participantIds,
};
