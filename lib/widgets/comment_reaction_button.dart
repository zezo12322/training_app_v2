import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/wall_comment.dart';
import '../providers/auth_provider.dart';
import '../providers/wall_comment_providers.dart';

/// Comment reaction button with emoji picker
/// Similar to ReactionButton but for comments
class CommentReactionButton extends ConsumerWidget {
  final WallComment comment;
  final bool isCompact; // For nested replies

  const CommentReactionButton({
    super.key,
    required this.comment,
    this.isCompact = false,
  });

  static const _availableReactions = ['👍', '❤️', '🎉', '💪', '👏', '🔥'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authStateProvider).value;
    final userId = currentUser?.uid ?? '';

    // Find user's current reaction
    String? userReaction;
    if (userId.isNotEmpty) {
      for (final emoji in _availableReactions) {
        if (comment.reactionUsers[emoji]?.contains(userId) ?? false) {
          userReaction = emoji;
          break;
        }
      }
    }

    final hasReaction = userReaction != null;
    final totalReactions = comment.totalReactions;

    return InkWell(
      onTap: () => _showReactionPicker(context, ref, userId),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 8 : 10,
          vertical: isCompact ? 4 : 6,
        ),
        decoration: BoxDecoration(
          color: hasReaction
              ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
              : Colors.transparent,
          border: Border.all(
            color: hasReaction
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)
                : Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              hasReaction ? userReaction : '👍',
              style: TextStyle(fontSize: isCompact ? 14 : 16),
            ),
            if (totalReactions > 0) ...[
              SizedBox(width: isCompact ? 4 : 6),
              Text(
                totalReactions.toString(),
                style: TextStyle(
                  fontSize: isCompact ? 11 : 12,
                  fontWeight: FontWeight.w600,
                  color: hasReaction
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showReactionPicker(BuildContext context, WidgetRef ref, String userId) {
    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يجب تسجيل الدخول للتفاعل')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _ReactionPickerSheet(
        comment: comment,
        userId: userId,
        onReactionSelected: (emoji) async {
          Navigator.pop(context);
          await ref.read(toggleCommentReactionProvider)(
            postId: comment.postId,
            commentId: comment.id,
            userId: userId,
            emoji: emoji,
          );
        },
      ),
    );
  }
}

class _ReactionPickerSheet extends StatefulWidget {
  final WallComment comment;
  final String userId;
  final Function(String) onReactionSelected;

  const _ReactionPickerSheet({
    required this.comment,
    required this.userId,
    required this.onReactionSelected,
  });

  @override
  State<_ReactionPickerSheet> createState() => _ReactionPickerSheetState();
}

class _ReactionPickerSheetState extends State<_ReactionPickerSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String? _getUserReaction() {
    for (final emoji in CommentReactionButton._availableReactions) {
      if (widget.comment.reactionUsers[emoji]?.contains(widget.userId) ?? false) {
        return emoji;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final userReaction = _getUserReaction();
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'اختر تفاعلك',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Reaction grid
          ScaleTransition(
            scale: _scaleAnimation,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.5,
                ),
                itemCount: CommentReactionButton._availableReactions.length,
                itemBuilder: (context, index) {
                  final emoji = CommentReactionButton._availableReactions[index];
                  final count = widget.comment.reactions[emoji] ?? 0;
                  final isSelected = emoji == userReaction;

                  return Material(
                    color: isSelected
                        ? theme.colorScheme.primaryContainer
                        : theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () => widget.onReactionSelected(emoji),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              emoji,
                              style: const TextStyle(fontSize: 28),
                            ),
                            if (count > 0) ...[
                              const SizedBox(height: 4),
                              Text(
                                count.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
