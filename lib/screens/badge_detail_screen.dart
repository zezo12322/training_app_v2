import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/badge_management_providers.dart';
import '../core/l10n_ext.dart';
import '../models/badge.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';

/// Provider to stream a single badge document
final badgeDocumentProvider = StreamProvider.family<model.Badge?, String>((
  ref,
  id,
) {
  final col = ref.watch(badgeManagementRepositoryProvider);
  return col
      .doc(id)
      .snapshots()
      .map(
        (d) => d.exists
            ? model.Badge.fromMap(d.data() as Map<String, dynamic>, d.id)
            : null,
      );
});

/// Provider to stream owners (limited) using array-contains on user_points.badges
final badgeOwnersProvider =
    StreamProvider.family<List<Map<String, dynamic>>, String>((
      ref,
      badgeId,
    ) async* {
      final fs = FirebaseFirestore.instance;
      yield* fs
          .collection('user_points')
          .where('badges', arrayContains: badgeId)
          .limit(30)
          .snapshots()
          .map(
            (snap) => snap.docs
                .map((d) => {'userId': d.id, 'points': d.data()['points'] ?? 0})
                .toList(),
          );
    });

class BadgeDetailScreen extends ConsumerWidget {
  final String badgeId;
  const BadgeDetailScreen({super.key, required this.badgeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final badgeAsync = ref.watch(badgeDocumentProvider(badgeId));
    final ownersAsync = ref.watch(badgeOwnersProvider(badgeId));
    return Scaffold(
      appBar: AppBar(title: Text('Badge')),
      body: badgeAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (badge) {
          if (badge == null) return Center(child: Text(l.noBadgesDefined));
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: badge.iconUrl.isNotEmpty
                        ? NetworkImage(badge.iconUrl)
                        : null,
                    child: badge.iconUrl.isEmpty
                        ? Text(badge.name.isNotEmpty ? badge.name[0] : '?')
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      badge.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(badge.description),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  _chip('Active: ${badge.active}'),
                  _chip('Auto: ${badge.autoAward}'),
                  if (badge.criteria.isNotEmpty)
                    ...badge.criteria.entries.map(
                      (e) => _chip('${e.key}=${e.value}'),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Text('Owners', style: Theme.of(context).textTheme.titleMedium),
              ownersAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(8),
                  child: LinearProgressIndicator(),
                ),
                error: (e, _) => Text('Error: $e'),
                data: (list) => list.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('None'),
                      )
                    : Column(
                        children: list
                            .map(
                              (o) => ListTile(
                                dense: true,
                                leading: const Icon(Icons.person),
                                title: Text(o['userId'] as String),
                                subtitle: Text('Points: ${o['points']}'),
                              ),
                            )
                            .toList(),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _chip(String label) => Chip(label: Text(label));
}
