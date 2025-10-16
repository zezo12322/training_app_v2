# ⚡ خطة العمل الفورية - 48 ساعة
# Immediate Action Plan - Launch Ready in 48 Hours

**تاريخ الإنشاء**: 16 أكتوبر 2025  
**الهدف**: الوصول من 84/100 إلى 90/100 (Soft Launch Ready)  
**الوقت المتوقع**: 8-13 ساعة عمل

---

## 📊 Current Status: 84/100

**ما يعمل بشكل ممتاز**:
- ✅ Course Wall (Flagship Feature!)
- ✅ Gamification System
- ✅ Course Management
- ✅ Firestore Security Rules (1046 lines)
- ✅ Multi-tenant Architecture

**ما يحتاج إصلاح فوري**:
- ❌ Email Verification (أمان)
- ❌ SSO UI Integration (marketing)
- ❌ OneSignal Configuration (notifications)
- ❌ Build Errors (technical blockers)
- ❌ Privacy Policy + Terms (قانوني)

---

## 🎯 Task Breakdown (Prioritized)

### 🔴 Task 1: Fix Build Runner Error
**الوقت**: 1 ساعة  
**الأولوية**: CRITICAL (يمنع التطوير)  
**الحالة**: ⬜ Not Started

**الخطأ الحالي**:
```
Terminal: powershell
Last Command: Remove-Item lib/providers/gamification/*.g.dart -ErrorAction SilentlyContinue; dart run build_runner build --delete-conflicting-outputs
Exit Code: 1
```

**الحل**:
```powershell
# Step 1: Clean everything
flutter clean
Remove-Item -Recurse -Force build/
Remove-Item lib/**/*.g.dart, lib/**/*.freezed.dart -Recurse -Force -ErrorAction SilentlyContinue

# Step 2: Get dependencies
flutter pub get

# Step 3: Run build_runner
dart run build_runner build --delete-conflicting-outputs

# Step 4: If still fails, check for conflicts:
dart run build_runner build --delete-conflicting-outputs --verbose
```

**Success Criteria**: ✅ Exit Code: 0, all .g.dart and .freezed.dart files generated

**Troubleshooting**:
- إذا ظهر error "conflicting outputs": حذف الملفات يدوياً ثم إعادة المحاولة
- إذا ظهر error "version conflict": تحديث `build_runner` في pubspec.yaml

---

### 🔴 Task 2: Fix Flutter Run Error
**الوقت**: 1-2 ساعة  
**الأولوية**: CRITICAL (يمنع الاختبار)  
**الحالة**: ⬜ Not Started

**الخطأ الحالي**:
```
Terminal: powershell
Last Command: flutter run -d CPH2059
Exit Code: 1
```

**خطوات التشخيص**:
```powershell
# Step 1: Check device
flutter devices

# Step 2: Run with verbose output
flutter run -d CPH2059 --verbose

# Step 3: Check for common issues
flutter doctor -v

# Step 4: Clean and rebuild
flutter clean
flutter pub get
flutter run -d CPH2059
```

**الأخطاء الشائعة والحلول**:

1. **Gradle Build Failed** (Android):
   ```bash
   cd android
   ./gradlew clean
   cd ..
   flutter run -d CPH2059
   ```

2. **Permissions Missing**:
   - تحقق من `android/app/src/main/AndroidManifest.xml`
   - أضف permissions للـ notifications, camera, storage

3. **Build Number Conflict**:
   - تحديث `version` في `pubspec.yaml`

**Success Criteria**: ✅ App runs successfully on device

---

### 🔴 Task 3: Email Verification
**الوقت**: 2-3 ساعات  
**الأولوية**: HIGH (Security)  
**الحالة**: ⬜ Not Started

**الملفات المطلوب تعديلها**:
1. `lib/services/auth_service.dart`
2. `lib/screens/email_verification_screen.dart` (جديد)
3. `lib/screens/auth_wrapper.dart`

