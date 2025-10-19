# Training App v2 - AI Agent Instructions

## Project Overview
A multi-tenant Flutter training management app (Flutter 3.9.2+) with Firebase backend, featuring role-based access, gamification, course walls, chat, and ML anomaly detection. Supports 6 roles: `super_admin`, `org_admin`, `company_admin`, `manager`, `trainer`, `trainee`.

## Architecture Patterns

### Multi-Tenancy Model
- **Hierarchy**: `institutions` → `companies` → `departments` → users
- All entities include `institutionId` and/or `companyId` for tenant isolation
- Feature flags in `system_settings/global` control tenant read/write enforcement
- Firestore security rules enforce tenant boundaries (see `firestore.rules`)
- Users can belong to multiple departments via `user_department_map` collection

### State Management (Riverpod 2.5.1)
- Use `StreamProvider.family` for real-time data with parameters (e.g., `wallPostsStreamProvider`)
- Use `FutureProvider.family` for async operations with caching
- Provider files named `*_providers.dart` in `lib/providers/`
- Auth state flows through `currentUserModelProvider` (from `auth_provider.dart`)
- Use `.autoDispose` for screen-scoped providers to prevent memory leaks

### Data Models (Freezed + JSON Serializable)
- All models use `@freezed` for immutability and copyWith
- JSON serialization with `@JsonSerializable(explicitToJson: true)` (see `build.yaml`)
- Timestamp fields use custom `@TimestampConverter()` (see `core/timestamp_converter.dart`)
- Always generate with: `dart run build_runner build --delete-conflicting-outputs`
- **PowerShell cleanup pattern**: `Remove-Item lib/providers/gamification/*.g.dart -ErrorAction SilentlyContinue; dart run build_runner build --delete-conflicting-outputs`

### Error Handling (Result Pattern)
- Use `Result<T>` from `core/result.dart` for all repository operations
- `Success(data)` for successful operations
- `FailureResult(Failure)` with typed failures: `network`, `auth`, `notFound`, `validation`, `permission`, `rateLimit`, `storage`, `unknown`
- Check `isRetryable` property on failures to enable retry logic
- Example: `return Success(userPoints);` or `return FailureResult(Failure.notFound('User not found'))`

### Repository Pattern
- Repositories in `lib/repositories/` encapsulate Firestore operations
- Return `Result<T>` for operations that can fail
- Use `Stream<List<T>>` for real-time data, `Future<Result<T>>` for one-time operations
- Always inject `FirebaseFirestore` via constructor for testability
- See `WallPostRepository` for pagination patterns with `startAfterDocument`

## Critical Developer Workflows

### Code Generation (MANDATORY after model changes)
```powershell
# Clean generated files first (PowerShell)
Remove-Item lib/models/*.g.dart, lib/models/*.freezed.dart -ErrorAction SilentlyContinue
dart run build_runner build --delete-conflicting-outputs
```

### Running the App
```bash
flutter run                    # Default device
flutter run -d <device-id>     # Specific device
flutter run --dart-define=PERF_LOGS=true  # Enable perf monitoring
```

### Testing
- Unit tests use `mocktail` for mocking
- Integration tests use `fake_cloud_firestore` for Firestore mocking
- Run tests: `flutter test`
- Run with coverage: `flutter test --coverage`
- Test files mirror source structure in `test/` directory
- See `test/wall_filter_providers_test.dart` for provider testing patterns

### Localization (i18n)
- ARB files in `lib/l10n/`: `app_en.arb` (English), `app_ar.arb` (Arabic)
- Generated classes in `lib/l10n/gen/app_localizations.dart`
- Access via `context.l.keyName` using extension from `core/l10n_ext.dart`
- Regenerate: `flutter gen-l10n`

### Firebase Backend Functions
- Node.js functions in `functions/` directory
- Deploy: `firebase deploy --only functions`
- Key functions: `sendPostNotification`, `buildEngagementSnapshots`, `computeUserRiskScores`
- Always use structured logging from `functions/logging.js`

## Project-Specific Conventions

