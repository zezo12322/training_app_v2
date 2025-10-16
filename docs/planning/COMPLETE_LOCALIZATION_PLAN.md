# خطة كاملة لدعم التطبيق للغتين العربية والإنجليزية

**التاريخ:** 16 أكتوبر 2025  
**آخر تحديث:** 17 أكتوبر 2025  
**الحالة:** � قيد التنفيذ (20% مكتمل)  
**الأولوية:** 🔴 عالية جداً

---

## 🎯 ملخص الإنجازات (Session 1 - 17 أكتوبر)

### ✅ ما تم إنجازه
- ✅ **Python Scripts**: إنشاء أدوات الفحص الآلي
  - `tools/check_l10n_coverage.py` - فحص 491 hard-coded string
  - `tools/compare_arb_files.py` - مقارنة 356 مفتاح في ARB files
  
- ✅ **تدقيق شامل**: 
  - 491 hard-coded string في 69 ملف
  - 394 نص عربي، 97 نص إنجليزي
  - تقرير كامل في `HARDCODED_STRINGS_AUDIT.txt`

- ✅ **إضافة ترجمات جديدة**:
  - 38 مفتاح جديد في `app_ar.arb` و `app_en.arb`
  - 10 Firebase error messages
  - 18 Dialog & Widget strings
  - 10 Screen titles

- ✅ **الملفات المكتملة (8 ملفات)**:
  1. `forgot_password_screen.dart` - 100% localized
  2. `login_screen.dart` - Firebase errors + forgot password link
  3. `signup_screen.dart` - Firebase errors
  4. `email_verification_screen.dart` - Screen title
  5. `privacy_policy_screen.dart` - Screen title
  6. `terms_of_service_screen.dart` - Screen title
  7. `wall_comments_sheet.dart` - 80% (Dialog buttons, reply, edit, delete)
  8. `app_ar.arb` + `app_en.arb` - 38 مفتاح جديد

### 📊 الإحصائيات المحدثة
- **الوقت المستغرق**: 10 ساعات (25% من الخطة)
- **الملفات المحدثة**: 8 ملفات
- **الملفات المتبقية**: 61 ملف (88%)
- **المفاتيح المضافة**: 38 مفتاح جديد
- **المفاتيح الإجمالية**: 394 مفتاح في كل لغة
- **التقدم**: 12% من الملفات مكتملة

### 🎯 الأهداف التالية (Session 2)
1. ✅ ~~تحديث `login_screen.dart`~~ - مكتمل
2. ✅ ~~تحديث `signup_screen.dart`~~ - مكتمل
3. ✅ ~~تحديث Screen titles البسيطة~~ - مكتمل
4. 🔄 إكمال `wall_comments_sheet.dart` - TextField hint
5. ⏳ تحديث `wall_search_bar.dart` - 9 strings
6. ⏳ تحديث `wall_post_card.dart` - 4 strings
7. ⏳ تحديث `reaction_row.dart` - 1 string
8. ⏳ تحديث باقي الـ Widgets الأساسية

---

## 📊 التحليل الحالي

### ✅ ما تم إنجازه
1. **البنية التحتية L10n موجودة:**
   - ملفات ARB: `app_ar.arb` (174 string) و `app_en.arb` (174 string)
   - `l10n.yaml` مُعد بشكل صحيح
   - الملفات المولدة: `lib/l10n/gen/app_localizations.dart`
   - Extension helper: `lib/core/l10n_ext.dart` (context.l)

2. **ميزة تبديل اللغة موجودة:**
   - `lib/providers/locale_provider.dart` (Riverpod StateNotifier)
   - UI في `settings_screen.dart` (زر العربية/English)
   - الحفظ في SharedPreferences

3. **الترجمات الأساسية:**
   - Authentication (login, signup, forgot password): ✅ 90%
   - Navigation labels: ✅ 80%
   - Form fields: ✅ 85%
   - Error messages: ✅ 70%

### ❌ المشاكل الحالية

#### 1. Hard-coded Strings في الكود
```dart
// ❌ أمثلة للمشاكل:
const Text('نسيت كلمة المرور؟')  // login_screen.dart:163
const Text('التحقق من البريد الإلكتروني')  // email_verification_screen.dart:88
const Text('سياسة الخصوصية')  // privacy_policy_screen.dart:58
const Text('🔥')  // progress_card.dart:255
'البريد الإلكتروني أو كلمة المرور غير صحيحة'  // login_screen.dart (Firebase errors)
```

