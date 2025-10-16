# نظام التقدم والـ Gamification داخل الكورس

## 📋 نظرة عامة

نظام متكامل لتتبع تقدم المتدربين وتحفيزهم من خلال:
- **النقاط (Points)**: يكسبها المتدرب من الأنشطة المختلفة
- **المستويات (Levels)**: يتقدم فيها بناءً على النقاط
- **الشارات (Badges)**: إنجازات خاصة
- **المسارات (Learning Paths)**: خطة تعليمية متدرجة

---

## 🎯 هيكل البيانات المقترح

### 1. Course Model - إضافة حقول جديدة

```dart
class Course {
  // ... الحقول الموجودة
  
  // Gamification Settings (يحددها المدرب/منشئ المسار)
  final GamificationSettings? gamificationSettings;
  
  // Learning Path (المسار التعليمي)
  final List<LearningModule>? learningPath;
}

class GamificationSettings {
  // نقاط المستويات
  final Map<int, int> levelThresholds; // مثال: {1: 100, 2: 250, 3: 500}
  
  // النقاط من كل نشاط
  final ActivityPoints activityPoints;
  
  // الشارات المتاحة في هذا الكورس
  final List<String> availableBadges;
  
  // هل النظام مفعّل؟
  final bool isEnabled;
  
  GamificationSettings({
    required this.levelThresholds,
    required this.activityPoints,
    required this.availableBadges,
    this.isEnabled = true,
  });
}

class ActivityPoints {
  // ⭐ الأساسيات (Core) - إلزامية
  final int completingLesson;      // إتمام درس
  final int passingQuiz;           // اجتياز اختبار
  final int perfectQuizScore;      // درجة كاملة في اختبار
  final int completingAssignment;  // إتمام مهمة/تكليف
  final int completingModule;      // إتمام وحدة كاملة
  
  // 🎮 التفاعل الاجتماعي (Social) - اختياري
  final int creatingPost;          // إنشاء منشور
  final int commentingOnPost;      // التعليق على منشور
  final int helpingPeer;           // مساعدة زميل (رد مفيد)
  final int receivingReaction;     // الحصول على reaction
  
  // 🔥 Daily Streak - اختياري
  final int dailyStreak;           // الدخول اليومي المتواصل
  final int weeklyStreak;          // أسبوع متواصل (bonus)
  
  // ⚙️ الإعدادات
  final bool enableSocialPoints;   // تفعيل نقاط التفاعل الاجتماعي
  final bool enableDailyStreak;    // تفعيل نقاط الدخول اليومي
  
  ActivityPoints({
    // القيم الافتراضية للأساسيات
    this.completingLesson = 10,
    this.passingQuiz = 20,
    this.perfectQuizScore = 50,
    this.completingAssignment = 30,
    this.completingModule = 100,
    
    // القيم الافتراضية للتفاعل (يمكن تعطيلها)
    this.creatingPost = 5,
    this.commentingOnPost = 2,
    this.helpingPeer = 15,
    this.receivingReaction = 1,
    
    // القيم الافتراضية للـ Streak (يمكن تعطيله)
    this.dailyStreak = 5,
    this.weeklyStreak = 50,
    
    // الإعدادات الافتراضية
    this.enableSocialPoints = false,  // معطل افتراضياً
    this.enableDailyStreak = false,   // معطل افتراضياً
  });
  
  // للـ JSON Serialization
  Map<String, dynamic> toJson() => {
    'completingLesson': completingLesson,
    'passingQuiz': passingQuiz,
    'perfectQuizScore': perfectQuizScore,
    'completingAssignment': completingAssignment,
    'completingModule': completingModule,
    'creatingPost': creatingPost,
    'commentingOnPost': commentingOnPost,
    'helpingPeer': helpingPeer,
    'receivingReaction': receivingReaction,
    'dailyStreak': dailyStreak,
    'weeklyStreak': weeklyStreak,
    'enableSocialPoints': enableSocialPoints,
    'enableDailyStreak': enableDailyStreak,
  };
  
  factory ActivityPoints.fromJson(Map<String, dynamic> json) => ActivityPoints(
    completingLesson: json['completingLesson'] ?? 10,
    passingQuiz: json['passingQuiz'] ?? 20,
    perfectQuizScore: json['perfectQuizScore'] ?? 50,
    completingAssignment: json['completingAssignment'] ?? 30,
    completingModule: json['completingModule'] ?? 100,
    creatingPost: json['creatingPost'] ?? 5,
    commentingOnPost: json['commentingOnPost'] ?? 2,
    helpingPeer: json['helpingPeer'] ?? 15,
    receivingReaction: json['receivingReaction'] ?? 1,
    dailyStreak: json['dailyStreak'] ?? 5,
    weeklyStreak: json['weeklyStreak'] ?? 50,
    enableSocialPoints: json['enableSocialPoints'] ?? false,
    enableDailyStreak: json['enableDailyStreak'] ?? false,
  );
}
```

### 2. Learning Module (وحدة تعليمية)

