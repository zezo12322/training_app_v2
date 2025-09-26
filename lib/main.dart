import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/firebase_options.dart';
import 'package:training_app/screens/auth_wrapper.dart';
import 'package:training_app/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize configuration service
  try {
    await AppConfig.initialize();
    AppConfig.instance.logConfiguration();
  } catch (e) {
    print('Warning: Could not load .env file. Using default configuration. Error: $e');
  }
  
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
      title: AppConfig.instance.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Cairo',
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
    );
  }
}