# خطة مشروع Training App V2

> **📘 للحصول على نظرة شاملة ومفصلة عن المشروع، راجع:** [`docs/PROJECT_COMPREHENSIVE_OVERVIEW.md`](docs/PROJECT_COMPREHENSIVE_OVERVIEW.md)

---

## 🔥🔥🔥 **الأولويات العاجلة (قبل كل شيء!)**

### **Priority #1: Course Wall Enhancements** 🎯
**Timeline:** 3-5 أيام  
**Document:** [`docs/COURSE_WALL_ENHANCEMENTS.md`](docs/COURSE_WALL_ENHANCEMENTS.md)  
**Status:** 🚀 Ready to Start

**Features:**
- Enhanced UI with beautiful cards
- Reactions (👍 ❤️ 🎉 💪)
- Comments threading
- Real-time notifications
- Pin/Archive/Edit
- Media attachments

---

### **Priority #2: Chat System** 🎯
**Timeline:** 1-2 weeks  
**Document:** [`docs/CHAT_SYSTEM_DESIGN.md`](docs/CHAT_SYSTEM_DESIGN.md)  
**Status:** 📋 Planned

**MVP (Week 1):**
- Course Chat
- Real-time messaging
- Notifications
- Strict security

**Enhanced (Week 2):**
- Direct Messages
- Assignment Discussion
- Image support

---

## مقدمة
بدأ مشروع Training App V2 في **2024** بهدف تطوير تطبيق تدريبي متكامل **متعدد المستأجرين (Multi-Tenant)** يدعم إدارة المستخدمين، الدورات التدريبية، المسارات التعليمية، والتقارير، مع دعم كامل لـ **6 أدوار مختلفة** (super_admin, org_admin, company_admin, manager, trainer, trainee). 

تم استخدام **Flutter 3.9.2+** لتطوير التطبيق، مع **Firebase Firestore** كقاعدة بيانات، و**Riverpod 2.5.1** لإدارة الحالة، مع تطبيق نظام **Gamification** شامل (Points, Badges, Levels, Streaks) لتعزيز المشاركة والتحفيز.

---

## مراحل المشروع (تفصيلية)

### Phase 0: Bootstrap & Authentication (✅ مكتمل - 2024 Q4)
- **الأهداف**:
  - إعداد بيئة Flutter والتكامل مع Firebase
  - تطوير نظام المصادقة (Login/Signup)
  - إعداد التنقل الأساسي والـ Localization (AR/EN)
- **النتائج**:
  - ✅ Firebase Authentication يعمل بالكامل
  - ✅ دعم اللغة العربية والإنجليزية
  - ✅ `AuthWrapper` للتوجيه حسب الدور
  - ✅ OneSignal Push Notifications integration

### Phase 1: Multi-Tenancy Foundation (✅ مكتمل - 2025 Q1)
- **الأهداف**:
  - تطوير نظام Multi-Tenant (Institutions & Companies)
  - تطبيق Firestore Rules للعزل الأمني
  - إنشاء نماذج البيانات الأساسية
- **النتائج**:
  - ✅ Collections: `institutions`, `companies`, `departments`
  - ✅ `user_department_map` للربط المرن
  - ✅ Tenant-based scoping في Firestore Rules
  - ✅ Feature Flags system (`system_settings/global`)
  - ✅ Super Admin dashboard foundations

### Phase 2: Courses & Gamification (✅ مكتمل - 2025 Q2)
- **الأهداف**:
  - تطوير نظام الكورسات والاختبارات
  - تطبيق Gamification System كامل
  - إنشاء Dashboards للأدوار المختلفة
- **النتائج**:
  - ✅ Courses CRUD للـ Trainers
  - ✅ Quiz Builder & Submission system
  - ✅ Points, Levels, Badges (6 badge families)
  - ✅ Daily Streak tracking
  - ✅ Leaderboard
  - ✅ Badge Timeline & Award Listener
  - ✅ Idempotent badge awarding (transaction-based)
  - ✅ Progress tracking screens

### Phase 3: Admin Dashboards & Role Separation (✅ مكتمل - 2025 Q3)
- **الأهداف**:
  - فصل كامل للأدوار (Role Separation)
  - Dashboards مخصصة لكل دور
  - تطوير أدوات الإدارة
