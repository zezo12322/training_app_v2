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
import 'package:training_app/core/l10n_ext.dart';
import 'package:training_app/widgets/widgets.dart';
import 'package:training_app/core/design/tokens.dart';
import 'package:training_app/models/wall_filter.dart';
import 'dashboard_helpers.dart';
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
import 'course_chat_screen.dart';

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

class _CourseDetailsScreenState extends ConsumerState<CourseDetailsScreen> 
    with WidgetsBindingObserver {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // 🎮 تحديث Daily Streak عند فتح الكورس
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkDailyStreak();
    });
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

  void _refreshData() {
    // Invalidate wall posts to refresh content
    ref.invalidate(wallPostsStreamProvider(widget.courseId));
  }

  Future<void> _onRefresh() async {
    _refreshData();
    await Future.delayed(const Duration(milliseconds: 500));
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
        title: context.l.courseDetailsNewPostTitle(courseName),
        content: context.l.courseDetailsNewPostContent(authorEmail),
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
      AppSnackBar.show(context, context.l.courseDetailsError(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final authUser = ref.watch(authStateProvider).value;
    final isTrainer = authUser?.uid == widget.trainerId;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            tooltip: l.courseDetailsMoreOptions,
            onSelected: (value) {
              switch (value) {
                case 'chat':
                  // 💬 Navigate to course chat
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CourseChatScreen(
                        courseId: widget.courseId,
                        courseName: widget.courseName,
                      ),
                    ),
                  );
                  break;
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
              // 💬 Course Chat - للجميع
              PopupMenuItem(
                value: 'chat',
                child: ListTile(
                  leading: const Icon(Icons.chat_bubble_outline),
                  title: const Text('Course Chat'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'badges',
                child: ListTile(
                  leading: const Icon(Icons.emoji_events_outlined),
                  title: Text(l.courseDetailsBadges),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'leaderboard',
                child: ListTile(
                  leading: const Icon(Icons.leaderboard_outlined),
                  title: Text(l.courseDetailsLeaderboard),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'achievements',
                child: ListTile(
                  leading: const Icon(Icons.military_tech_outlined),
                  title: Text(l.courseDetailsAchievements),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'modules',
                child: ListTile(
                  leading: const Icon(Icons.school_outlined),
                  title: Text(l.courseDetailsModules),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'quizzes',
                child: ListTile(
                  leading: const Icon(Icons.quiz_outlined),
                  title: Text(l.courseDetailsQuizzes),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'resources',
                child: ListTile(
                  leading: const Icon(Icons.folder_copy_outlined),
                  title: Text(l.courseDetailsResources),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              if (isTrainer) ...[
                PopupMenuItem(
                  value: 'trainees',
                  child: ListTile(
                    leading: const Icon(Icons.people_alt_outlined),
                    title: Text(l.courseDetailsTrainees),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                PopupMenuItem(
                  value: 'analytics',
                  child: ListTile(
                    leading: const Icon(Icons.analytics_outlined),
                    title: Text(l.courseDetailsAnalytics),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                PopupMenuItem(
                  value: 'gamification',
                  child: ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: Text(l.courseDetailsPointsSettings),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
              if (!isTrainer)
                PopupMenuItem(
                  value: 'evaluations',
                  child: ListTile(
                    leading: const Icon(Icons.assignment_turned_in_outlined),
                    title: Text(l.courseDetailsMyEvaluations),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Column(
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
                          title: Text(l.courseDetailsInfoTitle),
                          content: Text(l.courseDetailsInfoContent),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(l.courseDetailsClose),
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
      ),
    );
  }

  Widget _buildPostsList() {
    final l = context.l;
    final postsAsync = ref.watch(wallPostsStreamProvider(widget.courseId));
    final authUser = ref.watch(authStateProvider).value;
    final userDoc = authUser != null
        ? FirebaseFirestore.instance.collection('users').doc(authUser.uid)
        : null;

    return postsAsync.when(
      loading: () => ListView.builder(
        padding: EdgeInsets.all(DesignTokens.spacingMd),
        itemCount: 3,
        itemBuilder: (_, i) => Padding(
          padding: EdgeInsets.only(bottom: DesignTokens.spacingMd),
          child: AppCard(
            padding: EdgeInsets.all(DesignTokens.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppLoadingSkeleton(
                      type: AppSkeletonType.circle,
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: DesignTokens.spacingSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppLoadingSkeleton(width: 120, height: 14),
                          SizedBox(height: DesignTokens.spacingXs),
                          AppLoadingSkeleton(width: 80, height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: DesignTokens.spacingMd),
                AppLoadingSkeleton(width: double.infinity, height: 16),
                SizedBox(height: DesignTokens.spacingXs),
                AppLoadingSkeleton(width: double.infinity, height: 16),
                SizedBox(height: DesignTokens.spacingXs),
                AppLoadingSkeleton(width: 200, height: 16),
              ],
            ),
          ),
        ),
      ),
      error: (e, _) => AppErrorState(
        message: DashboardErrorHandler.getUserFriendlyMessage(
          e,
          l.courseDetailsError(e.toString()),
        ),
        onRetry: () => ref.invalidate(wallPostsStreamProvider(widget.courseId)),
      ),
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
              ? AppEmptyState(
                  icon: Icons.forum_outlined,
                  title: l.courseDetailsNoPosts,
                  actionLabel: l.courseDetailsChangeFilters,
                  onAction: () {
                    // Reset filters
                    ref.read(wallFilterProvider(widget.courseId).notifier).state = const WallFilter();
                  },
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
    final l = context.l;
    return Padding(
      padding: EdgeInsets.all(DesignTokens.spacingSm),
      child: AppCard(
        padding: EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingMd,
          vertical: DesignTokens.spacingSm,
        ),
        child: InkWell(
          onTap: () => _showAddPostDialog(),
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          child: Row(
            children: [
              AppAvatar(
                name: ref.watch(authStateProvider).value?.displayName ?? 'T',
                size: AppAvatarSize.md,
              ),
              SizedBox(width: DesignTokens.spacingSm),
              Expanded(
                child: Text(
                  l.courseDetailsPlaceholder,
                  style: DesignTokens.body1(context).copyWith(
                    color: DesignTokens.textSecondary(context),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.photo_library,
                  color: DesignTokens.info,
                ),
                onPressed: () => _showAddPostDialog(),
                tooltip: l.courseDetailsAddImages,
              ),
              IconButton(
                icon: Icon(
                  Icons.poll,
                  color: DesignTokens.warning,
                ),
                onPressed: () => _showCreatePollDialog(),
                tooltip: l.courseDetailsCreatePoll,
              ),
            ],
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
          authUser.email ?? context.l.courseDetailsTrainerFallback,
          widget.courseName,
        );
      }
    }
  }

  Future<void> _showCreatePollDialog() async {
    final authUser = ref.read(authStateProvider).value;
    if (authUser == null) {
      AppSnackBar.show(context, context.l.courseDetailsAuthRequired);
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
        authUser.email ?? context.l.courseDetailsTrainerFallback,
        widget.courseName,
      );
    }
  }
}