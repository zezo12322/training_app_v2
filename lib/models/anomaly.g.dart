// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anomaly.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnomalyScoreImpl _$$AnomalyScoreImplFromJson(Map<String, dynamic> json) =>
    _$AnomalyScoreImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      institutionId: json['institutionId'] as String,
      companyId: json['companyId'] as String?,
      type: $enumDecode(_$AnomalyTypeEnumMap, json['type']),
      severity: $enumDecode(_$AnomalySeverityEnumMap, json['severity']),
      score: (json['score'] as num).toDouble(),
      confidenceLevel: (json['confidenceLevel'] as num).toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>,
      relatedEntityId: json['relatedEntityId'] as String?,
      relatedEntityType: json['relatedEntityType'] as String?,
      description: json['description'] as String,
      reason: json['reason'] as String,
      evidencePoints:
          (json['evidencePoints'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      status: $enumDecode(_$InvestigationStatusEnumMap, json['status']),
      isReviewed: json['isReviewed'] as bool? ?? false,
      reviewedBy: json['reviewedBy'] as String?,
      reviewerName: json['reviewerName'] as String?,
      reviewedAt: const TimestampConverter().fromJson(json['reviewedAt']),
      reviewNotes: json['reviewNotes'] as String?,
      actionTaken: json['actionTaken'] as bool? ?? false,
      action: json['action'] as String?,
      detectedAt: const RequiredTimestampConverter().fromJson(
        json['detectedAt'] as Object,
      ),
      resolvedAt: const TimestampConverter().fromJson(json['resolvedAt']),
    );

Map<String, dynamic> _$$AnomalyScoreImplToJson(
  _$AnomalyScoreImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'userName': instance.userName,
  'institutionId': instance.institutionId,
  'companyId': instance.companyId,
  'type': _$AnomalyTypeEnumMap[instance.type]!,
  'severity': _$AnomalySeverityEnumMap[instance.severity]!,
  'score': instance.score,
  'confidenceLevel': instance.confidenceLevel,
  'metadata': instance.metadata,
  'relatedEntityId': instance.relatedEntityId,
  'relatedEntityType': instance.relatedEntityType,
  'description': instance.description,
  'reason': instance.reason,
  'evidencePoints': instance.evidencePoints,
  'status': _$InvestigationStatusEnumMap[instance.status]!,
  'isReviewed': instance.isReviewed,
  'reviewedBy': instance.reviewedBy,
  'reviewerName': instance.reviewerName,
  'reviewedAt': const TimestampConverter().toJson(instance.reviewedAt),
  'reviewNotes': instance.reviewNotes,
  'actionTaken': instance.actionTaken,
  'action': instance.action,
  'detectedAt': const RequiredTimestampConverter().toJson(instance.detectedAt),
  'resolvedAt': const TimestampConverter().toJson(instance.resolvedAt),
};

const _$AnomalyTypeEnumMap = {
  AnomalyType.suspiciousLogin: 'suspiciousLogin',
  AnomalyType.unusualQuizScore: 'unusualQuizScore',
  AnomalyType.rapidProgress: 'rapidProgress',
  AnomalyType.multipleDevices: 'multipleDevices',
  AnomalyType.unusualActivity: 'unusualActivity',
  AnomalyType.cheatingPattern: 'cheatingPattern',
  AnomalyType.accountSharing: 'accountSharing',
};

const _$AnomalySeverityEnumMap = {
  AnomalySeverity.low: 'low',
  AnomalySeverity.medium: 'medium',
  AnomalySeverity.high: 'high',
  AnomalySeverity.critical: 'critical',
};

const _$InvestigationStatusEnumMap = {
  InvestigationStatus.pending: 'pending',
  InvestigationStatus.investigating: 'investigating',
  InvestigationStatus.resolved: 'resolved',
  InvestigationStatus.falsePositive: 'falsePositive',
  InvestigationStatus.confirmed: 'confirmed',
};

_$AnomalyAlertImpl _$$AnomalyAlertImplFromJson(Map<String, dynamic> json) =>
    _$AnomalyAlertImpl(
      id: json['id'] as String,
      anomalyId: json['anomalyId'] as String,
      institutionId: json['institutionId'] as String,
      companyId: json['companyId'] as String?,
      title: json['title'] as String,
      message: json['message'] as String,
      severity: $enumDecode(_$AnomalySeverityEnumMap, json['severity']),
      recipientIds: (json['recipientIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      readBy:
          (json['readBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isRead: json['isRead'] as bool,
      isDismissed: json['isDismissed'] as bool,
      dismissedBy: json['dismissedBy'] as String?,
      dismissedAt: const TimestampConverter().fromJson(json['dismissedAt']),
      createdAt: const RequiredTimestampConverter().fromJson(
        json['createdAt'] as Object,
      ),
      expiresAt: const TimestampConverter().fromJson(json['expiresAt']),
    );

Map<String, dynamic> _$$AnomalyAlertImplToJson(
  _$AnomalyAlertImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'anomalyId': instance.anomalyId,
  'institutionId': instance.institutionId,
  'companyId': instance.companyId,
  'title': instance.title,
  'message': instance.message,
  'severity': _$AnomalySeverityEnumMap[instance.severity]!,
  'recipientIds': instance.recipientIds,
  'readBy': instance.readBy,
  'isRead': instance.isRead,
  'isDismissed': instance.isDismissed,
  'dismissedBy': instance.dismissedBy,
  'dismissedAt': const TimestampConverter().toJson(instance.dismissedAt),
  'createdAt': const RequiredTimestampConverter().toJson(instance.createdAt),
  'expiresAt': const TimestampConverter().toJson(instance.expiresAt),
};

_$AnomalyDetectionSettingsImpl _$$AnomalyDetectionSettingsImplFromJson(
  Map<String, dynamic> json,
) => _$AnomalyDetectionSettingsImpl(
  id: json['id'] as String,
  institutionId: json['institutionId'] as String,
  companyId: json['companyId'] as String?,
  isEnabled: json['isEnabled'] as bool,
  enabledTypes:
      (json['enabledTypes'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$AnomalyTypeEnumMap, e))
          .toList() ??
      const [],
  sensitivityLevel: (json['sensitivityLevel'] as num?)?.toDouble() ?? 0.7,
  rapidProgressThreshold:
      (json['rapidProgressThreshold'] as num?)?.toDouble() ?? 3.0,
  unusualScoreThreshold:
      (json['unusualScoreThreshold'] as num?)?.toDouble() ?? 0.95,
  multipleDevicesThreshold:
      (json['multipleDevicesThreshold'] as num?)?.toInt() ?? 5,
  unusualActivityThreshold:
      (json['unusualActivityThreshold'] as num?)?.toInt() ?? 100,
  sendAlerts: json['sendAlerts'] as bool,
  alertRecipients:
      (json['alertRecipients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  minAlertSeverity:
      $enumDecodeNullable(_$AnomalySeverityEnumMap, json['minAlertSeverity']) ??
      AnomalySeverity.medium,
  autoSuspendCritical: json['autoSuspendCritical'] as bool,
  autoFlagCheating: json['autoFlagCheating'] as bool,
  updatedAt: const RequiredTimestampConverter().fromJson(
    json['updatedAt'] as Object,
  ),
  updatedBy: json['updatedBy'] as String,
);

Map<String, dynamic> _$$AnomalyDetectionSettingsImplToJson(
  _$AnomalyDetectionSettingsImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'institutionId': instance.institutionId,
  'companyId': instance.companyId,
  'isEnabled': instance.isEnabled,
  'enabledTypes': instance.enabledTypes
      .map((e) => _$AnomalyTypeEnumMap[e]!)
      .toList(),
  'sensitivityLevel': instance.sensitivityLevel,
  'rapidProgressThreshold': instance.rapidProgressThreshold,
  'unusualScoreThreshold': instance.unusualScoreThreshold,
  'multipleDevicesThreshold': instance.multipleDevicesThreshold,
  'unusualActivityThreshold': instance.unusualActivityThreshold,
  'sendAlerts': instance.sendAlerts,
  'alertRecipients': instance.alertRecipients,
  'minAlertSeverity': _$AnomalySeverityEnumMap[instance.minAlertSeverity]!,
  'autoSuspendCritical': instance.autoSuspendCritical,
  'autoFlagCheating': instance.autoFlagCheating,
  'updatedAt': const RequiredTimestampConverter().toJson(instance.updatedAt),
  'updatedBy': instance.updatedBy,
};

_$AnomalyDetectionModelImpl _$$AnomalyDetectionModelImplFromJson(
  Map<String, dynamic> json,
) => _$AnomalyDetectionModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  type: $enumDecode(_$AnomalyTypeEnumMap, json['type']),
  version: json['version'] as String,
  modelPath: json['modelPath'] as String,
  accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0.0,
  precision: (json['precision'] as num?)?.toDouble() ?? 0.0,
  recall: (json['recall'] as num?)?.toDouble() ?? 0.0,
  trainingDataSize: (json['trainingDataSize'] as num).toInt(),
  trainedAt: const RequiredTimestampConverter().fromJson(
    json['trainedAt'] as Object,
  ),
  trainedBy: json['trainedBy'] as String?,
  isActive: json['isActive'] as bool,
  lastUsedAt: const TimestampConverter().fromJson(json['lastUsedAt']),
  metadata: json['metadata'] as Map<String, dynamic>,
);

Map<String, dynamic> _$$AnomalyDetectionModelImplToJson(
  _$AnomalyDetectionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'type': _$AnomalyTypeEnumMap[instance.type]!,
  'version': instance.version,
  'modelPath': instance.modelPath,
  'accuracy': instance.accuracy,
  'precision': instance.precision,
  'recall': instance.recall,
  'trainingDataSize': instance.trainingDataSize,
  'trainedAt': const RequiredTimestampConverter().toJson(instance.trainedAt),
  'trainedBy': instance.trainedBy,
  'isActive': instance.isActive,
  'lastUsedAt': const TimestampConverter().toJson(instance.lastUsedAt),
  'metadata': instance.metadata,
};

_$BehaviorPatternImpl _$$BehaviorPatternImplFromJson(
  Map<String, dynamic> json,
) => _$BehaviorPatternImpl(
  userId: json['userId'] as String,
  institutionId: json['institutionId'] as String,
  avgQuizScore: (json['avgQuizScore'] as num?)?.toDouble() ?? 0.0,
  quizScoreStdDev: (json['quizScoreStdDev'] as num?)?.toDouble() ?? 0.0,
  totalQuizzesTaken: (json['totalQuizzesTaken'] as num?)?.toInt() ?? 0,
  avgQuizCompletionTime:
      (json['avgQuizCompletionTime'] as num?)?.toDouble() ?? 0.0,
  avgCourseProgress: (json['avgCourseProgress'] as num?)?.toDouble() ?? 0.0,
  totalCoursesEnrolled: (json['totalCoursesEnrolled'] as num?)?.toInt() ?? 0,
  totalCoursesCompleted: (json['totalCoursesCompleted'] as num?)?.toInt() ?? 0,
  avgLessonDuration: (json['avgLessonDuration'] as num?)?.toDouble() ?? 0.0,
  commonLoginTimes:
      (json['commonLoginTimes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  commonDevices:
      (json['commonDevices'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  commonLocations:
      (json['commonLocations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  totalLoginSessions: (json['totalLoginSessions'] as num?)?.toInt() ?? 0,
  totalActivities: (json['totalActivities'] as num?)?.toInt() ?? 0,
  avgSessionDuration: (json['avgSessionDuration'] as num?)?.toDouble() ?? 0.0,
  peakActivityHours:
      (json['peakActivityHours'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  lastUpdatedAt: const RequiredTimestampConverter().fromJson(
    json['lastUpdatedAt'] as Object,
  ),
  createdAt: const RequiredTimestampConverter().fromJson(
    json['createdAt'] as Object,
  ),
);

Map<String, dynamic> _$$BehaviorPatternImplToJson(
  _$BehaviorPatternImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'institutionId': instance.institutionId,
  'avgQuizScore': instance.avgQuizScore,
  'quizScoreStdDev': instance.quizScoreStdDev,
  'totalQuizzesTaken': instance.totalQuizzesTaken,
  'avgQuizCompletionTime': instance.avgQuizCompletionTime,
  'avgCourseProgress': instance.avgCourseProgress,
  'totalCoursesEnrolled': instance.totalCoursesEnrolled,
  'totalCoursesCompleted': instance.totalCoursesCompleted,
  'avgLessonDuration': instance.avgLessonDuration,
  'commonLoginTimes': instance.commonLoginTimes,
  'commonDevices': instance.commonDevices,
  'commonLocations': instance.commonLocations,
  'totalLoginSessions': instance.totalLoginSessions,
  'totalActivities': instance.totalActivities,
  'avgSessionDuration': instance.avgSessionDuration,
  'peakActivityHours': instance.peakActivityHours,
  'lastUpdatedAt': const RequiredTimestampConverter().toJson(
    instance.lastUpdatedAt,
  ),
  'createdAt': const RequiredTimestampConverter().toJson(instance.createdAt),
};

_$ActivityEventImpl _$$ActivityEventImplFromJson(Map<String, dynamic> json) =>
    _$ActivityEventImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      institutionId: json['institutionId'] as String,
      eventType: json['eventType'] as String,
      eventData: json['eventData'] as Map<String, dynamic>,
      deviceId: json['deviceId'] as String?,
      deviceType: json['deviceType'] as String?,
      ipAddress: json['ipAddress'] as String?,
      location: json['location'] as String?,
      userAgent: json['userAgent'] as String?,
      timestamp: const RequiredTimestampConverter().fromJson(
        json['timestamp'] as Object,
      ),
      isFlagged: json['isFlagged'] as bool? ?? false,
      anomalyScore: (json['anomalyScore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ActivityEventImplToJson(
  _$ActivityEventImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'institutionId': instance.institutionId,
  'eventType': instance.eventType,
  'eventData': instance.eventData,
  'deviceId': instance.deviceId,
  'deviceType': instance.deviceType,
  'ipAddress': instance.ipAddress,
  'location': instance.location,
  'userAgent': instance.userAgent,
  'timestamp': const RequiredTimestampConverter().toJson(instance.timestamp),
  'isFlagged': instance.isFlagged,
  'anomalyScore': instance.anomalyScore,
};

_$DetectionStatisticsImpl _$$DetectionStatisticsImplFromJson(
  Map<String, dynamic> json,
) => _$DetectionStatisticsImpl(
  institutionId: json['institutionId'] as String,
  companyId: json['companyId'] as String?,
  startDate: const RequiredTimestampConverter().fromJson(
    json['startDate'] as Object,
  ),
  endDate: const RequiredTimestampConverter().fromJson(
    json['endDate'] as Object,
  ),
  totalAnomaliesDetected: (json['totalAnomaliesDetected'] as num).toInt(),
  confirmedAnomalies: (json['confirmedAnomalies'] as num).toInt(),
  falsePositives: (json['falsePositives'] as num).toInt(),
  pendingReview: (json['pendingReview'] as num).toInt(),
  anomaliesByType: (json['anomaliesByType'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry($enumDecode(_$AnomalyTypeEnumMap, k), (e as num).toInt()),
  ),
  anomaliesBySeverity: (json['anomaliesBySeverity'] as Map<String, dynamic>)
      .map(
        (k, e) => MapEntry(
          $enumDecode(_$AnomalySeverityEnumMap, k),
          (e as num).toInt(),
        ),
      ),
  detectionAccuracy: (json['detectionAccuracy'] as num?)?.toDouble() ?? 0.0,
  falsePositiveRate: (json['falsePositiveRate'] as num?)?.toDouble() ?? 0.0,
  truePositiveRate: (json['truePositiveRate'] as num?)?.toDouble() ?? 0.0,
  avgDetectionTime: (json['avgDetectionTime'] as num?)?.toDouble() ?? 0.0,
  avgReviewTime: (json['avgReviewTime'] as num?)?.toDouble() ?? 0.0,
  generatedAt: const RequiredTimestampConverter().fromJson(
    json['generatedAt'] as Object,
  ),
);

Map<String, dynamic> _$$DetectionStatisticsImplToJson(
  _$DetectionStatisticsImpl instance,
) => <String, dynamic>{
  'institutionId': instance.institutionId,
  'companyId': instance.companyId,
  'startDate': const RequiredTimestampConverter().toJson(instance.startDate),
  'endDate': const RequiredTimestampConverter().toJson(instance.endDate),
  'totalAnomaliesDetected': instance.totalAnomaliesDetected,
  'confirmedAnomalies': instance.confirmedAnomalies,
  'falsePositives': instance.falsePositives,
  'pendingReview': instance.pendingReview,
  'anomaliesByType': instance.anomaliesByType.map(
    (k, e) => MapEntry(_$AnomalyTypeEnumMap[k]!, e),
  ),
  'anomaliesBySeverity': instance.anomaliesBySeverity.map(
    (k, e) => MapEntry(_$AnomalySeverityEnumMap[k]!, e),
  ),
  'detectionAccuracy': instance.detectionAccuracy,
  'falsePositiveRate': instance.falsePositiveRate,
  'truePositiveRate': instance.truePositiveRate,
  'avgDetectionTime': instance.avgDetectionTime,
  'avgReviewTime': instance.avgReviewTime,
  'generatedAt': const RequiredTimestampConverter().toJson(
    instance.generatedAt,
  ),
};
