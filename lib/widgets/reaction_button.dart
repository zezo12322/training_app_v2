import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/wall_post.dart';
import '../providers/wall_post_providers.dart';

class ReactionButton extends ConsumerStatefulWidget {
  final WallPost post;
  final String userId;

  const ReactionButton({
    super.key,
    required this.post,
    required this.userId,
  });

  @override
  ConsumerState<ReactionButton> createState() => _ReactionButtonState();
}

class _ReactionButtonState extends ConsumerState<ReactionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isReacting = false;

  static const _availableReactions = ['👍', '❤️', '🎉', '💪', '👏', '🔥'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String? get _userReaction {
    for (final emoji in _availableReactions) {
      if (widget.post.hasUserReacted(widget.userId, emoji)) {
        return emoji;
      }
    }
    return null;
  }

  Future<void> _toggleReaction(String emoji) async {
    if (_isReacting) return;

    setState(() => _isReacting = true);
    _animationController.forward().then((_) => _animationController.reverse());

    final result = await ref.read(togglePostReactionProvider)(
      postId: widget.post.id,
      userId: widget.userId,
      emoji: emoji,
      courseId: widget.post.courseId, // Added for gamification
      authorId: widget.post.authorId, // Added for gamification
    );

    if (mounted) {
      setState(() => _isReacting = false);

      result.when(
        success: (_) {
          // Success - UI will update via stream
        },
        failure: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('خطأ: ${error.message}'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
      );
    }
  }

  void _showReactionPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            
            // Title
            const Text(
              'اختر تفاعلك',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // Reactions grid
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: _availableReactions.map((emoji) {
                final isSelected = _userReaction == emoji;
                final count = widget.post.reactions[emoji] ?? 0;
                
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _toggleReaction(emoji);
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          emoji,
                          style: const TextStyle(fontSize: 32),
                        ),
                        if (count > 0) ...[
                          const SizedBox(height: 4),
                          Text(
                            '$count',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userReaction = _userReaction;
    final theme = Theme.of(context);

    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
      ),
      child: TextButton.icon(
        onPressed: _isReacting ? null : _showReactionPicker,
        icon: userReaction != null
            ? Text(
                userReaction,
                style: const TextStyle(fontSize: 20),
              )
            : const Icon(Icons.thumb_up_outlined, size: 20),
        label: Text(
          userReaction != null ? 'أعجبني' : 'إعجاب',
          style: TextStyle(
            color: userReaction != null
                ? theme.colorScheme.primary
                : Colors.grey.shade700,
            fontWeight:
                userReaction != null ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        style: TextButton.styleFrom(
          foregroundColor: userReaction != null
              ? theme.colorScheme.primary
              : Colors.grey.shade700,
        ),
      ),
    );
  }
}
