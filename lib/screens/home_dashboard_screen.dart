import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:training_app/core/design/tokens.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/providers/gamification_providers.dart';
import 'package:training_app/providers/course_providers.dart';
import 'package:training_app/screens/personal_profile_screen.dart';
import 'package:training_app/screens/trainer_home_screen.dart';
import 'package:training_app/screens/trainee_home_screen.dart';
import 'package:training_app/screens/course_details_screen.dart';
import 'package:training_app/screens/badges_overview_screen.dart';
import 'package:training_app/screens/progress_screen.dart';
import 'package:training_app/screens/dashboard_helpers.dart';
import 'package:training_app/widgets/widgets.dart';

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
    
    // Role-based badge
    final roleBadge = widget.role == 'trainer' 
        ? AppBadge(
            text: l.roleTrainer,
            type: AppBadgeType.info,
            size: AppBadgeSize.sm,
          )
        : AppBadge(
            text: l.roleTrainee,
            type: AppBadgeType.success,
            size: AppBadgeSize.sm,
          );
    
    return Padding(
      padding: EdgeInsets.all(DesignTokens.spacingLg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const PersonalProfileScreen()),
            ),
            child: Hero(
              tag: 'userAvatarHero',
              child: AppAvatar(
                name: displayName ?? l.userMissing,
                size: AppAvatarSize.lg,
                showOnlineStatus: true,
                isOnline: true,
              ),
            ),
          ),
          SizedBox(width: DesignTokens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: DesignTokens.h4(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: DesignTokens.spacingXs),
                roleBadge,
              ],
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
    final l = context.l;
    
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingLg,
        vertical: DesignTokens.spacingSm,
      ),
      child: AppCard(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ProgressScreen()),
        ),
        child: upAsync.when(
          loading: () => DashboardSkeletons.statsCard(),
          error: (e, _) => AppErrorState(
            message: DashboardErrorHandler.getUserFriendlyMessage(
              e,
              'Failed to load stats',
            ),
            onRetry: () => ref.invalidate(userPointsStreamProvider),
          ),
          data: (up) {
            final points = up?.points ?? 0;
            final badges = up?.badges.length ?? 0;
            final lvl = computeLevel(points);
            final lp = computeLevelProgress(points);
            final percent = lp.percent;
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Points and Level Row
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
                          style: DesignTokens.h5(context).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      switchInCurve: Curves.easeOutBack,
                      switchOutCurve: Curves.easeInBack,
                      transitionBuilder: (child, animation) => ScaleTransition(
                        scale: animation,
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      ),
                      child: AppBadge(
                        key: ValueKey('lvl_$lvl'),
                        text: 'L$lvl',
                        type: AppBadgeType.primary,
                        size: AppBadgeSize.md,
                      ),
                    ),
                    SizedBox(width: DesignTokens.spacingSm),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const BadgesOverviewScreen(),
                        ),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        switchInCurve: Curves.easeOutBack,
                        switchOutCurve: Curves.easeInBack,
                        transitionBuilder: (child, animation) => ScaleTransition(
                          scale: animation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        ),
                        child: AppBadge(
                          key: ValueKey('bdg_$badges'),
                          text: '$badges',
                          type: AppBadgeType.success,
                          size: AppBadgeSize.md,
                          icon: Icons.military_tech,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: DesignTokens.spacingMd),
                
                // Level Progress Bar
                TweenAnimationBuilder<double>(
                  key: ValueKey('lvlbar_$lvl'),
                  tween: Tween(begin: 0, end: percent),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  builder: (ctx, v, _) => AppProgressBar(
                    progress: v,
                    height: 8,
                  ),
                ),
                SizedBox(height: DesignTokens.spacingSm),
                
                // Next Badge Info
                nextBadgeAsync.when(
                  loading: () => const SizedBox(
                    height: 16,
                    child: LinearProgressIndicator(),
                  ),
                  error: (_, __) => Text(
                    l.nextBadgeShort,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  data: (data) {
                    if (data == null || data.nextThreshold == null) {
                      return Text(
                        l.nextBadgeShort,
                        style: Theme.of(context).textTheme.bodySmall,
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
      padding: EdgeInsets.only(
        top: DesignTokens.spacingSm,
        bottom: DesignTokens.spacingXs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: DesignTokens.spacingLg,
              vertical: DesignTokens.spacingXs,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    role == 'trainer'
                        ? l.trainerCoursesSubtitle
                        : l.traineeCoursesSubtitle,
                    style: DesignTokens.h5(context).copyWith(
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
                padding: EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacingLg,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) => DashboardSkeletons.courseCard(),
                separatorBuilder: (_, __) => SizedBox(
                  width: DesignTokens.spacingMd,
                ),
                itemCount: 3,
              ),
              error: (e, _) => AppErrorState(
                message: DashboardErrorHandler.getUserFriendlyMessage(
                  e,
                  'Failed to load courses',
                ),
                onRetry: () {
                  if (role == 'trainer') {
                    ref.invalidate(trainerCoursesProvider);
                  } else {
                    ref.invalidate(traineeCoursesProvider);
                  }
                },
              ),
              data: (courses) {
                if (courses.isEmpty) {
                  return AppEmptyState(
                    icon: Icons.school_outlined,
                    title: role == 'trainer'
                        ? l.noTrainerCoursesTitleAlt
                        : l.noTraineeCoursesTitleAlt,
                    actionLabel: role == 'trainer' ? l.actionNewCourse : l.actionJoin,
                    onAction: () => role == 'trainer'
                        ? TrainerHomeScreen.createCourse(context)
                        : TraineeHomeScreen.joinCourse(context),
                  );
                }
                final preview = courses.take(10).toList();
                return ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacingLg,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) {
                    final c = preview[i];
                    return AppCard(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CourseDetailsScreen(
                            courseId: c.id,
                            courseName: c.name,
                            trainerId: c.trainerId,
                          ),
                        ),
                      ),
                      child: SizedBox(
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              role == 'trainer'
                                  ? l.courseCodePrefix(c.courseCode)
                                  : l.trainerPrefix(c.trainerId),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: DesignTokens.textSecondary(context),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(
                    width: DesignTokens.spacingMd,
                  ),
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
      padding: EdgeInsets.fromLTRB(
        DesignTokens.spacingLg,
        DesignTokens.spacingSm,
        DesignTokens.spacingLg,
        DesignTokens.spacingXs,
      ),
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
            color: DesignTokens.success,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const BadgesOverviewScreen()),
            ),
          ),
          _ActionButton(
            icon: Icons.auto_graph_outlined,
            label: l.progressTitle,
            color: DesignTokens.info,
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
          borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
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
        SizedBox(height: DesignTokens.spacingXs),
        SizedBox(
          width: 80,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
