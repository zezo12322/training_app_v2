import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/gamification/gamification_providers.dart';
import '../../services/gamification/level_system.dart';
import 'package:intl/intl.dart' as intl;

/// بطاقة عرض التقدم في الكورس
/// 
/// تعرض:
/// - المستوى الحالي مع emoji
/// - النقاط الكلية
/// - شريط التقدم للمستوى التالي
/// - Daily Streak (إذا مفعل)
class ProgressCard extends ConsumerWidget {
  final String courseId;
  final bool showStreak;
  final VoidCallback? onTap;

  const ProgressCard({
    super.key,
    required this.courseId,
    this.showStreak = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(currentUserProgressProvider(courseId));
    final settingsAsync = ref.watch(gamificationSettingsProvider(courseId));

    return settingsAsync.when(
      data: (settings) {
        if (settings == null || !settings.isEnabled) {
          return const SizedBox.shrink(); // النظام معطل
        }

        return progressAsync.when(
          data: (progress) {
            if (progress == null) {
              return _buildEmptyCard(context);
            }

            return _buildProgressCard(
              context,
              ref,
              progress,
              settings,
            );
          },
          loading: () => _buildLoadingCard(context),
          error: (error, stack) => _buildErrorCard(context, error),
        );
      },
      loading: () => _buildLoadingCard(context),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildProgressCard(
    BuildContext context,
    WidgetRef ref,
    progress,
    settings,
  ) {
    final theme = Theme.of(context);
    final levelSystem = ref.read(levelSystemProvider);
    final levelInfo = levelSystem.getAllLevelsInfo(settings.levelThresholds)
        .firstWhere((info) => info.level == progress.currentLevel);

    // حساب نسبة التقدم
    final progressPercentage = levelSystem.calculateLevelProgress(
      totalPoints: progress.totalPoints,
      currentLevel: progress.currentLevel,
      levelThresholds: settings.levelThresholds,
    );

    // التحقق من المستوى الأقصى
    final isMaxLevel = progress.currentLevel >= settings.levelThresholds.keys.reduce((a, b) => a > b ? a : b);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الصف الأول: Level Badge + النقاط
              Row(
                children: [
                  // Level Badge
                  _buildLevelBadge(levelInfo),
                  const SizedBox(width: 12),
                  // النقاط
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          levelInfo.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${intl.NumberFormat('#,###').format(progress.totalPoints)} نقطة',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Daily Streak (إذا مفعل)
                  if (showStreak && 
                      settings.activityPoints.enableDailyStreak && 
                      progress.dailyStreakCount > 0)
                    _buildStreakBadge(progress.dailyStreakCount),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // شريط التقدم
              if (!isMaxLevel) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المستوى التالي',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          '${progress.pointsToNextLevel} نقطة متبقية',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progressPercentage,
                        minHeight: 8,
                        backgroundColor: theme.colorScheme.surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getColorFromHex(levelInfo.color),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${(progressPercentage * 100).toStringAsFixed(0)}% مكتمل',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ] else ...[
                // رسالة المستوى الأقصى
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.amber.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.emoji_events, color: Colors.amber, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'تهانينا! وصلت للمستوى الأقصى 🎉',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.amber.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelBadge(LevelInfo levelInfo) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: _getColorFromHex(levelInfo.color).withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(
          color: _getColorFromHex(levelInfo.color),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            levelInfo.emoji,
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            '${levelInfo.level}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _getColorFromHex(levelInfo.color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakBadge(int streakCount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 4),
          Text(
            '$streakCount',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCard(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.rocket_launch, size: 48, color: Colors.grey),
            const SizedBox(height: 8),
            Text(
              'ابدأ رحلتك التعليمية!',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'أكمل الدروس والاختبارات لكسب النقاط',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingCard(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: 120,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 80,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(BuildContext context, Object error) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 8),
            Text(
              'حدث خطأ في تحميل التقدم',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorFromHex(String hexColor) {
    final hex = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }
}
