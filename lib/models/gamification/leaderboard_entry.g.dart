// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaderboardEntryImpl _$$LeaderboardEntryImplFromJson(
  Map<String, dynamic> json,
) => _$LeaderboardEntryImpl(
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  userAvatar: json['userAvatar'] as String?,
  totalPoints: (json['totalPoints'] as num).toInt(),
  currentLevel: (json['currentLevel'] as num).toInt(),
  levelName: json['levelName'] as String,
  rank: (json['rank'] as num).toInt(),
  moduleCount: (json['moduleCount'] as num?)?.toInt() ?? 0,
  quizCount: (json['quizCount'] as num?)?.toInt() ?? 0,
  streakCount: (json['streakCount'] as num?)?.toInt() ?? 0,
  lastActivity: json['lastActivity'] == null
      ? null
      : DateTime.parse(json['lastActivity'] as String),
);

Map<String, dynamic> _$$LeaderboardEntryImplToJson(
  _$LeaderboardEntryImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'userName': instance.userName,
  'userAvatar': instance.userAvatar,
  'totalPoints': instance.totalPoints,
  'currentLevel': instance.currentLevel,
  'levelName': instance.levelName,
  'rank': instance.rank,
  'moduleCount': instance.moduleCount,
  'quizCount': instance.quizCount,
  'streakCount': instance.streakCount,
  'lastActivity': instance.lastActivity?.toIso8601String(),
};
