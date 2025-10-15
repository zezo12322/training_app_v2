import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_message.dart';
import '../models/chat_room.dart';
import '../providers/auth_provider.dart';
import '../providers/chat_providers.dart';
import '../widgets/chat/chat_input.dart';
import '../widgets/chat/message_list.dart';
import '../widgets/network_status.dart';
import '../core/logging.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('محادثة الكورس'),
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
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'mute',
                child: Row(
                  children: [
                    Icon(Icons.notifications_off),
                    SizedBox(width: 8),
                    Text('كتم الإشعارات'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'info',
                child: Row(
                  children: [
                    Icon(Icons.info_outline),
                    SizedBox(width: 8),
                    Text('معلومات المحادثة'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('يجب تسجيل الدخول'));
          }

          return roomAsync.when(
            data: (room) {
              _chatRoom = room;
              return _buildChatContent(room, user.id);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) {
              logger.e('Error loading chat room', error: error, stackTrace: stack);
              return FirebaseErrorHandler.buildErrorWidget(
                context,
                error,
                onRetry: () => ref.invalidate(courseChatRoomProvider),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('خطأ: $error')),
      ),
    );
  }

  Widget _buildChatContent(ChatRoom room, String userId) {
    final messagesAsync = ref.watch(chatMessagesProvider(room.id));

    return Column(
      children: [
        // Messages list
        Expanded(
          child: messagesAsync.when(
            data: (messages) => MessageList(
              messages: messages,
              currentUserId: userId,
              onMessageLongPress: (message) => _showMessageOptions(message, userId),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) {
              logger.e('Error loading messages', error: error, stackTrace: stack);
              return FirebaseErrorHandler.buildErrorWidget(
                context,
                error,
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

    final dto = CreateChatMessageDto(
      chatRoomId: _chatRoom!.id,
      courseId: widget.courseId,
      institutionId: user.institutionId!,
      companyId: user.companyId!,
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل إرسال الرسالة: $e')),
        );
      }
    }
  }

  void _showMessageOptions(ChatMessage message, String userId) {
    final isMyMessage = message.authorId == userId;

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isMyMessage) ...[
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('تعديل'),
                onTap: () {
                  Navigator.pop(context);
                  _editMessage(message);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('حذف'),
                onTap: () {
                  Navigator.pop(context);
                  _deleteMessage(message);
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('إبلاغ'),
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

    final newContent = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل الرسالة'),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'الرسالة الجديدة',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('حفظ'),
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم تعديل الرسالة')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل التعديل: $e')),
          );
        }
      }
    }
  }

  Future<void> _deleteMessage(ChatMessage message) async {
    if (_chatRoom == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الرسالة'),
        content: const Text('هل أنت متأكد من حذف هذه الرسالة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('حذف'),
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم حذف الرسالة')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل الحذف: $e')),
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم الإبلاغ عن الرسالة')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل الإبلاغ: $e')),
        );
      }
    }
  }

  void _toggleMute() {
    // TODO: Implement mute functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ميزة الكتم قيد التطوير')),
    );
  }

  void _showRoomInfo() {
    if (_chatRoom == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('معلومات المحادثة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الكورس: ${_chatRoom!.courseName}'),
            Text('عدد المشاركين: ${_chatRoom!.participantIds.length}'),
            Text('تاريخ الإنشاء: ${_chatRoom!.createdAt}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }
}
