import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/comment_section_widget.dart';
import '../widgets/common/loading_widget.dart';
import '../widgets/common/error_widget.dart';
import '../widgets/common/empty_state_widget.dart';
import '../constants/app_constants.dart';
import '../utils/error_handler.dart';
import '../utils/validators.dart';
import '../services/notification_service.dart';
import 'trainee_list_screen.dart';
import 'my_evaluations_screen.dart';
import 'resource_library_screen.dart';
import 'quiz_list_screen.dart';

class CourseDetailsScreen extends StatefulWidget {
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
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _postController = TextEditingController();
  final _currentUser = FirebaseAuth.instance.currentUser;
  final _notificationService = OneSignalNotificationService();
  bool _isLoading = false;

  Future<void> _sendNotificationsToTrainees(String authorEmail, String courseName) async {
    try {
      final courseDoc = await FirebaseFirestore.instance
          .collection(AppConstants.coursesCollection)
          .doc(widget.courseId)
          .get();
      
      if (!courseDoc.exists) return;
      
      final courseData = courseDoc.data() as Map<String, dynamic>?;
      final trainees = List<String>.from(courseData?[AppConstants.traineesField] ?? []);
      if (trainees.isEmpty) return;

      final tokensSnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.usersCollection)
          .where(FieldPath.documentId, whereIn: trainees)
          .get();
      
      final List<String> playerIds = tokensSnapshot.docs
          .map((doc) => doc.data()[AppConstants.oneSignalPlayerIdField] as String?)
          .where((id) => id != null)
          .toList()
          .cast<String>();

      if (playerIds.isEmpty) return;

      await _notificationService.sendNotification(
        playerIds: playerIds,
        title: "منشور جديد في: $courseName",
        content: "قام $authorEmail بإضافة منشور جديد.",
      );
    } catch (e) {
      ErrorHandler.logError('CourseDetailsScreen._sendNotificationsToTrainees', e);
    }
  }

  Future<void> _addPost() async {
    if (!_formKey.currentState!.validate() || _currentUser == null) return;

    setState(() { _isLoading = true; });

    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.courseWallCollection)
          .add({
        AppConstants.courseIdField: widget.courseId,
        AppConstants.contentField: _postController.text.trim(),
        AppConstants.authorIdField: _currentUser!.uid,
        AppConstants.authorEmailField: _currentUser!.email,
        AppConstants.createdAtField: FieldValue.serverTimestamp(),
      });

      _postController.clear();
      FocusScope.of(context).unfocus();
      
      await _sendNotificationsToTrainees(
        _currentUser!.email ?? 'المدرب',
        widget.courseName,
      );

      if (mounted) {
        context.showSuccessSnackBar(AppConstants.postAddedMessage);
      }
    } catch (e) {
      ErrorHandler.logError('CourseDetailsScreen._addPost', e);
      if (mounted) {
        context.showErrorSnackBar(ErrorHandler.getGenericErrorMessage(e));
      }
    } finally {
      if (mounted) {
        setState(() { _isLoading = false; });
      }
    }
  }

  Future<void> _navigateToTraineeList() async {
    try {
      final courseDoc = await FirebaseFirestore.instance
          .collection(AppConstants.coursesCollection)
          .doc(widget.courseId)
          .get();
      
      if (!courseDoc.exists) {
        throw Exception("لم يتم العثور على الكورس");
      }
      
      final courseData = courseDoc.data() as Map<String, dynamic>?;
      final traineesData = courseData?[AppConstants.traineesField];
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
      ErrorHandler.logError('CourseDetailsScreen._navigateToTraineeList', e);
      if (mounted) {
        context.showErrorSnackBar(ErrorHandler.getGenericErrorMessage(e));
      }
    }
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTrainer = _currentUser?.uid == widget.trainerId;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
        actions: [
          IconButton(
            icon: const Icon(Icons.quiz_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => QuizListScreen(
                    courseId: widget.courseId,
                    isTrainer: isTrainer,
                  ),
                ),
              );
            },
            tooltip: 'الاختبارات',
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
            IconButton(icon: const Icon(Icons.people_alt_outlined), onPressed: _navigateToTraineeList, tooltip: 'عرض المتدربين'),
          if (!isTrainer)
            IconButton(icon: const Icon(Icons.assignment_turned_in_outlined), onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyEvaluationsScreen(courseId: widget.courseId)));
            }, tooltip: 'عرض تقييماتي'),
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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(AppConstants.courseWallCollection)
          .where(AppConstants.courseIdField, isEqualTo: widget.courseId)
          .orderBy(AppConstants.createdAtField, descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CustomErrorWidget(
            message: ErrorHandler.getGenericErrorMessage(snapshot.error),
            onRetry: () => setState(() {}),
          );
        }
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget(message: 'جاري تحميل المنشورات...');
        }
        
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          final isTrainer = _currentUser?.uid == widget.trainerId;
          return NoPostsWidget(
            canAddPost: isTrainer,
            onAddPost: isTrainer ? () {
              // Focus on the text field at the bottom
              FocusScope.of(context).requestFocus();
            } : null,
          );
        }

        final posts = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          padding: const EdgeInsets.all(AppConstants.defaultMargin),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            final postData = post.data() as Map<String, dynamic>;
            final content = postData[AppConstants.contentField] as String? ?? '';
            final author = postData[AppConstants.authorEmailField] as String? ?? 'غير معروف';

            return Card(
              margin: const EdgeInsets.symmetric(vertical: AppConstants.defaultMargin),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius + 4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppConstants.defaultPadding,
                      AppConstants.defaultPadding,
                      AppConstants.defaultPadding,
                      AppConstants.defaultMargin,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'نشر بواسطة: $author',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
                      ],
                    ),
                  ),
                  CommentSectionWidget(postId: post.id),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPostComposer() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultMargin),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _postController,
                validator: Validators.validatePostContent,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'اكتب منشورًا جديدًا...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.defaultPadding,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppConstants.defaultMargin),
            LoadingOverlay(
              isLoading: _isLoading,
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: _isLoading ? null : _addPost,
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}