#### Step 1: تعديل Auth Service

**File**: `lib/services/auth_service.dart`

```dart
// بعد السطر 30 (بعد Sign Up):

Future<UserCredential?> signUpWithEmail(
  String email,
  String password,
  String name,
  String role,
) async {
  try {
    UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);
    
    // ✅ إرسال Email Verification
    await userCredential.user!.sendEmailVerification();
    
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'name': name,
      'email': email,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
      'emailVerified': false, // NEW FIELD
    });
    
    return userCredential;
  } catch (e) {
    rethrow;
  }
}

// إضافة دالة جديدة للتحقق
Future<void> sendVerificationEmail() async {
  final user = _auth.currentUser;
  if (user != null && !user.emailVerified) {
    await user.sendEmailVerification();
  }
}

// إضافة دالة لتحديث حالة التحقق
Future<void> checkEmailVerified() async {
  final user = _auth.currentUser;
  if (user != null) {
    await user.reload(); // Refresh user state
    if (user.emailVerified) {
      // تحديث Firestore
      await _firestore.collection('users').doc(user.uid).update({
        'emailVerified': true,
      });
    }
  }
}
```

#### Step 2: إنشاء Email Verification Screen

**File**: `lib/screens/email_verification_screen.dart` (جديد)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../core/l10n_ext.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  ConsumerState<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends ConsumerState<EmailVerificationScreen> {
  bool _isChecking = false;
  bool _isResending = false;

  Future<void> _checkVerification() async {
    setState(() => _isChecking = true);
    try {
      final authService = ref.read(authRepositoryProvider);
      await authService.checkEmailVerified();
      
      // Reload auth state
      final user = ref.read(authStateProvider).value;
      await user?.reload();
      
      if (user?.emailVerified == true) {
        // العودة للـ AuthWrapper (سيعيد التوجيه تلقائياً)
        if (!mounted) return;
        Navigator.of(context).pop();
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('البريد لم يتم التحقق منه بعد')),
        );
      }
    } finally {
      if (mounted) setState(() => _isChecking = false);
    }
  }

  Future<void> _resendEmail() async {
    setState(() => _isResending = true);
    try {
      final authService = ref.read(authRepositoryProvider);
      await authService.sendVerificationEmail();
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال رابط التحقق إلى بريدك الإلكتروني'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).value;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('التحقق من البريد الإلكتروني'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authRepositoryProvider).signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.email_outlined,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                'تحقق من بريدك الإلكتروني',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'أرسلنا رابط التحقق إلى:\n${user?.email}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                'الرجاء فتح البريد والضغط على رابط التحقق',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: _isChecking ? null : _checkVerification,
                icon: _isChecking
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.refresh),
                label: Text(_isChecking ? 'جاري التحقق...' : 'لقد تحققت من البريد'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _isResending ? null : _resendEmail,
                child: Text(_isResending ? 'جاري الإرسال...' : 'إعادة إرسال البريد'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

#### Step 3: تعديل Auth Wrapper

**File**: `lib/screens/auth_wrapper.dart`

```dart
// إضافة import في الأعلى:
import 'email_verification_screen.dart';

// داخل build() - بعد السطر 60:
return authState.when(
  data: (user) {
    if (user == null) return const LoginScreen();

    // ✅ NEW: Check email verification
    if (!user.emailVerified) {
      return const EmailVerificationScreen();
    }

    // ... باقي الكود كما هو
```

**Success Criteria**:
- ✅ رسالة verification تُرسل بعد Sign Up
- ✅ المستخدم يُوجّه لـ EmailVerificationScreen
- ✅ بعد التحقق، يُوجّه للـ Dashboard

**Testing**:
1. إنشاء حساب جديد
2. التحقق من استلام البريد
3. الضغط على رابط التحقق
4. العودة للتطبيق والضغط "لقد تحققت من البريد"
5. التأكد من التوجيه للـ Dashboard

---

### 🟠 Task 4: SSO Integration في UI
**الوقت**: 1-2 ساعة  
**الأولوية**: HIGH (Marketing Feature)  
**الحالة**: ⬜ Not Started

**الملفات المطلوب تعديلها**:
1. `lib/screens/login_screen.dart`
2. `lib/screens/signup_screen.dart` (اختياري)

#### تعديل Login Screen

**File**: `lib/screens/login_screen.dart`

```dart
// إضافة imports في الأعلى:
import '../services/sso_service.dart';
import '../screens/sso_login_screen.dart';
import 'dart:io' show Platform;

// إضافة provider:
final ssoServiceProvider = Provider<SSOService>((ref) => SSOService());

// إضافة state للـ loading:
bool _isSSOLoading = false;

// إضافة دوال SSO:
Future<void> _signInWithGoogle() async {
  setState(() => _isSSOLoading = true);
  try {
    final service = ref.read(ssoServiceProvider);
    final result = await service.signInWithGoogle();
    
    if (!mounted) return;
    
    if (result.success) {
      // Success - AuthWrapper سيتعامل مع التوجيه
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('مرحباً ${result.displayName ?? result.email}!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.errorMessage ?? 'فشل تسجيل الدخول'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } finally {
    if (mounted) setState(() => _isSSOLoading = false);
  }
}

Future<void> _signInWithApple() async {
  setState(() => _isSSOLoading = true);
  try {
    final service = ref.read(ssoServiceProvider);
    final result = await service.signInWithApple();
    
    if (!mounted) return;
    
    if (result.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('مرحباً ${result.displayName ?? result.email}!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.errorMessage ?? 'فشل تسجيل الدخول'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } finally {
    if (mounted) setState(() => _isSSOLoading = false);
  }
}

// داخل build() - بعد TextButton للـ Sign Up (السطر ~160):
const SizedBox(height: 24),
const Row(
  children: [
    Expanded(child: Divider()),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text('أو', style: TextStyle(color: Colors.grey)),
    ),
    Expanded(child: Divider()),
  ],
),
const SizedBox(height: 16),
Text(
  'سجّل دخول بواسطة',
  style: TextStyle(fontSize: 16, color: Colors.grey),
  textAlign: TextAlign.center,
),
const SizedBox(height: 12),

// Google Sign-In Button
OutlinedButton.icon(
  onPressed: (_isLoading || _isSSOLoading) ? null : _signInWithGoogle,
  style: OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    side: BorderSide(color: Colors.grey.shade300),
  ),
  icon: _isSSOLoading
      ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
      : Image.network(
          'https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg',
          height: 24,
          errorBuilder: (_, __, ___) => const Icon(Icons.g_mobiledata, size: 32),
        ),
  label: const Text('Google', style: TextStyle(fontSize: 16)),
),

const SizedBox(height: 12),

// Apple Sign-In Button (iOS only)
if (Platform.isIOS)
  OutlinedButton.icon(
    onPressed: (_isLoading || _isSSOLoading) ? null : _signInWithApple,
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      side: BorderSide(color: Colors.grey.shade300),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    icon: const Icon(Icons.apple, size: 28),
    label: const Text('Apple', style: TextStyle(fontSize: 16)),
  ),
```

**Success Criteria**:
- ✅ زر Google Sign-In يظهر في LoginScreen
- ✅ زر Apple Sign-In يظهر في iOS فقط
- ✅ عند الضغط، يتم تسجيل الدخول بنجاح
- ✅ Loading indicator يظهر أثناء العملية

---

### 🟠 Task 5: OneSignal Configuration
**الوقت**: 1 ساعة  
**الأولوية**: MEDIUM (Notifications)  
**الحالة**: ⬜ Not Started

**الخطوات**:

#### Step 1: الحصول على OneSignal App ID

1. افتح https://onesignal.com/
2. سجّل دخول / إنشاء حساب
3. Create New App
4. اختر Flutter
5. انسخ App ID

#### Step 2: تكوين التطبيق

**Option 1: عبر --dart-define** (موصى به):

في VSCode → `.vscode/launch.json`:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter (Development)",
      "request": "launch",
      "type": "dart",
      "args": [
        "--dart-define=ONE_SIGNAL_APP_ID=c89cafa8-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        "--dart-define=NOTIF_ENDPOINT=https://onesignal-worker.tadreeblink.workers.dev"
      ]
    }
  ]
}
```

**Option 2: في app_config.dart** (للـ testing):

```dart
// lib/config/app_config.dart
const String _oneSignalAppIdFallback = 'c89cafa8-1e04-4b6a-bcf8-43ccae9c37cd'; // ضع App ID الحقيقي
```

#### Step 3: تكوين Android

**File**: `android/app/build.gradle`

تأكد من وجود:
```gradle
defaultConfig {
    minSdkVersion 21 // OneSignal يحتاج 21+
}
```

#### Step 4: تكوين iOS

**File**: `ios/Runner/Info.plist`

أضف:
```xml
<key>UIBackgroundModes</key>
<array>
  <string>remote-notification</string>
