# Master Plan (V2) — Multi‑Tenant Training Platform

تحديث شامل لخريطة الطريق بناءً على التصور الجديد لربط المُدرّس بالأقسام والمحتوى بشكل “مؤقت” عبر تعيينات تدريس Teaching Assignments، مع تضمين Phase 5 وخطوات التنفيذ.

## لماذا الإصدار V2؟
- مرونة أكبر: بدل ربط المدرّس بالقسم بشكل دائم، نستخدم تعيينات مؤقتة مربوطة بمسار تعلّم أو كورس خلال نافذة زمنية محددة.
- نظافة البيانات: العضويات الدائمة تبقى للوظائف الثابتة (مثلاً مدير قسم)، والتكليفات المؤقتة تُدار ككيان منفصل قابل للأرشفة.
- تقارير أدق: رصد الحمل التدريسي والنشاط عبر الزمن، ومتابعة جودة التنفيذ لكل تكليف.

## أدوار النظام (ملخص)
- Super Admin: إدارة كل التينانتس + إعدادات المنظومة.
- Org Admin (مؤسسة): إدارة محتوى/مسارات/مستخدمين على مستوى مؤسسة.
- Company Admin (شركة/مدرسة): إدارة الشركة، الأقسام، المسارات، تكليفات التدريس.
- Manager (رئيس قسم): متابعة الأداء وفجوات المهارات لفريقه.
- Trainer (مدرّس): إنشاء/تشغيل الكورسات والاختبارات والمهام داخل نطاق تكليفه.
- Trainee (متعلّم): يستهلك المحتوى ويحقق تقدّمًا.

## نموذج البيانات (Data Model)
المجموعات الأساسية:
- institutions: تعريف المؤسسة.
- companies: تعريف الشركة/المدرسة.
- departments: أقسام الشركة (companyId).
- users: بيانات المستخدم والدور + ربط tenant اختياري (institutionId/companyId).
- user_department_map: ربط دائم للمستخدم بقسم (مفيد للعضويات الثابتة وإشراف المدير).
- learning_paths: تعريف المسارات (tenantType, tenantId, title, ...).
- path_steps: خطوات المسار (pathId, order, title...).
- user_path_progress: تقدّم المستخدم في المسار (client-safe writes).

الجديد في V2:
- teaching_assignments: “تعيينات التدريس” المؤقتة.
  - tenantType: 'company' | 'institution'
  - tenantId
  - scopeType: 'course' | 'path'
  - scopeId: courseId أو pathId
  - trainerId
  - departmentId? (اختياري: للعرض ضمن قسم أثناء التكليف)
  - startAt, endAt, status ('active'|'ended'|'cancelled')
  - createdAt, updatedAt

الاستخدام:
- يظل دور المستخدم ثابتًا (role='trainer').
- التكليف هو الذي يوصله بمسار/كورس (وممكن بقسم) خلال نافذة زمنية.

## القواعد الأمنية (Firestore Rules) — المبدأ العام
- عزل البيانات بالتينانت: super_admin يرى الكل؛ org/company admin يرون نطاقهم فقط؛ manager يرى الأقسام/الفِرَق المرتبطة به؛ trainer/trainee ضمن نطاق تينانتهم.
- learning_paths & path_steps: القراءة متاحة حسب الدور/التينانت؛ الكتابة تُفتح للأدوار الإدارية في Phase 5 مع تحقق قوي.
- user_path_progress: كتابة آمنة من العميل بقيود صارمة (±1، والتحقق من stepsCount، وتطابق التينانت).
- teaching_assignments (جديد):
  - read: super_admin + org/company admin في نطاقهم + trainer يرى تكليفاته فقط.
  - write: org/company admin داخل نطاقهم؛ trainer لا يعدل إلا لو صممنا Workflow موافقات (خارج نطاق هذه المرحلة).

## واجهات المستخدم (ملخص)
- Super Admin Dashboard: إدارة التينانتس + (جديد) Assign Role سريع.
- Company Admin:
  - Departments: إنشاء/إدارة الأقسام.
  - Learning Paths: عرض (اليوم) + (Phase 5) إنشاء/تعديل.
  - Teaching Assignments: (Phase 5) تعيين مدرّس لمسار/كورس بفترة زمنية.
