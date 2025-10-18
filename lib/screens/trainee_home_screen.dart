import 'package:flutter/material.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/course_providers.dart';
import 'package:training_app/core/bootstrap.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/models/course.dart';
import 'package:training_app/screens/dashboard_helpers.dart';
import 'package:training_app/widgets/widgets.dart';
import 'package:training_app/core/design/tokens.dart';
import 'join_course_screen.dart';
import '../providers/settings_providers.dart';
import '../widgets/animations/slide_fade_in.dart';
import 'course_details_screen.dart';
import 'personal_profile_screen.dart';
import 'auth_wrapper.dart';

class TraineeHomeScreen extends ConsumerStatefulWidget {
  final bool embed;
  const TraineeHomeScreen({super.key, this.embed = false});

  static void joinCourse(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const JoinCourseScreen()));
  }

  @override
  ConsumerState<TraineeHomeScreen> createState() => _TraineeHomeScreenState();
}

class _TraineeHomeScreenState extends ConsumerState<TraineeHomeScreen> 
    with WidgetsBindingObserver {
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
        requestTraineeCoursesLoad(ref);
      });
      _requested = true;
    }
  }

  void _refreshData() {
    ref.invalidate(currentUserModelProvider);
    ref.invalidate(traineeCoursesProvider);
    requestCurrentUserLoad(ref);
    requestTraineeCoursesLoad(ref);
  }

  Future<void> _onRefresh() async {
    _refreshData();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(authStateProvider).value;
    final userModel = ref.watch(currentUserModelProvider).value;
    final coursesAsync = ref.watch(traineeCoursesProvider);

    if (authUser == null) {
      return Scaffold(body: Center(child: Text(context.l.userMissing)));
    }

    final content = RefreshIndicator(
      onRefresh: _onRefresh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
                    child: CircleAvatar(
                      radius: 26,
                      backgroundImage: (userModel?.imageUrl != null)
                          ? NetworkImage(userModel!.imageUrl!)
                          : null,
                      child: userModel?.imageUrl == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Builder(
                    builder: (ctx) {
                      final l = ctx.l;
                      final text = userModel?.name != null
                          ? l.greetingTrainee(userModel!.name)
                          : l.greetingTraineeFallback;
                      return Text(
                        text,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              context.l.traineeCoursesSubtitle,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
          const Divider(indent: 16, endIndent: 16, height: 16),
          Expanded(child: _CoursesTraineeList(coursesAsync: coursesAsync)),
        ],
      ),
    );
    if (widget.embed) return SafeArea(child: content);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.homeTitleTrainee),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
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
        heroTag: 'trainee_home_fab',
        onPressed: () => TraineeHomeScreen.joinCourse(context),
        icon: const Icon(Icons.add),
        label: Text(context.l.actionJoin),
      ),
    );
  }
}

class _CoursesTraineeList extends ConsumerWidget {
  final AsyncValue<List<Course>> coursesAsync;
  const _CoursesTraineeList({required this.coursesAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return trace(
      '_traineeHome.coursesSection',
      () => coursesAsync.when(
        loading: () => ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (_, i) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: DesignTokens.spacingMd,
              vertical: DesignTokens.spacingSm,
            ),
            child: DashboardSkeletons.courseCard(),
          ),
        ),
        error: (err, _) => AppErrorState(
          message: DashboardErrorHandler.getUserFriendlyMessage(
            err,
            'Failed to load courses',
          ),
          onRetry: () => ref.invalidate(traineeCoursesProvider),
        ),
        data: (courses) {
          final limit = currentTraineeLimit(ref);
          final showLoadMore = courses.isNotEmpty && courses.length >= limit;
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(traineeCoursesProvider);
              await Future<void>.delayed(const Duration(milliseconds: 150));
            },
            child: courses.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: DesignTokens.spacingXxl),
                    children: [
                      AppEmptyState(
                        icon: Icons.school_outlined,
                        title: context.l.noTraineeCoursesTitleAlt,
                        actionLabel: context.l.actionJoin,
                        onAction: () => TraineeHomeScreen.joinCourse(context),
                      ),
                    ],
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: courses.length + (showLoadMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (showLoadMore && index == courses.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: TextButton(
                              onPressed: () => loadMoreTraineeCourses(ref),
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
                        child: TraineeCourseTile(course: course),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}

// مزود يقوم بجلب اسم مستخدم (مدرب) من مجموعة users مع كاش داخلي بسيط
final trainerNameProvider = FutureProvider.family<String?, String>((
  ref,
  userId,
) async {
  if (userId.isEmpty) return null;
  try {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
    if (!doc.exists) return null;
    return (doc.data() ?? const {})['name'] as String?;
  } catch (_) {
    return null; // نفشل بصمت لكي لا نعطل الـ UI
  }
});

class TraineeCourseTile extends ConsumerWidget {
  final Course course;
  const TraineeCourseTile({super.key, required this.course});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainerNameAsync = ref.watch(trainerNameProvider(course.trainerId));
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 3,
      shadowColor: const Color(0x1A000000),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: const Icon(Icons.class_, size: 30),
        title: Text(
          course.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: trainerNameAsync.when(
          data: (name) =>
              Text(context.l.trainerPrefix(name ?? course.trainerId)),
          loading: () => Text(context.l.trainerPrefix('…')),
          error: (_, __) => Text(context.l.trainerPrefix(course.trainerId)),
        ),
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
  }
}
