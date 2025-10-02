// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  trainerId: json['trainerId'] as String,
  courseCode: json['courseCode'] as String,
  trainees:
      (json['trainees'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'trainerId': instance.trainerId,
      'courseCode': instance.courseCode,
      'trainees': instance.trainees,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
