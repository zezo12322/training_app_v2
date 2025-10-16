# Role Separation Plan — Admins vs Trainers/Trainees

Purpose: stabilize personas and prevent feature leakage between roles by giving each role its own entry point, navigation, and guarded actions.

## Goals
- Clear separation of responsibilities for: Super Admin, Org Admin, Company Admin, Manager, Trainer, Trainee.
- Dedicated navigation surface per role; remove mixed dashboards.
- Strong UI and data guards to prevent cross-role actions.
- Minimal disruption to existing code; reuse providers where safe.

## Scope (MVP of separation)
- Routing: role → dedicated screen (done in code for AuthWrapper).
- Navigation: BottomNavShell only for Trainer/Trainee; Admin/Manager get dedicated dashboards.
- Guards: helper functions and small wrappers to gate actions and providers by role and tenant.
- Cleanup: hide/remove actions not relevant to the role in each screen.

## Architecture Changes
- Auth → Role Router
  - `AuthWrapper`: routes by role to: SuperAdminDashboard, OrgAdminDashboard, CompanyAdminDashboard, ManagerDashboard, or BottomNavShell('trainer'|'trainee').
- Navigation Surfaces
  - Trainer/Trainee: `BottomNavShell` (Dashboard|Progress|Profile|Settings) with FAB contextual.
  - Company Admin: `CompanyAdminDashboard(companyId)`.
  - Org Admin: `OrgAdminDashboard(institutionId)`.
  - Manager: `ManagerDashboard(departmentId)`.
- Guards Utilities (new): `lib/core/roles.dart`
  - isSuperAdmin/isOrgAdmin/isCompanyAdmin/isManager/isTrainer/isTrainee
  - inTenant(companyId?/institutionId?)
- Provider Safety
  - Ensure provider queries apply tenant filters; avoid broad list queries for non-admins.

## Detailed Checklist

### 1) Routing & Entry Points
- [x] Route by role in `lib/screens/auth_wrapper.dart` to dedicated surfaces.
- [x] Add a small `lib/core/roles.dart` with predicates for roles and tenant check.
- [x] Replace scattered role checks with helpers in key screens.

### 2) Navigation Surfaces
- [x] Company Admin: initial curation — departments and learning paths authoring gated by company admin.
- [ ] Org Admin: similar to company admin but at institution level; omit company-specific features.
- [x] Manager: assignments panel + team performance; no authoring controls, no global user listings.
- [x] Trainer: BottomNavShell unchanged.
- [x] Trainee: BottomNavShell unchanged.

### 3) Feature Visibility & Action Guards
- [x] Learning Paths: New Path + Assign Trainer gated to company_admin (tenant-scoped).
- [x] Departments: manage members and create department gated to company_admin.
- [x] Manager Dashboard: shows panels only; admin-only actions hidden.
- [ ] Users lists: restrict by tenant and role (audit pending).
- [x] Super Admin: separate dashboard; no BottomNavShell routing.

### 4) Provider & Rules Alignment
- [x] Firestore rules relaxed for admins & super admin across learning_paths/path_steps.
- [x] users list/get rules updated to allow tenant-scoped admin reads.
- [x] user_path_progress: use direct doc reads and fix rules for list/get.
- [x] Path steps: transactions + FieldValue.increment for stepsCount integrity.
- [ ] Audit remaining providers for tenant filters and list limits.

### 5) QA Scenarios
- [ ] Login as each role and verify landing screen and nav.
- [ ] Ensure a manager cannot create/edit path steps or assignments.
- [ ] Ensure a trainer cannot see admin panels (departments/tenant metrics).
- [ ] Ensure a trainee cannot create content or see admin metrics.
- [ ] Verify Firestore denies prohibited writes/reads while UI hides them.

### 6) Documentation & i18n
- [ ] Update `docs/MASTER_PLAN_V2.md` to reference role separation.
- [ ] Add any new l10n strings required for role-specific screens.

## Rollout Plan
1. Merge routing changes (done).
2. Add guards utilities and apply to key screens. (done)
3. Curate dashboards per role (surface appropriate features only). (in progress)
4. QA per role; fix leakage. (next)
5. Update docs. (ongoing)

## Next steps
- Audit user lists/providers for tenant filters and add guards where missing.
- Add a simple role/tenant debug banner in non-production builds to aid QA. (added RoleDebugWrapper on admin/manager)
- Expand Org Admin surfaces once institution flows are ready.

## Progress log (Oct 10, 2025)
- Fixed role providers and centralized tenant checks in `lib/core/roles.dart`.
- Updated `auth_wrapper.dart` to route managers via department mappings instead of a non-existent field.
- Gated Departments screen actions (create/manage members) by company admin.
- Learning Paths authoring hardened: transactions for stepsCount, removed analyzer warnings.
- Android debug build produced `app-debug.apk` successfully.
- Wrapped `CompanyAdminDashboard` and `ManagerDashboard` with `RoleDebugWrapper` (debug-only overlay) for fast QA.
- Cleaned `usersInCompanyProvider` mapping and removed unnecessary casts.

## Risks & Mitigations
- Hidden but not forbidden: enforce via Firestore rules as well.
- Complex role transitions: add a simple debug banner showing current role and tenant for testers.
- Navigation regressions: add smoke tests for AuthWrapper routing.

# خطة الإطلاق النهائي للتطبيق (Android فقط)

## الأهداف
- إنهاء جميع خصائص التطبيق بنسبة 100%.
- ضمان عمل التطبيق بشكل صحيح على أجهزة Android.
- نشر التطبيق على Google Play.

## المهام الرئيسية

### 1. تدقيق الحجب والشاشات
- مراجعة جميع الشاشات (users, reports, settings, dashboards).
- التأكد من أن كل خاصية محجوبة حسب الدور والمستأجر.
- استخدام RoleGate/RoleDebugWrapper حيث يلزم.

### 2. مراجعة قواعد Firestore
- تدقيق قواعد Firestore للتأكد من منع أي وصول غير مصرح به.
- تحديث القواعد إذا لزم الأمر.

### 3. QA شامل وتجهيز بيانات الإنتاج
- إعداد حسابات أدوار مختلفة:
  - super_admin
  - company_admin
  - manager
  - trainer
  - trainee
- تجربة كل سيناريو عملياً.
- توثيق أي ملاحظات أو أخطاء.

### 4. تجهيز توقيع وبناء Android Release
- إعداد keystore.
- تحديث build.gradle.
- بناء APK/AAB Release.
- تجربة التثبيت على جهاز فعلي.

### 5. نشر التطبيق على Google Play
- إعداد صفحة المتجر.
- رفع APK/AAB.
- كتابة وصف وصور.
- نشر داخلي/مغلق ثم إنتاجي.
- مراقبة Crashlytics/Logs.

### 6. خطة hotfix والمتابعة بعد الإطلاق
- تجهيز آلية إصلاح عاجل لأي خطأ يظهر بعد الإطلاق.
- توثيق خطوات المتابعة والمراقبة.