**الملفات المتأثرة:**
- `lib/screens/login_screen.dart` (3 strings)
- `lib/screens/forgot_password_screen.dart` (7 strings)
- `lib/screens/email_verification_screen.dart` (1 string)
- `lib/screens/privacy_policy_screen.dart` (1 string)
- `lib/screens/terms_of_service_screen.dart` (1 string)
- `lib/screens/settings_screen.dart` (2 strings)
- `lib/widgets/wall_comments_sheet.dart` (8 strings)
- `lib/widgets/wall_search_bar.dart` (9 strings)
- `lib/widgets/wall_post_card.dart` (4 strings)
- `lib/widgets/reaction_row.dart` (1 string)

**إجمالي:** ~40 string بحاجة للترجمة

#### 2. Firebase Error Messages Hard-coded بالعربي
```dart
// في 3 ملفات: login_screen, signup_screen, forgot_password_screen
case 'wrong-password':
  errorMessage = 'البريد الإلكتروني أو كلمة المرور غير صحيحة'; // ❌ عربي فقط
```

#### 3. محتوى سياسة الخصوصية وشروط الاستخدام
- `privacy_policy_screen.dart`: النص باللغة العربية فقط
- `terms_of_service_screen.dart`: النص باللغة العربية فقط

#### 4. ترجمات ناقصة في ARB
```bash
# Strings موجودة في app_ar.arb لكن غير مستخدمة:
forgotPasswordNavigate, emailSent, sendResetEmail, backToLogin, etc.
```

#### 5. Direction (RTL/LTR) Issues محتملة
- بعض الـ widgets قد لا تدعم RTL بشكل كامل
- الأيقونات والـ padding قد تحتاج ضبط

---

## 🎯 الأهداف

### هدف قصير المدى (3-5 أيام)
- ✅ إزالة جميع الـ hard-coded strings
- ✅ استخدام l10n لكل النصوص
- ✅ ترجمة Firebase error messages
- ✅ دعم RTL/LTR كامل

### هدف متوسط المدى (1-2 أسبوع)
- ✅ ترجمة سياسة الخصوصية وشروط الاستخدام
- ✅ اختبار شامل للغتين
- ✅ توثيق عملية الترجمة
- ✅ إضافة ترجمات للتطبيق كاملاً

### هدف طويل المدى (مستقبلاً)
- 🔮 دعم لغات إضافية (فرنسي، إسباني)
- 🔮 Context-aware translations
- 🔮 Professional translation review
- 🔮 Automatic translation CI/CD

---

## 📋 خطة العمل التفصيلية

### ✅ المرحلة 1: تدقيق وتحليل (يوم 1) ⏱️ 4 ساعات - **مكتملة**

#### ✅ Task 1.1: فحص شامل للـ hard-coded strings
```bash
# البحث في كل ملفات Dart
grep -r "const Text('" lib/ | grep -v "l\." | grep -v "\.g\.dart"
grep -r 'Text("' lib/ | grep -v "l\." | grep -v "\.g\.dart"
grep -r "errorMessage = '" lib/
```

**التوثيق:**
- ✅ تم إنشاء `HARDCODED_STRINGS_AUDIT.txt`
- ✅ النتيجة: 491 hard-coded string في 69 ملف
- ✅ 394 عربي، 97 إنجليزي

#### ✅ Task 1.2: فحص ملفات ARB
```bash
# مقارنة الكلمات بين app_ar.arb و app_en.arb
python tools/compare_arb_keys.py
```

**Deliverable:**
- ✅ تم المقارنة: 356 مفتاح في كل ملف (متطابقة)
- ✅ 41 قيمة مكررة (مقبولة، لكن يمكن تنظيفها لاحقاً)
- ✅ 310 مفتاح بدون @metadata

#### ✅ Task 1.3: تحديد أولويات الترجمة
**المعايير:**
1. **Critical (P0):** Auth screens, error messages
2. **High (P1):** Main navigation, course wall
3. **Medium (P2):** Settings, profile screens
4. **Low (P3):** Admin panels, advanced features

