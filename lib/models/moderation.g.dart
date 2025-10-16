// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moderation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportImpl _$$ReportImplFromJson(Map<String, dynamic> json) => _$ReportImpl(
  id: json['id'] as String,
  type: $enumDecode(_$ReportTypeEnumMap, json['type']),
  status:
      $enumDecodeNullable(_$ReportStatusEnumMap, json['status']) ??
      ReportStatus.pending,
  reporterId: json['reporterId'] as String,
  reporterName: json['reporterName'] as String,
  contentType: json['contentType'] as String,
  contentId: json['contentId'] as String,
  reportedUserId: json['reportedUserId'] as String,
  reportedUserName: json['reportedUserName'] as String?,
  reason: json['reason'] as String,
  description: json['description'] as String? ?? '',
  evidenceUrls:
      (json['evidenceUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  courseId: json['courseId'] as String?,
  reviewerId: json['reviewerId'] as String?,
  reviewerName: json['reviewerName'] as String?,
  action:
      $enumDecodeNullable(_$ModerationActionEnumMap, json['action']) ??
      ModerationAction.none,
  reviewNotes: json['reviewNotes'] as String?,
  createdAt: const RequiredTimestampConverter().fromJson(
    json['createdAt'] as Object,
  ),
  reviewedAt: const TimestampConverter().fromJson(json['reviewedAt']),
  resolvedAt: const TimestampConverter().fromJson(json['resolvedAt']),
  institutionId: json['institutionId'] as String,
  companyId: json['companyId'] as String,
);

Map<String, dynamic> _$$ReportImplToJson(
  _$ReportImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$ReportTypeEnumMap[instance.type]!,
  'status': _$ReportStatusEnumMap[instance.status]!,
  'reporterId': instance.reporterId,
  'reporterName': instance.reporterName,
  'contentType': instance.contentType,
  'contentId': instance.contentId,
  'reportedUserId': instance.reportedUserId,
  'reportedUserName': instance.reportedUserName,
  'reason': instance.reason,
  'description': instance.description,
  'evidenceUrls': instance.evidenceUrls,
  'courseId': instance.courseId,
  'reviewerId': instance.reviewerId,
  'reviewerName': instance.reviewerName,
  'action': _$ModerationActionEnumMap[instance.action]!,
  'reviewNotes': instance.reviewNotes,
  'createdAt': const RequiredTimestampConverter().toJson(instance.createdAt),
  'reviewedAt': const TimestampConverter().toJson(instance.reviewedAt),
  'resolvedAt': const TimestampConverter().toJson(instance.resolvedAt),
  'institutionId': instance.institutionId,
  'companyId': instance.companyId,
};

const _$ReportTypeEnumMap = {
  ReportType.inappropriate: 'inappropriate',
  ReportType.harassment: 'harassment',
  ReportType.spam: 'spam',
  ReportType.misinformation: 'misinformation',
  ReportType.harmful: 'harmful',
  ReportType.copyright: 'copyright',
  ReportType.other: 'other',
};

const _$ReportStatusEnumMap = {
  ReportStatus.pending: 'pending',
  ReportStatus.investigating: 'investigating',
  ReportStatus.actionTaken: 'actionTaken',
  ReportStatus.dismissed: 'dismissed',
  ReportStatus.resolved: 'resolved',
};

const _$ModerationActionEnumMap = {
  ModerationAction.none: 'none',
  ModerationAction.warning: 'warning',
  ModerationAction.deleteContent: 'deleteContent',
  ModerationAction.hideContent: 'hideContent',
  ModerationAction.muteUser: 'muteUser',
  ModerationAction.banUser: 'banUser',
  ModerationAction.restrictPosting: 'restrictPosting',
};

_$ModerationLogImpl _$$ModerationLogImplFromJson(Map<String, dynamic> json) =>
    _$ModerationLogImpl(
      id: json['id'] as String,
      targetUserId: json['targetUserId'] as String,
      targetUserName: json['targetUserName'] as String,
      action: $enumDecode(_$ModerationActionEnumMap, json['action']),
      reason: json['reason'] as String,
      durationDays: (json['durationDays'] as num?)?.toInt(),
      startDate: const RequiredTimestampConverter().fromJson(
        json['startDate'] as Object,
      ),
      endDate: const TimestampConverter().fromJson(json['endDate']),
      moderatorId: json['moderatorId'] as String,
      moderatorName: json['moderatorName'] as String,
      relatedReportId: json['relatedReportId'] as String?,
      notes: json['notes'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? true,
      cancelledAt: const TimestampConverter().fromJson(json['cancelledAt']),
      cancellationReason: json['cancellationReason'] as String?,
      institutionId: json['institutionId'] as String,
      companyId: json['companyId'] as String,
    );

Map<String, dynamic> _$$ModerationLogImplToJson(
  _$ModerationLogImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'targetUserId': instance.targetUserId,
  'targetUserName': instance.targetUserName,
  'action': _$ModerationActionEnumMap[instance.action]!,
  'reason': instance.reason,
  'durationDays': instance.durationDays,
  'startDate': const RequiredTimestampConverter().toJson(instance.startDate),
  'endDate': const TimestampConverter().toJson(instance.endDate),
  'moderatorId': instance.moderatorId,
  'moderatorName': instance.moderatorName,
  'relatedReportId': instance.relatedReportId,
  'notes': instance.notes,
  'isActive': instance.isActive,
  'cancelledAt': const TimestampConverter().toJson(instance.cancelledAt),
  'cancellationReason': instance.cancellationReason,
  'institutionId': instance.institutionId,
  'companyId': instance.companyId,
};

_$ContentFilterImpl _$$ContentFilterImplFromJson(Map<String, dynamic> json) =>
    _$ContentFilterImpl(
      id: json['id'] as String,
      bannedWords:
          (json['bannedWords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      bannedPatterns:
          (json['bannedPatterns'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      allowedDomains:
          (json['allowedDomains'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isActive: json['isActive'] as bool? ?? true,
      sensitivity: (json['sensitivity'] as num?)?.toInt() ?? 5,
      autoAction:
          $enumDecodeNullable(_$ModerationActionEnumMap, json['autoAction']) ??
          ModerationAction.hideContent,
      notifyModerator: json['notifyModerator'] as bool? ?? true,
      institutionId: json['institutionId'] as String,
      companyId: json['companyId'] as String,
    );

Map<String, dynamic> _$$ContentFilterImplToJson(_$ContentFilterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bannedWords': instance.bannedWords,
      'bannedPatterns': instance.bannedPatterns,
      'allowedDomains': instance.allowedDomains,
      'isActive': instance.isActive,
      'sensitivity': instance.sensitivity,
      'autoAction': _$ModerationActionEnumMap[instance.autoAction]!,
      'notifyModerator': instance.notifyModerator,
      'institutionId': instance.institutionId,
      'companyId': instance.companyId,
    };

_$ModerationStatsImpl _$$ModerationStatsImplFromJson(
  Map<String, dynamic> json,
) => _$ModerationStatsImpl(
  totalReports: (json['totalReports'] as num?)?.toInt() ?? 0,
  pendingReports: (json['pendingReports'] as num?)?.toInt() ?? 0,
  resolvedReports: (json['resolvedReports'] as num?)?.toInt() ?? 0,
  dismissedReports: (json['dismissedReports'] as num?)?.toInt() ?? 0,
  totalActions: (json['totalActions'] as num?)?.toInt() ?? 0,
  bannedUsers: (json['bannedUsers'] as num?)?.toInt() ?? 0,
  mutedUsers: (json['mutedUsers'] as num?)?.toInt() ?? 0,
  avgReviewTimeHours: (json['avgReviewTimeHours'] as num?)?.toDouble() ?? 0.0,
  reportsByType:
      (json['reportsByType'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
);

Map<String, dynamic> _$$ModerationStatsImplToJson(
  _$ModerationStatsImpl instance,
) => <String, dynamic>{
  'totalReports': instance.totalReports,
  'pendingReports': instance.pendingReports,
  'resolvedReports': instance.resolvedReports,
  'dismissedReports': instance.dismissedReports,
  'totalActions': instance.totalActions,
  'bannedUsers': instance.bannedUsers,
  'mutedUsers': instance.mutedUsers,
  'avgReviewTimeHours': instance.avgReviewTimeHours,
  'reportsByType': instance.reportsByType,
};
