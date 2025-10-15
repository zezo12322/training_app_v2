import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/poll.dart';

class PollRepository {
  final FirebaseFirestore _firestore;

  PollRepository(this._firestore);

  /// Create a new poll and attach it to a wall post
  Future<Poll> createPoll({
    required String postId,
    required String question,
    required List<String> options,
    required String createdBy,
    DateTime? endsAt,
    bool allowMultipleVotes = false,
    bool showResultsBeforeVoting = false,
  }) async {
    final pollId = _firestore.collection('polls').doc().id;
    
    final pollOptions = options
        .asMap()
        .entries
        .map((entry) => PollOption(
              id: 'option_${entry.key}',
              text: entry.value,
              voters: [],
            ))
        .toList();

    final poll = Poll(
      id: pollId,
      question: question,
      options: pollOptions,
      createdBy: createdBy,
      createdAt: DateTime.now(),
      endsAt: endsAt,
      allowMultipleVotes: allowMultipleVotes,
      showResultsBeforeVoting: showResultsBeforeVoting,
    );

    // Save poll to Firestore
    await _firestore.collection('polls').doc(pollId).set(poll.toFirestore());

    // Update the wall post with poll reference (post must exist!)
    await _firestore.collection('course_wall').doc(postId).update({
      'poll': {
        'id': pollId,
        'question': question,
        'optionsCount': options.length,
      },
    });

    return poll;
  }

  /// Get a poll by ID
  Future<Poll?> getPoll(String pollId) async {
    final doc = await _firestore.collection('polls').doc(pollId).get();
    if (!doc.exists) return null;
    return Poll.fromFirestore(doc);
  }

  /// Vote on a poll option
  Future<void> vote({
    required String pollId,
    required String optionId,
    required String userId,
  }) async {
    final pollRef = _firestore.collection('polls').doc(pollId);
    
    await _firestore.runTransaction((transaction) async {
      final pollDoc = await transaction.get(pollRef);
      if (!pollDoc.exists) {
        throw Exception('Poll not found');
      }

      final poll = Poll.fromFirestore(pollDoc);

      // Check if poll is still active
      if (!poll.isActive) {
        throw Exception('Poll has ended');
      }

      // Check if user has already voted
      final hasVoted = poll.hasUserVoted(userId);
      
      if (hasVoted && !poll.allowMultipleVotes) {
        // Remove previous vote
        final previousVotes = poll.getUserVotes(userId);
        final updatedOptions = poll.options.map((option) {
          if (previousVotes.contains(option.id)) {
            return option.copyWith(
              voters: option.voters.where((v) => v != userId).toList(),
            );
          }
          return option;
        }).toList();

        // Add new vote
        final finalOptions = updatedOptions.map((option) {
          if (option.id == optionId) {
            return option.copyWith(
              voters: [...option.voters, userId],
            );
          }
          return option;
        }).toList();

        final totalVotes = finalOptions.fold<int>(
          0,
          (total, option) => total + option.voters.length,
        );

        transaction.update(pollRef, {
          'options': finalOptions.map((o) => o.toJson()).toList(),
          'totalVotes': totalVotes,
        });
      } else {
        // Add vote to the option
        final updatedOptions = poll.options.map((option) {
          if (option.id == optionId) {
            if (!option.voters.contains(userId)) {
              return option.copyWith(
                voters: [...option.voters, userId],
              );
            }
          }
          return option;
        }).toList();

        final totalVotes = updatedOptions.fold<int>(
          0,
          (total, option) => total + option.voters.length,
        );

        transaction.update(pollRef, {
          'options': updatedOptions.map((o) => o.toJson()).toList(),
          'totalVotes': totalVotes,
        });
      }
    });
  }

  /// Remove vote from a poll option
  Future<void> removeVote({
    required String pollId,
    required String optionId,
    required String userId,
  }) async {
    final pollRef = _firestore.collection('polls').doc(pollId);
    
    await _firestore.runTransaction((transaction) async {
      final pollDoc = await transaction.get(pollRef);
      if (!pollDoc.exists) {
        throw Exception('Poll not found');
      }

      final poll = Poll.fromFirestore(pollDoc);

      // Check if poll is still active
      if (!poll.isActive) {
        throw Exception('Poll has ended');
      }

      // Remove vote
      final updatedOptions = poll.options.map((option) {
        if (option.id == optionId) {
          return option.copyWith(
            voters: option.voters.where((v) => v != userId).toList(),
          );
        }
        return option;
      }).toList();

      final totalVotes = updatedOptions.fold<int>(
        0,
        (total, option) => total + option.voters.length,
      );

      transaction.update(pollRef, {
        'options': updatedOptions.map((o) => o.toJson()).toList(),
        'totalVotes': totalVotes,
      });
    });
  }

  /// Stream poll updates
  Stream<Poll?> watchPoll(String pollId) {
    return _firestore
        .collection('polls')
        .doc(pollId)
        .snapshots()
        .map((doc) => doc.exists ? Poll.fromFirestore(doc) : null);
  }

  /// Delete a poll
  Future<void> deletePoll(String pollId) async {
    await _firestore.collection('polls').doc(pollId).delete();
  }
}
