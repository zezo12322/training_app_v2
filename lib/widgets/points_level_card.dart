import 'package:flutter/material.dart';
// Removed explicit semantics import (not needed; Semantics widget available via material)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/gamification_providers.dart';
import '../providers/auth_provider.dart';
import '../core/l10n_ext.dart';

class PointsLevelCard extends ConsumerWidget {
  const PointsLevelCard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider).value;
    if (auth == null) {
      return const SizedBox.shrink();
    }
    final pointsAsync = ref.watch(userPointsStreamProvider(auth.uid));
    final level = ref.watch(currentUserLevelProvider);
    final lvlProg = ref.watch(currentUserLevelProgressProvider);
    final badgeProgress = ref.watch(nextBadgeProgressProvider);
    final dailyStreak = ref.watch(currentUserDailyStreakProvider);
    return Semantics(
      container: true,
      label: 'User progress card',
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: pointsAsync.when(
            data: (up) {
              final pts = up?.points ?? 0;
              final l = context.l;
              // Fallbacks في حال لم تُولد المفاتيح بعد
              String safe(String Function() getter, String fb) {
                try {
                  final v = getter();
                  return (v.isEmpty) ? fb : v;
                } catch (_) {
                  return fb;
                }
              }

              String pointsLabel = safe(() => l.pointsLabel, 'Points');
              String badgesLabel = safe(() => l.badgesLabel, 'Badges');
              String levelText(int lv) =>
                  safe(() => l.levelLabel(lv.toString()), 'Level $lv');
              String nextBadge(int p) => safe(
                () => l.nextBadgeProgress(p.toString()),
                'Next badge at $p pts',
              );
              final next = badgeProgress.value?.nextThreshold;
              final remaining = badgeProgress.value?.remaining ?? 0;
              final badgePercent =
                  ref.watch(nextBadgeProgressPercentProvider) ?? 0;
              final lp = lvlProg;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '$pointsLabel: $pts',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      if (lp != null)
                        Tooltip(
                          message: 'Level ${lp.level}',
                          child: const Icon(Icons.insights_outlined, size: 18),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (level != null) Text(levelText(level)),
                  if (lp != null) ...[
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: lp.percent,
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${lp.currentPoints - lp.baseLevelPoints}/${lp.nextLevelPoints - lp.baseLevelPoints} to next level',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  if (dailyStreak != null && dailyStreak > 0) ...[
                    const SizedBox(height: 4),
                    Text(
                      safe(
                        () => l.streakLabel(dailyStreak.toString()),
                        'Streak: $dailyStreak',
                      ),
                    ),
                  ],
                  if (next != null) ...[
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(value: badgePercent),
                    ),
                    const SizedBox(height: 4),
                    Text('${nextBadge(next)} | -$remaining'),
                  ] else ...[
                    const SizedBox(height: 6),
                    Text('$badgesLabel: ${(up?.badges.length ?? 0)}'),
                  ],
                ],
              );
            },
            error: (e, _) => Text('Err: $e'),
            loading: () => _skeleton(),
          ),
        ),
      ),
    );
  }

  Widget _skeleton() {
    Widget bar({double w = 80, double h = 10}) => Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        bar(w: 120, h: 14),
        const SizedBox(height: 8),
        bar(w: 90, h: 12),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: 0.2,
            backgroundColor: Colors.grey.shade200,
          ),
        ),
        const SizedBox(height: 10),
        bar(w: 150, h: 12),
      ],
    );
  }
}
