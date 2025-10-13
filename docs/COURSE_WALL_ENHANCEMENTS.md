# 📰 تحسينات Course Wall - خطة شاملة

> **الأولوية**: 🔥🔥🔥 عاجلة جداً (قبل نظام الدردشة)  
> **الحالة**: قيد التحسين  
> **الوقت المقدر**: 3-5 أيام

---

## 📋 الحالة الحالية

### الموجود حالياً ✅
- `lib/services/course_wall.dart` - الخدمة الأساسية
- `WallPost` model موجود
- Basic CRUD operations
- Comments system

### المشاكل الحالية ❌
1. **UI بسيطة جداً** - تحتاج تحسين كبير
2. **لا يوجد real-time updates** - تحتاج refresh يدوي
3. **التعليقات غير واضحة** - صعب المتابعة
4. **لا يوجد media support** - نص فقط
5. **لا يوجد reactions** - عدم تفاعل
6. **لا يوجد notifications** - المستخدم لا يعرف بالردود

---

## 🎯 الأهداف

### 1. تجربة مستخدم أفضل
- ✅ UI جذابة مع cards مصممة جيداً
- ✅ Animations سلسة
- ✅ Real-time updates
- ✅ Empty states واضحة

### 2. تفاعل أكثر
- ✅ Reactions (👍 ❤️ 🎉 ...)
- ✅ Comments threading (الردود على التعليقات)
- ✅ Mentions (@username)
- ✅ Rich media (صور، ملفات)

### 3. إدارة أفضل
- ✅ Pin posts (تثبيت)
- ✅ Archive/Delete (Trainer only)
- ✅ Edit posts (في أول 15 دقيقة)
- ✅ Report inappropriate content

---

## 📊 نموذج البيانات المحسّن

### Collection: `wall_posts` (تحديث)

```javascript
wall_posts/{postId} {
  // Existing fields
  courseId: string,
  authorId: string,
  authorName: string,
  authorRole: string,            // 'trainer' | 'trainee'
  content: string,               // max 5000 chars
  createdAt: Timestamp,
  
  // NEW: Enhanced fields
  type: 'announcement' | 'discussion' | 'question' | 'poll',
  
  // Media support
  attachments: [{
    url: string,
    type: 'image' | 'pdf' | 'video',
    name: string,
    size: number,
  }],
  
  // Metadata
  editedAt?: Timestamp,
  isPinned: boolean,
  isArchived: boolean,
  
  // Engagement
  reactions: {
    '👍': string[],              // [userId1, userId2, ...]
    '❤️': string[],
    '🎉': string[],
    '🤔': string[],
    '👎': string[],
  },
  
  // Stats (for quick access)
  stats: {
    commentsCount: number,
    reactionsCount: number,
    viewsCount: number,
  },
  
  // Mentions
  mentionedUsers: string[],      // [@userId1, @userId2]
  
  // Poll-specific (if type='poll')
  poll?: {
    question: string,
    options: string[],
    votes: {
      [optionIndex]: string[]    // userId[]
    },
    endsAt?: Timestamp,
    allowMultiple: boolean,
  },
  
  // Moderation
  isReported: boolean,
  reportCount: number,
}
```

### Subcollection: `wall_posts/{postId}/comments`

```javascript
comments/{commentId} {
  authorId: string,
  authorName: string,
  authorRole: string,
  content: string,               // max 2000 chars
  createdAt: Timestamp,
  editedAt?: Timestamp,
  
  // NEW: Threading support
  parentCommentId?: string,      // للردود على تعليقات
  depth: number,                 // مستوى العمق (0, 1, 2 max)
  
  // NEW: Reactions on comments
  reactions: {
    '👍': string[],
    '❤️': string[],
  },
  
  // Mentions
  mentionedUsers: string[],
  
  // Moderation
  isDeleted: boolean,
  deletedBy?: string,
}
```

### Collection: `wall_notifications`

```javascript
wall_notifications/{notificationId} {
  userId: string,                // من سيستقبل الإشعار
  postId: string,
  type: 'new_comment' | 'new_reply' | 'reaction' | 'mention',
  
  // Context
  actorId: string,
  actorName: string,
  actionText: string,            // "علّق على منشورك"
  
  // Status
  read: boolean,
  createdAt: Timestamp,
  
  // Link
  deepLink: string,              // للانتقال للمنشور
}
```

---

## 🎨 تحسينات UI

### 1. Wall Post Card (محسّن)

