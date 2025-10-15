import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/gamification/learning_module.dart';
import '../../providers/gamification/module_providers.dart';
import 'module_detail_screen.dart';

/// شاشة عرض كل الوحدات التعليمية في الكورس
class ModulesScreen extends ConsumerWidget {
  final String courseId;

  const ModulesScreen({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modulesAsync = ref.watch(courseModulesProvider(courseId));
    final progressMapAsync = ref.watch(courseModulesProgressProvider(courseId));

    return Scaffold(
      body: modulesAsync.when(
        data: (modules) {
          if (modules.isEmpty) {
            return _buildEmptyState(context);
          }

          return progressMapAsync.when(
            data: (progressMap) {
              return _buildModulesList(
                context,
                ref,
                modules,
                progressMap,
              );
            },
            loading: () => _buildLoadingState(),
            error: (_, __) => _buildModulesList(
              context,
              ref,
              modules,
              {},
            ),
          );
        },
        loading: () => _buildLoadingState(),
        error: (error, stack) => _buildErrorState(context, error),
      ),
    );
  }

  Widget _buildModulesList(
    BuildContext context,
    WidgetRef ref,
    List<LearningModule> modules,
    Map<String, Map<String, dynamic>> progressMap,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: modules.length,
      itemBuilder: (context, index) {
        final module = modules[index];
        final progress = progressMap[module.id] ?? {};

        return FutureBuilder<bool>(
          future: ref.read(isModuleUnlockedProvider((
            courseId: courseId,
            orderIndex: module.orderIndex,
          )).future),
          builder: (context, snapshot) {
            final isUnlocked = snapshot.data ?? (module.orderIndex == 1);

            return _ModuleCard(
              module: module,
              progress: progress,
              isUnlocked: isUnlocked,
              onTap: isUnlocked
                  ? () => _navigateToModuleDetail(context, module)
                  : null,
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد وحدات تعليمية بعد',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'سيتم إضافة الوحدات قريباً',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorState(BuildContext context, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'حدث خطأ في تحميل الوحدات',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _navigateToModuleDetail(BuildContext context, LearningModule module) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ModuleDetailScreen(
          moduleId: module.id!,
          courseId: courseId,
        ),
      ),
    );
  }
}

/// بطاقة عرض وحدة واحدة
class _ModuleCard extends StatelessWidget {
  final LearningModule module;
  final Map<String, dynamic> progress;
  final bool isUnlocked;
  final VoidCallback? onTap;

  const _ModuleCard({
    required this.module,
    required this.progress,
    required this.isUnlocked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progressPercentage = progress['progressPercentage'] ?? 0.0;
    final isCompleted = progress['isCompleted'] == true;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isUnlocked ? 2 : 0,
      color: isUnlocked
          ? null
          : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  // Status Icon
                  _buildStatusIcon(context, isCompleted, isUnlocked),
                  const SizedBox(width: 12),

                  // Title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${module.orderIndex}. ${module.title}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isUnlocked ? null : Colors.grey,
                              ),
                        ),
                        if (!isUnlocked) ...[
                          const SizedBox(height: 4),
                          Text(
                            'مقفلة - أكمل الوحدة السابقة',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Points Badge
                  if (isUnlocked)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? Colors.green.withValues(alpha: 0.2)
                            : Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isCompleted ? Icons.check_circle : Icons.emoji_events,
                            size: 16,
                            color: isCompleted ? Colors.green : null,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${isCompleted ? module.completionPoints : "0/${module.completionPoints}"}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isCompleted ? Colors.green : null,
                                ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              if (isUnlocked) ...[
                const SizedBox(height: 12),

                // Description
                if (module.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      module.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[700],
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                // Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: progressPercentage / 100,
                              minHeight: 8,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isCompleted ? Colors.green : Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${progressPercentage.toInt()}%',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isCompleted ? Colors.green : null,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Content Count
                    Row(
                      children: [
                        Icon(
                          Icons.menu_book,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${module.contents.length} محتوى',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.check_circle_outline,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${(progress['completedContents'] as List?)?.length ?? 0}/${module.contents.where((c) => c.isRequired).length} مكتمل',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(BuildContext context, bool isCompleted, bool isUnlocked) {
    if (!isUnlocked) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.lock,
          size: 24,
          color: Colors.grey[600],
        ),
      );
    }

    if (isCompleted) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check_circle,
          size: 24,
          color: Colors.green,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.play_circle_outline,
        size: 24,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
