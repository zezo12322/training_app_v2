// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'path_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PathStepImpl _$$PathStepImplFromJson(Map<String, dynamic> json) =>
    _$PathStepImpl(
      id: json['id'] as String,
      pathId: json['pathId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      type:
          $enumDecodeNullable(_$PathStepTypeEnumMap, json['type']) ??
          PathStepType.task,
      resourceId: json['resourceId'] as String?,
      order: (json['order'] as num).toInt(),
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
        json['createdAt'],
        const TimestampConverter().fromJson,
      ),
      updatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
        json['updatedAt'],
        const TimestampConverter().fromJson,
      ),
    );

Map<String, dynamic> _$$PathStepImplToJson(_$PathStepImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pathId': instance.pathId,
      'title': instance.title,
      'description': instance.description,
      'type': _$PathStepTypeEnumMap[instance.type]!,
      'resourceId': instance.resourceId,
      'order': instance.order,
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
        instance.createdAt,
        const TimestampConverter().toJson,
      ),
      'updatedAt': _$JsonConverterToJson<Timestamp, DateTime>(
        instance.updatedAt,
        const TimestampConverter().toJson,
      ),
    };

const _$PathStepTypeEnumMap = {
  PathStepType.task: 'task',
  PathStepType.quiz: 'quiz',
  PathStepType.resource: 'resource',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