- Manager Dashboard: عرض المدرّسين/الأعضاء “النشطين” خلال الفترة عبر التعيينات + قياسات المخاطر والفجوات.
- Trainer: يرى “Assigned to me” (المسارات/الكورسات المكلّف بها) ويُدير المحتوى.
- Trainee: تجربة التعلّم العادية.

---

## خريطة الطريق (Phases)

### Phase 0–3 — منجزة/مستقرة
- 0) Bootstrap + Auth + Navigation + الأساسية.
- 1) Multi‑tenancy (users، institutions، companies) وقواعد الأمان الأساسية.
- 2) Courses/Tasks/Quizzes + Gamification (points/badges) + Progress شاشات أساسية.
- 3) Admin Dashboards (Super/Admin/Manager) + Settings + Logout/Login تدفّق ثابت.

### Phase 4 — Learning Paths (الحالة: عرض + تقدّم جاهز؛ التأليف لاحق)
- قراءة المسارات للشركة + عرض الخطوات + كتابة تقدّم المستخدم من العميل.
- المطلوب لاحقاً (ضمن Phase 5): تمكين التأليف (create/update) للمسارات والخطوات للأدوار الإدارية.

### Phase 5 — Teaching Assignments + Authoring + Role Tools (الجديد)

نطاق العمل:
1) Teaching Assignments (كيان جديد):
   - إضافة collection + مزوّدات (Providers) للقراءة/الإنشاء/التحديث.
   - واجهة Company Admin: “Assign Trainer” لمسار/كورس (اختيار trainer + start/end + departmentId? اختيارياً).
   - قواعد Firestore: read/write كما هو موضح أعلاه.
   - Manager Dashboard: إظهار المدرّسين/الأعضاء “النشطين” الحاليين بناءً على التعيينات الزمنية.

2) Learning Paths Authoring:
   - تمكين إنشاء/تعديل المسارات (Company/Org Admin فقط، داخل نطاق tenant).
   - إدارة الخطوات (add/edit/reorder/delete) + stepsCount آلي.
   - قواعد Firestore: create/update صارمة مع التحقّق من tenant.

3) Role Assignment UI (تحسين):
   - داخل Super Admin: Dialog “Assign Role” (بالبحث بالإيميل) لتغيير role وربط institutionId/companyId.
   - موجود مزوّدات مساعدة بالفعل: findUserByEmailProvider، updateUserRoleProvider.

4) تقارير وUX:
   - “Assigned to me” للمدرّس: قائمة بمهامه النشطة (مسارات/كورسات) حسب التاريخ.
   - فلترة في Manager Dashboard: حسب الفترة/القسم/المعلم.

القبول (Acceptance Criteria):
- أ) إنشاء تكليف تدريس ناجح يربط المدرّس بمسار/كورس ويتحول تلقائياً إلى “active” ضمن الفترة.
- ب) انتهاء التكليف (بلوغ endAt) يُخفيه من القوائم النشطة دون حذف السجل (أرشفة).
- ج) Company Admin قادر على إنشاء/تعديل مسار وخطواته في نطاق شركته فقط.
- د) قيود الكتابة في user_path_progress كما هي (±1 وتطابق tenant) تعمل بدون كسر تجربة المستخدم.
- هـ) القياس: يظهر للمُدرّس “Assigned to me”، ويظهر للـ Manager المدرّسون/الأعضاء النشطون حالياً.

تقدير المهام (مرتّبة للتنفيذ):
1) Teaching Assignments — Data & Rules
   - [x] نموذج مزوّدات: assignmentsByTrainerProvider, assignmentsByScopeProvider, assignmentsByTenantProvider, create/update/cancel providers.
   - [x] Firestore rules: read/write/tenant scoping + status transitions.
   - [x] فهارس (indexes) للqueries الأساسية (trainer/tenant/scope + status/startAt).
2) UI: Assign Trainer
   - [x] Dialog من شاشة المسار/الكورس (Company Admin).
   - [x] Validation التاريخ/التينانت/التعارضات البسيطة (تحذير overlap اختياري).
3) Manager Dashboard تحديث
   - [x] استهلاك التعيينات لإظهار “نشط حاليًا”.
   - [x] فلاتر بسيطة (by department/date range: Active Now | Upcoming 30d | Archive 30d).
4) Learning Paths Authoring  
   - [ ] Enable create/update في rules.
   - [ ] New Path dialog + Manage Steps (CRUD + reorder).
   - [ ] stepsCount sync.
