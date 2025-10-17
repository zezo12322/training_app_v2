# Training App v2 🎓

A comprehensive Flutter-based training management application with advanced features including course management, interactive course walls, polls, push notifications, and gamification.

---

## 📚 UI/UX Improvement Documentation

**NEW**: Comprehensive UI/UX enhancement project in progress! 🎨

### 📄 Essential Files
- **[UI_UX_IMPROVEMENT_PLAN.md](./UI_UX_IMPROVEMENT_PLAN.md)** - Complete roadmap with 8 phases, code examples, and checklists
- **[PROGRESS_TRACKING.md](./PROGRESS_TRACKING.md)** - Daily progress tracking, statistics, and lessons learned
- **[DESIGN_SYSTEM_QUICK_REF.md](./DESIGN_SYSTEM_QUICK_REF.md)** - Quick reference for Design Tokens (colors, typography, spacing)

**Current Status**: 
- ✅ Phase 1: Design System (100% complete)
- ✅ Phase 2: Authentication Screens (100% complete)
- ⏳ Phase 3: Main Screens (Next)

**Progress**: 15% overall (2/8 phases complete)

---

## ✨ Features

### 🏫 Core Features
- **User Management**: Role-based access (Trainee, Trainer, Manager, Super Admin)
- **Course Management**: Create, join, and manage training courses
- **Department & Team System**: Organizational structure support
- **Teaching Assignments**: Assign trainers to courses
- **Resource Library**: Upload and share course materials
- **Quiz System**: Create and take quizzes with auto-grading
- **Evaluation System**: Rate trainers and provide feedback

### 💬 Course Wall (Advanced)
- **Rich Posts**: Text, images (single/multiple), and polls
- **Interactive Polls**: Single/multiple vote modes with real-time results
- **Reactions**: Emoji reactions on posts
- **Comments**: Threaded discussions with reactions
- **Pinned Posts**: Important announcements stay at top
- **Search & Filter**: 
  - Text search (content, authors, emails)
  - Filter by post type (text/images/polls)
  - Filter by author
  - Date range filtering
  - Sort by newest/oldest/comments/reactions
- **Pagination**: Infinite scroll support

### 🔔 Push Notifications
- Real-time notifications via OneSignal
- Notifications for new posts in enrolled courses
- Backend-based notification delivery
- Multi-user targeting support

### 🎮 Gamification System
- **Points**: Earn points for completing lessons, quizzes, and maintaining streaks
- **Badges**: Achievement system with multiple tiers
- **Levels**: Dynamic leveling based on total points
- **Daily Streaks**: Encourage daily engagement
- **Leaderboard**: Compete with other learners
- **Timeline**: Track your badge achievements

### 🔒 Security
- Firebase Authentication integration
- Role-based access control
- Firestore security rules
- Data validation and sanitization

### 🌐 Advanced Features

#### 🔑 SSO Integration
- **Google Sign-In**: OAuth 2.0 authentication
- **Apple Sign-In**: Sign in with Apple support
- Email authentication as fallback
- Auto-provisioning of user profiles

#### 📊 HRIS Import (HR Information System)
- **Bulk User Import**: CSV & Excel file support
- **Flexible Mapping**: Custom column mapping wizard
- **Validation**: Email format, required fields, duplicate detection
- **Progress Tracking**: Real-time import progress
- **Error Handling**: Detailed error reports per user
- **Templates**: Save and reuse mapping configurations
- **History**: View all import jobs with status and statistics

#### 📈 BigQuery Export
- **Data Export**: Users, courses, analytics data
- **Scheduling**: Manual, daily, weekly, monthly exports
- **Job Tracking**: Monitor export status and progress
- **Configuration**: Project ID, dataset ID, credentials
- **History**: View all export jobs with row counts
- Note: BigQuery API integration ready (requires google_cloud package)

#### 🤖 ML Anomaly Detection
- **Statistical Analysis**: Z-score based detection algorithms
- **6 Detection Types**:
  * Unusual quiz scores (cheating detection)
  * Suspicious login patterns
  * Rapid progress (unrealistic speed)
  * Multiple failed attempts
  * Unusual access patterns
  * Data inconsistency
