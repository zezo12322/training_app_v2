import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/thread/reply_model.dart';
import '../models/thread/task_model.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import '../services/spaces_upload_service.dart';
import '../config/app_config.dart';

// Stream of replies (basic version, no pagination yet)
final evaluationRepliesProvider =
    StreamProvider.family<List<ReplyModel>, String>((ref, evaluationId) {
      final col = FirebaseFirestore.instance
          .collection('evaluations')
          .doc(evaluationId)
          .collection('replies')
          .orderBy('createdAt', descending: false);
      return col.snapshots().map(
        (snap) => snap.docs.map((d) => ReplyModel.fromDoc(d)).toList(),
      );
    });

/// Stream parent evaluation doc (for status, pinnedReplyId, etc.)
final evaluationMetaProvider =
    StreamProvider.family<DocumentSnapshot<Map<String, dynamic>>?, String>((
      ref,
      evaluationId,
    ) {
      return FirebaseFirestore.instance
          .collection('evaluations')
          .doc(evaluationId)
          .snapshots();
    });

final evaluationTasksProvider = StreamProvider.family<List<TaskModel>, String>((
  ref,
  evaluationId,
) {
  final col = FirebaseFirestore.instance
      .collection('evaluations')
      .doc(evaluationId)
      .collection('tasks')
      .orderBy('createdAt', descending: false);
  return col.snapshots().map(
    (snap) => snap.docs.map((d) => TaskModel.fromDoc(d)).toList(),
  );
});

// Basic add reply (text only for now)
final addTextReplyProvider = FutureProvider.family
    .autoDispose<void, ({String evaluationId, String authorId, String text})>((
      ref,
      params,
    ) async {
      final now = DateTime.now();
      final doc = FirebaseFirestore.instance
          .collection('evaluations')
          .doc(params.evaluationId)
          .collection('replies')
          .doc();
      await doc.set({
        'authorId': params.authorId,
        'type': 'text',
        'text': params.text,
        'createdAt': now,
        'canEditUntil': now.add(const Duration(minutes: 5)),
        'deletableUntil': now.add(const Duration(minutes: 10)),
      });
      // update lastActivityAt on parent evaluation
      await FirebaseFirestore.instance
          .collection('evaluations')
          .doc(params.evaluationId)
          .update({'lastActivityAt': DateTime.now()});
    });

/// Add audio reply (after uploading to Spaces)
final addAudioReplyProvider = FutureProvider.family
    .autoDispose<void, ({String evaluationId, String authorId, File file})>((
      ref,
      params,
    ) async {
      // Upload (if spaces enabled)
      String? audioUrl;
      if (AppConfig.useSpaces && AppConfig.spacesPresignEndpoint.isNotEmpty) {
        final service = SpacesUploadService(
          presignEndpoint: AppConfig.spacesPresignEndpoint,
        );
        final ext = p
            .extension(params.file.path)
            .replaceFirst('.', '')
            .toLowerCase();
        try {
          audioUrl = await service.uploadAudio(
            params.file,
            extension: ext.isEmpty ? 'm4a' : ext,
          );
        } catch (_) {}
      }
      final now = DateTime.now();
      final doc = FirebaseFirestore.instance
          .collection('evaluations')
          .doc(params.evaluationId)
          .collection('replies')
          .doc();
      await doc.set({
        'authorId': params.authorId,
        'type': 'audio',
        'audioUrl': audioUrl,
        'createdAt': now,
        'canEditUntil': now.add(const Duration(minutes: 5)),
        'deletableUntil': now.add(const Duration(minutes: 10)),
        'durationSec': null,
      });
      await FirebaseFirestore.instance
          .collection('evaluations')
          .doc(params.evaluationId)
          .update({'lastActivityAt': DateTime.now()});
    });

final addTaskProvider = FutureProvider.family
    .autoDispose<void, ({String evaluationId, String createdBy, String title})>(
      (ref, params) async {
        final now = DateTime.now();
        final doc = FirebaseFirestore.instance
            .collection('evaluations')
            .doc(params.evaluationId)
            .collection('tasks')
            .doc();
        await doc.set({
          'title': params.title,
          'description': null,
          'status': 'open',
          'createdBy': params.createdBy,
          'createdAt': now,
          'updatedAt': now,
        });
        await FirebaseFirestore.instance
            .collection('evaluations')
            .doc(params.evaluationId)
            .update({'lastActivityAt': DateTime.now()});
      },
    );

