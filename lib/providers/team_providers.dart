import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import '../models/user_department_map.dart';
import '../models/user_model.dart';
import '../models/user_skill_stats.dart';
import '../models/engagement_snapshot.dart';

final _fs = Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);

// Stream user IDs mapped to a department
final teamUserIdsByDepartmentProvider =
    StreamProvider.family<List<String>, String>((ref, departmentId) {
      final fs = ref.watch(_fs);
      return fs
          .collection('user_department_map')
          .where('departmentId', isEqualTo: departmentId)
          .withConverter<Map<String, dynamic>>(
            fromFirestore: (snap, _) => snap.data() ?? {},
            toFirestore: (value, _) => value,
          )
          .snapshots()
          .map(
            (q) => q.docs
                .map(
                  (d) => UserDepartmentMap.fromDoc(
                    d as DocumentSnapshot<Map<String, dynamic>>,
                  ),
                )
                .map((m) => m.userId)
                .toList(),
          );
    });

// Fetch a single AppUser by id (one-shot Future)
final appUserByIdProvider = FutureProvider.family<AppUser?, String>((
  ref,
  userId,
) async {
  final fs = ref.watch(_fs);
  final snap = await fs.collection('users').doc(userId).get();
  if (!snap.exists) return null;
  return AppUser.fromDoc(snap);
});

// Compute average mastery and delta14d for a user across their skills
class UserAvgMastery {
  final double avgMastery;
  final double avgDelta14d;
  const UserAvgMastery({required this.avgMastery, required this.avgDelta14d});
}

final userAvgMasteryProvider = StreamProvider.family<UserAvgMastery, String>((
  ref,
  userId,
) {
  final fs = ref.watch(_fs);
  return fs
      .collection('user_skill_stats')
      .where('userId', isEqualTo: userId)
      .withConverter<Map<String, dynamic>>(
        fromFirestore: (snap, _) => snap.data() ?? {},
        toFirestore: (value, _) => value,
      )
      .snapshots()
      .map((q) {
        final stats = q.docs
            .map(
              (d) => UserSkillStats.fromDoc(
                d as DocumentSnapshot<Map<String, dynamic>>,
              ),
            )
            .toList();
        if (stats.isEmpty) {
          return const UserAvgMastery(avgMastery: 0, avgDelta14d: 0);
        }
        final avg =
            stats.map((s) => s.masteryScore).fold<double>(0, (a, b) => a + b) /
            stats.length;
        final avgDelta =
            stats.map((s) => s.delta14d).fold<double>(0, (a, b) => a + b) /
            stats.length;
        return UserAvgMastery(avgMastery: avg, avgDelta14d: avgDelta);
      });
});

// Risk model for a team member
class TeamMemberRisk {
  final String userId;
  final double risk; // 0..1
  final double componentsDelta; // 0..1
  final double componentsEvents; // 0..1
  const TeamMemberRisk({
    required this.userId,
    required this.risk,
    required this.componentsDelta,
    required this.componentsEvents,
  });
}

// Compute a simple risk score per member using plateau weighting
// - Delta component: if avgDelta14d < 0, riskDelta = min(1, (-avgDelta14d)/0.1) else 0
// - Events component: riskEvents = clamp01((5 - events7d) / 5)
// - Risk = 0.6*Delta + 0.4*Events
final teamMemberRiskProvider =
    StreamProvider.family<List<TeamMemberRisk>, String>((ref, departmentId) {
  final fs = ref.watch(_fs);
  return ref.watch(teamMemberMasteriesProvider(departmentId)).when(
        data: (members) {
          if (members.isEmpty) return Stream.value(const <TeamMemberRisk>[]);
          final userIds = members.map((m) => m.userId).toList(growable: false);
          // Build one stream per user for engagement snapshot
          final snapshotStreams = userIds.map((uid) {
      return fs
        .collection('engagement_snapshots')
        .doc(uid)
        .snapshots()
        .map((snap) => snap.exists
          ? EngagementSnapshot.fromDoc(
            snap as dynamic) // fromDoc accepts typed DocumentSnapshot
          : null);
          }).toList();

          return Rx.combineLatestList<EngagementSnapshot?>(snapshotStreams)
              .map((snaps) {
            final List<TeamMemberRisk> out = [];
            for (var i = 0; i < userIds.length; i++) {
              final uid = userIds[i];
              final m = members[i];
              final s = snaps[i];
              final events7d = (s?.events7d ?? 0).toDouble();
              final delta = m.avgDelta14d;
              final riskDelta = delta < 0
                  ? ((-delta) / 0.1).clamp(0.0, 1.0)
                  : 0.0; // normalize declines ≥ -0.1 → risk=1
              final riskEvents = ((5 - events7d) / 5).clamp(0.0, 1.0);
              final risk = (0.6 * riskDelta + 0.4 * riskEvents)
                  .clamp(0.0, 1.0);
              out.add(TeamMemberRisk(
                userId: uid,
                risk: risk,
                componentsDelta: riskDelta,
                componentsEvents: riskEvents,
              ));
            }
            return out;
          });
        },
        loading: () => const Stream.empty(),
        error: (_, __) => const Stream.empty(),
      );
});

// Department skill gaps: aggregate avg mastery per skill across team users
class SkillAggregate {
  final String skillCode;
  final double avgMastery;
  final double avgDelta14d;
  final int usersCount;
  const SkillAggregate({
    required this.skillCode,
    required this.avgMastery,
    required this.avgDelta14d,
    required this.usersCount,
  });
}

