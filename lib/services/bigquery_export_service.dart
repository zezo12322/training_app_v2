import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/bigquery_export.dart';
import '../models/user_model.dart';
import '../models/course.dart';
import '../core/logging.dart';

/// خدمة تصدير BigQuery
/// 
/// ملاحظة: هذه نسخة محاكاة - في الإنتاج يجب:
/// 1. إضافة googleapis package
/// 2. إعداد Service Account credentials
/// 3. تنفيذ الرفع الفعلي إلى BigQuery
class BigQueryExportService {
  final FirebaseFirestore _firestore;

  BigQueryExportService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// بدء عملية تصدير
  Future<BigQueryExport> startExport({
    required ExportType exportType,
    required String institutionId,
    String? companyId,
    required String userId,
    required String userName,
    required BigQueryConfig config,
  }) async {
    final exportId = _firestore.collection('bigquery_exports').doc().id;
    
    final schema = BigQuerySchemas.getSchema(exportType);
    if (schema == null && exportType != ExportType.all) {
      throw Exception('Schema not found for export type: $exportType');
    }

    final export = BigQueryExport(
      id: exportId,
      institutionId: institutionId,
      companyId: companyId,
      exportType: exportType,
      status: ExportStatus.pending,
      frequency: ExportFrequency.manual,
      projectId: config.projectId,
      datasetId: config.datasetId,
      tableId: schema?.tableName ?? 'all_data',
      totalRecords: 0,
      exportedRecords: 0,
      failedRecords: 0,
      triggeredBy: userId,
      triggeredByName: userName,
      startedAt: DateTime.now(),
    );

    // حفظ سجل التصدير
    await _firestore
        .collection('bigquery_exports')
        .doc(exportId)
        .set(export.toJson());

    // بدء المعالجة في الخلفية
    _processExport(export, config);

    return export;
  }

  /// معالجة التصدير
  Future<void> _processExport(
    BigQueryExport export,
    BigQueryConfig config,
  ) async {
    try {
      // تحديث الحالة
      await _updateExportStatus(export.id, ExportStatus.processing);

      List<Map<String, dynamic>> data;
      
      // جمع البيانات حسب النوع
      if (export.exportType == ExportType.all) {
        data = await _exportAllData(export.institutionId, export.companyId);
      } else {
        data = await _exportDataByType(
          export.exportType,
          export.institutionId,
          export.companyId,
        );
      }

      // تحديث إجمالي السجلات
      await _updateTotalRecords(export.id, data.length);

      // تحديث الحالة للرفع
      await _updateExportStatus(export.id, ExportStatus.uploading);

      // رفع البيانات (محاكاة)
      // في الإنتاج: استخدام BigQuery API
      await _uploadToBigQuery(export, data, config);

      // تحديث الحالة للاكتمال
      await _updateExportStatus(
        export.id,
        ExportStatus.completed,
        completedAt: DateTime.now(),
        exportedRecords: data.length,
      );

      logger.i('Export completed: ${export.id}');
    } catch (e, stackTrace) {
      logger.e('Export failed', error: e, stackTrace: stackTrace);
      
      await _updateExportStatus(
        export.id,
        ExportStatus.failed,
        errors: [e.toString()],
        completedAt: DateTime.now(),
      );
    }
  }

  /// تصدير جميع البيانات
  Future<List<Map<String, dynamic>>> _exportAllData(
    String institutionId,
    String? companyId,
  ) async {
    final allData = <Map<String, dynamic>>[];

    for (final type in ExportType.values) {
      if (type == ExportType.all) continue;
      
      try {
        final data = await _exportDataByType(type, institutionId, companyId);
        allData.addAll(data);
      } catch (e) {
        logger.w('Error exporting $type: $e');
      }
    }

    return allData;
  }

  /// تصدير البيانات حسب النوع
  Future<List<Map<String, dynamic>>> _exportDataByType(
    ExportType type,
    String institutionId,
    String? companyId,
  ) async {
    switch (type) {
      case ExportType.users:
        return await _exportUsers(institutionId, companyId);
      case ExportType.courses:
        return await _exportCourses(institutionId);
      case ExportType.enrollments:
        return await _exportEnrollments(institutionId, companyId);
      case ExportType.quizResults:
        return await _exportQuizResults(institutionId, companyId);
      case ExportType.certificates:
        return await _exportCertificates(institutionId, companyId);
      case ExportType.gamification:
        return await _exportGamification(institutionId, companyId);
      default:
        return [];
    }
  }