---

### ✅ المرحلة 2: إعداد البيئة والأدوات (يوم 1) ⏱️ 2 ساعات - **مكتملة**

#### ✅ Task 2.1: إنشاء scripts مساعدة

**`tools/check_l10n_coverage.py`**
```python
#!/usr/bin/env python3
"""
Check l10n coverage across Dart files.
Finds hard-coded strings and suggests l10n keys.
"""
import re
import os
from pathlib import Path

def find_hardcoded_strings(dart_file):
    """Scan Dart file for hard-coded Arabic/English strings."""
    with open(dart_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Pattern: Text('...')  أو  Text("...")
    pattern = r"Text\(['\"]([^'\"]+)['\"]\)"
    matches = re.findall(pattern, content)
    
    # Filter out l10n calls
    hardcoded = [m for m in matches if not m.startswith('l.')]
    return hardcoded

def main():
    lib_path = Path('lib')
    total_hardcoded = 0
    
    for dart_file in lib_path.rglob('*.dart'):
        if '.g.dart' in str(dart_file) or '.freezed.dart' in str(dart_file):
            continue
        
        hardcoded = find_hardcoded_strings(dart_file)
        if hardcoded:
            print(f"\n📄 {dart_file}")
            for string in hardcoded:
                print(f"  ❌ {string}")
                total_hardcoded += 1
    
    print(f"\n\n📊 Total hard-coded strings: {total_hardcoded}")

if __name__ == '__main__':
    main()
```
✅ **تم إنشاء `tools/check_l10n_coverage.py`** - يفحص 491 string بنجاح

**`tools/compare_arb_files.py`**
```python
#!/usr/bin/env python3
"""
Compare app_ar.arb and app_en.arb to find missing keys.
"""
import json
from pathlib import Path

def load_arb(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        data = json.load(f)
    # Filter out @ metadata keys
    return {k: v for k, v in data.items() if not k.startswith('@')}

def main():
    ar_file = Path('lib/l10n/app_ar.arb')
    en_file = Path('lib/l10n/app_en.arb')
    
    ar_data = load_arb(ar_file)
    en_data = load_arb(en_file)
    
    ar_keys = set(ar_data.keys())
    en_keys = set(en_data.keys())
    
    missing_in_en = ar_keys - en_keys
    missing_in_ar = en_keys - ar_keys
    
    print("🔍 ARB File Comparison\n")
    
    if missing_in_en:
        print(f"❌ Missing in English ({len(missing_in_en)}):")
        for key in sorted(missing_in_en):
            print(f"  - {key}: {ar_data[key]}")
    
    if missing_in_ar:
        print(f"\n❌ Missing in Arabic ({len(missing_in_ar)}):")
        for key in sorted(missing_in_ar):
            print(f"  - {key}: {en_data[key]}")
    
    if not missing_in_en and not missing_in_ar:
        print("✅ All keys are present in both files!")
    
    print(f"\n📊 Statistics:")
    print(f"  Arabic strings: {len(ar_keys)}")
    print(f"  English strings: {len(en_keys)}")

if __name__ == '__main__':
    main()
```
✅ **تم إنشاء `tools/compare_arb_files.py`** - يقارن 356 مفتاح بنجاح

#### ✅ Task 2.2: تحديث l10n.yaml
```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb  # Use English as template
output-localization-file: app_localizations.dart
output-class: AppLocalizations
nullable-getter: false  # Force all strings to be non-null
```
✅ **الملف موجود ومُعد بشكل صحيح**

---

### 🔄 المرحلة 3: إضافة الترجمات الناقصة (يوم 2) ⏱️ 6 ساعات - **جاري العمل (30% مكتمل)**

#### ✅ Task 3.1: Firebase Error Messages

**إضافة لـ `app_en.arb`:**
```json
{
  "authErrorWrongPassword": "Email or password is incorrect",
  "authErrorUserNotFound": "Email is not registered",
  "authErrorEmailInUse": "Email is already registered",
  "authErrorInvalidEmail": "Invalid email address",
  "authErrorWeakPassword": "Password is too weak",
  "authErrorUserDisabled": "This account is disabled. Contact support",
  "authErrorTooManyRequests": "Too many attempts. Try again later",
  "authErrorNetworkFailed": "Network connection error",
  "authErrorOperationNotAllowed": "Operation not allowed",
  "authErrorDefault": "An error occurred during authentication"
}
```