5) Super Admin — Assign Role
   - [ ] Dialog نهائي (استخدام findUserByEmailProvider + updateUserRoleProvider).
6) Trainer “Assigned to me”
   - [ ] شاشة/قسم يعرض المسارات/الكورسات النشطة للمعلّم بحسب التعيينات.

### Phase 5 — Detailed Checklist (أقصى تفصيل)

مبدأ عام للتنفيذ
- كل عنصر أدناه يحتوي: نطاق التغيير، المهام الفرعية، معايير القبول، اختبارات وQA، وملاحظات الأداء/الفهارس.
- افتراضات: لا توجد Cloud Functions حاليًا؛ سنبقي قواعد Firestore قابلة للتطبيق مع تحققات معقولة على مستوى العميل والإداري.

1) Teaching Assignments — Data, Providers, Rules, Indexes
    - نطاق التغيير
       - إضافة collection جديدة: teaching_assignments
       - مزوّدات Riverpod للقراءة/الكتابة
       - تحديث القواعد الأمنية لعزل التينانت والدور
       - إعداد فهارس للqueries الشائعة
    - مخطط المستند
       - fields:
          - id: string (docId)
          - tenantType: 'company' | 'institution' (required)
          - tenantId: string (required)
          - scopeType: 'path' | 'course' (required)
          - scopeId: string (required)
          - trainerId: string (required)
          - departmentId: string? (optional)
          - startAt: Timestamp (required)
          - endAt: Timestamp (required, > startAt)
          - status: 'active' | 'ended' | 'cancelled' (required)
          - createdAt: Timestamp (server)
          - updatedAt: Timestamp (server)
    - المزوّدات (Providers) — عقود وتوقّعات
       - assignmentsByTrainerProvider(trainerId, now?): Stream<List<Assignment>>
          - افتراض: now افتراضي DateTime.now() لتصفية “نشط الآن” عند الحاجة
          - يستعمل where(trainerId==..), where(status in ['active']) + startAt<=now<endAt
       - assignmentsByScopeProvider(scopeType, scopeId, status?): Stream<List<Assignment>>
          - يدعم فلترة حسب status أو window
       - assignmentsByTenantProvider(tenantType, tenantId, status?, dateRange?): Stream<PagedResult>
          - للـ Admin/Manager مع pagination
       - createAssignmentProvider(params): Future<Result<Assignment>>
          - يتحقق من: صلاحيات الكاتب، صحة النطاق، trainer.role == 'trainer', عدم تداخل بسيط اختياري (تحذير فقط)
       - updateAssignmentProvider(id, patch): Future<Result>
          - الحقول المسموحة: endAt, status, departmentId
          - يمنع تغيير tenantType/tenantId/scope*/trainerId بعد الإنشاء
       - cancelAssignmentProvider(id): Future<Result>
          - يضبط status='cancelled' وupdatedAt=serverTimestamp
    - القواعد الأمنية (Firestore Rules)
       - read:
          - allow read: إذا requester.role=='super_admin'
          - allow read: إذا requester.role in ['org_admin','company_admin'] AND requester.tenant matches {tenantType,tenantId}
          - allow read: إذا requester.uid == trainerId (يرى تكليفاته فقط)
       - list constraints:
          - impose limit <= 100، require explicit where on tenant for admins، وعلى trainerId للمدرّس
       - write (create):
          - requester.role in ['org_admin','company_admin'] AND requester.tenant matches doc.tenant
          - doc.status in ['active','ended','cancelled'] (عند الإنشاء عادة 'active' إذا now ضمن window، وإلا 'ended' لو نافذة منتهية — نفضّل دائماً الإنشاء بـ 'active' ونافذة مستقبلية/حالية)
          - startAt < endAt
          - trainerId يشير لمستخدم role=='trainer' في نفس tenant (أو visible by tenantType)
          - منع set للـ createdAt/updatedAt من العميل؛ تُكتب عبر request.time (validate serverTimestamp pattern)
       - write (update):
          - فقط org/company admin ضمن نفس tenant
          - مسموح تعديل: endAt, status, departmentId, updatedAt
          - انتقالات status:
             - active -> ended | cancelled مسموح
             - ended/cancelled -> active ممنوع
       - delete: ممنوع (أرشفة بدل حذف)
    - الفهارس (firestore.indexes.json)
       - Composite للتالي:
          - collection: teaching_assignments, fields: [trainerId ASC, status ASC, startAt DESC]
          - collection: teaching_assignments, fields: [tenantType ASC, tenantId ASC, status ASC, startAt DESC]
          - collection: teaching_assignments, fields: [scopeType ASC, scopeId ASC, status ASC, startAt DESC]
    - معايير القبول
       - إنشاء تكليف يعكسه مزوّد العرض خلال ≤ 2s
       - مدرّس يرى التكليف “النشط الآن” فقط اعتمادًا على now داخل حدود [startAt, endAt)
       - تحديث status إلى ended يخفيه من “نشط الآن” ويظهره في “الأرشيف”
    - اختبارات وQA
       - Happy path: إنشاء تكليف بمواعيد صحيحة، يظهر للمدرّس والمدير
       - Edge: startAt==endAt مرفوض، نافذة منتهية تُنشأ وتظهر كـ ended
       - صلاحيات: trainer لا يستطيع الإنشاء/التعديل؛ company_admin خارج التينانت مرفوض
       - أداء: قائمة المدرّس تُحمّل ≤ 200 عنصر مع pagination

