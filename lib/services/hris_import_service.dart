import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import '../models/hris_import.dart';
import '../models/user_model.dart';
import '../core/logging.dart';

/// خدمة استيراد HRIS
class HRISImportService {
  final FirebaseFirestore _firestore;

  HRISImportService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// قراءة ملف CSV
  Future<List<List<String>>> parseCSV(File file) async {
    try {
      final input = await file.readAsString();
      final csvTable = const CsvToListConverter().convert(input);
      
      // تحويل dynamic إلى String
      return csvTable.map((row) => 
        row.map((cell) => cell?.toString() ?? '').toList()
      ).toList();
    } catch (e) {
      logger.e('Error parsing CSV', error: e);
      rethrow;
    }
  }

  /// قراءة ملف Excel
  Future<List<List<String>>> parseExcel(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final excel = Excel.decodeBytes(bytes);
      
      // الحصول على أول ورقة عمل
      final sheet = excel.tables.values.first;
      
      // تحويل إلى قائمة من الصفوف
      final rows = <List<String>>[];
      for (final row in sheet.rows) {
        final rowData = row.map((cell) => cell?.value?.toString() ?? '').toList();
        rows.add(rowData);
      }
      
      return rows;
    } catch (e) {
      logger.e('Error parsing Excel', error: e);
      rethrow;
    }
  }

  /// استخراج سجلات المستخدمين من البيانات
  List<ImportedUserRecord> extractUserRecords({
    required List<List<String>> data,
    required FieldMapping fieldMapping,
  }) {
    if (data.isEmpty) return [];
    
    final headers = data.first;
    final records = <ImportedUserRecord>[];
    
    // الحصول على فهرس الأعمدة
    final emailIndex = _findColumnIndex(headers, fieldMapping.emailColumn);
    final nameIndex = _findColumnIndex(headers, fieldMapping.nameColumn);
    final roleIndex = _findColumnIndex(headers, fieldMapping.roleColumn);
    final phoneIndex = _findColumnIndex(headers, fieldMapping.phoneColumn);
    final deptIndex = _findColumnIndex(headers, fieldMapping.departmentColumn);
    final jobIndex = _findColumnIndex(headers, fieldMapping.jobTitleColumn);
    final empIdIndex = _findColumnIndex(headers, fieldMapping.employeeIdColumn);
    final mgrIndex = _findColumnIndex(headers, fieldMapping.managerEmailColumn);
    
    // معالجة كل صف (تخطي الرأس)
    for (int i = 1; i < data.length; i++) {
      final row = data[i];
      
      // استخراج البيانات
      final email = _getCell(row, emailIndex);
      final name = _getCell(row, nameIndex);
      final role = _getCell(row, roleIndex);
      final phone = _getCell(row, phoneIndex);
      final dept = _getCell(row, deptIndex);
      final job = _getCell(row, jobIndex);
      final empId = _getCell(row, empIdIndex);
      final mgr = _getCell(row, mgrIndex);
      
      // التحقق من الصحة
      final errors = <String>[];
      if (email.isEmpty) errors.add('البريد الإلكتروني مطلوب');
      if (!_isValidEmail(email)) errors.add('البريد الإلكتروني غير صحيح');
      if (name.isEmpty) errors.add('الاسم مطلوب');
      
      records.add(ImportedUserRecord(
        rowNumber: i + 1,
        email: email,
        name: name,
        role: role.isNotEmpty ? role : null,
        phone: phone.isNotEmpty ? phone : null,
        department: dept.isNotEmpty ? dept : null,
        jobTitle: job.isNotEmpty ? job : null,
        employeeId: empId.isNotEmpty ? empId : null,
        managerEmail: mgr.isNotEmpty ? mgr : null,
        isValid: errors.isEmpty,
        validationErrors: errors,
      ));
    }
    
    return records;
  }

  /// استيراد المستخدمين إلى Firestore
  Future<HRISImport> importUsers({
    required String importId,
    required List<ImportedUserRecord> records,
    required String institutionId,
    String? companyId,
    String? defaultRole,
    String? defaultPassword,
    bool updateExisting = true,
  }) async {
    try {
      // تحديث الحالة
      await _updateImportStatus(importId, ImportStatus.processing);
      
      int successful = 0;
      int failed = 0;
      final errors = <String>[];
      
      for (final record in records) {
        if (!record.isValid) {
          failed++;
          errors.add('Row ${record.rowNumber}: ${record.validationErrors.join(", ")}');
          continue;
        }
        
        try {
          // التحقق من وجود المستخدم
          final existingUser = await _findUserByEmail(record.email);
          
          if (existingUser != null) {
            if (updateExisting) {
              // تحديث المستخدم الموجود
              await _updateUser(existingUser.id, record);
              successful++;
            } else {
              failed++;
              errors.add('Row ${record.rowNumber}: المستخدم موجود بالفعل');
            }
          } else {
            // إنشاء مستخدم جديد
            await _createUser(
              record: record,
              institutionId: institutionId,
              companyId: companyId,
              defaultRole: defaultRole,
            );
            successful++;
          }
          
          // تحديث التقدم
          await _updateProgress(importId, records.indexOf(record) + 1, successful, failed);
        } catch (e) {
          failed++;
          errors.add('Row ${record.rowNumber}: ${e.toString()}');
          logger.e('Error importing user', error: e);
        }
      }
      
      // تحديث الحالة النهائية
      final finalStatus = failed == 0 
          ? ImportStatus.completed 
          : successful > 0 
              ? ImportStatus.partialSuccess 
              : ImportStatus.failed;
      
      await _updateImportStatus(
        importId,
        finalStatus,
        completedAt: DateTime.now(),
        errors: errors,
      );
      
      final updatedImport = await _firestore.collection('hris_imports').doc(importId).get();
      return HRISImport.fromJson(updatedImport.data()!);
    } catch (e, stackTrace) {
      logger.e('Import failed', error: e, stackTrace: stackTrace);
      await _updateImportStatus(importId, ImportStatus.failed);
      rethrow;
    }
  }

  /// إنشاء مستخدم جديد
  Future<void> _createUser({
    required ImportedUserRecord record,
    required String institutionId,
    String? companyId,
    String? defaultRole,
  }) async {
    final userId = _firestore.collection('users').doc().id;
    
    final user = AppUser(
      id: userId,
      email: record.email,
      name: record.name,
      role: record.role ?? defaultRole ?? 'trainee',
      institutionId: institutionId,
      companyId: companyId,
      createdAt: DateTime.now(),
    );
    
    await _firestore.collection('users').doc(userId).set(user.toJson());
    logger.i('User created: ${record.email}');
  }

  /// تحديث مستخدم موجود
  Future<void> _updateUser(String userId, ImportedUserRecord record) async {
    final updates = <String, dynamic>{
      'name': record.name,
    };
    
    if (record.role != null) updates['role'] = record.role;
    
    await _firestore.collection('users').doc(userId).update(updates);
    logger.i('User updated: ${record.email}');
  }

  /// البحث عن مستخدم بالبريد الإلكتروني
  Future<AppUser?> _findUserByEmail(String email) async {
    final snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    
    if (snapshot.docs.isEmpty) return null;
    
    return AppUser.fromJson(snapshot.docs.first.data());
  }

  /// تحديث حالة الاستيراد
  Future<void> _updateImportStatus(
    String importId,
    ImportStatus status, {
    DateTime? completedAt,
    List<String>? errors,
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
    
    await _firestore.collection('hris_imports').doc(importId).update(updates);
  }

  /// تحديث التقدم
  Future<void> _updateProgress(
    String importId,
    int processed,
    int successful,
    int failed,
  ) async {
    await _firestore.collection('hris_imports').doc(importId).update({
      'processedRows': processed,
      'successfulRows': successful,
      'failedRows': failed,
    });
  }

  /// مساعدات
  int _findColumnIndex(List<String> headers, String? columnName) {
    if (columnName == null || columnName.isEmpty) return -1;
    return headers.indexWhere((h) => 
      h.trim().toLowerCase() == columnName.trim().toLowerCase()
    );
  }

  String _getCell(List<String> row, int index) {
    if (index < 0 || index >= row.length) return '';
    return row[index].trim();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// حفظ قالب
  Future<bool> saveTemplate(ImportTemplate template) async {
    try {
      await _firestore
          .collection('import_templates')
          .doc(template.id)
          .set(template.toJson());
      return true;
    } catch (e) {
      logger.e('Error saving template', error: e);
      return false;
    }
  }

  /// جلب القوالب
  Future<List<ImportTemplate>> getTemplates(String institutionId) async {
    try {
      final snapshot = await _firestore
          .collection('import_templates')
          .where('institutionId', isEqualTo: institutionId)
          .get();
      
      return snapshot.docs
          .map((doc) => ImportTemplate.fromJson(doc.data()))
          .toList();
    } catch (e) {
      logger.e('Error fetching templates', error: e);
      return [];
    }
  }
}
