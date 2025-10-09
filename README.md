# training_app_v2

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

---

## Gamification & Engagement Layer

This project includes an incremental gamification system designed to drive retention and habit formation.

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
