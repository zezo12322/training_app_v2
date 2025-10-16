import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
import 'dart:async';
import '../models/user_points.dart';
import '../models/badge.dart';
import '../models/user_review.dart';
import '../repositories/points_repository.dart';
import '../repositories/review_repository.dart';
import '../repositories/leaderboard_repository.dart';
import 'auth_provider.dart';

/// أنواع الأحداث التي تمنح نقاط
enum PointEventType { lessonCompleted, quizPassed, dailyStreak }

/// قاعدة القيم لكل نوع حدث (يمكن نقلها لاحقاً إلى إعدادات عن بعد)
const Map<PointEventType, int> _pointValues = {
  PointEventType.lessonCompleted: 10,
  PointEventType.quizPassed: 20,
  PointEventType.dailyStreak: 5,
};

// Points repository provider (إن لم يكن معرفاً في ملف مستقل يمكن استخدام هذا)
final pointsRepositoryProvider = Provider<PointsRepository>((ref) {
  return PointsRepository();
});

// Repositories providers الأخرى
final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository();
});

final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) {
  return LeaderboardRepository();
});

/// مراقبة نقاط المستخدم (Stream)
final userPointsStreamProvider = StreamProvider.family.autoDispose<UserPoints?, String>((
  ref,
  userId,
) {
  final fs = ref.watch(firebaseFirestoreProvider);
  return fs
      .collection('user_points')
      .doc(userId)
      .snapshots()
      .map((doc) => doc.exists ? UserPoints.fromFirestore(doc) : null);
});

/// أعلى المستخدمين (Leaderboard) – استدعاء مستقبلي (يمكن تحويله لاحقاً إلى stream/cache)
final topUsersProvider = FutureProvider.family<List<UserPoints>, int>((
  ref,
  limit,
) async {
  final repo = ref.watch(pointsRepositoryProvider);
  final list = await repo.getLeaderboard(limit: limit);
  return list;
});

/// كل الشارات (مخبأة بالذاكرة عبر keepAlive لو رغبت لاحقاً)
// Legacy one-shot badges fetch (kept for backward compatibility)
final allBadgesProvider = FutureProvider<List<Badge>>((ref) async {
  final repo = ref.watch(pointsRepositoryProvider);
  return repo.getAllBadges();
});

/// Real-time badges stream so newly added badges appear immediately (e.g. for trainer)
final allBadgesStreamProvider = StreamProvider.autoDispose<List<Badge>>((ref) {
  final fs = ref.watch(firebaseFirestoreProvider);
  return fs
      .collection('badges')
      .snapshots()
      .map(
        (snap) => snap.docs.map((d) => Badge.fromMap(d.data(), d.id)).toList(),
      );
});

/// خريطة (badgeId -> Badge) لتسهيل lookup في الواجهات
final badgeIdToBadgeProvider = Provider<Map<String, Badge>>((ref) {
  final list = ref
      .watch(allBadgesStreamProvider)
      .maybeWhen(data: (d) => d, orElse: () => const <Badge>[]);
  return {for (final b in list) b.id: b};
});

/// مراجعات مستخدم مستهدَف
final userReviewsProvider = FutureProvider.family<List<UserReview>, String>((
  ref,
  targetId,
) async {
  final repo = ref.watch(reviewRepositoryProvider);
  return repo.getReviewsForUser(targetId);
});

/// متوسط تقييم مستخدم
final userAverageRatingProvider = FutureProvider.family<double, String>((
  ref,
  targetId,
) async {
  final repo = ref.watch(reviewRepositoryProvider);
  return repo.getAverageRating(targetId);
});

/// إجراء منح نقاط لحدث معين للمستخدم الحالي
final grantPointsForEventProvider = FutureProvider.family<void, PointEventType>(
  (ref, event) async {
    final auth = ref.watch(authStateProvider).value;
    if (auth == null) return; // ليس مسجلاً
    final repo = ref.read(pointsRepositoryProvider);
    final delta = _pointValues[event] ?? 0;
    if (delta == 0) return;
    await repo.addPoints(auth.uid, delta);
    if (event == PointEventType.dailyStreak) {
      await repo.recordDailyActivity(auth.uid);
    }
    // تحقق من الشارات بعد التحديث
    await ref.read(_badgeEvaluationServiceProvider).evaluateAndAward(auth.uid);
  },
);

