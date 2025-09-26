import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Training App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Cairo', // سنضيف هذا الخط في الخطوة التالية

        // --- تطبيق مجموعة الألوان الجديدة ---
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2176FF), // الأزرق الأساسي
          primary: const Color(0xFF2176FF),   // الأزرق الأساسي
          secondary: const Color(0xFFF79824), // البرتقالي كلون ثانوي
          brightness: Brightness.light,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2176FF), // لون شريط العنوان
          foregroundColor: Colors.white,      // لون النص والأيقونات في شريط العنوان
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFF79824), // لون الزر العائم
          foregroundColor: Colors.white,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2176FF), // لون الأزرار
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),

        // تغيير لون النصوص الافتراضي
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF31393C)),
          bodyLarge: TextStyle(color: Color(0xFF31393C)),
          titleLarge: TextStyle(color: Color(0xFF31393C)),
        ),

        // تصميم الكروت
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}