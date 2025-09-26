import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CourseWall {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // دالة لرفع ملف إلى Firebase Storage
  Future<String> uploadFile(String filePath, String courseId) async {
    try {
      final file = File(filePath);
      // إنشاء مرجع فريد للملف بناءً على الوقت الحالي واسم الملف
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
      final ref = _storage.ref().child('course_wall/$courseId/$fileName');
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    }
  }

  // دالة لإضافة منشور جديد على حائط الكورس
  Future<void> postToWall(String courseId, String content, {String? fileUrl, required String authorId}) async {
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