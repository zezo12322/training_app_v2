// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PollImpl _$$PollImplFromJson(Map<String, dynamic> json) => _$PollImpl(
  id: json['id'] as String,
  question: json['question'] as String,
  options: (json['options'] as List<dynamic>)
      .map((e) => PollOption.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdBy: json['createdBy'] as String,
  createdAt: _timestampFromJson(json['createdAt']),
  endsAt: const TimestampConverter().fromJson(json['endsAt']),
  allowMultipleVotes: json['allowMultipleVotes'] as bool? ?? false,
  showResultsBeforeVoting: json['showResultsBeforeVoting'] as bool? ?? false,
  totalVotes: (json['totalVotes'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$PollImplToJson(_$PollImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'options': instance.options.map((e) => e.toJson()).toList(),
      'createdBy': instance.createdBy,
      'createdAt': _timestampToJson(instance.createdAt),
      'endsAt': const TimestampConverter().toJson(instance.endsAt),
      'allowMultipleVotes': instance.allowMultipleVotes,
      'showResultsBeforeVoting': instance.showResultsBeforeVoting,
      'totalVotes': instance.totalVotes,
    };

_$PollOptionImpl _$$PollOptionImplFromJson(Map<String, dynamic> json) =>
    _$PollOptionImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      voters:
          (json['voters'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PollOptionImplToJson(_$PollOptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'voters': instance.voters,
    };
