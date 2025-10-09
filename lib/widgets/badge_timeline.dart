import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/gamification_providers.dart';
import '../providers/auth_provider.dart';
import '../core/l10n_ext.dart';

class BadgeTimeline extends ConsumerWidget {
  const BadgeTimeline({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider).value;
    if (auth == null) return const SizedBox.shrink();
    final historyAsync = ref.watch(badgeAwardsHistoryProvider(auth.uid));
    final badgeMap = ref.watch(badgeIdToBadgeProvider);
    final l = context.l;
    return historyAsync.when(
      data: (items) {
        if (items.isEmpty) {
          return Text(l.noBadgesYet);
        }
        final nameMap = {for (final e in badgeMap.entries) e.key: e.value.name};
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 8),
          itemBuilder: (_, i) {
            final h = items[i];
            final name = nameMap[h.badgeId] ?? h.badgeId;
            final dt = h.awardedAt;
            final time = dt != null
                ? '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}'
                : '...';
            return ListTile(
              leading: const Icon(Icons.emoji_events_outlined),
              title: Text(name),
              subtitle: Text(time),
            );
          },
        );
      },
      error: (e, _) => Text('Err: $e'),
      loading: () => const Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
          height: 48,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