**إضافة لـ `app_ar.arb`:**
```json
{
  "authErrorWrongPassword": "البريد الإلكتروني أو كلمة المرور غير صحيحة",
  "authErrorUserNotFound": "البريد الإلكتروني غير مسجل",
  "authErrorEmailInUse": "البريد الإلكتروني مسجل بالفعل",
  "authErrorInvalidEmail": "البريد الإلكتروني غير صحيح",
  "authErrorWeakPassword": "كلمة المرور ضعيفة جداً",
  "authErrorUserDisabled": "هذا الحساب معطل. يرجى التواصل مع الدعم",
  "authErrorTooManyRequests": "محاولات كثيرة. يرجى المحاولة لاحقاً",
  "authErrorNetworkFailed": "خطأ في الاتصال بالإنترنت",
  "authErrorOperationNotAllowed": "العملية غير مسموح بها",
  "authErrorDefault": "حدث خطأ أثناء المصادقة"
}
```
✅ **تم إضافة 10 مفاتيح Firebase errors للـ ARB files**

#### ✅ Task 3.2: Dialog & Widget Strings

**إضافة لكلا الملفين:**
```json
// Dialogs
"dialogConfirmTitle": "Confirm / تأكيد",
"dialogDeleteTitle": "Delete / حذف",
"dialogCancelButton": "Cancel / إلغاء",
"dialogConfirmButton": "Confirm / تأكيد",
"dialogDeleteButton": "Delete / حذف",
"dialogSaveButton": "Save / حفظ",
"dialogCloseButton": "Close / إغلاق",

// Wall Comments
"commentReply": "Reply / رد",
"commentEdit": "Edit / تعديل",
"commentDelete": "Delete / حذف",
"commentDeleteConfirm": "Are you sure? / هل أنت متأكد؟",
"commentDeleteTitle": "Delete Comment / حذف التعليق",

// Wall Search & Filter
"filterPostsTitle": "Filter Posts / تصفية المنشورات",
"sortPostsTitle": "Sort Posts / ترتيب المنشورات",
"filterClearDates": "Clear Dates / مسح التواريخ",
"filterReset": "Reset / إعادة تعيين",
"filterApply": "Apply / تطبيق",
"sortPinnedFirst": "Pinned First / المثبتة أولاً",

// Reactions
"reactionsClose": "Close / إغلاق",

// Common
"loading": "Loading... / جاري التحميل...",
"error": "Error / خطأ",
"success": "Success / نجاح",
"retry": "Retry / إعادة المحاولة"
}
```

#### Task 3.3: Screen Titles

**إضافة لكلا الملفين:**
```json
{
  "emailVerificationTitle": "Email Verification / التحقق من البريد الإلكتروني",
  "privacyPolicyTitle": "Privacy Policy / سياسة الخصوصية",
  "termsOfServiceTitle": "Terms of Service / شروط الاستخدام",
  "settingsTitle": "Settings / الإعدادات",
  "superAdminDashboard": "Super Admin Dashboard",
  "superAdminDashboardSubtitle": "Manage institutions, companies, and settings"
}
```
✅ **تم إضافة 10 مفاتيح Screen Titles للـ ARB files**
✅ **إجمالي المفاتيح الجديدة: 38 مفتاح**

---

### 🔄 المرحلة 4: تحديث الكود (يوم 2-3) ⏱️ 8 ساعات - **جاري العمل (15% مكتمل)**

#### 🔄 Task 4.1: تحديث Authentication Screens

**ملف: `lib/screens/login_screen.dart`**

**قبل:**
```dart
errorMessage = 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
```

**بعد:**
```dart
errorMessage = l.authErrorWrongPassword;
```