### Role-Based UI Gating
- Use `RoleGate` widget for conditional rendering based on role:
  ```dart
  RoleGate(
    allowRoles: ['company_admin', 'org_admin'],
    builder: (context) => AdminPanel(),
    fallback: Text('Access Denied'),
  )
  ```
- Role providers: `isSuperAdminProvider`, `isOrgAdminProvider`, `isCompanyAdminProvider`, `isManagerProvider`, `isTrainerProvider`, `isTraineeProvider`

### Gamification System
- **Points**: Awarded for events (lesson completed=10, quiz passed=20, daily streak=5)
- **Levels**: Calculated as `floor(sqrt(points / 50)) + 1`
- **Badges**: 6 families stored in `badges` collection, awarded via transaction-based system
- **Streaks**: Daily activity tracked in `user_points.dailyStreak` + `lastActiveDay`
- **Idempotent awarding**: Use Firestore transactions to prevent duplicate badge awards
- Badge listening: `gamification_providers.dart` includes auto-award logic

### Course Wall Features
- Posts support: text, images (single/multiple), polls
- Real-time updates via `StreamProvider` → `wallPostsStreamProvider`
- Pagination with `startAfterDoc` parameter
- Reactions: stored as map in `reactions` field: `{userId: emojiString}`
- Comments: separate `course_wall_comments` collection with `postId` reference
- Pin/archive: boolean flags `isPinned`, `isArchived`
- Filtering: Use `wall_filter_providers.dart` for search/filter/sort logic

### Push Notifications
- OneSignal integration (v5.3.4) for push notifications
- Backend Cloud Function sends notifications on new wall posts
- User tokens stored in `oneSignalPlayerId` field of `users` collection
- Initialize in `lib/services/notification_service.dart`

### Security Rules Patterns
- Always check `isSignedIn()` first
- Use helper functions: `isSuperAdmin()`, `isTrainer()`, `isTrainee()`, etc.
- Enforce tenant scoping with `tenantReadsEnforced()` and `tenantWritesEnforced()` flags
- Active institution/company checks: `institutionActive()`, `companyActive()`
- Example enrollment check: `isEnrolledInCourse(userId, courseId)`

### Firestore Indexes
- Composite indexes required for complex queries (filter + range + order)
- Indexes defined in `firestore.indexes.json`
- Deploy: `firebase deploy --only firestore:indexes`
- **CRITICAL**: Indexes take 2-10 minutes to build after deployment
- Check status: Firebase Console → Firestore → Indexes tab
- Common index patterns:
  - Leaderboards: `(courseId, lastActivityDate, totalPoints DESC)`
  - Wall posts: `(courseId, isPinned DESC, createdAt DESC)`
  - User progress: `(userId, courseId, lastActivityAt DESC)`
- If query fails with FAILED_PRECONDITION, click the provided console link to auto-create index


### Performance Monitoring
- Bootstrap monitoring in `core/bootstrap.dart`
- Frame timing callbacks log jank (>16ms build/raster)
- Global error handlers catch Flutter, zone, and platform errors
- Logging uses `logger` from `core/logging.dart` (structured with severity levels)

## Common Pitfalls & Solutions

### Issue: Build Runner Fails
**Solution**: Delete generated files first, then rebuild:
```powershell
Remove-Item lib/**/*.g.dart, lib/**/*.freezed.dart -ErrorAction SilentlyContinue -Recurse
dart run build_runner build --delete-conflicting-outputs
```

### Issue: Firestore Permission Denied
**Check**: User has correct `institutionId`/`companyId`, feature flags are not blocking, and tenant is not suspended

### Issue: Provider Not Updating
**Check**: Use `.autoDispose` for screen-scoped data, ensure `family` parameters match, verify upstream provider is StreamProvider not FutureProvider for real-time updates

### Issue: Badge Not Awarding
**Check**: `GamificationRepository.awardBadgeIfEligible()` uses transaction-based logic; ensure `userBadges` array doesn't already contain badge ID

### Issue: Build Fails on iOS/Android
**Check**: Run `flutter clean`, `flutter pub get`, delete `ios/Pods` and `android/.gradle`, then rebuild

