# 🎮 Gamification System - Day 5 Plan

## 📅 التاريخ: October 15, 2025
## الفرع: `main` (continued)
## المدة المتوقعة: 4-6 ساعات

---

## 🎯 الأهداف

### الهدف الرئيسي
تطوير نظام Learning Modules الكامل:
- ✅ Create/Edit modules
- ✅ Track module progress
- ✅ Award points on module completion
- ✅ UI screens للوحدات

---

## 📊 الوضع الحالي

### ✅ ما هو موجود:
1. **LearningModule Model** (Day 1):
   - `LearningModule` class with Freezed
   - `ModuleContent` (lesson/quiz/assignment/resource)
   - `ModuleRequirements`
   - JSON serialization ✅

2. **GamificationService** (Days 1-3):
   - `awardPoints()` method
   - Level calculation
   - Transaction logging

3. **Points System**:
   - `ActivityType.completingModule` defined
   - Default points: 100

### ⏳ ما ينقص:
1. **Module Repository**:
   - CRUD operations للوحدات
   - Progress tracking
   - Completion validation

2. **Module Providers**:
   - Stream modules
   - Create/update/delete
   - Track progress

3. **Module UI**:
   - Modules list screen
   - Module detail screen
   - Progress indicators

4. **Integration**:
   - Link modules with courses
   - Award points on completion
   - Unlock system

---

## 📋 خطة التنفيذ

### Phase 1: Repository Layer (1.5 ساعات) 🔥

#### 1.1 إنشاء `module_repository.dart`

**الملف**: `lib/repositories/gamification/module_repository.dart`

**الوظائف الأساسية**:
```dart
class ModuleRepository {
  final FirebaseFirestore _firestore;
  
  // CRUD Operations
  Future<void> createModule(LearningModule module);
  Future<void> updateModule(LearningModule module);
  Future<void> deleteModule(String moduleId);
  Stream<List<LearningModule>> streamCourseModules(String courseId);
  Future<LearningModule?> getModule(String moduleId);
  
  // Progress Tracking
  Future<void> updateModuleProgress({
    required String userId,
    required String moduleId,
    required String contentId,
    required bool isCompleted,
  });
  
  Future<Map<String, dynamic>> getModuleProgress({
    required String userId,
    required String moduleId,
  });
  
  // Completion Logic
  Future<bool> checkModuleCompletion({
    required String userId,
    required LearningModule module,
  });
  
  Future<void> completeModule({
    required String userId,
    required String moduleId,
    required String courseId,
  });
}
```

**Firestore Structure**:
```
learning_modules/{moduleId}
  - id: string
  - courseId: string
  - title: string
  - description: string
  - orderIndex: number
  - contents: array
  - requirements: object
  - completionPoints: number
  - isPublished: boolean
  - createdAt: timestamp

module_progress/{userId}_{moduleId}
  - userId: string
  - moduleId: string
  - courseId: string
  - completedContents: array of contentIds
  - progressPercentage: number
  - isCompleted: boolean
  - completedAt: timestamp?
  - lastAccessedAt: timestamp
```

---

### Phase 2: Provider Layer (1 ساعة) 🟡

#### 2.1 إنشاء `module_providers.dart`

**الملف**: `lib/providers/gamification/module_providers.dart`

