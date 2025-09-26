import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/screens/login_screen.dart';
import 'package:training_app/screens/trainee_home_screen.dart';
import 'package:training_app/screens/trainer_home_screen.dart';
import 'package:training_app/services/notification_service.dart'; // <--- استيراد خدمة الإشعارات

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // نستمع لحالة تسجيل الدخول
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return const LoginScreen();
        } else {
          // ✨ إضافة مهمة: استدعاء خدمة الإشعارات ✨
          // بمجرد التأكد من وجود مستخدم، نقوم بتهيئة OneSignal
          OneSignalNotificationService().initOneSignal();

          // الآن نستمع للـ Provider الذي يجلب بيانات المستخدم
          final userDetailsProvider = ref.watch(currentUserProvider);

          return userDetailsProvider.when(
            data: (userDoc) {
              if (userDoc != null && userDoc.exists) {
                // انتبه: تم التعديل من 'userType' إلى 'role' لمطابقة الكود القديم
                final userRole = userDoc['role'] ?? 'trainee';

                if (userRole == 'trainer') {
                  return const TrainerHomeScreen();
                } else {
                  return const TraineeHomeScreen();
                }
              }
              // إذا لم يتم العثور على بيانات المستخدم، يتم إرجاعه لشاشة تسجيل الدخول
              return const LoginScreen();
            },
            loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
            error: (err, stack) => Scaffold(body: Center(child: Text('Error loading user data: $err'))),
          );
        }
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Auth error: $err'))),
    );
  }
}