import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
// Firebase Storage أزيل لأنه لم يعد مطلوباً لرفع ملفات التقييم الصوتية
import 'package:training_app/services/spaces_upload_service.dart';
import 'package:training_app/config/app_config.dart';
import 'package:training_app/core/result.dart';
import 'package:training_app/models/evaluation.dart';
import 'package:training_app/core/logging.dart';
import 'package:training_app/core/bootstrap.dart';

class EvaluationRepository {
  final FirebaseFirestore _firestore;
  final SpacesUploadService? _spacesService =
      (AppConfig.useSpaces && AppConfig.spacesPresignEndpoint.isNotEmpty)
      ? SpacesUploadService(presignEndpoint: AppConfig.spacesPresignEndpoint)
      : null;

  EvaluationRepository(this._firestore);

  Stream<List<EvaluationModel>> streamUserEvaluations({
    required String courseId,
    required String traineeId,
  }) {
    return _firestore
        .collection('evaluations')
        .where('courseId', isEqualTo: courseId)
        .where('traineeId', isEqualTo: traineeId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) {
          final list = snap.docs.map((d) {
            final data = d.data();
            final rawUrl = data['audioUrl'];
            // Sanitize empty strings
            if (rawUrl is String && rawUrl.trim().isEmpty) {
              data['audioUrl'] = null;
            }
            final model = EvaluationModel.fromJson({...data, 'id': d.id});
            return model;
          }).toList();
          logger.i(
            '[EvalStream] course=$courseId trainee=$traineeId count=${list.length} audioWithUrl=${list.where((e) => (e.audioUrl ?? '').isNotEmpty).length}',
          );
          return list;
        });
  }

  Future<Result<void>> addEvaluation({
    required String courseId,
    required String traineeId,
    required String traineeEmail,
    required int score,
    required String feedback,
    required String trainerId,
    File? audioFile,
  }) async {
    try {
      String? audioUrl;
      if (audioFile != null) {
        if (!audioFile.existsSync()) {
          logger.w(
            'Audio file passed but does not exist on disk: ${audioFile.path}',
          );
        } else if (audioFile.lengthSync() == 0) {
          logger.w('Audio file is empty (0 bytes): ${audioFile.path}');
        } else if (_spacesService != null &&
            _spacesService.presignEndpoint.isNotEmpty) {
          logger.i('Uploading evaluation audio via DigitalOcean Spaces.');
          try {
            audioUrl = await _spacesService.uploadAudio(audioFile);
          } catch (e, st) {
            logger.e(
              'Spaces audio upload failed -> سيتم تجاهل الصوت',
              error: e,
              stackTrace: st,
            );
          }
        } else {
          // Explicitly inform that audio is skipped because no Spaces backend enabled
          logger.w(
            'Audio file present but no storage backend enabled (Spaces disabled) -> تقييم بدون صوت',
          );
        }
      }
      await traceAsync(
        'evaluation.addEval',
        () => _firestore.collection('evaluations').add({
          'courseId': courseId,
          'traineeId': traineeId,
          'traineeEmail': traineeEmail,
          'score': score,
          'feedback': feedback,
          'audioUrl': audioUrl,
          'trainerId': trainerId,
          'createdAt': FieldValue.serverTimestamp(),
        }),
      );
      logger.i(
        'Evaluation added (course=$courseId trainee=$traineeId score=$score hasAudio=${audioUrl != null})',
      );
      return const Success(null);
    } on FirebaseException catch (e, st) {
      // Provide more user-friendly messages for common codes
      String friendly = e.message ?? 'خطأ غير معروف';
      switch (e.code) {
        case 'permission-denied':
          friendly =
              'لا توجد صلاحية لإضافة تقييم. تحقق من صلاحيات الحساب أو قواعد التخزين.';
          break;
        case 'unauthenticated':
          friendly = 'انتهت الجلسة. يرجى تسجيل الدخول مجدداً.';
          break;
        case 'object-not-found':
          friendly =
              'تم رفع الملف لكن تعذر استرجاع رابطه حالياً. حاول مرة أخرى بعد لحظات.';
          break;
      }
      logger.e(
        'Failed to add evaluation (code=${e.code})',
        error: e,
        stackTrace: st,
      );
      return FailureResult(UnknownFailure(friendly, cause: e, stack: st));
    } catch (e, st) {
      logger.e('Unexpected error addEvaluation', error: e, stackTrace: st);
      return FailureResult(UnknownFailure(e.toString(), cause: e, stack: st));
    }
  }
}
