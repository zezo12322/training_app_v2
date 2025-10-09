// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:async';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// For FontFeature
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../providers/evaluation_providers.dart';
import '../providers/auth_provider.dart';
import '../core/logging.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
import 'package:training_app/services/notification_service.dart';
import 'package:training_app/core/l10n_ext.dart';
// ...existing code...
import 'package:training_app/models/user_review.dart';
import 'package:training_app/repositories/points_repository.dart';
import 'package:training_app/repositories/review_repository.dart';

class AddEvaluationScreen extends ConsumerStatefulWidget {
  final String courseId;
  final String traineeId;
  final String traineeEmail;

  const AddEvaluationScreen({
    super.key,
    required this.courseId,
    required this.traineeId,
    required this.traineeEmail,
  });

  @override
  ConsumerState<AddEvaluationScreen> createState() =>
      _AddEvaluationScreenState();
}

class _AddEvaluationScreenState extends ConsumerState<AddEvaluationScreen> {
  final _scoreController = TextEditingController();
  final _feedbackController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  String? _audioPath;
  DateTime? _recordStart;
  Timer? _timer;
  Duration _elapsed = Duration.zero;

  // Preview playback state
  AudioPlayer? _previewPlayer;
  bool _isPreviewPlaying = false;
  Duration _previewDuration = Duration.zero;
  Duration _previewPosition = Duration.zero;
  // Waveform data captured while recording (amplitude levels 0..1)
  final List<double> _waveform = [];
  StreamSubscription<Amplitude>? _ampSub;

  static const int _kMaxSeconds = 180; // 3 minutes limit
  static const int _kTargetWaveformBars =
      60; // number of bars kept for visualization

