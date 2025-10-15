import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/message_reaction.dart';
import '../services/message_reaction_service.dart';

/// مزود خدمة التفاعلات
final messageReactionServiceProvider = Provider<MessageReactionService>((ref) {
  return MessageReactionService();
});

/// Stream لملخص التفاعلات
final reactionSummaryProvider = StreamProvider.family.autoDispose<
    ReactionSummary,
    Map<String, String>
>((ref, params) {
  final service = ref.watch(messageReactionServiceProvider);
  return service.streamReactionSummary(
    messageId: params['messageId']!,
    currentUserId: params['currentUserId']!,
  );
});

/// صف التفاعلات تحت الرسالة
class ReactionRow extends ConsumerWidget {
  final String messageId;
  final String currentUserId;
  final String currentUserName;

  const ReactionRow({
    super.key,
    required this.messageId,
    required this.currentUserId,
    required this.currentUserName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(reactionSummaryProvider({
      'messageId': messageId,
      'currentUserId': currentUserId,
    }));

    return summaryAsync.when(
      data: (summary) {
        if (summary.totalCount == 0) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              ...summary.counts.entries.map((entry) {
                final emoji = entry.key;
                final count = entry.value;
                final hasReacted = summary.currentUserReactions[emoji] ?? false;
                final names = summary.userNames[emoji] ?? [];

                return InkWell(
                  onTap: () => _toggleReaction(ref, emoji),
                  onLongPress: () => _showReactors(context, emoji, names),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: hasReacted
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.grey.withOpacity(0.1),
                      border: Border.all(
                        color: hasReacted
                            ? Colors.blue
                            : Colors.grey.withOpacity(0.3),
                        width: hasReacted ? 1.5 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          emoji,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$count',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: hasReacted
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: hasReacted ? Colors.blue : Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              
              // زر إضافة تفاعل جديد
              InkWell(
                onTap: () => _showEmojiPicker(context, ref),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.add_reaction_outlined,
                    size: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  void _toggleReaction(WidgetRef ref, String emoji) {
    final service = ref.read(messageReactionServiceProvider);
    service.toggleReaction(
      messageId: messageId,
      emoji: emoji,
      userId: currentUserId,
      userName: currentUserName,
    );
  }

  void _showEmojiPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => EmojiPicker(
        onEmojiSelected: (emoji) {
          Navigator.pop(context);
          _toggleReaction(ref, emoji);
        },
      ),
    );
  }

  void _showReactors(BuildContext context, String emoji, List<String> names) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 8),
            Text('${names.length}'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: names.map((name) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(name),
              );
            }).toList(),
          ),
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

/// منتقي Emoji
class EmojiPicker extends StatelessWidget {
  final Function(String) onEmojiSelected;

  const EmojiPicker({
    super.key,
    required this.onEmojiSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'اختر تفاعلك',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: PopularEmojis.list.length,
            itemBuilder: (context, index) {
              final emoji = PopularEmojis.list[index];
              return InkWell(
                onTap: () => onEmojiSelected(emoji),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// زر إضافة تفاعل سريع (للاستخدام في قائمة الرسالة)
class AddReactionButton extends ConsumerWidget {
  final String messageId;
  final String currentUserId;
  final String currentUserName;

  const AddReactionButton({
    super.key,
    required this.messageId,
    required this.currentUserId,
    required this.currentUserName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.add_reaction_outlined),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => EmojiPicker(
            onEmojiSelected: (emoji) {
              Navigator.pop(context);
              final service = ref.read(messageReactionServiceProvider);
              service.toggleReaction(
                messageId: messageId,
                emoji: emoji,
                userId: currentUserId,
                userName: currentUserName,
              );
            },
          ),
        );
      },
      tooltip: 'إضافة تفاعل',
    );
  }
}
