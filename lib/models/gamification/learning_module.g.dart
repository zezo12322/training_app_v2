// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LearningModuleImpl _$$LearningModuleImplFromJson(Map<String, dynamic> json) =>
    _$LearningModuleImpl(
      id: json['id'] as String?,
      courseId: json['courseId'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      orderIndex: (json['orderIndex'] as num).toInt(),
      contents:
          (json['contents'] as List<dynamic>?)
              ?.map((e) => ModuleContent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      requirements: ModuleRequirements.fromJson(
        json['requirements'] as Map<String, dynamic>,
      ),
      completionPoints: (json['completionPoints'] as num?)?.toInt() ?? 100,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$LearningModuleImplToJson(
  _$LearningModuleImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'courseId': instance.courseId,
  'title': instance.title,
  'description': instance.description,
  'orderIndex': instance.orderIndex,
  'contents': instance.contents.map((e) => e.toJson()).toList(),
  'requirements': instance.requirements.toJson(),
  'completionPoints': instance.completionPoints,
  'isActive': instance.isActive,
};

_$ModuleContentImpl _$$ModuleContentImplFromJson(Map<String, dynamic> json) =>
    _$ModuleContentImpl(
      id: json['id'] as String,
      type: $enumDecode(_$ModuleContentTypeEnumMap, json['type']),
      title: json['title'] as String,
      orderIndex: (json['orderIndex'] as num).toInt(),
      isRequired: json['isRequired'] as bool? ?? true,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$ModuleContentImplToJson(_$ModuleContentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ModuleContentTypeEnumMap[instance.type]!,
      'title': instance.title,
      'orderIndex': instance.orderIndex,
      'isRequired': instance.isRequired,
      'isCompleted': instance.isCompleted,
    };

const _$ModuleContentTypeEnumMap = {
  ModuleContentType.lesson: 'lesson',
  ModuleContentType.quiz: 'quiz',
  ModuleContentType.assignment: 'assignment',
  ModuleContentType.resource: 'resource',
};

_$ModuleRequirementsImpl _$$ModuleRequirementsImplFromJson(
  Map<String, dynamic> json,
) => _$ModuleRequirementsImpl(
  completeLessons: json['completeLessons'] as bool? ?? true,
  passAllQuizzes: json['passAllQuizzes'] as bool? ?? true,
  minimumQuizScore: (json['minimumQuizScore'] as num?)?.toInt() ?? 70,
  completeAssignments: json['completeAssignments'] as bool? ?? true,
);

Map<String, dynamic> _$$ModuleRequirementsImplToJson(
  _$ModuleRequirementsImpl instance,
) => <String, dynamic>{
  'completeLessons': instance.completeLessons,
  'passAllQuizzes': instance.passAllQuizzes,
  'minimumQuizScore': instance.minimumQuizScore,
  'completeAssignments': instance.completeAssignments,
};