```dart
class LearningModule {
  final String id;
  final String title;
  final String description;
  final int order;
  
  // محتوى الوحدة
  final List<ModuleContent> content;
  
  // متطلبات إتمام الوحدة
  final ModuleRequirements requirements;
  
  // النقاط المكتسبة عند الإتمام
  final int completionPoints;
  
  // هل الوحدة مقفلة حتى إتمام السابقة؟
  final bool isLocked;
  
  // الوحدة السابقة المطلوبة
  final String? prerequisiteModuleId;
}

class ModuleContent {
  final String id;
  final ModuleContentType type; // lesson, quiz, assignment, reading
  final String title;
  final String? resourceUrl;
  final int estimatedMinutes;
  final int pointsValue;
  
  // للاختبارات
  final int? passingScore;
  final int? totalQuestions;
}

enum ModuleContentType {
  lesson,
  quiz,
  assignment,
  reading,
  video,
  practice,
}

class ModuleRequirements {
  // نسبة الإتمام المطلوبة (مثلاً 80%)
  final int minimumCompletionPercentage;
  
  // الحد الأدنى لدرجة الاختبارات
  final int? minimumQuizScore;
  
  // هل يجب إتمام كل المحتوى؟
  final bool requireAllContent;
}
```

### 3. User Course Progress

```dart
class UserCourseProgress {
  final String userId;
  final String courseId;
  
  // التقدم العام
  final int totalPoints;
  final int currentLevel;
  final int pointsToNextLevel;
  
  // التقدم في المسار
  final Map<String, ModuleProgress> moduleProgress;
  
  // الشارات المكتسبة
  final List<String> earnedBadges;
  
  // الإحصائيات
  final ProgressStats stats;
  
  // آخر تحديث
  final DateTime lastActivityAt;
  final int dailyStreakCount;
}

class ModuleProgress {
  final String moduleId;
  final bool isCompleted;
  final double completionPercentage;
  final Map<String, ContentProgress> contentProgress;
  final DateTime? completedAt;
}

class ContentProgress {
  final String contentId;
  final bool isCompleted;
  final int? score; // للاختبارات
  final int attempts;
  final DateTime? completedAt;
}

class ProgressStats {
  final int totalLessonsCompleted;
  final int totalQuizzesPassed;
  final int totalPosts;
  final int totalComments;
  final int helpfulCommentsCount;
  final double averageQuizScore;
  final int longestStreak;
}
```

---

## 🎮 كيفية كسب النقاط

### 1. إتمام المحتوى التعليمي
```dart
Future<void> markContentAsCompleted(
  String userId,
  String courseId,
  String moduleId,
  String contentId,
) async {
  final content = await getModuleContent(moduleId, contentId);
  final points = content.pointsValue;
  
  await _updateProgress(
    userId: userId,
    courseId: courseId,
    points: points,
    activity: 'completed_${content.type}',
  );
  
  // تحقق من إتمام الوحدة الكاملة
  await _checkModuleCompletion(userId, courseId, moduleId);
}
```

### 2. الاختبارات
```dart
Future<void> submitQuizResult(
  String userId,
  String courseId,
  String quizId,
  int score,
  int totalQuestions,
) async {
  final settings = await getCourseGamificationSettings(courseId);
  final passingScore = (totalQuestions * 0.7).ceil(); // 70%
  
  int points = 0;
  if (score >= passingScore) {
    points = settings.activityPoints.passingQuiz;
    
    // نقاط إضافية للدرجة الكاملة
    if (score == totalQuestions) {
      points = settings.activityPoints.perfectQuizScore;
    }
    
    await _updateProgress(
      userId: userId,
      courseId: courseId,
      points: points,
      activity: 'quiz_passed',
    );
  }
}
```

### 3. التفاعل الاجتماعي
```dart
Future<void> awardSocialPoints(
  String userId,
  String courseId,
  SocialActivity activity,
) async {
  final settings = await getCourseGamificationSettings(courseId);
  
  int points = 0;
  switch (activity) {
    case SocialActivity.createPost:
      points = settings.activityPoints.creatingPost;
      break;
    case SocialActivity.comment:
      points = settings.activityPoints.commentingOnPost;
      break;
    case SocialActivity.helpfulComment:
      // يتم تحديده من reactions/upvotes
      points = settings.activityPoints.helpingPeer;
      break;
  }
  
  await _updateProgress(
    userId: userId,
    courseId: courseId,
    points: points,
    activity: activity.name,
  );
}
```

### 4. Daily Streak
```dart
Future<void> checkDailyStreak(String userId, String courseId) async {
  final progress = await getUserProgress(userId, courseId);
  final now = DateTime.now();
  final lastActivity = progress.lastActivityAt;
  
  // تحقق من الفرق بالأيام
  final daysDiff = now.difference(lastActivity).inDays;
  
  if (daysDiff == 1) {
    // استمرار السلسلة
    final newStreak = progress.dailyStreakCount + 1;
    final settings = await getCourseGamificationSettings(courseId);
    
    await _updateProgress(
      userId: userId,
      courseId: courseId,
      points: settings.activityPoints.dailyStreak,
      activity: 'daily_streak',
      streak: newStreak,
    );
  } else if (daysDiff > 1) {
    // انقطعت السلسلة
    await _resetStreak(userId, courseId);
  }
}
```

---

## 🏆 نظام المستويات