2) UI: Assign Trainer (Company Admin)
    - نقاط الدخول
       - من شاشة تفاصيل المسار (learning_paths details) — زر "Assign Trainer"
       - مستقبلاً: من تفاصيل الكورس
    - عناصر الواجهة
       - Dialog أو BottomSheet يحتوي:
          - اختيار trainer (search by name/email, within tenant)
          - اختيار التاريخ: startAt, endAt (Date/Time pickers)
          - اختيار departmentId? (اختياري)
          - زر Create + مؤشر تحميل + رسائل خطأ محلية
       - Toast/Snackbar للنجاح
    - التحقّقات
       - required: trainer, startAt, endAt, startAt<endAt
       - التينانت: يطابق المسار/الشركة الحالية
       - تداخل مواعيد: تحذير فقط إذا وُجد overlap لنفس trainer&scope
    - التكامل مع المزوّدات
       - يستخدم createAssignmentProvider
       - إعادة تحميل assignmentsByScopeProvider بعد النجاح
    - معايير القبول
       - لا يمكن ضغط Create قبل استيفاء كل الحقول
       - بعد الإنشاء، يظهر التكليف في جدول/قائمة المسار
    - اختبارات وQA
       - UI validation يعمل محليًا قبل الاتصال
       - أخطاء القواعد تظهر برسالة ودّية

3) Manager Dashboard — Active Now + Filters
    - البيانات
       - يعتمد على assignmentsByTenantProvider مع where status='active' ونافذة تشمل الآن
       - join مبسّط لإظهار أسماء المدرّسين/الأقسام/المسارات (queries إضافية أو caching)
    - الواجهة
       - فلاتر: department, dateRange (افتراضي: اليوم)
       - تبويب: Active Now | Upcoming | Archive
       - Pagination عند >50 نتيجة
    - الأداء
       - حدود 50 لكل صفحة + زر Load more
       - فهرسة حسب tenant/status/startAt
    - معايير القبول
       - تبديل الفلاتر يحدّث القائمة خلال ≤ 1s بعد وصول البيانات
    - اختبارات
       - صلاحيات المدير ضمن قسمه/شركته فقط
       - نتائج "Active Now" لا تُظهر ended/cancelled

4) Learning Paths Authoring (Create/Update + Steps CRUD/Reorder)
    - القواعد (rules)
       - allow create/update on learning_paths: للأدوار org_admin/company_admin ضمن التينانت فقط
       - allow CRUD على path_steps داخل path نفسه لنفس الأدوار
       - منع delete للمسار إذا لديه steps إلا بعد حذف/أرشفة
       - قيود معقولة: title length, description length, order >=0
    - مزوّدات
       - createPathProvider, updatePathProvider, deletePathProvider? (soft-delete مؤجل)
       - steps providers: addStep, updateStep, deleteStep, reorderSteps (يحفظ order متسلسلًا)
       - sync stepsCount: يُحدّثه العميل بعد كل تغيير خطوات (التحقق الصارم مؤجل)
    - الواجهة
       - New Path dialog: title, description, visibility (tenant-bound)
       - Manage Steps screen: قائمة قابلة للسحب لإعادة الترتيب + CRUD
       - Guard على الخروج إن كان هناك تغييرات غير محفوظة
    - الفهارس
       - path_steps: index على [pathId ASC, order ASC]
    - معايير القبول
       - إنشاء مسار يظهر فورًا في قائمة الشركة
       - إعادة ترتيب الخطوات يعكس order الجديد خلال ≤ 2s
    - اختبارات
       - صلاحيات الكتابة محصورة بالإداريين
       - stepsCount يساوي عدد steps بعد عمليات CRUD (mild check في UI + مزوّد)