```dart
// lib/widgets/wall_post_card.dart
class WallPostCard extends ConsumerWidget {
  final WallPost post;
  final bool isDetailed; // true في صفحة التفاصيل
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserModelProvider).value;
    final isAuthor = post.authorId == currentUser?.id;
    final isTrainer = currentUser?.role == 'trainer';
    
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            leading: CircleAvatar(
              child: Text(post.authorName[0]),
              backgroundColor: post.authorRole == 'trainer' 
                ? Colors.blue 
                : Colors.grey,
            ),
            title: Row(
              children: [
                Text(
                  post.authorName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                if (post.authorRole == 'trainer') Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    context.l.trainer,
                    style: TextStyle(fontSize: 10, color: Colors.blue),
                  ),
                ),
                Spacer(),
                if (post.isPinned) Icon(Icons.push_pin, size: 16, color: Colors.orange),
              ],
            ),
            subtitle: Text(
              _formatTimestamp(post.createdAt),
              style: TextStyle(fontSize: 12),
            ),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                if (isAuthor || isTrainer) PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 8),
                      Text(context.l.edit),
                    ],
                  ),
                ),
                if (isTrainer) PopupMenuItem(
                  value: 'pin',
                  child: Row(
                    children: [
                      Icon(post.isPinned ? Icons.push_pin_outlined : Icons.push_pin, size: 20),
                      SizedBox(width: 8),
                      Text(post.isPinned ? context.l.unpin : context.l.pin),
                    ],
                  ),
                ),
                if (isAuthor || isTrainer) PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: Colors.red),
                      SizedBox(width: 8),
                      Text(context.l.delete, style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
                if (!isAuthor) PopupMenuItem(
                  value: 'report',
                  child: Row(
                    children: [
                      Icon(Icons.flag, size: 20, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(context.l.report),
                    ],
                  ),
                ),
              ],
              onSelected: (value) => handleMenuAction(context, ref, value, post),
            ),
          ),
          
          // Type Badge (if announcement or question)
          if (post.type != 'discussion') Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Chip(
              label: Text(
                post.type == 'announcement' ? context.l.announcement : context.l.question,
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: post.type == 'announcement' 
                ? Colors.orange[100] 
                : Colors.green[100],
              avatar: Icon(
                post.type == 'announcement' ? Icons.campaign : Icons.help_outline,
                size: 16,
              ),
            ),
          ),
          
          // Content
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.content,
                  style: TextStyle(fontSize: 15),
                  maxLines: isDetailed ? null : 5,
                  overflow: isDetailed ? null : TextOverflow.ellipsis,
                ),
                if (post.editedAt != null) ...[
                  SizedBox(height: 4),
                  Text(
                    '(${context.l.edited})',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
          
          // Attachments
          if (post.attachments.isNotEmpty) 
            AttachmentsGrid(attachments: post.attachments),
          
          // Poll (if applicable)
          if (post.type == 'poll' && post.poll != null)
            PollWidget(
              poll: post.poll!,
              postId: post.id,
              currentUserId: currentUser?.id,
            ),
          
          Divider(height: 1),
          
          // Reactions & Stats
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Reactions summary
                if (post.stats.reactionsCount > 0) ...[
                  ReactionsSummary(reactions: post.reactions),
                  SizedBox(width: 8),
                  Text(
                    '${post.stats.reactionsCount}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
                Spacer(),
                // Comments count
                TextButton.icon(
                  icon: Icon(Icons.comment, size: 16),
                  label: Text('${post.stats.commentsCount}'),
                  onPressed: () => showCommentsSheet(context, post),
                ),
              ],
            ),
          ),
          
          Divider(height: 1),
          
          // Action Buttons
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              ReactionButton(
                postId: post.id,
                currentReactions: post.reactions,
                userId: currentUser?.id,
              ),
              TextButton.icon(
                icon: Icon(Icons.comment_outlined),
                label: Text(context.l.comment),
                onPressed: () => showCommentsSheet(context, post),
              ),
              TextButton.icon(
                icon: Icon(Icons.share),
                label: Text(context.l.share),
                onPressed: () => sharePost(post),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

### 2. Reaction Button (جديد)

```dart
// lib/widgets/reaction_button.dart
class ReactionButton extends ConsumerWidget {
  final String postId;
  final Map<String, List<String>> currentReactions;
  final String? userId;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (userId == null) return SizedBox.shrink();
    
    // Find user's current reaction
    String? userReaction;
    currentReactions.forEach((emoji, users) {
      if (users.contains(userId)) userReaction = emoji;
    });
    