```dart
class LevelSystem {
  // حساب المستوى من النقاط
  static int calculateLevel(int points, Map<int, int> thresholds) {
    int level = 1;
    
    for (final entry in thresholds.entries) {
      if (points >= entry.value) {
        level = entry.key;
      } else {
        break;
      }
    }
    
    return level;
  }
  
  // حساب النقاط المطلوبة للمستوى التالي
  static int pointsToNextLevel(int currentPoints, Map<int, int> thresholds) {
    final sortedLevels = thresholds.keys.toList()..sort();
    
    for (final level in sortedLevels) {
      if (currentPoints < thresholds[level]!) {
        return thresholds[level]! - currentPoints;
      }
    }
    
    return 0; // وصل للمستوى الأقصى
  }
  
  // التحقق من الترقية
  static Future<void> checkLevelUp(
    String userId,
    String courseId,
    int newPoints,
  ) async {
    final settings = await getCourseGamificationSettings(courseId);
    final oldLevel = await getUserLevel(userId, courseId);
    final newLevel = calculateLevel(newPoints, settings.levelThresholds);
    
    if (newLevel > oldLevel) {
      // ترقية!
      await _awardLevelUpBadge(userId, courseId, newLevel);
      await _sendLevelUpNotification(userId, courseId, newLevel);
    }
  }
}
```

---

## 🎨 واجهة المستخدم المقترحة

### 1. Progress Card في أعلى الكورس

```dart
class CourseProgressCard extends StatelessWidget {
  final UserCourseProgress progress;
  final GamificationSettings settings;
  
  @override
  Widget build(BuildContext context) {
    final percentage = (progress.totalPoints / 
        settings.levelThresholds[progress.currentLevel + 1]!) * 100;
    
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text('${progress.currentLevel}'),
                  backgroundColor: _getLevelColor(progress.currentLevel),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'المستوى ${progress.currentLevel}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${progress.totalPoints} نقطة',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                if (progress.dailyStreakCount > 0)
                  Row(
                    children: [
                      Icon(Icons.local_fire_department, color: Colors.orange),
                      Text('${progress.dailyStreakCount}'),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 12),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[200],
            ),
            SizedBox(height: 8),
            Text(
              'متبقي ${progress.pointsToNextLevel} نقطة للمستوى التالي',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 2. Learning Path View

```dart
class LearningPathView extends StatelessWidget {
  final List<LearningModule> modules;
  final Map<String, ModuleProgress> userProgress;
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: modules.length,
      itemBuilder: (context, index) {
        final module = modules[index];
        final progress = userProgress[module.id];
        final isLocked = _isModuleLocked(module, userProgress);
        
        return ModuleTile(
          module: module,
          progress: progress,
          isLocked: isLocked,
          onTap: isLocked ? null : () => _openModule(context, module),
        );
      },
    );
  }
  
  bool _isModuleLocked(
    LearningModule module,
    Map<String, ModuleProgress> userProgress,
  ) {
    if (!module.isLocked) return false;
    if (module.prerequisiteModuleId == null) return false;
    
    final prereqProgress = userProgress[module.prerequisiteModuleId];
    return prereqProgress?.isCompleted != true;
  }
}

class ModuleTile extends StatelessWidget {
  final LearningModule module;
  final ModuleProgress? progress;
  final bool isLocked;
  final VoidCallback? onTap;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isLocked 
              ? Colors.grey 
              : (progress?.isCompleted ?? false)
                  ? Colors.green
                  : Colors.blue,
          child: Icon(
            isLocked 
                ? Icons.lock 
                : (progress?.isCompleted ?? false)
                    ? Icons.check
                    : Icons.play_arrow,
          ),
        ),
        title: Text(
          module.title,
          style: TextStyle(
            color: isLocked ? Colors.grey : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(module.description),
            if (progress != null && !progress!.isCompleted)
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: LinearProgressIndicator(
                  value: progress!.completionPercentage / 100,
                ),
              ),
            Text(
              '${module.content.length} عنصر • ${module.completionPoints} نقطة',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: isLocked 
            ? null 
            : Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
```

### 3. Points History / Activity Feed

```dart
class PointsHistoryScreen extends StatelessWidget {
  final String userId;
  final String courseId;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('سجل النقاط')),
      body: StreamBuilder<List<PointsTransaction>>(
        stream: getPointsHistory(userId, courseId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          
          final transactions = snapshot.data!;
          
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green[100],
                  child: Text(
                    '+${transaction.points}',
                    style: TextStyle(
                      color: Colors.green[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(transaction.activityName),
                subtitle: Text(
                  _formatDate(transaction.timestamp),
                  style: TextStyle(fontSize: 12),
                ),
                trailing: _getActivityIcon(transaction.activityType),
              );
            },
          );
        },
      ),
    );
  }
}
```

---

## 🔧 التكامل مع الكود الحالي

### 1. إضافة نقاط عند إنشاء منشور

في `wall_post_repository.dart`:

```dart
Future<Result<String>> createPost({...}) async {
  // ... الكود الحالي
  
  // منح نقاط للمستخدم
  await _gamificationService.awardPoints(
    userId: authorId,
    courseId: courseId,
    activity: GamificationActivity.createPost,
  );
  
  return Success(docRef.id);
}
```

### 2. إضافة نقاط عند التعليق

في `wall_comment_repository.dart`:

```dart
Future<void> addComment({...}) async {
  // ... الكود الحالي
  
  // منح نقاط للمعلق
  await _gamificationService.awardPoints(
    userId: authorId,
    courseId: courseId,
    activity: GamificationActivity.comment,
  );
}
```

### 3. التحقق من Daily Streak

في `main.dart` أو `app.dart`:

```dart
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // عند فتح التطبيق
    ref.listen(authStateProvider, (previous, next) {
      if (next.value != null) {
        // تحقق من daily streak لكل الكورسات
        _gamificationService.checkDailyStreakForAllCourses(
          next.value!.uid,
        );
      }
    });
    
    // ... باقي الكود
  }
}
```

---

## 📊 Firestore Structure

```
courses/{courseId}
  - gamificationSettings: {
      levelThresholds: {1: 100, 2: 250, 3: 500, ...}
      activityPoints: {...}
      availableBadges: [...]
      isEnabled: true
    }
  - learningPath: [
      {
        id, title, description,
        content: [...],
        requirements: {...}
      }
    ]