/// تحديث سلسلة الأيام دون إضافة نقاط (يمكن استدعاؤه عند فتح التطبيق)
final updateDailyStreakProvider = FutureProvider<void>((ref) async {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return;
  final repo = ref.read(pointsRepositoryProvider);
  await repo.recordDailyActivity(auth.uid);
});

/// مزود قراءة قيمة السلسلة الحالية للمستخدم الحالي
final currentUserDailyStreakProvider = Provider<int?>((ref) {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return null;
  final upAsync = ref.watch(userPointsStreamProvider(auth.uid));
  return upAsync.maybeWhen(data: (up) => up?.dailyStreak, orElse: () => null);
});

/// خدمة تقييم الشارات (بسيطة حالياً تعتمد على عدد النقاط)
class BadgeEvaluationService {
  final PointsRepository _pointsRepository;
  final FirebaseFirestore _firestore;
  BadgeEvaluationService(this._pointsRepository, {FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> evaluateAndAward(String userId) async {
    final up = await _pointsRepository.getUserPoints(userId);
    if (up == null) return;
    // Fetch active auto-award badges
    final badgesSnap = await _firestore
        .collection('badges')
        .where('active', isEqualTo: true)
        .get();
    // Pre-fetch review count lazily when first needed
    int? reviewsCount;
    for (final doc in badgesSnap.docs) {
      final data = doc.data();
      final autoAward = (data['autoAward'] ?? true) == true;
      if (!autoAward) continue; // skip manual badges
      final badgeId = doc.id;
      final currentBadges = up.badges;
      if (currentBadges.contains(badgeId)) continue; // already awarded
      final criteria = data['criteria'] is Map<String, dynamic>
          ? Map<String, dynamic>.from(data['criteria'] as Map)
          : <String, dynamic>{};
      if (criteria.isEmpty) {
        continue; // ignore empty criteria to prevent auto-award all
      }
      final ok = await _criteriaSatisfied(
        criteria,
        up,
        userId,
        reviewsCountRef: () async {
          reviewsCount ??= await _countReviews(userId);
          return reviewsCount!;
        },
      );
      if (ok) {
        await _pointsRepository.addBadge(userId, badgeId);
      }
    }
  }

  Future<int> _countReviews(String userId) async {
    final snap = await _firestore
        .collection('user_reviews')
        .where('reviewerId', isEqualTo: userId)
        .get();
    return snap.size;
  }

  Future<bool> _criteriaSatisfied(
    Map<String, dynamic> c,
    UserPoints up,
    String userId, {
    required Future<int> Function() reviewsCountRef,
  }) async {
    // Numeric helpers
    bool numGte(String key, int actual) {
      if (!c.containsKey(key)) return true;
      final v = c[key];
      if (v is int) return actual >= v;
      return true; // ignore invalid
    }

    if (!numGte('pointsGte', up.points)) return false;
    if (!numGte('dailyStreakGte', up.dailyStreak)) return false;
    if (!numGte('quizzesPassedGte', up.quizzesPassed)) return false;
    if (!numGte('tasksCompletedGte', up.tasksCompleted)) return false;
    if (!numGte('lessonsCompletedGte', up.lessonsCompleted)) return false;
    if (c.containsKey('reviewsWrittenGte')) {
      final need = c['reviewsWrittenGte'];
      if (need is int) {
        final count = await reviewsCountRef();
        if (count < need) return false;
      }
    }
    return true;
  }
}

final _badgeEvaluationServiceProvider = Provider<BadgeEvaluationService>((ref) {
  final repo = ref.watch(pointsRepositoryProvider);
  final fs = ref.watch(firebaseFirestoreProvider);
  return BadgeEvaluationService(repo, firestore: fs);
});

/// حساب المستوى بناءً على صيغة جذرية بسيطة: level = floor(sqrt(points / 50)) + 1
int computeLevel(int points) {
  if (points <= 0) return 1;
  return (math.sqrt(points / 50)).floor() + 1;
}

/// نموذج بيانات لتقدم المستوى (مجرّد للاختبار)
class LevelProgressData {
  final int level;
  final int baseLevelPoints; // أول نقطة في هذا المستوى
  final int nextLevelPoints; // أول نقطة في المستوى التالي (عتبة الانتقال)
  final int currentPoints;
  final double percent; // نسبة التقدم داخل المستوى الحالي 0..1
  LevelProgressData({
    required this.level,
    required this.baseLevelPoints,
    required this.nextLevelPoints,
    required this.currentPoints,
    required this.percent,
  });
}

/// حساب تفصيلي للتقدم داخل المستوى الحالي
LevelProgressData computeLevelProgress(int points) {
  final lvl = computeLevel(points);
  int baseLevelPoints(int lvl) =>
      lvl <= 1 ? 0 : (50 * math.pow((lvl - 1), 2)).toInt();
  int nextLevelPoints(int lvl) => (50 * math.pow(lvl, 2)).toInt();
  final base = baseLevelPoints(lvl);
  final next = nextLevelPoints(lvl);
  final span = (next - base).clamp(1, 1 << 31);
  final within = (points - base).clamp(0, span);
  final pct = within / span;
  return LevelProgressData(
    level: lvl,
    baseLevelPoints: base,
    nextLevelPoints: next,
    currentPoints: points,
    percent: pct,
  );
}

/// مزود مستوى المستخدم الحالي (يعتمد على userPointsStreamProvider)
final currentUserLevelProvider = Provider<int?>((ref) {
  final auth = ref.watch(authStateProvider).value;
  if (auth == null) return null;
  final upAsync = ref.watch(userPointsStreamProvider(auth.uid));
  return upAsync.maybeWhen(
    data: (up) => up == null ? 1 : computeLevel(up.points),
    orElse: () => null,
  );
});

/// تقدم النقاط نحو المستوى التالي (يعتمد على صيغة computeLevel)
/// نعرّف صيغة عكسية تقريبية: نقاط المستوى N = 50 * (N-1)^2
final currentUserLevelProgressProvider =
    Provider<
      ({
        int level,
        int nextLevelPoints,
        int baseLevelPoints,
        int currentPoints,
        double percent,
      })?
    >((ref) {
      final auth = ref.watch(authStateProvider).value;
      if (auth == null) return null;
      final upAsync = ref.watch(userPointsStreamProvider(auth.uid));
      return upAsync.maybeWhen(
        data: (up) {
          final pts = up?.points ?? 0;
          final lp = computeLevelProgress(pts);
          return (
            level: lp.level,
            nextLevelPoints: lp.nextLevelPoints,
            baseLevelPoints: lp.baseLevelPoints,
            currentPoints: lp.currentPoints,
            percent: lp.percent,
          );
        },
        orElse: () => null,
      );
    });

/// تقدم المستخدم نحو أقرب شارة تعتمد على شرط pointsGte (ديناميكية)
final nextBadgeProgressProvider =
    FutureProvider<({int? nextThreshold, int remaining, int currentPoints})?>((
      ref,
    ) async {
      final auth = ref.watch(authStateProvider).value;
      if (auth == null) return null;
      final up = await ref.watch(userPointsStreamProvider(auth.uid).future);
      if (up == null) {
        return (nextThreshold: null, remaining: 0, currentPoints: 0);
      }
      final fs = ref.watch(firebaseFirestoreProvider);
      final snap = await fs
          .collection('badges')
          .where('active', isEqualTo: true)
          .get();
      final thresholds = <int>{};
      for (final d in snap.docs) {
        final data = d.data();
        final criteria = data['criteria'];
        if (criteria is Map && criteria['pointsGte'] is int) {
          thresholds.add(criteria['pointsGte'] as int);
        }
      }
      if (thresholds.isEmpty) {
        return (nextThreshold: null, remaining: 0, currentPoints: up.points);
      }
      final sorted = thresholds.toList()..sort();
      int? next;
      for (final t in sorted) {
        if (up.points < t) {
          next = t;
          break;
        }
      }
      if (next == null) {
        return (nextThreshold: null, remaining: 0, currentPoints: up.points);
      }
      return (
        nextThreshold: next,
        remaining: (next - up.points).clamp(0, next),
        currentPoints: up.points,
      );
    });

/// نسبة التقدم نحو الشارة التالية (0..1). ترجع 1 إن لم توجد شارة تالية.
final nextBadgeProgressPercentProvider = Provider<double?>((ref) {
  final asyncVal = ref.watch(nextBadgeProgressProvider);
  return asyncVal.when(
    data: (p) {
      if (p == null) return null;
      final t = p.nextThreshold;
      if (t == null || t == 0) return 1;
      return (p.currentPoints / t).clamp(0, 1);
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

/// تقسيم الشارات إلى مكتسبة / مقفلة لمستخدم معين
final earnedLockedBadgesProvider =
    Provider.family<(List<Badge>, List<Badge>), String>((ref, userId) {
      final allBadges = ref
          .watch(allBadgesStreamProvider)
          .maybeWhen(data: (d) => d, orElse: () => const <Badge>[]);
      final up = ref
          .watch(userPointsStreamProvider(userId))
          .maybeWhen(data: (u) => u, orElse: () => null);
      final earnedIds = up?.badges.toSet() ?? <String>{};
      final earned = <Badge>[];
      final locked = <Badge>[];
      for (final b in allBadges) {
        if (earnedIds.contains(b.id)) {
          earned.add(b);
        } else {
          locked.add(b);
        }
      }
      return (earned, locked);
    });

/// مزود إدخالات المتصدرين مع بيانات المستخدم (الاسم والصورة) عبر LeaderboardRepository
final leaderboardEntriesProvider =
    FutureProvider.family<List<LeaderboardEntry>, int>((ref, limit) {
      return ref.watch(leaderboardRepositoryProvider).topUsers(limit: limit);
    });

// ------------------------------------------------------------
// Badge award events (detect newly earned badges and emit id list)
// ------------------------------------------------------------

/// مزود Firestore قابل للتهيئة للاختبارات (افتراضياً يستخدم FirebaseFirestore.instance)
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

class BadgeAwardNotifier extends StateNotifier<List<String>> {
  final FirebaseFirestore _firestore;
  final String _userId;
  Set<String> _last = {};
  late final StreamSubscription _sub;

  BadgeAwardNotifier(this._firestore, this._userId) : super(const []) {
    _sub = _firestore.collection('user_points').doc(_userId).snapshots().listen(
      (snap) {
        if (!snap.exists) return;
        final data = snap.data();
        if (data == null) return;
        final badgesRaw = data['badges'];
        final list = badgesRaw is List
            ? badgesRaw.map((e) => e.toString()).toList()
            : <String>[];
        final current = list.toSet();
        final newOnes = current.difference(_last);
        if (newOnes.isNotEmpty) {
          state = [...state, ...newOnes];
        }
        _last = current;
      },
    );
  }

  void consume(String id) {
    state = state.where((b) => b != id).toList();
  }

  void consumeAll() => state = const [];

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

final badgeAwardEventsProvider =
    StateNotifierProvider.family<BadgeAwardNotifier, List<String>, String>((
      ref,
      userId,
    ) {
      final fs = ref.watch(firebaseFirestoreProvider);
      return BadgeAwardNotifier(fs, userId);
    });

// ------------------------------------------------------------
// Badge awards history (stream of badgeId + awardedAt timestamp)
// ------------------------------------------------------------

final badgeAwardsHistoryProvider =
    StreamProvider.family<
      List<({String badgeId, DateTime? awardedAt})>,
      String
    >((ref, userId) {
      final fs = ref.watch(firebaseFirestoreProvider);
      return fs
          .collection('user_points')
          .doc(userId)
          .collection('badge_awards')
          .orderBy('awardedAt', descending: false)
          .snapshots()
          .map(
            (snap) => snap.docs.map((d) {
              final data = d.data();
              final ts = data['awardedAt'];
              DateTime? dt;
              if (ts is Timestamp) dt = ts.toDate();
              return (badgeId: d.id, awardedAt: dt);
            }).toList(),
          );
    });
