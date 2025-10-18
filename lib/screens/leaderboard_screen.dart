import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/gamification_providers.dart';
import '../core/l10n_ext.dart';
import 'package:training_app/widgets/widgets.dart';
import 'package:training_app/core/design/tokens.dart';
import 'dashboard_helpers.dart';

class LeaderboardScreen extends ConsumerWidget {
  final int limit;
  const LeaderboardScreen({super.key, this.limit = 50});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final entriesAsync = ref.watch(leaderboardEntriesProvider(limit));
    return Scaffold(
      appBar: AppBar(title: Text(l.leaderboardTitle)),
      body: entriesAsync.when(
        data: (entries) {
          if (entries.isEmpty) {
            return AppEmptyState(
              icon: Icons.leaderboard_outlined,
              title: l.leaderboardEmpty,
              actionLabel: 'Earn points to appear here',
            );
          }
          return RefreshIndicator(
            onRefresh: () async =>
                ref.refresh(leaderboardEntriesProvider(limit)),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: DesignTokens.spacingSm),
              itemCount: entries.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                color: DesignTokens.borderColor(context),
              ),
              itemBuilder: (context, index) {
                final e = entries[index];
                final isTopThree = e.rank <= 3;
                return AppCard(
                  margin: EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacingMd,
                    vertical: DesignTokens.spacingXs,
                  ),
                  padding: EdgeInsets.all(DesignTokens.spacingSm),
                  child: Row(
                    children: [
                      // Rank Badge
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isTopThree
                              ? (e.rank == 1
                                  ? Colors.amber.withOpacity(0.2)
                                  : e.rank == 2
                                      ? Colors.grey.withOpacity(0.2)
                                      : Colors.brown.withOpacity(0.2))
                              : DesignTokens.fillColor(context),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            e.rank.toString(),
                            style: DesignTokens.h5(context).copyWith(
                              color: isTopThree
                                  ? (e.rank == 1
                                      ? Colors.amber[700]
                                      : e.rank == 2
                                          ? Colors.grey[700]
                                          : Colors.brown[700])
                                  : DesignTokens.textPrimary(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: DesignTokens.spacingSm),
                      // User Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.name ?? l.commentFallbackName,
                              style: DesignTokens.body1(context).copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: DesignTokens.spacingXxs),
                            Row(
                              children: [
                                Icon(
                                  Icons.stars,
                                  size: 14,
                                  color: DesignTokens.warning,
                                ),
                                SizedBox(width: DesignTokens.spacingXxs),
                                Text(
                                  l.leaderboardPoints(e.points.toString()),
                                  style: DesignTokens.caption(context).copyWith(
                                    color: DesignTokens.textSecondary(context),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Badges
                      if (e.badges.isNotEmpty)
                        Wrap(
                          spacing: 4,
                          children: e.badges
                              .take(3)
                              .map(
                                (b) => AppBadge(
                                  text: b,
                                  type: AppBadgeType.info,
                                  size: AppBadgeSize.sm,
                                ),
                              )
                              .toList(),
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        },
        error: (e, st) => AppErrorState(
          message: DashboardErrorHandler.getUserFriendlyMessage(
            e,
            l.errorGeneric(e.toString()),
          ),
          onRetry: () => ref.invalidate(leaderboardEntriesProvider(limit)),
        ),
        loading: () => ListView.builder(
          padding: EdgeInsets.all(DesignTokens.spacingMd),
          itemCount: 10,
          itemBuilder: (_, i) => Padding(
            padding: EdgeInsets.only(bottom: DesignTokens.spacingSm),
            child: AppCard(
              padding: EdgeInsets.all(DesignTokens.spacingSm),
              child: Row(
                children: [
                  AppLoadingSkeleton(
                    type: AppSkeletonType.circle,
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(width: DesignTokens.spacingSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLoadingSkeleton(width: 120, height: 16),
                        SizedBox(height: DesignTokens.spacingXs),
                        AppLoadingSkeleton(width: 80, height: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