**Providers**:
```dart
// Repository Provider
final moduleRepositoryProvider = Provider<ModuleRepository>((ref) {
  return ModuleRepository(FirebaseFirestore.instance);
});

// Stream all modules for a course
final courseModulesProvider = StreamProvider.autoDispose
    .family<List<LearningModule>, String>((ref, courseId) {
  return ref.read(moduleRepositoryProvider).streamCourseModules(courseId);
});

// Get module progress for current user
final moduleProgressProvider = StreamProvider.autoDispose
    .family<Map<String, dynamic>, String>((ref, moduleId) async* {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) {
    yield {};
    return;
  }
  
  final repository = ref.read(moduleRepositoryProvider);
  // Stream progress updates
  yield* repository.streamModuleProgress(
    userId: auth.uid,
    moduleId: moduleId,
  );
});

// Create module (trainers only)
final createModuleProvider = FutureProvider.autoDispose
    .family<void, LearningModule>((ref, module) async {
  return ref.read(moduleRepositoryProvider).createModule(module);
});

// Update module content completion
final updateContentCompletionProvider = FutureProvider.autoDispose
    .family<void, ({
      String moduleId,
      String contentId,
      bool isCompleted,
    })>((ref, params) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return;
  
  final repository = ref.read(moduleRepositoryProvider);
  await repository.updateModuleProgress(
    userId: auth.uid,
    moduleId: params.moduleId,
    contentId: params.contentId,
    isCompleted: params.isCompleted,
  );
  
  // Check if module is now complete
  final module = await repository.getModule(params.moduleId);
  if (module != null) {
    final isComplete = await repository.checkModuleCompletion(
      userId: auth.uid,
      module: module,
    );
    
    if (isComplete) {
      // Award points!
      final gamificationService = ref.read(gamificationServiceProvider);
      await gamificationService.awardPoints(
        userId: auth.uid,
        courseId: module.courseId,
        activityType: ActivityType.completingModule,
        activityName: 'إتمام وحدة: ${module.title}',
        metadata: {
          'moduleId': module.id,
          'contentCount': module.contents.length,
        },
      );
      
      // Mark as completed
      await repository.completeModule(
        userId: auth.uid,
        moduleId: params.moduleId,
        courseId: module.courseId,
      );
    }
  }
});
```

---

### Phase 3: UI Layer (2-3 ساعات) 🔵

#### 3.1 Modules List Screen

**الملف**: `lib/screens/gamification/modules_screen.dart`

**المميزات**:
- عرض كل الوحدات في الكورس
- Progress bar لكل وحدة
- Lock/unlock indicators
- Tap to open module details

**UI Design**:
```
┌─────────────────────────────────────┐
│ ← الوحدات التعليمية                │
├─────────────────────────────────────┤
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ ✅ 1. مقدمة في البرمجة         │ │
│ │ █████████████████████ 100%      │ │
│ │ 5/5 دروس • 100 نقطة 🏆         │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ 🔄 2. المتغيرات والثوابت        │ │
│ │ ████████░░░░░░░░░░░░ 60%        │ │
│ │ 3/5 دروس • 0/100 نقطة          │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ 🔒 3. الدوال المتقدمة           │ │
│ │ مقفلة - أكمل الوحدة السابقة     │ │
│ └─────────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

#### 3.2 Module Detail Screen

**الملف**: `lib/screens/gamification/module_detail_screen.dart`

**المميزات**:
- عرض محتوى الوحدة
- Checkboxes للدروس المكتملة
- Quiz/Assignment links
- Progress tracking
- Completion button

**UI Design**:
```
┌─────────────────────────────────────┐
│ ← مقدمة في البرمجة                 │
├─────────────────────────────────────┤
│ 📊 التقدم: 60% (3/5)               │
│ █████████░░░░░░░░░░░░░░░            │
│                                     │
│ 📝 محتوى الوحدة:                   │
│                                     │
│ ✅ 1. ما هي البرمجة؟ (درس)         │
│ ✅ 2. بيئة التطوير (درس)           │
│ ✅ 3. اختبار الوحدة الأولى (اختبار)│
│ ⬜ 4. التطبيق العملي (مهمة)        │
│ ⬜ 5. الموارد الإضافية (مصدر)      │
│                                     │
│ ─────────────────────────────       │
│                                     │
│ 💡 المتطلبات:                      │
│ • إكمال جميع الدروس الإجبارية      │
│ • اجتياز الاختبارات (≥70%)         │
│ • تسليم المهام                     │
│                                     │
│ 🏆 المكافأة: 100 نقطة              │
│                                     │
│ [   إكمال الوحدة   ] (disabled)    │
└─────────────────────────────────────┘
```

#### 3.3 Module Content Card Widget

**الملف**: `lib/widgets/gamification/module_content_card.dart`

**المميزات**:
- Icon حسب نوع المحتوى
- Checkbox للإكمال
- Tap to navigate
- Lock indicator

---

### Phase 4: Integration & Testing (1 ساعة) 🟢

#### 4.1 Course Integration

تعديل `course_details_screen.dart`:
```dart
// Add "Modules" tab
TabBar(
  tabs: [
    Tab(text: 'نظرة عامة'),
    Tab(text: 'الوحدات'), // NEW!
    Tab(text: 'الحائط'),
    Tab(text: 'الاختبارات'),
    Tab(text: 'المهام'),
  ],
)

