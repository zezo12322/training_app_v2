import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/poll.dart';
import '../providers/poll_providers.dart';
import 'package:timeago/timeago.dart' as timeago;

class PollWidget extends ConsumerWidget {
  final String pollId;
  final String userId;

  const PollWidget({
    super.key,
    required this.pollId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pollAsync = ref.watch(pollProvider(pollId));

    return pollAsync.when(
      data: (poll) {
        if (poll == null) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('لم يتم العثور على الاستطلاع'),
            ),
          );
        }
        return _PollContent(poll: poll, userId: userId);
      },
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, stack) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('خطأ: $error'),
        ),
      ),
    );
  }
}

class _PollContent extends ConsumerStatefulWidget {
  final Poll poll;
  final String userId;

  const _PollContent({
    required this.poll,
    required this.userId,
  });

  @override
  ConsumerState<_PollContent> createState() => _PollContentState();
}

class _PollContentState extends ConsumerState<_PollContent> {
  bool _isVoting = false;

  Future<void> _vote(String optionId) async {
    if (_isVoting) return;

    setState(() => _isVoting = true);

    try {
      final hasVoted = widget.poll.hasUserVoted(widget.userId);
      final currentVotes = widget.poll.getUserVotes(widget.userId);

      if (hasVoted && currentVotes.contains(optionId)) {
        // Remove vote if already voted for this option
        await ref.read(removeVoteProvider)(
          pollId: widget.poll.id,
          optionId: optionId,
          userId: widget.userId,
        );
      } else {
        // Add vote
        await ref.read(voteOnPollProvider)(
          pollId: widget.poll.id,
          optionId: optionId,
          userId: widget.userId,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isVoting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasVoted = widget.poll.hasUserVoted(widget.userId);
    final userVotes = widget.poll.getUserVotes(widget.userId);
    final showResults = hasVoted || widget.poll.showResultsBeforeVoting || !widget.poll.isActive;

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.poll,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'استطلاع رأي',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const Spacer(),
                if (!widget.poll.isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'منتهي',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onErrorContainer,
                          ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Question
            Text(
              widget.poll.question,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // Options
            ...widget.poll.options.map((option) {
              final isSelected = userVotes.contains(option.id);
              final percentage = option.getPercentage(widget.poll.totalVotes);

              if (showResults) {
                // Show results
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _ResultOption(
                    option: option,
                    percentage: percentage,
                    isSelected: isSelected,
                    totalVotes: widget.poll.totalVotes,
                  ),
                );
              } else {
                // Show voting option
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _VoteOption(
                    option: option,
                    isSelected: isSelected,
                    onTap: widget.poll.isActive && !_isVoting
                        ? () => _vote(option.id)
                        : null,
                    allowMultiple: widget.poll.allowMultipleVotes,
                  ),
                );
              }
            }),

            const SizedBox(height: 8),

            // Footer
            Row(
              children: [
                Icon(
                  Icons.how_to_vote_outlined,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  '${widget.poll.totalVotes} ${widget.poll.totalVotes == 1 ? 'صوت' : 'أصوات'}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                if (widget.poll.endsAt != null) ...[
                  const SizedBox(width: 16),
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.poll.isActive
                        ? 'ينتهي ${timeago.format(widget.poll.endsAt!, locale: 'ar')}'
                        : 'انتهى ${timeago.format(widget.poll.endsAt!, locale: 'ar')}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _VoteOption extends StatelessWidget {
  final PollOption option;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool allowMultiple;

  const _VoteOption({
    required this.option,
    required this.isSelected,
    required this.onTap,
    required this.allowMultiple,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
              : null,
        ),
        child: Row(
          children: [
            Icon(
              allowMultiple
                  ? (isSelected ? Icons.check_box : Icons.check_box_outline_blank)
                  : (isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked),
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option.text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : null,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultOption extends StatelessWidget {
  final PollOption option;
  final double percentage;
  final bool isSelected;
  final int totalVotes;

  const _ResultOption({
    required this.option,
    required this.percentage,
    required this.isSelected,
    required this.totalVotes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                option.text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : null,
                    ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${percentage.toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Stack(
          children: [
            // Background
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            // Progress
            FractionallySizedBox(
              widthFactor: percentage / 100,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '${option.voteCount} ${option.voteCount == 1 ? 'صوت' : 'أصوات'}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}