/// Toggle task status open <-> done
final toggleTaskStatusProvider = FutureProvider.family
    .autoDispose<void, ({String evaluationId, String taskId})>((
      ref,
      params,
    ) async {
      final taskRef = FirebaseFirestore.instance
          .collection('evaluations')
          .doc(params.evaluationId)
          .collection('tasks')
          .doc(params.taskId);
      await FirebaseFirestore.instance.runTransaction((trx) async {
        final snap = await trx.get(taskRef);
        if (!snap.exists) return;
        final data = snap.data() as Map<String, dynamic>;
        final current = data['status'] as String? ?? 'open';
        final next = current == 'done' ? 'open' : 'done';
        trx.update(taskRef, {'status': next, 'updatedAt': DateTime.now()});
      });
      await FirebaseFirestore.instance
          .collection('evaluations')
          .doc(params.evaluationId)
          .update({'lastActivityAt': DateTime.now()});
    });

/// Pin reply
final pinReplyProvider = FutureProvider.family
    .autoDispose<void, ({String evaluationId, String replyId})>((
      ref,
      params,
    ) async {
      await FirebaseFirestore.instance
          .collection('evaluations')
          .doc(params.evaluationId)
          .update({
            'pinnedReplyId': params.replyId,
            'lastActivityAt': DateTime.now(),
          });
    });

/// Unpin reply
final unpinReplyProvider = FutureProvider.family.autoDispose<void, String>((
  ref,
  evaluationId,
) async {
  await FirebaseFirestore.instance
      .collection('evaluations')
      .doc(evaluationId)
      .update({
        'pinnedReplyId': FieldValue.delete(),
        'lastActivityAt': DateTime.now(),
      });
});

/// Update evaluation status
final updateEvaluationStatusProvider = FutureProvider.family
    .autoDispose<void, ({String evaluationId, String status})>((
      ref,
      params,
    ) async {
      await FirebaseFirestore.instance
          .collection('evaluations')
          .doc(params.evaluationId)
          .update({'status': params.status, 'lastActivityAt': DateTime.now()});
    });

/// Mute toggle stored in evaluation_user_settings collection (compound key)
final toggleMuteEvaluationProvider = FutureProvider.family
    .autoDispose<void, ({String evaluationId, String userId})>((
      ref,
      params,
    ) async {
      final key = '${params.userId}_${params.evaluationId}';
      final doc = FirebaseFirestore.instance
          .collection('evaluation_user_settings')
          .doc(key);
      final snap = await doc.get();
      if (snap.exists) {
        final muted = (snap.data()?['muted'] as bool?) ?? false;
        await doc.update({'muted': !muted, 'updatedAt': DateTime.now()});
      } else {
        await doc.set({
          'userId': params.userId,
          'evaluationId': params.evaluationId,
          'muted': true,
          'createdAt': DateTime.now(),
        });
      }
    });

final evaluationMutedProvider =
    StreamProvider.family<bool, ({String evaluationId, String userId})>((
      ref,
      params,
    ) {
      final key = '${params.userId}_${params.evaluationId}';
      return FirebaseFirestore.instance
          .collection('evaluation_user_settings')
          .doc(key)
          .snapshots()
          .map((s) => (s.data()?['muted'] as bool?) ?? false);
    });

/// Optimistic reply local state (simple) -- can be extended for queues
enum PendingStatus { sending, failed }

class LocalPendingReply {
  final String tempId;
  final String text; // For audio we can show placeholder text
  final bool isAudio;
  final String? filePath; // Only for audio retries
  final PendingStatus status;
  LocalPendingReply({
    required this.tempId,
    required this.text,
    required this.isAudio,
    this.filePath,
    this.status = PendingStatus.sending,
  });

