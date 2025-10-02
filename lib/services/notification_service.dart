import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/core/logging.dart';

class OneSignalNotificationService {
  // SECURITY NOTE:
  // The previous version hard‑coded OneSignal APP ID & REST API KEY here.
  // Storing secrets in client code is insecure (can be extracted from the APK/IPA).
  // Action taken: remove secrets & replace with indirection.
  // Next steps:
  //   1. Store APP ID only (public) via --dart-define or remote config if needed.
  //   2. Move REST API key usage to a backend (e.g. Firebase Cloud Function callable) that
  //      performs the HTTPS request to OneSignal.
  //   3. This service will only register the device & call backend for sending notifications.

  // Placeholder (non-sensitive). Provide via --dart-define=ONE_SIGNAL_APP_ID=XXXX
  final String _appId = const String.fromEnvironment('ONE_SIGNAL_APP_ID', defaultValue: 'REPLACE_ME');

  // Deprecated: DO NOT PLACE REST API KEY HERE.
  // final String _restApiKey = 'REMOVED';

  Future<void> initOneSignal() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(_appId);
    OneSignal.Notifications.requestPermission(true);
    OneSignal.User.pushSubscription.addObserver((state) {
      if (state.current.id != null) {
        _savePlayerIdToDatabase(state.current.id!);
      }
    });
  }

  Future<void> _savePlayerIdToDatabase(String playerId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({'oneSignalPlayerId': playerId});
    }
  }

  // --- دالة جديدة لإرسال الإشعارات ---
  /// Instead of calling OneSignal REST API directly (which needs a secret),
  /// call a secure backend endpoint / cloud function that performs the send.
  /// Example expected callable function name: sendOneSignalNotification
  /// (Implementation not included here to avoid mixing backend code.)
  Future<void> sendNotificationViaBackend({
    required List<String> playerIds,
    required String title,
    required String content,
  }) async {
    if (playerIds.isEmpty) return;
    // Placeholder: Replace with Firebase Functions HTTPS callable.
    // Example:
    // final callable = FirebaseFunctions.instance.httpsCallable('sendOneSignalNotification');
    // await callable.call({
    //   'playerIds': playerIds,
    //   'title': title,
    //   'content': content,
    // });
    // For now just log intent:
  logger.d('[DEBUG] Would send notification to ${playerIds.length} players (delegated to backend).');
  }

  // Backward compatibility for existing code still calling sendNotification.
  @Deprecated('Use sendNotificationViaBackend which routes through secure backend.')
  Future<void> sendNotification({
    required List<String> playerIds,
    required String title,
    required String content,
  }) => sendNotificationViaBackend(playerIds: playerIds, title: title, content: content);
}