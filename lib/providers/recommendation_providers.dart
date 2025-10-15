import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/recommendation.dart';
import '../services/recommendation_service.dart';

/// Provider لخدمة التوصيات
final recommendationServiceProvider = Provider<RecommendationService>((ref) {
  return RecommendationService();
});

/// Provider لتوليد توصيات جديدة
final generateRecommendationsProvider = FutureProvider.family<
    List<Recommendation>,
    ({String userId, String courseId})>((ref, params) async {
  final service = ref.read(recommendationServiceProvider);
  return service.generateRecommendations(
    userId: params.userId,
    courseId: params.courseId,
  );
});

/// Provider لبث التوصيات النشطة
final activeRecommendationsProvider = StreamProvider.family<
    List<Recommendation>,
    ({String userId, String courseId})>((ref, params) {
  final service = ref.read(recommendationServiceProvider);
  return service.streamActiveRecommendations(
    userId: params.userId,
    courseId: params.courseId,
  );
});

/// Provider لإحصائيات التوصيات
final recommendationStatsProvider = FutureProvider.family<
    RecommendationStats,
    ({String userId, String courseId})>((ref, params) async {
  final service = ref.read(recommendationServiceProvider);
  return service.getRecommendationStats(
    userId: params.userId,
    courseId: params.courseId,
  );
});

/// Provider لتحديث حالة توصية
final updateRecommendationStatusProvider = Provider<
    Future<void> Function({
      required String recommendationId,
      bool? isViewed,
      bool? isAccepted,
      bool? isDismissed,
      bool? isCompleted,
    })>((ref) {
  final service = ref.read(recommendationServiceProvider);
  return ({
    required String recommendationId,
    bool? isViewed,
    bool? isAccepted,
    bool? isDismissed,
    bool? isCompleted,
  }) async {
    await service.updateRecommendationStatus(
      recommendationId: recommendationId,
      isViewed: isViewed,
      isAccepted: isAccepted,
      isDismissed: isDismissed,
      isCompleted: isCompleted,
    );
  };
});
