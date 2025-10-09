import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/services/hybrid_storage_service.dart';

class CourseWall {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final HybridStorageService _hybrid = HybridStorageService();

  // دالة لرفع ملف باستخدام التخزين الهجين (R2 / Cloudinary)
  Future<String> uploadFile(String filePath, String courseId) async {
    try {
      final file = File(filePath);
      final res = await _hybrid.uploadFile(file);
      return res.url;
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }

  // دالة لإضافة منشور جديد على حائط الكورس
  Future<void> postToWall(
    String courseId,
    String content, {
    String? fileUrl,
    required String authorId,
  }) async {
    try {
      await _firestore.collection('course_wall').add({
        'courseId': courseId,
        'authorId': authorId, // مهم لمعرفة من قام بالنشر
        'content': content,
        'fileUrl': fileUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to post to wall: $e');
    }
  }
}