## Key Files Reference

- **Entry Point**: `lib/main.dart` - App initialization with Firebase, Riverpod, monitoring
- **Auth Flow**: `lib/screens/auth_wrapper.dart` - Routes by role after authentication
- **Multi-Tenant Core**: `lib/core/roles.dart` - Role providers and RoleGate widget
- **Result Pattern**: `lib/core/result.dart` - Error handling abstraction
- **Firestore Rules**: `firestore.rules` - Security rules with tenant isolation (1038 lines)
- **Backend Functions**: `functions/index.js` - Notifications, engagement, risk scoring
- **Gamification Logic**: `lib/providers/gamification_providers.dart` - Points, badges, leaderboard
- **Testing Guide**: `TESTING_GUIDE.md` - Quick start for manual testing flows
- **Project Plan**: `PROJECT_PLAN.md` - Roadmap, priorities, feature status

## Documentation Navigation
- **Features**: `docs/features/` - Individual feature specs (Chat, Course Wall, HRIS Import, etc.)
- **Gamification**: `docs/gamification/` - Daily logs, MVP plan, security rules
- **Planning**: `docs/planning/` - Master roadmap, role separation architecture
- **Deployment**: `docs/deployment/` - Release checklist and process
- **Security**: `docs/security/` - Migration guides, intrusion detection models

## Advanced Features
- **SSO**: Google Sign-In, Apple Sign-In with auto-provisioning (`lib/services/sso_service.dart`)
- **HRIS Import**: CSV/Excel bulk user import with mapping wizard (`lib/screens/hris_import_screen.dart`)
- **BigQuery Export**: Scheduled data exports (placeholder, requires `google_cloud` package)
- **ML Anomaly Detection**: Z-score based detection for cheating, suspicious logins, rapid progress (`lib/providers/anomaly_providers.dart`)
- **Chat System**: Real-time course chat and direct messages with Firestore (`lib/repositories/chat_repository.dart`)

## UI/UX Improvement Project (NEW - October 2025)
- **Main Plan**: `UI_UX_IMPROVEMENT_PLAN.md` - 8-phase roadmap with detailed checklists and code examples
- **Progress Tracking**: `PROGRESS_TRACKING.md` - Daily progress, statistics, and lessons learned
- **Quick Reference**: `DESIGN_SYSTEM_QUICK_REF.md` - Design Tokens reference (colors, typography, spacing)
- **Design System**: `lib/core/design/tokens.dart` - Adaptive colors, typography, spacing for Light/Dark Mode
- **Current Status**: Phase 1 (Design System) & Phase 2 (Auth Screens) complete - 15% overall progress

### Design System Usage
```dart
// Always use Design Tokens for consistency and Light/Dark Mode support
Container(
  color: DesignTokens.surface(context),           // NOT Colors.white
  padding: EdgeInsets.all(DesignTokens.spacingLg), // NOT EdgeInsets.all(16)
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(DesignTokens.radiusLg), // NOT BorderRadius.circular(12)
    boxShadow: DesignTokens.shadowMd(context),     // Adaptive shadows
  ),
  child: Text(
    'Title',
    style: DesignTokens.h4(context),               // NOT TextStyle(fontSize: 28, ...)
  ),
)
```

## When Making Changes
1. **Models**: Update model → run build_runner → check generated `.g.dart` and `.freezed.dart`
2. **Providers**: Use correct provider type (Stream vs Future) → test with `.autoDispose` → verify family parameters
3. **Repositories**: Return `Result<T>` → handle all error cases → add Firestore indexes if querying new fields
4. **UI**: 
   - **NEW**: Use `DesignTokens` for all colors, typography, spacing, and shadows
   - Check role-based access with `RoleGate` 
   - Use `context.l` for localization 
   - Test on both Arabic and English
   - **NEW**: Test Light/Dark Mode with `DesignTokens`
   - **NEW**: Test responsive design (Desktop/Tablet/Mobile)
