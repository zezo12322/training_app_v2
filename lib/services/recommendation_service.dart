import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recommendation.dart';
import '../models/gamification/user_course_progress.dart';
import '../core/logging.dart';

/// خدمة نظام التوصيات التكيفي
/// 
/// تحلل أداء المستخدم وتقترح المحتوى الأنسب له
class RecommendationService {
  final FirebaseFirestore _firestore;

  RecommendationService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// توليد توصيات للمستخدم بناءً على أدائه
  Future<List<Recommendation>> generateRecommendations({
    required String userId,
    required String courseId,
    RecommendationCriteria? criteria,
  }) async {
    try {
      final recommendations = <Recommendation>[];
      final criteriaToUse = criteria ??
          RecommendationCriteria(userId: userId, courseId: courseId);

      // 1. جلب بيانات التقدم
      final progress = await _getUserProgress(userId, courseId);
      
      // 2. جلب درجات الاختبارات
      final quizScores = await _getQuizScores(userId, courseId);
      
      // 3. جلب المحتوى المكتمل
      final completedContent = await _getCompletedContent(userId, courseId);

      // 4. توليد توصيات بناءً على الأداء الضعيف
      if (quizScores.isNotEmpty) {
        final weakTopics = _identifyWeakTopics(quizScores);
        for (final topic in weakTopics.take(2)) {
          final rec = await _createReviewRecommendation(
            userId: userId,
            courseId: courseId,
            topic: topic,
            priority: 90,
          );
          if (rec != null) recommendations.add(rec);
        }
      }

      // 5. توصية بالخطوة التالية المنطقية
      final nextStep = await _suggestNextStep(
        userId: userId,
        courseId: courseId,
        completedContent: completedContent,
      );
      if (nextStep != null) recommendations.add(nextStep);

      // 6. توصيات بناءً على شعبية المحتوى بين الأقران
      final popularContent = await _getPopularContent(
        courseId: courseId,
        excludeIds: completedContent,
        limit: 2,
      );
      for (final content in popularContent) {
        final rec = await _createPopularRecommendation(
          userId: userId,
          courseId: courseId,
          content: content,
        );
        if (rec != null) recommendations.add(rec);
      }

      // 7. توصيات لسد فجوات المهارات
      final skillGaps = await _identifySkillGaps(userId, courseId, progress);
      for (final gap in skillGaps.take(1)) {
        final rec = await _createSkillGapRecommendation(
          userId: userId,
          courseId: courseId,
          skill: gap,
        );
        if (rec != null) recommendations.add(rec);
      }

      // 8. ترتيب التوصيات حسب الأولوية والثقة
      recommendations.sort((a, b) {
        final scoreA = a.priority * a.confidence;
        final scoreB = b.priority * b.confidence;
        return scoreB.compareTo(scoreA);
      });

      // 9. حفظ التوصيات في Firestore
      for (final rec in recommendations.take(criteriaToUse.limit)) {
        await _saveRecommendation(rec);
      }

      return recommendations.take(criteriaToUse.limit).toList();
    } catch (e, stackTrace) {
      logger.e('Error generating recommendations', error: e, stackTrace: stackTrace);
      return [];
    }
  }

  /// جلب تقدم المستخدم
  Future<UserCourseProgress?> _getUserProgress(
    String userId,
    String courseId,
  ) async {
    try {
      final doc = await _firestore
          .collection('user_course_progress')
          .doc('${userId}_$courseId')
          .get();

      if (!doc.exists) return null;
      return UserCourseProgress.fromJson(doc.data()!);
    } catch (e) {
      logger.w('Error fetching user progress', error: e);
      return null;
    }
  }

