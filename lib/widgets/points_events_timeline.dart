import 'package:flutter/material.dart';
// duplicate import removed
import '../providers/points_events_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_point_event.dart';
import '../core/l10n_ext.dart';

final _eventFilterProvider = StateProvider<String?>((_) => null); // null = all

class PointsEventsTimeline extends ConsumerWidget {
  final String userId;
  const PointsEventsTimeline({super.key, required this.userId});

  String _labelFor(UserPointEvent e) {
    switch (e.type) {
      case 'quiz_pass':
        return 'Quiz passed +${e.points}';
      case 'task_completed':
        return 'Task completed +${e.points}';
      case 'lesson_completed':
        return 'Lesson completed +${e.points}';
      case 'daily_streak':
        final streak = e.extra['streakAfter'];
        return 'Daily streak +${e.points}${streak != null ? ' (streak $streak)' : ''}';
      default:
        return '${e.type} +${e.points}';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(_eventFilterProvider);
    final pager = ref.watch(
      userPointEventsPagerProvider((userId: userId, type: filter)),
    );
    final controller = ref.read(
      userPointEventsPagerProvider((userId: userId, type: filter)).notifier,
    );
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              _chip(
                ref,
                label: context.l.timelineFilterAll,
                value: null,
                current: filter,
              ),
              _chip(
                ref,
                label: context.l.timelineFilterQuizzes,
                value: 'quiz_pass',
                current: filter,
              ),
              _chip(
                ref,
                label: context.l.timelineFilterTasks,
                value: 'task_completed',
                current: filter,
              ),
              _chip(
                ref,
                label: context.l.timelineFilterLessons,
                value: 'lesson_completed',
                current: filter,
              ),
              _chip(
                ref,
                label: context.l.timelineFilterStreak,
                value: 'daily_streak',
                current: filter,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: pager.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (list) {
              if (list.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(
                      userPointEventsPagerProvider((
                        userId: userId,
                        type: filter,
                      )),
                    );
                    await Future<void>.delayed(
                      const Duration(milliseconds: 120),
                    );
                  },
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: 120),
                      Icon(
                        Icons.hourglass_empty,
                        size: 64,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(height: 12),
                      Center(child: Text(context.l.timelineNoMoreEvents)),
                    ],
                  ),
                );
              }
              return ListView.separated(
                itemCount: list.length + 1,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (ctx, i) {
                  if (i == list.length) {
                    if (controller.exhausted) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(context.l.timelineNoMoreEvents),
                      );
                    }
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      controller.loadMore();
                    });
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }
                  final e = list[i];
                  return ListTile(
                    title: Text(_labelFor(e)),
                    subtitle: Text(e.createdAt?.toLocal().toString() ?? ''),
                    leading: const Icon(Icons.bolt_outlined),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget _chip(
  WidgetRef ref, {
  required String label,
  required String? value,
  required String? current,
}) {
  final selected = value == current;
  return Padding(
    padding: const EdgeInsets.only(right: 6),
    child: FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        ref.read(_eventFilterProvider.notifier).state = value;
      },
    ),
  );
}