  /// تصدير المستخدمين
  Future<List<Map<String, dynamic>>> _exportUsers(
    String institutionId,
    String? companyId,
  ) async {
    var query = _firestore
        .collection('users')
        .where('institutionId', isEqualTo: institutionId);

    if (companyId != null) {
      query = query.where('companyId', isEqualTo: companyId);
    }

    final snapshot = await query.get();
    
    return snapshot.docs.map((doc) {
      final user = AppUser.fromDoc(doc);
      return {
        'user_id': user.id,
        'email': user.email,
        'name': user.name,
        'role': user.role,
        'institution_id': user.institutionId ?? '',
        'company_id': user.companyId,
        'created_at': user.createdAt?.toIso8601String(),
        'last_login_at': null, // الحقل غير موجود في النموذج
      };
    }).toList();
  }

  /// تصدير الدورات
  Future<List<Map<String, dynamic>>> _exportCourses(
    String institutionId,
  ) async {
    final snapshot = await _firestore
        .collection('courses')
        .get(); // لا يوجد institutionId في Course

    return snapshot.docs.map((doc) {
      final course = Course.fromDoc(doc);
      final data = doc.data();
      return {
        'course_id': course.id,
        'title': course.name, // استخدام name بدلاً من title
        'description': data['description'], // من البيانات الخام
        'category': data['category'],
        'level': data['level'],
        'duration_hours': data['durationHours'],
        'instructor_id': course.trainerId,
        'institution_id': data['institutionId'],
        'created_at': course.createdAt?.toIso8601String(),
      };
    }).toList();
  }

  /// تصدير التسجيلات
  Future<List<Map<String, dynamic>>> _exportEnrollments(
    String institutionId,
    String? companyId,
  ) async {
    // الحصول على المستخدمين أولاً
    var userQuery = _firestore
        .collection('users')
        .where('institutionId', isEqualTo: institutionId);

    if (companyId != null) {
      userQuery = userQuery.where('companyId', isEqualTo: companyId);
    }

    final userDocs = await userQuery.get();
    final userIds = userDocs.docs.map((d) => d.id).toList();

    final enrollments = <Map<String, dynamic>>[];

    // جمع التسجيلات لكل مستخدم
    for (final userId in userIds) {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('enrollments')
          .get();

      for (final doc in snapshot.docs) {
        final data = doc.data();
        enrollments.add({
          'enrollment_id': doc.id,
          'user_id': userId,
          'course_id': data['courseId'],
          'enrolled_at': (data['enrolledAt'] as Timestamp).toDate().toIso8601String(),
          'completed_at': data['completedAt'] != null
              ? (data['completedAt'] as Timestamp).toDate().toIso8601String()
              : null,
          'progress_percentage': data['progressPercentage'] ?? 0.0,
          'status': data['status'] ?? 'active',
        });
      }
    }

    return enrollments;
  }

  /// تصدير نتائج الاختبارات
  Future<List<Map<String, dynamic>>> _exportQuizResults(
    String institutionId,
    String? companyId,
  ) async {
    // الحصول على المستخدمين
    var userQuery = _firestore
        .collection('users')
        .where('institutionId', isEqualTo: institutionId);

    if (companyId != null) {
      userQuery = userQuery.where('companyId', isEqualTo: companyId);
    }

    final userDocs = await userQuery.get();
    final userIds = userDocs.docs.map((d) => d.id).toList();

    final results = <Map<String, dynamic>>[];

    // جمع النتائج لكل مستخدم
    for (final userId in userIds) {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('quiz_results')
          .get();

      for (final doc in snapshot.docs) {
        final data = doc.data();
        results.add({
          'result_id': doc.id,
          'user_id': userId,
          'quiz_id': data['quizId'],
          'course_id': data['courseId'],
          'score': (data['score'] ?? 0).toDouble(),
          'max_score': (data['maxScore'] ?? 0).toDouble(),
          'percentage': (data['percentage'] ?? 0.0).toDouble(),
          'passed': data['passed'] ?? false,
          'completed_at': (data['completedAt'] as Timestamp).toDate().toIso8601String(),
          'time_spent_seconds': data['timeSpentSeconds'],
        });
      }
    }

    return results;
  }

