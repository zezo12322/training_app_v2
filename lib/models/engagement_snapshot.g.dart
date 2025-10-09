// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engagement_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EngagementSnapshotImpl _$$EngagementSnapshotImplFromJson(
  Map<String, dynamic> json,
) => _$EngagementSnapshotImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  date: json['date'] as String,
  events7d: (json['events7d'] as num?)?.toInt() ?? 0,
  lastActiveTs: const TimestampConverter().fromJson(json['lastActiveTs']),
  streak: (json['streak'] as num?)?.toInt() ?? 0,
  masteryDelta14d: (json['masteryDelta14d'] as num?)?.toDouble() ?? 0,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$$EngagementSnapshotImplToJson(
  _$EngagementSnapshotImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'date': instance.date,
  'events7d': instance.events7d,
  'lastActiveTs': const TimestampConverter().toJson(instance.lastActiveTs),
  'streak': instance.streak,
  'masteryDelta14d': instance.masteryDelta14d,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};
