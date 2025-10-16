import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/providers/wall_post_providers.dart';
import 'package:training_app/providers/wall_filter_providers.dart';
import 'package:training_app/providers/gamification/gamification_providers.dart';
import 'package:training_app/core/logging.dart';
import 'package:training_app/services/notification_service.dart';
import '../widgets/wall_post_card.dart';
import '../widgets/add_post_dialog.dart';
import '../widgets/create_poll_dialog.dart';
import '../widgets/wall_search_bar.dart';
import '../widgets/gamification/progress_card.dart';
import 'trainee_list_screen.dart';
import 'my_evaluations_screen.dart';
import 'resource_library_screen.dart';
import 'quiz_hub_screen.dart';
import 'badges_overview_screen.dart';
import 'gamification/gamification_settings_screen.dart';
import 'gamification/modules_screen.dart';
import 'gamification/leaderboard_screen.dart';
import 'gamification/achievements_screen.dart';
import 'gamification/analytics_dashboard_screen.dart';

class CourseDetailsScreen extends ConsumerStatefulWidget {
  final String courseId;
  final String courseName;
  final String trainerId;

  const CourseDetailsScreen({
    super.key,
    required this.courseId,
    required this.courseName,
    required this.trainerId,
  });

  @override
  ConsumerState<CourseDetailsScreen> createState() =>
      _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends ConsumerState<CourseDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // 🎮 تحديث Daily Streak عند فتح الكورس
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkDailyStreak();
    });
  }

  Future<void> _checkDailyStreak() async {
    try {
      final authState = ref.read(authStateProvider);
      final userId = authState.value?.uid;
      
      if (userId != null) {
        final updateStreak = ref.read(updateDailyStreakProvider);
        await updateStreak(userId, widget.courseId);
      }
    } catch (e) {
      // Silent fail - لا نزعج المستخدم
      logger.w('Failed to update daily streak', error: e);
    }
  }

  Future<void> _sendNotificationsToTrainees(
    String authorEmail,
    String courseName,
  ) async {
    try {
      final courseDoc = await FirebaseFirestore.instance
          .collection('courses')
          .doc(widget.courseId)
          .get();
      if (!courseDoc.exists) return;
      final trainees = List<String>.from(courseDoc.data()?['trainees'] ?? []);
      if (trainees.isEmpty) return;
      await OneSignalNotificationService().sendNotificationViaBackend(
        userIds: trainees,
        title: 'منشور جديد في: $courseName',
        content: 'قام $authorEmail بإضافة منشور جديد.',
      );
    } catch (e, st) {
      logger.w(
        'Failed sending wall post notifications: $e',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> _navigateToTraineeList() async {
    try {
      final courseDoc = await FirebaseFirestore.instance
          .collection('courses')
          .doc(widget.courseId)
          .get();
      if (!courseDoc.exists) throw Exception("لم يتم العثور على الكورس");
      final traineesData = courseDoc.data()?['trainees'];
      final List<String> traineeIds = traineesData is List
          ? List<String>.from(traineesData)
          : [];
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TraineeListScreen(
            courseId: widget.courseId,
            traineeIds: traineeIds,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      AppSnackBar.show(context, 'حدث خطأ: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(authStateProvider).value;
    final isTrainer = authUser?.uid == widget.trainerId;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            tooltip: 'المزيد من الخيارات',
            onSelected: (value) {
              switch (value) {
                case 'badges':
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const BadgesOverviewScreen()),
                  );
                  break;
                case 'modules':
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ModulesScreen(courseId: widget.courseId),
                    ),
                  );
                  break;
                case 'quizzes':
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QuizHubScreen(courseId: widget.courseId),
                    ),
                  );
                  break;
                case 'resources':
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ResourceLibraryScreen(
                        courseId: widget.courseId,
                        isTrainer: isTrainer,
                      ),
                    ),
                  );
                  break;
                case 'trainees':
                  _navigateToTraineeList();
                  break;
                case 'gamification':
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GamificationSettingsScreen(
                        courseId: widget.courseId,
                        courseName: widget.courseName,
                      ),
                    ),
                  );
                  break;
                case 'leaderboard':
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LeaderboardScreen(courseId: widget.courseId),
                    ),
                  );
                  break;
                case 'achievements':
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AchievementsScreen(courseId: widget.courseId),
                    ),
                  );
                  break;
                case 'analytics':
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AnalyticsDashboardScreen(courseId: widget.courseId),
                    ),
                  );
                  break;
                case 'evaluations':
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MyEvaluationsScreen(courseId: widget.courseId),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'badges',
                child: ListTile(
                  leading: Icon(Icons.emoji_events_outlined),
                  title: Text('الشارات والإنجازات'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'leaderboard',
                child: ListTile(
                  leading: Icon(Icons.leaderboard_outlined),
                  title: Text('لوحة المتصدرين'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'achievements',
                child: ListTile(
                  leading: Icon(Icons.military_tech_outlined),
                  title: Text('الإنجازات'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'modules',
                child: ListTile(
                  leading: Icon(Icons.school_outlined),
                  title: Text('الوحدات التعليمية'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'quizzes',
                child: ListTile(
                  leading: Icon(Icons.quiz_outlined),
                  title: Text('الاختبارات'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'resources',
                child: ListTile(
                  leading: Icon(Icons.folder_copy_outlined),
                  title: Text('مكتبة الموارد'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              if (isTrainer) ...[
                const PopupMenuItem(
                  value: 'trainees',
                  child: ListTile(
                    leading: Icon(Icons.people_alt_outlined),
                    title: Text('المتدربين'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem(
                  value: 'analytics',
                  child: ListTile(
                    leading: Icon(Icons.analytics_outlined),
                    title: Text('تحليلات الكورس'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem(
                  value: 'gamification',
                  child: ListTile(
                    leading: Icon(Icons.settings_outlined),
                    title: Text('إعدادات النقاط'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
              if (!isTrainer)
                const PopupMenuItem(
                  value: 'evaluations',
                  child: ListTile(
                    leading: Icon(Icons.assignment_turned_in_outlined),
                    title: Text('تقييماتي'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          WallSearchBar(courseId: widget.courseId),
          const Divider(height: 1),
          
          // Content
          Expanded(
            child: Column(
              children: [
                // Progress Card
                ProgressCard(
                  courseId: widget.courseId,
                  showStreak: true,
                  onTap: () {
                    // Show course details in dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('معلومات الكورس'),
                        content: const Text('تفاصيل الكورس الكاملة'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('إغلاق'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // Posts List
                Expanded(child: _buildPostsList()),
              ],
            ),
          ),
          if (isTrainer) _buildPostComposer(),
        ],
      ),
    );
  }

  Widget _buildPostsList() {
    final postsAsync = ref.watch(wallPostsStreamProvider(widget.courseId));
    final authUser = ref.watch(authStateProvider).value;
    final userDoc = authUser != null
        ? FirebaseFirestore.instance.collection('users').doc(authUser.uid)
        : null;

    return postsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('حدث خطأ: $e')),
      data: (allPosts) {
        // Apply filters
        final filteredPosts = ref.watch(
          filteredWallPostsProvider(
            (courseId: widget.courseId, posts: allPosts)
          ),
        );
        
        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(wallPostsStreamProvider(widget.courseId));
            await Future<void>.delayed(const Duration(milliseconds: 200));
          },
          child: filteredPosts.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 120),
                    Icon(Icons.forum_outlined,
                        size: 80, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'لا توجد منشورات',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'جرّب تغيير إعدادات البحث',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ],
                )
              : FutureBuilder<bool>(
                  future: userDoc
                      ?.get()
                      .then((doc) => doc.data()?['role'] == 'trainer'),
                  builder: (context, snapshot) {
                    final isTrainer = snapshot.data ?? false;
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        final post = filteredPosts[index];
                        return WallPostCard(
                          post: post,
                          isTrainer: isTrainer,
                        );
                      },
                    );
                  },
                ),
        );
      },
    );
  }

  Widget _buildPostComposer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => _showAddPostDialog(),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'ماذا تريد أن تشارك؟',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 15,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.photo_library, color: Theme.of(context).colorScheme.primary),
                  onPressed: () => _showAddPostDialog(),
                  tooltip: 'إضافة صور',
                ),
                IconButton(
                  icon: Icon(Icons.poll, color: Theme.of(context).colorScheme.secondary),
                  onPressed: () => _showCreatePollDialog(),
                  tooltip: 'إنشاء استطلاع',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddPostDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AddPostDialog(
        courseId: widget.courseId,
        courseName: widget.courseName,
      ),
    );

    if (result == true) {
      // Post was created successfully, notification already sent in dialog
      final authUser = ref.read(authStateProvider).value;
      if (authUser != null) {
        await _sendNotificationsToTrainees(
          authUser.email ?? 'المدرب',
          widget.courseName,
        );
      }
    }
  }

  Future<void> _showCreatePollDialog() async {
    final authUser = ref.read(authStateProvider).value;
    if (authUser == null) {
      AppSnackBar.show(context, 'يجب تسجيل الدخول أولاً');
      return;
    }

    // Create a temporary post ID
    final postId = FirebaseFirestore.instance.collection('course_wall').doc().id;

    // Show poll creation dialog
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => CreatePollDialog(
        postId: postId,
        userId: authUser.uid,
        courseId: widget.courseId,
        authorEmail: authUser.email,
        authorName: authUser.displayName,
      ),
    );

    if (result == true && mounted) {
      // Poll was created successfully
      await _sendNotificationsToTrainees(
        authUser.email ?? 'المدرب',
        widget.courseName,
      );
    }
  }
}