- **النتائج**:
  - ✅ `SuperAdminDashboard`: إدارة النظام + Feature Flags
  - ✅ `OrgAdminDashboard`: إدارة المؤسسة
  - ✅ `CompanyAdminDashboard`: إدارة الشركة والأقسام
  - ✅ `ManagerDashboard`: متابعة الفرق
  - ✅ `BottomNavShell` للـ Trainers/Trainees
  - ✅ `RoleGate` & `RoleDebugWrapper` للتحكم بالواجهات
  - ✅ Department Management UI
  - ✅ Member Management with search & assign/remove

### Phase 4: Learning Paths (✅ 90% مكتمل - 2025 Q3)
- **الأهداف**:
  - تطوير نظام المسارات التعليمية
  - تتبع تقدم المستخدم في المسارات
  - Client-side secure writes
- **النتائج**:
  - ✅ `learning_paths` & `path_steps` collections
  - ✅ `user_path_progress` مع client-safe writes
  - ✅ Progress tracking UI
  - ✅ Path steps navigation
  - ⏳ Authoring tools (المخطط لـ Phase 5)

### Phase 5: Teaching Assignments & Advanced Features (⏳ 60% - جاري العمل)
- **الأهداف**:
  - تطوير نظام **Teaching Assignments** (تعيين المدرسين للمسارات/الكورسات)
  - تمكين Learning Paths Authoring
  - تحسين Dashboards
  - إضافة Security & Monitoring المتقدم
- **الحالة الحالية**:
  
  #### Teaching Assignments (80%)
  - ✅ Data Model (`TeachingAssignment`)
  - ✅ Providers (create, read by trainer/tenant/scope)
  - ✅ Firestore Rules
  - ✅ Composite Indexes
  - ⏳ UI: "Assign Trainer" Dialog
  - ⏳ Manager Dashboard: Active assignments view
  - ⏳ Trainer: "Assigned to me" screen
  
  #### Learning Paths Authoring (30%)
  - ⏳ Enable create/update في Rules
  - ⏳ New Path Dialog (Admin)
  - ⏳ Manage Steps screen (CRUD + reorder)
  - ⏳ stepsCount auto-sync
  
  #### Security & Monitoring (70%)
  - ✅ `security_events` logging
  - ✅ `security_daily_rollup` aggregations
  - ✅ `risk_user_score` model
  - ✅ `intrusion_alerts` placeholders
  - ⏳ Predictive risk dashboard enhancements

### Phase 5 (Advanced) - المخطط للمستقبل
- ⏳ Adaptive recommendation engine
- ⏳ Tokens economy
- ⏳ Advanced analytics & reporting
- ⏳ Real-time collaboration features

---

## التعديلات والإلغاءات (ما حدث خلال التطوير)

### القرارات التصميمية الكبرى

#### 1. تغيير من دور واحد إلى 6 أدوار 🔄
- **السبب الأصلي**: البداية كانت trainer/trainee فقط
- **التغيير**: توسع إلى نظام Multi-Tenant كامل
- **التاريخ**: Q1 2025
- **التأثير**: إعادة هيكلة كاملة للـ Auth & Navigation

#### 2. استبدال Cloud Functions بـ Client-Safe Writes 🔄
- **السبب الأصلي**: Callable Functions للـ progress updates
- **التغيير**: Client-side writes مع قيود صارمة في Rules
- **التاريخ**: Q2 2025
- **الفائدة**: تجنب Blaze plan requirement + أداء أفضل

#### 3. من Department Members الثابت إلى Teaching Assignments المؤقت 🔄
- **السبب الأصلي**: ربط المدرس بالقسم بشكل دائم
- **التغيير**: نظام تعيينات مؤقتة مع startAt/endAt
- **التاريخ**: Q3 2025
- **الفائدة**: مرونة أكبر + أرشفة تلقائية

### الخصائص الملغاة نهائياً ❌

#### 1. تقارير Analytics المتقدمة
- **الوصف**: Charts معقدة + AI predictions
- **السبب**: تعقيد التنفيذ + خارج نطاق MVP
- **البديل**: تقارير أساسية موجودة
- **القرار**: إلغاء نهائي

#### 2. Video Recording داخل التطبيق
- **الوصف**: تسجيل فيديو مباشر للدروس
- **السبب**: حجم التطبيق + complexity
- **البديل**: رفع فيديو من المعرض
- **القرار**: إلغاء نهائي

#### 3. Peer-to-Peer Chat
- **الوصف**: محادثات مباشرة بين المستخدمين
- **السبب**: خارج نطاق MVP + security concerns
- **البديل**: التعليقات على الكورسات
- **القرار**: مؤجل لـ Phase 7+

