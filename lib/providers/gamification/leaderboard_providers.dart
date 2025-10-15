import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/gamification/leaderboard_entry.dart';
import '../../repositories/gamification/leaderboard_repository.dart';

// ==================== Repository Provider ====================

final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) {
  return LeaderboardRepository();
});

// ==================== Leaderboard Stream ====================

/// Stream leaderboard for specific course and timeframe
final leaderboardProvider = StreamProvider.family<
    List<LeaderboardEntry>,
    ({String courseId, LeaderboardTimeframe timeframe, int limit})>(
  (ref, params) {
    final repository = ref.watch(leaderboardRepositoryProvider);

    return repository.streamLeaderboard(
      courseId: params.courseId,
      timeframe: params.timeframe,
      limit: params.limit,
    );
  },
);

/// Get top N students
final topStudentsProvider = FutureProvider.family<
    List<LeaderboardEntry>,
    ({String courseId, int limit})>(
  (ref, params) async {
    final repository = ref.watch(leaderboardRepositoryProvider);

    return repository.getTopStudents(
      courseId: params.courseId,
      limit: params.limit,
    );
  },
);

/// Get user's rank in leaderboard
final userRankProvider = FutureProvider.family<
    int?,
    ({String userId, String courseId, LeaderboardTimeframe timeframe})>(
  (ref, params) async {
    final repository = ref.watch(leaderboardRepositoryProvider);

    return repository.getUserRank(
      userId: params.userId,
      courseId: params.courseId,
      timeframe: params.timeframe,
    );
  },
);

/// Get user's leaderboard entry
final userLeaderboardEntryProvider = StreamProvider.family<
    LeaderboardEntry?,
    ({String userId, String courseId, LeaderboardTimeframe timeframe})>(
  (ref, params) {
    final leaderboardStream = ref.watch(
      leaderboardProvider((
        courseId: params.courseId,
        timeframe: params.timeframe,
        limit: 1000, // Large limit to ensure user is included
      )),
    );

    return leaderboardStream.whenData((entries) {
      try {
        return entries.firstWhere((entry) => entry.userId == params.userId);
      } catch (e) {
        return null;
      }
    }).value != null
        ? Stream.value(leaderboardStream.value)
        : const Stream.empty();
  },
);

/// Get podium (top 3 students)
final podiumProvider = StreamProvider.family<
    List<LeaderboardEntry>,
    ({String courseId, LeaderboardTimeframe timeframe})>(
  (ref, params) {
    return ref.watch(
      leaderboardProvider((
        courseId: params.courseId,
        timeframe: params.timeframe,
        limit: 3,
      )),
    ).value != null
        ? Stream.value(
            ref.watch(leaderboardProvider((
              courseId: params.courseId,
              timeframe: params.timeframe,
              limit: 3,
            ))).value!)
        : const Stream.empty();
  },
);