5. **Security**: Update `firestore.rules` → deploy rules → test with different roles
6. **Backend**: Update Cloud Functions → test locally with emulator → deploy with `firebase deploy --only functions`
7. **UI/UX Development** (NEW):
   - Check current task in `PROGRESS_TRACKING.md`
   - Follow detailed steps in `UI_UX_IMPROVEMENT_PLAN.md`
   - Use code examples from `DESIGN_SYSTEM_QUICK_REF.md`
   - **ALWAYS** update `PROGRESS_TRACKING.md` after completing any task
   - Test Light/Dark Mode, Responsive, and RTL support
   - Git commit after each screen/feature completion

## Daily Workflow for UI/UX Tasks
1. **Morning** (5 min): Review `PROGRESS_TRACKING.md` → identify today's task
2. **Start Task** (10 min): Read task section in `UI_UX_IMPROVEMENT_PLAN.md` → copy starter code
3. **During Work**: Use `DESIGN_SYSTEM_QUICK_REF.md` for quick reference → avoid hardcoded values
4. **After Task** (10 min): 
   - Test thoroughly (Light/Dark, Responsive, RTL)
   - Git commit with clear message
   - **UPDATE `PROGRESS_TRACKING.md`** with:
     - Task completion status
     - Time spent
     - Problems encountered and solutions
     - Update statistics (files modified, lines of code)
     - Set next task
5. **End of Day**: Review progress → plan tomorrow's work

## 🎯 CRITICAL: Checklist Management (MANDATORY)

### File Reference: `UI_UX_NEXT_PHASE_CHECKLIST.md`
This is the **master checklist** for all UI/UX development work. This file MUST be updated after completing ANY task.

### When to Update the Checklist:
1. ✅ **After completing ANY feature/component** (even small ones)
2. ✅ **After finishing a screen or major section**
3. ✅ **After successful Git commit**
4. ✅ **Before moving to the next task**
5. ✅ **At the end of each work session**

### How to Update the Checklist:
1. **Mark completed items**: Change `- [ ]` to `- [x]`
2. **Update progress percentages**: Recalculate based on completed/total tasks
3. **Update statistics table**: Add new commits, files, lines of code
4. **Update "Next Step" section**: Specify what's coming next
5. **Update timestamps**: Change "Last Updated" date

### Example Update Pattern:
```markdown
# Before
- [ ] Create AppCard widget
**Progress**: 0% (0/10)

# After
- [x] Create AppCard widget
**Progress**: 10% (1/10)
**Git Commit**: ✅ `abc1234` - "feat: Add AppCard widget"
```

### Update Locations in Checklist:
1. ✅ Individual task items (check boxes)
2. ✅ Section progress percentages
3. ✅ Phase progress bars
4. ✅ Overall completion percentage (top)
5. ✅ Statistics table (bottom)
6. ✅ "Next Step" section (bottom)
7. ✅ Last updated timestamp

### AI Agent Responsibilities:
- **NEVER skip checklist updates** - This is critical for tracking progress
- **Update IMMEDIATELY after task completion** - Don't wait or batch updates
- **Be specific in Git commit references** - Include commit hash or message
- **Recalculate percentages accurately** - Use exact math
- **Update all related sections** - Don't just update one checkbox

### Why This Matters:
- 📊 Provides clear progress tracking
- 🎯 Shows what's done and what's next
- 📝 Creates a historical record of work
- 🚀 Motivates continued progress
- 🔍 Helps identify bottlenecks
- 📈 Enables accurate time estimates

### Integration with Other Files:
- `UI_UX_NEXT_PHASE_CHECKLIST.md` - **Master checklist** (UPDATE ALWAYS)
- `PROGRESS_TRACKING.md` - Detailed daily logs (update daily)
- `UI_UX_IMPROVEMENT_PLAN.md` - Reference guide (rarely updated)
- `DESIGN_SYSTEM_QUICK_REF.md` - Quick reference (rarely updated)

### Workflow Integration:
```
Complete Task → Test → Git Commit → ✅ UPDATE CHECKLIST → Update Progress Tracking → Move to Next Task
                                        ^^^^^^^^^^^^^^^^
                                        MANDATORY STEP!
```

---
**Last Updated**: October 19, 2025
