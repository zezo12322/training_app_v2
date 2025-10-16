import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/gamification/learning_module.dart';
import '../../providers/gamification/module_providers.dart';

/// شاشة تفاصيل الوحدة التعليمية
class ModuleDetailScreen extends ConsumerWidget {
  final String courseId;
  final String moduleId;

  const ModuleDetailScreen({
    super.key,
    required this.courseId,
    required this.moduleId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final moduleAsync = ref.watch(courseModulesProvider(courseId));
    final progressAsync = ref.watch(moduleProgressProvider(moduleId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الوحدة'),
      ),
      body: moduleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('حدث خطأ: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(courseModulesProvider(courseId)),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
        data: (modules) {
          final module = modules.firstWhere(
            (m) => m.id == moduleId,
            orElse: () => throw Exception('Module not found'),
          );

          return progressAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text('خطأ في تحميل التقدم: $error'),
            ),
            data: (progress) {
              final isCompleted = progress['isCompleted'] == true;
              final completedContents = List<String>.from(progress['completedContents'] ?? []);
              final progressPercentage = (progress['progressPercentage'] ?? 0.0) as double;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Module Header
                    _ModuleHeader(
                      module: module,
                      progressPercentage: progressPercentage,
                      isCompleted: isCompleted,
                    ),

                    const SizedBox(height: 16),

                    // Module Description
                    if (module.description.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.description,
                                      color: theme.colorScheme.primary,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'الوصف',
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  module.description,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    // Module Contents
                    if (module.contents.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'محتويات الوحدة',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'أكمل جميع المحتويات للحصول على ${module.completionPoints} نقطة',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ...module.contents.asMap().entries.map(
                              (entry) {
                                final index = entry.key;
                                final content = entry.value;
                                final isContentCompleted = completedContents.contains(content.id);

                                return _ModuleContentTile(
                                  content: content,
                                  isCompleted: isContentCompleted,
                                  moduleId: moduleId,
                                  index: index + 1,
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                    // Completion Info
                    if (isCompleted)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Card(
                          color: Colors.green.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green.shade700,
                                  size: 32,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'تم إكمال الوحدة! 🎉',
                                        style: theme.textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green.shade700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'حصلت على ${module.completionPoints} نقطة',
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          color: Colors.green.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 32),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// رأس الوحدة مع التقدم
class _ModuleHeader extends StatelessWidget {
  final LearningModule module;
  final double progressPercentage;
  final bool isCompleted;

  const _ModuleHeader({
    required this.module,
    required this.progressPercentage,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primaryContainer,
            theme.colorScheme.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Module Title with Icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (isCompleted)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 14,
                              color: Colors.green.shade700,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'مكتملة',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'التقدم',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Text(
                    '${progressPercentage.toStringAsFixed(0)}%',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progressPercentage / 100,
                  minHeight: 8,
                  backgroundColor: Colors.white.withValues(alpha: 0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isCompleted ? Colors.green : theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Points Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.stars, color: Colors.amber.shade700, size: 20),
                const SizedBox(width: 8),
                Text(
                  '${module.completionPoints} نقطة عند الإكمال',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// بطاقة محتوى الوحدة
class _ModuleContentTile extends ConsumerWidget {
  final ModuleContent content;
  final bool isCompleted;
  final String moduleId;
  final int index;

  const _ModuleContentTile({
    required this.content,
    required this.isCompleted,
    required this.moduleId,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isCompleted ? 0 : 2,
      color: isCompleted ? Colors.green.shade50 : null,
      child: InkWell(
        onTap: () async {
          // Toggle completion
          try {
            await ref.read(updateContentCompletionProvider((
              moduleId: moduleId,
              contentId: content.id,
              isCompleted: !isCompleted,
            )).future);

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isCompleted
                        ? 'تم إلغاء وضع علامة على المحتوى كمكتمل'
                        : 'تم وضع علامة على المحتوى كمكتمل ✓',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('حدث خطأ: $e'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Index Circle
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isCompleted ? Colors.green : theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(Icons.check, color: Colors.white, size: 18)
                      : Text(
                          '$index',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(width: 16),

              // Content Icon
              Icon(
                _getContentIcon(content.type),
                color: isCompleted ? Colors.green.shade700 : theme.colorScheme.primary,
                size: 28,
              ),

              const SizedBox(width: 16),

              // Content Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            content.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: isCompleted ? TextDecoration.lineThrough : null,
                            ),
                          ),
                        ),
                        if (content.isRequired)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'مطلوب',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.orange.shade900,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getContentTypeLabel(content.type),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Checkbox
              Checkbox(
                value: isCompleted,
                onChanged: (value) async {
                  try {
                    await ref.read(updateContentCompletionProvider((
                      moduleId: moduleId,
                      contentId: content.id,
                      isCompleted: value ?? false,
                    )).future);
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('حدث خطأ: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getContentIcon(ModuleContentType type) {
    switch (type) {
      case ModuleContentType.lesson:
        return Icons.menu_book;
      case ModuleContentType.quiz:
        return Icons.quiz;
      case ModuleContentType.assignment:
        return Icons.assignment;
      case ModuleContentType.resource:
        return Icons.folder;
    }
  }

  String _getContentTypeLabel(ModuleContentType type) {
    switch (type) {
      case ModuleContentType.lesson:
        return 'درس';
      case ModuleContentType.quiz:
        return 'اختبار';
      case ModuleContentType.assignment:
        return 'واجب';
      case ModuleContentType.resource:
        return 'مصدر';
    }
  }
}
