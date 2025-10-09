import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/repositories/quiz_repository.dart';
import 'package:training_app/services/notification_service.dart';

final notificationServiceProvider = Provider<OneSignalNotificationService>((
  ref,
) {
  return OneSignalNotificationService();
});

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  final notif = ref.read(notificationServiceProvider);
  return QuizRepository(FirebaseFirestore.instance, notificationService: notif);
});
