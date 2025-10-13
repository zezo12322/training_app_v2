import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/department_providers.dart';
import 'package:flutter/foundation.dart';

// Basic role providers
final roleProvider = Provider<String?>((ref) => ref.watch(currentUserModelProvider).value?.role);
final isSuperAdminProvider = Provider<bool>((ref) => ref.watch(roleProvider) == 'super_admin');
final isOrgAdminProvider = Provider<bool>((ref) => ref.watch(roleProvider) == 'org_admin');
final isCompanyAdminProvider = Provider<bool>((ref) => ref.watch(roleProvider) == 'company_admin');
final isManagerProvider = Provider<bool>((ref) => ref.watch(roleProvider) == 'manager');
final isTrainerProvider = Provider<bool>((ref) => ref.watch(roleProvider) == 'trainer');
final isTraineeProvider = Provider<bool>((ref) => ref.watch(roleProvider) == 'trainee');

// Tenant-scoped helpers
final isOrgAdminForInstitutionProvider = Provider.family<bool, String>((ref, institutionId) {
  final user = ref.watch(currentUserModelProvider).value;
  return user?.role == 'org_admin' && user?.institutionId == institutionId;
});

final isCompanyAdminForCompanyProvider = Provider.family<bool, String>((ref, companyId) {
  final user = ref.watch(currentUserModelProvider).value;
  return user?.role == 'company_admin' && user?.companyId == companyId;
});

final isManagerOfDepartmentProvider = Provider.family<bool, String>((ref, departmentId) {
  final user = ref.watch(currentUserModelProvider).value;
  if (user?.role != 'manager') return false;
  final dept = ref.watch(departmentByIdProvider(departmentId)).value;
  // Minimal check: ensure same company
  return dept != null && user?.companyId == dept.companyId;
});

// Lightweight UI gate
class RoleGate extends ConsumerWidget {
  final List<String> allowRoles; // e.g., ['company_admin']
  final WidgetBuilder builder;
  final Widget? fallback;
  const RoleGate({super.key, required this.allowRoles, required this.builder, this.fallback});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(currentUserModelProvider).value?.role;
    if (role != null && allowRoles.contains(role)) {
      return builder(context);
    }
    return fallback ?? const SizedBox.shrink();
  }
}

/// Debug overlay to show current role and tenant ids in non-release builds.
class RoleDebugWrapper extends ConsumerWidget {
  final Widget child;
  const RoleDebugWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kReleaseMode) return child;
    final user = ref.watch(currentUserModelProvider).value;
    final info = 'role: ${user?.role ?? '-'} · inst: ${user?.institutionId ?? '-'} · company: ${user?.companyId ?? '-'}';
    return Stack(
      children: [
        child,
        Positioned(
          left: 8,
          right: 8,
          bottom: 8,
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.85,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF000000),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: DefaultTextStyle(
                  style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),
                  child: Text(info, maxLines: 2, overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
