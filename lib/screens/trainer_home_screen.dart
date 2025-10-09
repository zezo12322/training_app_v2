import 'package:flutter/material.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/course_providers.dart';
import 'package:training_app/core/bootstrap.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/models/course.dart';
import 'create_course_screen.dart'; // kept single import (deduplicated)
import '../providers/settings_providers.dart';
import '../widgets/animations/slide_fade_in.dart';
import 'course_details_screen.dart';
import 'personal_profile_screen.dart';
import '../widgets/skeleton.dart';
import 'auth_wrapper.dart';

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

class _TrainerHomeScreenState extends ConsumerState<TrainerHomeScreen> {
  bool _requested = false;

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
    final content = Column(
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
                    final l2 =
                        ctx.l; // local context variant (animation/scope safety)
                    final text = userModel?.name != null
                        ? l2.greetingTrainer(userModel!.name)
                        : l2.greetingTrainerFallback;
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
            l.trainerCoursesSubtitle,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
        const Divider(indent: 16, endIndent: 16, height: 16),
        Expanded(child: _CoursesTrainerList(coursesAsync: coursesAsync)),
      ],
    );

    if (widget.embed) return SafeArea(child: content);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.dashboardTitleTrainer),
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
        heroTag: 'trainer_home_fab',
        onPressed: () => TrainerHomeScreen.createCourse(context),
        icon: const Icon(Icons.add),
        label: Text(l.createCourseFab),
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
          itemBuilder: (_, i) => const ListTileSkeleton(withAvatar: false),
        ),
        error: (err, _) =>
            Center(child: Text(l.loadCoursesError(err.toString()))),
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
                padding: const EdgeInsets.symmetric(vertical: 60),
                children: [
                  Icon(
                    Icons.school_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      l.noTrainerCoursesTitleAlt,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      l.noTrainerCoursesHintAlt,
                      style: const TextStyle(color: Colors.grey),
                    ),
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 3,
      shadowColor: const Color(0x1A000000),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: const Icon(Icons.book, size: 30),
        title: Text(
          course.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(context.l.courseCodePrefix(course.courseCode)),
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