**التغييرات الكاملة:**
```dart
on FirebaseAuthException catch (e) {
  String errorMessage;
  switch (e.code) {
    case 'user-not-found':
      errorMessage = l.authErrorUserNotFound;
      break;
    case 'wrong-password':
    case 'invalid-credential':
    case 'invalid-email':
      errorMessage = l.authErrorWrongPassword;
      break;
    case 'user-disabled':
      errorMessage = l.authErrorUserDisabled;
      break;
    case 'too-many-requests':
      errorMessage = l.authErrorTooManyRequests;
      break;
    case 'network-request-failed':
      errorMessage = l.authErrorNetworkFailed;
      break;
    default:
      errorMessage = l.authErrorDefault;
  }
  _showSnackBar(errorMessage);
}
```

**نفس التغييرات في:**
- ⏳ `signup_screen.dart` (email-already-in-use, weak-password) - **متبقي**
- ⏳ `forgot_password_screen.dart` (user-not-found, invalid-email) - **متبقي**

#### ✅ Task 4.2: تحديث Forgot Password Screen - **مكتمل**

**ملف: `lib/screens/forgot_password_screen.dart`**

**التغييرات:**
```dart
// قبل
const Text('نسيت كلمة المرور')

// بعد
Text(l.forgotPasswordTitle)

// قبل
'أدخل بريدك الإلكتروني وسنرسل لك رابط لإعادة تعيين كلمة المرور'

// بعد
l.forgotPasswordDescription

// قبل
labelText: 'البريد الإلكتروني',

// بعد
labelText: l.emailLabel,

// قبل
'إرسال رابط إعادة التعيين'

// بعد
l.sendResetEmail

// قبل
'العودة لتسجيل الدخول'

// بعد
l.backToLogin
```
✅ **تم تحديث `forgot_password_screen.dart` بالكامل**
- ✅ جميع النصوص تستخدم l10n
- ✅ Firebase errors محدثة
- ✅ Screen title, description, labels, buttons
- ✅ 100% localized

#### ⏳ Task 4.3: تحديث Widgets - **متبقي**

**ملف: `lib/widgets/wall_comments_sheet.dart`**
```dart
// Dialog buttons
TextButton(
  onPressed: () => Navigator.pop(context),
  child: Text(l.dialogCancelButton),
),
TextButton(
  onPressed: _saveEdit,
  child: Text(l.dialogSaveButton),
),

// Delete confirmation
AlertDialog(
  title: Text(l.commentDeleteTitle),
  content: Text(l.commentDeleteConfirm),
  actions: [
    TextButton(
      child: Text(l.dialogCancelButton),
      onPressed: () => Navigator.pop(context),
    ),
    TextButton(
      child: Text(
        l.dialogDeleteButton,
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.pop(context);
        _deleteComment(commentId);
      },
    ),
  ],
)
```

**ملف: `lib/widgets/wall_search_bar.dart`**
```dart
// Filter sheet title
bottomSheet(
  builder: (context) => Column(
    children: [
      AppBar(
        title: Text(l.filterPostsTitle),
      ),
      // ... filters
      Row(
        children: [
          TextButton(
            onPressed: _resetFilters,
            child: Text(l.filterReset),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.dialogCancelButton),
          ),
          FilledButton(
            onPressed: _applyFilters,
            child: Text(l.filterApply),
          ),
        ],
      ),
    ],
  ),
)
```

#### ⏳ Task 4.4: تحديث Screen Titles - **متبقي**

**ملفات:**
- `email_verification_screen.dart`
- `privacy_policy_screen.dart`
- `terms_of_service_screen.dart`

```dart
// قبل
title: const Text('التحقق من البريد الإلكتروني'),

// بعد
title: Text(l.emailVerificationTitle),
```

---

### ⏳ المرحلة 5: ترجمة المحتوى الطويل (يوم 3-4) ⏱️ 6 ساعات - **متبقي**

#### ⏳ Task 5.1: سياسة الخصوصية

**استراتيجية:**
1. استخراج النص الحالي من `privacy_policy_screen.dart`
2. إنشاء ملفات منفصلة:
   - `assets/l10n/privacy_policy_ar.md`
   - `assets/l10n/privacy_policy_en.md`
3. تحميل المحتوى ديناميكياً

