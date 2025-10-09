import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/tasks/task_models.dart';
import '../features/tasks/task_providers.dart';
import '../features/quizzes/quiz_providers.dart';
import '../features/quizzes/quiz_models.dart';
import '../features/quizzes/quiz_attempt_providers.dart';
import '../providers/auth_provider.dart';
import 'quiz_attempt_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/l10n_ext.dart';
import '../services/points_award_service.dart';
import 'create_quiz_screen.dart';

// ---------------------------------------------------------------------------
// Temporary lightweight models (to be replaced / merged with real models)
// ---------------------------------------------------------------------------
class QuizLite {
  final String id;
  final String title;
  final int totalQuestions;
  final int? lastScore; // percent
  final bool allowRetake;
  const QuizLite({
    required this.id,
    required this.title,
    required this.totalQuestions,
    this.lastScore,
    this.allowRetake = true,
  });
}

class TaskLite {
  final String id;
  final String title;
  final String status; // pending | in_progress | done
  const TaskLite({
    required this.id,
    required this.title,
    this.status = 'pending',
  });
}

// ---------------------------------------------------------------------------
// Removed placeholder providers; now using Firestore-backed providers in quiz_providers.dart & task_providers.dart

// ---------------------------------------------------------------------------
// Entry Screen with Tabs
// ---------------------------------------------------------------------------
class QuizHubScreen extends StatelessWidget {
  final String courseId; // keep inside course context
  const QuizHubScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _HubAppBar(courseId: courseId),
        body: TabBarView(
          children: [
            _TestsTab(courseId: courseId),
            _TasksTab(courseId: courseId),
          ],
        ),
        floatingActionButton: _FabSwitcher(courseId: courseId),
      ),
    );
  }
}

class _FabSwitcher extends ConsumerStatefulWidget {
  final String courseId;
  const _FabSwitcher({required this.courseId});
  @override
  ConsumerState<_FabSwitcher> createState() => _FabSwitcherState();
}

class _FabSwitcherState extends ConsumerState<_FabSwitcher> {
  TabController? _controller;

  void _attachController() {
    final ctrl = DefaultTabController.maybeOf(context);
    if (ctrl != null && ctrl != _controller) {
      _controller?.removeListener(_onTabChanged);
      _controller = ctrl;
      _controller!.addListener(_onTabChanged);
    }
  }

  void _onTabChanged() {
    if (mounted) setState(() {}); // rebuild FAB when index changes
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _attachController();
  }

  @override
  void dispose() {
    _controller?.removeListener(_onTabChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref
        .watch(currentUserModelProvider)
        .maybeWhen(data: (u) => u, orElse: () => null);
    final isTrainer = user?.role == 'trainer';
    if (!isTrainer) return const SizedBox.shrink();
    final tabIndex = _controller?.index ?? 0;
    if (tabIndex == 0) {
      return FloatingActionButton(
        heroTag: 'fab_add_quiz',
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CreateQuizScreen(courseId: widget.courseId),
          ),
        ),
        child: const Icon(Icons.quiz_outlined),
      );
    }
    return _AddTaskProxyFab(courseId: widget.courseId);
  }
}

class _AddTaskProxyFab extends ConsumerWidget {
  final String courseId;
  const _AddTaskProxyFab({required this.courseId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      heroTag: 'fab_add_task',
      onPressed: () => _showTaskDialog(context, ref, courseId),
      child: const Icon(Icons.add_task),
    );
  }
}

