import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/recommendation.dart';
import '../providers/recommendation_providers.dart';

/// ويدجت بطاقة التوصية
class RecommendationCard extends ConsumerWidget {
  final Recommendation recommendation;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  const RecommendationCard({
    super.key,
    required this.recommendation,
    this.onTap,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _getPriorityColor(recommendation.priority).withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () async {
          // تحديث حالة المشاهدة والقبول
          if (!recommendation.isViewed) {
            final updateStatus = ref.read(updateRecommendationStatusProvider);
            await updateStatus(
              recommendationId: recommendation.id,
              isViewed: true,
              isAccepted: true,
            );
          }
          onTap?.call();
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  // أيقونة النوع
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getTypeColor(recommendation.type).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getTypeIcon(recommendation.type),
                      color: _getTypeColor(recommendation.type),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // العنوان
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recommendation.contentTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getReasonText(recommendation.reason),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // زر الرفض
                  if (onDismiss != null)
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () async {
                        final updateStatus = ref.read(updateRecommendationStatusProvider);
                        await updateStatus(
                          recommendationId: recommendation.id,
                          isDismissed: true,
                        );
                        onDismiss?.call();
                      },
                      tooltip: 'رفض التوصية',
                    ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // الوصف
              if (recommendation.description.isNotEmpty)
                Text(
                  recommendation.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              
              const SizedBox(height: 12),
              
              // المعلومات الإضافية
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  // الصعوبة
                  _buildInfoChip(
                    icon: Icons.speed,
                    label: recommendation.difficulty,
                    color: Colors.blue,
                  ),
                  
                  // الوقت المتوقع
                  if (recommendation.estimatedMinutes != null)
                    _buildInfoChip(
                      icon: Icons.access_time,
                      label: '${recommendation.estimatedMinutes} دقيقة',
                      color: Colors.orange,
                    ),
                  
                  // الأولوية
                  if (recommendation.priority > 70)
                    _buildInfoChip(
                      icon: Icons.priority_high,
                      label: 'أولوية عالية',
                      color: Colors.red,
                    ),
                  
                  // درجة الثقة
                  _buildInfoChip(
                    icon: Icons.verified,
                    label: '${(recommendation.confidence * 100).toInt()}% ثقة',
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    if (priority >= 80) return Colors.red;
    if (priority >= 60) return Colors.orange;
    return Colors.blue;
  }

  Color _getTypeColor(RecommendationType type) {
    switch (type) {
      case RecommendationType.lesson:
        return Colors.blue;
      case RecommendationType.quiz:
        return Colors.purple;
      case RecommendationType.assignment:
        return Colors.orange;
      case RecommendationType.module:
        return Colors.green;
      case RecommendationType.review:
        return Colors.red;
      case RecommendationType.challenge:
        return Colors.amber;
    }
  }

  IconData _getTypeIcon(RecommendationType type) {
    switch (type) {
      case RecommendationType.lesson:
        return Icons.book;
      case RecommendationType.quiz:
        return Icons.quiz;
      case RecommendationType.assignment:
        return Icons.assignment;
      case RecommendationType.module:
        return Icons.school;
      case RecommendationType.review:
        return Icons.refresh;
      case RecommendationType.challenge:
        return Icons.emoji_events;
    }
  }

  String _getReasonText(RecommendationReason reason) {
    switch (reason) {
      case RecommendationReason.weakPerformance:
        return 'لتحسين الأداء';
      case RecommendationReason.interests:
        return 'بناءً على اهتماماتك';
      case RecommendationReason.nextStep:
        return 'الخطوة التالية';
      case RecommendationReason.skillGap:
        return 'لسد فجوة مهارية';
      case RecommendationReason.popularWithPeers:
        return 'شائع بين زملائك';
      case RecommendationReason.pathCompletion:
        return 'لإكمال المسار';
      case RecommendationReason.strengthenSkill:
        return 'لتعزيز مهاراتك';
    }
  }
}

/// قائمة التوصيات
class RecommendationsList extends ConsumerWidget {
  final String userId;
  final String courseId;

  const RecommendationsList({
    super.key,
    required this.userId,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendationsAsync = ref.watch(
      activeRecommendationsProvider((userId: userId, courseId: courseId)),
    );

    return recommendationsAsync.when(
      data: (recommendations) {
        if (recommendations.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد توصيات حالياً',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'سنقوم بإنشاء توصيات مخصصة لك قريباً',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: recommendations.length,
          itemBuilder: (context, index) {
            final rec = recommendations[index];
            return RecommendationCard(
              recommendation: rec,
              onTap: () {
                // يمكن التنقل للمحتوى هنا
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('فتح: ${rec.contentTitle}'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              onDismiss: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم رفض التوصية'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            );
          },
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'حدث خطأ في تحميل التوصيات',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