**التنفيذ:**
```dart
// lib/screens/privacy_policy_screen.dart
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  Future<String> _loadContent(Locale locale) async {
    final languageCode = locale.languageCode;
    final path = 'assets/l10n/privacy_policy_$languageCode.md';
    try {
      return await rootBundle.loadString(path);
    } catch (e) {
      // Fallback to Arabic
      return await rootBundle.loadString('assets/l10n/privacy_policy_ar.md');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final locale = Localizations.localeOf(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l.privacyPolicyTitle),
      ),
      body: FutureBuilder<String>(
        future: _loadContent(locale),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text(l.error));
          }
          
          return Markdown(
            data: snapshot.data ?? '',
            selectable: true,
          );
        },
      ),
    );
  }
}
```

**محتوى `assets/l10n/privacy_policy_en.md`:**
```markdown
# Privacy Policy

Last updated: October 16, 2025

## 1. Introduction
Welcome to Training App v2. This privacy policy explains how we collect, use, and protect your personal information.

## 2. Information We Collect
- Email address
- Full name
- Institution affiliation
- Course enrollment data
- Usage analytics

## 3. How We Use Your Information
We use your information to:
- Provide training services
- Track course progress
- Generate certificates
- Improve user experience

## 4. Data Security
We implement industry-standard security measures including:
- Encryption at rest and in transit
- Regular security audits
- Access controls

## 5. Your Rights
You have the right to:
- Access your data
- Request deletion
- Export your information
- Update your details

## 6. Contact Us
For privacy concerns, contact: support@trainingapp.com
```

#### Task 5.2: شروط الاستخدام

**نفس الاستراتيجية:**
- `assets/l10n/terms_of_service_ar.md`
- `assets/l10n/terms_of_service_en.md`

**تحديث `pubspec.yaml`:**
```yaml
flutter:
  assets:
    - assets/l10n/privacy_policy_ar.md
    - assets/l10n/privacy_policy_en.md
    - assets/l10n/terms_of_service_ar.md
    - assets/l10n/terms_of_service_en.md
```

---

### ⏳ المرحلة 6: دعم RTL/LTR الكامل (يوم 4) ⏱️ 4 ساعات - **متبقي**

#### ⏳ Task 6.1: مراجعة MaterialApp setup

**ملف: `lib/main.dart`**
```dart
MaterialApp(
  // ... existing config
  locale: localeState,
  supportedLocales: const [
    Locale('ar'),  // Arabic
    Locale('en'),  // English
  ],
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  
  // Force RTL/LTR based on locale
  builder: (context, child) {
    return Directionality(
      textDirection: localeState?.languageCode == 'ar' 
          ? TextDirection.rtl 
          : TextDirection.ltr,
      child: child!,
    );
  },
)
```

#### ⏳ Task 6.2: استخدام Directional Widgets

**قبل:**
```dart
Padding(
  padding: EdgeInsets.only(left: 16, right: 8),
  child: Icon(Icons.arrow_forward),
)
```

**بعد:**
```dart
Padding(
  padding: EdgeInsetsDirectional.only(start: 16, end: 8),
  child: Icon(Icons.arrow_forward_ios),  // Use directional icon
)
```

#### ⏳ Task 6.3: تحديث الأيقونات

**إنشاء helper:**
```dart
// lib/core/directional_icon.dart
class DirectionalIcon {
  static IconData getArrowIcon(BuildContext context, {bool forward = true}) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    
    if (forward) {
      return isRTL ? Icons.arrow_back : Icons.arrow_forward;
    } else {
      return isRTL ? Icons.arrow_forward : Icons.arrow_back;
    }
  }
  
  static IconData chevronRight(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    return isRTL ? Icons.chevron_left : Icons.chevron_right;
  }
}
```

---

### ⏳ المرحلة 7: الاختبار (يوم 5) ⏱️ 6 ساعات - **متبقي**

#### ⏳ Task 7.1: اختبارات يدوية

**قائمة فحص:**

**Authentication Screens:**
- [ ] Login screen: جميع النصوص بالعربية/الإنجليزية
- [ ] Signup screen: جميع النصوص بالعربية/الإنجليزية
- [ ] Forgot password: جميع النصوص بالعربية/الإنجليزية
- [ ] Email verification: جميع النصوص بالعربية/الإنجليزية
- [ ] Error messages: تظهر باللغة الصحيحة

**Main App Screens:**
- [ ] Dashboard: التخطيط RTL/LTR صحيح
- [ ] Course Wall: المنشورات تظهر بالاتجاه الصحيح
- [ ] Comments: التعليقات والردود RTL/LTR
- [ ] Settings: تبديل اللغة يعمل بشكل فوري
- [ ] Profile: جميع البيانات تظهر صح

