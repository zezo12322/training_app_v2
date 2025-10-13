import 'package:flutter/material.dart';
import '../../models/chat_message.dart';
import 'message_bubble.dart';

/// Scrollable list of chat messages with auto-scroll to bottom
class MessageList extends StatefulWidget {
  final List<ChatMessage> messages;
  final String currentUserId;
  final bool isLoading;
  final Widget? emptyWidget;
  final void Function(ChatMessage)? onMessageLongPress;

  const MessageList({
    super.key,
    required this.messages,
    required this.currentUserId,
    this.isLoading = false,
    this.emptyWidget,
    this.onMessageLongPress,
  });

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final _scrollController = ScrollController();
  bool _isAtBottom = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    
    // Scroll to bottom on mount
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom(animate: false);
    });
  }

  @override
  void didUpdateWidget(MessageList oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Auto-scroll to bottom when new message arrives
    if (widget.messages.length > oldWidget.messages.length && _isAtBottom) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    
    final position = _scrollController.position;
    _isAtBottom = position.pixels >= position.maxScrollExtent - 50;
  }

  void _scrollToBottom({bool animate = true}) {
    if (!_scrollController.hasClients) return;

    if (animate) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.messages.isEmpty) {
      return widget.emptyWidget ??
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 64,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(height: 16),
                Text(
                  'لا توجد رسائل بعد',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'ابدأ المحادثة بإرسال رسالة',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ],
            ),
          );
    }

    return Stack(
      children: [
        ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: widget.messages.length,
          itemBuilder: (context, index) {
            final message = widget.messages[index];
            final isCurrentUser = message.authorId == widget.currentUserId;

            return MessageBubble(
              message: message,
              isCurrentUser: isCurrentUser,
              onLongPress: widget.onMessageLongPress != null
                  ? () => widget.onMessageLongPress!(message)
                  : null,
            );
          },
        ),

        // Scroll to bottom button (when not at bottom)
        if (!_isAtBottom)
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton.small(
              onPressed: _scrollToBottom,
              child: const Icon(Icons.arrow_downward),
            ),
          ),
      ],
    );
  }
}
