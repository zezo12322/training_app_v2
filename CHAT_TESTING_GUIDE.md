# Chat System - Testing Guide

## ⚠️ مشاكل تم إصلاحها

### 1. **Sign-out Crash** (CRITICAL)

**المشكلة:**
```
W/Firestore: Listen for Query(...) failed: Status{code=PERMISSION_DENIED}
Lost connection to device.
```

التطبيق كان يتعطل عند تسجيل الخروج بسبب استمرار الـ StreamProviders في محاولة قراءة البيانات بعد sign-out.

**الحل:**
تم إضافة `.autoDispose` لجميع الـ StreamProviders التي تقرأ بيانات المستخدم:

#### الملفات المعدلة:

1. **`lib/providers/gamification_providers.dart`**
   ```dart
   // قبل
   final allBadgesStreamProvider = StreamProvider<List<Badge>>((ref) {...});
   
   // بعد
   final allBadgesStreamProvider = StreamProvider.autoDispose<List<Badge>>((ref) {...});
   ```

2. **`lib/providers/feed_providers.dart`**
   ```dart
   // قبل
   final userFeedProvider = StreamProvider.family<List<FeedEvent>, String>((ref, userId) {...});
   
   // بعد
   final userFeedProvider = StreamProvider.autoDispose.family<List<FeedEvent>, String>((ref, userId) {...});
   ```

3. **`lib/providers/badge_management_providers.dart`**
   ```dart
   // قبل
   final activeBadgesProvider = StreamProvider<List<Badge>>((ref) {...});
   final allBadgesStreamProvider = StreamProvider<List<Badge>>((ref) {...});
   
   // بعد
   final activeBadgesProvider = StreamProvider.autoDispose<List<Badge>>((ref) {...});
   final allBadgesStreamProvider = StreamProvider.autoDispose<List<Badge>>((ref) {...});
   ```

4. **`lib/providers/evaluation_thread_providers.dart`**
   ```dart
   // قبل
   final evaluationRepliesProvider = StreamProvider.family<List<ReplyModel>, String>((ref, id) {...});
   final evaluationMetaProvider = StreamProvider.family<DocumentSnapshot?, String>((ref, id) {...});
   final evaluationTasksProvider = StreamProvider.family<List<TaskModel>, String>((ref, id) {...});
   
   // بعد
   final evaluationRepliesProvider = StreamProvider.autoDispose.family<List<ReplyModel>, String>((ref, id) {...});
   final evaluationMetaProvider = StreamProvider.autoDispose.family<DocumentSnapshot?, String>((ref, id) {...});
   final evaluationTasksProvider = StreamProvider.autoDispose.family<List<TaskModel>, String>((ref, id) {...});
   ```

**النتيجة:**
- ✅ الـ providers تنظف نفسها تلقائياً عند عدم استخدامها
- ✅ لا توجد قراءات Firestore بعد sign-out
- ✅ لا يوجد crash عند تسجيل الخروج

---

## 📝 دليل الاختبار

### 1. اختبار تسجيل الخروج

**الخطوات:**
1. سجل دخول للتطبيق
2. انتقل لأي شاشة تستخدم StreamProviders (Home, Badges, Profile)
3. انتقل للإعدادات → تسجيل الخروج
4. **المتوقع**: التطبيق يعود لشاشة تسجيل الدخول بدون crash

**قبل الإصلاح:**
```
W/Firestore: PERMISSION_DENIED
Lost connection to device.
```

**بعد الإصلاح:**
```
D/FirebaseAuth: Notifying auth state listeners about a sign-out event.
[SUCCESS] Return to login screen
```

### 2. اختبار Chat System

**الخطوات:**
1. سجل دخول كمستخدم (trainer/trainee)
2. ادخل على أي كورس
3. اضغط على زر "محادثة الكورس" (يجب إضافته في CourseDetailScreen)
4. أرسل رسالة
5. **المتوقع**: الرسالة تظهر فوراً مع Real-time updates

**اختبار Edit/Delete:**
1. اضغط مطولاً على رسالتك
2. اختر "تعديل" → عدّل النص → احفظ
3. **المتوقع**: الرسالة تتحدث مع علامة "(معدلة)"
4. اضغط مطولاً مرة أخرى → "حذف"
5. **المتوقع**: الرسالة تظهر "رسالة محذوفة"

### 3. اختبار Multi-User Chat

**الخطوات:**
1. سجل دخول من جهازين مختلفين (أو متصفحين)
2. ادخل على نفس الكورس
3. أرسل رسالة من الجهاز الأول
4. **المتوقع**: الرسالة تظهر فوراً في الجهاز الثاني

### 4. اختبار Security Rules

**الخطوات:**
1. حاول الوصول لـ chat room من tenant مختلف
2. **المتوقع**: PERMISSION_DENIED
3. حاول إرسال رسالة كمستخدم محظور
4. **المتوقع**: PERMISSION_DENIED

---

## 🔧 الميزات المكتملة

