import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/moderation.dart';
import '../core/logging.dart';

/// خدمة الإشراف والإبلاغ
class ModerationService {
  final FirebaseFirestore _firestore;

  ModerationService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// تقديم تقرير
  Future<Report?> submitReport({
    required String reporterId,
    required String reporterName,
    required ReportType type,
    required String contentType,
    required String contentId,
    required String reportedUserId,
    required String reason,
    required String institutionId,
    required String companyId,
    String? description,
    List<String>? evidenceUrls,
    String? courseId,
  }) async {
    try {
      final reportId = _generateId();
      final report = Report(
        id: reportId,
        type: type,
        reporterId: reporterId,
        reporterName: reporterName,
        contentType: contentType,
        contentId: contentId,
        reportedUserId: reportedUserId,
        reason: reason,
        description: description ?? '',
        evidenceUrls: evidenceUrls ?? [],
        courseId: courseId,
        createdAt: DateTime.now(),
        institutionId: institutionId,
        companyId: companyId,
      );

      await _firestore.collection('reports').doc(reportId).set(report.toJson());

      // إخفاء المحتوى تلقائياً للمراجعة (optional)
      if (type == ReportType.inappropriate || type == ReportType.harmful) {
        await _flagContentForReview(contentType, contentId);
      }

      logger.i('Report submitted: $reportId');
      return report;
    } catch (e, stackTrace) {
      logger.e('Error submitting report', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// مراجعة تقرير
  Future<bool> reviewReport({
    required String reportId,
    required String reviewerId,
    required String reviewerName,
    required ReportStatus newStatus,
    required ModerationAction action,
    String? reviewNotes,
  }) async {
    try {
      final updates = <String, dynamic>{
        'status': newStatus.toString(),
        'reviewerId': reviewerId,
        'reviewerName': reviewerName,
        'action': action.toString(),
        'reviewNotes': reviewNotes,
        'reviewedAt': FieldValue.serverTimestamp(),
      };

      if (newStatus == ReportStatus.resolved) {
        updates['resolvedAt'] = FieldValue.serverTimestamp();
      }

      await _firestore.collection('reports').doc(reportId).update(updates);

      // تنفيذ الإجراء إذا لزم الأمر
      if (action != ModerationAction.none) {
        final reportDoc = await _firestore.collection('reports').doc(reportId).get();
        if (reportDoc.exists) {
          final report = Report.fromJson(reportDoc.data()!);
          await _executeAction(
            report: report,
            action: action,
            moderatorId: reviewerId,
            moderatorName: reviewerName,
          );
        }
      }

      logger.i('Report reviewed: $reportId, action: $action');
      return true;
    } catch (e) {
      logger.e('Error reviewing report', error: e);
      return false;
    }
  }

  /// تنفيذ إجراء تأديبي
  Future<void> _executeAction({
    required Report report,
    required ModerationAction action,
    required String moderatorId,
    required String moderatorName,
  }) async {
    try {
      switch (action) {
        case ModerationAction.deleteContent:
          await _deleteContent(report.contentType, report.contentId);
          break;
        case ModerationAction.hideContent:
          await _hideContent(report.contentType, report.contentId);
          break;
        case ModerationAction.muteUser:
          await _muteUser(
            userId: report.reportedUserId,
            moderatorId: moderatorId,
            moderatorName: moderatorName,
            reason: report.reason,
            durationDays: 7,
            institutionId: report.institutionId,
            companyId: report.companyId,
          );
          break;
        case ModerationAction.banUser:
          await _banUser(
            userId: report.reportedUserId,
            moderatorId: moderatorId,
            moderatorName: moderatorName,
            reason: report.reason,
            institutionId: report.institutionId,
            companyId: report.companyId,
          );
          break;
        default:
          logger.d('Action $action - no implementation needed');
      }

      // تسجيل الإجراء
      await _logAction(
        targetUserId: report.reportedUserId,
        action: action,
        moderatorId: moderatorId,
        moderatorName: moderatorName,
        reason: report.reason,
        reportId: report.id,
        institutionId: report.institutionId,
        companyId: report.companyId,
      );
    } catch (e) {
      logger.e('Error executing action', error: e);
    }
  }

  /// حذف محتوى
  Future<void> _deleteContent(String contentType, String contentId) async {
    try {
      if (contentType == 'message') {
        await _firestore.collection('chat_messages').doc(contentId).update({
          'isDeleted': true,
          'deletedAt': FieldValue.serverTimestamp(),
          'content': '',
          'isModerated': true,
        });
      } else if (contentType == 'post') {
        await _firestore.collection('wall_posts').doc(contentId).delete();
      }
      logger.i('Content deleted: $contentType/$contentId');
    } catch (e) {
      logger.e('Error deleting content', error: e);
    }
  }

  /// إخفاء محتوى
  Future<void> _hideContent(String contentType, String contentId) async {
    try {
      if (contentType == 'message') {
        await _firestore.collection('chat_messages').doc(contentId).update({
          'isModerated': true,
        });
      }
      logger.i('Content hidden: $contentType/$contentId');
    } catch (e) {
      logger.e('Error hiding content', error: e);
    }
  }

  /// وضع علامة للمراجعة
  Future<void> _flagContentForReview(String contentType, String contentId) async {
    try {
      if (contentType == 'message') {
        await _firestore.collection('chat_messages').doc(contentId).update({
          'isFlagged': true,
        });
      }
    } catch (e) {
      logger.e('Error flagging content', error: e);
    }
  }

  /// كتم مستخدم
  Future<void> _muteUser({
    required String userId,
    required String moderatorId,
    required String moderatorName,
    required String reason,
    required int durationDays,
    required String institutionId,
    required String companyId,
  }) async {
    try {
      final endDate = DateTime.now().add(Duration(days: durationDays));
      
      await _firestore.collection('user_restrictions').doc(userId).set({
        'isMuted': true,
        'mutedUntil': Timestamp.fromDate(endDate),
        'reason': reason,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      logger.i('User muted: $userId until $endDate');
    } catch (e) {
      logger.e('Error muting user', error: e);
    }
  }

  /// حظر مستخدم
  Future<void> _banUser({
    required String userId,
    required String moderatorId,
    required String moderatorName,
    required String reason,
    required String institutionId,
    required String companyId,
  }) async {
    try {
      await _firestore.collection('user_restrictions').doc(userId).set({
        'isBanned': true,
        'bannedAt': FieldValue.serverTimestamp(),
        'reason': reason,
      }, SetOptions(merge: true));

      logger.i('User banned: $userId');
    } catch (e) {
      logger.e('Error banning user', error: e);
    }
  }

  /// تسجيل الإجراء
  Future<void> _logAction({
    required String targetUserId,
    required ModerationAction action,
    required String moderatorId,
    required String moderatorName,
    required String reason,
    required String institutionId,
    required String companyId,
    String? reportId,
  }) async {
    try {
      final logId = _generateId();
      final log = ModerationLog(
        id: logId,
        targetUserId: targetUserId,
        targetUserName: '',
        action: action,
        reason: reason,
        startDate: DateTime.now(),
        moderatorId: moderatorId,
        moderatorName: moderatorName,
        relatedReportId: reportId,
        institutionId: institutionId,
        companyId: companyId,
      );

      await _firestore.collection('moderation_logs').doc(logId).set(log.toJson());
    } catch (e) {
      logger.e('Error logging action', error: e);
    }
  }

  /// التحقق من حالة المستخدم
  Future<bool> isUserRestricted(String userId) async {
    try {
      final doc = await _firestore
          .collection('user_restrictions')
          .doc(userId)
          .get();

      if (!doc.exists) return false;

      final data = doc.data()!;
      
      // التحقق من الحظر
      if (data['isBanned'] == true) {
        return true;
      }

      // التحقق من الكتم
      if (data['isMuted'] == true) {
        final mutedUntil = (data['mutedUntil'] as Timestamp?)?.toDate();
        if (mutedUntil != null && mutedUntil.isAfter(DateTime.now())) {
          return true;
        }
      }

      return false;
    } catch (e) {
      logger.e('Error checking user restrictions', error: e);
      return false;
    }
  }

  /// تصفية المحتوى (كشف الكلمات المحظورة)
  Future<bool> filterContent(String content, String institutionId) async {
    try {
      final filterDoc = await _firestore
          .collection('content_filters')
          .doc(institutionId)
          .get();

      if (!filterDoc.exists) return true; // السماح إذا لم يوجد فلتر

      final filter = ContentFilter.fromJson(filterDoc.data()!);
      
      if (!filter.isActive) return true;

      // التحقق من الكلمات المحظورة
      final lowerContent = content.toLowerCase();
      for (final word in filter.bannedWords) {
        if (lowerContent.contains(word.toLowerCase())) {
          logger.w('Banned word detected: $word');
          return false;
        }
      }

      // التحقق من الأنماط (regex)
      for (final pattern in filter.bannedPatterns) {
        final regex = RegExp(pattern, caseSensitive: false);
        if (regex.hasMatch(content)) {
          logger.w('Banned pattern detected: $pattern');
          return false;
        }
      }

      return true;
    } catch (e) {
      logger.e('Error filtering content', error: e);
      return true; // السماح في حالة الخطأ
    }
  }

  /// Stream للتقارير قيد المراجعة
  Stream<List<Report>> streamPendingReports(String institutionId) {
    return _firestore
        .collection('reports')
        .where('institutionId', isEqualTo: institutionId)
        .where('status', isEqualTo: ReportStatus.pending.toString())
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Report.fromJson(doc.data())).toList();
    });
  }

  /// جلب إحصائيات الإشراف
  Future<ModerationStats> getModerationStats(String institutionId) async {
    try {
      final reports = await _firestore
          .collection('reports')
          .where('institutionId', isEqualTo: institutionId)
          .get();

      final total = reports.size;
      var pending = 0;
      var resolved = 0;
      var dismissed = 0;
      final byType = <String, int>{};

      for (final doc in reports.docs) {
        final report = Report.fromJson(doc.data());
        
        if (report.status == ReportStatus.pending) pending++;
        if (report.status == ReportStatus.resolved) resolved++;
        if (report.status == ReportStatus.dismissed) dismissed++;

        final typeKey = report.type.toString();
        byType[typeKey] = (byType[typeKey] ?? 0) + 1;
      }

      return ModerationStats(
        totalReports: total,
        pendingReports: pending,
        resolvedReports: resolved,
        dismissedReports: dismissed,
        reportsByType: byType,
      );
    } catch (e) {
      logger.e('Error getting moderation stats', error: e);
      return const ModerationStats();
    }
  }

  String _generateId() {
    return _firestore.collection('reports').doc().id;
  }
}
