import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/gamification/achievement.dart';
import '../../providers/auth_provider.dart';
import '../../providers/gamification/achievement_providers.dart';
import '../../services/gamification/achievement_service.dart';

/// شاشة الإنجازات
///
/// تعرض:
/// - Grid view لجميع الإنجازات
/// - حالة القفل/الفتح لكل إنجاز
/// - التقدم نحو الإنجازات غير المفتوحة
/// - فلترة حسب الفئة
/// - تفاصيل كل إنجاز
class AchievementsScreen extends ConsumerStatefulWidget {
  final String courseId;

  const AchievementsScreen({
    super.key,
    required this.courseId,
  });

  @override
  ConsumerState<AchievementsScreen> createState() =>
      _AchievementsScreenState();
}

class _AchievementsScreenState extends ConsumerState<AchievementsScreen> {
  AchievementCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final userId = authState.value?.uid;

    if (userId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('الإنجازات')),
        body: const Center(child: Text('يجب تسجيل الدخول')),
      );
    }

    final achievementsAsync = ref.watch(
      achievementsWithDetailsProvider((
        userId: userId,
        courseId: widget.courseId,
      )),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإنجازات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showCategoryFilter,
          ),
        ],
      ),
      body: achievementsAsync.when(
        data: (achievements) {
          if (achievements.isEmpty) {
            return _buildEmptyState();
          }

          // Filter by category
          final filtered = _selectedCategory == null
              ? achievements
              : achievements
                  .where((a) => a.achievement.category == _selectedCategory)
                  .toList();

          // Group by category
          final grouped = <AchievementCategory, List<AchievementWithDetails>>{};
          for (final achievement in filtered) {
            grouped
                .putIfAbsent(achievement.achievement.category, () => [])
                .add(achievement);
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(achievementsWithDetailsProvider);
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildStats(achievements, userId),
                const SizedBox(height: 24),
                if (_selectedCategory != null) ...[
                  _buildCategoryChip(_selectedCategory!),
                  const SizedBox(height: 16),
                ],
                ...grouped.entries.map((entry) => _buildCategorySection(
                      entry.key,
                      entry.value,
                    )),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorState(error),
      ),
    );
  }

  Widget _buildStats(List<AchievementWithDetails> achievements, String userId) {
    final unlockedCount = achievements.where((a) => a.isUnlocked).length;
    final totalCount = achievements.length;
    final percentage = (unlockedCount / totalCount * 100).toStringAsFixed(0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  '🏆',
                  '$unlockedCount',
                  'مفتوحة',
                ),
                _buildStatItem(
                  '📊',
                  '$percentage%',
                  'النسبة',
                ),
                _buildStatItem(
                  '🎯',
                  '${totalCount - unlockedCount}',
                  'متبقية',
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: unlockedCount / totalCount,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String emoji, String value, String label) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 32)),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection(
    AchievementCategory category,
    List<AchievementWithDetails> achievements,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Text(category.icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 8),
              Text(
                category.displayName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: achievements.length,
          itemBuilder: (context, index) {
            return _buildAchievementCard(achievements[index]);
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildAchievementCard(AchievementWithDetails details) {
    final achievement = details.achievement;
    final isUnlocked = details.isUnlocked;
    final isSecret = achievement.isSecret && !isUnlocked;

    return GestureDetector(
      onTap: () => _showAchievementDetails(details),
      child: Card(
        elevation: isUnlocked ? 4 : 1,
        color: isUnlocked ? Colors.amber.shade50 : Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon/Badge
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isUnlocked ? Colors.amber : Colors.grey.shade300,
                ),
                child: Center(
                  child: Text(
                    isSecret ? '❓' : achievement.category.icon,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Title
              Text(
                isSecret ? '????' : achievement.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isUnlocked ? Colors.black87 : Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 4),

              // Description or Lock Status
              if (isSecret)
                Text(
                  'إنجاز سري 🔒',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                )
              else if (isUnlocked)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle, size: 14, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(
                      'مفتوح ✓',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              else
                Text(
                  'مقفل 🔒',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),

              const Spacer(),

              // Points
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? Colors.amber.shade100
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 14,
                      color: isUnlocked ? Colors.amber : Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${achievement.pointsReward}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isUnlocked ? Colors.amber.shade900 : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(AchievementCategory category) {
    return Chip(
      avatar: Text(category.icon),
      label: Text(category.displayName),
      deleteIcon: const Icon(Icons.close, size: 18),
      onDeleted: () {
        setState(() {
          _selectedCategory = null;
        });
      },
    );
  }

  void _showCategoryFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'تصفية حسب الفئة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Text('🌟', style: TextStyle(fontSize: 24)),
              title: const Text('الكل'),
              onTap: () {
                setState(() {
                  _selectedCategory = null;
                });
                Navigator.pop(context);
              },
            ),
            ...AchievementCategory.values.map((category) {
              return ListTile(
                leading: Text(category.icon, style: const TextStyle(fontSize: 24)),
                title: Text(category.displayName),
                onTap: () {
                  setState(() {
                    _selectedCategory = category;
                  });
                  Navigator.pop(context);
                },
              );
            }),
          ],
        );
      },
    );
  }

  void _showAchievementDetails(AchievementWithDetails details) {
    final achievement = details.achievement;
    final isUnlocked = details.isUnlocked;
    final isSecret = achievement.isSecret && !isUnlocked;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Text(
                isSecret ? '???' : achievement.category.icon,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isSecret ? 'إنجاز سري' : achievement.title,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isSecret) ...[
                Text(
                  achievement.description,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 8),
                    Text(
                      '${achievement.pointsReward} نقطة',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      isUnlocked ? Icons.check_circle : Icons.lock,
                      color: isUnlocked ? Colors.green : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isUnlocked ? 'مفتوح ✓' : 'مقفل 🔒',
                      style: TextStyle(
                        fontSize: 14,
                        color: isUnlocked ? Colors.green : Colors.grey,
                      ),
                    ),
                  ],
                ),
                if (isUnlocked && details.userAchievement != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    'تم الفتح: ${_formatDate(details.userAchievement!.unlockedAt)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ] else ...[
                const Text(
                  'هذا إنجاز سري! 🤫',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  'ستكتشفه عندما تفتحه',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month}/${date.day}';
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🏆', style: TextStyle(fontSize: 64)),
          SizedBox(height: 16),
          Text(
            'لا توجد إنجازات بعد',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text('حدث خطأ في تحميل الإنجازات'),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              ref.invalidate(achievementsWithDetailsProvider);
            },
            icon: const Icon(Icons.refresh),
            label: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }
}
