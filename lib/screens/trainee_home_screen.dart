import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/providers/course_providers.dart';
import 'join_course_screen.dart';
import 'course_details_screen.dart';
import 'profile_screen.dart';

class TraineeHomeScreen extends ConsumerWidget {
  const TraineeHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authStateProvider).value;
    final userModel = ref.watch(currentUserModelProvider).value;
    final coursesAsync = ref.watch(traineeCoursesProvider);

    if (authUser == null) {
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
            onPressed: () => ref.read(authRepositoryProvider).signOut(),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'أهلاً بك، ${userModel?.name ?? 'أيها المتدرب'}!',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('كورساتك المسجل بها:', style: TextStyle(fontSize: 18, color: Colors.grey)),
          ),
          const Divider(indent: 16, endIndent: 16, height: 16),
          Expanded(
            child: coursesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('خطأ في التحميل: $err')),
              data: (courses) {
                if (courses.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.class_outlined, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        const Text('لم تنضم إلى أي كورسات بعد', style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        const Text('اضغط على زر + للانضمام إلى كورس جديد', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      elevation: 3,
                      shadowColor: const Color(0x1A000000),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        leading: const Icon(Icons.class_, size: 30),
                        title: Text(course.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        subtitle: Text('المدرب: ${course.trainerId}'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CourseDetailsScreen(
                                courseId: course.id,
                                courseName: course.name,
                                trainerId: course.trainerId,
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