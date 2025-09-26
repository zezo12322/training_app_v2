import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../config/app_config.dart';

class OneSignalNotificationService {
  // Use configuration service instead of hardcoded values
  String get _appId => AppConfig.instance.oneSignalAppId;
  String get _restApiKey => AppConfig.instance.oneSignalRestApiKey;

  Future<void> initOneSignal() async {
    // Validate configuration before initializing
    if (_appId.isEmpty) {
      print('OneSignal: App ID not configured. Please set ONESIGNAL_APP_ID in .env file');
      return;
    }

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

  // Send notification with proper error handling and validation
  Future<void> sendNotification({
    required List<String> playerIds,
    required String title,
    required String content,
  }) async {
    if (playerIds.isEmpty) {
      print('OneSignal: No player IDs provided for notification');
      return;
    }

    if (_restApiKey.isEmpty) {
      print('OneSignal: REST API Key not configured. Please set ONESIGNAL_REST_API_KEY in .env file');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://onesignal.com/api/v1/notifications'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Basic $_restApiKey',
        },
        body: jsonEncode(<String, dynamic>{
          "app_id": _appId,
          "include_player_ids": playerIds,
          "headings": {"en": title},
          "contents": {"en": content},
        }),
      );

      if (response.statusCode == 200) {
        print('OneSignal: Notification sent successfully to ${playerIds.length} users.');
      } else {
        print('OneSignal: Failed to send notification. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('OneSignal: Error sending notification: $e');
    }
  }
}