</array>
```

**Success Criteria**:
- ✅ OneSignal يُهيّأ بدون errors
- ✅ Device يسجّل في OneSignal
- ✅ Notification تصل عند نشر منشور جديد

---

### 🟡 Task 6: Privacy Policy + Terms of Service
**الوقت**: 2-3 ساعات  
**الأولوية**: MEDIUM (Legal)  
**الحالة**: ⬜ Not Started

#### Step 1: إنشاء الملفات

**File 1**: `assets/legal/privacy_policy_ar.md`

```markdown
# سياسة الخصوصية

**تاريخ السريان**: 16 أكتوبر 2025

## 1. المقدمة
نحن في [اسم الشركة] نلتزم بحماية خصوصيتك...

## 2. البيانات التي نجمعها
- الاسم
- البريد الإلكتروني
- بيانات الدورات التدريبية
- بيانات التقدم والنقاط

## 3. كيف نستخدم البيانات
- تقديم خدمات المنصة
- تحسين تجربة المستخدم
- إرسال الإشعارات

## 4. مشاركة البيانات
لا نشارك بياناتك مع أطراف ثالثة إلا في الحالات التالية:
- بموافقتك الصريحة
- للامتثال للقوانين

## 5. أمان البيانات
نستخدم Firebase وتشفير SSL لحماية بياناتك

