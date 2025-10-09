import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../core/l10n_ext.dart';
import '../widgets/points_level_card.dart';
import '../widgets/points_events_timeline.dart';
import 'badges_overview_screen.dart';
import '../providers/gamification_providers.dart';
import '../providers/points_events_providers.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    if (user == null) return const SizedBox.shrink();
    final l = context.l;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.gamificationSection),
        actions: [
          IconButton(
            tooltip: l.badgesLabel,
            icon: const Icon(Icons.emoji_events_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const BadgesOverviewScreen()),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(userPointsStreamProvider(user.uid));
          ref.invalidate(nextBadgeProgressProvider);
          ref.invalidate(currentUserLevelProgressProvider);
          ref.invalidate(currentUserLevelProvider);
          ref.invalidate(
            userPointEventsPagerProvider((userId: user.uid, type: null)),
          );
          await Future<void>.delayed(const Duration(milliseconds: 150));
        },
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: PointsLevelCard(),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: PointsEventsTimeline(userId: user.uid),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
