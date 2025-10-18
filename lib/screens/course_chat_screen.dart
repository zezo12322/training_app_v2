import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_message.dart';
import '../models/chat_room.dart';
import '../providers/auth_provider.dart';
import '../providers/chat_providers.dart';
import '../widgets/chat/chat_input.dart';
import '../widgets/chat/message_list.dart';
import '../core/logging.dart';
import '../core/l10n_ext.dart';
import 'package:training_app/widgets/widgets.dart';
import 'package:training_app/core/design/tokens.dart';
import 'dashboard_helpers.dart';

/// Course chat screen for real-time messaging
class CourseChatScreen extends ConsumerStatefulWidget {
  final String courseId;
  final String courseName;

  const CourseChatScreen({
    super.key,
    required this.courseId,
    required this.courseName,
  });

  @override
  ConsumerState<CourseChatScreen> createState() => _CourseChatScreenState();
}

class _CourseChatScreenState extends ConsumerState<CourseChatScreen> {
  ChatRoom? _chatRoom;

  Widget _buildChatSkeleton() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(DesignTokens.spacingMd),
            itemCount: 8,
            itemBuilder: (_, i) {
              final isMe = i % 2 == 0;
              return Padding(
                padding: EdgeInsets.only(bottom: DesignTokens.spacingMd),
                child: Row(
                  mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isMe) ...[
                      AppLoadingSkeleton(
                        type: AppSkeletonType.circle,
                        width: 32,
                        height: 32,
                      ),
                      SizedBox(width: DesignTokens.spacingSm),
                    ],
                    Column(
                      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        if (!isMe)
                          Padding(
                            padding: EdgeInsets.only(bottom: DesignTokens.spacingXs),
                            child: AppLoadingSkeleton(width: 80, height: 12),
                          ),
                        Container(
                          constraints: BoxConstraints(maxWidth: 250),
                          child: AppLoadingSkeleton(
                            width: 150 + (i % 3) * 50.0,
                            height: 40 + (i % 2) * 20.0,
                            type: AppSkeletonType.roundedRectangle,
                          ),
                        ),
                      ],
                    ),
                    if (isMe) ...[
                      SizedBox(width: DesignTokens.spacingSm),
                      AppLoadingSkeleton(
                        type: AppSkeletonType.circle,
                        width: 32,
                        height: 32,
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(DesignTokens.spacingMd),
          decoration: BoxDecoration(
            color: DesignTokens.surface(context),
            border: Border(
              top: BorderSide(
                color: DesignTokens.borderColor(context),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: AppLoadingSkeleton(
                  height: 48,
                  type: AppSkeletonType.roundedRectangle,
                ),
              ),
              SizedBox(width: DesignTokens.spacingSm),
              AppLoadingSkeleton(
                width: 48,
                height: 48,
                type: AppSkeletonType.circle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserModelProvider);
    final roomAsync = ref.watch(
      courseChatRoomProvider(
        CourseChatRoomParams(
          courseId: widget.courseId,
          courseName: widget.courseName,
        ),
      ),
    );
    final l = context.l;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.courseChatTitle),
            Text(
              widget.courseName,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          // Room options menu
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'mute') {
                _toggleMute();
              } else if (value == 'info') {
                _showRoomInfo();
              }
            },
            itemBuilder: (context) {
              final userAsync = ref.watch(currentUserModelProvider);
              final user = userAsync.value;
              final isMuted = user != null && _chatRoom != null 
                  ? _chatRoom!.isMutedBy(user.id) 
                  : false;

              final l = context.l;
              return [
                PopupMenuItem(
                  value: 'mute',
                  child: Row(
                    children: [
                      Icon(isMuted ? Icons.notifications_active : Icons.notifications_off),
                      const SizedBox(width: 8),
                      Text(isMuted ? l.courseChatUnmute : l.courseChatMute),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'info',
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline),
                      const SizedBox(width: 8),
                      Text(l.courseChatInfo),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return Center(child: Text(l.courseChatLoginRequired));
          }

          return roomAsync.when(
            data: (room) {
              _chatRoom = room;
              return _buildChatContent(room, user.id);
            },
            loading: () => _buildChatSkeleton(),
            error: (error, stack) {
              logger.e('Error loading chat room', error: error, stackTrace: stack);
              return AppErrorState(
                message: DashboardErrorHandler.getUserFriendlyMessage(
                  error,
                  l.courseChatLoadError(error.toString()),
                ),
                onRetry: () => ref.invalidate(courseChatRoomProvider),
              );
            },
          );
        },
        loading: () => _buildChatSkeleton(),
        error: (error, stack) => AppErrorState(
          message: DashboardErrorHandler.getUserFriendlyMessage(
            error,
            l.courseChatLoadError(error.toString()),
          ),
          onRetry: () => ref.invalidate(currentUserModelProvider),
        ),
      ),
    );
  }

  Widget _buildChatContent(ChatRoom room, String userId) {
    // ✅ Null check: Ensure room has valid ID before loading messages
    if (room.id.isEmpty) {
      return Center(
        child: Text('Error: Invalid chat room'),
      );
    }

    final messagesAsync = ref.watch(chatMessagesProvider(room.id));

    return Column(
      children: [
        // Messages list
        Expanded(
          child: messagesAsync.when(
            data: (messages) {
              if (messages.isEmpty) {
                return AppEmptyState(
                  icon: Icons.chat_bubble_outline,
                  title: 'No messages yet',
                  actionLabel: 'Start the conversation',
                  onAction: () {
                    // Focus on input - implement if ChatInput supports focus
                  },
                );
              }
              return MessageList(
                messages: messages,
                currentUserId: userId,
                onMessageLongPress: (message) => _showMessageOptions(message, userId),
              );
            },
            loading: () => ListView.builder(
              padding: EdgeInsets.all(DesignTokens.spacingMd),
              itemCount: 6,
              itemBuilder: (_, i) {
                final isMe = i % 2 == 0;
                return Padding(
                  padding: EdgeInsets.only(bottom: DesignTokens.spacingMd),
                  child: Row(
                    mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isMe) ...[
                        AppLoadingSkeleton(
                          type: AppSkeletonType.circle,
                          width: 32,
                          height: 32,
                        ),
                        SizedBox(width: DesignTokens.spacingSm),
                      ],
                      AppLoadingSkeleton(
                        width: 150 + (i % 3) * 50.0,
                        height: 40,
                        type: AppSkeletonType.roundedRectangle,
                      ),
                    ],
                  ),
                );
              },
            ),
            error: (error, stack) {
              logger.e('Error loading messages', error: error, stackTrace: stack);
              return AppErrorState(
                message: DashboardErrorHandler.getUserFriendlyMessage(
                  error,
                  'Failed to load messages',
                ),
                onRetry: () => ref.invalidate(chatMessagesProvider(room.id)),
              );
            },
          ),
        ),

        // Input field
        ChatInput(
          onSendMessage: (message) => _sendMessage(message, userId),
          enabled: !room.isUserBlocked(userId),
        ),
      ],
    );
  }

