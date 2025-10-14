import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/gamification/gamification_settings.dart';
import '../../models/gamification/user_course_progress.dart';
import '../../models/gamification/points_transaction.dart';
import '../../core/logging.dart';

/// Repository لإدارة بيانات نظام التقدم في Firestore
class GamificationRepository {
  final FirebaseFirestore _firestore;

  GamificationRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // ==================== Collections ====================
  
  CollectionReference get _coursesCollection => 
      _firestore.collection('courses');
  
  CollectionReference get _progressCollection => 
      _firestore.collection('user_course_progress');
  
  CollectionReference get _transactionsCollection => 
      _firestore.collection('points_transactions');

  // ==================== Settings ====================

  /// الحصول على إعدادات نظام النقاط للكورس
  Future<GamificationSettings?> getSettings(String courseId) async {
    try {
      final doc = await _coursesCollection.doc(courseId).get();
      
      if (!doc.exists) return null;
      
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null || !data.containsKey('gamificationSettings')) {
        return null;
      }
      
      return GamificationSettings.fromJson(
        data['gamificationSettings'] as Map<String, dynamic>,
      );
    } catch (e) {
      logger.e('Error getting gamification settings', error: e);
      return null;
    }
  }

  /// تحديث إعدادات نظام النقاط
  Future<void> updateSettings(
    String courseId,
    GamificationSettings settings,
  ) async {
    try {
      await _coursesCollection.doc(courseId).update({
        'gamificationSettings': settings.toJson(),
      });
    } catch (e) {
      // إذا لم يوجد الحقل، نستخدم set مع merge
      await _coursesCollection.doc(courseId).set({
        'gamificationSettings': settings.toJson(),
      }, SetOptions(merge: true));
    }
  }

  // ==================== User Progress ====================

  /// الحصول على تقدم المستخدم في الكورس
  Future<UserCourseProgress?> getUserProgress(
    String userId,
    String courseId,
  ) async {
    try {
      final docId = '${userId}_$courseId';
      final doc = await _progressCollection.doc(docId).get();
      
      if (!doc.exists) return null;
      
      final data = doc.data() as Map<String, dynamic>;
      return UserCourseProgress.fromJson(data);
    } catch (e) {
      logger.e('Error getting user progress', error: e);
      return null;
    }
  }

  /// تحديث تقدم المستخدم
  Future<void> updateUserProgress(UserCourseProgress progress) async {
    try {
      final docId = '${progress.userId}_${progress.courseId}';
      await _progressCollection.doc(docId).set(
        progress.toJson(),
        SetOptions(merge: true),
      );
    } catch (e) {
      logger.e('Error updating user progress', error: e);
      rethrow;
    }
  }

  /// الحصول على المتصدرين (Leaderboard)
  Future<List<UserCourseProgress>> getTopUsers(
    String courseId, {
    int limit = 10,
  }) async {
    try {
      final snapshot = await _progressCollection
          .where('courseId', isEqualTo: courseId)
          .orderBy('totalPoints', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs
          .map((doc) => UserCourseProgress.fromJson(
                doc.data() as Map<String, dynamic>,
              ))
          .toList();
    } catch (e) {
      logger.e('Error getting leaderboard', error: e);
      return [];
    }
  }

  /// Stream لتقدم المستخدم (real-time)
  Stream<UserCourseProgress?> watchUserProgress(
    String userId,
    String courseId,
  ) {
    final docId = '${userId}_$courseId';
    return _progressCollection.doc(docId).snapshots().map((snapshot) {
      if (!snapshot.exists) return null;
      return UserCourseProgress.fromJson(
        snapshot.data() as Map<String, dynamic>,
      );
    });
  }

  /// Stream للمتصدرين (real-time leaderboard)
  Stream<List<UserCourseProgress>> watchLeaderboard(
    String courseId, {
    int limit = 10,
  }) {
    return _progressCollection
        .where('courseId', isEqualTo: courseId)
        .orderBy('totalPoints', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserCourseProgress.fromJson(
                  doc.data() as Map<String, dynamic>,
                ))
            .toList());
  }

  // ==================== Points Transactions ====================

  /// إضافة معاملة نقاط جديدة
  Future<void> addPointsTransaction(PointsTransaction transaction) async {
    try {
      await _transactionsCollection.add(transaction.toJson());
    } catch (e) {
      logger.e('Error adding points transaction', error: e);
      rethrow;
    }
  }

  /// الحصول على سجل النقاط للمستخدم
  Stream<List<PointsTransaction>> getPointsTransactions({
    required String userId,
    required String courseId,
    int limit = 20,
  }) {
    return _transactionsCollection
        .where('userId', isEqualTo: userId)
        .where('courseId', isEqualTo: courseId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              data['id'] = doc.id;
              return PointsTransaction.fromJson(data);
            })
            .toList());
  }

  /// الحصول على آخر معاملات النقاط للكورس (لجميع المستخدمين)
  Stream<List<PointsTransaction>> getRecentTransactions(
    String courseId, {
    int limit = 50,
  }) {
    return _transactionsCollection
        .where('courseId', isEqualTo: courseId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              data['id'] = doc.id;
              return PointsTransaction.fromJson(data);
            })
            .toList());
  }

  /// حذف كل بيانات التقدم للكورس (للمدرب - عند إعادة تعيين النظام)
  Future<void> resetCourseProgress(String courseId) async {
    try {
      // حذف كل التقدم
      final progressDocs = await _progressCollection
          .where('courseId', isEqualTo: courseId)
          .get();
      
      final batch = _firestore.batch();
      for (final doc in progressDocs.docs) {
        batch.delete(doc.reference);
      }
      
      // حذف كل المعاملات
      final transactionDocs = await _transactionsCollection
          .where('courseId', isEqualTo: courseId)
          .get();
      
      for (final doc in transactionDocs.docs) {
        batch.delete(doc.reference);
      }
      
      await batch.commit();
    } catch (e) {
      logger.e('Error resetting course progress', error: e);
      rethrow;
    }
  }
}
