import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';

import '../models/thread/reply_model.dart';
// Tasks feature moved to a dedicated screen – task model import removed
import '../providers/auth_provider.dart';
import '../providers/evaluation_thread_providers.dart'
    show
        evaluationRepliesProvider,
        evaluationMetaProvider,
        pinReplyProvider,
        unpinReplyProvider,
        deleteReplyProvider,
        updateReplyTextProvider,
        setAudioDurationIfAbsentProvider,
        pendingRepliesProvider,
        PendingStatus,
        LocalPendingReply,
        retryPendingReplyProvider,
        evaluationThreadActionsProvider;

class EvaluationThreadScreen extends ConsumerStatefulWidget {
  final String evaluationId;
  final String traineeId;
  final String trainerId;
  const EvaluationThreadScreen({
    super.key,
    required this.evaluationId,
    required this.traineeId,
    required this.trainerId,
  });

  @override
  ConsumerState<EvaluationThreadScreen> createState() =>
      _EvaluationThreadScreenState();
}

class _EvaluationThreadScreenState
    extends ConsumerState<EvaluationThreadScreen> {
  // Text / task controllers
  final _textController = TextEditingController();
  // Task controller removed (tasks relocated)
  final _editController = TextEditingController();
  // bool _addingTask removed
  String? _editingReplyId;

  // Audio recording
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  DateTime? _recordStart;
  Timer? _recTimer;
  Duration _recElapsed = Duration.zero;
  static const int _kMaxAudioSeconds = 30;
  String? _recordPath;

  // Playback
  AudioPlayer? _player;
  String? _playingReplyId;
  Duration _playPos = Duration.zero;
  Duration _playDur = Duration.zero;

  @override
  void dispose() {
    _textController.dispose();
    // _taskController disposed (removed)
    _editController.dispose();
    _recTimer?.cancel();
    _audioRecorder.dispose();
    _player?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l; // non-null localization
    final user = ref.watch(authStateProvider).value;
    final repliesAsync = ref.watch(
      evaluationRepliesProvider(widget.evaluationId),
    );
    // Tasks removed from thread view per request (now handled elsewhere)
    final metaAsync = ref.watch(evaluationMetaProvider(widget.evaluationId));
    final pending = ref.watch(pendingRepliesProvider(widget.evaluationId));
    final pinnedId = metaAsync.whenOrNull(
      data: (d) => d?.data()?['pinnedReplyId'] as String?,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l.threadTitle),
        actions: [
          if (user != null)
            IconButton(
              tooltip: l.refreshTooltip,
              onPressed: () => setState(() {}),
              icon: const Icon(Icons.refresh),
            ),
        ],
      ),
      body: Column(
        children: [
          // Evaluation summary header
          metaAsync.when(
            data: (doc) {
              final data = doc?.data() ?? {};
              final score = data['score'];
              final feedback = data['feedback'] as String?;
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(
                        context,
                      ).dividerColor.withValues(alpha: .4),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.assessment,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          score == null
                              ? l.scoreLabel('-')
                              : l.scoreLabel(score),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    if (feedback != null && feedback.trim().isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        feedback,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(height: 1.25),
                      ),
                    ],
                  ],
                ),
              );
            },
            loading: () => const LinearProgressIndicator(minHeight: 2),
            error: (e, st) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.l.evaluationLoadError,
                style: TextStyle(color: Colors.red.shade700, fontSize: 12),
              ),
            ),
          ),
          if (pinnedId != null) _PinnedBanner(pinnedId: pinnedId),
          const Divider(height: 0),
          Expanded(
            child: repliesAsync.when(
              data: (list) {
                // Merge pending replies (text + audio)
                final merged = [
                  ...list,
                  ...pending.map(
                    (p) => ReplyModel(
                      id: p.tempId,
                      authorId: user?.uid ?? 'local',
                      type: p.isAudio ? ReplyType.audio : ReplyType.text,
                      text: p.text,
                    ),
                  ),
                ];
                if (merged.isEmpty) {
                  return Center(child: Text(l.noRepliesYet));
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  itemCount: merged.length,
                  itemBuilder: (ctx, i) {
                    final r = merged[i];
                    final isPending = r.id.startsWith('local_');
                    final pendingMeta = isPending
                        ? pending.firstWhere(
                            (e) => e.tempId == r.id,
                            orElse: () => LocalPendingReply(
                              tempId: r.id,
                              text: r.text ?? '',
                              isAudio: r.type == ReplyType.audio,
                            ),
                          )
                        : null;
                    final isFailed =
                        pendingMeta?.status == PendingStatus.failed;
                    return _buildReplyBubble(
                      reply: r,
                      isPending: isPending,
                      isFailed: isFailed,
                      pendingMeta: pendingMeta,
                      pinnedId: pinnedId,
                      currentUserId: user?.uid,
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) {
                final l = context.l;
                return Center(child: Text(l.errorGeneric(e.toString())));
              },
            ),
          ),
          _buildComposer(user),
        ],
      ),
    );
  }

  // Tasks section removed.

  // ---------------------------------------------------------------------------
  // Reply Bubble
  // ---------------------------------------------------------------------------
  Widget _buildReplyBubble({
    required ReplyModel reply,
    required bool isPending,
    required bool isFailed,
    required LocalPendingReply? pendingMeta,
    required String? pinnedId,
    required String? currentUserId,
  }) {
    final isMine = currentUserId == reply.authorId;
    final now = DateTime.now();
    final canEdit =
        reply.canEditUntil != null &&
        now.isBefore(reply.canEditUntil!) &&
        isMine &&
        reply.type == ReplyType.text &&
        !isPending;
    final canDelete =
        reply.deletableUntil != null &&
        now.isBefore(reply.deletableUntil!) &&
        isMine &&
        !isPending;
    final isPinned = !isPending && pinnedId == reply.id;

    final bubbleColor = isMine
        ? Theme.of(context).colorScheme.primaryContainer
        : Theme.of(context).colorScheme.secondaryContainer;
    final alignment = isMine
        ? AlignmentDirectional.centerEnd
        : AlignmentDirectional.centerStart;

    Widget inner;
    if (reply.type == ReplyType.text) {
      inner = _buildTextContent(
        reply,
        isPending,
        isFailed,
        canEdit,
        pendingMeta,
      );
    } else {
      inner = _buildAudioContent(
        reply,
        isPending,
        isFailed: isFailed,
        pendingMeta: pendingMeta,
      );
    }

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 380),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onLongPress: () => _onBubbleMenu(
                reply,
                canEdit: canEdit,
                canDelete: canDelete,
                isPinned: isPinned,
                isPending: isPending,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: bubbleColor.withAlpha(
                    (255 * (isPending ? (isFailed ? 0.45 : 0.6) : 1)).round(),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(14),
                    topRight: const Radius.circular(14),
                    bottomLeft: Radius.circular(isMine ? 14 : 4),
                    bottomRight: Radius.circular(isMine ? 4 : 14),
                  ),
                  border: Border.all(
                    color: isPinned
                        ? Theme.of(
                            context,
                          ).colorScheme.primary.withAlpha((255 * .55).round())
                        : Theme.of(
                            context,
                          ).colorScheme.outline.withAlpha((255 * .10).round()),
                    width: isPinned ? 1.4 : 1,
                  ),
                  boxShadow: isPinned
                      ? [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary
                                .withAlpha((255 * .20).round()),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: inner,
              ),
            ),
            if (isPinned)
              Positioned(
                top: -4,
                left: isMine ? null : -6,
                right: isMine ? -6 : null,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha((255 * .4).round()),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.push_pin,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _onBubbleMenu(
    ReplyModel r, {
    required bool canEdit,
    required bool canDelete,
    required bool isPinned,
    required bool isPending,
  }) async {
    final l = context.l;
    if (isPending) return; // no menu for pending
    final user = ref.read(authStateProvider).value;
    final selection = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            if (user?.uid == widget.trainerId && !isPinned)
              ListTile(
                leading: const Icon(Icons.push_pin_outlined),
                title: Text(l.pinAction),
                onTap: () => Navigator.pop(ctx, 'pin'),
              ),
            if (user?.uid == widget.trainerId && isPinned)
              ListTile(
                leading: const Icon(Icons.push_pin),
                title: Text(l.unpinAction),
                onTap: () => Navigator.pop(ctx, 'unpin'),
              ),
            if (r.type == ReplyType.text)
              ListTile(
                leading: const Icon(Icons.copy),
                title: Text(l.copyTextAction),
                onTap: () => Navigator.pop(ctx, 'copy'),
              ),
            if (canEdit)
              ListTile(
                leading: const Icon(Icons.edit),
                title: Text(l.editAction),
                onTap: () => Navigator.pop(ctx, 'edit'),
              ),
            if (canDelete)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: Text(
                  l.deleteAction,
                  style: const TextStyle(color: Colors.red),
                ),
                onTap: () => Navigator.pop(ctx, 'delete'),
              ),
          ],
        ),
      ),
    );
    if (!mounted) return; // Guard against use after async gap
    switch (selection) {
      case 'pin':
        ref.read(
          pinReplyProvider((
            evaluationId: widget.evaluationId,
            replyId: r.id,
          )).future,
        );
        break;
      case 'unpin':
        ref.read(unpinReplyProvider(widget.evaluationId).future);
        break;
      case 'copy':
        if (r.text != null) {
          AppSnackBar.show(context, l.copiedToast, isError: false);
        }
        break;
      case 'edit':
        if (canEdit) {
          setState(() {
            _editingReplyId = r.id;
            _editController.text = r.text ?? '';
          });
        }
        break;
      case 'delete':
        if (canDelete) {
          ref.read(
            deleteReplyProvider((
              evaluationId: widget.evaluationId,
              replyId: r.id,
            )).future,
          );
        }
        break;
    }
  }

  // ---------------------------------------------------------------------------
  // Composer
  // ---------------------------------------------------------------------------
  Widget _buildComposer(User? user) {
    final l = context.l;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 10),
        child: Row(
          children: [
            _buildRecordButton(),
            const SizedBox(width: 6),
            Expanded(
              child: TextField(
                controller: _textController,
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: l.writeReplyHint,
                  border: const OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.send_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                final txt = _textController.text.trim();
                if (txt.isEmpty) return;
                final u = ref.read(authStateProvider).value;
                if (u == null) return;
                _textController.clear();
                ref
                    .read(evaluationThreadActionsProvider)
                    .sendText(
                      evaluationId: widget.evaluationId,
                      authorId: u.uid,
                      text: txt,
                    );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordButton() {
    return GestureDetector(
      onTap: _toggleRecord,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isRecording
              ? Colors.red
              : Theme.of(context).colorScheme.primaryContainer,
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.outline.withAlpha((255 * .25).round()),
          ),
        ),
        child: Center(
          child: _isRecording
              ? Text(
                  _formatElapsed(_recElapsed),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                )
              : Icon(
                  Icons.mic,
                  color: Theme.of(context).colorScheme.primary,
                  size: 22,
                ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Text & Audio Content Widgets
  // ---------------------------------------------------------------------------
  Widget _buildTextContent(
    ReplyModel r,
    bool isPending,
    bool isFailed,
    bool canEdit,
    LocalPendingReply? pendingMeta,
  ) {
    final l = context.l;
    final showSpinner = isPending && !isFailed;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: _editingReplyId == r.id
              ? _buildEditField(r)
              : Text(
                  r.text ?? '',
                  style: TextStyle(
                    height: 1.35,
                    decoration: isFailed ? TextDecoration.lineThrough : null,
                    color: isFailed ? Colors.red.shade700 : null,
                  ),
                ),
        ),
        if (showSpinner)
          const Padding(
            padding: EdgeInsetsDirectional.only(start: 8),
            child: SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        if (isFailed && pendingMeta != null)
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              final u = ref.read(authStateProvider).value;
              if (u != null) {
                ref.read(
                  retryPendingReplyProvider((
                    evaluationId: widget.evaluationId,
                    tempId: pendingMeta.tempId,
                    authorId: u.uid,
                  )).future,
                );
              }
            },
            child: Container(
              margin: const EdgeInsetsDirectional.only(start: 6),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha((255 * .15).round()),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.refresh, size: 14, color: Colors.red),
                  const SizedBox(width: 4),
                  Text(
                    l.retryLabel,
                    style: const TextStyle(fontSize: 11, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        if (canEdit && _editingReplyId != r.id && !isPending && !isFailed)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 4),
            child: Icon(
              Icons.edit,
              size: 14,
              color: Theme.of(
                context,
              ).colorScheme.primary.withAlpha((255 * .7).round()),
            ),
          ),
      ],
    );
  }

  Widget _buildAudioContent(
    ReplyModel r,
    bool isPending, {
    required bool isFailed,
    LocalPendingReply? pendingMeta,
  }) {
    final l = context.l;
    final isPlaying = _playingReplyId == r.id;
    if (isPending || r.audioUrl == null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.audiotrack),
          const SizedBox(width: 8),
          Text(
            isPending
                ? l.uploadingAudio
                : (isFailed ? l.audioFailed : l.audioLabel),
          ),
          if (isPending)
            const Padding(
              padding: EdgeInsetsDirectional.only(start: 8),
              child: SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          if (isFailed && pendingMeta != null)
            InkWell(
              onTap: () {
                final u = ref.read(authStateProvider).value;
                if (u != null) {
                  ref.read(
                    retryPendingReplyProvider((
                      evaluationId: widget.evaluationId,
                      tempId: pendingMeta.tempId,
                      authorId: u.uid,
                    )).future,
                  );
                }
              },
              child: const Padding(
                padding: EdgeInsetsDirectional.only(start: 6),
                child: Icon(Icons.refresh, size: 16, color: Colors.red),
              ),
            ),
        ],
      );
    }
    final pos = isPlaying ? _playPos : Duration.zero;
    final dur = _playDur > Duration.zero && isPlaying
        ? _playDur
        : (r.audioDurationSec != null
              ? Duration(seconds: r.audioDurationSec!)
              : Duration.zero);
    String fmt(Duration d) => d.inMinutes == 0
        ? '0:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}'
        : '${d.inMinutes}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return SizedBox(
      width: 220,
      child: Row(
        children: [
          InkWell(
            onTap: () => _togglePlay(r),
            borderRadius: BorderRadius.circular(24),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(
                  context,
                ).colorScheme.primary.withAlpha((255 * .15).round()),
              ),
              padding: const EdgeInsets.all(4),
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: dur.inMilliseconds == 0
                        ? 0
                        : (pos.inMilliseconds / dur.inMilliseconds).clamp(0, 1),
                    minHeight: 5,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.outline.withAlpha((255 * .15).round()),
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      fmt(pos),
                      style: const TextStyle(fontSize: 10, height: 1.1),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '/',
                      style: TextStyle(fontSize: 10, height: 1.1),
                    ),
                    Text(
                      dur == Duration.zero ? '--:--' : fmt(dur),
                      style: const TextStyle(fontSize: 10, height: 1.1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Audio record & playback
  // ---------------------------------------------------------------------------
  String _formatElapsed(Duration d) =>
      '${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}';

  Future<void> _toggleRecord() async {
    if (_isRecording) {
      final path = await _audioRecorder.stop();
      _recTimer?.cancel();
      setState(() => _isRecording = false);
      if (path != null) {
        _recordPath = path;
        await _sendAudioReply();
      }
      return;
    }
    if (!await _audioRecorder.hasPermission()) return;
    final dir = await getTemporaryDirectory();
    final filePath = p.join(
      dir.path,
      'reply_${DateTime.now().millisecondsSinceEpoch}.m4a',
    );
    await _audioRecorder.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        sampleRate: 44100,
        numChannels: 1,
      ),
      path: filePath,
    );
    setState(() {
      _isRecording = true;
      _recElapsed = Duration.zero;
      _recordStart = DateTime.now();
    });
    _recTimer?.cancel();
    _recTimer = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (!_isRecording || _recordStart == null) return;
      final diff = DateTime.now().difference(_recordStart!);
      setState(() => _recElapsed = diff);
      if (diff.inSeconds >= _kMaxAudioSeconds) {
        final path = await _audioRecorder.stop();
        _recTimer?.cancel();
        setState(() => _isRecording = false);
        if (path != null) {
          _recordPath = path;
          await _sendAudioReply();
        }
      }
    });
  }

  Future<void> _sendAudioReply() async {
    final user = ref.read(authStateProvider).value;
    if (user == null || _recordPath == null) return;
    final file = File(_recordPath!);
    if (!file.existsSync()) return;
    ref
        .read(evaluationThreadActionsProvider)
        .sendAudio(
          evaluationId: widget.evaluationId,
          authorId: user.uid,
          file: file,
        );
    _recordPath = null;
  }

  Future<void> _togglePlay(ReplyModel r) async {
    if (r.audioUrl == null) return;
    if (_playingReplyId == r.id) {
      await _player?.stop();
      setState(() {
        _playingReplyId = null;
        _playPos = Duration.zero;
        _playDur = Duration.zero;
      });
      return;
    }
    await _player?.stop();
    _player?.dispose();
    final player = AudioPlayer();
    setState(() {
      _player = player;
      _playingReplyId = r.id;
      _playPos = Duration.zero;
      _playDur = Duration.zero;
    });
    player.onDurationChanged.listen((d) {
      if (_playingReplyId == r.id) {
        setState(() => _playDur = d);
        if (r.audioDurationSec == null && d.inSeconds > 0) {
          ref.read(
            setAudioDurationIfAbsentProvider((
              evaluationId: widget.evaluationId,
              replyId: r.id,
              seconds: d.inSeconds,
            )).future,
          );
        }
      }
    });
    player.onPositionChanged.listen((p) {
      if (_playingReplyId == r.id) setState(() => _playPos = p);
    });
    player.onPlayerComplete.listen((_) {
      if (_playingReplyId == r.id) {
        setState(() {
          _playPos = _playDur;
          _playingReplyId = null;
        });
      }
    });
    await player.play(UrlSource(r.audioUrl!));
  }

  // ---------------------------------------------------------------------------
  // Edit Field
  // ---------------------------------------------------------------------------
  Widget _buildEditField(ReplyModel r) {
    final l = context.l;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _editController,
          maxLines: null,
          decoration: const InputDecoration(
            isDense: true,
            border: InputBorder.none,
          ),
          style: const TextStyle(height: 1.35),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () => setState(() => _editingReplyId = null),
              child: Text(l.editCancel),
            ),
            const SizedBox(width: 4),
            ElevatedButton(
              onPressed: () {
                final newText = _editController.text.trim();
                if (newText.isEmpty) {
                  setState(() => _editingReplyId = null);
                  return;
                }
                ref.read(
                  updateReplyTextProvider((
                    evaluationId: widget.evaluationId,
                    replyId: r.id,
                    newText: newText,
                  )).future,
                );
                setState(() => _editingReplyId = null);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                minimumSize: Size.zero,
              ),
              child: Text(l.editSave),
            ),
          ],
        ),
      ],
    );
  }

  // _addTask removed.
}

// Simple pinned banner placeholder (can be extended to show snippet)
class _PinnedBanner extends StatelessWidget {
  final String pinnedId;
  const _PinnedBanner({required this.pinnedId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.primary.withAlpha((255 * .08).round()),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.primary.withAlpha((255 * .35).round()),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.push_pin, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              context.l.pinnedReplyLabel(pinnedId),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