  @override
  void dispose() {
    _scoreController.dispose();
    _feedbackController.dispose();
    _audioRecorder.dispose();
    _timer?.cancel();
    _previewPlayer?.dispose();
    _ampSub?.cancel();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    if (await _audioRecorder.isRecording()) {
      final path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        _audioPath = path;
        _recordStart = null;
        _timer?.cancel();
        _elapsed = Duration.zero;
      });
      HapticFeedback.lightImpact();
      await _ampSub?.cancel();
    } else {
      if (await _audioRecorder.hasPermission()) {
        // Use app-specific temporary directory to avoid EROFS on some devices
        final dir = await getTemporaryDirectory();
        final fileName =
            'audio_evaluation_${DateTime.now().millisecondsSinceEpoch}.m4a';
        final filePath = p.join(dir.path, fileName);
        await _audioRecorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc, // High compatibility AAC (LC)
            bitRate:
                96000, // Balanced quality vs size (can drop to 64000 if needed)
            sampleRate: 44100,
            numChannels: 1,
          ),
          path: filePath,
        );
        setState(() {
          _isRecording = true;
          _audioPath = null;
          _recordStart = DateTime.now();
          _elapsed = Duration.zero;
          _waveform.clear();
        });
        _timer?.cancel();
        _timer = Timer.periodic(const Duration(seconds: 1), (_) {
          if (!mounted || !_isRecording || _recordStart == null) return;
          final diff = DateTime.now().difference(_recordStart!);
          setState(() {
            _elapsed = diff;
          });
          // Auto stop when exceeding max duration
          if (diff.inSeconds >= _kMaxSeconds) {
            _autoStopRecording();
          }
        });
        HapticFeedback.mediumImpact();

        // Stop preview if was playing
        if (_isPreviewPlaying) {
          await _previewPlayer?.stop();
          setState(() {
            _isPreviewPlaying = false;
          });
        }

        // Start amplitude stream every 120ms
        _ampSub?.cancel();
        _ampSub = _audioRecorder
            .onAmplitudeChanged(const Duration(milliseconds: 120))
            .listen((amp) {
              // amp.current ranges roughly in db negative; normalize
              // We'll take absolute amplitude as linear ratio
              final linear =
                  (amp.current + 45) / 45; // assume -45dB floor to 0dB
              final clamped = linear.clamp(0.0, 1.0);
              setState(() {
                _waveform.add(clamped);
                // Down-sample to target bars by dropping oldest if over capacity
                if (_waveform.length > _kTargetWaveformBars) {
                  // Remove proportionally: simple remove first
                  _waveform.removeAt(0);
                }
              });
            });
      }
    }
  }

  Future<void> _autoStopRecording() async {
    if (!_isRecording) return;
    try {
      final path = await _audioRecorder.stop();
      await _ampSub?.cancel();
      setState(() {
        _isRecording = false;
        _audioPath = path;
        _recordStart = null;
        _timer?.cancel();
      });
      if (mounted) {
        _showSnackBar(context.l.autoStopRecording, isError: false);
      }
    } catch (_) {}
  }

  Future<void> _togglePreview() async {
    if (_audioPath == null) return;
    _previewPlayer ??= AudioPlayer();
    // Attach listeners once
    _previewPlayer!.onDurationChanged.listen((d) {
      if (mounted) {
        setState(() {
          _previewDuration = d;
        });
      }
    });
    _previewPlayer!.onPositionChanged.listen((p) {
      if (mounted) {
        setState(() {
          _previewPosition = p;
        });
      }
    });
    _previewPlayer!.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          _isPreviewPlaying = false;
          _previewPosition = _previewDuration;
        });
      }
    });

    if (_isPreviewPlaying) {
      await _previewPlayer!.pause();
      setState(() {
        _isPreviewPlaying = false;
      });
    } else {
      try {
        await _previewPlayer!.stop();
        await _previewPlayer!.play(DeviceFileSource(_audioPath!));
        setState(() {
          _isPreviewPlaying = true;
        });
      } catch (e) {
        final l = context.l;
        _showSnackBar(l.previewPlayError(e.toString()));
      }
    }
  }

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Future<void> _submitEvaluation() async {
    if (!_formKey.currentState!.validate()) return;
    final trainerId = ref.read(authStateProvider).value?.uid;
    if (trainerId == null) {
      _showSnackBar(context.l.trainerAccountMissing);
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final repo = ref.read(evaluationRepositoryProvider);
      final result = await repo.addEvaluation(
        courseId: widget.courseId,
        traineeId: widget.traineeId,
        traineeEmail: widget.traineeEmail,
        score: int.tryParse(_scoreController.text.trim()) ?? 0,
        feedback: _feedbackController.text.trim(),
        trainerId: trainerId,
        audioFile: _audioPath != null ? File(_audioPath!) : null,
      );
      result.when(
        success: (_) async {
          _showSnackBar(context.l.evaluationSendSuccess, isError: false);
          await _sendNewEvaluationNotification();

          // --- Competitive Features Logic ---
          // 1. Award points to trainee and trainer
          try {
            final pointsRepo = PointsRepository();
            await pointsRepo.addPoints(
              widget.traineeId,
              10,
            ); // Example: 10 points per evaluation
            await pointsRepo.addPoints(
              trainerId,
              5,
            ); // Example: 5 points for trainer

            // 2. Award badge if trainee reaches 100 points (example logic)
            final traineePoints = await pointsRepo.getUserPoints(
              widget.traineeId,
            );
            if (traineePoints != null &&
                traineePoints.points >= 100 &&
                !traineePoints.badges.contains('100_points')) {
              await pointsRepo.addBadge(widget.traineeId, '100_points');
            }

            // 3. Add review for trainee (can be extended for trainer)
            final reviewRepo = ReviewRepository();
            await reviewRepo.addReview(
              UserReview(
                id: '', // Firestore auto-id
                reviewerId: trainerId,
                targetId: widget.traineeId,
                rating: 5.0, // Example: always 5, can be made dynamic
                comment: _feedbackController.text.trim(),
                date: DateTime.now(),
              ),
            );
          } catch (e, st) {
            logger.w('Competitive features error', error: e, stackTrace: st);
          }
          // --- End Competitive Features Logic ---

          if (mounted) Navigator.of(context).pop();
        },
        failure: (f) {
          _showSnackBar(
            context.l.evaluationSendFailure(f.localizedMessage(context)),
          );
        },
      );
    } catch (e, st) {
      logger.e(
        'Unexpected error submitting evaluation',
        error: e,
        stackTrace: st,
      );
      _showSnackBar(context.l.unexpectedErrorMsg(e.toString()));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _sendNewEvaluationNotification() async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.traineeId)
          .get();
      if (!userDoc.exists) return;
      // Using external user id mapping, just send trainee uid.

      final courseDoc = await FirebaseFirestore.instance
          .collection('courses')
          .doc(widget.courseId)
          .get();
      final l = context.l;
      final courseName = courseDoc.data()?['name'] ?? l.courseNameFallback;

      await OneSignalNotificationService().sendNotificationViaBackend(
        userIds: [widget.traineeId],
        title: context.l.notificationNewEvaluationTitle,
        content: context.l.notificationNewEvaluationBody(courseName),
      );
    } catch (e, st) {
      logger.w(
        'Could not send evaluation notification: $e',
        error: e,
        stackTrace: st,
      );
    }
  }

  void _showSnackBar(String message, {bool isError = true}) {
    if (!mounted) return;
    AppSnackBar.show(context, message, isError: isError);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isRecording,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return; // already popped via system back
        if (_isRecording) {
          final shouldDiscard = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(context.l.cancelRecordingTitle),
              content: Text(context.l.cancelRecordingBody),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: Text(context.l.dialogNo),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: Text(context.l.dialogYes),
                ),
              ],
            ),
          );
          if (shouldDiscard == true) {
            try {
              await _audioRecorder.stop();
            } catch (_) {}
            if (mounted) {
              setState(() {
                _isRecording = false;
                _recordStart = null;
                _timer?.cancel();
              });
              Navigator.of(context).pop();
            }
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.l.reportTitle(widget.traineeEmail))),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _scoreController,
                  decoration: InputDecoration(
                    labelText: context.l.scoreFieldLabel,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.l.scoreRequired;
                    }
                    final score = int.tryParse(value);
                    if (score == null || score < 0 || score > 100) {
                      return context.l.scoreRangeError;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _feedbackController,
                  decoration: InputDecoration(
                    labelText: context.l.feedbackFieldLabel,
                    border: const OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.l.feedbackRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  context.l.audioSectionOptional,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Center(
                  child: _RecordButton(
                    isRecording: _isRecording,
                    hasRecorded: _audioPath != null && !_isRecording,
                    elapsed: _elapsed,
                    onTap: _toggleRecording,
                  ),
                ),
                if (_audioPath != null && !_isRecording) ...[
                  const SizedBox(height: 20),
                  _PreviewPlayerBar(
                    isPlaying: _isPreviewPlaying,
                    duration: _previewDuration,
                    position: _previewPosition,
                    onToggle: _togglePreview,
                    onReRecord: _toggleRecording,
                    label: _format(_previewDuration),
                    waveform: List<double>.from(_waveform),
                  ),
                ],
                const SizedBox(height: 24),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton.icon(
                        icon: const Icon(Icons.send),
                        label: Text(context.l.submitEvaluation),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: _submitEvaluation,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Fancy circular record button with white icon on dark background and subtle pulse when recording.
class _RecordButton extends StatefulWidget {
  final bool isRecording;
  final bool hasRecorded;
  final Duration elapsed;
  final VoidCallback onTap;
  const _RecordButton({
    required this.isRecording,
    required this.hasRecorded,
    required this.elapsed,
    required this.onTap,
  });

  @override
  State<_RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<_RecordButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    if (widget.isRecording) {
      _pulse.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant _RecordButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isRecording != widget.isRecording) {
      if (widget.isRecording) {
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

    final Color ringColor = widget.isRecording
        ? (isDark ? Colors.redAccent.shade200 : Colors.redAccent)
        : (isDark
              ? cs.primary.withValues(alpha: 0.7)
              : cs.primary.withValues(alpha: 0.85));

    final Gradient buttonGradient = widget.isRecording
        ? LinearGradient(colors: [Colors.red.shade400, Colors.red.shade700])
        : LinearGradient(colors: [cs.primary, cs.secondary]);

    final icon = widget.isRecording ? Icons.stop_rounded : Icons.mic_rounded;
    final iconColor =
        Colors.white; // enforce white icon for clarity on dark backgrounds

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 120,
          width: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Live waveform ring (circular) using current bars when not too empty
              if (widget.isRecording)
                Positioned.fill(
                  child: CustomPaint(
                    painter: _CircularWaveformPainter(
                      widget.elapsed,
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              if (widget.isRecording)
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
                          color: ringColor.withValues(alpha: 0.15 * opacity),
                        ),
                      ),
                    );
                  },
                ),
              Material(
                shape: const CircleBorder(),
                elevation: widget.isRecording ? 8 : 4,
                child: Ink(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: buttonGradient,
                  ),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: widget.onTap,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, anim) =>
                            ScaleTransition(scale: anim, child: child),
                        child: Icon(
                          icon,
                          key: ValueKey(icon),
                          size: 38,
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
        const SizedBox(height: 12),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Column(
            key: ValueKey(widget.isRecording),
            children: [
              Text(
                widget.isRecording
                    ? context.l.recordingInProgress
                    : context.l.recordingStartLabel,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : cs.onSurface,
                ),
              ),
              if (widget.isRecording) ...[
                const SizedBox(height: 4),
                Text(
                  _format(widget.elapsed),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.white70 : cs.outlineVariant,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ],
          ),
        ),
        if (widget.hasRecorded) ...[
          const SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 20),
              const SizedBox(width: 6),
              Text(
                context.l.recordedLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: cs.successColorOrGreen(),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

String _format(Duration d) {
  final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$m:$s';
}

class _PreviewPlayerBar extends StatelessWidget {
  final bool isPlaying;
  final Duration duration;
  final Duration position;
  final VoidCallback onToggle;
  final VoidCallback onReRecord;
  final String label;
  final List<double> waveform;
  const _PreviewPlayerBar({
    required this.isPlaying,
    required this.duration,
    required this.position,
    required this.onToggle,
    required this.onReRecord,
    required this.label,
    required this.waveform,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final total = duration.inMilliseconds == 0 ? 1 : duration.inMilliseconds;
    final progress = (position.inMilliseconds / total).clamp(0.0, 1.0);
    return Semantics(
      label: context.l.previewAudioLabel,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
          border: Border.all(color: cs.outline.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onToggle,
                  customBorder: const CircleBorder(),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: isPlaying
                        ? cs.primary
                        : cs.primaryContainer,
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: isPlaying ? cs.onPrimary : cs.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            context.l.previewButton,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Text(
                            _format(position),
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: cs.outlineVariant),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        height: 46,
                        child: _WaveformBars(
                          bars: waveform,
                          progress: progress,
                          activeColor: cs.primary,
                          inactiveColor: cs.outline.withValues(alpha: 0.18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  context.l.durationLabel(label),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: cs.outlineVariant),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: onReRecord,
                  icon: const Icon(Icons.mic, size: 18),
                  label: Text(context.l.reRecord),
                  style: TextButton.styleFrom(foregroundColor: cs.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension _ColorSchemeSuccess on ColorScheme {
  Color successColorOrGreen() => brightness == Brightness.dark
      ? Colors.greenAccent.shade200
      : Colors.green.shade600;
}

class _WaveformBars extends StatelessWidget {
  final List<double> bars;
  final double progress; // 0..1
  final Color activeColor;
  final Color inactiveColor;
  const _WaveformBars({
    required this.bars,
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final effective = bars.isEmpty ? List<double>.filled(30, 0.05) : bars;
    return LayoutBuilder(
      builder: (context, constraints) {
        final barCount = effective.length;
        final spacing = 2.0;
        final progressIndex = (progress * barCount).clamp(
          0,
          barCount.toDouble(),
        );
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (var i = 0; i < barCount; i++) ...[
              Expanded(
                flex: 1,
                child: FractionallySizedBox(
                  heightFactor: 0.2 + (effective[i] * 0.8),
                  alignment: Alignment.bottomCenter,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: i <= progressIndex ? activeColor : inactiveColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              if (i != barCount - 1) SizedBox(width: spacing),
            ],
          ],
        );
      },
    );
  }
}

class _CircularWaveformPainter extends CustomPainter {
  final Duration elapsed;
  final Color color;
  _CircularWaveformPainter(this.elapsed, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final totalSegments = 40;
    final t = (elapsed.inMilliseconds / 4000) % 1.0; // cycles every 4s
    for (var i = 0; i < totalSegments; i++) {
      final angle = (i / totalSegments) * math.pi * 2;
      final segT = (i / totalSegments - t);
      final fade = (1 - (segT.abs() * 3)).clamp(0.0, 1.0);
      final amp = 6 + 10 * fade;
      final inner = radius - 18;
      final outer = inner + amp;
      paint.color = color.withValues(alpha: 0.10 + 0.55 * fade);
      final p1 = Offset(
        center.dx + inner * math.cos(angle),
        center.dy + inner * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + outer * math.cos(angle),
        center.dy + outer * math.sin(angle),
      );
      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CircularWaveformPainter oldDelegate) =>
      oldDelegate.elapsed != elapsed;
}