  /// جلب درجات الاختبارات
  Future<List<Map<String, dynamic>>> _getQuizScores(
    String userId,
    String courseId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('quiz_submissions')
          .where('userId', isEqualTo: userId)
          .where('courseId', isEqualTo: courseId)
          .orderBy('submittedAt', descending: true)
          .limit(20)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      logger.w('Error fetching quiz scores', error: e);
      return [];
    }
  }

  /// جلب المحتوى المكتمل
  Future<List<String>> _getCompletedContent(
    String userId,
    String courseId,
  ) async {
    try {
      // يمكن تحسين هذا بناءً على هيكل البيانات الفعلي
      return [];
    } catch (e) {
      return [];
    }
  }

  /// تحديد المواضيع الضعيفة
  List<String> _identifyWeakTopics(List<Map<String, dynamic>> quizScores) {
    final topicScores = <String, List<double>>{};

    for (final quiz in quizScores) {
      final topic = quiz['topic'] as String? ?? 'general';
      final score = (quiz['score'] as num?)?.toDouble() ?? 0.0;

      topicScores.putIfAbsent(topic, () => []).add(score);
    }

    // حساب المتوسط لكل موضوع
    final weakTopics = <String>[];
    topicScores.forEach((topic, scores) {
      final avg = scores.reduce((a, b) => a + b) / scores.length;
      if (avg < 70.0) {
        // أقل من 70% يعتبر ضعيف
        weakTopics.add(topic);
      }
    });

    return weakTopics;
  }

  /// إنشاء توصية مراجعة
  Future<Recommendation?> _createReviewRecommendation({
    required String userId,
    required String courseId,
    required String topic,
    required int priority,
  }) async {
    try {
      // البحث عن محتوى مراجعة مناسب
      final content = await _findReviewContent(courseId, topic);
      if (content == null) return null;

      return Recommendation(
        id: _generateId(),
        userId: userId,
        courseId: courseId,
        type: RecommendationType.review,
        reason: RecommendationReason.weakPerformance,
        contentId: content['id'] as String,
        contentTitle: content['title'] as String,
        description: 'يُنصح بمراجعة هذا الموضوع لتحسين الأداء',
        priority: priority,
        confidence: 0.85,
        estimatedMinutes: content['duration'] as int? ?? 30,
        difficulty: 'مراجعة',
        createdAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(days: 7)),
      );
    } catch (e) {
      logger.w('Error creating review recommendation', error: e);
      return null;
    }
  }

  /// اقتراح الخطوة التالية
  Future<Recommendation?> _suggestNextStep({
    required String userId,
    required String courseId,
    required List<String> completedContent,
  }) async {
    try {
      // البحث عن الدرس/الوحدة التالية المنطقية
      final nextContent = await _findNextLogicalContent(
        courseId,
        completedContent,
      );
      
      if (nextContent == null) return null;

      return Recommendation(
        id: _generateId(),
        userId: userId,
        courseId: courseId,
        type: _mapContentType(nextContent['type'] as String),
        reason: RecommendationReason.nextStep,
        contentId: nextContent['id'] as String,
        contentTitle: nextContent['title'] as String,
        description: 'الخطوة التالية في مسار التعلم الخاص بك',
        priority: 80,
        confidence: 0.9,
        estimatedMinutes: nextContent['duration'] as int? ?? 45,
        difficulty: nextContent['difficulty'] as String? ?? 'متوسط',
        createdAt: DateTime.now(),
      );
    } catch (e) {
      return null;
    }
  }

  /// جلب المحتوى الشائع بين الأقران
  Future<List<Map<String, dynamic>>> _getPopularContent({
    required String courseId,
    required List<String> excludeIds,
    required int limit,
  }) async {
    try {
      // يمكن تحسين هذا بحساب شعبية المحتوى من analytics
      return [];
    } catch (e) {
      return [];
    }
  }

  /// إنشاء توصية بناءً على الشعبية
  Future<Recommendation?> _createPopularRecommendation({
    required String userId,
    required String courseId,
    required Map<String, dynamic> content,
  }) async {
    return Recommendation(
      id: _generateId(),
      userId: userId,
      courseId: courseId,
      type: _mapContentType(content['type'] as String? ?? 'lesson'),
      reason: RecommendationReason.popularWithPeers,
      contentId: content['id'] as String,
      contentTitle: content['title'] as String,
      description: 'محتوى شائع بين زملائك في الكورس',
      priority: 60,
      confidence: 0.7,
      estimatedMinutes: content['duration'] as int? ?? 40,
      createdAt: DateTime.now(),
    );
  }

  /// تحديد فجوات المهارات
  Future<List<String>> _identifySkillGaps(
    String userId,
    String courseId,
    UserCourseProgress? progress,
  ) async {
    try {
      // تحليل المهارات المفقودة بناءً على التقدم
      return [];
    } catch (e) {
      return [];
    }
  }

  /// إنشاء توصية لسد فجوة مهارة
  Future<Recommendation?> _createSkillGapRecommendation({
    required String userId,
    required String courseId,
    required String skill,
  }) async {
    return null; // يمكن تطويره لاحقاً
  }

  /// البحث عن محتوى مراجعة
  Future<Map<String, dynamic>?> _findReviewContent(
    String courseId,
    String topic,
  ) async {
    try {
      // يمكن البحث في collection الدروس
      return null;
    } catch (e) {
      return null;
    }
  }

  /// البحث عن المحتوى التالي المنطقي
  Future<Map<String, dynamic>?> _findNextLogicalContent(
    String courseId,
    List<String> completedIds,
  ) async {
    try {
      // البحث عن أول محتوى غير مكتمل في الترتيب
      return null;
    } catch (e) {
      return null;
    }
  }

  /// حفظ التوصية
  Future<void> _saveRecommendation(Recommendation rec) async {
    try {
      await _firestore
          .collection('recommendations')
          .doc(rec.id)
          .set(rec.toJson());
    } catch (e) {
      logger.e('Error saving recommendation', error: e);
    }
  }

  /// تحديث حالة التوصية
  Future<void> updateRecommendationStatus({
    required String recommendationId,
    bool? isViewed,
    bool? isAccepted,
    bool? isDismissed,
    bool? isCompleted,
  }) async {
    try {
      final updates = <String, dynamic>{};
      
      if (isViewed != null) {
        updates['isViewed'] = isViewed;
        updates['viewedAt'] = FieldValue.serverTimestamp();
      }
      
      if (isAccepted != null) {
        updates['isAccepted'] = isAccepted;
        updates['acceptedAt'] = FieldValue.serverTimestamp();
      }
      
      if (isDismissed != null) {
        updates['isDismissed'] = isDismissed;
      }
      
      if (isCompleted != null) {
        updates['isCompleted'] = isCompleted;
      }

      await _firestore
          .collection('recommendations')
          .doc(recommendationId)
          .update(updates);
    } catch (e) {
      logger.e('Error updating recommendation status', error: e);
    }
  }

  /// جلب التوصيات النشطة للمستخدم
  Stream<List<Recommendation>> streamActiveRecommendations({
    required String userId,
    required String courseId,
  }) {
    return _firestore
        .collection('recommendations')
        .where('userId', isEqualTo: userId)
        .where('courseId', isEqualTo: courseId)
        .where('isDismissed', isEqualTo: false)
        .where('isCompleted', isEqualTo: false)
        .orderBy('priority', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Recommendation.fromJson(doc.data()))
          .toList();
    });
  }

  /// حساب إحصائيات التوصيات
  Future<RecommendationStats> getRecommendationStats({
    required String userId,
    required String courseId,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('recommendations')
          .where('userId', isEqualTo: userId)
          .where('courseId', isEqualTo: courseId)
          .get();

      final recommendations =
          snapshot.docs.map((doc) => Recommendation.fromJson(doc.data())).toList();

      final total = recommendations.length;
      final viewed = recommendations.where((r) => r.isViewed).length;
      final accepted = recommendations.where((r) => r.isAccepted).length;
      final dismissed = recommendations.where((r) => r.isDismissed).length;
      final completed = recommendations.where((r) => r.isCompleted).length;

      return RecommendationStats(
        totalRecommendations: total,
        viewedRecommendations: viewed,
        acceptedRecommendations: accepted,
        dismissedRecommendations: dismissed,
        completedRecommendations: completed,
        acceptanceRate: total > 0 ? accepted / total : 0.0,
        completionRate: accepted > 0 ? completed / accepted : 0.0,
        avgConfidence: total > 0
            ? recommendations.map((r) => r.confidence).reduce((a, b) => a + b) /
                total
            : 0.5,
      );
    } catch (e) {
      logger.e('Error calculating recommendation stats', error: e);
      return const RecommendationStats();
    }
  }

  /// توليد ID فريد
  String _generateId() {
    return _firestore.collection('recommendations').doc().id;
  }

  /// تحويل نوع المحتوى
  RecommendationType _mapContentType(String type) {
    switch (type.toLowerCase()) {
      case 'lesson':
        return RecommendationType.lesson;
      case 'quiz':
        return RecommendationType.quiz;
      case 'assignment':
        return RecommendationType.assignment;
      case 'module':
        return RecommendationType.module;
      default:
        return RecommendationType.lesson;
    }
  }
}
