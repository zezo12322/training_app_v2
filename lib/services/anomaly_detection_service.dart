import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/anomaly.dart';
import '../core/logging.dart';

/// خدمة الكشف عن الشذوذ
/// 
/// ملاحظة: هذه نسخة محاكاة بخوارزميات إحصائية بسيطة
/// في الإنتاج: استخدم TensorFlow Lite أو ML Kit
class AnomalyDetectionService {
  final FirebaseFirestore _firestore;

  AnomalyDetectionService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// الكشف عن الشذوذ في درجات الاختبارات
  Future<List<AnomalyScore>> detectUnusualQuizScores({
    required String userId,
    required String quizId,
    required double score,
    required double percentage,
    required int timeSpentSeconds,
    required String institutionId,
    String? companyId,
  }) async {
    final anomalies = <AnomalyScore>[];
    
    try {
      // الحصول على نمط السلوك
      final pattern = await _getBehaviorPattern(userId, institutionId);
      
      if (pattern == null || pattern.totalQuizzesTaken < 3) {
        // لا توجد بيانات كافية
        return [];
      }

      // الكشف عن درجة غير طبيعية (عالية جداً مقارنة بالمتوسط)
      final scoreDiff = percentage - pattern.avgQuizScore;
      final stdDevThreshold = pattern.quizScoreStdDev * 2.5; // 2.5 انحراف معياري
      
      if (scoreDiff > stdDevThreshold && percentage > 90) {
        final anomalyScore = _calculateAnomalyScore(
          scoreDiff / 100,
          stdDevThreshold / 100,
        );
        
        anomalies.add(AnomalyScore(
          id: _firestore.collection('anomalies').doc().id,
          userId: userId,
          userName: 'User', // يجب جلب الاسم
          institutionId: institutionId,
          companyId: companyId,
          type: AnomalyType.unusualQuizScore,
          severity: _determineSeverity(anomalyScore),
          score: anomalyScore,
          confidenceLevel: 0.8,
          metadata: {
            'quizId': quizId,
            'score': score,
            'percentage': percentage,
            'avgScore': pattern.avgQuizScore,
            'scoreDiff': scoreDiff,
            'stdDev': pattern.quizScoreStdDev,
          },
          relatedEntityId: quizId,
          relatedEntityType: 'quiz',
          description: 'درجة اختبار غير طبيعية',
          reason: 'الدرجة أعلى بكثير من المتوسط (${scoreDiff.toStringAsFixed(1)}%)',
          evidencePoints: [
            'الدرجة: ${percentage.toStringAsFixed(1)}%',
            'المتوسط: ${pattern.avgQuizScore.toStringAsFixed(1)}%',
            'الفرق: ${scoreDiff.toStringAsFixed(1)}%',
            'عدد الاختبارات السابقة: ${pattern.totalQuizzesTaken}',
          ],
          status: InvestigationStatus.pending,
          detectedAt: DateTime.now(),
        ));
      }

      // الكشف عن إكمال سريع جداً
      final avgTime = pattern.avgQuizCompletionTime * 60; // تحويل لثواني
      if (avgTime > 0 && timeSpentSeconds < avgTime * 0.3) {
        // أقل من 30% من الوقت المعتاد
        final timeRatio = timeSpentSeconds / avgTime;
        final anomalyScore = _calculateAnomalyScore(1 - timeRatio, 0.7);
        
        anomalies.add(AnomalyScore(
          id: _firestore.collection('anomalies').doc().id,
          userId: userId,
          userName: 'User',
          institutionId: institutionId,
          companyId: companyId,
          type: AnomalyType.rapidProgress,
          severity: _determineSeverity(anomalyScore),
          score: anomalyScore,
          confidenceLevel: 0.75,
          metadata: {
            'quizId': quizId,
            'timeSpent': timeSpentSeconds,
            'avgTime': avgTime,
            'timeRatio': timeRatio,
          },
          relatedEntityId: quizId,
          relatedEntityType: 'quiz',
          description: 'إكمال الاختبار بسرعة غير طبيعية',
          reason: 'الوقت المستغرق ${(timeSpentSeconds / 60).toStringAsFixed(1)} دقيقة (المعتاد ${pattern.avgQuizCompletionTime.toStringAsFixed(1)} دقيقة)',
          evidencePoints: [
            'الوقت المستغرق: ${(timeSpentSeconds / 60).toStringAsFixed(1)} دقيقة',
            'المتوسط: ${pattern.avgQuizCompletionTime.toStringAsFixed(1)} دقيقة',
            'النسبة: ${(timeRatio * 100).toStringAsFixed(0)}% من الوقت المعتاد',
          ],
          status: InvestigationStatus.pending,
          detectedAt: DateTime.now(),
        ));
      }

      // حفظ الشذوذات
      for (final anomaly in anomalies) {
        await _saveAnomaly(anomaly);
      }
      
      return anomalies;
    } catch (e) {
      logger.e('Error detecting quiz anomalies', error: e);
      return [];
    }
  }