Future<void> _showTaskDialog(
  BuildContext context,
  WidgetRef ref,
  String courseId,
) async {
  final titleController = TextEditingController();
  final detailsController = TextEditingController();
  final pointsController = TextEditingController(text: '5');
  String priority = 'low';
  DateTime? pickedDue;
  final result = await showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(context.l.addTaskDialogTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              autofocus: true,
              decoration: InputDecoration(hintText: context.l.fieldTitleHint),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: detailsController,
              maxLines: 2,
              decoration: InputDecoration(hintText: context.l.fieldDetailsHint),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: pointsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: context.l.fieldPointsHint),
            ),
            const SizedBox(height: 8),
            _DueDatePickerField(onChanged: (d) => pickedDue = d),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: priority,
              items: const [
                DropdownMenuItem(value: 'low', child: _PriorityLabel('low')),
                DropdownMenuItem(value: 'med', child: _PriorityLabel('med')),
                DropdownMenuItem(value: 'high', child: _PriorityLabel('high')),
              ],
              onChanged: (v) => priority = v ?? 'low',
              decoration: InputDecoration(labelText: context.l.priorityLabel),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(context.l.cancelAction),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(ctx, titleController.text.trim()),
          child: Text(context.l.editSave),
        ),
      ],
    ),
  );
  if (result != null && result.isNotEmpty) {
    final uid = ref.read(authStateProvider).value?.uid ?? 'unknown';
    final points = int.tryParse(pointsController.text.trim()) ?? 0;
    final dueDate = pickedDue;
    final fut = ref.read(
      createTaskProvider(
        CreateTaskInput(
          parentType: TaskParentType.course,
          parentId: courseId,
          title: result,
          details: detailsController.text.trim().isEmpty
              ? null
              : detailsController.text.trim(),
          createdBy: uid,
          pointsOnComplete: points,
          priority: priority,
          dueDate: dueDate,
        ),
      ).future,
    );
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('... جاري إنشاء المهمة')));
    }
    await fut;
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l.quizUpdateSuccess)),
      ); // reuse success key
    }
  }
}