- **Real-time Monitoring**: Live anomaly dashboard
- **Severity Levels**: Critical, High, Medium, Low
- **Status Workflow**: Pending → Investigating → Resolved/False Positive
- **Configurable Thresholds**: Adjust sensitivity per detection type
- **Auto-actions**: Optional auto-notify and auto-block

## 🚀 Getting Started

### Core Concepts
| Concept | Description |
|---------|-------------|
| Points | Awarded for defined events (lesson completed, quiz passed, daily streak check). |
| Badges | Milestones across multiple dimensions: total points, daily streak length, authored reviews. |
| Levels | Derived from total points using formula: `level = floor(sqrt(points / 50)) + 1`. |
| Streak | Daily activity chain (stored as `dailyStreak` + `lastActiveDay`). |
| Leaderboard | Top users by points (ranked). |
| Timeline | Historical list of awarded badges with timestamps. |

### Firestore Data Model (simplified)
```
user_points/{userId} {
	points: number,
	badges: [badgeId,...],
	dailyStreak: number,
	lastActiveDay: Timestamp
}
user_points/{userId}/badge_awards/{badgeId} {
	awardedAt: Timestamp
}
badges/{badgeId} {
	name, description, iconUrl
}
user_reviews/{autoId} {
	reviewerId, targetId, rating, comment, date
}
```

### Badge Families Implemented
- Points: `points_100`, `points_500`, `points_1000`
- Daily Streak: `streak_3`, `streak_7`, `streak_14`, `streak_30`
- Reviews Authored: `first_review`, `reviews_10`, `reviews_25`, `reviews_50`

Extensible (future): lesson count, quiz count, advanced streaks, social milestones.

### Providers Overview (Riverpod)
| Provider | Type | Purpose |
|----------|------|---------|
| `pointsRepositoryProvider` | `Provider` | Data access for points & badge mutation. |
| `userPointsStreamProvider(userId)` | `StreamProvider` | Live user gamification snapshot. |
| `currentUserLevelProvider` | `Provider<int?>` | Derived level. |
| `nextBadgeProgressProvider` | `Provider<Record>` | Remaining points to next threshold. |
| `nextBadgeProgressPercentProvider` | `Provider<double?>` | Normalized progress 0..1. |
| `earnedLockedBadgesProvider(userId)` | `FutureProvider<(earned,locked)>` | Partition badges. |
| `leaderboardEntriesProvider(limit)` | `FutureProvider<List<LeaderboardEntry>>` | Ranked list. |
| `badgeAwardEventsProvider(userId)` | `StateNotifierProvider` | Emits newly earned badge IDs (debounced). |
| `badgeAwardsHistoryProvider(userId)` | `StreamProvider<List<{badgeId,awardedAt}>>` | Timeline history. |
| `badgeIdToBadgeProvider` | `FutureProvider<Map>` | Map for quick id→Badge lookup. |
| `updateDailyStreakProvider` | `FutureProvider<void>` | Forces streak recalculation. |
| `currentUserDailyStreakProvider` | `Provider<int?>` | Current streak value. |

### Award Evaluation Flow
1. User triggers an action (e.g., lesson complete) → `grantPointsForEventProvider(PointEventType.lessonCompleted)`.
2. Points increment (transactional merge) + optional streak update.
3. `BadgeEvaluationService.evaluateAndAward(userId)` runs:
	 - Checks point thresholds.
	 - Checks streak thresholds.
	 - Counts authored reviews for review badges.
	 - Grants badges idempotently (transaction ensures no duplicates).
4. Firestore stream updates → `badgeAwardNotifier` diffs previous vs current badge set → enqueues new IDs.
5. `BadgeAwardListener` (UI) batches notifications (debounced) & consumes queue.

### UI Components
- `PointsLevelCard` – points, level, progress bar, streak line.
- `EarnedBadgesGrid` / `LockedBadgesGrid` – badge partition display.
- `BadgesOverview` – tabbed combined view.
- `BadgeTimeline` – chronological awarded badges.
- `BadgeAwardListener` – global snackbar feedback (supports batch message via localization key `badgesEarnedBatch`).