  Future<void> _sendMessage(String content, String userId) async {
    if (_chatRoom == null) return;

    final userAsync = ref.read(currentUserModelProvider);
    final user = userAsync.value;
    if (user == null) return;

    // Support freelance trainers/trainees with default values
    final institutionId = user.institutionId ?? 'freelance';
    final companyId = user.companyId ?? 'independent';

    final dto = CreateChatMessageDto(
      chatRoomId: _chatRoom!.id,
      courseId: widget.courseId,
      institutionId: institutionId,
      companyId: companyId,
      authorId: user.id,
      authorName: user.name,
      authorRole: user.role,
      content: content,
    );

    try {
      final sendMessage = ref.read(sendMessageProvider);
      await sendMessage(dto);
      logger.i('Message sent successfully');
    } catch (e, stack) {
      logger.e('Error sending message', error: e, stackTrace: stack);
      if (mounted) {
        final l = context.l;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.courseChatMessageSendError(e.toString()))),
        );
      }
    }
  }

  void _showMessageOptions(ChatMessage message, String userId) {
    final isMyMessage = message.authorId == userId;
    final l = context.l;

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isMyMessage) ...[
              ListTile(
                leading: const Icon(Icons.edit),
                title: Text(l.courseChatEditMessage),
                onTap: () {
                  Navigator.pop(context);
                  _editMessage(message);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: Text(l.courseChatDeleteMessage),
                onTap: () {
                  Navigator.pop(context);
                  _deleteMessage(message);
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.flag),
              title: Text(l.courseChatFlagMessage),
              onTap: () {
                Navigator.pop(context);
                _flagMessage(message);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editMessage(ChatMessage message) async {
    final controller = TextEditingController(text: message.content);
    final l = context.l;

    final newContent = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.courseChatEditTitle),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: l.courseChatEditPlaceholder,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.dialogCancelButton),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text(l.dialogSaveButton),
          ),
        ],
      ),
    );

    if (newContent != null && newContent.trim().isNotEmpty && _chatRoom != null) {
      try {
        final editMessage = ref.read(editMessageProvider);
        await editMessage(
          chatRoomId: _chatRoom!.id,
          messageId: message.id,
          newContent: newContent.trim(),
        );
        if (mounted) {
          final l = context.l;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.courseChatEditSuccess)),
          );
        }
        } catch (e) {
        if (mounted) {
          final l = context.l;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.courseChatEditError(e.toString()))),
          );
        }
      }
    }
  }

  Future<void> _deleteMessage(ChatMessage message) async {
    if (_chatRoom == null) return;

    final l = context.l;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.courseChatDeleteTitle),
        content: Text(l.courseChatDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l.dialogCancelButton),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text(l.dialogDeleteButton),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final deleteMessage = ref.read(deleteMessageProvider);
        await deleteMessage(
          chatRoomId: _chatRoom!.id,
          messageId: message.id,
        );
        if (mounted) {
          final l = context.l;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.courseChatDeleteSuccess)),
          );
        }
        } catch (e) {
        if (mounted) {
          final l = context.l;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.courseChatDeleteError(e.toString()))),
          );
        }
      }
    }
  }

  Future<void> _flagMessage(ChatMessage message) async {
    if (_chatRoom == null) return;

    try {
      final flagMessage = ref.read(flagMessageProvider);
      await flagMessage(
        chatRoomId: _chatRoom!.id,
        messageId: message.id,
      );
      if (mounted) {
        final l = context.l;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.courseChatFlagSuccess)),
        );
      }
      } catch (e) {
      if (mounted) {
        final l = context.l;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.courseChatFlagError(e.toString()))),
        );
      }
    }
  }

  void _toggleMute() async {
    if (_chatRoom == null) return;

    final userAsync = ref.read(currentUserModelProvider);
    final user = userAsync.value;
    if (user == null) return;

    final isMuted = _chatRoom!.isMutedBy(user.id);
    
    try {
      final toggleMute = ref.read(toggleRoomMuteProvider);
      await toggleMute(
        roomId: _chatRoom!.id,
        userId: user.id,
        mute: !isMuted,
      );

      if (mounted) {
        final l = context.l;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isMuted ? l.courseChatUnmuteSuccess : l.courseChatMuteSuccess),
            duration: const Duration(seconds: 2),
          ),
        );
      }

      // Refresh room data
      ref.invalidate(courseChatRoomProvider);
    } catch (e) {
      logger.e('Error toggling mute', error: e);
      if (mounted) {
        final l = context.l;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.courseChatMuteError)),
        );
      }
    }
  }

  void _showRoomInfo() {
    if (_chatRoom == null) return;

    final l = context.l;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.courseChatInfoTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(l.courseChatInfoCourse((_chatRoom!.courseName ?? '').toString())),
            Text(l.courseChatInfoParticipants((_chatRoom!.participantIds.length).toString())),
            Text(l.courseChatInfoCreated((_chatRoom!.createdAt).toString())),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.courseChatInfoClose),
          ),
        ],
      ),
    );
  }
}
