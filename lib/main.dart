import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/firebase_options.dart';
import 'package:training_app/screens/auth_wrapper.dart'; // <--- استيراد الشاشة الجديدة

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Training App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Cairo',
      ),
      debugShowCheckedModeBanner: false,
      // ببساطة، الشاشة الرئيسية هي الـ AuthWrapper
      // وهو سيتولى باقي العمل
      home: const AuthWrapper(),
    );
  }
}