  /// تصدير الشهادات
  Future<List<Map<String, dynamic>>> _exportCertificates(
    String institutionId,
    String? companyId,
  ) async {
    var query = _firestore
        .collection('certificates')
        .where('institutionId', isEqualTo: institutionId);

    if (companyId != null) {
      query = query.where('companyId', isEqualTo: companyId);
    }

    final snapshot = await query.get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'certificate_id': doc.id,
        'user_id': data['userId'],
        'course_id': data['courseId'],
        'certificate_number': data['certificateNumber'],
        'issued_at': (data['issuedAt'] as Timestamp).toDate().toIso8601String(),
        'verification_code': data['verificationCode'],
      };
    }).toList();
  }

  /// تصدير بيانات النقاط والإنجازات
  Future<List<Map<String, dynamic>>> _exportGamification(
    String institutionId,
    String? companyId,
  ) async {
    // الحصول على المستخدمين
    var userQuery = _firestore
        .collection('users')
        .where('institutionId', isEqualTo: institutionId);

    if (companyId != null) {
      userQuery = userQuery.where('companyId', isEqualTo: companyId);
    }

    final userDocs = await userQuery.get();
    final userIds = userDocs.docs.map((d) => d.id).toList();

    final records = <Map<String, dynamic>>[];

    // جمع سجلات النقاط
    for (final userId in userIds) {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('points_history')
          .get();

      for (final doc in snapshot.docs) {
        final data = doc.data();
        records.add({
          'record_id': doc.id,
          'user_id': userId,
          'event_type': data['eventType'] ?? 'unknown',
          'points_earned': data['pointsEarned'],
          'total_points': data['totalPoints'],
          'achievement_id': data['achievementId'],
          'occurred_at': (data['timestamp'] as Timestamp).toDate().toIso8601String(),
        });
      }
    }

    return records;
  }

  /// رفع البيانات إلى BigQuery (محاكاة)
  Future<void> _uploadToBigQuery(
    BigQueryExport export,
    List<Map<String, dynamic>> data,
    BigQueryConfig config,
  ) async {
    // في الإنتاج، استخدم:
    // 1. googleapis package
    // 2. BigQuery API
    // 3. Service Account credentials من config.credentialsJson
    
    // محاكاة التأخير للرفع
    await Future.delayed(const Duration(seconds: 2));
    
    // حفظ البيانات محلياً للمراجعة (اختياري)
    for (var i = 0; i < data.length; i++) {
      await _updateExportProgress(export.id, i + 1);
      
      // محاكاة بعض الفشل (5%)
      if (i % 20 == 0 && i > 0) {
        await _incrementFailedRecords(export.id);
      }
    }

    logger.i('Uploaded ${data.length} records to BigQuery (simulated)');
  }

  /// تحديث حالة التصدير
  Future<void> _updateExportStatus(
    String exportId,
    ExportStatus status, {
    DateTime? completedAt,
    List<String>? errors,
    int? exportedRecords,
  }) async {
    final updates = <String, dynamic>{
      'status': status.toString(),
    };

    if (completedAt != null) {
      updates['completedAt'] = Timestamp.fromDate(completedAt);
    }
    if (errors != null) {
      updates['errors'] = errors;
    }
    if (exportedRecords != null) {
      updates['exportedRecords'] = exportedRecords;
    }

    await _firestore
        .collection('bigquery_exports')
        .doc(exportId)
        .update(updates);
  }

  /// تحديث إجمالي السجلات
  Future<void> _updateTotalRecords(String exportId, int total) async {
    await _firestore
        .collection('bigquery_exports')
        .doc(exportId)
        .update({'totalRecords': total});
  }

  /// تحديث التقدم
  Future<void> _updateExportProgress(String exportId, int exported) async {
    await _firestore
        .collection('bigquery_exports')
        .doc(exportId)
        .update({'exportedRecords': exported});
  }

  /// زيادة عدد السجلات الفاشلة
  Future<void> _incrementFailedRecords(String exportId) async {
    await _firestore
        .collection('bigquery_exports')
        .doc(exportId)
        .update({
      'failedRecords': FieldValue.increment(1),
    });
  }

  /// حفظ إعدادات BigQuery
  Future<bool> saveConfig(BigQueryConfig config) async {
    try {
      await _firestore
          .collection('bigquery_configs')
          .doc(config.institutionId)
          .set(config.toJson());
      return true;
    } catch (e) {
      logger.e('Error saving BigQuery config', error: e);
      return false;
    }
  }

  /// جلب إعدادات BigQuery
  Future<BigQueryConfig?> getConfig(String institutionId) async {
    try {
      final doc = await _firestore
          .collection('bigquery_configs')
          .doc(institutionId)
          .get();

      if (!doc.exists) return null;

      return BigQueryConfig.fromJson(doc.data()!);
    } catch (e) {
      logger.e('Error fetching BigQuery config', error: e);
      return null;
    }
  }

  /// جلب سجل التصديرات
  Stream<List<BigQueryExport>> getExportsHistory(String institutionId) {
    return _firestore
        .collection('bigquery_exports')
        .where('institutionId', isEqualTo: institutionId)
        .orderBy('startedAt', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => BigQueryExport.fromJson(doc.data()))
            .toList());
  }
}
