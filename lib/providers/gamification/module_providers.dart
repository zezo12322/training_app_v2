import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/gamification/learning_module.dart';
import '../../models/gamification/points_transaction.dart';
import '../../repositories/gamification/module_repository.dart';
import '../auth_provider.dart';
import 'gamification_providers.dart';

// ==================== Repository Provider ====================

final moduleRepositoryProvider = Provider<ModuleRepository>((ref) {
  return ModuleRepository(FirebaseFirestore.instance);
});

// ==================== Module Providers ====================

/// Stream all modules for a course (ordered by orderIndex)
final courseModulesProvider = StreamProvider.autoDispose
    .family<List<LearningModule>, String>((ref, courseId) {
  final repository = ref.watch(moduleRepositoryProvider);
  return repository.streamCourseModules(courseId);
});

/// Get a single module
final moduleProvider = FutureProvider.autoDispose
    .family<LearningModule?, String>((ref, moduleId) async {
  final repository = ref.read(moduleRepositoryProvider);
  return repository.getModule(moduleId);
});

// ==================== Progress Providers ====================

/// Get module progress for current user (real-time stream)
final moduleProgressProvider = StreamProvider.autoDispose
    .family<Map<String, dynamic>, String>((ref, moduleId) {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) {
    return Stream.value({
      'completedContents': <String>[],
      'progressPercentage': 0.0,
      'isCompleted': false,
    });
  }

  final repository = ref.watch(moduleRepositoryProvider);
  return repository.streamModuleProgress(
    userId: auth.uid,
    moduleId: moduleId,
  );
});

/// Get all module progress for a course (for overview)
final courseModulesProgressProvider = FutureProvider.autoDispose
    .family<Map<String, Map<String, dynamic>>, String>((ref, courseId) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return {};

  final modules = await ref.watch(courseModulesProvider(courseId).future);
  final repository = ref.read(moduleRepositoryProvider);

  final Map<String, Map<String, dynamic>> progressMap = {};

  for (final module in modules) {
    if (module.id != null) {
      final progress = await repository.getModuleProgress(
        userId: auth.uid,
        moduleId: module.id!,
      );
      progressMap[module.id!] = progress;
    }
  }

  return progressMap;
});

/// Check if a module is unlocked for current user
final isModuleUnlockedProvider = FutureProvider.autoDispose
    .family<bool, ({String courseId, int orderIndex})>((ref, params) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return false;

  // First module is always unlocked
  if (params.orderIndex == 1) return true;

  // Get all modules to find previous module
  final modules = await ref.watch(courseModulesProvider(params.courseId).future);
  final previousModule = modules
      .where((m) => m.orderIndex == params.orderIndex - 1)
      .firstOrNull;

  if (previousModule == null || previousModule.id == null) {
    return false; // Can't unlock if previous doesn't exist
  }

  // Check if previous module is completed
  final repository = ref.read(moduleRepositoryProvider);
  final previousProgress = await repository.getModuleProgress(
    userId: auth.uid,
    moduleId: previousModule.id!,
  );

  return previousProgress['isCompleted'] == true;
});

// ==================== Action Providers ====================

/// Create a new module (trainers only)
final createModuleProvider = FutureProvider.autoDispose
    .family<String, LearningModule>((ref, module) async {
  final repository = ref.read(moduleRepositoryProvider);
  return repository.createModule(module);
});

/// Update an existing module (trainers only)
final updateModuleProvider = FutureProvider.autoDispose
    .family<void, LearningModule>((ref, module) async {
  final repository = ref.read(moduleRepositoryProvider);
  return repository.updateModule(module);
});

/// Delete a module (trainers only)
final deleteModuleProvider = FutureProvider.autoDispose
    .family<void, String>((ref, moduleId) async {
  final repository = ref.read(moduleRepositoryProvider);
  return repository.deleteModule(moduleId);
});

