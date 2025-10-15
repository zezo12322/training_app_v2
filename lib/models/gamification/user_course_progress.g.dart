// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_course_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserCourseProgressImpl _$$UserCourseProgressImplFromJson(
  Map<String, dynamic> json,
) => _$UserCourseProgressImpl(
  userId: json['userId'] as String,
  courseId: json['courseId'] as String,
  totalPoints: (json['totalPoints'] as num?)?.toInt() ?? 0,
  currentLevel: (json['currentLevel'] as num?)?.toInt() ?? 1,
  pointsToNextLevel: (json['pointsToNextLevel'] as num?)?.toInt() ?? 100,
  activityCounts:
      (json['activityCounts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
  earnedBadges:
      (json['earnedBadges'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  lastActivityAt: DateTime.parse(json['lastActivityAt'] as String),
  dailyStreakCount: (json['dailyStreakCount'] as num?)?.toInt() ?? 0,
  longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
  lastStreakCheckDate: const TimestampConverter().fromJson(
    json['lastStreakCheckDate'],
  ),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$UserCourseProgressImplToJson(
  _$UserCourseProgressImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'courseId': instance.courseId,
  'totalPoints': instance.totalPoints,
  'currentLevel': instance.currentLevel,
  'pointsToNextLevel': instance.pointsToNextLevel,
  'activityCounts': instance.activityCounts,
  'earnedBadges': instance.earnedBadges,
  'lastActivityAt': instance.lastActivityAt.toIso8601String(),
  'dailyStreakCount': instance.dailyStreakCount,
  'longestStreak': instance.longestStreak,
  'lastStreakCheckDate': const TimestampConverter().toJson(
    instance.lastStreakCheckDate,
  ),
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
};

_$ProgressStatsImpl _$$ProgressStatsImplFromJson(
  Map<String, dynamic> json,
) => _$ProgressStatsImpl(
  totalLessonsCompleted: (json['totalLessonsCompleted'] as num?)?.toInt() ?? 0,
  totalQuizzesPassed: (json['totalQuizzesPassed'] as num?)?.toInt() ?? 0,
  perfectQuizzes: (json['perfectQuizzes'] as num?)?.toInt() ?? 0,
  totalAssignmentsCompleted:
      (json['totalAssignmentsCompleted'] as num?)?.toInt() ?? 0,
  totalModulesCompleted: (json['totalModulesCompleted'] as num?)?.toInt() ?? 0,
  totalPosts: (json['totalPosts'] as num?)?.toInt() ?? 0,
  totalComments: (json['totalComments'] as num?)?.toInt() ?? 0,
  helpfulCommentsCount: (json['helpfulCommentsCount'] as num?)?.toInt() ?? 0,
  averageQuizScore: (json['averageQuizScore'] as num?)?.toDouble() ?? 0.0,
  longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
  totalLearningMinutes: (json['totalLearningMinutes'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$ProgressStatsImplToJson(_$ProgressStatsImpl instance) =>
    <String, dynamic>{
      'totalLessonsCompleted': instance.totalLessonsCompleted,
      'totalQuizzesPassed': instance.totalQuizzesPassed,
      'perfectQuizzes': instance.perfectQuizzes,
      'totalAssignmentsCompleted': instance.totalAssignmentsCompleted,
      'totalModulesCompleted': instance.totalModulesCompleted,
      'totalPosts': instance.totalPosts,
      'totalComments': instance.totalComments,
      'helpfulCommentsCount': instance.helpfulCommentsCount,
      'averageQuizScore': instance.averageQuizScore,
      'longestStreak': instance.longestStreak,
      'totalLearningMinutes': instance.totalLearningMinutes,
    };