user_course_progress/{userId}_{courseId}
  - userId
  - courseId
  - totalPoints
  - currentLevel
  - pointsToNextLevel
  - moduleProgress: {
      moduleId: {
        isCompleted,
        completionPercentage,
        contentProgress: {...}
      }
    }
  - earnedBadges: [...]
  - stats: {...}
  - lastActivityAt
  - dailyStreakCount

points_transactions/{transactionId}
  - userId
  - courseId
  - points
  - activityType
  - activityName
  - timestamp
  - metadata: {...}
```

---

## 🎯 خطوات التنفيذ المقترحة

### المرحلة 1: البنية التحتية
1. ✅ إنشاء Models للـ Gamification
2. ✅ إنشاء GamificationService
3. ✅ إضافة حقول في Course Model
4. ✅ Migration للبيانات الحالية

### المرحلة 2: نظام النقاط
1. ✅ تكامل مع Wall Posts/Comments
2. ✅ Points Transaction History
3. ✅ Daily Streak System
4. ✅ Level Calculation

### المرحلة 3: Learning Path
1. ✅ Learning Module UI
2. ✅ Content Progress Tracking
3. ✅ Module Locking System
4. ✅ Completion Requirements

### المرحلة 4: واجهة المستخدم
1. ✅ Progress Card
2. ✅ Learning Path View
3. ✅ Points History
4. ✅ Achievements Screen

### المرحلة 5: لوحة التحكم للمدرب
1. ✅ Gamification Settings Editor
2. ✅ Learning Path Builder
3. ✅ Progress Analytics
4. ✅ Custom Badge Creator

---

## 💡 أفكار إضافية

### 1. Leaderboard (لوحة المتصدرين)
```dart
class CourseLeaderboard extends StatelessWidget {
  final String courseId;
  
  // عرض أفضل 10 متدربين
  // مع خيار إخفاء الأسماء والعرض بـ Anonymous
}
```

### 2. Peer Recognition (تقدير الأقران)
```dart
// السماح للمتدربين بمنح نقاط لبعضهم
// عند تقديم مساعدة مفيدة
Future<void> awardPeerRecognition(
  String fromUserId,
  String toUserId,
  String commentId,
) {
  // +15 points للشخص المساعد
  // شارة "Helpful" بعد 10 recognitions
}
```

### 3. Challenges (التحديات)
```dart
class CourseChallenge {
  final String title; // "أكمل 5 دروس هذا الأسبوع"
  final DateTime startDate;
  final DateTime endDate;
  final int bonusPoints; // 50 نقطة إضافية
  final ChallengeRequirement requirement;
}
```

### 4. Team Competition (المنافسة الجماعية)
```dart
// تقسيم المتدربين لفرق
// كل فريق يحصل على نقاط جماعية
class CourseTeam {
  final String name;
  final List<String> memberIds;
  final int totalPoints;
}
```

---

## 🎛️ لوحة تحكم المدرب - إعدادات النقاط

```dart
class GamificationSettingsScreen extends StatefulWidget {
  final String courseId;
  
  @override
  State<GamificationSettingsScreen> createState() => 
      _GamificationSettingsScreenState();
}

class _GamificationSettingsScreenState extends State<GamificationSettingsScreen> {
  late ActivityPoints _activityPoints;
  late Map<int, int> _levelThresholds;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إعدادات نظام النقاط'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // القسم الأول: الأساسيات (Core Activities)
            _buildSectionHeader(
              title: 'الأنشطة الأساسية',
              subtitle: 'المهام والاختبارات - الأساس لتقدم المتدرب',
              icon: Icons.school,
              color: Colors.blue,
            ),
            _buildPointSlider(
              label: 'إتمام درس',
              value: _activityPoints.completingLesson,
              min: 5,
              max: 50,
              onChanged: (val) => setState(() {
                _activityPoints = _activityPoints.copyWith(
                  completingLesson: val.round(),
                );
              }),
            ),
            _buildPointSlider(
              label: 'اجتياز اختبار',
              value: _activityPoints.passingQuiz,
              min: 10,
              max: 100,
              onChanged: (val) => setState(() {
                _activityPoints = _activityPoints.copyWith(
                  passingQuiz: val.round(),
                );
              }),
            ),
            _buildPointSlider(
              label: 'درجة كاملة في اختبار',
              value: _activityPoints.perfectQuizScore,
              min: 20,
              max: 200,
              onChanged: (val) => setState(() {
                _activityPoints = _activityPoints.copyWith(
                  perfectQuizScore: val.round(),
                );
              }),
            ),
            _buildPointSlider(
              label: 'إتمام مهمة/تكليف',
              value: _activityPoints.completingAssignment,
              min: 10,
              max: 150,
              onChanged: (val) => setState(() {
                _activityPoints = _activityPoints.copyWith(
                  completingAssignment: val.round(),
                );
              }),
            ),
            _buildPointSlider(
              label: 'إتمام وحدة كاملة',
              value: _activityPoints.completingModule,
              min: 50,
              max: 500,
              onChanged: (val) => setState(() {
                _activityPoints = _activityPoints.copyWith(
                  completingModule: val.round(),
                );
              }),
            ),
            