## 6. حقوقك
- الوصول لبياناتك
- تصحيح البيانات
- حذف الحساب

## 7. التواصل
[email@example.com]
```

**File 2**: `assets/legal/terms_of_service_ar.md`

```markdown
# شروط الاستخدام

**تاريخ السريان**: 16 أكتوبر 2025

## 1. قبول الشروط
باستخدام هذه المنصة، أنت توافق على هذه الشروط...

## 2. الحسابات
- يجب أن تكون 18+ سنة
- معلومات دقيقة وحقيقية
- مسؤول عن أمان حسابك

## 3. المحتوى
- لا تنشر محتوى مسيء
- لا تنتهك حقوق الملكية
- نحتفظ بحق حذف المحتوى غير المناسب

## 4. الدفع والاشتراكات
- الأسعار قابلة للتغيير بإشعار مسبق
- لا استرداد للمبالغ إلا في حالات محددة

## 5. إنهاء الخدمة
نحتفظ بالحق في تعليق أو إنهاء الحسابات...

## 6. إخلاء المسؤولية
الخدمة "كما هي" بدون ضمانات...

## 7. القانون الحاكم
القانون المصري

## 8. التواصل
[email@example.com]
```

#### Step 2: إنشاء الشاشات

**File**: `lib/screens/privacy_policy_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سياسة الخصوصية')),
      body: FutureBuilder<String>(
        future: rootBundle.loadString('assets/legal/privacy_policy_ar.md'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Markdown(data: snapshot.data!);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
```

**File**: `lib/screens/terms_of_service_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('شروط الاستخدام')),
      body: FutureBuilder<String>(
        future: rootBundle.loadString('assets/legal/terms_of_service_ar.md'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Markdown(data: snapshot.data!);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
```

#### Step 3: إضافة الروابط

في `LoginScreen` و `SignupScreen`:

```dart
// في أسفل الشاشة:
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
        );
      },
      child: const Text('سياسة الخصوصية', style: TextStyle(fontSize: 12)),
    ),
    const Text('•', style: TextStyle(color: Colors.grey)),
    TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TermsOfServiceScreen()),
        );
      },
      child: const Text('شروط الاستخدام', style: TextStyle(fontSize: 12)),
    ),
  ],
)
```

#### Step 4: إضافة flutter_markdown

**File**: `pubspec.yaml`

```yaml
dependencies:
  flutter_markdown: ^0.7.4
