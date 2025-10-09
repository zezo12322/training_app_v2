import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../core/l10n_ext.dart';
import 'earned_badges_grid.dart';
import 'locked_badges_grid.dart';

class BadgesOverview extends ConsumerStatefulWidget {
  const BadgesOverview({super.key});

  @override
  ConsumerState<BadgesOverview> createState() => _BadgesOverviewState();
}

class _BadgesOverviewState extends ConsumerState<BadgesOverview>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authStateProvider).value;
    final l = context.l;
    if (auth == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          controller: _controller,
          tabs: [
            Tab(text: l.earnedBadgesSection),
            Tab(text: l.allBadgesSection),
          ],
        ),
        SizedBox(
          height: 220,
          child: TabBarView(
            controller: _controller,
            children: const [EarnedBadgesGrid(), LockedBadgesGrid()],
          ),
        ),
      ],
    );
  }
}
