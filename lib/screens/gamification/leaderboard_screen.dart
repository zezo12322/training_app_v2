import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n_ext.dart';
import '../../models/gamification/leaderboard_entry.dart';
import '../../providers/auth_provider.dart';
import '../../providers/gamification/leaderboard_providers.dart';

/// شاشة المتصدرين (Leaderboard)
///
/// تعرض:
/// - تبويبات للفترات الزمنية (أسبوعي، شهري، كل الأوقات)
/// - منصة التتويج للثلاث الأوائل
/// - قائمة الترتيب لبقية الطلاب
/// - إبراز المستخدم الحالي
class LeaderboardScreen extends ConsumerStatefulWidget {
  final String courseId;

  const LeaderboardScreen({
    super.key,
    required this.courseId,
  });

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 2);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      setState(() {
        // Rebuild on tab change
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final userId = authState.value?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.leaderboardTitle),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: context.l.leaderboardWeekly),
            Tab(text: context.l.leaderboardMonthly),
            Tab(text: context.l.leaderboardAllTime),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLeaderboardContent(
            LeaderboardTimeframe.weekly,
            userId,
          ),
          _buildLeaderboardContent(
            LeaderboardTimeframe.monthly,
            userId,
          ),
          _buildLeaderboardContent(
            LeaderboardTimeframe.allTime,
            userId,
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardContent(
    LeaderboardTimeframe timeframe,
    String? userId,
  ) {
    final leaderboardAsync = ref.watch(
      leaderboardProvider((
        courseId: widget.courseId,
        timeframe: timeframe,
        limit: 100,
      )),
    );

    return leaderboardAsync.when(
      data: (entries) {
        if (entries.isEmpty) {
          return _buildEmptyState(context);
        }

        final topThree = entries.take(3).toList();
        final rest = entries.skip(3).toList();

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(leaderboardProvider);
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (topThree.isNotEmpty) ...[
                _buildPodium(topThree),
                const SizedBox(height: 32),
              ],
              ...rest.map((entry) => _buildLeaderboardTile(
                    entry,
                    userId == entry.userId,
                    context,
                  )),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorState(error, context),
    );
  }

  Widget _buildPodium(List<LeaderboardEntry> topThree) {
    return SizedBox(
      height: 250,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // المركز الثاني (يسار)
          if (topThree.length >= 2)
            Positioned(
              left: 0,
              bottom: 20,
              child: _buildPodiumPosition(
                topThree[1],
                2,
                Colors.grey.shade400,
                150,
                context,
              ),
            ),

          // المركز الأول (منتصف)
          if (topThree.isNotEmpty)
            Positioned(
              bottom: 40,
              child: _buildPodiumPosition(
                topThree[0],
                1,
                Colors.amber,
                180,
                context,
              ),
            ),

          // المركز الثالث (يمين)
          if (topThree.length >= 3)
            Positioned(
              right: 0,
              bottom: 0,
              child: _buildPodiumPosition(
                topThree[2],
                3,
                Colors.brown.shade300,
                120,
                context,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPodiumPosition(
    LeaderboardEntry entry,
    int rank,
    Color color,
    double height,
    BuildContext context,
  ) {
    final l = context.l;
    final medals = ['🥇', '🥈', '🥉'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar
        CircleAvatar(
          radius: rank == 1 ? 40 : 30,
          backgroundImage: entry.userAvatar != null
              ? NetworkImage(entry.userAvatar!)
              : null,
          child: entry.userAvatar == null
              ? Text(
                  entry.userName.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontSize: rank == 1 ? 24 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),

        const SizedBox(height: 8),

        // Name
        SizedBox(
          width: 100,
          child: Text(
            entry.userName,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: rank == 1 ? 16 : 14,
            ),
          ),
        ),

        const SizedBox(height: 4),

        // Points
        Text(
          l.leaderboardPointsWithLabel(entry.totalPoints.toString()),
          style: TextStyle(
            fontSize: rank == 1 ? 14 : 12,
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 8),

        // Podium
        Container(
          width: 100,
          height: height,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.3),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8),
            ),
            border: Border.all(color: color, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                medals[rank - 1],
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 4),
              Text(
                '#$rank',
                style: TextStyle(
                  fontSize: rank == 1 ? 24 : 20,
                  fontWeight: FontWeight.bold,
                  color: color.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardTile(LeaderboardEntry entry, bool isCurrentUser, BuildContext context) {
    final l = context.l;
    return Card(
      color: isCurrentUser ? Colors.blue.shade50 : null,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getRankColor(entry.rank),
          child: Text(
            '#${entry.rank}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                entry.userName,
                style: TextStyle(
                  fontWeight: isCurrentUser ? FontWeight.bold : null,
                ),
              ),
            ),
            if (isCurrentUser)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  l.leaderboardYou,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Text(
          l.leaderboardLevelFormat(entry.currentLevel.toString(), entry.levelName),
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${entry.totalPoints}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              l.leaderboardPointsShort,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    if (rank <= 3) return Colors.amber;
    if (rank <= 10) return Colors.blue;
    if (rank <= 20) return Colors.green;
    return Colors.grey;
  }

  Widget _buildEmptyState(BuildContext context) {
    final l = context.l;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.emoji_events_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            l.leaderboardEmptyTitle,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l.leaderboardEmptySubtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error, BuildContext context) {
    final l = context.l;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            l.leaderboardErrorLoad,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              ref.invalidate(leaderboardProvider);
            },
            icon: const Icon(Icons.refresh),
            label: Text(context.l.leaderboardRetry),
          ),
        ],
      ),
    );
  }
}