  /// الكشف عن تسجيل دخول مشبوه
  Future<List<AnomalyScore>> detectSuspiciousLogin({
    required String userId,
    required String deviceId,
    required String ipAddress,
    required String institutionId,
    String? companyId,
  }) async {
    final anomalies = <AnomalyScore>[];
    
    try {
      // الحصول على نمط السلوك
      final pattern = await _getBehaviorPattern(userId, institutionId);
      
      if (pattern == null) return [];

      // الكشف عن جهاز جديد
      if (!pattern.commonDevices.contains(deviceId)) {
        anomalies.add(AnomalyScore(
          id: _firestore.collection('anomalies').doc().id,
          userId: userId,
          userName: 'User',
          institutionId: institutionId,
          companyId: companyId,
          type: AnomalyType.suspiciousLogin,
          severity: AnomalySeverity.medium,
          score: 0.6,
          confidenceLevel: 0.7,
          metadata: {
            'deviceId': deviceId,
            'ipAddress': ipAddress,
            'commonDevices': pattern.commonDevices,
          },
          description: 'تسجيل دخول من جهاز جديد',
          reason: 'الجهاز غير مألوف',
          evidencePoints: [
            'معرف الجهاز: $deviceId',
            'عدد الأجهزة المعتادة: ${pattern.commonDevices.length}',
          ],
          status: InvestigationStatus.pending,
          detectedAt: DateTime.now(),
        ));
      }

      // الكشف عن موقع جديد (IP)
      final ipRegion = _getRegionFromIP(ipAddress);
      if (!pattern.commonLocations.contains(ipRegion)) {
        anomalies.add(AnomalyScore(
          id: _firestore.collection('anomalies').doc().id,
          userId: userId,
          userName: 'User',
          institutionId: institutionId,
          companyId: companyId,
          type: AnomalyType.suspiciousLogin,
          severity: AnomalySeverity.medium,
          score: 0.65,
          confidenceLevel: 0.65,
          metadata: {
            'ipAddress': ipAddress,
            'region': ipRegion,
            'commonLocations': pattern.commonLocations,
          },
          description: 'تسجيل دخول من موقع جديد',
          reason: 'الموقع غير مألوف',
          evidencePoints: [
            'المنطقة: $ipRegion',
            'عدد المواقع المعتادة: ${pattern.commonLocations.length}',
          ],
          status: InvestigationStatus.pending,
          detectedAt: DateTime.now(),
        ));
      }

      // حفظ الشذوذات
      for (final anomaly in anomalies) {
        await _saveAnomaly(anomaly);
      }
      
      return anomalies;
    } catch (e) {
      logger.e('Error detecting login anomalies', error: e);
      return [];
    }
  }

  /// الكشف عن أجهزة متعددة
  Future<List<AnomalyScore>> detectMultipleDevices({
    required String userId,
    required String institutionId,
    String? companyId,
  }) async {
    try {
      // جلب آخر 24 ساعة من الأنشطة
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));
      
      final snapshot = await _firestore
          .collection('activity_events')
          .where('userId', isEqualTo: userId)
          .where('timestamp', isGreaterThan: Timestamp.fromDate(yesterday))
          .get();

      final devices = snapshot.docs
          .map((doc) => doc.data()['deviceId'] as String?)
          .whereType<String>()
          .toSet();