  LocalPendingReply copyWith({
    String? text,
    bool? isAudio,
    String? filePath,
    PendingStatus? status,
  }) => LocalPendingReply(
    tempId: tempId,
    text: text ?? this.text,
    isAudio: isAudio ?? this.isAudio,
    filePath: filePath ?? this.filePath,
    status: status ?? this.status,
  );
}

final pendingRepliesProvider =
    StateProvider.family<List<LocalPendingReply>, String>(
      (ref, evaluationId) => [],
    );

/// Add optimistic reply then commit to Firestore; remove if success else mark (for simplicity we just remove on success or keep error state optional)
// ----------------------------------------------------------------------------
// Optimistic reply helpers (converted from FutureProvider to imperative API)
// Reason: Original implementation mutated another provider's state DURING the
// FutureProvider build causing Riverpod assertion:
// "Providers are not allowed to modify other providers during initialization".
// We expose a simple service with methods that perform state mutation before
// awaiting Firestore operations, and return Futures the UI can await.
// ----------------------------------------------------------------------------

class EvaluationThreadActions {
  final Ref ref;
  EvaluationThreadActions(this.ref);

  Future<void> sendText({
    required String evaluationId,
    required String authorId,
    required String text,
  }) async {
    final tempId = 'local_${DateTime.now().millisecondsSinceEpoch}';
    final list = ref.read(pendingRepliesProvider(evaluationId));
    ref.read(pendingRepliesProvider(evaluationId).notifier).state = [
      ...list,
      LocalPendingReply(
        tempId: tempId,
        text: text,
        isAudio: false,
        status: PendingStatus.sending,
      ),
    ];
    try {
      await ref.read(
        addTextReplyProvider((
          evaluationId: evaluationId,
          authorId: authorId,
          text: text,
        )).future,
      );
      _removePending(evaluationId, tempId);
    } catch (e) {
      _markFailed(evaluationId, tempId, isAudio: false);
      rethrow;
    }
  }

  Future<void> sendAudio({
    required String evaluationId,
    required String authorId,
    required File file,
  }) async {
    final tempId = 'local_audio_${DateTime.now().millisecondsSinceEpoch}';
    final list = ref.read(pendingRepliesProvider(evaluationId));
    ref.read(pendingRepliesProvider(evaluationId).notifier).state = [
      ...list,
      LocalPendingReply(
        tempId: tempId,
        text: 'الصوت قيد الإرسال…',
        isAudio: true,
        filePath: file.path,
        status: PendingStatus.sending,
      ),
    ];
    try {
      await ref.read(
        addAudioReplyProvider((
          evaluationId: evaluationId,
          authorId: authorId,
          file: file,
        )).future,
      );
      _removePending(evaluationId, tempId);
    } catch (e) {
      _markFailed(evaluationId, tempId, isAudio: true);
      rethrow;
    }
  }

  void _removePending(String evaluationId, String tempId) {
    ref.read(pendingRepliesProvider(evaluationId).notifier).state = ref
        .read(pendingRepliesProvider(evaluationId))
        .where((r) => r.tempId != tempId)
        .toList();
  }

  void _markFailed(
    String evaluationId,
    String tempId, {
    required bool isAudio,
  }) {
    ref.read(pendingRepliesProvider(evaluationId).notifier).state = ref
        .read(pendingRepliesProvider(evaluationId))
        .map(
          (r) => r.tempId == tempId
              ? r.copyWith(
                  status: PendingStatus.failed,
                  text: isAudio ? 'فشل رفع الصوت' : r.text,
                )
              : r,
        )
        .toList();
  }
}

final evaluationThreadActionsProvider = Provider.autoDispose(
  (ref) => EvaluationThreadActions(ref),
);

