# 💬 نظام الدردشة - تصميم شامل (Chat System Design)

> **الأولوية**: 🔥🔥🔥 عاجلة جداً (Phase 5.5 - قبل الإطلاق)  
> **الحالة**: مخطط - جاهز للتنفيذ  
> **الوقت المقدر**: 1-2 أسابيع (MVP)

---

## 📋 جدول المحتويات

1. [نظرة عامة](#نظرة-عامة)
2. [حالات الاستخدام](#حالات-الاستخدام)
3. [نموذج البيانات](#نموذج-البيانات)
4. [قواعد الأمان](#قواعد-الأمان)
5. [واجهات المستخدم](#واجهات-المستخدم)
6. [Providers](#providers)
7. [خطة التنفيذ](#خطة-التنفيذ)

---

## نظرة عامة

نظام دردشة **آمن ومحدود النطاق** (Scoped) يسمح بالتواصل داخل سياقات محددة:
- ✅ **Course Chat**: نقاش داخل الكورس (Trainer + Trainees)
- ✅ **Direct Messages**: رسائل مباشرة محدودة حسب الدور
- ✅ **Assignment Chat**: مناقشات خاصة بالتكليفات
- ✅ **Moderation**: نظام إشراف للمحتوى

### المبادئ الأساسية:
- 🔒 **Security First**: قواعد Firestore صارمة جداً
- 🏢 **Tenant Isolation**: لا يمكن التواصل عبر tenants مختلفة
- 👥 **Role-Based Access**: كل دور له صلاحيات محددة
- 📊 **Audit Trail**: تتبع كامل للرسائل والإجراءات

---

## حالات الاستخدام

### 1. Course Chat (الأساسي) 🎓

**الوصف**: غرفة نقاش لكل كورس

**المشاركون**:
- Trainer (مُشرف)
- جميع Trainees المسجلين
- Manager/Admin (مراقبة فقط - read-only)

**القواعد**:
```
✅ Trainee يرى: رسائله + رسائل Trainer + إعلانات
✅ Trainer يرى: جميع الرسائل
✅ Manager يرى: جميع الرسائل (read-only)
❌ Trainee لا يرى: رسائل Trainees الآخرين (optional privacy mode)
```

**Moderation**:
- Trainer يمكنه حذف أي رسالة
- Trainer يمكنه كتم (mute) متدرب مزعج
- Auto-moderation للكلمات المسيئة (optional)

---

### 2. Direct Messages (DM) 📩

**الأزواج المسموحة**:
```
✅ Trainee → Trainer (في نفس الكورس)
✅ Trainer → Trainee (في نفس الكورس)
✅ Manager → Team Member (في نفس القسم)
✅ Company Admin → أي user في الشركة
✅ Trainer → Manager (نفس التكليف)

❌ Trainee → Trainee (ممنوع)
❌ Cross-tenant messaging (ممنوع)
```

**التحققات**:
- نفس الـ tenant
- علاقة تدريبية/إدارية موجودة
- غير محظور من الطرف الآخر

---

### 3. Assignment Discussion 📝

**الوصف**: نقاش حول Teaching Assignment محدد

**المشاركون**:
- Trainer المُعيّن
- Manager المسؤول
- (Optional) Trainees في القسم

**الاستخدام**:
- تنسيق المحتوى
- تقييمات سريعة
- ملاحظات على الأداء

---

## نموذج البيانات

### Collection: `chat_rooms`

```javascript
chat_rooms/{roomId} {
  // Type & Scope
  type: 'course' | 'direct' | 'assignment' | 'group',
  
  // Scope identifiers (حسب النوع)
  courseId?: string,              // إذا type='course'
  assignmentId?: string,          // إذا type='assignment'
  
  // Participants
  participants: string[],         // [userId1, userId2, ...]
  participantRoles: {             // للتحقق السريع
    [userId]: 'trainer' | 'trainee' | 'manager'
  },
  
  // Tenant isolation (مهم جداً!)
  tenantType: 'company' | 'institution',
  tenantId: string,
  
  // Metadata
  name?: string,                  // للـ group chats فقط
  avatarUrl?: string,
  description?: string,
  
  // Audit
  createdBy: string,
  createdAt: Timestamp,
  updatedAt: Timestamp,
  
  // Last message (للعرض والفرز)
  lastMessage: {
    text: string,
    senderId: string,
    senderName: string,
    sentAt: Timestamp,
  },
  
  // Settings
  isArchived: boolean,
  mutedBy: {[userId]: boolean},   // من قام بكتم الغرفة
  pinnedBy: {[userId]: boolean},  // من قام بتثبيت الغرفة
  
  // Moderation
  isModerated: boolean,           // يحتاج موافقة قبل الإرسال
  moderatorIds: string[],         // Trainers/Managers
  allowedToPost: string[],        // من يُسمح لهم بالنشر
}
```

**Indexes Required**:
```json
{
  "collectionGroup": "chat_rooms",
  "fields": [
    {"fieldPath": "participants", "arrayConfig": "CONTAINS"},
    {"fieldPath": "isArchived", "order": "ASCENDING"},
    {"fieldPath": "updatedAt", "order": "DESCENDING"}
  ]
},
{
  "collectionGroup": "chat_rooms",
  "fields": [
    {"fieldPath": "tenantId", "order": "ASCENDING"},
    {"fieldPath": "type", "order": "ASCENDING"},
    {"fieldPath": "updatedAt", "order": "DESCENDING"}
  ]
}
```

---

### Subcollection: `chat_rooms/{roomId}/messages`

```javascript
messages/{messageId} {
  // Sender info
  senderId: string,
  senderName: string,
  senderRole: string,             // للعرض فقط
  senderAvatarUrl?: string,
  
  // Content
  text: string,                   // max 5000 chars
  type: 'text' | 'image' | 'file' | 'system',
  
  // Attachments (optional)
  attachmentUrl?: string,
  attachmentType?: 'image' | 'pdf' | 'video' | 'audio',
  attachmentName?: string,
  attachmentSize?: number,        // bytes
  
  // Timestamps
  sentAt: Timestamp,
  editedAt?: Timestamp,
  deletedAt?: Timestamp,          // soft delete
  
  // Status
  status: 'pending' | 'sent' | 'deleted' | 'moderated',
  
  // Read receipts (optional - for DMs)
  readBy: {
    [userId]: Timestamp
  },
  
  // Moderation
  needsApproval?: boolean,
  isApproved?: boolean,
  approvedBy?: string,
  approvedAt?: Timestamp,
  
  // Threading (متقدم - Phase 2)
  replyToId?: string,
  threadCount?: number,
  
  // Reactions (متقدم - Phase 2)
  reactions?: {
    [emoji]: string[]             // [userId1, userId2, ...]
  }
}
```

**Indexes Required**:
```json
{
  "collectionGroup": "messages",
  "fields": [
    {"fieldPath": "status", "order": "ASCENDING"},
    {"fieldPath": "sentAt", "order": "DESCENDING"}
  ]
}
```

---

### Collection: `user_chat_metadata`

```javascript
user_chat_metadata/{userId} {
  rooms: {
    [roomId]: {
      unreadCount: number,
      lastReadAt: Timestamp,
      isMuted: boolean,
      isPinned: boolean,
      lastMessageAt: Timestamp,
    }
  },
  
  // Block list
  blockedUsers: string[],
  blockedBy: string[],            // من قام بحظري
  
  // Totals
  totalUnreadCount: number,       // للعرض في Badge
  
  // Preferences
  preferences: {
    soundEnabled: boolean,
    notificationsEnabled: boolean,
    showReadReceipts: boolean,
  },
  
  updatedAt: Timestamp,
}
```

---

### Collection: `chat_reports`

```javascript
chat_reports/{reportId} {
  // Context
  roomId: string,
  messageId: string,
  
  // Reporter
  reportedBy: string,
  reportedByName: string,
  
  // Reported
  reportedUser: string,
  reportedUserName: string,
  
  // Details
  reason: 'spam' | 'harassment' | 'inappropriate' | 'other',
  details?: string,
  
  // Review
  status: 'pending' | 'under_review' | 'resolved' | 'dismissed',
  reviewedBy?: string,
  reviewedAt?: Timestamp,
  
  // Action taken
  action?: 'warning' | 'mute_24h' | 'mute_7d' | 'ban' | 'none',
  actionDetails?: string,
  
  // Audit
  createdAt: Timestamp,
  updatedAt: Timestamp,
}
```

---

## قواعد الأمان

### Firestore Rules (صارمة جداً)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // ===================== Helper Functions =====================
    function isSignedIn() {
      return request.auth != null;
    }
    
    function userDoc() {
      return get(/databases/$(database)/documents/users/$(request.auth.uid)).data;
    }
    
    function isSuperAdmin() {
      return isSignedIn() && userDoc().role == 'super_admin';
    }
    
    function isCompanyAdmin() {
      return isSignedIn() && userDoc().role == 'company_admin';
    }
    
    function isParticipant(roomData) {
      return request.auth.uid in roomData.participants;
    }
    
    function sameTenant(tenantType, tenantId) {
      let user = userDoc();
      return (
        (tenantType == 'company' && user.companyId == tenantId) ||
        (tenantType == 'institution' && user.institutionId == tenantId)
      );
    }
    
    // ===================== Chat Rooms =====================
    match /chat_rooms/{roomId} {
      
      // Read: participant أو admin
      allow get: if isSignedIn() && (
        isSuperAdmin() ||
        isParticipant(resource.data) ||
        (isCompanyAdmin() && sameTenant(resource.data.tenantType, resource.data.tenantId))
      );
      
      // List: only rooms where user is participant (with limit)
      allow list: if isSignedIn() && 
                     request.auth.uid in resource.data.participants &&
                     request.query.limit <= 50;
      
      // Create: strict validation
      allow create: if isSignedIn() && 
                       request.resource.data.createdBy == request.auth.uid &&
                       request.auth.uid in request.resource.data.participants &&
                       sameTenant(request.resource.data.tenantType, request.resource.data.tenantId) &&
                       validateRoomCreation(request.resource.data);
      
      // Update: only specific fields
      allow update: if isSignedIn() && isParticipant(resource.data) && (
        // Can update: lastMessage, updatedAt, mutedBy, pinnedBy
        !request.resource.data.diff(resource.data).affectedKeys()
          .hasAny(['participants', 'type', 'courseId', 'assignmentId', 
                   'tenantType', 'tenantId', 'createdBy', 'participantRoles'])
      );
      
      // Delete: never (archive instead)
      allow delete: if false;
      
      // ===================== Messages Subcollection =====================
      match /messages/{messageId} {
        
        function isRoomParticipant() {
          return request.auth.uid in get(/databases/$(database)/documents/chat_rooms/$(roomId)).data.participants;
        }
        
        function isSender() {
          return request.auth.uid == resource.data.senderId;
        }
        
        function isModerator() {
          let room = get(/databases/$(database)/documents/chat_rooms/$(roomId)).data;
          return request.auth.uid in room.moderatorIds;
        }
        
        function canEdit() {
          // Can edit within 15 minutes
          return isSender() && 
                 (request.time.toMillis() - resource.data.sentAt.toMillis()) < 900000;
        }
        
        // Read: participants only
        allow get: if isSignedIn() && isRoomParticipant();
        allow list: if isSignedIn() && 
                       isRoomParticipant() && 
                       request.query.limit <= 100;
        
        // Create: participants only, with validation
        allow create: if isSignedIn() && 
                         isRoomParticipant() &&
                         request.resource.data.senderId == request.auth.uid &&
                         validateMessageContent(request.resource.data);
        
        // Update: sender can edit, moderator can approve/delete
        allow update: if isSignedIn() && (
          (canEdit() && validateEdit(request.resource.data, resource.data)) ||
          (isModerator() && validateModeration(request.resource.data, resource.data))
        );
        
        // Delete: never (soft delete only)
        allow delete: if false;
      }
    }
    
    // ===================== User Chat Metadata =====================
    match /user_chat_metadata/{userId} {
      allow get: if isSignedIn() && userId == request.auth.uid;
      allow create, update: if isSignedIn() && 
                               userId == request.auth.uid &&
                               validateMetadata(request.resource.data);
      allow delete: if false;
    }
    
    // ===================== Chat Reports =====================
    match /chat_reports/{reportId} {
      allow create: if isSignedIn() && 
                       request.resource.data.reportedBy == request.auth.uid &&
                       validateReport(request.resource.data);
      
      allow list, get: if isSuperAdmin() || isCompanyAdmin();
      
      allow update: if (isSuperAdmin() || isCompanyAdmin()) &&
                       request.resource.data.diff(resource.data).affectedKeys()
                         .hasOnly(['status', 'reviewedBy', 'reviewedAt', 'action', 'actionDetails']);
      
      allow delete: if false;
    }
  }
  
  // ===================== Validation Functions =====================
  
  function validateRoomCreation(roomData) {
    let type = roomData.type;
    
    return (
      // Common validations
      roomData.participants.size() >= 2 &&
      roomData.participants.size() <= 100 &&
      roomData.isArchived == false &&
      
      // Type-specific validations
      (
        (type == 'course' && validateCourseRoom(roomData)) ||
        (type == 'direct' && validateDirectRoom(roomData)) ||
        (type == 'assignment' && validateAssignmentRoom(roomData))
      )
    );
  }
  
  function validateCourseRoom(roomData) {
    // Must have courseId
    // Creator must be trainer or enrolled trainee
    let course = get(/databases/$(database)/documents/courses/$(roomData.courseId)).data;
    let user = userDoc();
    
    return roomData.courseId is string &&
           (
             (user.role == 'trainer' && course.trainerId == request.auth.uid) ||
             (user.role == 'trainee' && 
              exists(/databases/$(database)/documents/course_enrollments/$(request.auth.uid + '_' + roomData.courseId)))
           );
  }
  
  function validateDirectRoom(roomData) {
    // Exactly 2 participants
    // Allowed role combinations only
    let participants = roomData.participants;
    let user = userDoc();
    let otherUserId = participants[0] == request.auth.uid ? participants[1] : participants[0];
    let otherUser = get(/databases/$(database)/documents/users/$(otherUserId)).data;
    
    return participants.size() == 2 &&
           sameTenant(roomData.tenantType, roomData.tenantId) &&
           validateRolePair(user.role, otherUser.role);
  }
  
  function validateRolePair(role1, role2) {
    return (
      (role1 == 'trainer' && role2 in ['trainee', 'manager']) ||
      (role1 == 'trainee' && role2 == 'trainer') ||
      (role1 == 'manager' && role2 in ['trainer', 'trainee']) ||
      (role1 in ['company_admin', 'org_admin'])
    );
  }
  
  function validateAssignmentRoom(roomData) {
    // Must have assignmentId
    // Creator must be trainer or manager in assignment
    let assignment = get(/databases/$(database)/documents/teaching_assignments/$(roomData.assignmentId)).data;
    let user = userDoc();
    
    return roomData.assignmentId is string &&
           (
             (user.role == 'trainer' && assignment.trainerId == request.auth.uid) ||
             (user.role == 'manager' && assignment.departmentId != null)
           );
  }
  
  function validateMessageContent(msgData) {
    return msgData.text is string &&
           msgData.text.size() > 0 &&
           msgData.text.size() <= 5000 &&
           msgData.type in ['text', 'image', 'file', 'system'] &&
           msgData.status == 'sent';
  }
  
  function validateEdit(newData, oldData) {
    // Can only edit text and mark as edited
    return newData.diff(oldData).affectedKeys().hasOnly(['text', 'editedAt']) &&
           newData.senderId == oldData.senderId;
  }
  
  function validateModeration(newData, oldData) {
    // Moderator can approve or soft-delete
    return (
      (newData.diff(oldData).affectedKeys().hasOnly(['isApproved', 'approvedBy', 'approvedAt'])) ||
      (newData.diff(oldData).affectedKeys().hasOnly(['status', 'deletedAt']) &&
       newData.status == 'deleted')
    );
  }
  
  function validateMetadata(metadata) {
    // Basic validation for metadata
    return metadata.totalUnreadCount >= 0;
  }
  
  function validateReport(reportData) {
    return reportData.reason in ['spam', 'harassment', 'inappropriate', 'other'] &&
           reportData.status == 'pending';
  }
}
```

---

## واجهات المستخدم

### 1. Chat List Screen

```dart
// lib/screens/chat_list_screen.dart
class ChatListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomsAsync = ref.watch(userChatRoomsProvider);
    final totalUnread = ref.watch(totalUnreadCountProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.chats),
        actions: [
          if (totalUnread > 0) Badge(
            label: Text('$totalUnread'),
            child: IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NotificationsScreen()),
              ),
            ),
          ),
        ],
      ),
      body: roomsAsync.when(
        data: (rooms) {
          if (rooms.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.chat_bubble_outline,
              title: context.l.noChats,
              description: context.l.startChatDescription,
              action: RoleGate(
                allowRoles: ['trainer', 'company_admin'],
                builder: (_) => FilledButton.icon(
                  onPressed: () => showNewChatDialog(context),
                  icon: Icon(Icons.add),
                  label: Text(context.l.newChat),
                ),
              ),
            );
          }
          
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(userChatRoomsProvider);
            },
            child: ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final room = rooms[index];
                return ChatRoomTile(
                  room: room,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatRoomScreen(roomId: room.id),
                    ),
                  ),
                );
              },
            ),
          );
        },
        loading: () => SkeletonListView(itemCount: 5),
        error: (e, st) => ErrorStateWidget(
          error: e.toString(),
          onRetry: () => ref.invalidate(userChatRoomsProvider),
        ),
      ),
      floatingActionButton: RoleGate(
        allowRoles: ['trainer', 'company_admin', 'manager'],
        builder: (_) => FloatingActionButton.extended(
          onPressed: () => showNewChatDialog(context),
          icon: Icon(Icons.add_comment),
          label: Text(context.l.newChat),
        ),
      ),
    );
  }
}
```

---

## Providers

انظر الملف الكامل للتفاصيل (سيتم إضافته في `lib/providers/chat_providers.dart`)

---

## خطة التنفيذ

### 🔥 Phase 1: MVP - Course Chat (أسبوع واحد)

**الأولوية**: عاجلة جداً

#### Day 1-2: Backend Setup
- [x] إنشاء Data Models
  - `ChatRoom` model
  - `ChatMessage` model
  - `UserChatMetadata` model
- [x] Firestore Rules implementation
- [x] Composite Indexes setup

#### Day 3-4: Basic UI
- [x] Chat List Screen
- [x] Chat Room Screen
- [x] Message Bubble Widget
- [x] Chat Input Bar

#### Day 5-6: Core Features
- [x] Send/Receive messages
- [x] Real-time updates
- [x] Unread count tracking
- [x] Basic notifications

#### Day 7: Testing & Polish
- [x] Unit tests
- [x] UI tests
- [x] Bug fixes
- [x] Performance optimization

---

### 🟡 Phase 2: Enhanced Features (أسبوع)

- [ ] Direct Messages
- [ ] Read receipts
- [ ] Edit/Delete messages (15 min window)
- [ ] Typing indicators
- [ ] Image attachments
- [ ] Push notifications للرسائل

---

### 🟢 Phase 3: Advanced (أسبوعين)

- [ ] File attachments (PDF, Audio)
- [ ] Assignment chats
- [ ] Moderation system
- [ ] Report system
- [ ] Search in messages
- [ ] Message threading
- [ ] Reactions (emoji)

---

## المخاطر والتحديات

### 1. Performance ⚠️
**المشكلة**: كثرة الرسائل قد تبطئ التطبيق

**الحل**:
- Pagination (100 رسالة في المرة)
- Lazy loading للصور
- Caching aggressive

### 2. Abuse & Spam 🚫
**المشكلة**: إرسال رسائل مزعجة أو مسيئة

**الحل**:
- Rate limiting في Rules
- Moderation system
- Report & Block features
- Auto-filter للكلمات المسيئة (optional)

### 3. Storage Costs 💰
**المشكلة**: تخزين الرسائل قد يكلف

**الحل**:
- Data retention policy (حذف بعد 90 يوم)
- Compress images
- Limit file sizes

---

## القبول النهائي (Acceptance Criteria)

### MVP (Phase 1):
- ✅ يمكن إنشاء Course Chat تلقائياً عند إنشاء كورس
- ✅ Trainer و Trainees يمكنهم إرسال رسائل
- ✅ الرسائل تظهر في real-time
- ✅ Unread count يعمل بدقة
- ✅ Push notification عند رسالة جديدة
- ✅ لا يمكن التواصل عبر tenants مختلفة
- ✅ Firestore Rules تمنع أي وصول غير مصرح

### Enhanced (Phase 2):
- ✅ Direct messages يعمل للأزواج المسموحة فقط
- ✅ Read receipts تظهر بوضوح
- ✅ Edit/Delete يعمل خلال 15 دقيقة
- ✅ الصور تُرفع وتُعرض بشكل صحيح

---

## الخلاصة

نظام دردشة **آمن، مرن، وقابل للتوسع** مع تركيز على:
1. 🔒 **Security**: قواعد صارمة جداً
2. 🏢 **Tenant Isolation**: عزل كامل
3. 👥 **Role-Based**: صلاحيات محددة
4. 📊 **Scalability**: جاهز للتوسع

**الخطوة التالية**: البدء في تنفيذ Phase 1 (MVP) فوراً! 🚀

---

**Last Updated**: October 12, 2025  
**Author**: Training App V2 Team  
**Status**: Ready for Implementation