    return TextButton.icon(
      icon: Icon(
        userReaction != null ? Icons.favorite : Icons.favorite_border,
        color: userReaction != null ? Colors.red : null,
      ),
      label: Text(userReaction ?? context.l.react),
      onPressed: () => showReactionPicker(context, ref, postId, userReaction),
    );
  }
  
  void showReactionPicker(BuildContext context, WidgetRef ref, String postId, String? current) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l.reactToPost,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 16,
              children: ['👍', '❤️', '🎉', '🤔', '👎'].map((emoji) {
                final isSelected = current == emoji;
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    ref.read(toggleReactionProvider((
                      postId: postId,
                      emoji: emoji,
                    )));
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                      border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
                    ),
                    child: Center(
                      child: Text(emoji, style: TextStyle(fontSize: 24)),
                    ),
                  ),
                );
              }).toList(),
            ),
            if (current != null) ...[
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(removeReactionProvider((
                    postId: postId,
                    emoji: current,
                  )));
                },
                child: Text(context.l.removeReaction),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

### 3. Comments Sheet (محسّن)

```dart
// lib/widgets/comments_sheet.dart
void showCommentsSheet(BuildContext context, WallPost post) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => CommentsView(
        post: post,
        scrollController: scrollController,
      ),
    ),
  );
}

class CommentsView extends ConsumerStatefulWidget {
  final WallPost post;
  final ScrollController scrollController;
  
  @override
  _CommentsViewState createState() => _CommentsViewState();
}

class _CommentsViewState extends ConsumerState<CommentsView> {
  final _commentController = TextEditingController();
  String? _replyingToId;
  String? _replyingToName;
  
  @override
  Widget build(BuildContext context) {
    final commentsAsync = ref.watch(wallPostCommentsProvider(widget.post.id));
    
    return Column(
      children: [
        // Handle
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        
        // Header
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                context.l.comments,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                '${widget.post.stats.commentsCount}',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
        
        Divider(height: 1),
        
        // Comments List
        Expanded(
          child: commentsAsync.when(
            data: (comments) {
              if (comments.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.comment_outlined, size: 48, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        context.l.noCommentsYet,
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        context.l.beTheFirst,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                );
              }
              
              return ListView.builder(
                controller: widget.scrollController,
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return CommentTile(
                    comment: comment,
                    onReply: () => setState(() {
                      _replyingToId = comment.id;
                      _replyingToName = comment.authorName;
                    }),
                  );
                },
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error: $e')),
          ),
        ),
        
        Divider(height: 1),
        
        // Comment Input
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Replying indicator
                if (_replyingToId != null) Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.blue[50],
                  child: Row(
                    children: [
                      Icon(Icons.reply, size: 16, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        '${context.l.replyingTo} $_replyingToName',
                        style: TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.close, size: 16),
                        onPressed: () => setState(() {
                          _replyingToId = null;
                          _replyingToName = null;
                        }),
                      ),
                    ],
                  ),
                ),
                
                // Input field
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: context.l.writeComment,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    SizedBox(width: 8),
                    FloatingActionButton.small(
                      onPressed: () => _submitComment(),
                      child: Icon(Icons.send),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  void _submitComment() async {
    if (_commentController.text.trim().isEmpty) return;
    
    final result = await ref.read(
      addWallCommentProvider((
        postId: widget.post.id,
        content: _commentController.text.trim(),
        parentCommentId: _replyingToId,
      )).future,
    );
    
    result.when(
      success: (_) {
        _commentController.clear();
        setState(() {
          _replyingToId = null;
          _replyingToName = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.commentAdded)),
        );
      },
      failure: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      },
    );
  }
}
```

---

## 🔌 Providers المطلوبة

