import 'package:flutter/material.dart';
import '../models/evaluation.dart';
import 'package:training_app/core/l10n_ext.dart';
import '../screens/evaluation_thread_screen.dart';

typedef AudioToggleCallback = Future<void> Function(String url);

class EvaluationCard extends StatelessWidget {
  final EvaluationModel evaluation;
  final bool isPlaying;
  final bool hasAudio;
  final AudioToggleCallback? onToggleAudio;
  final String? currentlyPlayingUrl;

  const EvaluationCard({
    super.key,
    required this.evaluation,
    required this.isPlaying,
    required this.currentlyPlayingUrl,
    required this.hasAudio,
    this.onToggleAudio,
  });

  @override
  Widget build(BuildContext context) {
    final created = evaluation.createdAt;
    final dateStr = created != null
        ? '${created.year}/${created.month}/${created.day}'
        : '—';
    final cs = Theme.of(context).colorScheme;
    final playingThis = isPlaying && currentlyPlayingUrl == evaluation.audioUrl;
    return Card(
      elevation: playingThis ? 4 : 1,
      shadowColor: playingThis ? cs.primary.withValues(alpha: 0.4) : null,
      child: InkWell(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: playingThis
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      cs.primaryContainer.withValues(alpha: 0.28),
                      cs.surface,
                    ],
                  )
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            _ScoreChip(score: evaluation.score),
                            Chip(
                              label: Text(
                                dateStr,
                                style: const TextStyle(fontSize: 12),
                              ),
                              backgroundColor: cs.surfaceContainerHighest
                                  .withValues(alpha: 0.5),
                              elevation: 0,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              side: BorderSide.none,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (evaluation.feedback.isNotEmpty) ...[
                          Text(
                            evaluation.feedback,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(height: 1.45),
                          ),
                        ] else ...[
                          Builder(
                            builder: (ctx) {
                              final l = ctx.l;
                              return Text(
                                l.noFeedback,
                                style: Theme.of(ctx).textTheme.bodySmall
                                    ?.copyWith(color: cs.outline),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              if (hasAudio && evaluation.audioUrl != null) ...[
                const SizedBox(height: 16),
                _AudioSection(
                  url: evaluation.audioUrl!,
                  isPlaying:
                      isPlaying && currentlyPlayingUrl == evaluation.audioUrl,
                  onToggle: onToggleAudio,
                ),
              ],
              const SizedBox(height: 12),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EvaluationThreadScreen(
                          evaluationId: evaluation.id,
                          traineeId: evaluation.traineeId,
                          trainerId: evaluation.trainerId,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.forum_outlined, size: 18),
                  label: Builder(
                    builder: (ctx) => Text(ctx.l.discussionButton),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreChip extends StatelessWidget {
  final int score;
  const _ScoreChip({required this.score});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Chip(
      label: Text(
        context.l.scoreLabel(score),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: cs.primaryContainer,
      labelStyle: TextStyle(color: cs.onPrimaryContainer),
      side: BorderSide.none,
    );
  }
}

class _AudioSection extends StatefulWidget {
  final String url;
  final bool isPlaying;
  final AudioToggleCallback? onToggle;
  const _AudioSection({
    required this.url,
    required this.isPlaying,
    this.onToggle,
  });

  @override
  State<_AudioSection> createState() => _AudioSectionState();
}

class _AudioSectionState extends State<_AudioSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    if (widget.isPlaying) _pulse.repeat();
  }

  @override
  void didUpdateWidget(covariant _AudioSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isPlaying != widget.isPlaying) {
      if (widget.isPlaying) {
        _pulse.repeat();
      } else {
        _pulse.stop();
      }
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Background with subtle frosted / layered look for better contrast.
    final Color baseBg = isDark
        ? Color.alphaBlend(
            cs.primary.withValues(alpha: 0.06),
            cs.surfaceContainerHighest.withValues(alpha: 0.35),
          )
        : Color.alphaBlend(
            cs.primary.withValues(alpha: 0.08),
            cs.surfaceContainerHighest.withValues(alpha: 0.55),
          );
    final Color activeBg = isDark
        ? Color.alphaBlend(
            cs.primary.withValues(alpha: 0.18),
            cs.surfaceContainerHighest.withValues(alpha: 0.45),
          )
        : Color.alphaBlend(
            cs.primary.withValues(alpha: 0.20),
            cs.surfaceContainerHighest.withValues(alpha: 0.70),
          );

    final containerDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: widget.isPlaying
            ? [activeBg, activeBg.withValues(alpha: isDark ? 0.85 : 0.92)]
            : [baseBg, baseBg.withValues(alpha: isDark ? 0.75 : 0.90)],
      ),
      border: Border.all(color: cs.outline.withValues(alpha: 0.12)),
      boxShadow: [
        if (widget.isPlaying)
          BoxShadow(
            color: cs.primary.withValues(alpha: 0.25),
            blurRadius: 14,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
      ],
    );

    final Gradient buttonGradient = LinearGradient(
      colors: widget.isPlaying
          ? [cs.primary, cs.tertiary]
          : [cs.primaryContainer, cs.secondaryContainer],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final iconColor = widget.isPlaying ? cs.onPrimary : cs.onPrimaryContainer;

    final l = context.l;
    return Semantics(
      label: widget.isPlaying ? l.audioPauseSemantic : l.audioPlaySemantic,
      button: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        decoration: containerDecoration,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Play/Pause button with pulsing ring when playing
            SizedBox(
              height: 56,
              width: 56,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (widget.isPlaying)
                    AnimatedBuilder(
                      animation: _pulse,
                      builder: (context, _) {
                        final scale = 1 + (_pulse.value * 0.55);
                        final opacity = (1 - _pulse.value).clamp(0.0, 1.0);
                        return Transform.scale(
                          scale: scale,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  cs.primary.withValues(alpha: 0.18 * opacity),
                                  cs.primary.withValues(alpha: 0.01),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  Material(
                    shape: const CircleBorder(),
                    elevation: widget.isPlaying ? 6 : 0,
                    color: Colors.transparent,
                    child: Ink(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: buttonGradient,
                      ),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => widget.onToggle?.call(widget.url),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 320),
                            transitionBuilder: (child, anim) =>
                                ScaleTransition(scale: anim, child: child),
                            child: Icon(
                              widget.isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              key: ValueKey(widget.isPlaying),
                              size: 30,
                              color: iconColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          l.audioEvaluation,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: widget.isPlaying
                                    ? cs.onPrimaryContainer
                                    : null,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 350),
                        opacity: widget.isPlaying ? 1 : 0,
                        child: Icon(
                          Icons.equalizer_rounded,
                          size: 16,
                          color: cs.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: widget.isPlaying
                        ? Text(
                            l.audioPlayingNow,
                            key: const ValueKey('playing'),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              // M3 tone update: onSurfaceVariant -> outlineVariant for subdued label
                              color: cs.outlineVariant,
                              letterSpacing: .2,
                            ),
                          )
                        : Text(
                            l.audioTapToPlay,
                            key: const ValueKey('tap'),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  // Maintain alpha while switching base tone
                                  color: cs.outlineVariant.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                          ),
                  ),
                  // Decorative progress placeholder bar (future real progress) for visual polish.
                  const SizedBox(height: 8),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          height: 4,
                          width: double.infinity,
                          color: cs.outline.withValues(alpha: 0.08),
                          alignment: Alignment.centerLeft,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOutCubic,
                            width: widget.isPlaying
                                ? constraints.maxWidth * .35
                                : constraints.maxWidth * .12,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  cs.primary,
                                  cs.primary.withValues(alpha: 0.4),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Right edge decorative icon
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: widget.isPlaying
                  ? Icon(
                      Icons.music_note_rounded,
                      key: const ValueKey('note'),
                      color: cs.primary,
                      size: 22,
                    )
                  : Icon(
                      Icons.graphic_eq,
                      key: const ValueKey('eq_off'),
                      color: cs.outline.withValues(alpha: 0.35),
                      size: 20,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
