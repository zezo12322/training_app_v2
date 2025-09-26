import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

// 1. Provider to expose an instance of AuthService (لا تغيير هنا)
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// 2. StreamProvider to listen to authentication state changes (لا تغيير هنا)
final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

// 3. ✨ Provider جديد لجلب بيانات المستخدم الحالي ✨
// هذا هو الجزء الأهم في الحل
// FutureProvider سيقوم بجلب البيانات مرة واحدة وعرضها
final currentUserProvider = FutureProvider<DocumentSnapshot?>((ref) {
  // نستمع لحالة تسجيل الدخول
  final user = ref.watch(authStateProvider).value;
  if (user != null) {
    // إذا كان المستخدم مسجلاً، اذهب واجلب بياناته من AuthService
    return ref.read(authServiceProvider).getUserDetails();
  }
  return null;
});