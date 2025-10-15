// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_reaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageReactionImpl _$$MessageReactionImplFromJson(
  Map<String, dynamic> json,
) => _$MessageReactionImpl(
  emoji: json['emoji'] as String,
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$MessageReactionImplToJson(
  _$MessageReactionImpl instance,
) => <String, dynamic>{
  'emoji': instance.emoji,
  'userId': instance.userId,
  'userName': instance.userName,
  'createdAt': instance.createdAt.toIso8601String(),
};

_$ReactionSummaryImpl _$$ReactionSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$ReactionSummaryImpl(
  counts:
      (json['counts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
  userNames:
      (json['userNames'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ) ??
      const {},
  currentUserReactions:
      (json['currentUserReactions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ) ??
      const {},
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$ReactionSummaryImplToJson(
  _$ReactionSummaryImpl instance,
) => <String, dynamic>{
  'counts': instance.counts,
  'userNames': instance.userNames,
  'currentUserReactions': instance.currentUserReactions,
  'totalCount': instance.totalCount,
};