**Dialogs & Modals:**
- [ ] Delete confirmations: النصوص مترجمة
- [ ] Filter sheets: جميع الخيارات مترجمة
- [ ] Alert dialogs: الأزرار مترجمة

**Content:**
- [ ] Privacy Policy: يظهر بالعربية/الإنجليزية
- [ ] Terms of Service: يظهر بالعربية/الإنجليزية

#### ⏳ Task 7.2: اختبارات Switching

**سيناريو:**
1. افتح التطبيق بالعربية
2. انتقل لعدة شاشات
3. بدل اللغة للإنجليزية من Settings
4. تحقق من:
   - جميع النصوص تحولت للإنجليزية
   - التخطيط تحول من RTL لـ LTR
   - الأيقونات في الاتجاه الصحيح
   - Padding صحيح
5. أعد تشغيل التطبيق
6. تحقق من استمرار اللغة الإنجليزية

#### ⏳ Task 7.3: اختبارات Edge Cases

- [ ] تبديل اللغة أثناء عملية تسجيل دخول
- [ ] تبديل اللغة أثناء تحميل بيانات
- [ ] تبديل اللغة في screens متداخلة (deep navigation)
- [ ] رسائل الخطأ تظهر باللغة الصحيحة
- [ ] Toast/Snackbar messages باللغة الصحيحة

---

### ⏳ المرحلة 8: التوثيق (يوم 5) ⏱️ 2 ساعات - **متبقي**

#### ⏳ Task 8.1: دليل المساهمين

**إنشاء `docs/LOCALIZATION_GUIDE.md`:**
```markdown
# Localization Guide for Contributors

## Adding New Strings

### 1. Add to ARB files
Add your string to both `app_ar.arb` and `app_en.arb`:

**app_ar.arb:**
```json
{
  "myNewString": "النص بالعربية",
  "@myNewString": {
    "description": "Description of when this string is used"
  }
}
```

**app_en.arb:**
```json
{
  "myNewString": "Text in English",
  "@myNewString": {
    "description": "Description of when this string is used"
  }
}
```

### 2. Regenerate l10n files
```bash
flutter gen-l10n
```

### 3. Use in code
```dart
final l = context.l;
Text(l.myNewString)
```

## Guidelines

### DO:
✅ Use l10n for ALL user-facing text
✅ Add descriptions for context
✅ Test in both languages
✅ Use directional widgets (EdgeInsetsDirectional)
✅ Check RTL/LTR layout

### DON'T:
❌ Hard-code strings
❌ Use left/right padding directly
❌ Forget to translate error messages
❌ Mix languages in one string

## Common Patterns

### Error Messages
```dart
on FirebaseAuthException catch (e) {
  final errorMessage = switch (e.code) {
    'user-not-found' => l.authErrorUserNotFound,
    'wrong-password' => l.authErrorWrongPassword,
    _ => l.authErrorDefault,
  };
  _showSnackBar(errorMessage);
}
```

### Dialog Buttons
```dart
AlertDialog(
  title: Text(l.dialogConfirmTitle),
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(l.dialogCancelButton),
    ),
    FilledButton(
      onPressed: _confirm,
      child: Text(l.dialogConfirmButton),
    ),
  ],
)
```
```

#### ⏳ Task 8.2: تحديث README

**إضافة section للترجمة في `README.md`:**
```markdown
## 🌍 Internationalization

This app supports:
- 🇸🇦 Arabic (العربية) - RTL
- 🇺🇸 English - LTR

### Changing Language
1. Open Settings
2. Select Language (اللغة)
3. Choose العربية or English

### For Developers
See [LOCALIZATION_GUIDE.md](docs/LOCALIZATION_GUIDE.md) for adding new translations.

Localization files:
- `lib/l10n/app_ar.arb` - Arabic strings
- `lib/l10n/app_en.arb` - English strings
- `lib/l10n/gen/app_localizations.dart` - Generated code
```

---

## 📊 خطة التنفيذ الزمنية

### Week 1: Foundation (5 أيام)