### الخصائص المؤجلة (لإصدارات مستقبلية) ⏸️

#### 1. دعم iOS 📱
- **الوصف**: بناء التطبيق لأجهزة Apple
- **الحالة**: مؤجل إلى Phase 6
- **السبب**: 
  - قيود الوقت والموارد
  - الأولوية لـ Android أولاً
  - يحتاج Mac + Apple Developer account
- **الخطة المستقبلية**:
  - بعد إطلاق Android بشهر
  - تقييم الطلب من المستخدمين
  - إعداد CI/CD للـ iOS

#### 2. الوضع الليلي (Dark Mode) 🌙
- **الوصف**: theme داكن للتطبيق
- **الحالة**: مؤجل إلى Phase 6
- **السبب**: 
  - تحديث 50+ شاشة
  - تأكد من التباين في جميع الحالات
  - وقت طويل للتنفيذ
- **التحديات**:
  - ضمان التوافق مع الألوان الحالية
  - اختبار جميع الشاشات
  - تخزين التفضيل (SharedPreferences)
- **الخطة**: 
  - استخدام ThemeMode في MaterialApp
  - تحديث `app_theme.dart`

#### 3. إشعارات Push Notifications المتقدمة 🔔
- **الوصف**: إشعارات ذكية + جدولة + targeting
- **الحالة**: Basic integration موجود، Advanced features مؤجلة
- **ما هو موجود**:
  - ✅ OneSignal integration
  - ✅ تسجيل المستخدمين
- **ما هو مؤجل**:
  - ⏸️ Scheduled notifications
  - ⏸️ In-app notification center
  - ⏸️ User preferences للإشعارات
  - ⏸️ Rich notifications (images, actions)
- **الخطة**: Phase 5.5

#### 4. Offline Mode 📴
- **الوصف**: استخدام التطبيق بدون إنترنت
- **الحالة**: مؤجل إلى Phase 6
- **السبب**: 
  - Firestore offline persistence معقدة
  - Sync conflicts handling
  - خارج نطاق MVP
- **الخطة**: 
  - تفعيل Firestore persistence
  - Conflict resolution strategy
  - UI indicators للـ sync status

#### 5. Web Version 🌐
- **الوصف**: نسخة ويب من التطبيق
- **الحالة**: مؤجل إلى Phase 7+
- **السبب**: 
  - Flutter Web performance concerns
  - UI يحتاج تعديلات للشاشات الكبيرة
  - أولوية للموبايل
- **الخطة**: 
  - تقييم الطلب
  - Responsive design overhaul
  - PWA considerations

---

## الحالة الحالية للتطوير (Phase 5 - Current Work)

> **انتبه**: هذا القسم يوضح الخصائص قيد التنفيذ حالياً. للخصائص المؤجلة، راجع القسم السابق.

### 1. Teaching Assignments System ⚙️ 80%
**الهدف**: ربط المدرسين بالمسارات/الكورسات بشكل مؤقت مع نافذة زمنية

**ما هو منجز** ✅:
- ✅ Data Model كامل (`TeachingAssignment` class)
- ✅ Providers للقراءة والكتابة
- ✅ Firestore Rules للتحكم بالوصول
- ✅ Composite Indexes
- ✅ Integration جزئي في Manager Dashboard

**ما هو متبقي** ⏳:
- ⏳ UI: "Assign Trainer" Dialog في Company Admin
- ⏳ Manager Dashboard: Active assignments filtering
- ⏳ Trainer: "Assigned to me" screen
- ⏳ UI Tests

**الأولوية**: 🔥🔥🔥 عالية جداً

---

### 2. Learning Paths Authoring 📝 30%
**الهدف**: تمكين الإداريين من إنشاء/تعديل المسارات

**الحالة**: Read-only حالياً، Create/Update محتاج تفعيل

**ما هو متبقي** ⏳:
- ⏳ Firestore Rules (allow create/update)
- ⏳ "New Path" Dialog
- ⏳ "Manage Steps" Screen (CRUD + reorder)
- ⏳ Providers للكتابة
- ⏳ stepsCount auto-sync

**الأولوية**: 🔥🔥 عالية

---

### 3. Dashboard Enhancements 📊 50%
**الهدف**: تحسين عرض البيانات

**ما هو متبقي**:
- ⏳ Manager Dashboard UI tests
- ⏳ Better visualizations
- ⏳ Performance optimization

**الأولوية**: 🟡 متوسطة

---

### 4. UI Testing Coverage 🧪 40%
**الأولوية قبل الإطلاق**: 🔥🔥🔥

