// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecommendationImpl _$$RecommendationImplFromJson(Map<String, dynamic> json) =>
    _$RecommendationImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      courseId: json['courseId'] as String,
      type: $enumDecode(_$RecommendationTypeEnumMap, json['type']),
      reason: $enumDecode(_$RecommendationReasonEnumMap, json['reason']),
      contentId: json['contentId'] as String,
      contentTitle: json['contentTitle'] as String,
      description: json['description'] as String? ?? '',
      priority: (json['priority'] as num?)?.toInt() ?? 50,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.5,
      estimatedMinutes: (json['estimatedMinutes'] as num?)?.toInt(),
      difficulty: json['difficulty'] as String? ?? 'متوسط',
      isViewed: json['isViewed'] as bool? ?? false,
      isAccepted: json['isAccepted'] as bool? ?? false,
      isDismissed: json['isDismissed'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: const RequiredTimestampConverter().fromJson(
        json['createdAt'] as Object,
      ),
      expiresAt: const TimestampConverter().fromJson(json['expiresAt']),
      viewedAt: const TimestampConverter().fromJson(json['viewedAt']),
      acceptedAt: const TimestampConverter().fromJson(json['acceptedAt']),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$RecommendationImplToJson(
  _$RecommendationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'courseId': instance.courseId,
  'type': _$RecommendationTypeEnumMap[instance.type]!,
  'reason': _$RecommendationReasonEnumMap[instance.reason]!,
  'contentId': instance.contentId,
  'contentTitle': instance.contentTitle,
  'description': instance.description,
  'priority': instance.priority,
  'confidence': instance.confidence,
  'estimatedMinutes': instance.estimatedMinutes,
  'difficulty': instance.difficulty,
  'isViewed': instance.isViewed,
  'isAccepted': instance.isAccepted,
  'isDismissed': instance.isDismissed,
  'isCompleted': instance.isCompleted,
  'createdAt': const RequiredTimestampConverter().toJson(instance.createdAt),
  'expiresAt': const TimestampConverter().toJson(instance.expiresAt),
  'viewedAt': const TimestampConverter().toJson(instance.viewedAt),
  'acceptedAt': const TimestampConverter().toJson(instance.acceptedAt),
  'metadata': instance.metadata,
};

const _$RecommendationTypeEnumMap = {
  RecommendationType.lesson: 'lesson',
  RecommendationType.quiz: 'quiz',
  RecommendationType.assignment: 'assignment',
  RecommendationType.module: 'module',
  RecommendationType.review: 'review',
  RecommendationType.challenge: 'challenge',
};

const _$RecommendationReasonEnumMap = {
  RecommendationReason.weakPerformance: 'weakPerformance',
  RecommendationReason.interests: 'interests',
  RecommendationReason.nextStep: 'nextStep',
  RecommendationReason.skillGap: 'skillGap',
  RecommendationReason.popularWithPeers: 'popularWithPeers',
  RecommendationReason.pathCompletion: 'pathCompletion',
  RecommendationReason.strengthenSkill: 'strengthenSkill',
};

_$RecommendationCriteriaImpl _$$RecommendationCriteriaImplFromJson(
  Map<String, dynamic> json,
) => _$RecommendationCriteriaImpl(
  userId: json['userId'] as String,
  courseId: json['courseId'] as String,
  preferredTypes:
      (json['preferredTypes'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$RecommendationTypeEnumMap, e))
          .toList() ??
      const [],
  targetSkills:
      (json['targetSkills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  preferredDifficulty: json['preferredDifficulty'] as String? ?? 'متوسط',
  maxTimeAvailable: (json['maxTimeAvailable'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt() ?? 5,
  excludeCompleted: json['excludeCompleted'] as bool? ?? true,
  excludeDismissed: json['excludeDismissed'] as bool? ?? true,
);

Map<String, dynamic> _$$RecommendationCriteriaImplToJson(
  _$RecommendationCriteriaImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'courseId': instance.courseId,
  'preferredTypes': instance.preferredTypes
      .map((e) => _$RecommendationTypeEnumMap[e]!)
      .toList(),
  'targetSkills': instance.targetSkills,
  'preferredDifficulty': instance.preferredDifficulty,
  'maxTimeAvailable': instance.maxTimeAvailable,
  'limit': instance.limit,
  'excludeCompleted': instance.excludeCompleted,
  'excludeDismissed': instance.excludeDismissed,
};

_$RecommendationStatsImpl _$$RecommendationStatsImplFromJson(
  Map<String, dynamic> json,
) => _$RecommendationStatsImpl(
  totalRecommendations: (json['totalRecommendations'] as num?)?.toInt() ?? 0,
  viewedRecommendations: (json['viewedRecommendations'] as num?)?.toInt() ?? 0,
  acceptedRecommendations:
      (json['acceptedRecommendations'] as num?)?.toInt() ?? 0,
  dismissedRecommendations:
      (json['dismissedRecommendations'] as num?)?.toInt() ?? 0,
  completedRecommendations:
      (json['completedRecommendations'] as num?)?.toInt() ?? 0,
  acceptanceRate: (json['acceptanceRate'] as num?)?.toDouble() ?? 0.0,
  completionRate: (json['completionRate'] as num?)?.toDouble() ?? 0.0,
  avgTimeToAccept: (json['avgTimeToAccept'] as num?)?.toDouble() ?? 0.0,
  avgConfidence: (json['avgConfidence'] as num?)?.toDouble() ?? 0.5,
);

Map<String, dynamic> _$$RecommendationStatsImplToJson(
  _$RecommendationStatsImpl instance,
) => <String, dynamic>{
  'totalRecommendations': instance.totalRecommendations,
  'viewedRecommendations': instance.viewedRecommendations,
  'acceptedRecommendations': instance.acceptedRecommendations,
  'dismissedRecommendations': instance.dismissedRecommendations,
  'completedRecommendations': instance.completedRecommendations,
  'acceptanceRate': instance.acceptanceRate,
  'completionRate': instance.completionRate,
  'avgTimeToAccept': instance.avgTimeToAccept,
  'avgConfidence': instance.avgConfidence,
};