// In TabBarView
ModulesScreen(courseId: widget.course.id),
```

#### 4.2 Firestore Security Rules

**إضافة في `firestore.rules`**:
```javascript
// learning_modules collection
match /learning_modules/{moduleId} {
  // Read: anyone in the course
  allow read: if request.auth != null;
  
  // Write: trainers only
  allow create, update, delete: if isTrainer();
}

// module_progress collection
match /module_progress/{progressId} {
  // Read: own progress or trainer of course
  allow read: if request.auth != null && (
    progressId.matches(request.auth.uid + '_.*') ||
    isTrainer()
  );
  
  // Write: own progress only
  allow write: if request.auth != null && 
    progressId.matches(request.auth.uid + '_.*');
}
```

#### 4.3 Firestore Indexes

**إضافة في `firestore.indexes.json`**:
```json
{
  "indexes": [
    {
      "collectionGroup": "learning_modules",
      "queryScope": "COLLECTION",
      "fields": [
        {"fieldPath": "courseId", "order": "ASCENDING"},
        {"fieldPath": "orderIndex", "order": "ASCENDING"}
      ]
    },
    {
      "collectionGroup": "module_progress",
      "queryScope": "COLLECTION",
      "fields": [
        {"fieldPath": "userId", "order": "ASCENDING"},
        {"fieldPath": "courseId", "order": "ASCENDING"},
        {"fieldPath": "lastAccessedAt", "order": "DESCENDING"}
      ]
    }
  ]
}
```

---

## 🧪 Testing Plan

### Unit Tests

#### Test 1: Module Creation
```dart
test('Create module with contents', () async {
  final module = LearningModule(
    courseId: 'course123',
    title: 'مقدمة',
    orderIndex: 1,
    contents: [
      ModuleContent(
        id: 'lesson1',
        type: ModuleContentType.lesson,
        title: 'الدرس الأول',
        orderIndex: 1,
      ),
    ],
    completionPoints: 100,
  );
  
  await repository.createModule(module);
  final retrieved = await repository.getModule(module.id!);
  
  expect(retrieved, isNotNull);
  expect(retrieved!.title, 'مقدمة');
});
```

#### Test 2: Progress Tracking
```dart
test('Track content completion', () async {
  await repository.updateModuleProgress(
    userId: 'user123',
    moduleId: 'module1',
    contentId: 'lesson1',
    isCompleted: true,
  );
  
  final progress = await repository.getModuleProgress(
    userId: 'user123',
    moduleId: 'module1',
  );
  
  expect(progress['completedContents'], contains('lesson1'));
});
```

#### Test 3: Module Completion & Points
```dart
test('Award points on module completion', () async {
  // Complete all contents
  await completeAllContents();
  
  // Check completion
  final isComplete = await repository.checkModuleCompletion(
    userId: 'user123',
    module: module,
  );
  
  expect(isComplete, true);
  
  // Verify points awarded
  final progress = await gamificationRepository.getUserProgress(
    'user123',
    'course123',
  );
  
  expect(progress.totalPoints, greaterThanOrEqualTo(100));
});
```

### Integration Tests

#### Test Flow:
1. ✅ Create module as trainer
2. ✅ View modules list as student
3. ✅ Open module details
4. ✅ Complete first content
5. ✅ Verify progress updates
6. ✅ Complete all contents
7. ✅ Verify module completion
8. ✅ Verify points awarded
9. ✅ Check next module unlocked

---

## 📁 الملفات المتأثرة

### ✏️ ملفات جديدة:
```
lib/repositories/gamification/module_repository.dart
lib/providers/gamification/module_providers.dart
lib/screens/gamification/modules_screen.dart
lib/screens/gamification/module_detail_screen.dart
lib/widgets/gamification/module_content_card.dart
lib/widgets/gamification/module_progress_indicator.dart
test/repositories/module_repository_test.dart
docs/GAMIFICATION_DAY5_COMPLETE.md
```

### ✏️ ملفات سيتم تعديلها:
```
lib/screens/course_details_screen.dart (add Modules tab)
firestore.rules (add module rules)
firestore.indexes.json (add module indexes)
```

---

## ⚠️ Considerations

### 1. Module Unlocking
**سياسة القفل**:
- الوحدة الأولى: مفتوحة دائماً
- الوحدات التالية: تفتح عند إكمال الوحدة السابقة
- يمكن للمدرب تجاوز القفل (optional)

### 2. Progress Calculation
```dart
double calculateProgress(
  List<String> completedContents,
  List<ModuleContent> allContents,
) {
  final requiredContents = allContents
      .where((c) => c.isRequired)
      .toList();
  
  final completedRequired = completedContents
      .where((id) => requiredContents.any((c) => c.id == id))
      .length;
  
  return completedRequired / requiredContents.length;
}
```

### 3. Completion Validation
**المتطلبات**:
- ✅ إكمال كل الدروس الإجبارية
- ✅ اجتياز كل الاختبارات (≥70%)
- ✅ تسليم كل المهام الإجبارية

### 4. Points Awarding
- نقاط الوحدة تُمنح **مرة واحدة** فقط
- استخدام transaction-based awarding
- Metadata تحتوي على تفاصيل الوحدة

---

## 🎯 Success Criteria

### يعتبر اليوم الخامس ناجح إذا:

1. ✅ **Modules CRUD Works**:
   - إنشاء وحدة جديدة
   - عرض الوحدات
   - تعديل وحدة
   - حذف وحدة

2. ✅ **Progress Tracking Works**:
   - تتبع إكمال المحتوى
   - حساب النسبة المئوية
   - عرض التقدم في UI

3. ✅ **Completion Logic Works**:
   - التحقق من المتطلبات
   - منح النقاط عند الإكمال
   - علامة "مكتمل" تظهر

4. ✅ **Unlocking Works**:
   - الوحدة الأولى مفتوحة
   - الوحدات التالية مقفلة
   - تفتح بعد إكمال السابقة

5. ✅ **UI/UX Works**:
   - Modules list واضحة
   - Module details سهلة الاستخدام
   - Progress indicators دقيقة
   - Navigation سلسة

---

## 📊 Expected Impact

### Before Day 5:
```
Course Structure:
- Overview ✅
- Wall ✅
- Quizzes ✅
- Tasks ✅
- Modules ❌