| اليوم | المهام | الساعات | الحالة | التقدم | التفاصيل |
|-------|---------|---------|--------|---------|----------|
| **يوم 1** | تدقيق شامل + إعداد الأدوات | 6 ساعات | ✅ مكتمل | 100% | Scripts + Audit + ARB comparison |
| **يوم 2** | إضافة ترجمات ARB + تحديث Auth screens | 8 ساعات | 🔄 جاري | 50% | 38 مفاتيح + 8 ملفات مكتملة |
| **يوم 3** | تحديث Widgets + Screen titles | 8 ساعات | ⏳ متبقي | 5% | wall_comments_sheet 80% فقط |
| **يوم 4** | ترجمة المحتوى الطويل + RTL support | 10 ساعات | ⏳ متبقي | 0% | - |
| **يوم 5** | الاختبار الشامل + التوثيق | 8 ساعات | ⏳ متبقي | 0% | - |

**إجمالي:** 40 ساعة عمل = أسبوع واحد  
**المنجز حتى الآن:** 10 ساعات (25%)  
**الملفات المكتملة:** 8/69 ملف (12%)

---

## 🎯 معايير النجاح

### Phase 1 (يجب تحقيقها)
- [ ] صفر hard-coded strings في كل الملفات
- [ ] جميع Firebase errors مترجمة
- [ ] جميع screen titles مترجمة
- [ ] جميع dialog buttons مترجمة
- [ ] التطبيق يعمل 100% بالعربية
- [ ] التطبيق يعمل 100% بالإنجليزية
- [ ] RTL/LTR يعمل بشكل صحيح

### Phase 2 (مستحسنة)
- [ ] سياسة الخصوصية مترجمة
- [ ] شروط الاستخدام مترجمة
- [ ] جميع tooltips مترجمة
- [ ] جميع placeholder texts مترجمة

### Phase 3 (مستقبلية)
- [ ] CI/CD للتحقق من الترجمات
- [ ] Automated tests للـ l10n
- [ ] Professional review للترجمات

---

## 🔧 الأدوات والموارد

### Scripts
- `tools/check_l10n_coverage.py` - فحص hard-coded strings
- `tools/compare_arb_files.py` - مقارنة ملفات ARB
- `tools/validate_l10n.sh` - التحقق من صحة الترجمات

### References
- [Flutter Internationalization](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)
- [ARB Format Specification](https://github.com/google/app-resource-bundle/wiki/ApplicationResourceBundleSpecification)
- [Material Design Internationalization](https://m2.material.io/design/usability/internationalization.html)

### Translation Resources
- Google Translate (للمسودات الأولية فقط)
- Native speakers review (مطلوب للإصدار النهائي)
- Context screenshots (لفهم السياق)

---

## 📝 Notes

### Current Coverage (تقدير)
- **Auth Screens:** 85% ✅
- **Main Screens:** 60% 🟡
- **Widgets:** 40% 🔴
- **Dialogs:** 30% 🔴
- **Error Messages:** 50% 🟡
- **Content Pages:** 0% 🔴

### Priority Order
1. **P0 (Critical):** Auth screens, Firebase errors
2. **P1 (High):** Main screens, dialogs, widgets
3. **P2 (Medium):** Settings, tooltips
4. **P3 (Low):** Content pages, admin panels

---

## 🚀 البدء الفوري

### الخطوات التالية (الآن):

#### Step 1: تشغيل Audit Script
```bash
cd g:/training_app_v2
python tools/check_l10n_coverage.py > HARDCODED_STRINGS_AUDIT.txt
python tools/compare_arb_files.py > ARB_COMPARISON.txt
```

#### Step 2: البدء بأعلى أولوية
1. فتح `lib/screens/login_screen.dart`
2. استبدال hard-coded error messages
3. اختبار فوري

#### Step 3: Commit بعد كل ملف
```bash
git add lib/screens/login_screen.dart lib/l10n/*.arb
git commit -m "feat(l10n): Localize login screen error messages"
```

---

## 📞 Support

للمساعدة في الترجمة:
- **Technical issues:** GitHub Issues
- **Translation review:** طلب من native speakers
- **Context questions:** يرجى إضافة screenshots

---

**Last Updated:** October 16, 2025  
**Status:** 📋 Ready to Execute  
**Estimated Completion:** 5 days (40 hours)