      if (devices.length > 3) {
        // أكثر من 3 أجهزة في 24 ساعة
        final anomalyScore = min(devices.length / 10.0, 1.0);
        
        final anomaly = AnomalyScore(
          id: _firestore.collection('anomalies').doc().id,
          userId: userId,
          userName: 'User',
          institutionId: institutionId,
          companyId: companyId,
          type: AnomalyType.multipleDevices,
          severity: _determineSeverity(anomalyScore),
          score: anomalyScore,
          confidenceLevel: 0.85,
          metadata: {
            'deviceCount': devices.length,
            'devices': devices.toList(),
            'timeWindow': '24 hours',
          },
          description: 'استخدام أجهزة متعددة',
          reason: '${devices.length} أجهزة مختلفة في 24 ساعة',
          evidencePoints: [
            'عدد الأجهزة: ${devices.length}',
            'الفترة: 24 ساعة',
            'معدل الأجهزة المعتاد: 1-2',
          ],
          status: InvestigationStatus.pending,
          detectedAt: DateTime.now(),
        );

        await _saveAnomaly(anomaly);
        return [anomaly];
      }

      return [];
    } catch (e) {
      logger.e('Error detecting multiple devices', error: e);
      return [];
    }
  }

  /// الكشف عن تقدم سريع
  Future<List<AnomalyScore>> detectRapidProgress({
    required String userId,
    required String courseId,
    required double progressChange,
    required int minutesElapsed,
    required String institutionId,
    String? companyId,
  }) async {
    try {
      // التقدم السريع: أكثر من 20% في أقل من 30 دقيقة
      if (progressChange > 20 && minutesElapsed < 30) {
        final anomalyScore = min(progressChange / 50.0, 1.0);
        
        final anomaly = AnomalyScore(
          id: _firestore.collection('anomalies').doc().id,
          userId: userId,
          userName: 'User',
          institutionId: institutionId,
          companyId: companyId,
          type: AnomalyType.rapidProgress,
          severity: _determineSeverity(anomalyScore),
          score: anomalyScore,
          confidenceLevel: 0.75,
          metadata: {
            'courseId': courseId,
            'progressChange': progressChange,
            'minutesElapsed': minutesElapsed,
          },
          relatedEntityId: courseId,
          relatedEntityType: 'course',
          description: 'تقدم سريع جداً في الدورة',
          reason: 'تقدم ${progressChange.toStringAsFixed(1)}% في $minutesElapsed دقيقة',
          evidencePoints: [
            'التقدم: ${progressChange.toStringAsFixed(1)}%',
            'الوقت: $minutesElapsed دقيقة',
            'المعدل: ${(progressChange / minutesElapsed).toStringAsFixed(2)}% / دقيقة',
          ],
          status: InvestigationStatus.pending,
          detectedAt: DateTime.now(),
        );

        await _saveAnomaly(anomaly);
        return [anomaly];
      }

      return [];
    } catch (e) {
      logger.e('Error detecting rapid progress', error: e);
      return [];
    }
  }

  /// حساب درجة الشذوذ
  double _calculateAnomalyScore(double deviation, double threshold) {
    if (threshold == 0) return 0.5;
    final score = min(deviation / threshold, 1.0);
    return max(score, 0.0);
  }

  /// تحديد مستوى الخطورة
  AnomalySeverity _determineSeverity(double score) {
    if (score >= 0.9) return AnomalySeverity.critical;
    if (score >= 0.7) return AnomalySeverity.high;
    if (score >= 0.5) return AnomalySeverity.medium;
    return AnomalySeverity.low;
  }

  /// الحصول على نمط السلوك
  Future<BehaviorPattern?> _getBehaviorPattern(
    String userId,
    String institutionId,
  ) async {
    try {
      final doc = await _firestore
          .collection('behavior_patterns')
          .doc(userId)
          .get();

      if (!doc.exists) return null;

      return BehaviorPattern.fromJson(doc.data()!);
    } catch (e) {
      logger.e('Error getting behavior pattern', error: e);
      return null;
    }
  }

  /// حفظ الشذوذ
  Future<void> _saveAnomaly(AnomalyScore anomaly) async {
    try {
      await _firestore
          .collection('anomalies')
          .doc(anomaly.id)
          .set(anomaly.toJson());

      // إنشاء تنبيه إذا كانت الخطورة عالية
      if (anomaly.severity == AnomalySeverity.high ||
          anomaly.severity == AnomalySeverity.critical) {
        await _createAlert(anomaly);
      }
    } catch (e) {
      logger.e('Error saving anomaly', error: e);
    }
  }

  /// إنشاء تنبيه
  Future<void> _createAlert(AnomalyScore anomaly) async {
    try {
      // جلب الإعدادات للحصول على المستلمين
      final settings = await getSettings(anomaly.institutionId);
      
      if (settings == null || !settings.sendAlerts) return;

      final alert = AnomalyAlert(
        id: _firestore.collection('anomaly_alerts').doc().id,
        anomalyId: anomaly.id,
        institutionId: anomaly.institutionId,
        companyId: anomaly.companyId,
        title: 'تنبيه شذوذ: ${_getTypeLabel(anomaly.type)}',
        message: anomaly.description,
        severity: anomaly.severity,
        recipientIds: settings.alertRecipients,
        isRead: false,
        isDismissed: false,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('anomaly_alerts')
          .doc(alert.id)
          .set(alert.toJson());
    } catch (e) {
      logger.e('Error creating alert', error: e);
    }
  }

  /// الحصول على تسمية النوع
  String _getTypeLabel(AnomalyType type) {
    switch (type) {
      case AnomalyType.suspiciousLogin:
        return 'تسجيل دخول مشبوه';
      case AnomalyType.unusualQuizScore:
        return 'درجة اختبار غير طبيعية';
      case AnomalyType.rapidProgress:
        return 'تقدم سريع';
      case AnomalyType.multipleDevices:
        return 'أجهزة متعددة';
      case AnomalyType.unusualActivity:
        return 'نشاط غير معتاد';
      case AnomalyType.cheatingPattern:
        return 'نمط غش';
      case AnomalyType.accountSharing:
        return 'مشاركة حساب';
    }
  }

  /// استخراج المنطقة من IP (محاكاة)
  String _getRegionFromIP(String ipAddress) {
    // في الإنتاج: استخدم GeoIP API
    return ipAddress.split('.').first;
  }

  /// حفظ/تحديث الإعدادات
  Future<bool> saveSettings(AnomalyDetectionSettings settings) async {
    try {
      await _firestore
          .collection('anomaly_settings')
          .doc(settings.institutionId)
          .set(settings.toJson());
      return true;
    } catch (e) {
      logger.e('Error saving settings', error: e);
      return false;
    }
  }

  /// جلب الإعدادات
  Future<AnomalyDetectionSettings?> getSettings(String institutionId) async {
    try {
      final doc = await _firestore
          .collection('anomaly_settings')
          .doc(institutionId)
          .get();

      if (!doc.exists) return null;

      return AnomalyDetectionSettings.fromJson(doc.data()!);
    } catch (e) {
      logger.e('Error getting settings', error: e);
      return null;
    }
  }

  /// جلب الشذوذات
  Stream<List<AnomalyScore>> getAnomalies(
    String institutionId, {
    InvestigationStatus? status,
    AnomalySeverity? severity,
  }) {
    var query = _firestore
        .collection('anomalies')
        .where('institutionId', isEqualTo: institutionId)
        .orderBy('detectedAt', descending: true)
        .limit(100);

    if (status != null) {
      query = query.where('status', isEqualTo: status.toString());
    }

    if (severity != null) {
      query = query.where('severity', isEqualTo: severity.toString());
    }

    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => AnomalyScore.fromJson(doc.data())).toList());
  }

  /// جلب التنبيهات
  Stream<List<AnomalyAlert>> getAlerts(String institutionId) {
    return _firestore
        .collection('anomaly_alerts')
        .where('institutionId', isEqualTo: institutionId)
        .where('isDismissed', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => AnomalyAlert.fromJson(doc.data())).toList());
  }

  /// مراجعة شذوذ
  Future<bool> reviewAnomaly({
    required String anomalyId,
    required InvestigationStatus status,
    required String reviewedBy,
    required String reviewerName,
    String? notes,
  }) async {
    try {
      await _firestore.collection('anomalies').doc(anomalyId).update({
        'status': status.toString(),
        'isReviewed': true,
        'reviewedBy': reviewedBy,
        'reviewerName': reviewerName,
        'reviewedAt': Timestamp.now(),
        'reviewNotes': notes,
        if (status == InvestigationStatus.resolved ||
            status == InvestigationStatus.confirmed)
          'resolvedAt': Timestamp.now(),
      });
      return true;
    } catch (e) {
      logger.e('Error reviewing anomaly', error: e);
      return false;
    }
  }
}
