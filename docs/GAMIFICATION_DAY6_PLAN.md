# 🎯 Day 6: Leaderboard & Analytics Dashboard

**الهدف:** إنشاء نظام Leaderboard للمنافسة وDashboard للإحصائيات

---

## 📋 المهام الرئيسية

### Part 1: Leaderboard System
1. ✅ Leaderboard Screen - عرض أفضل المتدربين
2. ✅ Real-time ranking updates
3. ✅ Filtering options (weekly, monthly, all-time)
4. ✅ User highlighting (own position)
5. ✅ Beautiful UI with rankings

### Part 2: Analytics Dashboard (للمدرب)
1. ✅ Course analytics screen
2. ✅ Engagement metrics
3. ✅ Activity breakdown charts
4. ✅ Student progress overview
5. ✅ Export functionality

### Part 3: Achievements System
1. ✅ Achievement badges
2. ✅ Auto-unlock logic
3. ✅ Achievements screen
4. ✅ Notification on unlock
5. ✅ Progress tracking

---

## 🏗️ التفاصيل الفنية

### 1. Leaderboard Model
```dart
@freezed
class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    required String userId,
    required String userName,
    String? userAvatar,
    required int totalPoints,
    required int currentLevel,
    required String levelName,
    required int rank,
    @Default(0) int moduleCount,
    @Default(0) int quizCount,
    @Default(0) int streakCount,
    DateTime? lastActivity,
  }) = _LeaderboardEntry;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryFromJson(json);
}

enum LeaderboardTimeframe {
  weekly,
  monthly,
  allTime,
}
```

### 2. Achievement Model
```dart
@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String title,
    required String description,
    required String iconUrl,
    required AchievementCategory category,
    required AchievementCriteria criteria,
    @Default(0) int pointsReward,
    @Default(false) bool isSecret, // مخفية حتى يتم فتحها
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
}

enum AchievementCategory {
  modules,      // إكمال وحدات
  quizzes,      // اجتياز اختبارات
  social,       // التفاعل الاجتماعي
  streak,       // Daily Streak
  special,      // إنجازات خاصة
}

@freezed
class AchievementCriteria with _$AchievementCriteria {
  const factory AchievementCriteria({
    String? type,           // "modules_completed", "quizzes_passed", etc.
    int? targetValue,       // 5 modules, 10 quizzes, etc.
    String? specificId,     // معرف محدد (مثلاً: module معين)
  }) = _AchievementCriteria;

  factory AchievementCriteria.fromJson(Map<String, dynamic> json) =>
      _$AchievementCriteriaFromJson(json);
}

@freezed
class UserAchievement with _$UserAchievement {
  const factory UserAchievement({
    required String achievementId,
    required String userId,
    required String courseId,
    required DateTime unlockedAt,
    @Default(false) bool isViewed,
  }) = _UserAchievement;

  factory UserAchievement.fromJson(Map<String, dynamic> json) =>
      _$UserAchievementFromJson(json);
}
```

### 3. Analytics Model
```dart
@freezed
class CourseAnalytics with _$CourseAnalytics {
  const factory CourseAnalytics({
    required String courseId,
    required int totalStudents,
    required int activeStudents, // آخر 7 أيام
    required double avgPoints,
    required double avgLevel,
    required Map<String, int> activityBreakdown,
    required List<TopStudent> topStudents,
    required Map<String, double> engagementRate,
    DateTime? lastUpdated,
  }) = _CourseAnalytics;

  factory CourseAnalytics.fromJson(Map<String, dynamic> json) =>
      _$CourseAnalyticsFromJson(json);
}

@freezed
class TopStudent with _$TopStudent {
  const factory TopStudent({
    required String userId,
    required String userName,
    required int points,
    required int level,
  }) = _TopStudent;

  factory TopStudent.fromJson(Map<String, dynamic> json) =>
      _$TopStudentFromJson(json);
}
```

---

## 📱 UI Screens

### 1. Leaderboard Screen
**الموقع:** `lib/screens/gamification/leaderboard_screen.dart`

**الميزات:**
- Tabs للتبديل بين (أسبوعي، شهري، دائم)
- Top 3 عرض خاص مع أيقونات 🥇🥈🥉
- باقي الترتيب في ListView
- تمييز المستخدم الحالي بلون مختلف
- Refresh to reload
- Empty state جميل

