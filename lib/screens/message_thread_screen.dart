import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/chat_message.dart';
import '../services/message_threading_service.dart';
import '../providers/user_providers.dart';
import '../core/l10n_ext.dart';

/// مزود خدمة Threading
final messageThreadingServiceProvider = Provider<MessageThreadingService>((ref) {
  return MessageThreadingService();
});

/// Parameters for thread messages
class ThreadMessagesParams {
  final String chatRoomId;
  final String parentMessageId;

  ThreadMessagesParams({
    required this.chatRoomId,
    required this.parentMessageId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThreadMessagesParams &&
          runtimeType == other.runtimeType &&
          chatRoomId == other.chatRoomId &&
          parentMessageId == other.parentMessageId;

  @override
  int get hashCode => chatRoomId.hashCode ^ parentMessageId.hashCode;
}

/// Stream للردود
final threadMessagesProvider = StreamProvider.family.autoDispose<
    List<ChatMessage>,
    ThreadMessagesParams
>((ref, params) {
  final service = ref.watch(messageThreadingServiceProvider);
  return service.streamThreadMessages(params.chatRoomId, params.parentMessageId);
});

/// Parameters for parent message
class ParentMessageParams {
  final String chatRoomId;
  final String messageId;

  ParentMessageParams({
    required this.chatRoomId,
    required this.messageId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParentMessageParams &&
          runtimeType == other.runtimeType &&
          chatRoomId == other.chatRoomId &&
          messageId == other.messageId;

  @override
  int get hashCode => chatRoomId.hashCode ^ messageId.hashCode;
}

/// جلب الرسالة الأصلية
final parentMessageProvider = FutureProvider.family.autoDispose<
    ChatMessage?,
    ParentMessageParams
>((ref, params) async {
  final service = ref.watch(messageThreadingServiceProvider);
  return await service.getParentMessage(params.chatRoomId, params.messageId);
});

/// شاشة عرض Thread (جميع الردود)
class MessageThreadScreen extends ConsumerStatefulWidget {
  final String parentMessageId;
  final String currentUserId;
  final String chatRoomId;
  final String courseId;
  final String institutionId;
  final String companyId;

  const MessageThreadScreen({
    super.key,
    required this.parentMessageId,
    required this.currentUserId,
    required this.chatRoomId,
    required this.courseId,
    required this.institutionId,
    required this.companyId,
  });

  @override
  ConsumerState<MessageThreadScreen> createState() => _MessageThreadScreenState();
}

class _MessageThreadScreenState extends ConsumerState<MessageThreadScreen> {
  final TextEditingController _replyController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _replyController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendReply() async {
    final l = context.l;
    final content = _replyController.text.trim();
    if (content.isEmpty) return;

    final parentAsync = ref.read(parentMessageProvider(ParentMessageParams(
      chatRoomId: widget.chatRoomId,
      messageId: widget.parentMessageId,
    )));
    final parent = parentAsync.value;
    
    if (parent == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.messageThreadParentNotFound)),
      );
      return;
    }

    // Get current user data
    final currentUser = await ref.read(currentUserProvider.future);
    if (currentUser == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.messageThreadUserNotFound)),
        );
      }
    final service = ref.read(messageThreadingServiceProvider);
    
    final reply = await service.replyToMessage(
      chatRoomId: widget.chatRoomId,
      parentMessageId: widget.parentMessageId,
      courseId: widget.courseId,
      institutionId: widget.institutionId,
      companyId: widget.companyId,
      authorId: widget.currentUserId,
      authorName: currentUser.name,
      authorRole: currentUser.role,
      content: content,
    );authorName: currentUser.name,
      authorRole: currentUser.role,
      content: content,
    );

    if (reply != null) {
      _replyController.clear();
      
      // Scroll to bottom
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.messageThreadSendFailed)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final parentAsync = ref.watch(parentMessageProvider(ParentMessageParams(
      chatRoomId: widget.chatRoomId,
      messageId: widget.parentMessageId,
    )));
    final repliesAsync = ref.watch(threadMessagesProvider(ThreadMessagesParams(
      chatRoomId: widget.chatRoomId,
      parentMessageId: widget.parentMessageId,
    )));

    return Scaffold(
      appBar: AppBar(
        title: Text(l.messageThreadTitle),
      ),
      body: Column(
        children: [
          // عرض الرسالة الأصلية
          parentAsync.when(
            data: (parent) {
              if (parent == null) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(l.messageThreadParentNotFound),
                );
              }
              return _ParentMessageCard(message: parent);
            },
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Padding(
              padding: const EdgeInsets.all(16),
              child: Text(l.messageThreadError(error.toString())),
            ),
          ),

          const Divider(height: 1, thickness: 2),

          // قائمة الردود
          Expanded(
            child: repliesAsync.when(
              data: (replies) {
                if (replies.isEmpty) {
                  return Center(
                    child: Text(l.messageThreadNoReplies),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: replies.length,
                  itemBuilder: (context, index) {
                    final reply = replies[index];
                    final isMe = reply.authorId == widget.currentUserId;

                    return _ReplyBubble(
                      message: reply,
                      isMe: isMe,
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Text(l.messageThreadError(error.toString())),
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
                Expanded(
                  child: TextField(
                    controller: _replyController,
                    decoration: InputDecoration(
                      hintText: l.messageThreadReplyPlaceholder,
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
                    textInputAction: TextInputAction.newline,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendReply,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// بطاقة الرسالة الأصلية
class _ParentMessageCard extends StatelessWidget {
  final ChatMessage message;

  const _ParentMessageCard({required this.message});

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue.withValues(alpha: 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                child: Text(
                  message.authorName.isNotEmpty
                      ? message.authorName[0].toUpperCase()
                      : context.l.unknownUserInitial,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.authorName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      timeago.format(message.createdAt, locale: 'ar'),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            message.content,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.forum, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                '${message.threadCount} ${message.threadCount == 1 ? l.messageThreadReplySingular : l.messageThreadReplyPlural}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// فقاعة الرد
class _ReplyBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;

  const _ReplyBubble({
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Text(
                message.authorName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            if (!isMe) const SizedBox(height: 4),
            Text(message.content),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// مؤشر الردود (للاستخدام في قائمة الرسائل الرئيسية)
class ThreadIndicator extends ConsumerWidget {
  final ChatMessage message;
  final VoidCallback onTap;

  const ThreadIndicator({
    super.key,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!message.hasReplies) return const SizedBox.shrink();

    final recentRepliesStream = ref.watch(messageThreadingServiceProvider)
        .streamRecentReplies(message.chatRoomId, message.id);

    return StreamBuilder<List<ChatMessage>>(
      stream: recentRepliesStream,
      builder: (context, snapshot) {
        final recentReplies = snapshot.data ?? [];
        
        return InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(top: 8, right: 40),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.forum, size: 14, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text(
                      '${message.threadCount} ${message.threadCount == 1 ? l.messageThreadReplySingular : l.messageThreadReplyPlural}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (recentReplies.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    l.messageThreadLastReply(recentReplies.last.authorName),
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
