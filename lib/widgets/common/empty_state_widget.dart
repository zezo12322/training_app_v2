import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon;
  final String? actionText;
  final VoidCallback? onAction;
  final Widget? customAction;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.actionText,
    this.onAction,
    this.customAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              color: Colors.grey[400],
              size: 72,
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.defaultMargin),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            if (customAction != null) ...[
              const SizedBox(height: AppConstants.defaultPadding),
              customAction!,
            ] else if (onAction != null && actionText != null) ...[
              const SizedBox(height: AppConstants.defaultPadding),
              ElevatedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add),
                label: Text(actionText!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class NoCourseWidget extends StatelessWidget {
  final bool isTrainer;
  final VoidCallback? onCreateCourse;
  final VoidCallback? onJoinCourse;

  const NoCourseWidget({
    super.key,
    required this.isTrainer,
    this.onCreateCourse,
    this.onJoinCourse,
  });

  @override
  Widget build(BuildContext context) {
    if (isTrainer) {
      return EmptyStateWidget(
        title: 'لا توجد كورسات',
        message: 'قم بإنشاء أول كورس لك لبدء رحلة التدريب',
        icon: Icons.school_outlined,
        actionText: 'إنشاء كورس جديد',
        onAction: onCreateCourse,
      );
    } else {
      return EmptyStateWidget(
        title: 'لا توجد كورسات',
        message: 'قم بالانضمام إلى كورس باستخدام كود الكورس من المدرب',
        icon: Icons.bookmark_add_outlined,
        actionText: 'الانضمام إلى كورس',
        onAction: onJoinCourse,
      );
    }
  }
}

class NoPostsWidget extends StatelessWidget {
  final bool canAddPost;
  final VoidCallback? onAddPost;

  const NoPostsWidget({
    super.key,
    required this.canAddPost,
    this.onAddPost,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      title: 'لا توجد منشورات',
      message: canAddPost
          ? 'كن أول من يضيف منشوراً في هذا الكورس'
          : 'لم يتم إضافة أي منشورات في هذا الكورس بعد',
      icon: Icons.post_add_outlined,
      actionText: canAddPost ? 'إضافة منشور' : null,
      onAction: canAddPost ? onAddPost : null,
    );
  }
}

class NoCommentsWidget extends StatelessWidget {
  const NoCommentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateWidget(
      title: 'لا توجد تعليقات',
      message: 'كن أول من يعلق على هذا المنشور',
      icon: Icons.comment_outlined,
    );
  }
}
