import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/providers/gamification_providers.dart';
import 'package:training_app/providers/course_providers.dart';
import 'package:training_app/screens/personal_profile_screen.dart';
import 'package:training_app/screens/trainer_home_screen.dart';
import 'package:training_app/screens/trainee_home_screen.dart';
import 'package:training_app/screens/course_details_screen.dart';
import 'package:training_app/screens/badges_overview_screen.dart';
import 'package:training_app/screens/progress_screen.dart';
import 'package:training_app/widgets/skeleton.dart';

/// Unified role‑aware home dashboard.
/// Shows greeting, quick stats (points / level / streak / next badge), recent courses, quick actions.
class HomeDashboardScreen extends ConsumerStatefulWidget {
  const HomeDashboardScreen({super.key, required this.role});
  final String role; // 'trainer' | 'trainee'

  @override
  ConsumerState<HomeDashboardScreen> createState() =>
      _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends ConsumerState<HomeDashboardScreen> {
  bool _requested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_requested) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        requestCurrentUserLoad(ref);
        if (widget.role == 'trainer') {
          requestTrainerCoursesLoad(ref);
        } else {
          requestTraineeCoursesLoad(ref);
        }
      });
      _requested = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(authStateProvider).value;
    final userModel = ref.watch(currentUserModelProvider).value;
    final l = context.l;
    if (authUser == null) {
      return Scaffold(body: Center(child: Text(l.userMissing)));
    }

    final upAsync = ref.watch(userPointsStreamProvider(authUser.uid));
    final nextBadgeAsync = ref.watch(nextBadgeProgressProvider);
    final coursesAsync = widget.role == 'trainer'
        ? ref.watch(trainerCoursesProvider)
        : ref.watch(traineeCoursesProvider);

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          if (widget.role == 'trainer') {
            ref.invalidate(trainerCoursesProvider);
          } else {
            ref.invalidate(traineeCoursesProvider);
          }
          ref.invalidate(userPointsStreamProvider(authUser.uid));
          ref.invalidate(nextBadgeProgressProvider);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context, userModel?.name)),
            SliverToBoxAdapter(
              child: _UnifiedProgressCard(
                upAsync: upAsync,
                nextBadgeAsync: nextBadgeAsync,
              ),
            ),
            SliverToBoxAdapter(
              child: _HorizontalCourses(
                role: widget.role,
                coursesAsync: coursesAsync,
              ),
            ),
            SliverToBoxAdapter(child: _IconActions(role: widget.role)),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String? name) {
    final l = context.l;
    final displayName = name;
    final greeting = widget.role == 'trainer'
        ? (displayName != null
              ? l.greetingTrainer(displayName)
              : l.greetingTrainerFallback)
        : (displayName != null
              ? l.greetingTrainee(displayName)
              : l.greetingTraineeFallback);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const PersonalProfileScreen()),
            ),
            child: Hero(
              tag: 'userAvatarHero',
              child: CircleAvatar(radius: 28, child: const Icon(Icons.person)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              greeting,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _UnifiedProgressCard extends ConsumerWidget {
  final AsyncValue upAsync;
  final AsyncValue nextBadgeAsync;
  const _UnifiedProgressCard({
    required this.upAsync,
    required this.nextBadgeAsync,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final l = context.l;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const ProgressScreen())),
        child: Container(
          decoration: BoxDecoration(
            // Replaced deprecated surfaceVariant with surfaceContainer* tones
            color: isDark
                ? cs.surfaceContainerHighest.withValues(alpha: .25)
                : cs.surfaceContainerHigh.withValues(alpha: .45),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(18),
          child: upAsync.when(
            loading: () => const _MiniSkeleton(),
            error: (e, _) => Text(l.loadErrorGeneric(e.toString())),
            data: (up) {
              final points = up?.points ?? 0;
              final badges = up?.badges.length ?? 0;
              final lvl = computeLevel(points);
              final lp = computeLevelProgress(points);
              final percent = lp.percent;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          child: Text(
                            '${l.pointsLabel}: $points',
                            key: ValueKey('pts_$points'),
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: cs.primaryContainer,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          child: Text(
                            'L$lvl',
                            key: ValueKey('lvl_$lvl'),
                            style: TextStyle(
                              color: cs.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const BadgesOverviewScreen(),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: cs.secondaryContainer,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.military_tech, size: 16),
                              const SizedBox(width: 4),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 350),
                                child: Text(
                                  '$badges',
                                  key: ValueKey('bdg_$badges'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TweenAnimationBuilder<double>(
                    key: ValueKey('lvlbar_$lvl'),
                    tween: Tween(begin: 0, end: percent),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    builder: (ctx, v, _) => ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: v,
                        minHeight: 8,
                        backgroundColor: cs.outlineVariant.withValues(
                          alpha: .25,
                        ),
                        valueColor: AlwaysStoppedAnimation(cs.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  nextBadgeAsync.when(
                    loading: () => const SizedBox(
                      height: 16,
                      child: LinearProgressIndicator(),
                    ),
                    error: (_, __) => Text(
                      l.nextBadgeShort,
                      style: const TextStyle(fontSize: 12),
                    ),
                    data: (data) {
                      if (data == null || data.nextThreshold == null) {
                        return Text(
                          l.nextBadgeShort,
                          style: const TextStyle(fontSize: 12),
                        );
                      }
                      final pct = (data.currentPoints / data.nextThreshold!)
                          .clamp(0, 1.0);
                      return Text(
                        '${l.nextBadgeShort}: ${data.currentPoints}/${data.nextThreshold} (${(pct * 100).toStringAsFixed(0)}%)',
                        style: Theme.of(context).textTheme.bodySmall,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HorizontalCourses extends ConsumerWidget {
  final String role;
  final AsyncValue coursesAsync;
  const _HorizontalCourses({required this.role, required this.coursesAsync});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    role == 'trainer'
                        ? l.trainerCoursesSubtitle
                        : l.traineeCoursesSubtitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => role == 'trainer'
                          ? const TrainerHomeScreen()
                          : const TraineeHomeScreen(),
                    ),
                  ),
                  child: Text(l.dashboardSeeAll),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 140,
            child: coursesAsync.when(
              loading: () => ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) => const SizedBox(
                  width: 110,
                  child: ListTileSkeleton(withAvatar: false),
                ),
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: 3,
              ),
              error: (e, _) =>
                  Center(child: Text(l.loadErrorGeneric(e.toString()))),
              data: (courses) {
                if (courses.isEmpty) {
                  return Center(
                    child: Text(
                      role == 'trainer'
                          ? l.noTrainerCoursesTitleAlt
                          : l.noTraineeCoursesTitleAlt,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                final preview = courses.take(10).toList();
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) {
                    final c = preview[i];
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CourseDetailsScreen(
                            courseId: c.id,
                            courseName: c.name,
                            trainerId: c.trainerId,
                          ),
                        ),
                      ),
                      child: Container(
                        width: 160,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                              .withValues(alpha: .25),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              role == 'trainer'
                                  ? l.courseCodePrefix(c.courseCode)
                                  : l.trainerPrefix(c.trainerId),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemCount: preview.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _IconActions extends StatelessWidget {
  final String role;
  const _IconActions({required this.role});
  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ActionButton(
            icon: Icons.add_circle_outline,
            label: role == 'trainer' ? l.actionNewCourse : l.actionJoin,
            color: cs.primary,
            onTap: () => role == 'trainer'
                ? TrainerHomeScreen.createCourse(context)
                : TraineeHomeScreen.joinCourse(context),
          ),
          _ActionButton(
            icon: Icons.military_tech_outlined,
            label: l.badgesLabel,
            color: cs.secondary,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const BadgesOverviewScreen()),
            ),
          ),
          _ActionButton(
            icon: Icons.auto_graph_outlined,
            label: l.progressTitle,
            color: cs.tertiary,
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ProgressScreen())),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: onTap,
          child: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: .15),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 80,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _MiniSkeleton extends StatelessWidget {
  const _MiniSkeleton();
  @override
  Widget build(BuildContext context) {
    final base = Container(
      height: 10,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 70,
          height: 14,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 110,
          height: 18,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .35),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        base,
      ],
    );
  }
}