**الكود:**
```dart
class LeaderboardScreen extends ConsumerStatefulWidget {
  final String courseId;

  const LeaderboardScreen({
    super.key,
    required this.courseId,
  });

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  LeaderboardTimeframe _currentTimeframe = LeaderboardTimeframe.allTime;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _currentTimeframe = LeaderboardTimeframe.values[_tabController.index];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final leaderboardAsync = ref.watch(
      leaderboardProvider((courseId: widget.courseId, timeframe: _currentTimeframe)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة المتصدرين'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'الأسبوع'),
            Tab(text: 'الشهر'),
            Tab(text: 'الكل'),
          ],
        ),
      ),
      body: leaderboardAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('خطأ: $error')),
        data: (entries) {
          if (entries.isEmpty) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(leaderboardProvider((
                courseId: widget.courseId,
                timeframe: _currentTimeframe,
              )));
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Top 3 Podium
                if (entries.length >= 3)
                  _buildPodium(entries.take(3).toList()),
                
                const SizedBox(height: 24),
                
                // Rest of the list
                ...entries.skip(3).map((entry) => _buildLeaderboardTile(entry)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPodium(List<LeaderboardEntry> top3) {
    // Beautiful podium UI with 2nd, 1st, 3rd arrangement
  }

  Widget _buildLeaderboardTile(LeaderboardEntry entry) {
    final auth = ref.read(authStateProvider).value;
    final isCurrentUser = auth?.uid == entry.userId;

    return Card(
      color: isCurrentUser ? Colors.blue.shade50 : null,
      child: ListTile(
        leading: CircleAvatar(
          child: Text('#${entry.rank}'),
        ),
        title: Text(entry.userName),
        subtitle: Text('المستوى ${entry.currentLevel} - ${entry.levelName}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${entry.totalPoints} نقطة',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (isCurrentUser)
              const Text('أنت', style: TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.leaderboard, size: 100, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'لا يوجد متدربين بعد',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
```

### 2. Analytics Dashboard Screen
**الموقع:** `lib/screens/gamification/analytics_dashboard_screen.dart`

**الميزات:**
- Overview cards (إجمالي الطلاب، المتوسطات، إلخ)
- Activity breakdown chart
- Top students widget
- Engagement rate over time
- Export to CSV

**UI Components:**
- MetricCard widget
- SimpleBarChart (optional: use fl_chart package)
- TopStudentsWidget
- ExportButton

### 3. Achievements Screen
**الموقع:** `lib/screens/gamification/achievements_screen.dart`

**الميزات:**
- Grid view للإنجازات
- Locked vs Unlocked states
- Progress indicators لكل إنجاز
- Filter by category
- Achievement details dialog

---

## 🔄 Providers

### Leaderboard Providers
```dart
// Repository
final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) {
  return LeaderboardRepository(FirebaseFirestore.instance);
});

// Leaderboard Stream
final leaderboardProvider = StreamProvider.autoDispose.family<
    List<LeaderboardEntry>,
    ({String courseId, LeaderboardTimeframe timeframe})
>((ref, params) {
  final repository = ref.watch(leaderboardRepositoryProvider);
  return repository.streamLeaderboard(
    courseId: params.courseId,
    timeframe: params.timeframe,
  );
});

// User Rank
final userRankProvider = FutureProvider.autoDispose.family<
    int?,
    ({String userId, String courseId, LeaderboardTimeframe timeframe})
>((ref, params) async {
  final repository = ref.read(leaderboardRepositoryProvider);
  return repository.getUserRank(
    userId: params.userId,
    courseId: params.courseId,
    timeframe: params.timeframe,
  );
});
```

### Achievement Providers
```dart
// Achievements Stream
final courseAchievementsProvider = StreamProvider.autoDispose.family<
    List<Achievement>,
    String
>((ref, courseId) {
  final repository = ref.watch(achievementRepositoryProvider);
  return repository.streamCourseAchievements(courseId);
});

// User Achievements
final userAchievementsProvider = StreamProvider.autoDispose.family<
    List<UserAchievement>,
    ({String userId, String courseId})
>((ref, params) {
  final repository = ref.watch(achievementRepositoryProvider);
  return repository.streamUserAchievements(
    userId: params.userId,
    courseId: params.courseId,
  );
});

// Check & Award Achievement
final checkAchievementsProvider = FutureProvider.autoDispose.family<
    void,
    ({String userId, String courseId})
>((ref, params) async {
  final service = ref.read(achievementServiceProvider);
  await service.checkAndAwardAchievements(
    userId: params.userId,
    courseId: params.courseId,
  );
});
```

### Analytics Providers
```dart
// Course Analytics
final courseAnalyticsProvider = FutureProvider.autoDispose.family<
    CourseAnalytics,
    String
>((ref, courseId) async {
  final repository = ref.read(analyticsRepositoryProvider);
  return repository.getCourseAnalytics(courseId);
});
```

---

## 🗄️ Firestore Structure

### Collections:

#### `achievements/{achievementId}`
```json
{
  "id": "ach_001",
  "title": "المبتدئ",
  "description": "أكمل وحدتك الأولى",
  "iconUrl": "assets/achievements/first_module.png",
  "category": "modules",
  "criteria": {
    "type": "modules_completed",
    "targetValue": 1
  },
  "pointsReward": 50,
  "isSecret": false
}
```

