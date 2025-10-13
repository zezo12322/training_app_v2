# Day 3 Plan - Comments Threading & Edit Features

**التاريخ:** 12 أكتوبر 2025  
**الوقت المتوقع:** 4-6 ساعات  
**Status:** 🚧 In Progress

---

## 🎯 الأهداف

### 1. Comments Threading (الأولوية الأولى)
- ✅ Backend جاهز (parentCommentId, replyCount موجودة)
- 🔨 إضافة "Reply" button لكل تعليق
- 🔨 عرض الردود بشكل متداخل (nested)
- 🔨 "View X replies" للتوسيع/الطي
- 🔨 UI محسّن للردود (indentation)

### 2. Edit Functionality
- 🔨 Edit post dialog
- 🔨 Edit comment inline
- 🔨 Update repository methods
- ✅ (معدّل) indicator جاهز

### 3. Comment Reactions
- ✅ Backend جاهز (toggleCommentReaction موجود)
- 🔨 إضافة ReactionButton للتعليقات
- 🔨 عرض reactions على التعليقات

### 4. Performance & Polish
- 🔨 Pagination للتعليقات (optional)
- 🔨 Loading states
- 🔨 Error handling improvements

---

## 📋 خطة التنفيذ

### Phase 1: Reply Functionality (90 min)
```
1. تحديث WallCommentsSheet:
   - إضافة "Reply" button
   - State لتتبع الـ reply mode
   - عرض "Replying to @username"
   
2. تحديث _CommentItem:
   - Reply button
   - "View X replies" button
   - Nested replies display
   
3. UI للردود:
   - Indentation (padding-right)
   - Connector line (optional)
   - Avatar أصغر للردود
```

### Phase 2: Edit Posts (60 min)
```
1. إنشاء EditPostDialog:
   - TextField مع المحتوى الحالي
   - Save/Cancel buttons
   
2. تحديث WallPostCard:
   - "Edit" في PopupMenu
   - استدعاء updatePostProvider
   
3. Testing:
   - تعديل المحتوى
   - التحقق من (معدّل) indicator
```

### Phase 3: Edit Comments (45 min)
```
1. Edit inline في _CommentItem:
   - TextField يظهر عند الضغط على Edit
   - استخدام updateWallCommentProvider
   
2. UI:
   - Icon button للـ Edit
   - Save/Cancel buttons
```

### Phase 4: Comment Reactions (60 min)
```
1. إنشاء CommentReactionButton:
   - نسخة مصغرة من ReactionButton
   - استخدام toggleCommentReactionProvider
   
2. تحديث _CommentItem:
   - عرض reactions summary
   - Reaction button
```

### Phase 5: Polish & Testing (60 min)
```
1. Testing شامل
2. Error handling
3. Loading states
4. UX improvements
```

---

## 🎨 UI Mockup - Threaded Comments

```
┌─────────────────────────────────────────┐
│ Comment by Ahmed                        │
│ This is a parent comment                │
│ [👍 2] [Reply] [منذ ساعة]              │
│                                         │
│   └─ Reply by Sara                      │
│      Great point!                       │
│      [❤️ 1] [Reply] [منذ 30 دقيقة]    │
│                                         │
│   └─ Reply by Mohamed                   │
│      I agree                            │
│      [Reply] [منذ 10 دقائق]            │
│                                         │
│ ▼ View 2 more replies                   │
└─────────────────────────────────────────┘
```

---

## 🔧 Technical Details

### Reply State Management
```dart
class _WallCommentsSheetState {
  String? _replyingToCommentId;
  String? _replyingToUsername;
  
  void _setReplyMode(String commentId, String username) {
    setState(() {
      _replyingToCommentId = commentId;
      _replyingToUsername = username;
    });
  }
}
```

### Nested Comments Query
```dart
// Load all comments
final allComments = await commentsStream;

// Separate parent & replies
final parentComments = allComments.where((c) => c.parentCommentId == null);
final replies = allComments.where((c) => c.parentCommentId != null);

// Group replies by parent
Map<String, List<WallComment>> repliesByParent = {};
for (var reply in replies) {
  repliesByParent[reply.parentCommentId] ??= [];
  repliesByParent[reply.parentCommentId]!.add(reply);
}
```

### Edit Post Dialog
```dart
class EditPostDialog extends StatelessWidget {
  final WallPost post;
  final TextEditingController _controller;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('تعديل المنشور'),
      content: TextField(
        controller: _controller,
        maxLines: 5,
      ),
      actions: [
        TextButton(onPressed: cancel),
        ElevatedButton(onPressed: save),
      ],
    );
  }
}
```

---

## ✅ Success Criteria

### Threading:
- [ ] يمكن الرد على أي تعليق
- [ ] الردود تظهر بشكل متداخل
- [ ] Indentation واضح للردود
- [ ] "View replies" يعمل

### Edit:
- [ ] يمكن تعديل المنشورات
- [ ] يمكن تعديل التعليقات
- [ ] (معدّل) indicator يظهر
- [ ] updatedAt timestamp صحيح

### Reactions:
- [ ] يمكن إضافة reaction للتعليق
- [ ] Reactions تظهر على التعليقات
- [ ] Count صحيح

---

## 📊 Progress Tracking

```
Day 3 Progress: ░░░░░░░░░░░░░░░░░░░░ 0%
├── Reply Functionality    ░░░░░░░░░░ 0%
├── Edit Posts            ░░░░░░░░░░ 0%
├── Edit Comments         ░░░░░░░░░░ 0%
├── Comment Reactions     ░░░░░░░░░░ 0%
└── Polish & Testing      ░░░░░░░░░░ 0%
```

---

## 🚀 Let's Start!

**First Task:** Reply Functionality
**Files to Update:**
- `lib/widgets/wall_comments_sheet.dart`
- Create new widget for nested display

Ready? يلا نبدأ! 💪
