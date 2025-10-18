import 'package:flutter/material.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/course_providers.dart';
import 'package:training_app/core/bootstrap.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/models/course.dart';
import 'package:training_app/screens/dashboard_helpers.dart';
import 'create_course_screen.dart';
import '../providers/settings_providers.dart';
import '../widgets/animations/slide_fade_in.dart';
import 'course_details_screen.dart';
import 'personal_profile_screen.dart';
import 'auth_wrapper.dart';
import '../core/design/tokens.dart';
import '../widgets/widgets.dart';

class TrainerHomeScreen extends ConsumerStatefulWidget {
  final bool embed; // if true, hide own Scaffold and AppBar (used inside shell)
  const TrainerHomeScreen({super.key, this.embed = false});

  static void createCourse(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const CreateCourseScreen()));
  }

  @override
  ConsumerState<TrainerHomeScreen> createState() => _TrainerHomeScreenState();
}

class _TrainerHomeScreenState extends ConsumerState<TrainerHomeScreen> with WidgetsBindingObserver {
  bool _requested = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // عند العودة للتطبيق أو الشاشة، نعمل refresh
    if (state == AppLifecycleState.resumed) {
      _refreshData();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_requested) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        requestCurrentUserLoad(ref);
        requestTrainerCoursesLoad(ref);
      });
      _requested = true;
    }
  }

  void _refreshData() {
    // تحديث بيانات المستخدم والكورسات
    ref.invalidate(currentUserModelProvider);
    ref.invalidate(trainerCoursesProvider);
    requestCurrentUserLoad(ref);
    requestTrainerCoursesLoad(ref);
  }

  Future<void> _onRefresh() async {
    _refreshData();
    // انتظر قليلاً لإعطاء الوقت للبيانات أن تتحدث
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(authStateProvider).value;
    final userModel = ref
        .watch(currentUserModelProvider)
        .value; // قد تكون null مبدئياً
    final coursesAsync = ref.watch(trainerCoursesProvider);

    if (authUser == null) {
      final l = context.l;
      return Scaffold(body: Center(child: Text(l.userMissing)));
    }

    final l = context.l;
    final content = RefreshIndicator(
      onRefresh: _onRefresh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Avatar and Greeting
          Container(
            color: DesignTokens.surface(context),
            padding: EdgeInsets.all(DesignTokens.spacingLg),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PersonalProfileScreen(),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'userAvatarHero',
                    child: AppAvatar(
                      imageUrl: userModel?.imageUrl,
                      name: userModel?.name ?? 'Trainer',
                      size: AppAvatarSize.lg,
                      showOnlineStatus: true,
                      isOnline: true,
                    ),
                  ),
                ),
                SizedBox(width: DesignTokens.spacingLg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userModel?.name != null
                            ? l.greetingTrainer(userModel!.name)
                            : l.greetingTrainerFallback,
                        style: DesignTokens.h5(context),
                      ),
                      SizedBox(height: DesignTokens.spacingXs),
                      Text(
                        l.trainerCoursesSubtitle,
                        style: DesignTokens.body2(context).copyWith(
                          color: DesignTokens.textSecondary(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: DesignTokens.spacingSm),
          // Stats Dashboard
          _StatsSection(coursesAsync: coursesAsync),
          SizedBox(height: DesignTokens.spacingLg),
          // Courses Section Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: DesignTokens.spacingLg),
            child: Text(
              context.l.navDashboardTrainer,
              style: DesignTokens.h6(context),
            ),
          ),
          SizedBox(height: DesignTokens.spacingMd),
          Expanded(child: _CoursesTrainerList(coursesAsync: coursesAsync)),
        ],
      ),
    );

    if (widget.embed) return SafeArea(child: content);
    return Scaffold(
      backgroundColor: DesignTokens.background(context),
      appBar: AppBar(
        backgroundColor: DesignTokens.surface(context),
        elevation: 0,
        title: Text(
          l.dashboardTitleTrainer,
          style: DesignTokens.h6(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: DesignTokens.textPrimary(context),
            ),
            onPressed: () async {
              await ref.read(authRepositoryProvider).signOut();
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthWrapper()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: content,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'trainer_home_fab',
        backgroundColor: DesignTokens.info,
        onPressed: () => TrainerHomeScreen.createCourse(context),
        icon: Icon(Icons.add, color: DesignTokens.textOnColor(context)),
        label: Text(
          l.createCourseFab,
          style: DesignTokens.button(context).copyWith(
            color: DesignTokens.textOnColor(context),
          ),
        ),
      ),
    );
  }
}

