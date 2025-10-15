# نظرة شاملة على مشروع Training App V2

## ملخص تنفيذي

Training App V2 هو تطبيق تدريبي متعدد المستأجرين (Multi-Tenant) مبني بـ Flutter، يستهدف بيئات التدريب المؤسسي والتعليمي. يدعم التطبيق 6 أدوار رئيسية مع فصل كامل للصلاحيات والبيانات، ويستخدم Firebase Firestore كقاعدة بيانات مع Riverpod لإدارة الحالة.

**الحالة الحالية:** المشروع في مرحلة ما قبل الإطلاق (Pre-Release) - Phase 4.5 من 5

---

## البنية التقنية (Technology Stack)

### الأساسيات
- **Framework:** Flutter 3.9.2+
- **Language:** Dart
- **State Management:** Riverpod 2.5.1
- **Database:** Firebase Firestore
- **Authentication:** Firebase Auth
- **Localization:** flutter_localizations (Arabic & English)
- **Code Generation:** freezed, json_serializable

### المكتبات الرئيسية
```yaml
Dependencies:
  - firebase_core: 4.1.0
  - cloud_firestore: 6.0.1
  - firebase_auth: 6.0.2
  - flutter_riverpod: 2.5.1
  - freezed_annotation: 2.4.4
  - onesignal_flutter: 5.3.4 (Push Notifications)
  - image_picker: 1.2.0
  - audioplayers: 6.5.1
  - intl: 0.20.2

Dev Dependencies:
  - mocktail: 1.0.3
  - fake_cloud_firestore: 4.0.0
  - patrol: 3.19.0 (UI Testing)
```

---

## نموذج الأدوار (Role Model)

### الأدوار الستة

#### 1. Super Admin (`super_admin`)
- **النطاق:** النظام بالكامل
- **الصلاحيات:**
  - إدارة جميع المؤسسات والشركات
  - تعيين الأدوار لجميع المستخدمين
  - مراقبة النظام والأمان
  - الوصول لجميع البيانات عبر جميع المستأجرين
- **الشاشة الرئيسية:** `SuperAdminDashboard`
- **الخصائص:**
  - لوحة مراقبة المخاطر الأمنية
  - إدارة المؤسسات والشركات
  - Feature Flags Management
  - Audit Logs

#### 2. Organization Admin (`org_admin`)
- **النطاق:** مؤسسة واحدة (`institutionId`)
- **الصلاحيات:**
  - إدارة محتوى المؤسسة
  - إدارة المسارات التعليمية
  - مراقبة الأداء على مستوى المؤسسة
- **الشاشة الرئيسية:** `OrgAdminDashboard`

#### 3. Company Admin (`company_admin`)
- **النطاق:** شركة واحدة (`companyId`)
- **الصلاحيات:**
  - إدارة الأقسام (Departments)
  - إدارة أعضاء الشركة
  - تعيين المدرسين للمسارات (Teaching Assignments)
  - إدارة المحتوى الخاص بالشركة
- **الشاشة الرئيسية:** `CompanyAdminDashboard`
- **الخصائص الرئيسية:**
  - إنشاء/تعديل الأقسام
  - إضافة/إزالة أعضاء من الأقسام
  - تعيين المدرسين للمسارات التعليمية

#### 4. Manager (`manager`)
- **النطاق:** قسم أو أكثر (`departmentId` via `user_department_map`)
- **الصلاحيات:**
  - متابعة أداء الفريق
  - عرض التقارير والتحليلات
  - مراقبة التعيينات النشطة (Active Assignments)
- **الشاشة الرئيسية:** `ManagerDashboard`
- **الخصائص:**
  - عرض المدرسين والأعضاء النشطين
  - فلترة حسب التاريخ والقسم
  - تقارير فجوات المهارات

#### 5. Trainer (`trainer`)
- **النطاق:** الكورسات والمسارات المُعينة له
- **الصلاحيات:**
  - إنشاء وإدارة الكورسات
  - إنشاء الاختبارات والمهام
  - تقييم المتدربين
  - عرض المحتوى المُعين له (Assigned to me)
