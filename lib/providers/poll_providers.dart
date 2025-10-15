import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/poll.dart';
import '../repositories/poll_repository.dart';

// Repository Provider
final pollRepositoryProvider = Provider<PollRepository>((ref) {
  return PollRepository(FirebaseFirestore.instance);
});

// Watch a specific poll
final pollProvider = StreamProvider.family<Poll?, String>((ref, pollId) {
  return ref.read(pollRepositoryProvider).watchPoll(pollId);
});

// Create poll provider
final createPollProvider = Provider((ref) {
  return ({
    required String postId,
    required String question,
    required List<String> options,
    required String createdBy,
    DateTime? endsAt,
    bool allowMultipleVotes = false,
    bool showResultsBeforeVoting = false,
  }) async {
    return ref.read(pollRepositoryProvider).createPoll(
          postId: postId,
          question: question,
          options: options,
          createdBy: createdBy,
          endsAt: endsAt,
          allowMultipleVotes: allowMultipleVotes,
          showResultsBeforeVoting: showResultsBeforeVoting,
        );
  };
});

// Vote on poll provider
final voteOnPollProvider = Provider((ref) {
  return ({
    required String pollId,
    required String optionId,
    required String userId,
  }) async {
    await ref.read(pollRepositoryProvider).vote(
          pollId: pollId,
          optionId: optionId,
          userId: userId,
        );
  };
});

// Remove vote provider
final removeVoteProvider = Provider((ref) {
  return ({
    required String pollId,
    required String optionId,
    required String userId,
  }) async {
    await ref.read(pollRepositoryProvider).removeVote(
          pollId: pollId,
          optionId: optionId,
          userId: userId,
        );
  };
});

// Delete poll provider
final deletePollProvider = Provider((ref) {
  return (String pollId) async {
    await ref.read(pollRepositoryProvider).deletePoll(pollId);
  };
});
