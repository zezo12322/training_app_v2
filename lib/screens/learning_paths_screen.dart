import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/learning_path_providers.dart';
import '../providers/path_step_providers.dart';
import 'package:training_app/core/l10n_ext.dart';
import '../providers/auth_provider.dart';
import '../models/user_path_progress.dart';
import '../services/user_path_progress_service.dart';

class LearningPathsScreen extends ConsumerWidget {
  final String companyId;
  const LearningPathsScreen({super.key, required this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pathsAsync = ref.watch(companyLearningPathsProvider(companyId));
    return Scaffold(
      appBar: AppBar(title: Text(context.learningPathsTitle)),
      body: pathsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (list) {
          if (list.isEmpty) return Center(child: Text(context.noLearningPaths));
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (ctx, i) {
              final lp = list[i];
              return ListTile(
                leading: const Icon(Icons.route_outlined),
                title: Text(lp.title),
                subtitle: Text(
                  (lp.description ?? '').isEmpty ? '—' : lp.description!,
                ),
                trailing: lp.active
                    ? Chip(label: Text(context.activeChip))
                    : Chip(label: Text(context.inactiveChip)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          _PathStepsScreen(pathId: lp.id, title: lp.title),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _PathStepsScreen extends ConsumerWidget {
  final String pathId;
  final String title;
  const _PathStepsScreen({required this.pathId, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepsAsync = ref.watch(pathStepsProvider(pathId));
    final auth = ref.watch(authStateProvider).value;
    final progressAsync = auth == null
        ? const AsyncValue<UserPathProgress?>.data(null)
        : ref.watch(
            userPathProgressProvider((userId: auth.uid, pathId: pathId)),
          );
  final svc = ref.read(userPathProgressServiceProvider);
    return Scaffold(
      appBar: AppBar(title: Text(context.pathTitle(title))),
      body: stepsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (steps) {
          if (steps.isEmpty) return Center(child: Text(context.noSteps));
          return ListView.separated(
            itemCount: steps.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (ctx, i) {
              final s = steps[i];
              if (i == 0) {
                // Insert a lightweight progress header above the first step
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: progressAsync.when(
                        loading: () => const LinearProgressIndicator(),
                        error: (e, st) => const SizedBox.shrink(),
                        data: (p) {
                          if (p == null || p.totalSteps == 0) {
                            return const SizedBox.shrink();
                          }
                          final total = steps.length; // compute from current list
                          final frac = (p.completedSteps / total)
                              .clamp(0.0, 1.0);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                        '${(frac * 100).toStringAsFixed(0)}%'),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    tooltip: 'Decrement',
                                    icon: const Icon(
                                        Icons.remove_circle_outline),
                                    onPressed: auth == null
                                        ? null
                                        : () async {
                                            final next = (p.completedSteps - 1)
                                                .clamp(0, total);
                                            try {
                                              await svc.setProgress(
                                                userId: auth.uid,
                                                pathId: pathId,
                                                completedSteps: next,
                                                totalSteps: total,
                                              );
                                            } catch (_) {}
                                          },
                                  ),
                                  IconButton(
                                    tooltip: 'Increment',
                                    icon:
                                        const Icon(Icons.add_circle_outline),
                                    onPressed: auth == null
                                        ? null
                                        : () async {
                                            final next = (p.completedSteps + 1)
                                                .clamp(0, total);
                                            try {
                                              await svc.setProgress(
                                                userId: auth.uid,
                                                pathId: pathId,
                                                completedSteps: next,
                                                totalSteps: total,
                                              );
                                            } catch (_) {}
                                          },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              LinearProgressIndicator(value: frac),
                            ],
                          );
                        },
                      ),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.flag_outlined),
                      title: Text('${s.order}. ${s.title}'),
                      subtitle: Text(
                        (s.description ?? '').isEmpty ? '—' : s.description!,
                      ),
                    ),
                  ],
                );
              }
              return ListTile(
                leading: const Icon(Icons.flag_outlined),
                title: Text('${s.order}. ${s.title}'),
                subtitle: Text(
                  (s.description ?? '').isEmpty ? '—' : s.description!,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
