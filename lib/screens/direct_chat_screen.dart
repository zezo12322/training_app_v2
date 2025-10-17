import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../models/chat_message.dart';
import '../providers/direct_message_providers.dart';
import '../providers/user_providers.dart';
import '../services/hybrid_storage_service.dart';
import '../widgets/report_dialog.dart';
import '../core/l10n_ext.dart';
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

    // جلب بيانات المستخدم الحالي
    final currentUserAsync = ref.read(currentUserProvider);
    final currentUser = currentUserAsync.value;
    
      if (currentUser == null) {
      final l = context.l;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.directChatLoginError)),
      );
      return;
    }    final sendMessage = ref.read(sendDirectMessageProvider);
    await sendMessage(
      roomId: widget.roomId,
      senderId: widget.currentUserId,
      senderName: currentUser.name,
      senderRole: currentUser.role,
      recipientId: widget.otherUserId,
      content: content,
      institutionId: currentUser.institutionId ?? '',
      companyId: currentUser.companyId ?? '',
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
            Text(context.l.directChatTitle),
            typingUsersAsync.when(
              data: (typingUsers) {
                if (typingUsers.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Text(
                  context.l.directChatTyping,
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
            onSelected: (value) async {
              switch (value) {
                case 'block':
                  // تأكيد الحظر
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: Text(dialogContext.l.directChatBlockTitle),
                      content: Text(dialogContext.l.directChatBlockConfirm),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext, false),
                          child: Text(dialogContext.l.dialogCancelButton),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(dialogContext, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text(dialogContext.l.directChatBlock),
                        ),
                      ],
                    ),
                  );
                  
                  if (confirm != true) break;
                  if (!mounted) break;
                  
                  final blockUser = ref.read(blockUserProvider);
                  final success = await blockUser(
                    userId: widget.currentUserId,
                    blockedUserId: widget.otherUserId,
                  );
                  
                  if (!mounted) break;
                  
                  final l = context.l;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success ? l.directChatBlockSuccess : l.directChatBlockError),
                    ),
                  );
                  
                  if (success) {
                    Navigator.pop(context);
                  }
                  break;
                  
                case 'report':
                  // فتح نافذة الإبلاغ
                  if (!mounted) return;
                  await showDialog(
                    context: context,
                    builder: (context) => ReportDialog(
                      contentType: 'user',
                      contentId: widget.otherUserId,
                      reportedUserId: widget.otherUserId,
                    ),
                  );
                  break;
                  
                case 'delete':
                  // تأكيد الحذف
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(context.l.directChatDeleteTitle),
                      content: Text(context.l.directChatDeleteConfirm),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(context.l.dialogCancel),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text(context.l.dialogDeleteButton),
                        ),
                      ],
                    ),
                  );
                  
                  if (confirm != true) break;
                  if (!mounted) break;
                  
                  final deleteConversation = ref.read(deleteConversationProvider);
                  final success = await deleteConversation(
                    roomId: widget.roomId,
                    userId: widget.currentUserId,
                  );
                  
                  if (!mounted) break;
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success ? context.l.directChatDeleteSuccess : context.l.directChatDeleteError),
                    ),
                  );
                  
                  if (success) {
                    Navigator.pop(context);
                  }
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'block',
                child: Text(context.l.directChatBlock),
              ),
              PopupMenuItem(
                value: 'report',
                child: Text(context.l.directChatReport),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Text(context.l.directChatDeleteTitle),
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
                  return Center(
                    child: Text(context.l.directChatEmptyMessage),
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
                child: Text(context.l.directChatError(error.toString())),
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
                  color: Colors.grey.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  tooltip: context.l.directChatAttachFile,
                  onPressed: () async {
                    // إرفاق ملف
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'txt'],
                    );
                    
                    if (result != null && result.files.single.path != null) {
                      final file = File(result.files.single.path!);
                      final fileName = result.files.single.name;
                      
                      // رفع الملف
                      try {
                        final storage = HybridStorageService();
                        final uploadResult = await storage.uploadFile(file);
                        
                        if (!mounted) return;
                        
                        // إرسال رسالة مع الملف
                        final currentUserAsync = ref.read(currentUserProvider);
                        final currentUser = currentUserAsync.value;
                        if (currentUser != null) {
                          final sendMessage = ref.read(sendDirectMessageProvider);
                          await sendMessage(
                            roomId: widget.roomId,
                            senderId: widget.currentUserId,
                            senderName: currentUser.name,
                            senderRole: currentUser.role,
                            recipientId: widget.otherUserId,
                            content: fileName,
                            fileUrl: uploadResult.url,
                            institutionId: currentUser.institutionId ?? '',
                            companyId: currentUser.companyId ?? '',
                          );
                        }
                      } catch (e) {
                        if (!mounted) return;
                        final l = context.l;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l.directChatFileUploadError(e.toString()))),
                        );
                      }
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.image),
                  tooltip: context.l.directChatAttachImage,
                  onPressed: () async {
                    // إرفاق صورة
                    final picker = ImagePicker();
                    final image = await picker.pickImage(source: ImageSource.gallery);
                    
                    if (image != null) {
                      final file = File(image.path);
                      
                      // رفع الصورة
                      try {
                        final storage = HybridStorageService();
                        final uploadResult = await storage.uploadFile(file);
                        
                        if (!mounted) return;
                        
                        // إرسال رسالة مع الصورة
                        final currentUserAsync = ref.read(currentUserProvider);
                        final currentUser = currentUserAsync.value;
                        if (currentUser != null) {
                          final sendMessage = ref.read(sendDirectMessageProvider);
                          await sendMessage(
                            roomId: widget.roomId,
                            senderId: widget.currentUserId,
                            senderName: currentUser.name,
                            senderRole: currentUser.role,
                            recipientId: widget.otherUserId,
                            content: context.l.directChatImageLabel,
                            imageUrl: uploadResult.url,
                            institutionId: currentUser.institutionId ?? '',
                            companyId: currentUser.companyId ?? '',
                          );
                        }
                      } catch (e) {
                        if (!mounted) return;
                        final l = context.l;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l.directChatImageUploadError(e.toString()))),
                        );
                      }
                    }
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: context.l.directChatMessagePlaceholder,
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
                Text(
                  context.l.directChatMessageDeleted,
                  style: const TextStyle(
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
                    Builder(
                      builder: (ctx) {
                        final l = ctx.l;
                        return Text(
                          l.directChatMessageEdited,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        );
                      },
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
                title: Text(context.l.courseChatEditMessage),
                onTap: () {
                  Navigator.pop(context);
                  _editMessage(context, ref);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: Text(context.l.courseChatDeleteMessage),
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
    final l = context.l;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.directChatEditTitle),
        content: TextField(
          controller: controller,
          maxLines: null,
          decoration: InputDecoration(
            hintText: l.directChatEditPlaceholder,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.dialogCancelButton),
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
                  final l = context.l;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success ? l.directChatEditSuccess : l.directChatEditError,
                      ),
                    ),
                  );
                }
              }
            },
            child: Text(l.dialogSaveButton),
          ),
        ],
      ),
    );
  }

  void _deleteMessage(BuildContext context, WidgetRef ref) {
    final l = context.l;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.directChatDeleteMessageTitle),
        content: Text(l.directChatDeleteMessageConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.dialogCancelButton),
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
                final l = context.l;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success ? l.directChatDeleteMessageSuccess : l.directChatDeleteMessageError,
                    ),
                  ),
                );
              }
            },
            child: Text(l.dialogDeleteButton, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