class _HubAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String courseId;
  const _HubAppBar({required this.courseId});
  @override
  Size get preferredSize => const Size.fromHeight(104);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizProg = ref.watch(quizProgressForCourseProvider(courseId));
    // Correct usage: watch then maybeWhen
    final taskProg = ref
        .watch(
          taskProgressProvider((
            parentType: TaskParentType.course,
            parentId: courseId,
          )),
        )
        .maybeWhen(data: (v) => v, orElse: () => 0.0);
    return AppBar(
      title: Text(context.l.progressTitle),
      bottom: TabBar(
        tabs: [
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(context.l.testsTabLabel),
                const SizedBox(height: 4),
                _MiniBar(value: quizProg),
              ],
            ),
          ),
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(context.l.tasksTabLabel),
                const SizedBox(height: 4),
                _MiniBar(value: taskProg, color: Colors.teal),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniBar extends StatelessWidget {
  final double value;
  final Color? color;
  const _MiniBar({required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: LinearProgressIndicator(
        value: value.clamp(0, 1),
        minHeight: 4,
        backgroundColor: Theme.of(
          context,
        ).colorScheme.outline.withValues(alpha: .15),
        valueColor: AlwaysStoppedAnimation(
          color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tests Tab Placeholder
// ---------------------------------------------------------------------------
class _TestsTab extends ConsumerWidget {
  final String courseId;
  const _TestsTab({required this.courseId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzesAsync = ref.watch(courseQuizzesProvider(courseId));
    final latestSubsAsync = ref.watch(latestQuizSubmissionsProvider(courseId));
    final userModel = ref
        .watch(currentUserModelProvider)
        .maybeWhen(data: (u) => u, orElse: () => null);
    final isTrainer = userModel?.role == 'trainer';
    final trainerSubs = isTrainer
        ? ref
              .watch(trainerAllSubmissionsProvider(courseId))
              .maybeWhen(
                data: (d) => d,
                orElse: () => const <String, List<QuizSubmissionLite>>{},
              )
        : const <String, List<QuizSubmissionLite>>{};
    return quizzesAsync.when(
      data: (quizzes) {
        if (quizzes.isEmpty) {
          return _EmptyState(
            icon: Icons.quiz_outlined,
            message: context.l.noQuizzesYet,
          );
        }
        final latestSubs = latestSubsAsync.maybeWhen(
          data: (d) => d,
          orElse: () => const <String, dynamic>{},
        );
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (c, i) {
            final q = quizzes[i];
            final sub = latestSubs[q.id];
            final passed = sub != null && sub.score >= q.passScore;
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('${i + 1}')),
                title: Text(q.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (sub != null)
                      Text(context.l.quizLastScore(sub.score))
                    else
                      Text(context.l.quizNotStarted),
                    if (isTrainer) ...[
                      Builder(
                        builder: (_) {
                          final all =
                              trainerSubs[q.id] ?? const <QuizSubmissionLite>[];
                          if (all.isEmpty) {
                            return Text(
                              'لا توجد محاولات بعد',
                              style: TextStyle(
                                fontSize: 11,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            );
                          }
                          final latestAny = all.first; // ordered desc
                          return Text(
                            'أحدث درجة: ${latestAny.score} | إجمالي المحاولات: ${all.length}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          );
                        },
                      ),
                    ],
                    if (passed)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          '✅ ${context.l.quizPassedLabel} (${context.l.quizPassThreshold(q.passScore)})',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    // Attempts info row
                    // Lazy attempts count: rely on latest submissions map (first occurrence per quiz)
                    Builder(
                      builder: (_) {
                        final latest = latestSubs[q.id];
                        // We can't know attempts count without history query; show simple state.
                        // Optionally we could request history on demand.
                        return Text(
                          latest == null
                              ? (q.maxAttempts > 1
                                    ? context.l.quizAttemptsUsed(
                                        0,
                                        q.maxAttempts,
                                      )
                                    : context.l.quizAttemptSingle)
                              : (q.maxAttempts > 1
                                    ? context.l.quizAttemptsUsed(
                                        1,
                                        q.maxAttempts,
                                      )
                                    : context.l.quizAttemptSingle),
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        );
                      },
                    ),
                    if (sub != null)
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: TextButton.icon(
                          onPressed: () async {
                            final history = ref
                                .read(quizSubmissionHistoryProvider(q.id))
                                .maybeWhen(
                                  data: (d) => d,
                                  orElse: () => const <QuizSubmissionLite>[],
                                );
                            if (history.isEmpty) return;
                            final latest = history.first; // ordered desc
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuizReviewScreen(
                                  quiz: q,
                                  submission: latest,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.visibility, size: 16),
                          label: Text(context.l.quizReviewAction),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsetsDirectional.only(
                              start: 0,
                              end: 8,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                trailing: Builder(
                  builder: (ctx) {
                    // We only know if at least one attempt exists via latestSubs map
                    final firstAttempt = latestSubs[q.id];
                    final used = firstAttempt == null
                        ? 0
                        : 1; // lightweight approximation without full history stream
                    final remaining = q.maxAttempts - used;
                    final canAttempt = remaining > 0;
                    return FilledButton(
                      onPressed: !canAttempt
                          ? null
                          : () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => QuizAttemptScreen(
                                    quizId: q.id,
                                    courseId: q.courseId,
                                  ),
                                ),
                              );
                              // If new submission and passed and first time pass -> award points (simple placeholder)
                              if (result != null && context.mounted) {
                                final subMap = ref
                                    .read(
                                      latestQuizSubmissionsProvider(courseId),
                                    )
                                    .maybeWhen(
                                      data: (d) => d,
                                      orElse: () => {},
                                    );
                                final latest = subMap[q.id];
                                final nowPassed =
                                    latest != null &&
                                    latest.score >= q.passScore;
                                if (nowPassed) {
                                  final auth = ref
                                      .read(authStateProvider)
                                      .value;
                                  if (auth != null) {
                                    final created = await ref
                                        .read(pointsAwardServiceProvider)
                                        .award(
                                          userId: auth.uid,
                                          eventId:
                                              'quizpass_${q.id}_${auth.uid}',
                                          type: 'quiz_pass',
                                          points: q.rewardPoints,
                                          extra: {'quizId': q.id},
                                        );
                                    if (created && context.mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '+${q.rewardPoints} ${context.l.pointsLabel}',
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                }
                              }
                            },
                      child: Text(
                        !canAttempt
                            ? context.l.quizAttemptExceeded
                            : (sub == null
                                      ? context.l.quizStartAction
                                      : context.l.quizRetakeAction) +
                                  (q.maxAttempts > 1
                                      ? ' ($used/${q.maxAttempts})'
                                      : ''),
                      ),
                    );
                  },
                ),
                onLongPress: () async {
                  if (!isTrainer) return; // trainer only
                  final passCtrl = TextEditingController(
                    text: q.passScore.toString(),
                  );
                  final pointsCtrl = TextEditingController(
                    text: q.rewardPoints.toString(),
                  );
                  final attemptsCtrl = TextEditingController(
                    text: q.maxAttempts.toString(),
                  );
                  final res = await showDialog<bool>(
                    context: context,
                    builder: (dCtx) => AlertDialog(
                      title: Text(context.l.quizSettingsTitle),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: context.l.quizPassPercentLabel,
                            ),
                            controller: passCtrl,
                            keyboardType: TextInputType.number,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: context.l.quizRewardPointsLabel,
                            ),
                            controller: pointsCtrl,
                            keyboardType: TextInputType.number,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: context.l.quizMaxAttemptsLabel,
                            ),
                            controller: attemptsCtrl,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dCtx, false),
                          child: Text(context.l.cancelAction),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(dCtx, true),
                          child: Text(context.l.editSave),
                        ),
                      ],
                    ),
                  );
                  if (res == true) {
                    final pass = int.tryParse(passCtrl.text.trim());
                    final pts = int.tryParse(pointsCtrl.text.trim());
                    final mx = int.tryParse(attemptsCtrl.text.trim());
                    if (pass != null && pts != null && mx != null) {
                      await FirebaseFirestore.instance
                          .collection('quizzes')
                          .doc(q.id)
                          .update({
                            'passScore': pass,
                            'rewardPoints': pts,
                            'maxAttempts': mx,
                          });
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(context.l.quizUpdateSuccess)),
                        );
                      }
                    }
                  }
                },
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemCount: quizzes.length,
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => _ErrorState(error: e.toString()),
    );
  }
}

// Review Screen -------------------------------------------------------------
class QuizReviewScreen extends ConsumerWidget {
  final QuizLiteModel quiz;
  final QuizSubmissionLite submission;
  const QuizReviewScreen({
    super.key,
    required this.quiz,
    required this.submission,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionsAsync = ref.watch(quizQuestionsProvider(quiz.id));
    return Scaffold(
      appBar: AppBar(title: Text(quiz.title)),
      body: questionsAsync.when(
        data: (questions) {
          final answers = submission.answers ?? {};
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: questions.length,
            itemBuilder: (c, i) {
              final q = questions[i];
              final chosen = answers[q.id];
              final correct = q.correctIndex;
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${i + 1}. ${q.text}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      for (
                        var optIndex = 0;
                        optIndex < q.options.length;
                        optIndex++
                      )
                        Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: optIndex == correct
                                ? Colors.green.withValues(alpha: .12)
                                : (chosen == optIndex && chosen != correct)
                                ? Colors.red.withValues(alpha: .12)
                                : null,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: optIndex == correct
                                  ? Colors.green
                                  : (chosen == optIndex && chosen != correct)
                                  ? Colors.red
                                  : Colors.grey.withValues(alpha: .3),
                            ),
                          ),
                          child: ListTile(
                            dense: true,
                            leading: optIndex == correct
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : (chosen == optIndex
                                      ? const Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                        )
                                      : const SizedBox(width: 24)),
                            title: Text(q.options[optIndex]),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString())),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tasks Tab Placeholder
// ---------------------------------------------------------------------------
class _TasksTab extends ConsumerWidget {
  final String courseId;
  const _TasksTab({required this.courseId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusFilter = ref.watch(taskStatusFilterProvider);
    final tasksAsync = ref.watch(
      tasksForContextProvider((
        parentType: TaskParentType.course,
        parentId: courseId,
        statusFilter: statusFilter,
      )),
    );
    final filtered = ref.watch(
      filteredTasksProvider((
        parentType: TaskParentType.course,
        parentId: courseId,
        statusFilter: statusFilter,
      )),
    );
    return tasksAsync.when(
      data: (_) {
        final tasks = filtered;
        if (tasks.isEmpty) {
          return _EmptyState(
            icon: Icons.checklist_rtl,
            message:
                context.l.noTasksYetAlt, // reuse / alt key or introduce new
          );
        }
        return Stack(
          children: [
            ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (c, i) {
                final t = tasks[i];
                final done = t.status == AppTaskStatus.done;
                final inProgress = t.status == AppTaskStatus.inProgress;
                Color statusColor() {
                  if (done) return Colors.green;
                  if (inProgress) return Colors.orange;
                  return Theme.of(context).colorScheme.primary;
                }

                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  opacity: done ? .55 : 1,
                  child: Card(
                    child: InkWell(
                      onTap: () async {
                        await ref.read(cycleTaskStatusProvider(t.id).future);
                        // attempt award if moved to done
                        ref.read(awardTaskPointsIfNeededProvider(t.id));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 6,
                              height: 48,
                              decoration: BoxDecoration(
                                color: _priorityColor(t.priority, context),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        done
                                            ? Icons.check_circle
                                            : (inProgress
                                                  ? Icons.autorenew
                                                  : Icons
                                                        .radio_button_unchecked),
                                        color: statusColor(),
                                        size: 18,
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          t.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            decoration: done
                                                ? TextDecoration.lineThrough
                                                : null,
                                          ),
                                        ),
                                      ),
                                      if (t.pointsOnComplete > 0)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.amber.withValues(
                                              alpha: .15,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color: Colors.amber.withValues(
                                                alpha: .4,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.stars,
                                                size: 14,
                                                color: Colors.amber,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '+${t.pointsOnComplete}',
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                  if (t.details != null &&
                                      t.details!.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 4,
                                        right: 4,
                                      ),
                                      child: Text(
                                        t.details!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          // Updated: onSurfaceVariant -> outlineVariant for subtle secondary text
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.outlineVariant,
                                          height: 1.25,
                                        ),
                                      ),
                                    ),
                                  const SizedBox(height: 4),
                                  Wrap(
                                    spacing: 6,
                                    runSpacing: -4,
                                    children: [
                                      _statusChip(t.status, context),
                                      if (t.priority != 'low')
                                        _priorityChip(t.priority, context),
                                      if (t.dueDate != null)
                                        _dueChip(t.dueDate!, context),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: tasks.length,
            ),
            // Removed inner FAB (now handled by top-level FAB switcher)
            Positioned(
              left: 16,
              top: 0,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _TaskFiltersBar(),
                  const SizedBox(height: 4),
                  const _TaskDueFiltersBar(),
                ],
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => _ErrorState(error: e.toString()),
    );
  }
}

Color _priorityColor(String priority, BuildContext context) {
  switch (priority) {
    case 'high':
      return Colors.redAccent;
    case 'med':
      return Colors.orangeAccent;
    default:
      return Theme.of(context).colorScheme.primary.withValues(alpha: .6);
  }
}

Widget _statusChip(AppTaskStatus status, BuildContext context) {
  final l = context.l;
  final label = switch (status) {
    AppTaskStatus.pending => l.taskStatusNew,
    AppTaskStatus.inProgress => l.taskStatusInProgress,
    AppTaskStatus.done => l.taskStatusDone,
    AppTaskStatus.skipped => l.taskStatusSkipped,
  };
  Color bg;
  switch (status) {
    case AppTaskStatus.done:
      bg = Colors.green.withValues(alpha: .15);
      break;
    case AppTaskStatus.inProgress:
      bg = Colors.orange.withValues(alpha: .18);
      break;
    case AppTaskStatus.skipped:
      bg = Colors.grey.withValues(alpha: .2);
      break;
    default:
      bg = Theme.of(context).colorScheme.primary.withValues(alpha: .15);
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(label, style: const TextStyle(fontSize: 11)),
  );
}

Widget _priorityChip(String priority, BuildContext context) {
  final l = context.l;
  final label = switch (priority) {
    'high' => l.priorityHigh,
    'med' => l.priorityMed,
    _ => l.priorityLow,
  };
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: _priorityColor(priority, context).withValues(alpha: .15),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(label, style: const TextStyle(fontSize: 11)),
  );
}

Widget _dueChip(DateTime due, BuildContext context) {
  final l = context.l;
  final now = DateTime.now();
  final isPast = due.isBefore(now);
  final days = due.difference(DateTime(now.year, now.month, now.day)).inDays;
  final label = isPast
      ? l.duePast
      : (days == 0
            ? l.dueToday
            : days == 1
            ? l.dueTomorrow
            : l.dueInDays(days));
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: (isPast ? Colors.redAccent : Colors.blueAccent).withValues(
        alpha: .15,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 11, color: isPast ? Colors.red : null),
    ),
  );
}

class _TaskFiltersBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(taskStatusFilterProvider);
    void setFilter(String? v) =>
        ref.read(taskStatusFilterProvider.notifier).state = v;
    final l = context.l;
    final items = <({String? key, String label})>[
      (key: null, label: l.filterAll),
      (key: 'pending', label: l.taskStatusNew),
      (key: 'in_progress', label: l.taskStatusInProgress),
      (key: 'done', label: l.taskStatusDone),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Row(
        children: [
          for (final it in items)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 6),
              child: FilterChip(
                label: Text(it.label, style: const TextStyle(fontSize: 12)),
                selected: current == it.key,
                onSelected: (_) => setFilter(it.key),
              ),
            ),
        ],
      ),
    );
  }
}

class _TaskDueFiltersBar extends ConsumerWidget {
  const _TaskDueFiltersBar();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final current = ref.watch(taskDueFilterProvider);
    void setFilter(String? v) =>
        ref.read(taskDueFilterProvider.notifier).state = v;
    final items = <({String? key, String label})>[
      (key: null, label: l.filterAll),
      (key: 'overdue', label: l.taskDueFilterOverdue),
      (key: 'today', label: l.taskDueFilterToday),
      (key: 'week', label: l.taskDueFilterWeek),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(top: 0, bottom: 4),
      child: Row(
        children: [
          for (final it in items)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 6),
              child: FilterChip(
                label: Text(it.label, style: const TextStyle(fontSize: 11)),
                selected: current == it.key,
                onSelected: (_) => setFilter(it.key),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared Simple UI Helpers
// ---------------------------------------------------------------------------
class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  const _EmptyState({required this.icon, required this.message});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 12),
          Text(message, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String error;
  const _ErrorState({required this.error});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Builder(
          builder: (context) =>
              Text(context.l.errorGeneric(error), textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Due Date Picker (Inherited to retrieve selected date after dialog closes)
// ---------------------------------------------------------------------------
class _DueDatePickerField extends StatefulWidget {
  final ValueChanged<DateTime?>? onChanged;
  const _DueDatePickerField({this.onChanged});

  @override
  State<_DueDatePickerField> createState() => _DueDatePickerFieldState();
}

class _DueDatePickerFieldState extends State<_DueDatePickerField> {
  DateTime? selected;

  Future<void> _pick() async {
    final now = DateTime.now();
    final res = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
      initialDate: selected ?? now,
    );
    if (res != null) {
      setState(() => selected = res);
      widget.onChanged?.call(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Row(
      children: [
        Expanded(
          child: Text(
            selected == null
                ? l.selectDueDate
                : '${l.dueDatePickerLabel}: ${selected!.year}/${selected!.month}/${selected!.day}',
            style: const TextStyle(fontSize: 13),
          ),
        ),
        TextButton(
          onPressed: _pick,
          child: Text(selected == null ? l.pickAction : l.changeAction),
        ),
        if (selected != null)
          IconButton(
            tooltip: l.clearAction,
            onPressed: () {
              setState(() => selected = null);
              widget.onChanged?.call(null);
            },
            icon: const Icon(Icons.close, size: 18),
          ),
      ],
    );
  }
}

// Simple widget to localize priority dropdown entries
class _PriorityLabel extends StatelessWidget {
  final String priority;
  const _PriorityLabel(this.priority);
  @override
  Widget build(BuildContext context) {
    final l = context.l;
    switch (priority) {
      case 'high':
        return Text(l.priorityHigh);
      case 'med':
        return Text(l.priorityMed);
      default:
        return Text(l.priorityLow);
    }
  }
}