            SizedBox(height: 32),
            Divider(),
            
            // القسم الثاني: التفاعل الاجتماعي (Optional)
            _buildSectionHeader(
              title: 'التفاعل الاجتماعي',
              subtitle: 'اختياري - لتشجيع التواصل بين المتدربين',
              icon: Icons.people,
              color: Colors.purple,
            ),
            SwitchListTile(
              title: Text('تفعيل نقاط التفاعل الاجتماعي'),
              subtitle: Text('منح نقاط للمنشورات والتعليقات'),
              value: _activityPoints.enableSocialPoints,
              onChanged: (val) => setState(() {
                _activityPoints = _activityPoints.copyWith(
                  enableSocialPoints: val,
                );
              }),
            ),
            
            if (_activityPoints.enableSocialPoints) ...[
              _buildPointSlider(
                label: 'إنشاء منشور',
                value: _activityPoints.creatingPost,
                min: 1,
                max: 20,
                onChanged: (val) => setState(() {
                  _activityPoints = _activityPoints.copyWith(
                    creatingPost: val.round(),
                  );
                }),
              ),
              _buildPointSlider(
                label: 'التعليق على منشور',
                value: _activityPoints.commentingOnPost,
                min: 1,
                max: 10,
                onChanged: (val) => setState(() {
                  _activityPoints = _activityPoints.copyWith(
                    commentingOnPost: val.round(),
                  );
                }),
              ),
              _buildPointSlider(
                label: 'مساعدة زميل (رد مفيد)',
                value: _activityPoints.helpingPeer,
                min: 5,
                max: 50,
                onChanged: (val) => setState(() {
                  _activityPoints = _activityPoints.copyWith(
                    helpingPeer: val.round(),
                  );
                }),
              ),
            ],
            
            SizedBox(height: 32),
            Divider(),
            
            // القسم الثالث: Daily Streak (Optional)
            _buildSectionHeader(
              title: 'الدخول اليومي',
              subtitle: 'اختياري - لتشجيع الاستمرارية والمواظبة',
              icon: Icons.local_fire_department,
              color: Colors.orange,
            ),
            SwitchListTile(
              title: Text('تفعيل نقاط الدخول اليومي'),
              subtitle: Text('مكافأة المتدربين على الدخول المستمر'),
              value: _activityPoints.enableDailyStreak,
              onChanged: (val) => setState(() {
                _activityPoints = _activityPoints.copyWith(
                  enableDailyStreak: val,
                );
              }),
            ),
            
            if (_activityPoints.enableDailyStreak) ...[
              _buildPointSlider(
                label: 'نقاط الدخول اليومي',
                value: _activityPoints.dailyStreak,
                min: 1,
                max: 20,
                onChanged: (val) => setState(() {
                  _activityPoints = _activityPoints.copyWith(
                    dailyStreak: val.round(),
                  );
                }),
              ),
              _buildPointSlider(
                label: 'مكافأة الأسبوع المتواصل',
                value: _activityPoints.weeklyStreak,
                min: 10,
                max: 200,
                onChanged: (val) => setState(() {
                  _activityPoints = _activityPoints.copyWith(
                    weeklyStreak: val.round(),
                  );
                }),
              ),
            ],
            
            SizedBox(height: 32),
            Divider(),
            
