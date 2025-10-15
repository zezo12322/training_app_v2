import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../models/gamification/learning_module.dart';
import '../../core/logging.dart';

/// Repository لإدارة Learning Modules والتقدم فيها
class ModuleRepository {
  final FirebaseFirestore _firestore;

  ModuleRepository(this._firestore);

  // ==================== CRUD Operations ====================

  /// إنشاء وحدة تعليمية جديدة
  Future<String> createModule(LearningModule module) async {
    try {
      final docRef = await _firestore.collection('learning_modules').add({
        'courseId': module.courseId,
        'title': module.title,
        'description': module.description,
        'orderIndex': module.orderIndex,
        'contents': module.contents.map((c) => c.toJson()).toList(),
        'requirements': module.requirements.toJson(),
        'completionPoints': module.completionPoints,
        'isActive': module.isActive,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      debugPrint('✅ Module created: ${docRef.id}');
      return docRef.id;
    } catch (e, st) {
      logger.e('Failed to create module', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// تحديث وحدة تعليمية
  Future<void> updateModule(LearningModule module) async {
    if (module.id == null) {
      throw ArgumentError('Module ID cannot be null for update');
    }

    try {
      await _firestore.collection('learning_modules').doc(module.id).update({
        'title': module.title,
        'description': module.description,
        'orderIndex': module.orderIndex,
        'contents': module.contents.map((c) => c.toJson()).toList(),
        'requirements': module.requirements.toJson(),
        'completionPoints': module.completionPoints,
        'isActive': module.isActive,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      debugPrint('✅ Module updated: ${module.id}');
    } catch (e, st) {
      logger.e('Failed to update module', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// حذف وحدة تعليمية
  Future<void> deleteModule(String moduleId) async {
    try {
      await _firestore.collection('learning_modules').doc(moduleId).delete();
      debugPrint('✅ Module deleted: $moduleId');
    } catch (e, st) {
      logger.e('Failed to delete module', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// Stream لكل الوحدات في كورس معين
  Stream<List<LearningModule>> streamCourseModules(String courseId) {
    return _firestore
        .collection('learning_modules')
        .where('courseId', isEqualTo: courseId)
        .orderBy('orderIndex')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return LearningModule.fromJson({
          ...data,
          'id': doc.id,
        });
      }).toList();
    });
  }

  /// الحصول على وحدة واحدة
  Future<LearningModule?> getModule(String moduleId) async {
    try {
      final doc = await _firestore
          .collection('learning_modules')
          .doc(moduleId)
          .get();

      if (!doc.exists) return null;

      return LearningModule.fromJson({
        ...doc.data()!,
        'id': doc.id,
      });
    } catch (e, st) {
      logger.e('Failed to get module', error: e, stackTrace: st);
      return null;
    }
  }

  // ==================== Progress Tracking ====================

  /// تحديث تقدم المستخدم في محتوى معين
  Future<void> updateModuleProgress({
    required String userId,
    required String moduleId,
    required String contentId,
    required bool isCompleted,
  }) async {
    final progressId = '${userId}_$moduleId';

    try {
      await _firestore.runTransaction((transaction) async {
        final progressRef = _firestore
            .collection('module_progress')
            .doc(progressId);

        final progressDoc = await transaction.get(progressRef);

        if (!progressDoc.exists) {
          // Create new progress document
          transaction.set(progressRef, {
            'userId': userId,
            'moduleId': moduleId,
            'completedContents': isCompleted ? [contentId] : [],
            'progressPercentage': 0.0,
            'isCompleted': false,
            'completedAt': null,
            'lastAccessedAt': FieldValue.serverTimestamp(),
            'createdAt': FieldValue.serverTimestamp(),
          });
        } else {
          // Update existing progress
          final data = progressDoc.data()!;
          final completedContents = List<String>.from(
            data['completedContents'] ?? [],
          );

          if (isCompleted && !completedContents.contains(contentId)) {
            completedContents.add(contentId);
          } else if (!isCompleted && completedContents.contains(contentId)) {
            completedContents.remove(contentId);
          }

          transaction.update(progressRef, {
            'completedContents': completedContents,
            'lastAccessedAt': FieldValue.serverTimestamp(),
          });
        }
      });

      debugPrint('✅ Progress updated: $contentId → $isCompleted');

      // Update progress percentage
      await _updateProgressPercentage(userId, moduleId);
    } catch (e, st) {
      logger.e('Failed to update progress', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// حساب وتحديث نسبة التقدم
  Future<void> _updateProgressPercentage(
    String userId,
    String moduleId,
  ) async {
    try {
      final module = await getModule(moduleId);
      if (module == null) return;

      final progressId = '${userId}_$moduleId';
      final progressDoc = await _firestore
          .collection('module_progress')
          .doc(progressId)
          .get();

      if (!progressDoc.exists) return;

      final data = progressDoc.data()!;
      final completedContents = List<String>.from(
        data['completedContents'] ?? [],
      );

      // Count required contents
      final requiredContents = module.contents
          .where((c) => c.isRequired)
          .toList();

      if (requiredContents.isEmpty) return;

      final completedRequired = completedContents
          .where((id) => requiredContents.any((c) => c.id == id))
          .length;

      final percentage = (completedRequired / requiredContents.length) * 100;

      await _firestore
          .collection('module_progress')
          .doc(progressId)
          .update({
        'progressPercentage': percentage,
      });

      debugPrint('📊 Progress: $percentage%');
    } catch (e, st) {
      logger.e('Failed to update progress percentage', error: e, stackTrace: st);
    }
  }

  /// الحصول على تقدم المستخدم في وحدة
  Future<Map<String, dynamic>> getModuleProgress({
    required String userId,
    required String moduleId,
  }) async {
    final progressId = '${userId}_$moduleId';

    try {
      final doc = await _firestore
          .collection('module_progress')
          .doc(progressId)
          .get();

      if (!doc.exists) {
        return {
          'completedContents': <String>[],
          'progressPercentage': 0.0,
          'isCompleted': false,
        };
      }

      return doc.data()!;
    } catch (e, st) {
      logger.e('Failed to get progress', error: e, stackTrace: st);
      return {
        'completedContents': <String>[],
        'progressPercentage': 0.0,
        'isCompleted': false,
      };
    }
  }

  /// Stream لتقدم المستخدم (real-time)
  Stream<Map<String, dynamic>> streamModuleProgress({
    required String userId,
    required String moduleId,
  }) {
    final progressId = '${userId}_$moduleId';

    return _firestore
        .collection('module_progress')
        .doc(progressId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) {
        return {
          'completedContents': <String>[],
          'progressPercentage': 0.0,
          'isCompleted': false,
        };
      }
      return doc.data()!;
    });
  }

  // ==================== Completion Logic ====================

  /// التحقق من إكمال الوحدة
  Future<bool> checkModuleCompletion({
    required String userId,
    required LearningModule module,
  }) async {
    if (module.id == null) return false;

    try {
      final progress = await getModuleProgress(
        userId: userId,
        moduleId: module.id!,
      );

      final completedContents = List<String>.from(
        progress['completedContents'] ?? [],
      );

      // Check required contents
      final requiredContents = module.contents
          .where((c) => c.isRequired)
          .toList();

      for (final content in requiredContents) {
        if (!completedContents.contains(content.id)) {
          debugPrint('❌ Required content not completed: ${content.id}');
          return false;
        }
      }

      debugPrint('✅ All requirements met for module: ${module.id}');
      return true;
    } catch (e, st) {
      logger.e('Failed to check completion', error: e, stackTrace: st);
      return false;
    }
  }

  /// تحديد الوحدة كمكتملة
  Future<void> completeModule({
    required String userId,
    required String moduleId,
    required String courseId,
  }) async {
    final progressId = '${userId}_$moduleId';

    try {
      await _firestore
          .collection('module_progress')
          .doc(progressId)
          .update({
        'isCompleted': true,
        'completedAt': FieldValue.serverTimestamp(),
        'progressPercentage': 100.0,
      });

      debugPrint('🎉 Module completed: $moduleId');
    } catch (e, st) {
      logger.e('Failed to complete module', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// الحصول على الوحدة التالية المفتوحة
  Future<LearningModule?> getNextUnlockedModule({
    required String userId,
    required String courseId,
  }) async {
    try {
      // Get all modules
      final modulesSnapshot = await _firestore
          .collection('learning_modules')
          .where('courseId', isEqualTo: courseId)
          .orderBy('orderIndex')
          .get();

      if (modulesSnapshot.docs.isEmpty) return null;

      // First module is always unlocked
      final firstModule = LearningModule.fromJson({
        ...modulesSnapshot.docs.first.data(),
        'id': modulesSnapshot.docs.first.id,
      });

      // Check if first module is completed
      final firstProgress = await getModuleProgress(
        userId: userId,
        moduleId: firstModule.id!,
      );

      if (firstProgress['isCompleted'] != true) {
        return firstModule; // Return first module if not completed
      }

      // Find first incomplete module
      for (final doc in modulesSnapshot.docs.skip(1)) {
        final module = LearningModule.fromJson({
          ...doc.data(),
          'id': doc.id,
        });

        final progress = await getModuleProgress(
          userId: userId,
          moduleId: module.id!,
        );

        if (progress['isCompleted'] != true) {
          // Check if previous module is completed
          final prevIndex = module.orderIndex - 1;
          final prevModule = modulesSnapshot.docs
              .map((d) => LearningModule.fromJson({...d.data(), 'id': d.id}))
              .firstWhere((m) => m.orderIndex == prevIndex);

          final prevProgress = await getModuleProgress(
            userId: userId,
            moduleId: prevModule.id!,
          );

          if (prevProgress['isCompleted'] == true) {
            return module; // This is the next unlocked module
          }
        }
      }

      return null; // All modules completed
    } catch (e, st) {
      logger.e('Failed to get next unlocked module', error: e, stackTrace: st);
      return null;
    }
  }
}