5) Super Admin — Assign Role Dialog
    - الواجهة
       - حقل بحث بالإيميل (debounced)
       - Dropdown role: super_admin, org_admin, company_admin, manager, trainer, trainee
       - اختيار tenantType + tenantId (عند الحاجة)
    - التحقّقات
       - منع إسقاط super_admin الوحيد
       - عند اختيار role إداري، tenant مطلوب
    - التكامل
       - استخدام findUserByEmailProvider + updateUserRoleProvider
    - معايير القبول
       - تحديث الدور ينعكس عند إعادة تحميل بيانات المستخدم
    - اختبارات
       - أخطاء عدم العثور على المستخدم، صلاحيات، ربط tenant

6) Trainer — Assigned to me
    - البيانات
       - assignmentsByTrainerProvider(trainerId, now)
       - join لإظهار أسماء المسارات/الكورسات
    - الواجهة
       - تبويبات: Active | Upcoming | Archive
       - إجراءات سريعة: الذهاب لتفاصيل المسار/الكورس
    - معايير القبول
       - "Active" يطابق النافذة الزمنية الحالية
    - اختبارات
       - مدرّس لا يرى تكليف مدرّس آخر

### Phase 5 (Advanced)

- [ ] Adaptive engine iteration (Recommendation Provider)
   - توصيات مسارات/كورسات مخصصة حسب سلوك المستخدم وأهداف الشركة.
   - نسخة أولى: قواعد بسيطة + تتبع CTR/الإنهاء، ثم تحسين تدريجي ببيانات الاستخدام.
- [ ] Tokens economy schema
   - اقتصاد نقاط/توكنز موحّد للاستخدام عبر المهام والإنجازات والاسترداد.
   - دفتر أستاذ بسيط (ledger) مع منع التلاعب ومراجعات إدارية.
- [ ] Certificates issuance + QR verify
   - توليد شهادات (PDF/PNG) مع QR يرتبط بصفحة تحقق عامة تعرض بصمة/معرّف الشهادة.
   - سجل شهادات في Firestore + نقطة تحقق للعموم (قراءة فقط).
- [ ] SSO integration scaffold
   - هيكل تكامل أولي (Google/Microsoft SSO) عبر Firebase Auth مع ربط tenant وسياسات تطابق النطاقات البريدية.
- [ ] HRIS ingest stub
   - استيراد CSV/Excel مبدئي لمستخدمي الموارد البشرية (users/departments/roles) + idempotency.
- [ ] BigQuery export job
   - جدولة تصدير بيانات الاستخدام/التقدّم إلى BigQuery أو GCS لتحليلات متقدمة ولوحات قياس.
- [ ] ML anomaly (optional post-export)
   - كشف الشذوذ (الغش/نشاط غير اعتيادي) بعد توفّر بيانات كافية في BigQuery.

#### الذكاء الاصطناعي — Features (Roadmap)

- [ ] توصيات شخصية للمسارات/المحتوى (RecSys) — مبني على إشارات التفاعل والتقدّم.
- [ ] مولّد أسئلة/اختبارات من المحتوى بإشراف إداري (Prompting + حواجز أمان للمحتوى).
- [ ] مساعد تعلّمي داخل التطبيق للسؤال عن المحتوى المسموح (RAG على مسارات/خطوات الشركة).
- [ ] تصحيح تلقائي للمهام النصية مع Rubrics قابلة للتهيئة + شروحات.
- [ ] كشف الشذوذ والغش (من BigQuery) — جلسات قصيرة جدًا، تبدلات جهاز متكررة، أنماط غير طبيعية.
- [ ] بحث دلالي متعدد اللغات (Embeddings) على الموارد والمسارات.
- [ ] تلخيص تقارير المدير الأسبوعية تلقائيًا (Auto-summaries) مع مؤشرات قابلة للتنفيذ.

