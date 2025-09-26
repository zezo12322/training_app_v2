import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentSectionWidget extends StatefulWidget {
  final String postId;

  const CommentSectionWidget({super.key, required this.postId});

  @override
  State<CommentSectionWidget> createState() => _CommentSectionWidgetState();
}

class _CommentSectionWidgetState extends State<CommentSectionWidget> {
  final _commentController = TextEditingController();
  final _currentUser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _addComment() async {
    final content = _commentController.text.trim();
    if (content.isEmpty || _currentUser == null) return;

    final userData = await FirebaseFirestore.instance.collection('users').doc(_currentUser.uid).get();
    final userName = userData.data()?['name'] ?? 'مستخدم غير معروف';
    final userImageUrl = userData.data()?['imageUrl'] as String?;

    await FirebaseFirestore.instance.collection('post_comments').add({
      'postId': widget.postId,
      'content': content,
      'authorId': _currentUser.uid,
      'authorName': userName,
      'authorImageUrl': userImageUrl,
      'createdAt': FieldValue.serverTimestamp(),
    });

    _commentController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      // لون خلفية أفتح قليلاً لتمييز قسم التعليقات
      color: Colors.grey.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('post_comments')
                .where('postId', isEqualTo: widget.postId)
                .orderBy('createdAt', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2.0)),
                ));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const SizedBox.shrink();
              }

              final comments = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: comments.map((doc) {
                    final commentData = doc.data() as Map<String, dynamic>;
                    final authorName = commentData['authorName'] ?? 'مستخدم';
                    final content = commentData['content'] ?? '';
                    final authorImageUrl = commentData['authorImageUrl'] as String?;

                    return ListTile(
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundImage: authorImageUrl != null ? NetworkImage(authorImageUrl) : null,
                        child: authorImageUrl == null ? const Icon(Icons.person, size: 18) : null,
                      ),
                      title: Text(authorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      subtitle: Text(content, style: const TextStyle(fontSize: 14)),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'اكتب تعليقًا...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _addComment,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}