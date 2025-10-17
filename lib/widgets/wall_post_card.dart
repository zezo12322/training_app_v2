import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/wall_post.dart';
import '../providers/auth_provider.dart';
import '../providers/wall_post_providers.dart';
import 'reaction_button.dart';
import 'wall_comments_sheet.dart';
import 'edit_post_dialog.dart';
import 'image_grid_widget.dart';
import 'poll_widget.dart';
import '../core/l10n_ext.dart';

class WallPostCard extends ConsumerStatefulWidget {
  final WallPost post;
  final bool isTrainer;
  final VoidCallback? onDeleted;

  const WallPostCard({
    super.key,
    required this.post,
    this.isTrainer = false,
    this.onDeleted,
  });

  @override
  ConsumerState<WallPostCard> createState() => _WallPostCardState();
}

class _WallPostCardState extends ConsumerState<WallPostCard>
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
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _togglePin() async {
    final l = context.l;
    final result = await ref.read(togglePinProvider)(
      widget.post.id,
      !widget.post.isPinned,
    );
    result.when(
      success: (_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.post.isPinned ? l.postUnpinned : l.postPinned,
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      failure: (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${l.errorGeneric}: ${error.message}')),
          );
        }
      },
    );
  }

  Future<void> _deletePost() async {
    final l = context.l;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final l = ctx.l;
        return AlertDialog(
          title: Text(l.postDeleteTitle),
          content: Text(l.postDeleteConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l.dialogCancelButton),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l.postDeleteButton, style: const TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      final result = await ref.read(deletePostProvider)(widget.post.id);
      result.when(
        success: (_) {
          widget.onDeleted?.call();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l.postDeleted)),
            );
          }
        },
        failure: (error) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${l.errorGeneric}: ${error.message}')),
            );
          }
        },
      );
    }
  }

  Future<void> _editPost() async {
    final updated = await showDialog<bool>(
      context: context,
      builder: (context) => EditPostDialog(post: widget.post),
    );
    
    if (updated == true && mounted) {
      // Post will update via stream, no need to do anything
    }
  }

  void _showCommentsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => WallCommentsSheet(post: widget.post),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authStateProvider).value;
    final isAuthor = currentUser?.uid == widget.post.authorId;
    final theme = Theme.of(context);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        elevation: widget.post.isPinned ? 4 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: widget.post.isPinned
              ? BorderSide(color: theme.colorScheme.primary, width: 2)
              : BorderSide.none,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Author info + Menu
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(
                      _getInitial(widget.post.authorName, widget.post.authorEmail),
                      style: TextStyle(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Author name & timestamp
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Builder(
                                builder: (ctx) {
                                  final l = ctx.l;
                                  return Text(
                                    widget.post.authorName ??
                                        widget.post.authorEmail ??
                                        l.postAuthorFallback,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  );
                                },
                              ),
                            ),
                            if (widget.post.isPinned) ...[
                              const SizedBox(width: 6),
                              Icon(
                                Icons.push_pin,
                                size: 16,
                                color: theme.colorScheme.primary,
                              ),
                            ],
                            if (widget.post.isEdited) ...[
                              const SizedBox(width: 6),
                              Builder(
                                builder: (ctx) {
                                  final l = ctx.l;
                                  return Text(
                                    '(${l.postEditedLabel})',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                        if (widget.post.createdAt != null)
                          Text(
                            timeago.format(
                              widget.post.createdAt!,
                              locale: 'ar',
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                      ],
                    ),
                  ),
                  
                  // Menu button (for author or trainer)
                  if (isAuthor || widget.isTrainer)
                    Builder(
                      builder: (ctx) {
                        final l = ctx.l;
                        return PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert, color: Colors.grey.shade600),
                          onSelected: (value) {
                            switch (value) {
                              case 'edit':
                                _editPost();
                                break;
                              case 'pin':
                                _togglePin();
                                break;
                              case 'delete':
                                _deletePost();
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                            if (isAuthor)
                              PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    const Icon(Icons.edit_outlined, size: 20),
                                    const SizedBox(width: 12),
                                    Text(l.postEditButton),
                                  ],
                                ),
                              ),
                            if (widget.isTrainer)
                              PopupMenuItem(
                                value: 'pin',
                                child: Row(
                                  children: [
                                    Icon(
                                      widget.post.isPinned
                                          ? Icons.push_pin_outlined
                                          : Icons.push_pin,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(widget.post.isPinned
                                        ? l.postUnpinButton
                                        : l.postPinButton),
                                  ],
                                ),
                              ),
                            if (isAuthor || widget.isTrainer)
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    const Icon(Icons.delete_outline,
                                        size: 20, color: Colors.red),
                                    const SizedBox(width: 12),
                                    Text(l.postDeleteButton,
                                        style: const TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Text(
                widget.post.content,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ),

            // Multiple images (new)
            if (widget.post.imageUrls.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ImageGridWidget(imageUrls: widget.post.imageUrls),
              ),

            // Single image (legacy support)
            if (widget.post.imageUrl != null && widget.post.imageUrls.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.post.imageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.broken_image, size: 48),
                      );
                    },
                  ),
                ),
              ),

            // Poll widget
            if (widget.post.poll != null && widget.post.poll!['id'] != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PollWidget(
                  pollId: widget.post.poll!['id'] as String,
                  userId: ref.watch(authStateProvider).value?.uid ?? '',
                ),
              ),

            const Divider(height: 1),

            // Reactions & Comments bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  // Reactions
                  if (widget.post.totalReactions > 0) ...[
                    _buildReactionsSummary(theme),
                    const SizedBox(width: 8),
                  ],
                  const Spacer(),
                  
                  // Comment count
                  if (widget.post.commentCount > 0)
                    Builder(
                      builder: (ctx) {
                        final l = ctx.l;
                        return TextButton.icon(
                          onPressed: _showCommentsSheet,
                          icon: const Icon(Icons.comment_outlined, size: 16),
                          label: Text(
                            l.postCommentCount(widget.post.commentCount),
                            style: const TextStyle(fontSize: 13),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Row(
                children: [
                  // Reaction button
                  Expanded(
                    child: ReactionButton(
                      post: widget.post,
                      userId: currentUser?.uid ?? '',
                    ),
                  ),
                  
                  // Comment button
                  Expanded(
                    child: Builder(
                      builder: (ctx) {
                        final l = ctx.l;
                        return TextButton.icon(
                          onPressed: _showCommentsSheet,
                          icon: const Icon(Icons.comment_outlined, size: 20),
                          label: Text(l.postCommentButton),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey.shade700,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReactionsSummary(ThemeData theme) {
    final reactions = widget.post.reactions;
    final topReactions = reactions.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...topReactions.take(3).map((entry) => Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text(
                entry.key,
                style: const TextStyle(fontSize: 16),
              ),
            )),
        const SizedBox(width: 4),
        Text(
          '${widget.post.totalReactions}',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Get initial letter from author name or email
  String _getInitial(String? name, String? email) {
    final text = name ?? email ?? 'U';
    if (text.isEmpty) return 'U';
    return text.substring(0, 1).toUpperCase();
  }
}
