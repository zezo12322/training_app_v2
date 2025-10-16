import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'task_models.dart';
import '../../providers/auth_provider.dart';
import '../../providers/gamification/gamification_providers.dart';

// Firestore collection root suggestion: tasks (flat) with composite indexes OR nested.
// For flexibility we'll assume a top-level `tasks` collection storing all app tasks.

final tasksForContextProvider =
    StreamProvider.family<
      List<AppTask>,
      ({TaskParentType parentType, String parentId, String? statusFilter})
    >((ref, params) {
      Query<Map<String, dynamic>> q = FirebaseFirestore.instance
          .collection('tasks')
          .where('parentType', isEqualTo: params.parentType.key)
          .where('parentId', isEqualTo: params.parentId)
          // Show newest tasks first for better trainer feedback
          .orderBy('createdAt', descending: true);
      if (params.statusFilter != null) {
        q = q.where('status', isEqualTo: params.statusFilter);
      }
      return q.snapshots().map(
        (s) => s.docs.map((d) => AppTask.fromDoc(d)).toList(),
      );
    });

// Due date filter: null (all), 'overdue', 'today', 'week'
final taskDueFilterProvider = StateProvider<String?>((ref) => null);

/// Combine base list + due filter in memory (avoids extra composite indexes now)
final filteredTasksProvider =
    Provider.family<
      List<AppTask>,
      ({TaskParentType parentType, String parentId, String? statusFilter})
    >((ref, params) {
      final base = ref
          .watch(tasksForContextProvider(params))
          .maybeWhen(data: (d) => d, orElse: () => <AppTask>[]);
      final dueFilter = ref.watch(taskDueFilterProvider);
      if (dueFilter == null) return base;
      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      final weekEnd = todayStart.add(const Duration(days: 7));
      return base.where((t) {
        final d = t.dueDate;
        if (d == null) {
          return false; // when filtering by due, hide tasks w/out due
        }
        switch (dueFilter) {
          case 'overdue':
            return d.isBefore(todayStart);
          case 'today':
            return d.year == todayStart.year &&
                d.month == todayStart.month &&
                d.day == todayStart.day;
          case 'week':
            return !d.isBefore(todayStart) && d.isBefore(weekEnd);
        }
        return true;
      }).toList();
    });

final taskProgressProvider =
    StreamProvider.family<
      double,
      ({TaskParentType parentType, String parentId})
    >((ref, params) {
      final base = FirebaseFirestore.instance
          .collection('tasks')
          .where('parentType', isEqualTo: params.parentType.key)
          .where('parentId', isEqualTo: params.parentId);
      // We listen to the full set for now (can optimize with aggregate queries later)
      return base.snapshots().map((s) {
        final tasks = s.docs.map((d) => AppTask.fromDoc(d)).toList();
        if (tasks.isEmpty) return 0.0;
        final done = tasks.where((t) => t.status == AppTaskStatus.done).length;
        return done / tasks.length;
      });
    });

class CreateTaskInput {
  final TaskParentType parentType;
  final String parentId;
  final String title;
  final String? details;
  final String createdBy;
  final String? assignedTo;
  final DateTime? dueDate;
  final int pointsOnComplete;
  final String priority;
  CreateTaskInput({
    required this.parentType,
    required this.parentId,
    required this.title,
    this.details,
    required this.createdBy,
    this.assignedTo,
    this.dueDate,
    this.pointsOnComplete = 0,
    this.priority = 'low',
  });
}

final createTaskProvider = FutureProvider.autoDispose
    .family<void, CreateTaskInput>((ref, input) async {
      final now = DateTime.now();
      final doc = FirebaseFirestore.instance.collection('tasks').doc();
      await doc.set({
        'parentType': input.parentType.key,
        'parentId': input.parentId,
        'title': input.title,
        'details': input.details,
        'status': AppTaskStatus.pending.key,
        'createdBy': input.createdBy,
        'assignedTo': input.assignedTo,
        'createdAt': now,
        'updatedAt': now,
        'dueDate': input.dueDate,
        'pointsOnComplete': input.pointsOnComplete,
        'priority': input.priority,
      });
    });

/// Update a task status (simple direct write)
final updateTaskStatusProvider = FutureProvider.autoDispose
    .family<void, ({String taskId, AppTaskStatus newStatus})>((
      ref,
      params,
    ) async {
      final doc = FirebaseFirestore.instance
          .collection('tasks')
          .doc(params.taskId);
      await doc.update({
        'status': params.newStatus.key,
        'updatedAt': DateTime.now(),
      });
    });

/// Cycle task status: pending -> in_progress -> done -> pending ...
final cycleTaskStatusProvider = FutureProvider.autoDispose.family<void, String>(
  (ref, taskId) async {
    final doc = FirebaseFirestore.instance.collection('tasks').doc(taskId);
    await FirebaseFirestore.instance.runTransaction((trx) async {
      final snap = await trx.get(doc);
      if (!snap.exists) return;
      final current = AppTaskStatusX.from(snap.data()?['status'] as String?);
      final next = switch (current) {
        AppTaskStatus.pending => AppTaskStatus.inProgress,
        AppTaskStatus.inProgress => AppTaskStatus.done,
        AppTaskStatus.done => AppTaskStatus.pending,
        AppTaskStatus.skipped => AppTaskStatus.pending,
      };
      trx.update(doc, {'status': next.key, 'updatedAt': DateTime.now()});
    });
  },
);

/// When task reaches done first time: award points (placeholder gamification)
final awardTaskPointsIfNeededProvider = FutureProvider.autoDispose
    .family<void, String>((ref, taskId) async {
      final auth = ref.read(authStateProvider).value;
      if (auth == null) return;
      final snap = await FirebaseFirestore.instance
          .collection('tasks')
          .doc(taskId)
          .get();
      if (!snap.exists) return;
      final data = snap.data()!;
      if (data['status'] != 'done') return;
      final points = (data['pointsOnComplete'] as int?) ?? 0;
      if (points <= 0) return;
      
      // Get course ID from task parent
      final parentType = data['parentType'] as String?;
      final parentId = data['parentId'] as String?;
      
      // Award points only if task belongs to a course
      if (parentType == 'course' && parentId != null) {
        final gamificationService = ref.read(gamificationServiceProvider);
        await gamificationService.awardPoints(
          userId: auth.uid,
          courseId: parentId,
          activityType: 'task_completed',
          activityName: data['title'] ?? 'Task',
          metadata: {'taskId': taskId, 'points': points},
        );
      }
    });

final deleteTaskProvider = FutureProvider.autoDispose.family<void, String>((
  ref,
  taskId,
) async {
  await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
});

// State for UI filters (e.g., selected status)
final taskStatusFilterProvider = StateProvider<String?>((ref) => null);
