import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/fcm_notification_service.dart';
import '../services/wall_notification_helper.dart';

/// FCM Notification Service Provider
final fcmNotificationServiceProvider = Provider<FcmNotificationService>((ref) {
  return FcmNotificationService();
});

/// Initialize FCM on app startup
final fcmInitializationProvider = FutureProvider<void>((ref) async {
  final fcmService = ref.read(fcmNotificationServiceProvider);
  await fcmService.initialize();
});

/// Wall Notification Helper Provider
final wallNotificationHelperProvider = Provider<WallNotificationHelper>((ref) {
  final fcmService = ref.read(fcmNotificationServiceProvider);
  return WallNotificationHelper(fcmService, FirebaseFirestore.instance);
});
