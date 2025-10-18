import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/core/l10n_ext.dart';
import '../providers/auth_provider.dart';
import '../services/preferences_service.dart';
import 'trainer_home_screen.dart';
import 'trainee_home_screen.dart';
import 'home_dashboard_screen.dart';
import 'personal_profile_screen.dart';
import 'progress_screen.dart';
import 'settings_screen.dart';
import 'direct_messages_screen.dart';
import '../services/guided_tour_service.dart';

/// Shared bottom navigation shell (adapts to role trainer/trainee for first tab).
class BottomNavShell extends ConsumerStatefulWidget {
  const BottomNavShell({super.key, required this.role});
  final String role; // 'trainer' or 'trainee'

  @override
  ConsumerState<BottomNavShell> createState() => _BottomNavShellState();
}

class _BottomNavShellState extends ConsumerState<BottomNavShell>
    with TickerProviderStateMixin {
  int _index = 0;
  late final List<Widget> _pages;
  late final AnimationController _fadeController;
  bool _onboardingShown = false;
  // Keys for tour
  final _kDashboard = GlobalKey();
  final _kFab = GlobalKey();
  final _kProfile = GlobalKey();
  final _kSettings = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pages = [
      // Unified dashboard (still can deep-link to legacy trainer/trainee lists)
      HomeDashboardScreen(role: widget.role),
      const ProgressScreen(),
      const DirectMessagesScreen(), // 💬 Direct Messages
      const PersonalProfileScreen(),
      const SettingsScreen(),
    ];
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..forward();
    _restoreLastIndex();
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeShowOnboarding());
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _onTap(int i) {
    if (i == _index) return;
    setState(() {
      _index = i;
    });
    _fadeController.forward(from: 0);
    PreferencesService.instance().then(
      (p) => p.set('last_nav_index', i.toString()),
    );
  }

  Future<void> _restoreLastIndex() async {
    final p = await PreferencesService.instance();
    final s = p.getString('last_nav_index');
    final parsed = s == null ? null : int.tryParse(s);
    if (parsed != null && parsed >= 0 && parsed < _pages.length && mounted) {
      setState(() => _index = parsed);
    }
  }

  Future<void> _maybeShowOnboarding() async {
    final p = await PreferencesService.instance();
    final done = p.getBool('onboarding_done') ?? false;
    if (done || !mounted || _onboardingShown) return;
    _onboardingShown = true;
    final startTour = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => const _OnboardingSheet(),
    );
    if (!mounted) return;
    await p.set('onboarding_done', true);
    if (startTour == true && mounted) {
      // Build the tour steps and start the tour now that the sheet is closed.
      final service = ref.read(guidedTourServiceProvider);
      final role = widget.role;
      final l2 = context.l;
      final steps = [
        TourStep(
          key: _kDashboard,
          title: l2.tourDashboardTitle,
          body: l2.tourDashboardBody,
        ),
        TourStep(
          key: _kFab,
          title:
              role == 'trainer' ? l2.tourFabTitleTrainer : l2.tourFabTitleTrainee,
          body: role == 'trainer'
              ? l2.tourFabBodyTrainer
              : l2.tourFabBodyTrainee,
        ),
        TourStep(
          key: _kProfile,
          title: l2.tourProfileTitle,
          body: l2.tourProfileBody,
        ),
        TourStep(
          key: _kSettings,
          title: l2.tourSettingsTitle,
          body: l2.tourSettingsBody,
        ),
      ];
      service.start(context, steps);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(authStateProvider); // keep listening for sign-out -> rebuild
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, anim) =>
            FadeTransition(opacity: anim, child: child),
        child: KeyedSubtree(
          key: ValueKey('page_$_index'),
          child: _pages[_index],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _onTap,
        destinations: [
          NavigationDestination(
            key: _kDashboard,
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard),
            label: widget.role == 'trainer'
                ? context.l.navDashboardTrainer
                : context.l.navHomeTrainee,
          ),
          NavigationDestination(
            icon: const Icon(Icons.auto_graph_outlined),
            selectedIcon: const Icon(Icons.auto_graph),
            label: context.l.progressTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.chat_bubble_outline),
            selectedIcon: const Icon(Icons.chat_bubble),
            label: 'Messages',
          ),
          NavigationDestination(
            key: _kProfile,
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: context.l.navProfile,
          ),
          NavigationDestination(
            key: _kSettings,
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: context.l.navSettings,
          ),
        ],
      ),
      floatingActionButton: _fabForIndexAndRole(),
    );
  }

  Widget? _fabForIndexAndRole() {
    if (_index != 0 && _index != 2) return null; // FAB في التبويب الأول والـMessages
    
    // FAB for Messages tab (index 2) - New Chat
    if (_index == 2) {
      return FloatingActionButton.extended(
        key: _kFab,
        heroTag: 'fab_new_chat',
        onPressed: () {
          // Navigate to DirectMessagesScreen and trigger new chat
          // The DirectMessagesScreen already has a FAB for new chat
        },
        icon: const Icon(Icons.chat),
        label: const Text('New Chat'),
      );
    }
    
    // FAB for Dashboard (index 0)
    if (widget.role == 'trainer') {
      final l = context.l;
      return FloatingActionButton.extended(
        key: _kFab,
        heroTag: 'fab_create_course_shell',
        onPressed: () => TrainerHomeScreen.createCourse(context),
        icon: const Icon(Icons.add),
        label: Text(l.actionNewCourse),
      );
    } else {
      final l = context.l;
      return FloatingActionButton.extended(
        key: _kFab,
        heroTag: 'fab_join_course_shell',
        onPressed: () => TraineeHomeScreen.joinCourse(context),
        icon: const Icon(Icons.add),
        label: Text(l.actionJoin),
      );
    }
  }
}

class _OnboardingSheet extends ConsumerWidget {
  const _OnboardingSheet();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final roleText = l.onboardingRoleNote;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l.onboardingTitle,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _OnboardingPoint(
              icon: Icons.dashboard,
              title: l.onboardingPointDashboardTitle,
              body: l.onboardingPointDashboardBody,
            ),
            _OnboardingPoint(
              icon: Icons.person,
              title: l.onboardingPointProfileTitle,
              body: l.onboardingPointProfileBody,
            ),
            _OnboardingPoint(
              icon: Icons.settings,
              title: l.onboardingPointSettingsTitle,
              body: l.onboardingPointSettingsBody,
            ),
            const SizedBox(height: 8),
            Text(
              roleText,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              icon: const Icon(Icons.check_circle_outline),
              label: Text(l.onboardingStart),
              onPressed: () {
                final nav = Navigator.of(context);
                nav.pop();
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.tour),
              label: Text(l.onboardingFullTour),
              onPressed: () {
                // Close the sheet and signal to start the tour from the parent.
                Navigator.of(context).pop(true);
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () {
                  final nav = Navigator.of(context);
                  nav.pop();
                },
                child: Text(l.onboardingLater),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPoint extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  const _OnboardingPoint({
    required this.icon,
    required this.title,
    required this.body,
  });
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: cs.onPrimaryContainer, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