#### `user_achievements/{userId}_{achievementId}`
```json
{
  "achievementId": "ach_001",
  "userId": "user123",
  "courseId": "course456",
  "unlockedAt": "2025-10-15T10:30:00Z",
  "isViewed": true
}
```

#### Existing: `user_course_progress/{userId}_{courseId}`
سنضيف:
```json
{
  // ... الحقول الموجودة ...
  "achievementIds": ["ach_001", "ach_005"],
  "rank": 5,
  "rankLastUpdated": "2025-10-15T10:30:00Z"
}
```

---

## 🔒 Security Rules

```javascript
// Achievements (read-only للطلاب)
match /achievements/{achievementId} {
  allow read: if isSignedIn();
  allow write: if isTrainer(); // المدربون يمكنهم إضافة إنجازات مخصصة
}

// User Achievements
match /user_achievements/{docId} {
  allow read: if isSignedIn() && (
    docId.matches('^' + request.auth.uid + '_.*') || // own achievements
    isTrainer() // trainers can see all
  );
  allow write: if false; // Only via service (server-side logic)
}
```

---

## 📊 Firestore Indexes

```json
{
  "indexes": [
    {
      "collectionGroup": "user_course_progress",
      "fields": [
        { "fieldPath": "courseId", "order": "ASCENDING" },
        { "fieldPath": "totalPoints", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "user_course_progress",
      "fields": [
        { "fieldPath": "courseId", "order": "ASCENDING" },
        { "fieldPath": "lastActivityDate", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "user_achievements",
      "fields": [
        { "fieldPath": "userId", "order": "ASCENDING" },
        { "fieldPath": "courseId", "order": "ASCENDING" },
        { "fieldPath": "unlockedAt", "order": "DESCENDING" }
      ]
    }
  ]
}
```

---

## ✅ Checklist

### Models & Freezed:
- [ ] LeaderboardEntry model
- [ ] Achievement model
- [ ] AchievementCriteria model
- [ ] UserAchievement model
- [ ] CourseAnalytics model
- [ ] Run build_runner

### Repositories:
- [ ] LeaderboardRepository
  - [ ] streamLeaderboard()
  - [ ] getUserRank()
  - [ ] updateRankings() (scheduled job)
- [ ] AchievementRepository
  - [ ] streamCourseAchievements()
  - [ ] streamUserAchievements()
  - [ ] unlockAchievement()
- [ ] AnalyticsRepository
  - [ ] getCourseAnalytics()
  - [ ] getActivityBreakdown()

### Services:
- [ ] AchievementService
  - [ ] checkAndAwardAchievements()
  - [ ] evaluateCriteria()
  - [ ] notifyUnlock()

### Providers:
- [ ] Leaderboard providers (3)
- [ ] Achievement providers (3)
- [ ] Analytics providers (1)

### UI:
- [ ] LeaderboardScreen
- [ ] AnalyticsDashboardScreen (for trainers)
- [ ] AchievementsScreen
- [ ] Widgets:
  - [ ] PodiumWidget
  - [ ] LeaderboardTile
  - [ ] AchievementCard
  - [ ] MetricCard
  - [ ] ProgressChart

### Integration:
- [ ] Add Leaderboard menu item in course
- [ ] Add Analytics menu item (trainers only)
- [ ] Add Achievements menu item
- [ ] Check achievements after each activity

### Security & Performance:
- [ ] Firestore rules
- [ ] Firestore indexes
- [ ] Test security rules
- [ ] Optimize queries

### Testing:
- [ ] Unit tests for services
- [ ] Widget tests for screens
- [ ] Integration tests
- [ ] Manual testing

### Documentation:
- [ ] GAMIFICATION_DAY6_COMPLETE.md
- [ ] Update GAMIFICATION_OVERALL_SUMMARY.md

---

## 🎯 Success Criteria

- ✅ Leaderboard working with real-time updates
- ✅ Rankings accurate and fast
- ✅ Achievements auto-unlock correctly
- ✅ Analytics dashboard shows useful metrics
- ✅ Beautiful UI consistent with app design
- ✅ No performance issues
- ✅ Security rules tested and working

---

## 🚀 Estimated Time

- **Part 1 (Leaderboard):** 3-4 hours
- **Part 2 (Analytics):** 2-3 hours
- **Part 3 (Achievements):** 3-4 hours
- **Testing & Polish:** 1-2 hours
- **Total:** ~8-12 hours (full day of work)

---

## 📝 Notes

- استخدم `fl_chart` package للرسوم البيانية (optional)
- Leaderboard ranking يمكن حسابه on-the-fly أو caching
- Achievements check بعد كل نشاط مهم
- Analytics يمكن caching لتحسين الأداء

---

**جاهز للبدء؟** 💪