            // القسم الرابع: المستويات
            _buildSectionHeader(
              title: 'المستويات',
              subtitle: 'حدد النقاط المطلوبة لكل مستوى',
              icon: Icons.stairs,
              color: Colors.green,
            ),
            _buildLevelThresholdsEditor(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPointSlider({
    required String label,
    required int value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$value نقطة',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ),
            ],
          ),
          Slider(
            value: value.toDouble(),
            min: min,
            max: max,
            divisions: ((max - min) / 5).round(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
  
  Widget _buildLevelThresholdsEditor() {
    return Column(
      children: [
        for (var level in _levelThresholds.keys.toList()..sort())
          _buildLevelThresholdTile(level),
        SizedBox(height: 8),
        OutlinedButton.icon(
          icon: Icon(Icons.add),
          label: Text('إضافة مستوى جديد'),
          onPressed: _addNewLevel,
        ),
      ],
    );
  }
  
  Widget _buildLevelThresholdTile(int level) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('$level'),
        backgroundColor: _getLevelColor(level),
      ),
      title: Text('المستوى $level'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${_levelThresholds[level]} نقطة'),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.edit, size: 20),
            onPressed: () => _editLevelThreshold(level),
          ),
          if (level > 1)
            IconButton(
              icon: Icon(Icons.delete, size: 20, color: Colors.red),
              onPressed: () => _deleteLevelThreshold(level),
            ),
        ],
      ),
    );
  }
  
  Future<void> _saveSettings() async {
    // حفظ الإعدادات في Firestore
    await FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseId)
        .update({
      'gamificationSettings': {
        'activityPoints': _activityPoints.toJson(),
        'levelThresholds': _levelThresholds,
        'isEnabled': true,
      },
    });
    
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم حفظ الإعدادات بنجاح')),
    );
  }
}
```

---

## ✨ الخلاصة

هذا النظام يوفر:
- ✅ تحفيز مستمر للمتدربين
- ✅ مسار تعليمي منظم ومتدرج
- ✅ تتبع دقيق للتقدم
- ✅ **مرونة كاملة للمدرب في التخصيص**
- ✅ **أولوية للمهام والاختبارات**
- ✅ **التفاعل الاجتماعي والـ Daily Streak اختياريين**
- ✅ شفافية في معايير التقييم

---

## 📋 خطة التنفيذ التفصيلية

### 🎯 المرحلة 0: الإعداد والتخطيط (يوم واحد)
**الهدف**: تجهيز البنية الأساسية

- [ ] مراجعة الكود الحالي والـ dependencies
- [ ] إنشاء branch جديد: `feature/gamification-system`
- [ ] تحديث `pubspec.yaml` إذا لزم الأمر
- [ ] إنشاء هيكل المجلدات:
  ```
  lib/
    models/gamification/
    services/gamification/
    repositories/gamification/
    providers/gamification/
    screens/gamification/
    widgets/gamification/
  ```

**الناتج**: هيكل نظيف ومنظم للبدء

---

### 🏗️ المرحلة 1: البنية التحتية (2-3 أيام)

#### اليوم 1: Models الأساسية

**1.1 إنشاء `activity_points.dart`**
```dart
lib/models/gamification/activity_points.dart
```
- [ ] Class `ActivityPoints` مع كل الحقول
- [ ] JSON serialization (toJson/fromJson)
- [ ] copyWith method
- [ ] القيم الافتراضية
- [ ] Unit tests

**1.2 إنشاء `gamification_settings.dart`**
```dart
lib/models/gamification/gamification_settings.dart
```
- [ ] Class `GamificationSettings`
- [ ] تضمين `ActivityPoints`
- [ ] `levelThresholds` map
- [ ] JSON serialization
- [ ] Unit tests

**1.3 إنشاء `learning_module.dart`**
```dart
lib/models/gamification/learning_module.dart
```
- [ ] Class `LearningModule`
- [ ] Class `ModuleContent`
- [ ] Class `ModuleRequirements`
- [ ] Enums للأنواع
- [ ] JSON serialization
- [ ] Unit tests

**1.4 إنشاء `user_course_progress.dart`**
```dart
lib/models/gamification/user_course_progress.dart
```
- [ ] Class `UserCourseProgress`
- [ ] Class `ModuleProgress`
- [ ] Class `ContentProgress`
- [ ] Class `ProgressStats`
- [ ] JSON serialization
- [ ] Unit tests

**1.5 إنشاء `points_transaction.dart`**
```dart
lib/models/gamification/points_transaction.dart
```
- [ ] Class `PointsTransaction`
- [ ] Enum `ActivityType`
- [ ] JSON serialization
- [ ] Unit tests

#### اليوم 2: Services الأساسية

**2.1 إنشاء `gamification_service.dart`**
```dart
lib/services/gamification/gamification_service.dart
```
- [ ] Method: `awardPoints()`
- [ ] Method: `calculateLevel()`
- [ ] Method: `checkLevelUp()`
- [ ] Method: `updateProgress()`
- [ ] Method: `getCourseSettings()`
- [ ] Integration tests

**2.2 إنشاء `points_calculator.dart`**
```dart
lib/services/gamification/points_calculator.dart
```
- [ ] Method: `calculateLessonPoints()`
- [ ] Method: `calculateQuizPoints()`
- [ ] Method: `calculateAssignmentPoints()`
- [ ] Method: `calculateSocialPoints()`
- [ ] Method: `calculateStreakPoints()`
- [ ] Unit tests لكل method

**2.3 إنشاء `level_system.dart`**
```dart
lib/services/gamification/level_system.dart
```
- [ ] Method: `calculateLevel()`
- [ ] Method: `pointsToNextLevel()`
- [ ] Method: `getLevelInfo()`
- [ ] Method: `getLevelColor()`
- [ ] Unit tests

#### اليوم 3: Repositories

**3.1 إنشاء `gamification_repository.dart`**
```dart
lib/repositories/gamification/gamification_repository.dart
```
- [ ] Method: `getSettings(courseId)`
- [ ] Method: `updateSettings(courseId, settings)`
- [ ] Method: `getUserProgress(userId, courseId)`
- [ ] Method: `updateUserProgress()`
- [ ] Method: `getPointsHistory()`
- [ ] Method: `addPointsTransaction()`
- [ ] Integration tests

**3.2 إنشاء `learning_path_repository.dart`**
```dart
lib/repositories/gamification/learning_path_repository.dart
```
- [ ] Method: `getLearningPath(courseId)`
- [ ] Method: `updateLearningPath()`
- [ ] Method: `getModuleProgress()`
- [ ] Method: `updateModuleProgress()`
- [ ] Integration tests

---

### 🎮 المرحلة 2: نظام النقاط الأساسي (3-4 أيام)

#### اليوم 4-5: تكامل المهام والاختبارات

**4.1 تعديل Quiz System**
- [ ] فتح ملف الاختبارات الحالي
- [ ] إضافة منح نقاط بعد اجتياز الاختبار
- [ ] إضافة نقاط إضافية للدرجة الكاملة
- [ ] تحديث UI لعرض النقاط المكتسبة
- [ ] Testing شامل

**4.2 إنشاء Assignment System (جديد)**
```dart
lib/models/assignment.dart
lib/repositories/assignment_repository.dart
lib/screens/assignment_screen.dart
```
- [ ] Model للمهام/التكليفات
- [ ] Repository للعمليات
- [ ] UI لإنشاء وعرض المهام
- [ ] نظام التسليم والتقييم
- [ ] منح النقاط عند التقييم

**4.3 تعديل Lesson System**
- [ ] إضافة tracking لإتمام الدروس
- [ ] منح نقاط عند إتمام الدرس
- [ ] UI notification للنقاط

#### اليوم 6: Points Transaction System

**6.1 إنشاء Points History Screen**
```dart
lib/screens/gamification/points_history_screen.dart
```
- [ ] عرض كل transactions المستخدم
- [ ] فلترة حسب النوع/التاريخ
- [ ] إحصائيات شاملة

**6.2 إنشاء Points Animation Widget**
```dart
lib/widgets/gamification/points_gained_animation.dart
```
- [ ] Animation عند كسب نقاط
- [ ] عرض النقاط المكتسبة
- [ ] Sound effects (اختياري)

---

### 🎯 المرحلة 3: التفاعل الاجتماعي (اختياري) (2 يوم)

#### اليوم 7-8: Social Points Integration

**7.1 تعديل Wall Post System**
```dart
lib/repositories/wall_post_repository.dart
```
- [ ] إضافة check للإعدادات (enableSocialPoints)
- [ ] منح نقاط عند إنشاء منشور
- [ ] منح نقاط عند التعليق
- [ ] منح نقاط للردود المفيدة (based on reactions)

**7.2 Helpful Comment Detection**
```dart
lib/services/gamification/helpful_comment_detector.dart
```
- [ ] Logic لتحديد التعليق المفيد
- [ ] Based on reaction count/type
- [ ] منح نقاط تلقائياً

---

### 🔥 المرحلة 4: Daily Streak System (اختياري) (2 يوم)

#### اليوم 9-10: Streak Tracking

**9.1 إنشاء Streak Service**
```dart
lib/services/gamification/streak_service.dart
```
- [ ] Method: `checkDailyStreak()`
- [ ] Method: `updateStreak()`
- [ ] Method: `resetStreak()`
- [ ] Method: `awardStreakPoints()`

**9.2 Streak Widget**
```dart
lib/widgets/gamification/streak_indicator.dart
```
- [ ] عرض الـ streak الحالي
- [ ] Fire animation
- [ ] Streak history

**9.3 Background Job للتحقق**
- [ ] Setup background task
- [ ] التحقق اليومي من الـ streak
- [ ] إرسال notification

---

### 📚 المرحلة 5: Learning Path (3-4 أيام)

#### اليوم 11-12: Learning Path UI

**11.1 إنشاء Learning Path Screen**
```dart
lib/screens/gamification/learning_path_screen.dart
```
- [ ] عرض كل الـ modules
- [ ] Progress indicators
- [ ] Lock/unlock logic
- [ ] Navigation للـ modules

**11.2 إنشاء Module Detail Screen**
```dart
lib/screens/gamification/module_detail_screen.dart
```
- [ ] عرض محتوى الـ module
- [ ] Content list
- [ ] Progress tracking
- [ ] Completion logic

**11.3 إنشاء Content Viewer**
```dart
lib/screens/gamification/content_viewer_screen.dart
```
- [ ] عرض المحتوى (lesson/quiz/assignment)
- [ ] Mark as complete
- [ ] Award points
- [ ] Navigation للمحتوى التالي

#### اليوم 13-14: Module Progress Tracking

**13.1 تنفيذ Progress Logic**
- [ ] Track content completion
- [ ] Calculate module completion percentage
- [ ] Check requirements
- [ ] Unlock next module
- [ ] Award completion points

---

### 🎨 المرحلة 6: Progress UI (2-3 أيام)

#### اليوم 15-16: Progress Widgets

**15.1 إنشاء Progress Card**
```dart
lib/widgets/gamification/course_progress_card.dart
```
- [ ] Current level display
- [ ] Points display
- [ ] Progress bar للمستوى التالي
- [ ] Streak indicator (إذا مفعّل)

**15.2 إنشاء Level Badge**
```dart
lib/widgets/gamification/level_badge.dart
```
- [ ] عرض المستوى
- [ ] تصميم جذاب
- [ ] Animation عند الترقية

**15.3 إنشاء Stats Widget**
```dart
lib/widgets/gamification/progress_stats_widget.dart
```
- [ ] إحصائيات شاملة
- [ ] Charts (اختياري)
- [ ] Comparisons

#### اليوم 17: Integration في Course Screen

**17.1 تعديل Course Details Screen**
- [ ] إضافة Progress Card في الأعلى
- [ ] Tab للـ Learning Path
- [ ] Tab للـ Progress/Stats
- [ ] Link لـ Points History

---

### 🎛️ المرحلة 7: لوحة تحكم المدرب (3-4 أيام)

#### اليوم 18-19: Settings Screen

**18.1 إنشاء Gamification Settings Screen**
```dart
lib/screens/gamification/gamification_settings_screen.dart
```
- [ ] UI للـ Core activities
- [ ] Sliders للنقاط
- [ ] Switch للـ Social points
- [ ] Switch للـ Daily streak
- [ ] Level thresholds editor

**18.2 إنشاء Helper Widgets**
```dart
lib/widgets/gamification/settings/
  - point_slider_widget.dart
  - section_header_widget.dart
  - level_threshold_editor.dart
