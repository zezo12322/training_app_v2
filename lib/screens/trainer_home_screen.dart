import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/providers/course_providers.dart';
import 'create_course_screen.dart';
import 'course_details_screen.dart';
import 'profile_screen.dart';

class TrainerHomeScreen extends ConsumerWidget {
  const TrainerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authStateProvider).value;
    final userModel = ref.watch(currentUserModelProvider).value; // قد تكون null مبدئياً
    final coursesAsync = ref.watch(trainerCoursesProvider);

    if (authUser == null) {
      return const Scaffold(body: Center(child: Text('المستخدم غير موجود')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التحكم'),
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
              'مرحباً، ${userModel?.name ?? 'أيها المدرب'}!',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('كورساتك الحالية:', style: TextStyle(fontSize: 18, color: Colors.grey)),
          ),
          const Divider(indent: 16, endIndent: 16, height: 16),
          Expanded(
            child: coursesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('خطأ في تحميل الكورسات: $err')),
              data: (courses) {
                if (courses.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.school_outlined, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        const Text('لم تقم بإنشاء أي كورسات بعد', style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        const Text('اضغط على زر + في الأسفل للبدء', style: TextStyle(color: Colors.grey)),
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
                        leading: const Icon(Icons.book, size: 30),
                        title: Text(course.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        subtitle: Text('الكود: ${course.courseCode}'),
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
            MaterialPageRoute(builder: (context) => const CreateCourseScreen()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'إنشاء كورس جديد',
      ),
    );
  }
}