// Stats Dashboard Section
class _StatsSection extends ConsumerWidget {
  final AsyncValue<List<Course>> coursesAsync;
  const _StatsSection({required this.coursesAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DesignTokens.spacingLg),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive: 4 cards on desktop, 2 on tablet/mobile
          final crossAxisCount = constraints.maxWidth > 900
              ? 4
              : constraints.maxWidth > 600
                  ? 2
                  : 2;

          return coursesAsync.when(
            loading: () => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: DesignTokens.spacingMd,
                mainAxisSpacing: DesignTokens.spacingMd,
                childAspectRatio: 1.5,
              ),
              itemCount: 4,
              itemBuilder: (ctx, i) => AppLoadingSkeleton(
                type: AppSkeletonType.roundedRectangle,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            error: (e, _) => AppErrorState(
              message: DashboardErrorHandler.getUserFriendlyMessage(
                e,
                'Failed to load stats',
              ),
              onRetry: () => ref.invalidate(trainerCoursesProvider),
            ),
            data: (courses) {
              final totalCourses = courses.length;
              final totalStudents = courses.fold<int>(
                0,
                (sum, course) => sum + course.trainees.length,
              );

              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: DesignTokens.spacingMd,
                mainAxisSpacing: DesignTokens.spacingMd,
                childAspectRatio: 1.5,
                children: [
                  _StatCard(
                    icon: Icons.book_outlined,
                    iconColor: DesignTokens.info,
                    title: 'Total Courses',
                    value: totalCourses.toString(),
                  ),
                  _StatCard(
                    icon: Icons.people_outline,
                    iconColor: DesignTokens.success,
                    title: 'Total Students',
                    value: totalStudents.toString(),
                  ),
                  _StatCard(
                    icon: Icons.workspace_premium,
                    iconColor: DesignTokens.warning,
                    title: 'Active Courses',
                    value: totalCourses.toString(), // All courses are active
                  ),
                  _StatCard(
                    icon: Icons.schedule,
                    iconColor: const Color(0xFF9C27B0), // Purple
                    title: 'This Week',
                    value: '0', // TODO: Calculate weekly activity
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// Individual Stat Card
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(DesignTokens.spacingLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(DesignTokens.spacingSm),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: Icon(
                icon,
                size: 24,
                color: iconColor,
              ),
            ),
            SizedBox(height: DesignTokens.spacingMd),
            Text(
              value,
              style: DesignTokens.h4(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: DesignTokens.spacingXs),
            Text(
              title,
              style: DesignTokens.caption(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoursesTrainerList extends ConsumerWidget {
  final AsyncValue<List<Course>> coursesAsync;
  const _CoursesTrainerList({required this.coursesAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    return trace(
      '_trainerHome.coursesSection',
      () => coursesAsync.when(
        loading: () => ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (ctx, i) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: DesignTokens.spacingMd,
              vertical: DesignTokens.spacingSm,
            ),
            child: AppSkeletonLayouts.card(ctx),
          ),
        ),
        error: (err, _) => AppErrorState(
          message: DashboardErrorHandler.getUserFriendlyMessage(
            err,
            'Failed to load courses',
          ),
          onRetry: () => ref.invalidate(trainerCoursesProvider),
        ),
        data: (courses) {
          final limit = currentTrainerLimit(ref);
          if (courses.isEmpty) {
            // اجعل الشاشة قابلة للسحب للتحديث حتى في حالة عدم وجود عناصر
            return RefreshIndicator(
              onRefresh: () async {
                // إعادة تحميل البيانات عبر إبطال الـ provider
                ref.invalidate(trainerCoursesProvider);
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(DesignTokens.spacingXl),
                children: [
                  AppEmptyState(
                    icon: Icons.school_outlined,
                    title: l.noTrainerCoursesTitleAlt,
                    description: l.noTrainerCoursesHintAlt,
                    actionLabel: l.createCourseFab,
                    onAction: () => TrainerHomeScreen.createCourse(context),
                  ),
                ],
              ),
            );
          }
          final showLoadMore = courses.length >= limit; // heuristic
          return trace(
            '_trainerHome.coursesListBuild',
            () => RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(trainerCoursesProvider);
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                itemCount: courses.length + (showLoadMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (showLoadMore && index == courses.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: TextButton(
                          onPressed: () => loadMoreTrainerCourses(ref),
                          child: Text(context.l.loadMore),
                        ),
                      ),
                    );
                  }
                  final course = courses[index];
                  final funAnim = ref.watch(funAnimationsProvider);
                  return SlideFadeIn(
                    index: index,
                    enable: funAnim,
                    child: TrainerCourseTile(course: course),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class TrainerCourseTile extends StatelessWidget {
  final Course course;
  const TrainerCourseTile({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingSm,
        vertical: DesignTokens.spacingSm,
      ),
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
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingLg,
          vertical: DesignTokens.spacingMd,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(DesignTokens.spacingMd),
              decoration: BoxDecoration(
                color: DesignTokens.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: Icon(
                Icons.book,
                size: 28,
                color: DesignTokens.info,
              ),
            ),
            SizedBox(width: DesignTokens.spacingLg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    style: DesignTokens.body1(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: DesignTokens.spacingXs),
                  Text(
                    context.l.courseCodePrefix(course.courseCode),
                    style: DesignTokens.caption(context),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: DesignTokens.textSecondary(context),
            ),
          ],
        ),
      ),
    );
  }
}
