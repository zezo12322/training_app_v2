// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchQueryImpl _$$SearchQueryImplFromJson(Map<String, dynamic> json) =>
    _$SearchQueryImpl(
      text: json['text'] as String? ?? '',
      authorId: json['authorId'] as String?,
      authorName: json['authorName'] as String?,
      startDate: const TimestampConverter().fromJson(json['startDate']),
      endDate: const TimestampConverter().fromJson(json['endDate']),
      roomId: json['roomId'] as String?,
      includeDeleted: json['includeDeleted'] as bool? ?? false,
      limit: (json['limit'] as num?)?.toInt() ?? 50,
    );

Map<String, dynamic> _$$SearchQueryImplToJson(_$SearchQueryImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'startDate': const TimestampConverter().toJson(instance.startDate),
      'endDate': const TimestampConverter().toJson(instance.endDate),
      'roomId': instance.roomId,
      'includeDeleted': instance.includeDeleted,
      'limit': instance.limit,
    };

_$SearchResultImpl _$$SearchResultImplFromJson(Map<String, dynamic> json) =>
    _$SearchResultImpl(
      messageId: json['messageId'] as String,
      content: json['content'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      authorAvatar: json['authorAvatar'] as String?,
      roomId: json['roomId'] as String,
      roomName: json['roomName'] as String?,
      createdAt: const RequiredTimestampConverter().fromJson(
        json['createdAt'] as Object,
      ),
      isDeleted: json['isDeleted'] as bool? ?? false,
      isEdited: json['isEdited'] as bool? ?? false,
      highlightedSnippets:
          (json['highlightedSnippets'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      relevance: (json['relevance'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$SearchResultImplToJson(
  _$SearchResultImpl instance,
) => <String, dynamic>{
  'messageId': instance.messageId,
  'content': instance.content,
  'authorId': instance.authorId,
  'authorName': instance.authorName,
  'authorAvatar': instance.authorAvatar,
  'roomId': instance.roomId,
  'roomName': instance.roomName,
  'createdAt': const RequiredTimestampConverter().toJson(instance.createdAt),
  'isDeleted': instance.isDeleted,
  'isEdited': instance.isEdited,
  'highlightedSnippets': instance.highlightedSnippets,
  'relevance': instance.relevance,
};

_$SearchFiltersImpl _$$SearchFiltersImplFromJson(
  Map<String, dynamic> json,
) => _$SearchFiltersImpl(
  userIds:
      (json['userIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  roomIds:
      (json['roomIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  contentTypes:
      (json['contentTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  onlyWithAttachments: json['onlyWithAttachments'] as bool? ?? false,
  onlyEdited: json['onlyEdited'] as bool? ?? false,
  onlyUnread: json['onlyUnread'] as bool? ?? false,
  sortBy:
      $enumDecodeNullable(_$SortOrderEnumMap, json['sortBy']) ??
      SortOrder.relevance,
);

Map<String, dynamic> _$$SearchFiltersImplToJson(_$SearchFiltersImpl instance) =>
    <String, dynamic>{
      'userIds': instance.userIds,
      'roomIds': instance.roomIds,
      'contentTypes': instance.contentTypes,
      'onlyWithAttachments': instance.onlyWithAttachments,
      'onlyEdited': instance.onlyEdited,
      'onlyUnread': instance.onlyUnread,
      'sortBy': _$SortOrderEnumMap[instance.sortBy]!,
    };

const _$SortOrderEnumMap = {
  SortOrder.relevance: 'relevance',
  SortOrder.newest: 'newest',
  SortOrder.oldest: 'oldest',
};