**ما هو منجز** ✅:
- ✅ Unit tests شاملة (Badge, Points, Level, Streak)
- ✅ Basic widget test

**ما هو متبقي** ⏳:
- ⏳ Manager Dashboard UI tests
- ⏳ Teaching Assignments flow tests
- ⏳ Role-based navigation tests

---

## الخطط المستقبلية (Post-Launch)

### Phase 6: Polish & Expansion
- 🌙 Dark Mode
- 📱 iOS Support
- 📴 Offline Mode
- 🔔 Advanced Notifications

### Phase 7: Advanced Features
- 🤖 AI Recommendations
- 💰 Tokens Economy
- 📊 Advanced Analytics
- 👥 Real-time Collaboration
- 🌐 Web Version

---

## معلومات تقنية إضافية

### التقنيات المستخدمة
```yaml
Framework: Flutter 3.9.2+
Language: Dart
State Management: Riverpod 2.5.1
Database: Firebase Firestore
Authentication: Firebase Auth
Localization: AR/EN (flutter_localizations)
Code Generation: freezed + json_serializable
Push Notifications: OneSignal 5.3.4
Testing: mocktail + fake_cloud_firestore + patrol
```

### البنية المعمارية
```
lib/
├── core/                    # Utilities & helpers
│   ├── roles.dart          # RoleGate, role providers
│   ├── theme/              # App themes
│   └── logging.dart        # Logging helpers
├── models/                  # Data models (freezed)
├── providers/               # Riverpod providers (20+ files)
├── screens/                 # UI screens (40+ files)
├── services/                # Business logic services
├── widgets/                 # Reusable widgets
└── l10n/                    # Localizations (AR/EN)

docs/
├── MASTER_PLAN_V2.md       # الخطة الشاملة
├── PROJECT_COMPREHENSIVE_OVERVIEW.md  # نظرة شاملة مفصلة
├── ROLE_SEPARATION_PLAN.md # خطة فصل الأدوار
├── SECURITY_MIGRATION.md   # توثيق الأمان
├── RELEASE_CHECKLIST.md    # قائمة ما قبل الإطلاق
└── CHANGELOG.md            # سجل التغييرات

tools/
├── seed_users.dart         # إنشاء مستخدمين تجريبيين
├── rules_simulation.js     # اختبار قواعد Firestore
└── admin/                  # Admin SDK scripts
```

### الأدوار الستة (Role Model)
1. **super_admin**: إدارة النظام الكاملة
2. **org_admin**: إدارة المؤسسة (`institutionId`)
3. **company_admin**: إدارة الشركة (`companyId`) + الأقسام
4. **manager**: متابعة الفرق (`departmentId` via mapping)
5. **trainer**: إنشاء/تدريس الكورسات
6. **trainee**: استهلاك المحتوى + التعلم

### التحديات الرئيسية التي تم حلها ✅
1. ✅ **Multi-Tenant Data Isolation**: Firestore Rules معقدة مع Feature Flags
2. ✅ **Role-based Routing**: `AuthWrapper` + 6 entry points مختلفة
3. ✅ **Client-Safe Progress Writes**: قيود صارمة بدون Cloud Functions
4. ✅ **Gamification Idempotency**: Transaction-based badge awarding
5. ✅ **Department Flexibility**: `user_department_map` للربط المتعدد
6. ✅ **Security Migration**: إزالة secrets من العميل

### الإنجازات الكبرى 🎉
- ✨ نظام Gamification كامل (Points, Badges, Levels, Streaks)
- 🔐 Security & Monitoring framework جاهز
- 🏢 Multi-Tenant architecture صلب
- 🎨 40+ شاشة مع دعم AR/EN
- 🧪 30+ unit test
- 📊 6 Dashboards متخصصة
- 🔥 Firestore Rules شاملة (700+ سطر)

---

## للمطور الجديد 👨‍💻

### نقاط البداية المقترحة:
1. **اقرأ أولاً**: [`docs/PROJECT_COMPREHENSIVE_OVERVIEW.md`](docs/PROJECT_COMPREHENSIVE_OVERVIEW.md)
2. **افهم الأدوار**: راجع `lib/core/roles.dart`
3. **ادرس القواعد**: `firestore.rules` (مهم جداً!)
4. **جرّب التطبيق**: بأدوار مختلفة مع `RoleDebugWrapper`