```

#### اليوم 20-21: Learning Path Builder

**20.1 إنشاء Learning Path Builder Screen**
```dart
lib/screens/gamification/learning_path_builder_screen.dart
```
- [ ] إضافة modules
- [ ] ترتيب الـ modules (drag & drop)
- [ ] تعديل module content
- [ ] Set requirements
- [ ] Preview

**20.2 إنشاء Module Editor Dialog**
```dart
lib/widgets/gamification/module_editor_dialog.dart
```
- [ ] Form لبيانات الـ module
- [ ] Content list editor
- [ ] Requirements editor

---

### 📊 المرحلة 8: Analytics للمدرب (2 يوم)

#### اليوم 22-23: Progress Analytics

**22.1 إنشاء Course Analytics Screen**
```dart
lib/screens/gamification/course_analytics_screen.dart
```
- [ ] Overview statistics
- [ ] Top performers
- [ ] Average progress
- [ ] Completion rates
- [ ] Charts/Graphs

**22.2 إنشاء Student Progress Detail**
```dart
lib/screens/gamification/student_progress_detail_screen.dart
```
- [ ] تفاصيل تقدم طالب معين
- [ ] Timeline
- [ ] Points breakdown
- [ ] Module completion

---

### 🔐 المرحلة 9: Security Rules (1 يوم)

#### اليوم 24: Firestore Rules

**24.1 تحديث Security Rules**
```javascript
firestore.rules
```
- [ ] Rules للـ gamification_settings
- [ ] Rules للـ user_course_progress
- [ ] Rules للـ points_transactions
- [ ] Rules للـ learning_path
- [ ] Testing للـ rules

---

### ✅ المرحلة 10: Testing & Polish (3-4 أيام)

#### اليوم 25-26: Testing شامل

**25.1 Unit Tests**
- [ ] كل الـ models
- [ ] كل الـ services
- [ ] كل الـ repositories

**25.2 Integration Tests**
- [ ] Award points flow
- [ ] Level up flow
- [ ] Module completion flow
- [ ] Settings update flow

**25.3 Widget Tests**
- [ ] Progress card
- [ ] Learning path view
- [ ] Settings screen

#### اليوم 27-28: UI/UX Polish

**27.1 Design Review**
- [ ] مراجعة كل الشاشات
- [ ] تحسين الألوان والخطوط
- [ ] إضافة animations
- [ ] تحسين الـ responsive design

**27.2 User Testing**
- [ ] اختبار مع مستخدمين حقيقيين
- [ ] جمع feedback
- [ ] إصلاح المشاكل

---

### 🚀 المرحلة 11: Deployment (1-2 يوم)

#### اليوم 29-30: Production Ready

**29.1 Migration Script**
```dart
lib/scripts/migrate_courses_to_gamification.dart
```
- [ ] Script لإضافة default settings للكورسات الموجودة
- [ ] Script لإنشاء progress records للمستخدمين

**29.2 Documentation**
- [ ] User guide للمتدربين
- [ ] Admin guide للمدربين
- [ ] Technical documentation
- [ ] API documentation

**29.3 Deployment**
- [ ] Merge to main branch
- [ ] Deploy to production
- [ ] Monitor errors
- [ ] Announcement للمستخدمين

---

## 📊 ملخص الجدول الزمني

| المرحلة | المدة | الأولوية |
|---------|-------|---------|
| 0. الإعداد | يوم واحد | 🔴 عالية |
| 1. البنية التحتية | 2-3 أيام | 🔴 عالية |
| 2. نظام النقاط الأساسي | 3-4 أيام | 🔴 عالية |
| 3. التفاعل الاجتماعي | 2 يوم | 🟡 متوسطة |
| 4. Daily Streak | 2 يوم | 🟡 متوسطة |
| 5. Learning Path | 3-4 أيام | 🔴 عالية |
| 6. Progress UI | 2-3 أيام | 🔴 عالية |
| 7. لوحة تحكم المدرب | 3-4 أيام | 🔴 عالية |
| 8. Analytics | 2 يوم | 🟢 منخفضة |
| 9. Security Rules | يوم واحد | 🔴 عالية |
| 10. Testing & Polish | 3-4 أيام | 🔴 عالية |
| 11. Deployment | 1-2 يوم | 🔴 عالية |
| **المجموع** | **25-32 يوم** | |

---

## 🎯 خطة العمل المقترحة

### الخيار 1: Full Implementation (شهر كامل)
تنفيذ كل المراحل بالترتيب

### الخيار 2: MVP Approach (أسبوعين)
التركيز على:
- ✅ المرحلة 0, 1, 2 (البنية + النقاط الأساسية)
- ✅ المرحلة 5, 6 (Learning Path + UI)
- ✅ المرحلة 7 (لوحة المدرب - أساسيات فقط)
- ✅ المرحلة 9, 10, 11 (Security + Testing + Deploy)

ثم إضافة المراحل 3, 4, 8 لاحقاً.

### الخيار 3: Phased Rollout (تدريجي)
- **Phase 1** (أسبوع): Core system only
- **Phase 2** (أسبوع): Learning Path
- **Phase 3** (أسبوع): Social + Streak
- **Phase 4** (أسبوع): Analytics + Polish

---

## 📝 ملاحظات مهمة

### للمدرب:
1. ✅ كل الإعدادات قابلة للتعديل
2. ✅ التفاعل الاجتماعي اختياري
3. ✅ Daily Streak اختياري
4. ✅ يمكن تعطيل النظام كاملاً
5. ✅ تحليلات تفصيلية لتقدم المتدربين

### للمتدرب:
1. ✅ تقدم واضح ومرئي
2. ✅ مكافآت عادلة وشفافة
3. ✅ التركيز على التعلم الفعلي
4. ✅ مسار منظم وسهل المتابعة

---

عايز نبدأ بأي مرحلة؟ أقترح نبدأ بـ MVP Approach! 🚀