### ✅ Phase 1 - MVP
- [x] Course Chat rooms
- [x] Send/Receive messages
- [x] Real-time updates
- [x] Edit messages
- [x] Delete messages (soft delete)
- [x] Flag messages
- [x] Tenant isolation
- [x] Role-based access control
- [x] Firestore indexes (4 composite)
- [x] Security rules
- [x] Auto-scroll to bottom
- [x] RTL support

### ⏳ Phase 2 - Enhanced (Optional)
- [ ] Unread count badges
- [ ] Push notifications for new messages
- [ ] Direct Messages (1-on-1)
- [ ] Image attachments
- [ ] Typing indicators
- [ ] Read receipts
- [ ] Message search

---

## 🐛 مشاكل معروفة

### ⚠️ Firebase Unavailable Error (FIXED)

**المشكلة:**
```
FirebaseException ([cloud_firestore/unavailable] 
The service is currently unavailable.)
```

**السبب:**
- عدم وجود اتصال بالإنترنت
- مشكلة مؤقتة في Firebase servers
- Firestore في وضع offline

**الحل:**
1. **FirebaseErrorHandler** - Helper class للتعامل مع أخطاء Firebase:
   - كشف تلقائي لأخطاء الاتصال
   - رسائل واضحة للمستخدم بالعربية
   - زر "إعادة المحاولة" تلقائي
   
2. **Offline Persistence** - مفعّل بالفعل في main.dart:
   ```dart
   FirebaseFirestore.instance.settings = const Settings(
     persistenceEnabled: true,
     cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
   );
   ```

3. **Better Error UX**:
   - أيقونات واضحة (cloud_off للإنترنت، error_outline للأخطاء الأخرى)
   - رسائل مفهومة بالعربية
   - زر Retry واضح

**ملاحظة:** التطبيق يعمل offline مع البيانات المخزنة مسبقاً!

---

### Minor Issues:
1. **withOpacity deprecated** - تحذيرات فقط، لا تؤثر على الوظائف
2. **super parameters** - code style تحذيرات، لا تؤثر

### Future Improvements:
1. إضافة pagination للرسائل (حالياً limit 50)
2. إضافة message reactions (like, love, etc.)
3. إضافة file attachments (PDF, docs)
4. إضافة voice messages

---

## 📊 الأداء

### Firestore Reads:
- **Initial load**: ~20-50 messages
- **New message**: 1 read
- **Real-time listener**: Minimal overhead

### Indexes المستخدمة:
1. `chat_rooms`: institutionId + companyId + participantIds + isActive + lastMessageAt
2. `chat_rooms`: type + courseId + institutionId + companyId
3. `messages`: isDeleted + isModerated + createdAt
4. `messages`: authorId + createdAt

### Performance Tips:
- استخدم `limit` في `streamMessages` (افتراضي: 50)
- الـ providers تستخدم `.autoDispose` للتنظيف التلقائي
- الـ listeners تتوقف تلقائياً عند مغادرة الشاشة

---

## 🔒 الأمان

### Tenant Isolation:
```dart
// كل chat room يجب أن يطابق tenant المستخدم
institutionId == userDoc().data.institutionId
companyId == userDoc().data.companyId
```

### Role-Based Access:
```dart
// فقط المشاركين يمكنهم القراءة/الكتابة
request.auth.uid in resource.data.participantIds

// المسؤولون يمكنهم حذف أي رسالة
isCompanyAdmin() || isOrgAdmin() || isSuperAdmin()
```

### Block/Mute:
```dart
// المستخدمون المحظورون لا يمكنهم الكتابة
!blockedUsers.hasAny([request.auth.uid])

// الغرف المكتومة (client-side only)
isMutedBy(userId)
```

---

## 📖 كيفية الاستخدام

### إضافة Chat إلى شاشة الكورس:

```dart
// في course_detail_screen.dart
FloatingActionButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseChatScreen(
          courseId: widget.courseId,
          courseName: courseName,
        ),
      ),
    );
  },
  child: const Icon(Icons.chat),
)
```

### استخدام Chat في أي مكان:

```dart
// الحصول على chat room
final roomAsync = ref.watch(
  courseChatRoomProvider(
    CourseChatRoomParams(
      courseId: courseId,
      courseName: courseName,
    ),
  ),
);

// إرسال رسالة
final sendMessage = ref.read(sendMessageProvider);
await sendMessage(CreateChatMessageDto(
  chatRoomId: roomId,
  courseId: courseId,
  institutionId: user.institutionId!,
  companyId: user.companyId!,
  authorId: user.id,
  authorName: user.name,
  authorRole: user.role,
  content: messageText,
));

// قراءة الرسائل
final messagesAsync = ref.watch(chatMessagesProvider(roomId));
```

---

## 🎯 Next Steps

1. ✅ إصلاح sign-out crash
2. ⏳ إضافة unread count badges
3. ⏳ إضافة push notifications
4. ⏳ اختبار على أجهزة متعددة
5. ⏳ Performance testing مع 100+ رسالة
6. ⏳ إضافة chat button في CourseDetailScreen

---

**تاريخ التحديث**: 12 أكتوبر 2025  
**الحالة**: جاهز للاختبار ✅
