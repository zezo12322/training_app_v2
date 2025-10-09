import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../core/l10n_ext.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/providers/auth_provider.dart';
import 'package:training_app/providers/wall_post_providers.dart';
import 'package:training_app/models/wall_post.dart';
import 'package:training_app/core/logging.dart';
import 'package:training_app/services/notification_service.dart';
import '../widgets/comment_section_widget.dart';
import 'trainee_list_screen.dart';
import 'my_evaluations_screen.dart';
import 'resource_library_screen.dart';
import 'quiz_hub_screen.dart'; // استبدال شاشة قائمة الاختبارات القديمة بالهاب الجديد
import 'badges_overview_screen.dart';
// Removed direct HTTP OneSignal calls; handled via backend service.

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
  final _postController = TextEditingController();

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

  Future<void> _addPost() async {
    final content = _postController.text.trim();
    if (content.isEmpty) return;
    final authUser = ref.read(authStateProvider).value;
    if (authUser == null) return;
    final repo = ref.read(wallPostRepositoryProvider);
    // Optimistic insert: create a temp post in a local provider override list (simple approach: show SnackBar only)
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 1200),
          content: Text(context.l.postPublishing),
        ),
      );
    }
    final result = await repo.addPost(
      courseId: widget.courseId,
      content: content,
      authorId: authUser.uid,
      authorEmail: authUser.email ?? 'مدرب',
    );
    result.when(
      success: (_) async {
        _postController.clear();
        FocusScope.of(context).unfocus();
        await _sendNotificationsToTrainees(
          authUser.email ?? 'المدرب',
          widget.courseName,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(context.l.postPublished)));
        }
      },
      failure: (f) {
        if (mounted) {
          AppSnackBar.show(context, 'حدث خطأ: ${f.message}');
        }
      },
    );
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
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(authStateProvider).value;
    final isTrainer = authUser?.uid == widget.trainerId;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events_outlined),
            tooltip: 'الشارات',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const BadgesOverviewScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.quiz_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      QuizHubScreen(courseId: widget.courseId),
                ),
              );
            },
            tooltip: 'الاختبارات (Hub)',
          ),
          IconButton(
            icon: const Icon(Icons.folder_copy_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ResourceLibraryScreen(
                    courseId: widget.courseId,
                    isTrainer: isTrainer,
                  ),
                ),
              );
            },
            tooltip: 'مكتبة الموارد',
          ),
          if (isTrainer)
            IconButton(
              icon: const Icon(Icons.people_alt_outlined),
              onPressed: _navigateToTraineeList,
              tooltip: 'عرض المتدربين',
            ),
          if (!isTrainer)
            IconButton(
              icon: const Icon(Icons.assignment_turned_in_outlined),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        MyEvaluationsScreen(courseId: widget.courseId),
                  ),
                );
              },
              tooltip: 'عرض تقييماتي',
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildPostsList()),
          if (isTrainer) _buildPostComposer(),
        ],
      ),
    );
  }

  Widget _buildPostsList() {
    final postsAsync = ref.watch(wallPostsStreamProvider(widget.courseId));
    return postsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('حدث خطأ: $e')),
      data: (posts) {
        return RefreshIndicator(
          onRefresh: () async {
            // إبطال الـ provider لإجبار إعادة الاشتراك (Riverpod سينشئ stream جديد)
            ref.invalidate(wallPostsStreamProvider(widget.courseId));
            await Future<void>.delayed(const Duration(milliseconds: 200));
          },
          child: posts.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(height: 120),
                    Icon(Icons.message_outlined, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        'لا توجد منشورات حتى الآن',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  reverse: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8.0),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final WallPost post = posts[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'نشر بواسطة: ${post.authorEmail ?? post.authorId}',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  post.content,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CommentSectionWidget(postId: post.id),
                        ],
                      ),
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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _postController,
              decoration: InputDecoration(
                hintText: 'اكتب منشورًا جديدًا...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.withValues(alpha: 0.1),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _addPost,
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