```

```bash
flutter pub get
```

**Success Criteria**:
- ✅ ملفات Privacy Policy و Terms موجودة
- ✅ الشاشات تعرض المحتوى بشكل صحيح
- ✅ روابط في Login/Signup تعمل

---

## ✅ Checklist للمتابعة

### Day 1 (4-6 ساعات):
- [ ] Task 1: Fix Build Runner ✅ (1h)
- [ ] Task 2: Fix Flutter Run ✅ (1-2h)
- [ ] Task 3: Email Verification ✅ (2-3h)

### Day 2 (4-7 ساعات):
- [ ] Task 4: SSO Integration ✅ (1-2h)
- [ ] Task 5: OneSignal Config ✅ (1h)
- [ ] Task 6: Privacy Policy ✅ (2-3h)
- [ ] Testing شامل ✅ (1h)

---

## 🧪 Testing Checklist (بعد إنهاء كل Tasks)

### Email Verification:
- [ ] إنشاء حساب جديد
- [ ] استلام البريد
- [ ] الضغط على رابط التحقق
- [ ] التحقق من التوجيه الصحيح

### SSO:
- [ ] Google Sign-In على Android
- [ ] Google Sign-In على iOS
- [ ] Apple Sign-In على iOS
- [ ] معالجة الأخطاء (cancel, network error)

### OneSignal:
- [ ] Device registration
- [ ] إرسال notification من backend
- [ ] استلام notification على device
- [ ] الضغط على notification يفتح الـ post

### Privacy/Terms:
- [ ] الروابط تعمل
- [ ] المحتوى يُعرض صحيحاً
- [ ] Markdown formatting صحيح

---

## 🚀 بعد إنهاء كل Tasks

### التأكد من النتيجة:
```bash
# Build للتأكد
flutter clean
flutter pub get
flutter build apk --debug

# Run على device
flutter run -d CPH2059
```

### Deployment Checklist:
- [ ] Firebase Firestore Rules deployed ✅ (موجود)
- [ ] Cloud Functions deployed ✅ (موجود)
- [ ] App tested on Android
- [ ] App tested on iOS
- [ ] OneSignal notifications working

---

## 📊 Score Tracker

| Task | Status | Score Impact |
|------|--------|--------------|
| Build Runner Fix | ⬜ | +2 points |
| Flutter Run Fix | ⬜ | +2 points |
| Email Verification | ⬜ | +3 points |
| SSO Integration | ⬜ | +2 points |
| OneSignal Config | ⬜ | +1 point |
| Privacy/Terms | ⬜ | +2 points |

**Current**: 84/100  
**Target**: 90/100 ✅  
**After All Tasks**: 96/100 🎉

---

**تاريخ البدء المتوقع**: [__/__/____]  
**تاريخ الإنهاء المستهدف**: [__/__/____]  
**النتيجة الفعلية**: [____]

**ملاحظات**:
```
[أضف ملاحظاتك هنا أثناء التنفيذ]
```