- **الشاشة الرئيسية:** `BottomNavShell` (role: 'trainer')
- **التنقل:** Dashboard | Progress | Profile | Settings

#### 6. Trainee (`trainee`)
- **النطاق:** الكورسات المسجل فيها
- **الصلاحيات:**
  - الوصول للمحتوى التدريبي
  - أخذ الاختبارات
  - تتبع التقدم الشخصي
  - كسب النقاط والشارات
- **الشاشة الرئيسية:** `BottomNavShell` (role: 'trainee')
- **التنقل:** Dashboard | Progress | Profile | Settings

---

## البنية المعمارية (Architecture)

### نموذج البيانات الأساسي

```
Collections (Firestore):

1. users/{userId}
   - id, email, name, role
   - institutionId?, companyId?
   - createdAt, lastLogin
   - Avatar, phone, etc.

2. institutions/{institutionId}
   - name, description, status
   - settings, createdAt

3. companies/{companyId}
   - name, institutionId?
   - status, settings, createdAt

4. departments/{departmentId}
   - companyId (required)
   - name, description
   - createdAt

5. user_department_map/{mapId}
   - userId, departmentId
   - role? (للأدوار الخاصة بالقسم)
   - addedAt

6. learning_paths/{pathId}
   - tenantType ('company' | 'institution')
   - tenantId
   - title, description, stepsCount
   - visibility, createdAt

7. path_steps/{stepId}
   - pathId, order
   - title, description, type
   - resourceUrl?, duration?

8. user_path_progress/{progressId}
   - userId, pathId
   - currentStep, completedSteps
   - lastAccessAt, completedAt?

9. teaching_assignments/{assignmentId} ⭐ NEW in Phase 5
   - tenantType, tenantId
   - scopeType ('path' | 'course')
   - scopeId, trainerId
   - departmentId?
   - startAt, endAt, status
   - title, createdAt, updatedAt

10. courses/{courseId}
    - tenantType?, tenantId?
    - trainerId, title, description
    - difficulty, tags[]
    - createdAt, updatedAt

11. evaluations/{evalId}
    - courseId, trainerId, traineeId
    - score, feedback, status
    - submittedAt, gradedAt?

12. user_points/{userId}
    - points, level, badges[]
    - dailyStreak, lastActiveDay
    - updatedAt

13. user_points/{userId}/badge_awards/{badgeId}
    - badgeId, awardedAt
    - reason?

14. badges/{badgeId}
    - name, description, iconUrl
    - category, threshold
    - createdAt

15. security_events/{eventId}
    - userId, eventType, severity
    - metadata, ts, flagged?

16. security_daily_rollup/{date_userId}
    - Aggregated security metrics per day

17. risk_user_score/{userId}
    - overallScore, flags[]
    - lastUpdated

18. intrusion_alerts/{alertId}
    - userId?, attackType, severity
    - detected, resolved?

19. integrity_flags/{flagId}
    - targetType, targetId
    - reason, status
    - createdAt, resolvedAt?

20. system_settings/global
    - featureFlags{}
    - maintenanceMode, etc.
```

---

## الخصائص المنجزة (Completed Features)

### Phase 0-3: الأساسيات ✅

#### 1. المصادقة والتنقل
- ✅ تسجيل الدخول/إنشاء حساب
- ✅ Firebase Authentication
- ✅ Role-based routing (`AuthWrapper`)
- ✅ Multi-language support (AR/EN)
- ✅ OneSignal Push Notifications

#### 2. نظام الأدوار (Role-Based Access)
- ✅ `RoleGate` Widget للتحكم بالواجهات
- ✅ `RoleDebugWrapper` للتطوير
- ✅ Provider-based role checking
- ✅ Tenant isolation في Firestore Rules

#### 3. الكورسات والاختبارات
- ✅ إنشاء/تعديل الكورسات (Trainers)
- ✅ Quiz Builder مع أنواع أسئلة متعددة
- ✅ تقديم الاختبارات وعرض النتائج
- ✅ Manual Grading للمهام

