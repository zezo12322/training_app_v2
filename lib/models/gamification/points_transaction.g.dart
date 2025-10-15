// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointsTransactionImpl _$$PointsTransactionImplFromJson(
  Map<String, dynamic> json,
) => _$PointsTransactionImpl(
  id: json['id'] as String?,
  userId: json['userId'] as String,
  courseId: json['courseId'] as String,
  points: (json['points'] as num).toInt(),
  activityType: json['activityType'] as String,
  activityName: json['activityName'] as String,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$$PointsTransactionImplToJson(
  _$PointsTransactionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'courseId': instance.courseId,
  'points': instance.points,
  'activityType': instance.activityType,
  'activityName': instance.activityName,
  'metadata': instance.metadata,
  'timestamp': instance.timestamp.toIso8601String(),
};
