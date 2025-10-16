import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/chat_message.dart';

/// Message bubble widget for displaying chat messages
class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isCurrentUser;
  final VoidCallback? onLongPress;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: isCurrentUser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: isCurrentUser
                ? theme.colorScheme.primary
                : theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16).copyWith(
              bottomRight: isCurrentUser
                  ? const Radius.circular(4)
                  : const Radius.circular(16),
              bottomLeft: !isCurrentUser
                  ? const Radius.circular(4)
                  : const Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Author name (if not current user)
              if (!isCurrentUser) ...[
                Text(
                  message.authorName,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
              ],

              // Message content
              Text(
                message.displayContent,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isCurrentUser
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),

              // Image attachment (if exists)
              if (message.imageUrl != null) ...[
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    message.imageUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image);
                    },
                  ),
                ),
              ],

              // Timestamp and edited indicator
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatTime(message.createdAt),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isCurrentUser
                          ? theme.colorScheme.onPrimary.withValues(alpha: 0.7)
                          : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                      fontSize: 10,
                    ),
                  ),
                  if (message.isEdited) ...[
                    const SizedBox(width: 4),
                    Text(
                      '(معدلة)',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isCurrentUser
                            ? theme.colorScheme.onPrimary.withValues(alpha: 0.7)
                            : theme.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.7),
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
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

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      // Today: show time only
      return DateFormat.jm().format(dateTime);
    } else if (messageDate ==
        today.subtract(const Duration(days: 1))) {
      // Yesterday
      return 'أمس ${DateFormat.jm().format(dateTime)}';
    } else if (now.difference(dateTime).inDays < 7) {
      // This week: show day name
      return DateFormat('EEEE HH:mm', 'ar').format(dateTime);
    } else {
      // Older: show full date
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    }
  }
}