```dart
// lib/providers/wall_providers.dart

// Stream wall posts for a course
final courseWallPostsProvider = StreamProvider.family.autoDispose<List<WallPost>, String>(
  (ref, courseId) {
    return FirebaseFirestore.instance
      .collection('wall_posts')
      .where('courseId', isEqualTo: courseId)
      .where('isArchived', isEqualTo: false)
      .orderBy('isPinned', descending: true)
      .orderBy('createdAt', descending: true)
      .limit(50)
      .snapshots()
      .map((snap) => snap.docs
          .map((doc) => WallPost.fromDoc(doc))
          .toList());
  },
);

// Stream comments for a post
final wallPostCommentsProvider = StreamProvider.family.autoDispose<List<WallComment>, String>(
  (ref, postId) {
    return FirebaseFirestore.instance
      .collection('wall_posts')
      .doc(postId)
      .collection('comments')
      .where('isDeleted', isEqualTo: false)
      .orderBy('createdAt', descending: false)
      .limit(100)
      .snapshots()
      .map((snap) => snap.docs
          .map((doc) => WallComment.fromDoc(doc))
          .toList());
  },
);

// Toggle reaction
final toggleReactionProvider = FutureProvider.family.autoDispose<Result<void>, ({
  String postId,
  String emoji,
})>((ref, params) async {
  try {
    final userId = ref.read(currentUserIdProvider)!;
    final postRef = FirebaseFirestore.instance
      .collection('wall_posts')
      .doc(params.postId);
    
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final doc = await transaction.get(postRef);
      final reactions = Map<String, List<String>>.from(
        doc.data()?['reactions'] ?? {}
      );
      
      // Toggle reaction
      if (reactions[params.emoji]?.contains(userId) ?? false) {
        reactions[params.emoji]!.remove(userId);
      } else {
        // Remove any other reaction first
        reactions.forEach((key, value) {
          value.remove(userId);
        });
        // Add new reaction
        reactions[params.emoji] = [...?reactions[params.emoji], userId];
      }
      
      // Calculate total
      int total = reactions.values.fold(0, (sum, list) => sum + list.length);
      
      transaction.update(postRef, {
        'reactions': reactions,
        'stats.reactionsCount': total,
      });
    });
    
    return Result.success(null);
  } catch (e) {
    return Result.failure(e.toString());
  }
});

// Add comment
final addWallCommentProvider = FutureProvider.family.autoDispose<Result<void>, ({
  String postId,
  String content,
  String? parentCommentId,
})>((ref, params) async {
  try {
    final user = ref.read(currentUserModelProvider).value!;
    
    final commentRef = FirebaseFirestore.instance
      .collection('wall_posts')
      .doc(params.postId)
      .collection('comments')
      .doc();
    
    await commentRef.set({
      'authorId': user.id,
      'authorName': user.name,
      'authorRole': user.role,
      'content': params.content,
      'createdAt': FieldValue.serverTimestamp(),
      if (params.parentCommentId != null) 'parentCommentId': params.parentCommentId,
      'depth': params.parentCommentId != null ? 1 : 0,
      'reactions': {},
      'mentionedUsers': [],
      'isDeleted': false,
    });
    
    // Update post's comment count
    await FirebaseFirestore.instance
      .collection('wall_posts')
      .doc(params.postId)
      .update({
        'stats.commentsCount': FieldValue.increment(1),
      });
    
    return Result.success(null);
  } catch (e) {
    return Result.failure(e.toString());
  }
});

// Pin/Unpin post (Trainer only)
final togglePinPostProvider = FutureProvider.family.autoDispose<Result<void>, String>(
  (ref, postId) async {
    try {
      final postRef = FirebaseFirestore.instance
        .collection('wall_posts')
        .doc(postId);
      
      final doc = await postRef.get();
      final isPinned = doc.data()?['isPinned'] ?? false;
      
      await postRef.update({'isPinned': !isPinned});
      
      return Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  },
);
```

---

## 📋 خطة التنفيذ

### 🔥 Day 1: Backend Updates
- [x] تحديث `WallPost` model
- [x] إضافة `WallComment` model
- [x] تحديث Firestore Rules
- [x] Composite Indexes

### 🔥 Day 2: Basic UI Improvements
- [x] `WallPostCard` محسّن
- [x] Reactions UI
- [x] Empty states

### 🔥 Day 3: Comments System
- [x] Comments sheet
- [x] Threading support
- [x] Reply functionality

### 🔥 Day 4: Advanced Features
- [x] Attachments grid
- [x] Poll widget
- [x] Pin/Archive functionality

### 🔥 Day 5: Testing & Polish
- [x] Unit tests
- [x] UI tests
- [x] Bug fixes
- [x] Performance optimization

---

## ✅ معايير القبول

- ✅ الـ Wall يعمل real-time (Stream-based)
- ✅ Reactions تعمل بسلاسة
- ✅ Comments تدعم الردود (threading)
- ✅ Trainer يمكنه تثبيت/حذف المنشورات
- ✅ UI جذابة ومصممة جيداً
- ✅ Empty states واضحة
- ✅ Animations سلسة
- ✅ Performance ممتاز (< 2s loading)

---

## الخلاصة

تحسينات شاملة لـ Course Wall ستجعله:
1. 🎨 **أكثر جاذبية** - UI محسّن
2. 💬 **أكثر تفاعلية** - Reactions + Comments
3. 🔄 **Real-time** - تحديثات فورية
4. 📱 **User-friendly** - تجربة ممتازة

**الأولوية**: 🔥🔥🔥 **الأعلى** - يجب إنجازها أولاً!

---

**Last Updated**: October 12, 2025  
**Status**: Ready for Implementation 🚀
