import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sso_provider.dart';
import '../models/user_model.dart';
import '../core/logging.dart';

/// خدمة تسجيل الدخول الموحد (SSO)
class SSOService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  SSOService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  /// تسجيل الدخول بـ Google
  Future<SSOLoginResult> signInWithGoogle({
    String? institutionId,
    String? companyId,
  }) async {
    try {
      // بدء عملية تسجيل الدخول
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        // المستخدم ألغى تسجيل الدخول
        return const SSOLoginResult(
          success: false,
          provider: SSOProviderType.google,
          errorMessage: 'تم إلغاء تسجيل الدخول',
        );
      }

      // الحصول على بيانات المصادقة
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // إنشاء credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // تسجيل الدخول إلى Firebase
      final UserCredential userCredential = 
          await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user == null) {
        return const SSOLoginResult(
          success: false,
          provider: SSOProviderType.google,
          errorMessage: 'فشل تسجيل الدخول',
        );
      }

      // التحقق من إعدادات SSO
      if (institutionId != null) {
        final settings = await getSSOSettings(institutionId);
        
        if (!settings.googleEnabled) {
          await _auth.signOut();
          await _googleSignIn.signOut();
          return const SSOLoginResult(
            success: false,
            provider: SSOProviderType.google,
            errorMessage: 'تسجيل الدخول بـ Google غير مفعل',
          );
        }

        // التحقق من المجال المسموح
        if (settings.allowedDomains.isNotEmpty && user.email != null) {
          final emailDomain = user.email!.split('@').last;
          if (!settings.allowedDomains.contains(emailDomain)) {
            await _auth.signOut();
            await _googleSignIn.signOut();
            return SSOLoginResult(
              success: false,
              provider: SSOProviderType.google,
              errorMessage: 'المجال ${emailDomain} غير مسموح',
            );
          }
        }

        // إنشاء/تحديث المستخدم
        if (settings.autoCreateAccount) {
          await _createOrUpdateUser(
            user: user,
            provider: SSOProviderType.google,
            institutionId: institutionId,
            companyId: companyId,
            defaultRole: settings.defaultRole,
          );
        }
      }

      logger.i('Google Sign-In successful: ${user.email}');

      return SSOLoginResult(
        success: true,
        provider: SSOProviderType.google,
        userId: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
    } catch (e, stackTrace) {
      logger.e('Google Sign-In error', error: e, stackTrace: stackTrace);
      return SSOLoginResult(
        success: false,
        provider: SSOProviderType.google,
        errorMessage: e.toString(),
      );
    }
  }

  /// تسجيل الدخول بـ Apple
  Future<SSOLoginResult> signInWithApple({
    String? institutionId,
    String? companyId,
  }) async {
    try {
      // التحقق من التوفر
      final isAvailable = await SignInWithApple.isAvailable();
      
      if (!isAvailable) {
        return const SSOLoginResult(
          success: false,
          provider: SSOProviderType.apple,
          errorMessage: 'تسجيل الدخول بـ Apple غير متوفر على هذا الجهاز',
        );
      }

      // بدء عملية تسجيل الدخول
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // إنشاء credential لـ Firebase
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      // تسجيل الدخول إلى Firebase
      final UserCredential userCredential = 
          await _auth.signInWithCredential(oauthCredential);

      final User? user = userCredential.user;

      if (user == null) {
        return const SSOLoginResult(
          success: false,
          provider: SSOProviderType.apple,
          errorMessage: 'فشل تسجيل الدخول',
        );
      }

      // التحقق من إعدادات SSO
      if (institutionId != null) {
        final settings = await getSSOSettings(institutionId);
        
        if (!settings.appleEnabled) {
          await _auth.signOut();
          return const SSOLoginResult(
            success: false,
            provider: SSOProviderType.apple,
            errorMessage: 'تسجيل الدخول بـ Apple غير مفعل',
          );
        }

        // إنشاء/تحديث المستخدم
        if (settings.autoCreateAccount) {
          String? displayName = user.displayName;
          
          // استخدام الاسم من Apple إذا كان متوفراً
          if (credential.givenName != null || credential.familyName != null) {
            displayName = '${credential.givenName ?? ''} ${credential.familyName ?? ''}'.trim();
          }

          await _createOrUpdateUser(
            user: user,
            provider: SSOProviderType.apple,
            institutionId: institutionId,
            companyId: companyId,
            defaultRole: settings.defaultRole,
            customDisplayName: displayName,
          );
        }
      }

      logger.i('Apple Sign-In successful: ${user.email}');

      return SSOLoginResult(
        success: true,
        provider: SSOProviderType.apple,
        userId: user.uid,
        email: credential.email ?? user.email,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        idToken: credential.identityToken,
      );
    } catch (e, stackTrace) {
      logger.e('Apple Sign-In error', error: e, stackTrace: stackTrace);
      return SSOLoginResult(
        success: false,
        provider: SSOProviderType.apple,
        errorMessage: e.toString(),
      );
    }
  }

  /// تسجيل الخروج
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      logger.i('User signed out');
    } catch (e) {
      logger.e('Sign out error', error: e);
    }
  }

  /// إنشاء أو تحديث المستخدم في Firestore
  Future<void> _createOrUpdateUser({
    required User user,
    required SSOProviderType provider,
    required String institutionId,
    String? companyId,
    String defaultRole = 'trainee',
    String? customDisplayName,
  }) async {
    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        // إنشاء مستخدم جديد
        final newUser = AppUser(
          id: user.uid,
          email: user.email ?? '',
          name: customDisplayName ?? user.displayName ?? user.email ?? 'مستخدم',
          role: defaultRole,
          institutionId: institutionId,
          companyId: companyId,
          imageUrl: user.photoURL,
          createdAt: DateTime.now(),
        );

        await _firestore.collection('users').doc(user.uid).set(newUser.toJson());
        logger.i('New SSO user created: ${user.uid}');
      } else {
        // تحديث بيانات المستخدم
        await _firestore.collection('users').doc(user.uid).update({
          'imageUrl': user.photoURL,
          'lastLoginAt': FieldValue.serverTimestamp(),
        });
        logger.i('SSO user updated: ${user.uid}');
      }
    } catch (e) {
      logger.e('Error creating/updating user', error: e);
    }
  }

  /// جلب إعدادات SSO للمؤسسة
  Future<SSOSettings> getSSOSettings(String institutionId) async {
    try {
      final doc = await _firestore
          .collection('sso_settings')
          .doc(institutionId)
          .get();

      if (!doc.exists) {
        // إعدادات افتراضية
        return SSOSettings(institutionId: institutionId);
      }

      return SSOSettings.fromJson(doc.data()!);
    } catch (e) {
      logger.e('Error fetching SSO settings', error: e);
      return SSOSettings(institutionId: institutionId);
    }
  }

  /// حفظ إعدادات SSO
  Future<bool> saveSSOSettings(SSOSettings settings) async {
    try {
      await _firestore
          .collection('sso_settings')
          .doc(settings.institutionId)
          .set(settings.toJson());
      logger.i('SSO settings saved for: ${settings.institutionId}');
      return true;
    } catch (e) {
      logger.e('Error saving SSO settings', error: e);
      return false;
    }
  }

  /// التحقق من حالة تسجيل الدخول
  bool isSignedIn() {
    return _auth.currentUser != null;
  }

  /// الحصول على المستخدم الحالي
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
