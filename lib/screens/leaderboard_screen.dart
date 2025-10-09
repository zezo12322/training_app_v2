import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/gamification_providers.dart';
import '../core/l10n_ext.dart';

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
          if (entries.isEmpty) return Center(child: Text(l.leaderboardEmpty));
          return RefreshIndicator(
            onRefresh: () async =>
                ref.refresh(leaderboardEntriesProvider(limit)),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: entries.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final e = entries[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(e.rank.toString())),
                  title: Text(e.name ?? l.commentFallbackName),
                  subtitle: Text(l.leaderboardPoints(e.points.toString())),
                  trailing: e.badges.isNotEmpty
                      ? Wrap(
                          spacing: 4,
                          children: e.badges
                              .take(5)
                              .map(
                                (b) => Chip(
                                  label: Text(
                                    b,
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                  visualDensity: VisualDensity.compact,
                                ),
                              )
                              .toList(),
                        )
                      : null,
                );
              },
            ),
          );
        },
        error: (e, st) => Center(child: Text(l.errorGeneric(e.toString()))),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
