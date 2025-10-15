// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseAnalyticsImpl _$$CourseAnalyticsImplFromJson(
  Map<String, dynamic> json,
) => _$CourseAnalyticsImpl(
  courseId: json['courseId'] as String,
  totalStudents: (json['totalStudents'] as num).toInt(),
  activeStudents: (json['activeStudents'] as num).toInt(),
  avgPoints: (json['avgPoints'] as num).toDouble(),
  avgLevel: (json['avgLevel'] as num).toDouble(),
  activityBreakdown: Map<String, int>.from(json['activityBreakdown'] as Map),
  topStudents: (json['topStudents'] as List<dynamic>)
      .map((e) => TopStudent.fromJson(e as Map<String, dynamic>))
      .toList(),
  engagementRate: (json['engagementRate'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
  totalPointsAwarded: (json['totalPointsAwarded'] as num?)?.toInt() ?? 0,
  totalAchievementsUnlocked:
      (json['totalAchievementsUnlocked'] as num?)?.toInt() ?? 0,
  lastUpdated: json['lastUpdated'] == null
      ? null
      : DateTime.parse(json['lastUpdated'] as String),
);

Map<String, dynamic> _$$CourseAnalyticsImplToJson(
  _$CourseAnalyticsImpl instance,
) => <String, dynamic>{
  'courseId': instance.courseId,
  'totalStudents': instance.totalStudents,
  'activeStudents': instance.activeStudents,
  'avgPoints': instance.avgPoints,
  'avgLevel': instance.avgLevel,
  'activityBreakdown': instance.activityBreakdown,
  'topStudents': instance.topStudents.map((e) => e.toJson()).toList(),
  'engagementRate': instance.engagementRate,
  'totalPointsAwarded': instance.totalPointsAwarded,
  'totalAchievementsUnlocked': instance.totalAchievementsUnlocked,
  'lastUpdated': instance.lastUpdated?.toIso8601String(),
};

_$TopStudentImpl _$$TopStudentImplFromJson(Map<String, dynamic> json) =>
    _$TopStudentImpl(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      points: (json['points'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      userAvatar: json['userAvatar'] as String?,
      rank: (json['rank'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$TopStudentImplToJson(_$TopStudentImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'points': instance.points,
      'level': instance.level,
      'userAvatar': instance.userAvatar,
      'rank': instance.rank,
    };

_$ActivityStatsImpl _$$ActivityStatsImplFromJson(Map<String, dynamic> json) =>
    _$ActivityStatsImpl(
      activityType: json['activityType'] as String,
      count: (json['count'] as num).toInt(),
      percentage: (json['percentage'] as num).toDouble(),
      totalPoints: (json['totalPoints'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ActivityStatsImplToJson(_$ActivityStatsImpl instance) =>
    <String, dynamic>{
      'activityType': instance.activityType,
      'count': instance.count,
      'percentage': instance.percentage,
      'totalPoints': instance.totalPoints,
    };