final departmentSkillGapsProvider =
    StreamProvider.family<List<SkillAggregate>, String>((ref, departmentId) {
      final fs = ref.watch(_fs);
      return ref
          .watch(teamUserIdsByDepartmentProvider(departmentId))
          .when(
            data: (userIds) {
              if (userIds.isEmpty) {
                return Stream.value(const <SkillAggregate>[]);
              }
              // For each user, stream their skill stats
              final streams = userIds.map((uid) {
                return fs
                    .collection('user_skill_stats')
                    .where('userId', isEqualTo: uid)
                    .withConverter<Map<String, dynamic>>(
                      fromFirestore: (snap, _) => snap.data() ?? {},
                      toFirestore: (value, _) => value,
                    )
                    .snapshots()
                    .map(
                      (q) => q.docs
                          .map(
                            (d) => UserSkillStats.fromDoc(
                              d as DocumentSnapshot<Map<String, dynamic>>,
                            ),
                          )
                          .toList(),
                    );
              }).toList();

              return Rx.combineLatestList<List<UserSkillStats>>(streams).map((
                lists,
              ) {
                // Flatten
                final all = <UserSkillStats>[];
                for (final l in lists) {
                  all.addAll(l);
                }
                // Group by skillCode
                final Map<String, List<UserSkillStats>> bySkill = {};
                for (final s in all) {
                  bySkill
                      .putIfAbsent(s.skillCode, () => <UserSkillStats>[])
                      .add(s);
                }
                final aggs = <SkillAggregate>[];
                bySkill.forEach((code, stats) {
                  final usersCount =
                      stats.length; // users who have this skill stat
                  final avg =
                      stats
                          .map((e) => e.masteryScore)
                          .fold<double>(0, (a, b) => a + b) /
                      usersCount;
                  final avgDelta =
                      stats
                          .map((e) => e.delta14d)
                          .fold<double>(0, (a, b) => a + b) /
                      usersCount;
                  aggs.add(
                    SkillAggregate(
                      skillCode: code,
                      avgMastery: avg,
                      avgDelta14d: avgDelta,
                      usersCount: usersCount,
                    ),
                  );
                });
                aggs.sort((a, b) => a.avgMastery.compareTo(b.avgMastery));
                return aggs;
              });
            },
            loading: () => const Stream.empty(),
            error: (_, __) => const Stream.empty(),
          );
    });

// Aggregate per-member mastery for a department (avg mastery and Δ14d per user)
class TeamMemberMastery {
  final String userId;
  final double avgMastery;
  final double avgDelta14d;
  const TeamMemberMastery({
    required this.userId,
    required this.avgMastery,
    required this.avgDelta14d,
  });
}

final teamMemberMasteriesProvider =
    StreamProvider.family<List<TeamMemberMastery>, String>((ref, departmentId) {
  final fs = ref.watch(_fs);
  return ref.watch(teamUserIdsByDepartmentProvider(departmentId)).when(
        data: (userIds) {
          if (userIds.isEmpty) return Stream.value(const <TeamMemberMastery>[]);
          // Build one stream per user that yields their averaged mastery across skills
          final streams = userIds.map((uid) {
            return fs
                .collection('user_skill_stats')
                .where('userId', isEqualTo: uid)
                .withConverter<Map<String, dynamic>>(
                  fromFirestore: (snap, _) => snap.data() ?? {},
                  toFirestore: (value, _) => value,
                )
                .snapshots()
                .map((q) {
              final stats = q.docs
                  .map((d) => UserSkillStats.fromDoc(
                      d as DocumentSnapshot<Map<String, dynamic>>))
                  .toList();
              if (stats.isEmpty) {
                return const UserAvgMastery(avgMastery: 0, avgDelta14d: 0);
              }
              final avg = stats
                      .map((s) => s.masteryScore)
                      .fold<double>(0, (a, b) => a + b) /
                  stats.length;
              final delta = stats
                      .map((s) => s.delta14d)
                      .fold<double>(0, (a, b) => a + b) /
                  stats.length;
              return UserAvgMastery(avgMastery: avg, avgDelta14d: delta);
            });
          }).toList();

          return Rx.combineLatestList<UserAvgMastery>(streams).map((list) {
            // Pair results with userIds in the same order
            final result = <TeamMemberMastery>[];
            for (var i = 0; i < list.length; i++) {
              final m = list[i];
              result.add(TeamMemberMastery(
                userId: userIds[i],
                avgMastery: m.avgMastery,
                avgDelta14d: m.avgDelta14d,
              ));
            }
            return result;
          });
        },
        loading: () => const Stream.empty(),
        error: (_, __) => const Stream.empty(),
      );
});

// Simple plateau risk threshold: non-positive progress over 14d
const double _kPlateauDeltaThreshold = 0.0;

// Emits the set of userIds in the department considered at risk (plateau/decline)
final teamPlateauFlagsProvider =
    StreamProvider.family<Set<String>, String>((ref, departmentId) {
  return ref.watch(teamMemberMasteriesProvider(departmentId)).when(
        data: (members) {
          final risky = members
              .where((m) => m.avgDelta14d <= _kPlateauDeltaThreshold)
              .map((m) => m.userId)
              .toSet();
          return Stream.value(risky);
        },
        loading: () => const Stream.empty(),
        error: (_, __) => const Stream.empty(),
      );
});