### Testing Strategy
| Test | Focus |
|------|-------|
| `compute_level_test.dart` | Level math correctness. |
| `badge_evaluation_service_test.dart` | Awarding point threshold badges. |
| `streak_badge_evaluation_test.dart` | Streak badge logic. |
| `review_badges_test.dart` | Review-authored badge logic. |
| `points_repository_badge_award_test.dart` | Idempotent badge transaction + timestamp. |
| `badge_award_notifier_test.dart` | Detection of new badge IDs. |
| `badge_award_notifier_consume_all_test.dart` | Batch consume behavior. |
| `badge_awards_history_provider_test.dart` | Ordering of award history. |
| `earned_locked_badges_provider_test.dart` | Partition correctness. |

### Extending Badges
Add entries to service maps or externalize thresholds:
```dart
// Example: add 25 & 50 review badges
static const _reviewBadges = <int,String>{
	1: 'first_review',
	10: 'reviews_10',
	25: 'reviews_25',
	50: 'reviews_50',
};
```
Then seed `badges` collection documents accordingly.

### Future Ideas
- Remote-configurable thresholds
- Seasonal / limited-time badges
- XP decay for inactivity
- Challenge quests & multi-step achievements
- Push notifications on significant milestones

### Weekly Challenges (NEW)
Server-managed recurring goals to drive short-term focus.

Data Model:
```
weekly_challenges/{id} {
	title, description, targetType: 'points'|'quizzesPassed'|'tasksCompleted'|'attempts',
	targetValue: number,
	activeRange: { start: ISO8601, end: ISO8601 },
	active: boolean,
	createdAt, updatedAt
}
user_challenge_progress/{userId_challengeId} {
	userId, challengeId, progress, target, completed, completedAt?, lastEval
}
```

Backend:
- Scheduled CF `evaluateWeeklyChallenges` computes progress once per day (MVP cadence).
- Callable `createWeeklyChallenge` (super_admin only) seeds a challenge.
- Callable `forceEvaluateChallenges` allows manual re-run.

Rules:
- `weekly_challenges`: read all signed-in, writes super_admin only.
- `user_challenge_progress`: read own (or super_admin), server-only writes.

Next Iterations:
- Capture per-user baseline at challenge activation for delta-based progress.
- Real-time incremental updates via point/attempt triggers.
- Challenge tiers & cohort / tenant scoped challenges.

### Minimal Badge Document Seed
```
// badges/points_100
{ "name": "100 Points", "description": "Reach 100 total points", "iconUrl": "" }
```

---

---

##  Installation & Setup

### Prerequisites
- Flutter SDK (3.x or higher)
- Dart SDK (3.x or higher)  
- Firebase CLI
- Node.js (for Cloud Functions)
- OneSignal account

### Quick Start

1. **Clone & Install**
```bash
git clone https://github.com/zezo12322/training_app_v2.git
cd training_app_v2
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

2. **Firebase Configuration**
   - Create Firebase project
   - Enable Authentication, Firestore, Storage
   - Add google-services.json & GoogleService-Info.plist
   - Deploy indexes: `firebase deploy --only firestore:indexes`
   - Deploy functions: `firebase deploy --only functions`

3. **Run**
```bash
flutter run
```

---

##  Testing

```bash
flutter test                                    # Run all tests
flutter test test/wall_filter_providers_test.dart  # Specific test
flutter analyze                                 # Code analysis
```

**Status**:  16/16 tests passing, 0 errors, 0 warnings

---

##  Performance

- **Image Compression**: 70% size reduction
- **Pagination**: 20 posts per page
- **Firestore Indexes**: 4 composite indexes for fast queries
- **State Management**: Efficient Riverpod caching

---

##  Documentation

- [Development Summary](DEVELOPMENT_SUMMARY.md) - Detailed feature documentation
- [Security Migration](docs/SECURITY_MIGRATION.md) - Security updates guide
- [HRIS Import Guide](docs/HRIS_IMPORT.md) - Bulk user import documentation
- [BigQuery Export Guide](docs/BIGQUERY_EXPORT.md) - Data export setup and usage
- [Anomaly Detection Guide](docs/ANOMALY_DETECTION.md) - ML-based anomaly detection system

---

**Version**: 2.0  
**Last Updated**: January 2025  
**Status**: Production Ready 
