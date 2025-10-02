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

          final userModelAsync = ref.watch(currentUserModelProvider);
          return userModelAsync.when(
            data: (appUser) {
              if (appUser == null) return const LoginScreen();
              final role = appUser.role;
              if (role == 'trainer') return const TrainerHomeScreen();
              return const TraineeHomeScreen();
            },
            loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => Scaffold(
              body: Center(child: Text('Error loading user data: $err')),
            ),
          );
        }
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Auth error: $err'))),
    );
  }
}