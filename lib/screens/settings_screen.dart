import 'package:flutter/material.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_providers.dart';
import 'package:training_app/core/l10n_ext.dart';
import '../widgets/animations/slide_fade_in.dart';
import '../core/logging.dart';
import '../providers/auth_provider.dart';
import 'org_admin_dashboard.dart';
import 'company_admin_dashboard.dart';
import 'bulk_import_screen.dart';
import 'departments_screen.dart';
import 'learning_paths_screen.dart';
import 'manager_dashboard.dart';
import '../providers/department_providers.dart';
import 'super_admin_dashboard.dart';
import '../services/preferences_service.dart';
import 'auth_wrapper.dart';
import 'privacy_policy_screen.dart';
import 'terms_of_service_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final notifications = ref.watch(notificationsEnabledProvider);
    final funAnimations = ref.watch(funAnimationsProvider);
    final autoplayAudio = ref.watch(autoplayAudioProvider);
    final cs = Theme.of(context).colorScheme;
    final l = context.l;
    final currentLocale = ref.watch(appLocaleProvider);

    // Current app user (for role-gated admin entries)
    final userAsync = ref.watch(currentUserModelProvider);
    final appUser = userAsync.asData?.value;
    final isOrgAdmin = appUser?.role == 'org_admin';
    final isCompanyAdmin = appUser?.role == 'company_admin';
    final isSuperAdmin = appUser?.role == 'super_admin';
    final isManager = appUser?.role == 'manager';
    final institutionId = appUser?.institutionId;
    final companyId = appUser?.companyId;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.primaryContainer,
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.tune, color: cs.onPrimaryContainer),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l.navSettings,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Appearance
          SlideFadeIn(
            index: 0,
            enable: funAnimations,
            child: Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionHeader(label: l.navSettings),
                    const SizedBox(height: 8),
                    SegmentedButton<ThemeMode>(
                      style: const ButtonStyle(
                        visualDensity: VisualDensity.compact,
                      ),
                      segments: [
                        ButtonSegment(
                          value: ThemeMode.system,
                          icon: const Icon(Icons.phone_android),
                          label: Text(l.themeSystem),
                        ),
                        ButtonSegment(
                          value: ThemeMode.light,
                          icon: const Icon(Icons.light_mode),
                          label: Text(l.themeLight),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          icon: const Icon(Icons.dark_mode),
                          label: Text(l.themeDark),
                        ),
                      ],
                      selected: {themeMode},
                      onSelectionChanged: (set) =>
                          saveThemeMode(ref, set.first),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l.languagePickerTitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      children: [
                        ChoiceChip(
                          label: Text(l.systemLocaleLabel),
                          selected: currentLocale == null,
                          onSelected: (_) => setAppLocale(ref, null),
                        ),
                        ChoiceChip(
                          label: Text(l.settingsArabicLabel),
                          selected: currentLocale?.languageCode == 'ar',
                          onSelected: (_) =>
                              setAppLocale(ref, const Locale('ar')),
                        ),
                        ChoiceChip(
                          label: const Text('English'),
                          selected: currentLocale?.languageCode == 'en',
                          onSelected: (_) =>
                              setAppLocale(ref, const Locale('en')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Administration (role-gated)
          if ((isOrgAdmin && institutionId != null) ||
              (isCompanyAdmin && companyId != null) ||
              isSuperAdmin ||
              isManager)
            SlideFadeIn(
              index: 2, // place before system/settings debug sections
              enable: funAnimations,
              child: Card(
                elevation: 1,
                child: Column(
                  children: [
                    if (isSuperAdmin)
                      ListTile(
                        leading: const Icon(Icons.security_outlined),
                        title: const Text('Super Admin Dashboard'),
                        subtitle: const Text('Open global admin & tenants tools'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SuperAdminDashboard(),
                            ),
                          );
                        },
                      ),
                    if (isSuperAdmin) const Divider(height: 0),
                    if (isOrgAdmin && institutionId != null)
                      ListTile(
                        leading: const Icon(
                          Icons.admin_panel_settings_outlined,
                        ),
                        title: Text(context.orgAdminDashboardTitle),
                        subtitle: Text(context.orgAdminDashboardSubtitle),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => OrgAdminDashboard(
                                institutionId: institutionId,
                              ),
                            ),
                          );
                        },
                      ),
                    if (isCompanyAdmin && companyId != null)
                      Column(
                        children: [
                          if (isOrgAdmin && institutionId != null)
                            const Divider(height: 0),
                          ListTile(
                            leading: const Icon(Icons.business_outlined),
                            title: Text(context.companyAdminDashboardTitle),
                            subtitle: Text(
                              context.companyAdminDashboardSubtitle,
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CompanyAdminDashboard(
                                    companyId: companyId,
                                  ),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 0),
                          ListTile(
                            leading: const Icon(Icons.account_tree_outlined),
                            title: Text(context.departmentsTitle),
                            subtitle: Text(context.departmentsSubtitle),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DepartmentsScreen(companyId: companyId),
                                ),
                              );
                            },
                          ),
                          const Divider(height: 0),
                          ListTile(
                            leading: const Icon(Icons.route_outlined),
                            title: Text(context.learningPathsTitle),
                            subtitle: Text(context.learningPathsSubtitle),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      LearningPathsScreen(companyId: companyId),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    if (isManager || isSuperAdmin)
                      Column(
                        children: [
                          const Divider(height: 0),
                          ListTile(
                            leading: const Icon(Icons.groups_2_outlined),
                            title: Text(context.managerDashboardTitle),
                            subtitle: Text(context.managerDashboardSubtitle),
                            onTap: () async {
                              final managerId = appUser?.id;
                              if (managerId == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(context.selectDepartmentHint)),
                                );
                                return;
                              }
                              // Prefetch departments to allow auto-open when only one exists
                              final deps = await ref.read(departmentsForUserProvider(managerId).future);
                              if (!context.mounted) return;
                              if (deps.length == 1) {
                                final d = deps.first;
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ManagerDashboard(departmentId: d.id),
                                  ),
                                );
                                return;
                              }
                              showModalBottomSheet(
                                context: context,
                                showDragHandle: true,
                                builder: (sheetCtx) {
                                  return Consumer(
                                    builder: (ctx, ref, _) {
                                      final depsAsync = ref.watch(departmentsForUserProvider(managerId));
                                      return depsAsync.when(
                                        loading: () => const Padding(
                                          padding: EdgeInsets.all(24),
                                          child: Center(child: CircularProgressIndicator()),
                                        ),
                                        error: (e, st) => Padding(
                                          padding: const EdgeInsets.all(24),
                                          child: Text('Error: $e'),
                                        ),
                                        data: (deps) {
                                          if (deps.isEmpty) {
                                            return Padding(
                                              padding: const EdgeInsets.all(24),
                                              child: Center(child: Text(context.noDepartments)),
                                            );
                                          }
                                          return ListView.separated(
                                            shrinkWrap: true,
                                            itemCount: deps.length,
                                            separatorBuilder: (_, __) => const Divider(height: 0),
                                            itemBuilder: (c, i) {
                                              final d = deps[i];
                                              return ListTile(
                                                leading: const Icon(Icons.apartment_outlined),
                                                title: Text(d.name),
                                                subtitle: Text(context.idLabel(d.id)),
                                                onTap: () {
                                                  Navigator.of(sheetCtx).pop();
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) => ManagerDashboard(departmentId: d.id),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.upload_file_outlined),
                      title: Text(context.bulkImportTitle),
                      subtitle: Text(context.bulkImportSubtitle),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const BulkImportScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),
          // Behavior
          SlideFadeIn(
            index: 3,
            enable: funAnimations,
            child: Card(
              elevation: 1,
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  _SwitchWrapper(
                    child: SwitchListTile(
                      value: notifications,
                      title: Text(l.notificationsTitle),
                      subtitle: Text(l.notificationsSubtitle),
                      secondary: const Icon(
                        Icons.notifications_active_outlined,
                      ),
                      onChanged: (v) => toggleNotifications(ref, v),
                    ),
                  ),
                  const Divider(height: 0),
                  _SwitchWrapper(
                    child: SwitchListTile(
                      value: funAnimations,
                      title: Text(l.funAnimationsTitle),
                      subtitle: Text(l.funAnimationsSubtitle),
                      secondary: const Icon(Icons.animation_outlined),
                      onChanged: (v) => toggleFunAnimations(ref, v),
                    ),
                  ),
                  const Divider(height: 0),
                  _SwitchWrapper(
                    child: SwitchListTile(
                      value: autoplayAudio,
                      title: Text(l.autoplayAudioTitle),
                      subtitle: Text(l.autoplayAudioSubtitle),
                      secondary: const Icon(Icons.play_circle_outline),
                      onChanged: (v) => toggleAutoplayAudio(ref, v),
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // النظام
          SlideFadeIn(
            index: 4,
            enable: funAnimations,
            child: Card(
              elevation: 1,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.storage_rounded),
                    title: Text(l.clearCacheTitle),
                    subtitle: Text(l.clearCacheSubtitle),
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(l.confirmationTitle),
                          content: Text(l.clearCacheConfirm),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(false),
                              child: Text(l.cancelAction),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.of(ctx).pop(true),
                              child: Text(l.continueAction),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true && context.mounted) {
                        AppSnackBar.show(
                          context,
                          l.cacheClearedToast,
                          isError: false,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // الحساب
          SlideFadeIn(
            index: 5,
            enable: funAnimations,
            child: Card(
              elevation: 1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: cs.primary),
                        const SizedBox(width: 12),
                        Text(
                          l.aboutSection,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title: Text(l.privacyPolicy),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 0),
                  ListTile(
                    leading: const Icon(Icons.article_outlined),
                    title: Text(l.termsOfService),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const TermsOfServiceScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 0),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: Text(
                      l.logoutAction,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(l.confirmationTitle),
                          content: Text(l.logoutConfirm),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(false),
                              child: Text(l.cancelAction),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.of(ctx).pop(true),
                              child: Text(l.logoutAction),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        try {
                          await ref.read(authRepositoryProvider).signOut();
                          // Reset saved tab so next login lands on Home
                          final prefs = await PreferencesService.instance();
                          await prefs.set('last_nav_index', '0');
                          if (!context.mounted) return;
                          // Replace the entire stack with a fresh AuthWrapper to ensure Login is shown
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => const AuthWrapper(),
                            ),
                            (route) => false,
                          );
                        } catch (e, st) {
                          logger.e('Logout failed', error: e, stackTrace: st);
                          if (context.mounted) {
                            AppSnackBar.show(context, l.logoutFailed('$e'));
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // السجل / التشخيص
          SlideFadeIn(
            index: 6,
            enable: funAnimations,
            child: FilledButton.icon(
              icon: const Icon(Icons.bug_report_outlined),
              label: Text(l.dumpSettingsAction),
              onPressed: () {
                logger.i(
                  '[SettingsDump] theme=$themeMode notifications=$notifications funAnim=$funAnimations autoplay=$autoplayAudio',
                );
                AppSnackBar.show(context, l.dumpSettingsToast, isError: false);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Removed old helper translation functions (now using direct getters)

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _SwitchWrapper extends StatelessWidget {
  const _SwitchWrapper({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 4),
      child: child,
    );
  }
}
