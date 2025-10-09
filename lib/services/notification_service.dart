import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:training_app/core/logging.dart';
import 'package:training_app/config/app_config.dart';

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
  final String _appId = const String.fromEnvironment(
    'ONE_SIGNAL_APP_ID',
    defaultValue: 'c89cafa8-1e04-4b6a-bcf8-43ccae9c37cd',
  );

  // Deprecated: DO NOT PLACE REST API KEY HERE.
  // final String _restApiKey = 'REMOVED';

  static bool _initialized = false; // prevents duplicate init spam
  // External backend endpoint (Cloudflare Worker / simple server) that holds OneSignal REST key securely.
  // Configure at runtime via --dart-define=NOTIF_ENDPOINT=https://your-worker.example.com/send
  final String _endpointEnv = const String.fromEnvironment(
    'NOTIF_ENDPOINT',
    defaultValue: '',
  );

  // Pending queue for notifications triggered before endpoint / subscription ready.
  final List<_PendingNotification> _pending = [];
  bool _flushing = false;

  String get _resolvedEndpoint {
    // Priority: dart-define > AppConfig.notifEndpoint (fallback) > empty
    if (_endpointEnv.isNotEmpty) return _endpointEnv;
    if (AppConfig.notifEndpoint.isNotEmpty) return AppConfig.notifEndpoint;
    return '';
  }

  Future<void> initOneSignal() async {
    if (_initialized) {
      logger.t('[OneSignal] initOneSignal skipped (already initialized)');
      return;
    }

    if (_appId.isEmpty || _appId == 'REPLACE_ME') {
      logger.e(
        '[OneSignal] App ID is missing or placeholder. Pass --dart-define=ONE_SIGNAL_APP_ID=<UUID> at run/build time. Initialization aborted.',
      );
      return;
    }

    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    logger.i('[OneSignal] Initializing with app id: $_appId');
    OneSignal.initialize(_appId);
    OneSignal.Notifications.requestPermission(true);

    // Set external user id = Firebase Auth UID (لا نستخدم Firestore الآن)
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await OneSignal.login(user.uid);
        logger.i('[OneSignal] Logged in with external id=${user.uid}');
      } catch (e, st) {
        logger.e('[OneSignal] login error', error: e, stackTrace: st);
      }
    } else {
      logger.w(
        '[OneSignal] No authenticated user at init time; will rely on later auth wrapper call',
      );
    }
    _initialized = true;
    // Try flush if anything queued very early.
    _flushPending();
  }

  /// Explicit relogin when auth state changes (e.g. user signed in after service init).
  Future<void> ensureUserBinding() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      final currentExternal = await OneSignal.User.getExternalId();
      if (currentExternal != user.uid) {
        await OneSignal.login(user.uid);
        logger.i('[OneSignal] Re-bound external user id=${user.uid}');
      }
    } catch (e, st) {
      logger.e('[OneSignal] ensureUserBinding error', error: e, stackTrace: st);
    }
    _flushPending();
  }

  // --- دالة جديدة لإرسال الإشعارات ---
  /// Instead of calling OneSignal REST API directly (which needs a secret),
  /// call a secure backend endpoint / cloud function that performs the send.
  /// Example expected callable function name: sendOneSignalNotification
  /// (Implementation not included here to avoid mixing backend code.)
  Future<void> sendNotificationViaBackend({
    required List<String> userIds,
    required String title,
    required String content,
    Map<String, dynamic>? data,
  }) async {
    if (userIds.isEmpty) return;
    final ep = _resolvedEndpoint;
    final subscribed = await _isLikelySubscribed();
    if (ep.isEmpty || !subscribed) {
      // Queue and warn once.
      _pending.add(_PendingNotification(userIds, title, content, data ?? {}));
      logger.w(
        '[OneSignal] Queued notification (endpointConfigured=${ep.isNotEmpty}, subscribed=$subscribed). Pending=${_pending.length}',
      );
      return _scheduleDelayedFlush();
    }
    try {
      logger.i('[OneSignal] POST $ep -> users=${userIds.length}');
      final resp = await http.post(
        Uri.parse(ep),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userIds': userIds,
          'title': title,
          'content': content,
          'data': data ?? {},
        }),
      );
      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        logger.i('[OneSignal] OK ${resp.statusCode} body=${resp.body}');
      } else {
        logger.e('[OneSignal] Endpoint error ${resp.statusCode}: ${resp.body}');
      }
    } catch (e, st) {
      logger.e('[OneSignal] HTTP send error', error: e, stackTrace: st);
      // On network failure keep queued (re-add) for retry.
      _pending.add(_PendingNotification(userIds, title, content, data ?? {}));
      _scheduleDelayedFlush();
    }
  }

  // Backward compatibility for existing code still calling sendNotification.
  @Deprecated(
    'Use sendNotificationViaBackend which routes through secure backend.',
  )
  Future<void> sendNotification({
    required List<String> userIds,
    required String title,
    required String content,
    Map<String, dynamic>? data,
  }) => sendNotificationViaBackend(
    userIds: userIds,
    title: title,
    content: content,
    data: data,
  );

  /// Debug helper: collects OneSignal state & prints to logger.
  Future<Map<String, dynamic>> debugStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    String? externalId;
    String? pushId;
    bool? optedIn;
    try {
      externalId = await OneSignal.User.getExternalId();
    } catch (e) {
      externalId = 'ERR:$e';
    }
    try {
      pushId = OneSignal.User.pushSubscription.id;
      optedIn = OneSignal.User.pushSubscription.optedIn;
    } catch (_) {}
    bool? permissionGranted; // not available directly here
    final m = {
      'appId': _appId,
      'endpointConfigured': _resolvedEndpoint.isNotEmpty,
      'currentUid': user?.uid,
      'externalUserId': externalId,
      'pushId': pushId,
      'optedIn': optedIn,
      'permissionGranted': permissionGranted,
      'initialized': _initialized,
      'pendingQueue': _pending.length,
    };
    logger.i('[OneSignal][DEBUG] $m');
    return m;
  }

  // Convenience: send test notification to current user (if signed-in).
  Future<void> sendTestToSelf({
    String title = 'Test',
    String content = 'Notification debug',
  }) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      logger.w('[OneSignal] Cannot send test – no signed-in user');
      return;
    }
    await sendNotificationViaBackend(
      userIds: [uid],
      title: title,
      content: content,
      data: {'t': 'self_test'},
    );
  }

  Future<bool> _isLikelySubscribed() async {
    try {
      final optedIn = OneSignal.User.pushSubscription.optedIn;
      final id = OneSignal.User.pushSubscription.id;
      return optedIn == true && (id?.isNotEmpty ?? false);
    } catch (_) {
      return false; // Before initialization or API differences.
    }
  }

  void _scheduleDelayedFlush() {
    if (_flushing || _pending.isEmpty) return;
    Future.delayed(const Duration(seconds: 4), _flushPending);
  }

  Future<void> _flushPending() async {
    if (_flushing) return;
    if (_pending.isEmpty) return;
    final ep = _resolvedEndpoint;
    final subscribed = await _isLikelySubscribed();
    if (ep.isEmpty || !subscribed) {
      // Try again later if still not ready.
      _scheduleDelayedFlush();
      return;
    }
    _flushing = true;
    try {
      logger.i('[OneSignal] Flushing ${_pending.length} queued notifications');
      final copy = List<_PendingNotification>.from(_pending);
      _pending.clear();
      for (final n in copy) {
        await sendNotificationViaBackend(
          userIds: n.userIds,
          title: n.title,
          content: n.content,
          data: n.data,
        );
        await Future.delayed(const Duration(milliseconds: 150));
      }
    } finally {
      _flushing = false;
      if (_pending.isNotEmpty) _scheduleDelayedFlush();
    }
  }
}

class _PendingNotification {
  final List<String> userIds;
  final String title;
  final String content;
  final Map<String, dynamic> data;
  _PendingNotification(this.userIds, this.title, this.content, this.data);
}
