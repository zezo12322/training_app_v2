import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/screens/login_screen.dart';
import 'bottom_nav_shell.dart';
import 'package:training_app/widgets/badge_award_listener.dart';
import 'package:training_app/providers/quiz_providers.dart'; // للوصول لمزود notificationServiceProvider
import 'super_admin_dashboard.dart';
import 'org_admin_dashboard.dart';
import 'company_admin_dashboard.dart';
import 'manager_dashboard.dart';
import '../providers/department_providers.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  static bool _oneSignalStarted = false;

  void _initOneSignalOnce(WidgetRef ref) {
    if (_oneSignalStarted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_oneSignalStarted) return; // double guard
      final service = ref.read(notificationServiceProvider);
      await service.initOneSignal();
      _oneSignalStarted = true;
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // نستمع لحالة تسجيل الدخول
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) return const LoginScreen();

        // Trigger user model load (idempotent) after authentication.
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => requestCurrentUserLoad(ref),
        );

        // تهيئة OneSignal ثم ضمان ربط المستخدم
        _initOneSignalOnce(ref);
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          final service = ref.read(notificationServiceProvider);
          await service.ensureUserBinding();
        });

        final userModelAsync = ref.watch(currentUserModelProvider);
        return userModelAsync.when(
          data: (appUser) {
            // إذا لم يتم تحميل بيانات المستخدم بعد، نظهر مؤشر تحميل بدلاً من الرجوع لشاشة تسجيل الدخول
            if (appUser == null) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            final role = appUser.role;
            final instId = appUser.institutionId;
            final compId = appUser.companyId;
            // Route by role to avoid mixing features across personas
            switch (role) {
              case 'super_admin':
                return const SuperAdminDashboard();
              case 'org_admin':
                return OrgAdminDashboard(institutionId: instId ?? '');
              case 'company_admin':
                return CompanyAdminDashboard(companyId: compId ?? '');
              case 'manager':
                // Managers may be mapped to multiple departments via user_department_map.
                final depsAsync = ref.watch(departmentsForUserProvider(appUser.id));
                return depsAsync.when(
                  data: (deps) {
                    if (deps.isEmpty) {
                      // No department mapping yet; fallback to trainer shell until assigned
                      return const BadgeAwardListener(child: BottomNavShell(role: 'trainer'));
                    }
                    // Pick the first department for now; Settings screen already offers a chooser.
                    return ManagerDashboard(departmentId: deps.first.id);
                  },
                  loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
                  error: (e, st) => const BadgeAwardListener(child: BottomNavShell(role: 'trainer')),
                );
              case 'trainer':
                return const BadgeAwardListener(child: BottomNavShell(role: 'trainer'));
              case 'trainee':
              default:
                return const BadgeAwardListener(child: BottomNavShell(role: 'trainee'));
            }
          },
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (err, stack) => Scaffold(
            body: Center(child: Text('Error loading user data: $err')),
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) =>
          Scaffold(body: Center(child: Text('Auth error: $err'))),
    );
  }
}