/// Update content completion and check for module completion
final updateContentCompletionProvider = FutureProvider.autoDispose
    .family<void, ({
      String moduleId,
      String contentId,
      bool isCompleted,
    })>((ref, params) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return;

  final repository = ref.read(moduleRepositoryProvider);

  // Update progress
  await repository.updateModuleProgress(
    userId: auth.uid,
    moduleId: params.moduleId,
    contentId: params.contentId,
    isCompleted: params.isCompleted,
  );

  // Get module to check completion
  final module = await repository.getModule(params.moduleId);
  if (module == null) return;

  // Check if module is now complete
  final isComplete = await repository.checkModuleCompletion(
    userId: auth.uid,
    module: module,
  );

  if (isComplete) {
    // Check if already awarded points
    final progress = await repository.getModuleProgress(
      userId: auth.uid,
      moduleId: params.moduleId,
    );

    // Only award points if not already completed
    if (progress['isCompleted'] != true) {
      // Award points!
      final gamificationService = ref.read(gamificationServiceProvider);
      await gamificationService.awardPoints(
        userId: auth.uid,
        courseId: module.courseId,
        activityType: ActivityType.completingModule,
        activityName: 'إتمام وحدة: ${module.title}',
        metadata: {
          'moduleId': module.id,
          'contentCount': module.contents.length,
          'completionPoints': module.completionPoints,
        },
      );

      // Mark as completed
      await repository.completeModule(
        userId: auth.uid,
        moduleId: params.moduleId,
        courseId: module.courseId,
      );
    }
  }
});

/// Manually complete a module (for testing or admin)
final completeModuleProvider = FutureProvider.autoDispose
    .family<void, ({String moduleId, String courseId})>((ref, params) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return;

  final repository = ref.read(moduleRepositoryProvider);
  await repository.completeModule(
    userId: auth.uid,
    moduleId: params.moduleId,
    courseId: params.courseId,
  );
});

/// Get next unlocked module for current user
final nextUnlockedModuleProvider = FutureProvider.autoDispose
    .family<LearningModule?, String>((ref, courseId) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return null;

  final repository = ref.read(moduleRepositoryProvider);
  return repository.getNextUnlockedModule(
    userId: auth.uid,
    courseId: courseId,
  );
});

// ==================== Computed Providers ====================

/// Calculate total possible points from all modules in a course
final courseTotalModulePointsProvider = FutureProvider.autoDispose
    .family<int, String>((ref, courseId) async {
  final modules = await ref.watch(courseModulesProvider(courseId).future);
  return modules.fold<int>(
    0,
    (sum, module) => sum + module.completionPoints,
  );
});

/// Calculate earned points from completed modules
final courseEarnedModulePointsProvider = FutureProvider.autoDispose
    .family<int, String>((ref, courseId) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return 0;

  final modules = await ref.watch(courseModulesProvider(courseId).future);
  final repository = ref.read(moduleRepositoryProvider);

  int earnedPoints = 0;

  for (final module in modules) {
    if (module.id == null) continue;

    final progress = await repository.getModuleProgress(
      userId: auth.uid,
      moduleId: module.id!,
    );

    if (progress['isCompleted'] == true) {
      earnedPoints += module.completionPoints;
    }
  }

  return earnedPoints;
});

/// Calculate overall course module completion percentage
final courseModulesCompletionProvider = FutureProvider.autoDispose
    .family<double, String>((ref, courseId) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return 0.0;

  final modules = await ref.watch(courseModulesProvider(courseId).future);
  if (modules.isEmpty) return 0.0;

  final repository = ref.read(moduleRepositoryProvider);

  int completedCount = 0;

  for (final module in modules) {
    if (module.id == null) continue;

    final progress = await repository.getModuleProgress(
      userId: auth.uid,
      moduleId: module.id!,
    );

    if (progress['isCompleted'] == true) {
      completedCount++;
    }
  }

  return (completedCount / modules.length) * 100;
});