#### 4. Gamification System
- ✅ Points & Levels (formula: `level = floor(sqrt(points / 50)) + 1`)
- ✅ Badge Awards (Points, Streak, Reviews)
- ✅ Daily Streak tracking
- ✅ Leaderboard
- ✅ Badge Timeline
- ✅ Idempotent badge awarding
- ✅ UI Components:
  - `PointsLevelCard`
  - `EarnedBadgesGrid` / `LockedBadgesGrid`
  - `BadgeAwardListener` (Snackbar notifications)
  - `BadgeTimeline`

#### 5. Learning Paths
- ✅ عرض المسارات للمستخدمين
- ✅ تتبع التقدم (Client-side secure writes)
- ✅ Path steps navigation
- ✅ Progress persistence في Firestore

#### 6. Security & Monitoring
- ✅ Security Events logging
- ✅ Daily Rollup aggregations
- ✅ Risk scoring model
- ✅ Intrusion detection placeholders
- ✅ Integrity flags system

#### 7. Admin Dashboards
- ✅ Super Admin Dashboard
  - إدارة المؤسسات والشركات
  - Feature flags management
  - Audit logs viewer
- ✅ Company Admin Dashboard
  - إدارة الأقسام
  - إدارة الأعضاء
  - Department members management
- ✅ Manager Dashboard
  - Team overview
  - Active assignments view

---

## الأولويات العاجلة (قبل كل شيء!) 🔥🔥🔥

### 🎯 Priority 1: Course Wall Enhancements (3-5 أيام)
**الحالة:** قيد التحسين الفوري  
**الوثيقة:** [`docs/COURSE_WALL_ENHANCEMENTS.md`](COURSE_WALL_ENHANCEMENTS.md)

**الأهداف:**
- ✅ UI محسّن مع cards جذابة
- ✅ Reactions system (👍 ❤️ 🎉)
- ✅ Comments threading (الردود على التعليقات)
- ✅ Real-time updates
- ✅ Pin/Archive functionality
- ✅ Rich media support (صور، ملفات)

**الجدول الزمني:**
- Day 1: Backend updates + Models
- Day 2: UI improvements + Reactions
- Day 3: Comments system
- Day 4: Advanced features
- Day 5: Testing & Polish

---

### 🎯 Priority 2: Chat System (أسبوع - أسبوعين)
**الحالة:** مخطط - جاهز للتنفيذ  
**الوثيقة:** [`docs/CHAT_SYSTEM_DESIGN.md`](CHAT_SYSTEM_DESIGN.md)

**Phase 1 - MVP (أسبوع واحد):**
- ✅ Course Chat (نقاش داخل الكورس)
- ✅ Send/Receive messages
- ✅ Real-time updates
- ✅ Unread counts
- ✅ Push notifications

**Phase 2 - Enhanced:**
- ⏳ Direct Messages
- ⏳ Read receipts
- ⏳ Edit/Delete messages
- ⏳ Image attachments

**القواعد الأمنية:**
- 🔒 Tenant isolation صارم
- 🔒 Role-based messaging
- 🔒 Moderation system
- 🔒 Report & Block features

---

## الخصائص قيد التنفيذ (Phase 5)

### 1. Teaching Assignments ⚙️ 80%
**الأولوية:** 🟡 متوسطة (بعد Wall & Chat)

**المنجز:**
- ✅ Data model (`TeachingAssignment`)
- ✅ Providers:
  - `assignmentsByTrainerProvider`
  - `assignmentsByScopeProvider`
  - `assignmentsByTenantProvider`
  - `createAssignmentProvider`
- ✅ Firestore Rules للتحكم بالوصول
- ✅ Indexes definition

**المتبقي:**
- ⏳ UI: "Assign Trainer" Dialog (Company Admin)
- ⏳ Manager Dashboard: Active assignments filtering
- ⏳ Trainer: "Assigned to me" screen
- ⏳ Tests & QA

### 2. Learning Paths Authoring ⏳ 30%
**الحالة:** Read-only حالياً، بحاجة لـ CRUD operations

