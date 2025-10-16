import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'poll.freezed.dart';
part 'poll.g.dart';

@freezed
class Poll with _$Poll {
  const Poll._();

  const factory Poll({
    required String id,
    required String question,
    required List<PollOption> options,
    required String createdBy,
    @RequiredTimestampConverter() required DateTime createdAt,
    @TimestampConverter() DateTime? endsAt,
    @Default(false) bool allowMultipleVotes,
    @Default(false) bool showResultsBeforeVoting,
    @Default(0) int totalVotes,
  }) = _Poll;

  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);

  factory Poll.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Poll.fromJson({
      ...data,
      'id': doc.id,
    });
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    
    // Remove null endsAt field to avoid Firestore validation issues
    if (endsAt == null) {
      json.remove('endsAt');
    }
    return json;
  }

  bool get isActive {
    if (endsAt == null) return true;
    return DateTime.now().isBefore(endsAt!);
  }

  bool hasUserVoted(String userId) {
    return options.any((option) => option.voters.contains(userId));
  }

  List<String> getUserVotes(String userId) {
    return options
        .where((option) => option.voters.contains(userId))
        .map((option) => option.id)
        .toList();
  }
}

@freezed
class PollOption with _$PollOption {
  const PollOption._();

  const factory PollOption({
    required String id,
    required String text,
    @Default([]) List<String> voters,
  }) = _PollOption;

  factory PollOption.fromJson(Map<String, dynamic> json) =>
      _$PollOptionFromJson(json);

  int get voteCount => voters.length;

  double getPercentage(int totalVotes) {
    if (totalVotes == 0) return 0.0;
    return (voteCount / totalVotes) * 100;
  }
}
