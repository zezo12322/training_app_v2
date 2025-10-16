import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../core/logging.dart';
import 'navigation_service.dart';

/// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.i('[FCM] Background message: ${message.messageId}');
}

class FcmNotificationService {
  static final FcmNotificationService _instance = FcmNotificationService._internal();
  factory FcmNotificationService() => _instance;
  FcmNotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = 
      FlutterLocalNotificationsPlugin();

  String? _fcmToken;
  bool _initialized = false;

  /// Initialize FCM
  Future<void> initialize() async {
    if (_initialized) {
      logger.t('[FCM] Already initialized');
      return;
    }

    try {
      // Request permission
      final settings = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      logger.i('[FCM] Permission status: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        // Get FCM token
        _fcmToken = await _messaging.getToken();
        logger.i('[FCM] Token: $_fcmToken');

        // Save token to Firestore
        await _saveTokenToFirestore(_fcmToken);

        // Listen for token refresh
        _messaging.onTokenRefresh.listen(_saveTokenToFirestore);

        // Configure local notifications
        await _configureLocalNotifications();

        // Set up message handlers
        _setupMessageHandlers();

        // Set background message handler
        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

        _initialized = true;
        logger.i('[FCM] Initialization complete');
      } else {
        logger.w('[FCM] Permission denied');
      }
    } catch (e, st) {
      logger.e('[FCM] Initialization error', error: e, stackTrace: st);
    }
  }

  /// Configure local notifications for Android
  Future<void> _configureLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create Android notification channel
    const androidChannel = AndroidNotificationChannel(
      'high_importance_channel',
      'إشعارات مهمة',
      description: 'إشعارات التطبيق المهمة',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  /// Setup message handlers
  void _setupMessageHandlers() {
    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.i('[FCM] Foreground message: ${message.notification?.title}');
      _showLocalNotification(message);
    });

    // Message opened app from background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i('[FCM] Message opened app: ${message.data}');
      _handleNotificationTap(message.data);
    });

    // Check if app was opened from a terminated state
    _messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        logger.i('[FCM] App opened from terminated state: ${message.data}');
        _handleNotificationTap(message.data);
      }
    });
  }

  /// Show local notification when app is in foreground
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'إشعارات مهمة',
            channelDescription: 'إشعارات التطبيق المهمة',
            importance: Importance.high,
            priority: Priority.high,
            icon: android?.smallIcon ?? '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    if (response.payload != null) {
      final data = jsonDecode(response.payload!);
      _handleNotificationTap(data);
    }
  }

  /// Handle notification tap navigation
  void _handleNotificationTap(Map<String, dynamic> data) {
    logger.i('[FCM] Handling notification tap: $data');
    
    // Navigate using NavigationService
    final navigationService = NavigationService();
    navigationService.handleNotificationNavigation(data);
  }

  /// Save FCM token to Firestore
  Future<void> _saveTokenToFirestore(String? token) async {
    if (token == null) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // استخدام set مع merge بدل update عشان مايفشلش لو الـ document مش موجود
      await _firestore.collection('users').doc(user.uid).set({
        'fcmToken': token,
        'fcmTokenUpdatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      logger.i('[FCM] Token saved to Firestore');
    } catch (e, st) {
      logger.e('[FCM] Error saving token', error: e, stackTrace: st);
    }
  }

  /// Get current FCM token
  Future<String?> getToken() async {
    if (_fcmToken != null) return _fcmToken;
    _fcmToken = await _messaging.getToken();
    return _fcmToken;
  }

  /// Delete FCM token (for logout)
  Future<void> deleteToken() async {
    try {
      await _messaging.deleteToken();
      _fcmToken = null;
      
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'fcmToken': FieldValue.delete(),
        });
      }
      
      logger.i('[FCM] Token deleted');
    } catch (e, st) {
      logger.e('[FCM] Error deleting token', error: e, stackTrace: st);
    }
  }

  /// Send notification to specific users
  /// Note: This requires Firebase Cloud Functions to send notifications
  /// The function name should be 'sendNotification'
  Future<void> sendNotification({
    required List<String> userIds,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    if (userIds.isEmpty) return;

    try {
      // Get FCM tokens for users
      final tokens = await _getTokensForUsers(userIds);
      if (tokens.isEmpty) {
        logger.w('[FCM] No tokens found for users');
        return;
      }

      logger.i('[FCM] Sending notification to ${tokens.length} users');
      
      // In production, you would call a Cloud Function here
      // For now, we'll log the notification
      logger.i('[FCM] Title: $title');
      logger.i('[FCM] Body: $body');
      logger.i('[FCM] Data: $data');
      logger.i('[FCM] Tokens: ${tokens.length}');
      
      // Note: Cloud Functions are implemented in functions/index.js
      // They automatically send FCM notifications on Firestore triggers
      // This method is kept for manual notifications if needed
      
    } catch (e, st) {
      logger.e('[FCM] Error sending notification', error: e, stackTrace: st);
    }
  }

  /// Get FCM tokens for specific users
  Future<List<String>> _getTokensForUsers(List<String> userIds) async {
    try {
      final tokens = <String>[];
      
      // Firestore has a limit of 10 items for 'in' queries
      // So we need to batch the requests
      for (var i = 0; i < userIds.length; i += 10) {
        final batch = userIds.skip(i).take(10).toList();
        final docs = await _firestore
            .collection('users')
            .where(FieldPath.documentId, whereIn: batch)
            .get();
        
        for (final doc in docs.docs) {
          final token = doc.data()['fcmToken'] as String?;
          if (token != null && token.isNotEmpty) {
            tokens.add(token);
          }
        }
      }
      
      return tokens;
    } catch (e, st) {
      logger.e('[FCM] Error getting tokens', error: e, stackTrace: st);
      return [];
    }
  }

  /// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      logger.i('[FCM] Subscribed to topic: $topic');
    } catch (e, st) {
      logger.e('[FCM] Error subscribing to topic', error: e, stackTrace: st);
    }
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      logger.i('[FCM] Unsubscribed from topic: $topic');
    } catch (e, st) {
      logger.e('[FCM] Error unsubscribing from topic', error: e, stackTrace: st);
    }
  }
}
