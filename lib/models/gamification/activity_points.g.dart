// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_points.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityPointsImpl _$$ActivityPointsImplFromJson(Map<String, dynamic> json) =>
    _$ActivityPointsImpl(
      completingLesson: (json['completingLesson'] as num?)?.toInt() ?? 10,
      passingQuiz: (json['passingQuiz'] as num?)?.toInt() ?? 20,
      perfectQuizScore: (json['perfectQuizScore'] as num?)?.toInt() ?? 50,
      completingAssignment:
          (json['completingAssignment'] as num?)?.toInt() ?? 30,
      completingModule: (json['completingModule'] as num?)?.toInt() ?? 100,
      creatingPost: (json['creatingPost'] as num?)?.toInt() ?? 5,
      commentingOnPost: (json['commentingOnPost'] as num?)?.toInt() ?? 2,
      helpingPeer: (json['helpingPeer'] as num?)?.toInt() ?? 15,
      receivingReaction: (json['receivingReaction'] as num?)?.toInt() ?? 1,
      dailyStreak: (json['dailyStreak'] as num?)?.toInt() ?? 5,
      weeklyStreak: (json['weeklyStreak'] as num?)?.toInt() ?? 50,
      enableSocialPoints: json['enableSocialPoints'] as bool? ?? false,
      enableDailyStreak: json['enableDailyStreak'] as bool? ?? false,
    );

Map<String, dynamic> _$$ActivityPointsImplToJson(
  _$ActivityPointsImpl instance,
) => <String, dynamic>{
  'completingLesson': instance.completingLesson,
  'passingQuiz': instance.passingQuiz,
  'perfectQuizScore': instance.perfectQuizScore,
  'completingAssignment': instance.completingAssignment,
  'completingModule': instance.completingModule,
  'creatingPost': instance.creatingPost,
  'commentingOnPost': instance.commentingOnPost,
  'helpingPeer': instance.helpingPeer,
  'receivingReaction': instance.receivingReaction,
  'dailyStreak': instance.dailyStreak,
  'weeklyStreak': instance.weeklyStreak,
  'enableSocialPoints': instance.enableSocialPoints,
  'enableDailyStreak': instance.enableDailyStreak,
};
