import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'join_course_screen.dart';
import 'course_details_screen.dart';
import 'profile_screen.dart';

class TraineeHomeScreen extends StatelessWidget {
  const TraineeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: Text('المستخدم غير موجود')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            tooltip: 'الملف الشخصي',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                final userName = userData['name'] ?? 'أيها المتدرب';
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'أهلاً بك، $userName!',
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text('أهلاً بك!', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('كورساتك المسجل بها:', style: TextStyle(fontSize: 18, color: Colors.grey)),
          ),
          const Divider(indent: 16, endIndent: 16, height: 16),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('courses')
                  .where('trainees', arrayContains: user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  // --- تحسين شاشة "لا يوجد بيانات" ---
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.class_outlined, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        const Text(
                          'لم تنضم إلى أي كورسات بعد',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'اضغط على زر + للانضمام إلى كورس جديد',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                final courses = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0), // مسافة حول القائمة كلها
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    final courseName = course['name'] as String;
                    final trainerEmail = course['trainerEmail'] as String?;

                    return Card(
                      // --- تم تطبيق التحسينات هنا ---
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      elevation: 3,
                      shadowColor: Colors.black.withOpacity(0.1),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        leading: const Icon(Icons.class_, size: 30),
                        title: Text(courseName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        subtitle: Text('المدرب: ${trainerEmail ?? 'غير معروف'}'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CourseDetailsScreen(
                                courseId: course.id,
                                courseName: course['name'] as String,
                                trainerId: course['trainerId'] as String,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const JoinCourseScreen()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'الانضمام إلى كورس',
      ),
    );
  }
}