**المطلوب:**
- ⏳ Enable create/update في Firestore Rules
- ⏳ New Path Dialog (Company/Org Admin)
- ⏳ Manage Steps screen (CRUD + reorder)
- ⏳ stepsCount auto-sync
- ⏳ Validation & error handling

### 3. Dashboard Enhancements ⏳ 50%
**المطلوب:**
- ⏳ Manager Dashboard UI tests
- ⏳ Better data visualization
- ⏳ Performance optimization
- ⏳ Responsive design improvements

---

## الخصائص المؤجلة (Deferred Features)

### 1. iOS Support 📱
**السبب:** قيود الوقت والموارد
**الخطة المستقبلية:** Phase 6+

### 2. Dark Mode 🌙
**السبب:** تعقيد التنفيذ عبر جميع الشاشات
**الخطة المستقبلية:** Phase 6

### 3. Advanced Reports 📊
**السبب:** تعقيد الاستعلامات والواجهات
**الخطة المستقبلية:** Phase 5.5+

### 4. Real-time Collaboration 👥
**السبب:** خارج نطاق MVP
**الخطة المستقبلية:** Phase 7+

---

## Firestore Security Rules - ملخص

### المبادئ الأساسية

1. **Tenant Isolation:** كل دور يرى بيانات نطاقه فقط
2. **Feature Flags:** تفعيل/تعطيل القيود بشكل ديناميكي
3. **Super Admin Override:** full access للـ super_admin
4. **Client-safe Writes:** قيود صارمة على الكتابة من العميل

### أمثلة رئيسية

```javascript
// Users collection
allow get: if isSignedIn() && (
  isSuperAdmin() ||
  userId == request.auth.uid ||
  !tenantReadsEnforced() ||
  (isOrgAdmin() && sameTenant(institutionId)) ||
  (isCompanyAdmin() && sameTenant(companyId))
);

// Courses
allow create: if isTrainer() && 
  request.resource.data.trainerId == request.auth.uid &&
  courseTenantOkCreate();

// user_path_progress (Client-safe writes)
allow update: if userId == request.auth.uid &&
  validProgressIncrement() &&
  tenantMatches();

// teaching_assignments
allow create: if (isOrgAdmin() || isCompanyAdmin()) &&
  tenantMatches() &&
  validDateRange() &&
  trainerExists();
```

---

## Testing Strategy

### اختبارات الوحدة (Unit Tests) ✅
```dart
test/
├── badge_evaluation_service_test.dart ✅
├── badge_evaluation_quick_test.dart ✅
├── streak_badge_evaluation_test.dart ✅
├── review_badges_test.dart ✅
├── compute_level_test.dart ✅
├── course_repository_test.dart ✅
├── timestamp_converter_test.dart ✅
├── result_mapping_test.dart ✅
├── points_idempotency_test.dart ✅
└── daily_streak_test.dart ✅
```

### اختبارات الواجهة (UI Tests) ⏳
```dart
test/
├── manager_dashboard_test.dart ⏳ (In Progress)
└── widget_test.dart ✅
```

### اختبارات القواعد (Rules Simulation) ✅
```javascript
tools/
├── rules_simulation.js ✅
└── rules_simulation_write_enforcement.js ✅
```

---

## الأداء والتحسينات (Performance)

### Firestore Optimization

#### Indexes المطلوبة
```json
{
  "indexes": [
    {
      "collectionGroup": "teaching_assignments",
      "queryScope": "COLLECTION",
      "fields": [
        {"fieldPath": "trainerId", "order": "ASCENDING"},
        {"fieldPath": "status", "order": "ASCENDING"},
        {"fieldPath": "startAt", "order": "DESCENDING"}
      ]
    },
    {
      "collectionGroup": "teaching_assignments",
      "queryScope": "COLLECTION",
      "fields": [
        {"fieldPath": "tenantType", "order": "ASCENDING"},
        {"fieldPath": "tenantId", "order": "ASCENDING"},
        {"fieldPath": "status", "order": "ASCENDING"},
        {"fieldPath": "startAt", "order": "DESCENDING"}
      ]
    },
    {
      "collectionGroup": "path_steps",
      "queryScope": "COLLECTION",
      "fields": [
        {"fieldPath": "pathId", "order": "ASCENDING"},
        {"fieldPath": "order", "order": "ASCENDING"}
      ]
    }
  ]
}
```

