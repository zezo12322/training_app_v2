import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseManagement {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // دالة لإنشاء كورس جديد مع كود فريد
  Future<void> createCourse(String courseName, String trainerId) async {
    try {
      final courseCode = _generateUniqueCode();
      await _firestore.collection('courses').add({
        'name': courseName,
        'trainerId': trainerId,
        'courseCode': courseCode,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // يفضل استخدام print(e) أو logging أثناء التطوير
      throw Exception('Failed to create course: $e');
    }
  }

  // دالة للانضمام إلى كورس باستخدام الكود
  Future<DocumentSnapshot?> joinCourse(String courseCode, String traineeId) async {
    try {
      final querySnapshot = await _firestore
          .collection('courses')
          .where('courseCode', isEqualTo: courseCode)
          .limit(1) // يكفي العثور على مستند واحد
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final course = querySnapshot.docs.first;
        await _firestore.collection('courses').doc(course.id).update({
          'trainees': FieldValue.arrayUnion([traineeId]),
        });
        return course;
      } else {
        return null; // لم يتم العثور على الكورس
      }
    } catch (e) {
      throw Exception('Failed to join course: $e');
    }
  }

  // دالة خاصة لتوليد كود عشوائي
  String _generateUniqueCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();
    return List.generate(6, (index) => chars[rand.nextInt(chars.length)]).join();
  }
}