import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/gamification_providers.dart';
import '../core/l10n_ext.dart';
import '../models/badge.dart' as model;
import 'create_badge_screen.dart';

class BadgesOverviewScreen extends ConsumerWidget {
  const BadgesOverviewScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider).value;
    if (auth == null) return const SizedBox.shrink();
    final l = context.l;
    final earnedLocked = ref.watch(earnedLockedBadgesProvider(auth.uid));
    return Scaffold(
      appBar: AppBar(title: Text(l.badgesLabel)),
      body: Builder(
        builder: (_) {
          final earned = earnedLocked.$1;
          final locked = earnedLocked.$2;
          if (earned.isEmpty && locked.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomScrollView(
            slivers: [
              _sectionHeader(l.earnedBadgesSection),
              if (earned.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(l.noBadgesYet),
                  ),
                )
              else
                _badgesGrid(earned, earned: true),
              _sectionHeader(l.allBadgesSection),
              if (locked.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(l.noBadgesYet),
                  ),
                )
              else
                _badgesGrid(locked, earned: false),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab_add_badge',
        onPressed: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const CreateBadgeScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }

  SliverToBoxAdapter _sectionHeader(String title) => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
  );

  Widget _badgeTile(model.Badge b, {required bool earned}) {
    final fx = earned ? Colors.green : Colors.grey;
    final crit = b.criteria;
    String criteriaSummary() {
      if (crit.isEmpty) return 'No criteria';
      return crit.entries.map((e) => '${e.key}:${e.value}').join(', ');
    }

    return Tooltip(
      message: criteriaSummary(),
      waitDuration: const Duration(milliseconds: 300),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: fx.withValues(alpha: 0.15),
            backgroundImage: b.iconUrl.isNotEmpty
                ? NetworkImage(b.iconUrl)
                : null,
            child: b.iconUrl.isEmpty
                ? Icon(
                    earned ? Icons.emoji_events : Icons.lock_outline,
                    color: fx,
                  )
                : null,
          ),
          const SizedBox(height: 6),
          Text(
            b.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: earned ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  SliverPadding _badgesGrid(List<model.Badge> list, {required bool earned}) =>
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 110,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          delegate: SliverChildBuilderDelegate(
            (ctx, i) => _badgeTile(list[i], earned: earned),
            childCount: list.length,
          ),
        ),
      );
}