#### Caching Strategy
- ✅ Riverpod auto-dispose للمزودات غير المستخدمة
- ✅ Stream providers للبيانات الحية
- ✅ FutureProvider للبيانات الثابتة
- ⏳ Offline persistence (مخطط)

### App Size Optimization
- Current: ~15-20MB (Android)
- Target: <30MB
- Strategy: Code splitting, asset optimization

---

## خطة الإطلاق (Release Plan)

### Android Release ⏳

#### المتطلبات قبل الإطلاق

1. **QA الشامل** ⏳
   - [ ] اختبار جميع الأدوار
   - [ ] اختبار الـ Tenant isolation
   - [ ] اختبار Firestore Rules
   - [ ] Performance testing
   - [ ] Security audit

2. **التوقيع والبناء** ⏳
   - [ ] إعداد Keystore
   - [ ] تحديث build.gradle
   - [ ] بناء Release APK/AAB
   - [ ] اختبار على أجهزة فعلية

3. **Google Play** ⏳
   - [ ] إعداد صفحة المتجر
   - [ ] Screenshots & descriptions
   - [ ] Privacy Policy
   - [ ] Internal testing track
   - [ ] Production release

4. **Monitoring** ⏳
   - [ ] Firebase Crashlytics
   - [ ] Analytics
   - [ ] Performance monitoring
   - [ ] User feedback system

---

## المخاطر والتحديات (Risks & Challenges)

### المخاطر التقنية

1. **Firestore Rules Complexity** ⚠️ HIGH
   - **الوصف:** القواعد معقدة وقد تسبب حجب غير متوقع
   - **التخفيف:** 
     - اختبارات شاملة للقواعد
     - Feature flags للتحكم الديناميكي
     - Logging مفصل للأخطاء

2. **Performance at Scale** ⚠️ MEDIUM
   - **الوصف:** استعلامات معقدة قد تبطئ مع كثرة البيانات
   - **التخفيف:**
     - Pagination
     - Composite indexes
     - Caching strategy

3. **Multi-tenant Data Leakage** 🔴 CRITICAL
   - **الوصف:** احتمال تسريب بيانات بين المستأجرين
   - **التخفيف:**
     - Triple-check rules
     - Automated testing
     - Security audit قبل الإطلاق

### المخاطر التنظيمية

1. **Scope Creep** ⚠️ MEDIUM
   - **الوصف:** إضافة ميزات جديدة تؤخر الإطلاق
   - **التخفيف:**
     - Strict feature freeze قبل أسبوعين من الإطلاق
     - Backlog منظم للخصائص المستقبلية

2. **Testing Coverage** ⚠️ MEDIUM
   - **الوصف:** عدم تغطية جميع السيناريوهات
   - **التخفيف:**
     - Test checklist شامل
     - Beta testing program
     - Gradual rollout

---

## الخطوات التالية (Next Steps)

### الأولويات العاجلة (This Week)

1. **إكمال Teaching Assignments UI** 🔥
   - Assign Trainer Dialog
   - Manager Dashboard integration
   - Trainer "Assigned to me" screen

2. **اختبارات Manager Dashboard** 🔥
   - كتابة UI tests
   - Mock data setup
   - Error scenarios

3. **Learning Paths Authoring** 🔥
   - Enable create/update rules
   - Basic CRUD UI
   - Validation

### المدى القصير (Next 2 Weeks)

1. **QA الشامل**
   - إعداد حسابات الاختبار
   - اختبار جميع الأدوار
   - توثيق الأخطاء

2. **Performance Optimization**
   - تحسين الاستعلامات
   - Caching improvements
   - Load testing

3. **Documentation**
   - User manual
   - Admin guide
   - API documentation

