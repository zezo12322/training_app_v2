import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/comment_section_widget.dart';
import 'trainee_list_screen.dart';
import 'my_evaluations_screen.dart';
import 'resource_library_screen.dart';
import 'quiz_list_screen.dart';
import '../services/notification_service.dart';

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
  final _postController = TextEditingController();
  final _currentUser = FirebaseAuth.instance.currentUser;
  final _notificationService = OneSignalNotificationService();

  Future<void> _sendNotificationsToTrainees(String authorEmail, String courseName) async {
    try {
      final courseDoc = await FirebaseFirestore.instance.collection('courses').doc(widget.courseId).get();
      if (!courseDoc.exists) return;
      final trainees = List<String>.from(courseDoc.data()?['trainees'] ?? []);
      if (trainees.isEmpty) return;

      final tokensSnapshot = await FirebaseFirestore.instance.collection('users').where(FieldPath.documentId, whereIn: trainees).get();
      final List<String> playerIds = tokensSnapshot.docs
          .map((doc) => doc.data()['oneSignalPlayerId'] as String?)
          .where((id) => id != null).toList().cast<String>();

      if (playerIds.isEmpty) return;

      // Use the notification service instead of direct HTTP calls
      await _notificationService.sendNotification(
        playerIds: playerIds,
        title: "منشور جديد في: $courseName",
        content: "قام $authorEmail بإضافة منشور جديد.",
      );
    } catch (e) {
      print('Error sending OneSignal notifications: $e');
    }
  }

  Future<void> _addPost() async {
    final content = _postController.text.trim();
    if (content.isEmpty || _currentUser == null) return;
    try {
      await FirebaseFirestore.instance.collection('course_wall').add({
        'courseId': widget.courseId,
        'content': content,
        'authorId': _currentUser.uid,
        'authorEmail': _currentUser.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      _postController.clear();
      FocusScope.of(context).unfocus();
      await _sendNotificationsToTrainees(_currentUser.email ?? 'المدرب', widget.courseName);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
    }
  }

  Future<void> _navigateToTraineeList() async {
    try {
      final courseDoc = await FirebaseFirestore.instance.collection('courses').doc(widget.courseId).get();
      if (!courseDoc.exists) throw Exception("لم يتم العثور على الكورس");
      final traineesData = courseDoc.data()?['trainees'];
      final List<String> traineeIds = traineesData is List ? List<String>.from(traineesData) : [];
      if (!mounted) return;
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => TraineeListScreen(courseId: widget.courseId, traineeIds: traineeIds)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
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
      stream: FirebaseFirestore.instance.collection('course_wall')
          .where('courseId', isEqualTo: widget.courseId).orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('حدث خطأ: ${snapshot.error}'));
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.message_outlined, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text('لا توجد منشورات حتى الآن', style: TextStyle(fontSize: 18)),
              ],
            ),
          );
        }

        final posts = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          padding: const EdgeInsets.all(8.0),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            final postData = post.data() as Map<String, dynamic>;
            final content = postData['content'] as String;
            final author = postData['authorEmail'] as String? ?? 'غير معروف';

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
                fillColor: Colors.grey.withOpacity(0.1),
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