/// Retry a failed pending reply (text or audio)
final retryPendingReplyProvider = FutureProvider.family
    .autoDispose<void, ({String evaluationId, String tempId, String authorId})>(
      (ref, params) async {
        final list = ref.read(pendingRepliesProvider(params.evaluationId));
        final target = list.firstWhere(
          (e) => e.tempId == params.tempId,
          orElse: () => LocalPendingReply(tempId: '', text: '', isAudio: false),
        );
        if (target.tempId.isEmpty || target.status != PendingStatus.failed) {
          return;
        }
        // Set to sending
        ref
            .read(pendingRepliesProvider(params.evaluationId).notifier)
            .state = list
            .map(
              (r) => r.tempId == target.tempId
                  ? r.copyWith(
                      status: PendingStatus.sending,
                      text: r.isAudio ? 'الصوت قيد الإرسال…' : r.text,
                    )
                  : r,
            )
            .toList();
        try {
          if (target.isAudio && target.filePath != null) {
            await ref.read(
              addAudioReplyProvider((
                evaluationId: params.evaluationId,
                authorId: params.authorId,
                file: File(target.filePath!),
              )).future,
            );
          } else {
            await ref.read(
              addTextReplyProvider((
                evaluationId: params.evaluationId,
                authorId: params.authorId,
                text: target.text,
              )).future,
            );
          }
          // remove on success
          ref
              .read(pendingRepliesProvider(params.evaluationId).notifier)
              .state = ref
              .read(pendingRepliesProvider(params.evaluationId))
              .where((r) => r.tempId != target.tempId)
              .toList();
        } catch (e) {
          // revert to failed
          ref
              .read(pendingRepliesProvider(params.evaluationId).notifier)
              .state = ref
              .read(pendingRepliesProvider(params.evaluationId))
              .map(
                (r) => r.tempId == target.tempId
                    ? r.copyWith(
                        status: PendingStatus.failed,
                        text: r.isAudio ? 'فشل رفع الصوت' : r.text,
                      )
                    : r,
              )
              .toList();
        }
      },
    );

/// Update reply text (with edit window validation client-side for safety)
final updateReplyTextProvider = FutureProvider.family
    .autoDispose<
      void,
      ({String evaluationId, String replyId, String newText})
    >((ref, params) async {
      final docRef = FirebaseFirestore.instance
          .collection('evaluations')
          .doc(params.evaluationId)
          .collection('replies')
          .doc(params.replyId);
      final snap = await docRef.get();
      if (!snap.exists) return;
      final data = snap.data();
      final canEditUntil = data?['canEditUntil'];
      DateTime? canEdit;
      if (canEditUntil is Timestamp) canEdit = canEditUntil.toDate();
      if (canEdit != null && DateTime.now().isAfter(canEdit)) {
        // Outside edit window, skip silently (UI should guard; security rules should enforce)
        return;
      }
      await docRef.update({'text': params.newText, 'editedAt': DateTime.now()});
      await FirebaseFirestore.instance
          .collection('evaluations')
          .doc(params.evaluationId)
          .update({'lastActivityAt': DateTime.now()});
    });

/// Delete reply inside deletable window
final deleteReplyProvider = FutureProvider.family
    .autoDispose<void, ({String evaluationId, String replyId})>((
      ref,
      params,
    ) async {
      final docRef = FirebaseFirestore.instance
          .collection('evaluations')
          .doc(params.evaluationId)
          .collection('replies')
          .doc(params.replyId);
      final snap = await docRef.get();
      if (!snap.exists) return;
      final data = snap.data();
      final deletableUntil = data?['deletableUntil'];
      DateTime? limit;
      if (deletableUntil is Timestamp) limit = deletableUntil.toDate();
      if (limit != null && DateTime.now().isAfter(limit)) {
        return; // outside window
      }
      await docRef.delete();
      await FirebaseFirestore.instance
          .collection('evaluations')
          .doc(params.evaluationId)
          .update({'lastActivityAt': DateTime.now()});
    });

/// Persist audio duration once known (idempotent - only if null)
final setAudioDurationIfAbsentProvider = FutureProvider.family
    .autoDispose<void, ({String evaluationId, String replyId, int seconds})>((
      ref,
      params,
    ) async {
      final docRef = FirebaseFirestore.instance
          .collection('evaluations')
          .doc(params.evaluationId)
          .collection('replies')
          .doc(params.replyId);
      await FirebaseFirestore.instance.runTransaction((trx) async {
        final snap = await trx.get(docRef);
        if (!snap.exists) return;
        final data = snap.data() as Map<String, dynamic>;
        if ((data['audioDurationSec'] as int?) == null) {
          trx.update(docRef, {'audioDurationSec': params.seconds});
        }
      });
    });