Points Sources:
- Quiz: 20-50 pts ✅
- Wall: 1-15 pts ✅
- Modules: ❌
```

### After Day 5:
```
Course Structure:
- Overview ✅
- Wall ✅
- Quizzes ✅
- Tasks ✅
- Modules ✅ NEW!

Points Sources:
- Quiz: 20-50 pts ✅
- Wall: 1-15 pts ✅
- Modules: 100 pts ✅ NEW!

Learning Path:
Module 1 → Module 2 → Module 3 → ...
  ✅        🔒         🔒
```

---

## 🔄 Timeline

**Morning (2 hours)**:
- ✅ Phase 1: Repository Layer
- ✅ Testing repository methods

**Afternoon (2 hours)**:
- ✅ Phase 2: Provider Layer
- ✅ Phase 3.1-3.2: UI Screens

**Evening (2 hours)**:
- ✅ Phase 3.3: Widgets
- ✅ Phase 4: Integration & Testing
- ✅ Documentation

---

## 🚀 Next Steps (Day 6)

بعد Day 5، سننتقل لـ:

1. **Leaderboard Screen**:
   - Top 10 users display
   - Podium for top 3
   - User's current rank
   - Filter options

2. **Leaderboard Providers**:
   - Real-time leaderboard
   - Rank calculation
   - Filter by time period

3. **UI Polish**:
   - Animations
   - Transitions
   - Empty states

---

**Ready to implement Module System!** 🚀

**Estimated completion**: 4-6 hours  
**Priority**: High  
**Complexity**: Medium-High

---

تم بحمد الله ✨