### المدى المتوسط (Next Month)

1. **Android Release**
   - تجهيز التوقيع
   - بناء Release build
   - نشر على Google Play

2. **Monitoring Setup**
   - Crashlytics
   - Analytics
   - User feedback

3. **Post-launch Support**
   - Bug fixes
   - Performance monitoring
   - User support

---

## الموارد والوثائق (Resources)

### الوثائق الرئيسية

```
docs/
├── MASTER_PLAN_V2.md         ← الخطة الشاملة للمشروع
├── MASTER_ROADMAP.md         ← خريطة الطريق التفصيلية
├── ROLE_SEPARATION_PLAN.md  ← خطة فصل الأدوار
├── SECURITY_MIGRATION.md     ← توثيق الأمان
├── RELEASE_CHECKLIST.md      ← قائمة التحقق قبل الإطلاق
├── CHANGELOG.md              ← سجل التغييرات
├── INDEXES.md                ← فهارس Firestore
├── DATA_RETENTION.md         ← سياسة الاحتفاظ بالبيانات
└── PROJECT_PLAN.md           ← خطة المشروع (ملخص)
```

### أدوات الدعم

```
tools/
├── seed_users.dart                        ← إنشاء مستخدمين تجريبيين
├── backfill_tenants.dart                  ← ملء بيانات المستأجرين
├── rules_simulation.js                    ← اختبار القواعد
├── rules_simulation_write_enforcement.js  ← اختبار قيود الكتابة
└── admin/
    ├── seed_users_admin.js               ← إنشاء مستخدمين (Admin SDK)
    └── clean_collections_admin.js        ← تنظيف المجموعات
```

---

## معلومات الاتصال (Contact Information)

**المطور السابق:** Zezo12322  
**Repository:** training_app_v2  
**Branch:** main  

### للمطور الجديد

**مرحباً! 👋**

هذا المشروع في مرحلة متقدمة جداً ولكن يحتاج لجهد إضافي لإكمال Phase 5 والإطلاق. الأولويات الحالية هي:

1. ✅ إنهاء Teaching Assignments UI
2. ✅ إكمال Learning Paths Authoring
3. ✅ اختبارات شاملة
4. ✅ تحضير Android Release

**نقاط البداية المقترحة:**

1. اقرأ `docs/MASTER_PLAN_V2.md` لفهم الرؤية الكاملة
2. راجع `lib/core/roles.dart` لفهم نظام الأدوار
3. ادرس `firestore.rules` لفهم القيود الأمنية
4. جرّب التطبيق بأدوار مختلفة باستخدام `RoleDebugWrapper`

**أدوات مفيدة:**

```bash
# Run app with debug
flutter run

# Run tests
flutter test

# Analyze code
flutter analyze

# Generate code (freezed, json_serializable)
flutter pub run build_runner build --delete-conflicting-outputs

# Deploy Firestore rules
firebase deploy --only firestore:rules

# Deploy indexes
firebase deploy --only firestore:indexes
```

**Good Luck! 🚀**

---

## الخلاصة (Conclusion)

Training App V2 هو مشروع طموح ومعقد يجمع بين Multi-tenancy، Role-based access، Gamification، وSecurity monitoring. البنية الأساسية صلبة والكود نظيف ومنظم. المتبقي هو إكمال بعض الخصائص في Phase 5 وإجراء QA شامل قبل الإطلاق.

**التقدم الحالي:** ~85% من الخصائص الأساسية منجزة  
**الوقت المتوقع للإطلاق:** 2-3 أسابيع (بعد إكمال القائمة أعلاه)  
**المخاطر الرئيسية:** Firestore rules complexity, Testing coverage, Performance at scale

**التوصيات:**
1. التركيز على إكمال Teaching Assignments
2. اختبارات شاملة للأدوار المختلفة
3. Performance testing قبل الإطلاق
4. Gradual rollout strategy

---

**Last Updated:** October 12, 2025  
**Document Version:** 1.0  
**Status:** Pre-Release (Phase 4.5/5)
