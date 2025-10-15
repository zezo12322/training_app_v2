// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AchievementImpl _$$AchievementImplFromJson(Map<String, dynamic> json) =>
    _$AchievementImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      iconUrl: json['iconUrl'] as String,
      category: $enumDecode(_$AchievementCategoryEnumMap, json['category']),
      criteria: AchievementCriteria.fromJson(
        json['criteria'] as Map<String, dynamic>,
      ),
      pointsReward: (json['pointsReward'] as num?)?.toInt() ?? 0,
      isSecret: json['isSecret'] as bool? ?? false,
      courseId: json['courseId'] as String?,
    );

Map<String, dynamic> _$$AchievementImplToJson(_$AchievementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'iconUrl': instance.iconUrl,
      'category': _$AchievementCategoryEnumMap[instance.category]!,
      'criteria': instance.criteria.toJson(),
      'pointsReward': instance.pointsReward,
      'isSecret': instance.isSecret,
      'courseId': instance.courseId,
    };

const _$AchievementCategoryEnumMap = {
  AchievementCategory.modules: 'modules',
  AchievementCategory.quizzes: 'quizzes',
  AchievementCategory.social: 'social',
  AchievementCategory.streak: 'streak',
  AchievementCategory.special: 'special',
};

_$AchievementCriteriaImpl _$$AchievementCriteriaImplFromJson(
  Map<String, dynamic> json,
) => _$AchievementCriteriaImpl(
  type: json['type'] as String,
  targetValue: (json['targetValue'] as num).toInt(),
  specificId: json['specificId'] as String?,
  additionalConditions: json['additionalConditions'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$AchievementCriteriaImplToJson(
  _$AchievementCriteriaImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'targetValue': instance.targetValue,
  'specificId': instance.specificId,
  'additionalConditions': instance.additionalConditions,
};

_$UserAchievementImpl _$$UserAchievementImplFromJson(
  Map<String, dynamic> json,
) => _$UserAchievementImpl(
  achievementId: json['achievementId'] as String,
  userId: json['userId'] as String,
  courseId: json['courseId'] as String,
  unlockedAt: DateTime.parse(json['unlockedAt'] as String),
  isViewed: json['isViewed'] as bool? ?? false,
  currentProgress: (json['currentProgress'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$UserAchievementImplToJson(
  _$UserAchievementImpl instance,
) => <String, dynamic>{
  'achievementId': instance.achievementId,
  'userId': instance.userId,
  'courseId': instance.courseId,
  'unlockedAt': instance.unlockedAt.toIso8601String(),
  'isViewed': instance.isViewed,
  'currentProgress': instance.currentProgress,
};