ملاحظات سريعة
- البداية تكون بقواعد/تحليلات بسيطة ثم ترقية تدريجية نحو النماذج (لا حاجة لتبديل معماري كبير).
- احترام الخصوصية: عدم استخدام بيانات حساسة للتدريب؛ وضع سياسات الاحتفاظ/المحو.
- يمكن دعم التنفيذ عبر خدمات Google (Vertex AI/BigQuery) أو بدائل حسب المتاح.

7) عام — i18n, Docs, QA, Rollout
    - i18n
       - تحديث app_en.arb, app_ar.arb للمفردات الجديدة (Assignments, Assign Trainer, Status, etc.)
       - تشغيل التوليد (gen_l10n)
    - توثيق
       - تحديث هذا المستند + صور للشاشات الجديدة
       - README: إضافة قسم Phase 5 واختصارات المطوّر
    - QA
       - سيناريوهات: إداري شركة، مدير قسم، مدرّس، متعلّم
       - Checklists: صلاحيات/نافذة زمنية/ترجمة/هواتف صغيرة/وضع مظلم
    - Rollout تدريجي
       - الخطوة 1: تمكين القراءة فقط لقوائم Assignments
       - الخطوة 2: فتح إنشاء التعيينات لمؤسسة تجريبية
       - الخطوة 3: تفعيل تأليف المسارات
       - الخطوة 4: تمكين شاشات المدرّس والمدير بالكامل

Dependencies & Notes
- يتطلب: تحديث firestore.rules وفق ما سبق + إضافة فهارس في firestore.indexes.json
- الأداء: الالتزام بحدود الاستعلام، وإظهار رسائل Empty state بدل جلب ضخم
- الأمان: لا حذف نهائي لتكليف؛ أرشفة عبر status فقط

مرجع إضافي: انظر ملف خطة فصل الأدوار `docs/ROLE_SEPARATION_PLAN.md` لضمان عدم تداخل خصائص بين الإداريين والمدربين/المتعلمين.

المخاطر والتخفيف:
- تضارب جداول التعيين: نبدأ بتحذير بسيط عند overlap، نؤجل منع التداخل المتقدّم لمرحلة لاحقة.
- قواعد أمن معقّدة: نضيف اختبارات يدوية وسيناريوهات QA لكل كتابة/قراءة.
- الأداء: استخدام استعلامات محدّدة + حدود (limit) + فهرسة عند الحاجة.

خطة الإطلاق التدريجي (Rollout):
1) تفعيل Teaching Assignments (قراءة فقط) + UI العرض.
2) تمكين الإنشاء للأدوار الإدارية على نطاق صغير (بيئة اختبار/مؤسسة واحدة).
3) تفعيل Learning Paths Authoring.
4) تمكين تقارير/لوحات المدرّس والمدير.

## سجل التقدم (Progress Log)
- 2025‑10‑09: توحيد التصور V2 + إضافة Phase 5، وضبط قواعد multi‑tenancy (institutions/companies) وتحصين flags للقراءات.
- 2025‑10‑09: تنفيذ بند 1 من Phase 5 — إضافة teaching_assignments model + providers، تحديث firestore.rules، وإضافة composite indexes.
- 2025‑10‑10: تنفيذ بند 2 بالكامل (Assign Trainer UI + overlap warning + عرض active assignments في شاشة المسار) وتنفيذ بند 3 (Manager Dashboard Active/Upcoming/Archive).
- 2025‑10‑10: إضافة Phase 5 (Advanced) + خارطة مزايا الذكاء الاصطناعي (RecSys/Assistant/Anomaly/Certificates/SSO/HRIS/BigQuery).
- لاحقاً: تحديث هذا السجل بعد كل إنجاز فرعي (نُنصح بإضافة تاريخ/تعليق مختصر).

## ملاحق — ملفات مرجعية
- Providers:
  - `lib/providers/learning_path_providers.dart`
  - `lib/providers/super_admin_providers.dart` (findUserByEmailProvider, updateUserRoleProvider)
  - `lib/providers/department_providers.dart`, `lib/providers/team_providers.dart`
- Screens:
  - `lib/screens/learning_paths_screen.dart`
  - Dashboards: Super/Org/Company/Manager
- Rules:
  - `firestore.rules` (learning_paths, user_path_progress, tenants …)

---

ملاحظة: هذا المستند هو المرجع التنفيذي الحالي. بعد كل خطوة من Phase 5، يُرجى تحديث “Progress Log” ووضع علامة ✔️ على المهام المنتهية، مع ربط الكومِت/البرنش عند الحاجة.
