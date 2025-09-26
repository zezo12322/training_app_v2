import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OneSignalNotificationService {
  // --- ضع مفاتيح OneSignal هنا ---
  final String _appId = 'c89cafa8-1e04-4b6a-bcf8-43ccae9c37cd'; // 🚨 استبدل هذا
  final String _restApiKey = 'os_v2_app_zcok7ka6arfwvphyipgk5hbxzxky5pdoeonunzfxwia2ankigt6jqlhohcrme4hvpk7xdqe5tzhzg5buv7cems6imzspzamtbwxkyai'; // 🚨 استبدل هذا

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
  Future<void> sendNotification({
    required List<String> playerIds,
    required String title,
    required String content,
  }) async {
    if (playerIds.isEmpty) return;

    try {
      await http.post(
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
      print('OneSignal: Notification sent successfully to ${playerIds.length} users.');
    } catch (e) {
      print('OneSignal: Error sending notification: $e');
    }
  }
}