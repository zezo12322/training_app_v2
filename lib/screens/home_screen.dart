import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/services/notification_service.dart'; // <<< تعديل الاستيراد
import 'trainer_home_screen.dart';
import 'trainee_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // استدعاء خدمة OneSignal الجديدة
      OneSignalNotificationService().initOneSignal();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(body: Center(child: Text('لم يتم العثور على بيانات المستخدم!')));
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final String userRole = userData['role'] ?? 'trainee';

        if (userRole == 'trainer') {
          return const TrainerHomeScreen();
        } else {
          return const TraineeHomeScreen();
        }
      },
    );
  }
}