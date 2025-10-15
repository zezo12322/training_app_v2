// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GamificationSettingsImpl _$$GamificationSettingsImplFromJson(
  Map<String, dynamic> json,
) => _$GamificationSettingsImpl(
  activityPoints: ActivityPoints.fromJson(
    json['activityPoints'] as Map<String, dynamic>,
  ),
  levelThresholds: (json['levelThresholds'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(int.parse(k), (e as num).toInt()),
  ),
  availableBadges:
      (json['availableBadges'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  isEnabled: json['isEnabled'] as bool? ?? true,
  lastUpdatedAt: json['lastUpdatedAt'] == null
      ? null
      : DateTime.parse(json['lastUpdatedAt'] as String),
  lastUpdatedBy: json['lastUpdatedBy'] as String?,
);

Map<String, dynamic> _$$GamificationSettingsImplToJson(
  _$GamificationSettingsImpl instance,
) => <String, dynamic>{
  'activityPoints': instance.activityPoints.toJson(),
  'levelThresholds': instance.levelThresholds.map(
    (k, e) => MapEntry(k.toString(), e),
  ),
  'availableBadges': instance.availableBadges,
  'isEnabled': instance.isEnabled,
  'lastUpdatedAt': instance.lastUpdatedAt?.toIso8601String(),
  'lastUpdatedBy': instance.lastUpdatedBy,
};
