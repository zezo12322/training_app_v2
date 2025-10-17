import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/wall_post.dart';
import '../models/wall_comment.dart';
import '../providers/auth_provider.dart';
import '../providers/wall_comment_providers.dart';
import '../core/l10n_ext.dart';
import 'comment_reaction_button.dart';

class WallCommentsSheet extends ConsumerStatefulWidget {
  final WallPost post;

  const WallCommentsSheet({
    super.key,
    required this.post,
  });

  @override
  ConsumerState<WallCommentsSheet> createState() => _WallCommentsSheetState();
}

class _WallCommentsSheetState extends ConsumerState<WallCommentsSheet> {
  final _commentController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isSubmitting = false;
  
  // Reply state
  String? _replyingToCommentId;
  String? _replyingToUsername;

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _setReplyMode(String commentId, String username) {
    setState(() {
      _replyingToCommentId = commentId;
      _replyingToUsername = username;
      _focusNode.requestFocus();
    });
  }

  void _cancelReply() {
    setState(() {
      _replyingToCommentId = null;
      _replyingToUsername = null;
    });
  }

  Future<void> _addComment() async {
    final content = _commentController.text.trim();
    if (content.isEmpty || _isSubmitting) return;

    final currentUser = ref.read(authStateProvider).value;
    if (currentUser == null) return;

    setState(() => _isSubmitting = true);

    try {
      await ref.read(addWallCommentProvider)(
        postId: widget.post.id,
        courseId: widget.post.courseId,
        authorId: currentUser.uid,
        content: content,
        authorEmail: currentUser.email,
        authorName: currentUser.displayName,
        parentCommentId: _replyingToCommentId, // Add parent if replying
      );

      _commentController.clear();
      _focusNode.unfocus();
      _cancelReply(); // Clear reply mode

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_replyingToCommentId != null 
                ? context.l.wallCommentsReplyAdded 
                : context.l.wallCommentsCommentAdded),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.wallCommentsError(e.toString()))),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final commentsAsync = ref.watch(wallCommentsStreamProvider(widget.post.id));
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      l.wallCommentsTitle,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Comments list
              Expanded(
                child: commentsAsync.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stack) => Center(
                    child: Text(l.wallCommentsError(error.toString())),
                  ),
                  data: (comments) {
                    if (comments.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.comment_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              l.wallCommentsNoCommentsYet,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l.wallCommentsBeFirstToComment,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Separate parent comments and replies
                    final parentComments = comments
                        .where((c) => c.parentCommentId == null)
                        .toList();
                    
                    final repliesByParent = <String, List<WallComment>>{};
                    for (var comment in comments) {
                      if (comment.parentCommentId != null) {
                        repliesByParent[comment.parentCommentId!] ??= [];
                        repliesByParent[comment.parentCommentId!]!.add(comment);
                      }
                    }

                    return ListView.separated(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: parentComments.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        indent: 72,
                      ),
                      itemBuilder: (context, index) {
                        final comment = parentComments[index];
                        final replies = repliesByParent[comment.id] ?? [];
                        
                        return _CommentItem(
                          comment: comment,
                          replies: replies,
                          onReply: () => _setReplyMode(
                            comment.id,
                            comment.authorName ?? comment.authorEmail ?? l.commentUnknownUser,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              const Divider(height: 1),

              // Comment input
              Container(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 12,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 12,
                ),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Reply indicator
                    if (_replyingToUsername != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.reply,
                              size: 16,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                l.wallCommentsReplyingTo(_replyingToUsername!),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 18,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                              onPressed: _cancelReply,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                    
                    // Input row
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            focusNode: _focusNode,
                            maxLines: null,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _addComment(),
                            decoration: InputDecoration(
                              hintText: _replyingToUsername != null
                                  ? l.wallCommentsReplyPlaceholder
                                  : l.wallCommentsCommentPlaceholder,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: _isSubmitting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.send),
                          onPressed: _isSubmitting ? null : _addComment,
                          style: IconButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CommentItem extends ConsumerStatefulWidget {
  final WallComment comment;
  final List<WallComment> replies;
  final VoidCallback? onReply;

  const _CommentItem({
    required this.comment,
    this.replies = const [],
    this.onReply,
  });

  @override
  ConsumerState<_CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends ConsumerState<_CommentItem> {
  bool _showReplies = false;
  bool _isEditing = false;
  late final TextEditingController _editController;

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController(text: widget.comment.content);
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  Future<void> _saveEdit() async {
    final newContent = _editController.text.trim();
    if (newContent.isEmpty || newContent == widget.comment.content) {
      setState(() => _isEditing = false);
      return;
    }

    try {
      await ref.read(updateWallCommentProvider)(
        postId: widget.comment.postId,
        commentId: widget.comment.id,
        content: newContent,
      );

      if (!mounted) return;
      
      setState(() => _isEditing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l.wallCommentsCommentEdited)),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l.wallCommentsError(error.toString()))),
      );
    }
  }

  void _cancelEdit() {
    _editController.text = widget.comment.content;
    setState(() => _isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final currentUser = ref.watch(authStateProvider).value;
    final isAuthor = currentUser?.uid == widget.comment.authorId;
    final theme = Theme.of(context);
    final hasReplies = widget.replies.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Parent comment
        _buildCommentRow(
          widget.comment,
          isAuthor,
          theme,
          isReply: false,
        ),

        // Action buttons (Reply, Reactions, etc.)
        Padding(
          padding: const EdgeInsets.only(left: 48, top: 4, bottom: 8),
          child: Row(
            children: [
              // Reaction button
              CommentReactionButton(comment: widget.comment),
              const SizedBox(width: 8),
              
              // Reply button
              TextButton.icon(
                onPressed: widget.onReply,
                icon: const Icon(Icons.reply, size: 14),
                label: Text(l.commentReply, style: const TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              
              if (hasReplies) ...[
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () => setState(() => _showReplies = !_showReplies),
                  icon: Icon(
                    _showReplies ? Icons.expand_less : Icons.expand_more,
                    size: 16,
                  ),
                    label: Text(
                    _showReplies
                        ? l.wallCommentsHideReplies
                        : l.wallCommentsShowReplies(widget.replies.length),
                    style: const TextStyle(fontSize: 12),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ],
          ),
        ),

        // Nested replies
        if (_showReplies && hasReplies)
          ...widget.replies.map((reply) {
            final isReplyAuthor = currentUser?.uid == reply.authorId;
            return Padding(
              padding: const EdgeInsets.only(right: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCommentRow(
                    reply,
                    isReplyAuthor,
                    theme,
                    isReply: true,
                  ),
                  // Reaction button for reply
                  Padding(
                    padding: const EdgeInsets.only(left: 48, top: 4, bottom: 4),
                    child: CommentReactionButton(
                      comment: reply,
                      isCompact: true,
                    ),
                  ),
                ],
              ),
            );
          }),
      ],
    );
  }

  Widget _buildCommentRow(
    WallComment comment,
    bool isAuthor,
    ThemeData theme, {
    required bool isReply,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        right: isReply ? 0 : 16,
        left: 16,
        top: isReply ? 8 : 12,
        bottom: isReply ? 8 : 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            radius: isReply ? 14 : 18,
            backgroundColor: theme.colorScheme.secondaryContainer,
            child: Text(
              () {
                final name = comment.authorName ?? comment.authorEmail ?? 'U';
                return name.isEmpty ? 'U' : name.substring(0, 1).toUpperCase();
              }(),
              style: TextStyle(
                fontSize: isReply ? 12 : 14,
                color: theme.colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Comment content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Author name
                Row(
                  children: [
                    Builder(
                      builder: (ctx) => Text(
                        comment.authorName ?? comment.authorEmail ?? ctx.l.commentUnknownUser,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isReply ? 13 : 14,
                        ),
                      ),
                    ),
                    if (comment.isEdited) ...[
                      const SizedBox(width: 6),
                      Builder(
                        builder: (ctx) => Text(
                          ctx.l.messageBubbleEdited,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),

                // Content (editable or text)
                if (_isEditing && !isReply) ...[
                  Builder(
                    builder: (ctx) {
                      final l = ctx.l;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _editController,
                            maxLines: null,
                            maxLength: 2000,
                            decoration: InputDecoration(
                              hintText: l.commentPlaceholder,
                              border: const OutlineInputBorder(),
                              isDense: true,
                            ),
                            style: TextStyle(fontSize: isReply ? 13 : 14, height: 1.4),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              TextButton(
                                onPressed: _cancelEdit,
                                child: Text(l.dialogCancelButton),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: _saveEdit,
                                child: Text(l.dialogSaveButton),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ] else
                  Text(
                    comment.content,
                    style: TextStyle(
                      fontSize: isReply ? 13 : 14,
                      height: 1.4,
                    ),
                  ),
                const SizedBox(height: 6),

                // Timestamp only (reactions moved to button)
                if (comment.createdAt != null && !_isEditing)
                  Text(
                    timeago.format(comment.createdAt!, locale: 'ar'),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
              ],
            ),
          ),

          // Edit/Delete menu (for author, don't show when editing)
          if (isAuthor && !_isEditing)
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                size: 18,
                color: Colors.grey.shade600,
              ),
              onSelected: (value) async {
                if (value == 'edit' && !isReply) {
                  setState(() => _isEditing = true);
                } else if (value == 'delete') {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) {
                      final l = ctx.l;
                      return AlertDialog(
                        title: Text(l.commentDeleteTitle),
                        content: Text(l.commentDeleteConfirm),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: Text(l.dialogCancelButton),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: Text(
                              l.dialogDeleteButton,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirm == true) {
                    await ref.read(deleteWallCommentProvider)(
                      postId: comment.postId,
                      commentId: comment.id,
                      parentCommentId: comment.parentCommentId,
                    );
                  }
                }
              },
              padding: EdgeInsets.zero,
              itemBuilder: (context) => [
                if (!isReply)
                  PopupMenuItem(
                    value: 'edit',
                    child: Builder(
                      builder: (ctx) => Row(
                        children: [
                          const Icon(Icons.edit_outlined, size: 18),
                          const SizedBox(width: 8),
                          Text(ctx.l.commentEdit),
                        ],
                      ),
                    ),
                  ),
                PopupMenuItem(
                  value: 'delete',
                  child: Builder(
                    builder: (ctx) => Row(
                      children: [
                        const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                        const SizedBox(width: 8),
                        Text(ctx.l.dialogDeleteButton, style: const TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
