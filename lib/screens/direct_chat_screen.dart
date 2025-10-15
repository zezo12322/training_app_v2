import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/chat_message.dart';
import '../providers/direct_message_providers.dart';
import '../widgets/report_dialog.dart';
import 'dart:async';

/// شاشة المحادثة المباشرة
class DirectChatScreen extends ConsumerStatefulWidget {
  final String roomId;
  final String otherUserId;
  final String currentUserId;

  const DirectChatScreen({
    super.key,
    required this.roomId,
    required this.otherUserId,
    required this.currentUserId,
  });

  @override
  ConsumerState<DirectChatScreen> createState() => _DirectChatScreenState();
}

class _DirectChatScreenState extends ConsumerState<DirectChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _typingTimer;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTextChanged);
    _messageController.dispose();
    _scrollController.dispose();
    _typingTimer?.cancel();
    
    // إيقاف حالة الكتابة عند الخروج
    if (_isTyping) {
      final updateTyping = ref.read(updateTypingStatusProvider);
      updateTyping(
        roomId: widget.roomId,
        userId: widget.currentUserId,
        isTyping: false,
      );
    }
    
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _messageController.text.trim().isNotEmpty;
    
    if (hasText && !_isTyping) {
      _setTypingStatus(true);
    } else if (!hasText && _isTyping) {
      _setTypingStatus(false);
    }
    
    // إعادة تعيين المؤقت
    _typingTimer?.cancel();
    if (hasText) {
      _typingTimer = Timer(const Duration(seconds: 3), () {
        _setTypingStatus(false);
      });
    }
  }

  void _setTypingStatus(bool typing) {
    setState(() => _isTyping = typing);
    final updateTyping = ref.read(updateTypingStatusProvider);
    updateTyping(
      roomId: widget.roomId,
      userId: widget.currentUserId,
      isTyping: typing,
    );
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    _messageController.clear();
    _setTypingStatus(false);

    final sendMessage = ref.read(sendDirectMessageProvider);
    await sendMessage(
      roomId: widget.roomId,
      senderId: widget.currentUserId,
      senderName: 'أنا', // TODO: جلب من البروفايل
      senderRole: 'trainee', // TODO: جلب من البروفايل
      recipientId: widget.otherUserId,
      content: content,
      institutionId: 'inst_1', // TODO: جلب من السياق
      companyId: 'comp_1', // TODO: جلب من السياق
    );

    // التمرير للأسفل
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(
      roomMessagesProvider((roomId: widget.roomId, limit: 100)),
    );
    
    final typingUsersAsync = ref.watch(
      typingUsersProvider((
        roomId: widget.roomId,
        currentUserId: widget.currentUserId,
      )),
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('محادثة مباشرة'),
            typingUsersAsync.when(
              data: (typingUsers) {
                if (typingUsers.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Text(
                  'يكتب...',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[300],
                    fontStyle: FontStyle.italic,
                  ),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // TODO: إضافة خيارات (حظر، إبلاغ، حذف المحادثة)
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'block',
                child: Text('حظر'),
              ),
              const PopupMenuItem(
                value: 'report',
                child: Text('إبلاغ'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('حذف المحادثة'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // قائمة الرسائل
          Expanded(
            child: messagesAsync.when(
              data: (messages) {
                if (messages.isEmpty) {
                  return const Center(
                    child: Text('ابدأ المحادثة...'),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message.authorId == widget.currentUserId;

                    return _MessageBubble(
                      message: message,
                      isMe: isMe,
                      currentUserId: widget.currentUserId,
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('حدث خطأ: ${error.toString()}'),
              ),
            ),
          ),
          
          // شريط الإدخال
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    // TODO: إرفاق ملف
                  },
                  tooltip: 'إرفاق',
                ),
                IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    // TODO: إرفاق صورة
                  },
                  tooltip: 'صورة',
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالة...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  mini: true,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// فقاعة الرسالة
class _MessageBubble extends ConsumerWidget {
  final ChatMessage message;
  final bool isMe;
  final String currentUserId;

  const _MessageBubble({
    required this.message,
    required this.isMe,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canEdit = _canEditOrDelete();

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: canEdit ? () => _showOptions(context, ref) : null,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue[100] : Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // المحتوى
              if (message.isDeleted)
                const Text(
                  'تم حذف هذه الرسالة',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                )
              else ...[
                Text(message.content),
                if (message.imageUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        message.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) {
                          return Container(
                            height: 100,
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                  ),
              ],
              
              // المعلومات
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    timeago.format(message.createdAt, locale: 'ar'),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (message.isEdited) ...[
                    const SizedBox(width: 4),
                    Text(
                      'معدلة',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  if (isMe) ...[
                    const SizedBox(width: 4),
                    Icon(
                      message.readBy.length > 1
                          ? Icons.done_all
                          : Icons.done,
                      size: 14,
                      color: message.readBy.length > 1
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _canEditOrDelete() {
    if (!isMe) return false;
    if (message.isDeleted) return false;
    
    final diff = DateTime.now().difference(message.createdAt);
    return diff.inMinutes <= 15;
  }

  void _showOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_canEditOrDelete()) ...[
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('تعديل'),
                onTap: () {
                  Navigator.pop(context);
                  _editMessage(context, ref);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('حذف'),
                onTap: () {
                  Navigator.pop(context);
                  _deleteMessage(context, ref);
                },
              ),
            ],
            // زر الإبلاغ (للرسائل من مستخدمين آخرين)
            if (!isMe && !message.isDeleted)
              ReportButton(
                contentType: 'message',
                contentId: message.id,
                reportedUserId: message.authorId,
                courseId: null,
              ),
          ],
        ),
      ),
    );
  }

  void _editMessage(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: message.content);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل الرسالة'),
        content: TextField(
          controller: controller,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: 'الرسالة الجديدة',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () async {
              final newContent = controller.text.trim();
              if (newContent.isNotEmpty && newContent != message.content) {
                final editMessage = ref.read(editMessageProvider);
                final success = await editMessage(
                  messageId: message.id,
                  userId: currentUserId,
                  newContent: newContent,
                );
                
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success ? 'تم التعديل' : 'فشل التعديل',
                      ),
                    ),
                  );
                }
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  void _deleteMessage(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الرسالة'),
        content: const Text('هل أنت متأكد من حذف هذه الرسالة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () async {
              final deleteMessage = ref.read(deleteMessageProvider);
              final success = await deleteMessage(
                messageId: message.id,
                userId: currentUserId,
              );
              
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success ? 'تم الحذف' : 'فشل الحذف',
                    ),
                  ),
                );
              }
            },
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