### أوامر مفيدة:
```bash
# Run app
flutter run

# Run tests
flutter test

# Analyze
flutter analyze

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Deploy rules
firebase deploy --only firestore:rules

# Deploy indexes
firebase deploy --only firestore:indexes

# Deploy functions
firebase deploy --only functions
```

### الأولويات الحالية:
1. 🔥🔥🔥 Teaching Assignments UI completion
2. 🔥🔥 Learning Paths Authoring
3. 🔥🔥🔥 QA شامل قبل الإطلاق
4. 🔥 Performance testing

### المخاطر الرئيسية ⚠️:
- 🔴 **Firestore Rules Complexity**: اختبر بعناية!
- 🟠 **Performance at Scale**: راقب الاستعلامات الثقيلة
- 🟠 **Multi-tenant Data Leakage**: Triple-check rules

---

## معلومات الاتصال

**Repository**: training_app_v2 (GitHub: zezo12322)  
**Branch**: main  
**Last Updated**: October 12, 2025  
**Project Status**: Phase 5 (85% Complete)  
**Target Release**: 2-3 weeks  

### للاستفسارات:
- **Technical Docs**: راجع `docs/` folder
- **Architecture**: `PROJECT_COMPREHENSIVE_OVERVIEW.md`
- **Development Plan**: `MASTER_PLAN_V2.md`
- **Release Checklist**: `RELEASE_CHECKLIST.md`

---

## الخلاصة والتوصيات النهائية 🎯

### ما تم إنجازه (85%)
✅ **Architecture**: Multi-Tenant, 6 Roles, Secure by default  
✅ **Features**: Courses, Quizzes, Gamification, Learning Paths  
✅ **Security**: Firestore Rules (700+ lines), Security monitoring  
✅ **UI**: 40+ screens, AR/EN support, Role-based dashboards  
✅ **Testing**: 30+ unit tests, Rules simulation  

### ما هو متبقي (15%)
⏳ **Teaching Assignments**: UI completion (Dialog + Views)  
⏳ **Learning Paths Authoring**: Enable CRUD operations  
⏳ **QA**: Comprehensive testing قبل الإطلاق  
⏳ **Release**: Android build + Google Play setup  

### التوصيات للمطور الجديد

#### الأسبوع الأول:
1. 📚 اقرأ جميع الوثائق في `docs/`
2. 🏃 جرّب التطبيق بجميع الأدوار
3. 🔍 افهم Firestore Rules بعمق
4. 🧪 شغّل جميع الاختبارات وتأكد أنها تعمل

#### الأسبوع الثاني:
1. 🎨 أكمل Teaching Assignments UI
2. 📝 أكمل Learning Paths Authoring
3. 🧪 اكتب اختبارات للخصائص الجديدة

#### الأسبوع الثالث:
1. 🔍 QA شامل لجميع الأدوار
2. 🚀 تحضير Android Release
3. 📊 Performance testing
4. 📦 Google Play submission

### نصائح مهمة ⚠️

1. **لا تعدّل Firestore Rules بدون اختبار شامل** - الخطأ هنا قد يسبب data leakage!
2. **استخدم `RoleDebugWrapper`** في التطوير لمعرفة الدور الحالي
3. **اختبر بحسابات مختلفة** لكل دور
4. **راجع `CHANGELOG.md`** لفهم التغييرات الأخيرة
5. **اتبع `RELEASE_CHECKLIST.md`** قبل أي deployment

### الأولويات بالترتيب:
1. 🔥🔥🔥 Teaching Assignments UI (الأهم!)
2. 🔥🔥 QA & Testing
3. 🔥 Learning Paths Authoring
4. 🟡 Dashboard improvements
5. 🟢 Performance optimization

### معدل التقدم المتوقع:
- **With 1 developer full-time**: 2-3 weeks
- **With 2 developers**: 1-2 weeks
- **Part-time**: 3-4 weeks

---

## التوقيع والتسليم 📝

**تم تسليم المشروع من:**
- المطور: Zezo12322
- التاريخ: October 12, 2025
- الحالة: Phase 5 (85% Complete)
- الوثائق: محدّثة وشاملة

**نقاط التسليم الرئيسية:**
- ✅ الكود نظيف ومنظم
- ✅ الوثائق كاملة ومفصلة
- ✅ الاختبارات موجودة وتعمل
- ✅ Architecture قابل للتوسع
- ✅ Security measures مطبقة

---

**Last Updated:** October 12, 2025  
**Document Version:** 2.0 (Comprehensive)  
**Good Luck! 🚀 May the code be with you! 💻**