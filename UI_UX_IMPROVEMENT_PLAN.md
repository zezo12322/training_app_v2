# 🎨 خطة تحسين واجهة المستخدم - Training App v2

**تاريخ البدء**: 17 أكتوبر 2025  
**الحالة**: قيد التنفيذ  
**النمط المستوحى**: Facebook + LinkedIn + Material Design 3

---

## 📋 جدول المحتويات

1. [نظرة عامة](#نظرة-عامة)
2. [المراحل والجدول الزمني](#المراحل-والجدول-الزمني)
3. [المرحلة 1: Design System](#المرحلة-1-design-system)
4. [المرحلة 2: شاشات المصادقة](#المرحلة-2-شاشات-المصادقة)
5. [المرحلة 3: الشاشات الرئيسية](#المرحلة-3-الشاشات-الرئيسية)
6. [المرحلة 4: شاشات الإنشاء والتعديل](#المرحلة-4-شاشات-الإنشاء-والتعديل)
7. [المرحلة 5: التواصل والتفاعل](#المرحلة-5-التواصل-والتفاعل)
8. [المرحلة 6: التلعيب](#المرحلة-6-التلعيب)
9. [المرحلة 7: الإعدادات والإدارة](#المرحلة-7-الإعدادات-والإدارة)
10. [المرحلة 8: التحسينات المتقدمة](#المرحلة-8-التحسينات-المتقدمة)
11. [الأدوات والموارد](#الأدوات-والموارد)

---

## 🎯 نظرة عامة

### الهدف الرئيسي
تحويل Training App إلى منصة تدريبية احترافية بواجهة مستخدم عصرية وجذابة، مستوحاة من أفضل التطبيقات العالمية.

### المبادئ الأساسية
- ✅ **الاتساق (Consistency)**: نفس التصميم في كل مكان
- ✅ **البساطة (Simplicity)**: واجهة نظيفة بدون ازدحام
- ✅ **الوضوح (Clarity)**: كل عنصر واضح الغرض
- ✅ **الاستجابة (Responsiveness)**: يعمل على كل الأجهزة
- ✅ **إمكانية الوصول (Accessibility)**: متاح للجميع

### الإلهام التصميمي
```
Facebook (30%) ──┐
LinkedIn (25%) ───┤
Udemy (20%) ──────┼──► Training App Design
Duolingo (15%) ───┤
Material 3 (10%) ─┘
```

---

## 📅 المراحل والجدول الزمني

### الجدول الزمني الإجمالي: 4-5 أسابيع

| المرحلة | الوصف | المدة | الأولوية | الحالة |
|---------|-------|-------|----------|--------|
| **1** | Design System | 2-3 أيام | 🔴 عالية | ✅ مكتملة |
| **2** | شاشات المصادقة | 1 يوم | 🔴 عالية | ✅ مكتملة |
| **3** | الشاشات الرئيسية | 2-3 أيام | 🔴 عالية | 🔄 قيد التنفيذ (67%) |
| **4** | شاشات الإنشاء | 2-3 أيام | 🟡 متوسطة | ⏳ قادمة |
| **5** | التواصل والتفاعل | 2 يوم | 🟡 متوسطة | ⏳ قادمة |
| **6** | التلعيب | 2-3 أيام | 🟢 منخفضة | ⏳ قادمة |
| **7** | الإعدادات والإدارة | 1-2 يوم | 🟢 منخفضة | ⏳ قادمة |
| **8** | التحسينات المتقدمة | 1 أسبوع | 🟢 منخفضة | ⏳ قادمة |

---

## 🎨 المرحلة 1: Design System

### الحالة: ✅ مكتملة 100%

### ✅ المهام المكتملة

#### 1.1 إنشاء Design Tokens
- [x] ملف `lib/core/design/tokens.dart`
- [x] الألوان التكيفية (Light/Dark Mode)
  - [x] `background(context)` - الخلفية الرئيسية
  - [x] `surface(context)` - السطوح والكروت
  - [x] `fillColor(context)` - خلفية الحقول
  - [x] `borderColor(context)` - الحدود
  - [x] `textPrimary(context)` - النص الأساسي
  - [x] `textSecondary(context)` - النص الثانوي
  - [x] `textOnColor(context)` - النص على الألوان
- [x] الألوان الثابتة
  - [x] `success` - الأخضر
  - [x] `error` - الأحمر
  - [x] `warning` - البرتقالي
  - [x] `info` - الأزرق
- [x] المسافات (Spacing)
  - [x] من `spacingXxs` (2px) إلى `spacing3xl` (48px)
- [x] Border Radius
  - [x] من `radiusXs` (4px) إلى `radiusFull` (999px)
- [x] Typography
  - [x] `h1` إلى `h6` للعناوين
  - [x] `body1`, `body2` للنصوص
  - [x] `caption` للنصوص الصغيرة
  - [x] `button` لنصوص الأزرار
- [x] الظلال (Shadows)
  - [x] `shadowSm`, `shadowMd`, `shadowLg`
- [x] Animation Durations
  - [x] `durationFast`, `durationMedium`, `durationSlow`

#### 1.2 المكونات القابلة لإعادة الاستخدام ✅ مكتملة 100%
- [x] `AppCard` - كارت موحد (lib/widgets/app_card.dart)
  - [x] Adaptive colors
  - [x] Optional tap handling
  - [x] Consistent shadows and borders
  - [x] Customizable padding/margin
- [x] `AppButton` - زر موحد (lib/widgets/app_button.dart)
  - [x] Multiple types (primary, secondary, success, error, warning, info, text)
  - [x] Loading state support
  - [x] Icon support
  - [x] Full width option
- [x] `AppTextField` - حقل إدخال موحد (lib/widgets/app_text_field.dart)
  - [x] Adaptive colors
  - [x] Password field support with visibility toggle
  - [x] Validation support
  - [x] Prefix/suffix icon support
  - [x] Consistent styling
- [x] `AppAvatar` - صورة مستخدم موحدة ✨ (lib/widgets/app_avatar.dart)
  - [x] Multiple sizes (xs to xxl)
  - [x] Image or initials fallback
  - [x] Online status indicator
  - [x] Color generation from name
  - [x] Tap handling
- [x] `AppBadge` - شارة موحدة ✨ (lib/widgets/app_badge.dart)
  - [x] Multiple types (primary, success, error, warning, info, neutral)
  - [x] Multiple sizes (sm, md, lg)
  - [x] Optional icon
  - [x] Dismissible support
- [x] `AppChip` - رقاقة موحدة ✨ (lib/widgets/app_chip.dart)
  - [x] Multiple styles (filled, outlined, flat)
  - [x] Icon or avatar support
  - [x] Selection state
  - [x] Delete button support
  - [x] ChipGroup wrapper
- [x] `AppProgressBar` - شريط تقدم موحد ✨ (lib/widgets/app_progress_bar.dart)
  - [x] Linear and circular styles
  - [x] Color coding by progress
  - [x] Optional label with percentage
  - [x] Customizable styling
- [x] `AppEmptyState` - حالة فارغة موحدة ✨ (lib/widgets/app_empty_state.dart)
  - [x] Icon or custom image
  - [x] Title and description
  - [x] Optional action button
  - [x] Adaptive colors
- [x] `AppErrorState` - حالة خطأ موحدة ✨ (lib/widgets/app_error_state.dart)
  - [x] Error icon and message
  - [x] Retry button
  - [x] Customizable layout
- [x] `AppLoadingSkeleton` - هيكل تحميل موحد ✨ (lib/widgets/app_loading_skeleton.dart)
  - [x] Multiple skeleton types (text, circle, rectangle, rounded)
  - [x] Shimmer animation effect
  - [x] Pre-built layouts (listItem, card)
  - [x] Adaptive colors

### 📝 الملاحظات
- Design System جاهز للاستخدام في كل الشاشات
- الألوان تتكيف تلقائياً مع Light/Dark Mode
- النظام يدعم RTL (العربية) بشكل كامل

---

## 🔐 المرحلة 2: شاشات المصادقة

### الحالة: ✅ مكتملة 100%

### ✅ المهام المكتملة

#### 2.1 شاشة تسجيل الدخول (`login_screen.dart`)
- [x] استيراد Design Tokens
- [x] تحديث الخلفية لتستخدم `DesignTokens.background(context)`
- [x] تحديث الكارت لتستخدم `DesignTokens.surface(context)`
- [x] تحديث الشعار لاستخدام `DesignTokens.h1(context)`
- [x] تحديث الـ tagline لاستخدام `DesignTokens.h6(context)`
- [x] تحديث حقل Email
  - [x] `fillColor: DesignTokens.fillColor(context)`
  - [x] `borderColor: DesignTokens.borderColor(context)`
  - [x] `textStyle: DesignTokens.body1(context)`
  - [x] `hintStyle` مع `textSecondary`
- [x] تحديث حقل Password (نفس Email)
- [x] تحديث زر Login
  - [x] `backgroundColor: theme.colorScheme.primary`
  - [x] `foregroundColor: DesignTokens.textOnColor(context)`
  - [x] `textStyle: DesignTokens.button(context)`
- [x] تحديث رابط "Forgot Password"
- [x] تحديث زر "Create Account"
  - [x] `backgroundColor: DesignTokens.surface(context)`
- [x] تحديث كل المسافات لاستخدام `DesignTokens.spacing*`
- [x] تحديث الظلال لاستخدام `DesignTokens.shadowMd(context)`
- [x] تحديث Animation duration

#### 2.2 شاشة التسجيل (`signup_screen.dart`)
- [x] استيراد Design Tokens
- [x] تحديث الخلفية
- [x] تحديث الكارت
- [x] تحديث الشعار لاستخدام `DesignTokens.h2(context)`
- [x] تحديث العنوان "Create a new account" - `DesignTokens.h4(context)`
- [x] تحديث النص "It's quick and easy"
- [x] تحديث حقل Name
- [x] تحديث حقل Email
- [x] تحديث حقل Password
- [x] تحديث اختيار الدور (Trainer/Trainee)
  - [x] `fillColor: DesignTokens.fillColor(context)`
  - [x] `borderColor: DesignTokens.borderColor(context)`
  - [x] `textStyle: DesignTokens.body1(context)`
- [x] تحديث زر Sign Up
  - [x] `backgroundColor: DesignTokens.success`
  - [x] `foregroundColor: DesignTokens.textOnColor(context)`
- [x] تحديث رابط "Already have account"
- [x] تحديث كل المسافات
- [x] تحديث الظلال

#### 2.3 شاشة نسيت كلمة المرور (`forgot_password_screen.dart`)
- [x] استيراد Design Tokens
- [x] تحديث الخلفية لتستخدم `DesignTokens.background(context)`
- [x] تحديث الكارت/Container الرئيسي
  - [x] `color: DesignTokens.surface(context)`
  - [x] `boxShadow: DesignTokens.shadowMd(context)`
  - [x] `borderRadius: DesignTokens.radiusLg`
- [x] تحديث AppBar
  - [x] `backgroundColor: DesignTokens.surface(context)`
  - [x] `title` باستخدام `DesignTokens.h6(context)`
- [x] تحديث العنوان لاستخدام `DesignTokens.h4(context)`
- [x] تحديث الوصف لاستخدام `DesignTokens.body1(context)` مع `textSecondary`
- [x] تحديث حقل Email
  - [x] `fillColor: DesignTokens.fillColor(context)`
  - [x] `borderColor: DesignTokens.borderColor(context)`
  - [x] `textStyle: DesignTokens.body1(context)`
  - [x] `borderRadius: DesignTokens.radiusMd`
- [x] تحديث زر Send Reset Email
  - [x] `backgroundColor: theme.colorScheme.primary`
  - [x] `foregroundColor: DesignTokens.textOnColor(context)`
  - [x] `textStyle: DesignTokens.button(context)`
  - [x] `borderRadius: DesignTokens.radiusMd`
- [x] تحديث زر "Back to Login"
  - [x] `foregroundColor: DesignTokens.textSecondary(context)`
- [x] تحديث Info Box
  - [x] استخدام `DesignTokens.info` للون
  - [x] `borderRadius: DesignTokens.radiusMd`
  - [x] تحديث الـ text style
- [x] تحديث كل المسافات لاستخدام `DesignTokens.spacing*`
- [x] تحديث Animation duration لاستخدام `DesignTokens.durationMedium`

### 📝 الملاحظات
- ✅ شاشات المصادقة الثلاثة الآن احترافية وجاهزة
- ✅ الألوان تتكيف تلقائياً مع Light/Dark Mode
- ✅ التصميم موحد ومتسق في كل الشاشات
- ✅ Animation durations موحدة
- ✅ جاهزة للاختبار على Light/Dark Mode

---

## 🏠 المرحلة 3: الشاشات الرئيسية

### الحالة: 🔄 قيد التنفيذ (67% مكتملة)

### الأولوية: 🔴 عالية جداً

### المدة المقدرة: 3-4 أيام (2 أيام مكتملة)

---

### 3.0 لوحة التحكم الرئيسية (`home_dashboard_screen.dart`) - ✅ مكتملة 🆕

#### ⚠️ ملاحظة مهمة
**هذه هي الشاشة الأساسية** التي يراها المستخدم عند تسجيل الدخول (مع الـ Bottom Navigation).  
**TrainerHomeScreen** تظهر فقط عند الضغط على "See all".

#### ✅ التحسينات المُنفذة (مكتملة)

##### ✅ A. الـ Header Section
```dart
[x] تصميم Header محسّن:
    [x] Avatar كبير (AppAvatar size lg) مع Online status
    [x] Greeting message موحد (DesignTokens.h4)
    [x] Badge للـ Role (AppBadge - Trainer: info, Trainee: success)
    [x] استخدام DesignTokens للـ spacing والـ typography
```

##### ✅ B. Stats Dashboard Cards
```dart
[x] بطاقات الإحصائيات بالـ Design System:
    [x] استخدام AppCard بدل Container العادي
    [x] Points display مع DesignTokens.h5
    [x] Level Badge (AppBadge primary)
    [x] Badges count (AppBadge success مع أيقونة)
    [x] AppProgressBar للـ level progress
    [x] Next badge info
    [x] AppErrorState للأخطاء مع retry
    [x] Loading state بـ CircularProgressIndicator
```

##### ✅ C. Quick Actions Section
```dart
[x] تحسين Quick Actions:
    [x] استخدام Design System colors (primary, success, info)
    [x] Consistent spacing مع DesignTokens
    [x] Typography محسّنة (Theme.bodySmall)
    [x] DesignTokens.radiusFull للـ circles
```

##### ✅ D. Recent Courses List
```dart
[x] تحسين قائمة الكورسات:
    [x] AppCard wrapper للعناصر
    [x] AppEmptyState للحالة الفارغة مع action
    [x] AppErrorState للأخطاء
    [x] DesignTokens spacing & typography
    [x] Typography: bodyLarge للعنوان، bodySmall للتفاصيل
    [x] textSecondary color للتفاصيل
```

**التفاصيل**:
- ✅ Imports: DesignTokens + widgets.dart
- ✅ Header: AppAvatar + Role Badge + Online Status
- ✅ Stats: AppCard + AppBadge + AppProgressBar
- ✅ Courses: AppCard + AppEmptyState + Enhanced styling
- ✅ Actions: Design System colors + spacing
- ✅ Error handling: AppErrorState with retry
- ✅ Removed: Unused _MiniSkeleton class

**Git Commit**: `23bc177` - feat: Update HomeDashboardScreen with Design System  
**المدة الفعلية**: 2 ساعات  
**الحالة**: ✅ 100% مكتملة

---

##### D. Recent Courses Horizontal List
```dart
[ ] تحسين Courses Cards:
    [ ] استخدام AppCard بدل Container
    [ ] Loading state بـ AppLoadingSkeleton
    [ ] Empty state بـ AppEmptyState
    [ ] Typography موحدة
    [ ] Better spacing
```

##### E. Bottom Navigation
```dart
[ ] تحسين Bottom Nav:
    [ ] استخدام DesignTokens للألوان
    [ ] Selected state واضح
    [ ] Labels واضحة بـ Typography موحدة
    [ ] Icons أكبر شوية (24px)
```

**الكود المقترح للـ Header**:
```dart
Widget _buildHeader(BuildContext context, String? name) {
  final l = context.l;
  return Container(
    color: DesignTokens.surface(context),
    padding: EdgeInsets.all(DesignTokens.spacingLg),
    child: Row(
      children: [
        AppAvatar(
          imageUrl: userModel?.imageUrl,
          name: name ?? 'User',
          size: AppAvatarSize.xl,
          showOnlineStatus: true,
          isOnline: true,
        ),
        SizedBox(width: DesignTokens.spacingLg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name != null 
                  ? l.greetingTrainer(name) 
                  : l.greetingTrainerFallback,
                style: DesignTokens.h4(context),
              ),
              SizedBox(height: DesignTokens.spacingXs),
              AppBadge(
                text: widget.role == 'trainer' ? 'Trainer' : 'Student',
                type: AppBadgeType.primary,
                size: AppBadgeSize.sm,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
```

**الأولوية**: 🔴 عالية - يجب تحديثها قبل TrainerHomeScreen لأنها الشاشة الأساسية

**المدة المقدرة**: 2-3 ساعات

---

### 3.1 الشاشة الرئيسية للمدرب (`trainer_home_screen.dart`) ✅ مكتملة

#### ✅ الوظائف الحالية
- [x] عرض قائمة الكورسات
- [x] زر إنشاء كورس جديد
- [x] التنقل لتفاصيل الكورس
- [x] Auto-refresh عند العودة

#### ✅ التحسينات المُنفذة (مكتملة)

##### ✅ A. الـ AppBar
- [x] تطبيق DesignTokens للـ background
- [x] Typography موحدة (h6)
- [x] أيقونة Logout بلون موحد
- [x] Elevation = 0

##### ✅ B. Header Section
- [x] استخدام AppAvatar بدل CircleAvatar
- [x] Online status indicator
- [x] Typography موحدة (h5 للاسم، body2 للـ subtitle)
- [x] Spacing موحد بـ DesignTokens
- [x] Background color من DesignTokens.surface

##### ✅ C. Stats Dashboard (جديد!)
- [x] 4 بطاقات إحصائيات:
  - [x] Total Courses
  - [x] Total Students (محسوب من enrollments)
  - [x] Active Courses
  - [x] This Week Activity
- [x] Responsive Grid (4 على desktop، 2 على tablet/mobile)
- [x] أيقونات ملونة مع background شفاف
- [x] Typography موحدة (h4 للأرقام، caption للـ labels)
- [x] Loading state بـ AppLoadingSkeleton
- [x] استخدام AppCard

##### ✅ D. Course Cards
- [x] استخدام AppCard بدل Card العادي
- [x] Icon في container ملون مع background شفاف
- [x] Typography موحدة (body1 للعنوان، caption للكود)
- [x] Spacing موحد بـ DesignTokens
- [x] Arrow icon موحد اللون

##### ✅ E. Empty State
- [x] استخدام AppEmptyState بدل الـ custom widget
- [x] Action button للـ Create Course
- [x] Typography وأيقونات موحدة

##### ✅ F. Error State
- [x] استخدام AppErrorState مع retry button
- [x] Typography موحدة

##### ✅ G. Loading State
- [x] استخدام AppLoadingSkeleton للـ stats
- [x] استخدام AppSkeletonLayouts.card() للـ courses

##### ✅ H. FAB (Floating Action Button)
- [x] لون من DesignTokens.info
- [x] أيقونة ونص بلون موحد (textOnColor)
- [x] Typography موحدة (button)

**المدة الفعلية**: 1.5 ساعة  
**الحالة**: ✅ 100% مكتملة  
**Git Commit**: `4ca9776` - "feat: Update Trainer Home Screen with Design System and Stats Dashboard"

---
```dart
[ ] تصميم AppBar جديد:
    [ ] شعار التطبيق على اليسار (Logo + "Training App")
    [ ] أيقونة بحث (Search icon)
    [ ] أيقونة إشعارات (Notification bell) + badge للعدد
    [ ] صورة المدرب الشخصية + اسم على اليمين
    [ ] خلفية تتكيف مع الـ theme
```

**الكود المقترح**:
```dart
AppBar(
  backgroundColor: DesignTokens.surface(context),
  elevation: 0,
  title: Row(
    children: [
      Icon(Icons.school, color: theme.colorScheme.primary, size: 28),
      SizedBox(width: DesignTokens.spacingSm),
      Text(
        'Training App',
        style: DesignTokens.h6(context).copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.search, color: DesignTokens.textPrimary(context)),
      onPressed: () {/* TODO: Search */},
    ),
    Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, 
            color: DesignTokens.textPrimary(context)),
          onPressed: () {/* TODO: Notifications */},
        ),
        if (unreadCount > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: DesignTokens.error,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$unreadCount',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
      ],
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: DesignTokens.spacingSm),
      child: CircleAvatar(
        backgroundImage: NetworkImage(trainerPhotoUrl),
        radius: 18,
      ),
    ),
  ],
)
```

##### B. Dashboard Stats (في الأعلى)
```dart
[ ] بطاقات الإحصائيات (Stats Cards):
    [ ] عدد الكورسات الكلي
    [ ] عدد الطلاب الكلي
    [ ] معدل الإكمال
    [ ] التقييم المتوسط
    [ ] تصميم: 4 بطاقات صغيرة أفقياً
    [ ] أيقونات ملونة
    [ ] أرقام كبيرة واضحة
```

**التصميم المقترح**:
```dart
Container(
  height: 100,
  margin: EdgeInsets.all(DesignTokens.spacingLg),
  child: Row(
    children: [
      Expanded(child: _StatCard(
        icon: Icons.book,
        iconColor: Colors.blue,
        label: 'الكورسات',
        value: '12',
      )),
      SizedBox(width: DesignTokens.spacingMd),
      Expanded(child: _StatCard(
        icon: Icons.people,
        iconColor: Colors.green,
        label: 'الطلاب',
        value: '145',
      )),
      SizedBox(width: DesignTokens.spacingMd),
      Expanded(child: _StatCard(
        icon: Icons.check_circle,
        iconColor: Colors.orange,
        label: 'الإكمال',
        value: '78%',
      )),
      SizedBox(width: DesignTokens.spacingMd),
      Expanded(child: _StatCard(
        icon: Icons.star,
        iconColor: Colors.amber,
        label: 'التقييم',
        value: '4.5',
      )),
    ],
  ),
)

// Widget للبطاقة الصغيرة
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.surface(context),
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        boxShadow: DesignTokens.shadowSm(context),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 28),
          SizedBox(height: DesignTokens.spacingXs),
          Text(value, style: DesignTokens.h5(context)),
          Text(label, style: DesignTokens.caption(context)),
        ],
      ),
    );
  }
}
```

##### C. قائمة الكورسات (Course Cards)
```dart
[ ] بطاقة كورس محسّنة:
    [ ] صورة الكورس في الأعلى (aspect ratio 16:9)
    [ ] Gradient overlay على الصورة
    [ ] عنوان الكورس واضح
    [ ] عدد الطلاب + أيقونة
    [ ] عدد الدروس + أيقونة
    [ ] Progress bar للإكمال المتوسط
    [ ] شارة الحالة (منشور/مسودة)
    [ ] زر Menu (⋯) للخيارات
    [ ] Hover effect (على Web)
    [ ] Ripple effect عند الضغط
```

**التصميم المقترح**:
```dart
class CourseCard extends StatelessWidget {
  final Course course;
  
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CourseDetailsScreen(courseId: course.id),
        ),
      ),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة الكورس مع Gradient
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(DesignTokens.radiusLg),
                  ),
                  child: Image.network(
                    course.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(DesignTokens.radiusLg),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ),
              // الحالة (منشور/مسودة)
              Positioned(
                top: DesignTokens.spacingSm,
                right: DesignTokens.spacingSm,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacingSm,
                    vertical: DesignTokens.spacingXs,
                  ),
                  decoration: BoxDecoration(
                    color: course.isPublished 
                      ? DesignTokens.success 
                      : Colors.orange,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                  ),
                  child: Text(
                    course.isPublished ? 'منشور' : 'مسودة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              // Menu button
              Positioned(
                top: DesignTokens.spacingSm,
                left: DesignTokens.spacingSm,
                child: IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () => _showCourseMenu(context, course),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            ],
          ),
          
          // معلومات الكورس
          Padding(
            padding: EdgeInsets.all(DesignTokens.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان
                Text(
                  course.title,
                  style: DesignTokens.h6(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: DesignTokens.spacingSm),
                
                // الإحصائيات
                Row(
                  children: [
                    Icon(Icons.people, 
                      size: 16, 
                      color: DesignTokens.textSecondary(context)),
                    SizedBox(width: DesignTokens.spacingXs),
                    Text(
                      '${course.studentCount} طالب',
                      style: DesignTokens.body2(context),
                    ),
                    SizedBox(width: DesignTokens.spacingMd),
                    Icon(Icons.video_library, 
                      size: 16, 
                      color: DesignTokens.textSecondary(context)),
                    SizedBox(width: DesignTokens.spacingXs),
                    Text(
                      '${course.lessonCount} درس',
                      style: DesignTokens.body2(context),
                    ),
                  ],
                ),
                
                SizedBox(height: DesignTokens.spacingMd),
                
                // Progress bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'معدل الإكمال',
                          style: DesignTokens.caption(context),
                        ),
                        Text(
                          '${course.averageCompletion}%',
                          style: DesignTokens.caption(context).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: DesignTokens.spacingXs),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                      child: LinearProgressIndicator(
                        value: course.averageCompletion / 100,
                        backgroundColor: DesignTokens.fillColor(context),
                        valueColor: AlwaysStoppedAnimation(
                          theme.colorScheme.primary,
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

##### D. FAB (زر إنشاء كورس جديد)
```dart
[ ] Floating Action Button محسّن:
    [ ] أيقونة + نص "إنشاء كورس"
    [ ] Extended FAB (يظهر النص)
    [ ] لون primary
    [ ] ظل واضح
    [ ] Animation عند الظهور
```

**الكود المقترح**:
```dart
floatingActionButton: FloatingActionButton.extended(
  onPressed: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => CreateCourseScreen()),
  ),
  backgroundColor: theme.colorScheme.primary,
  foregroundColor: DesignTokens.textOnColor(context),
  icon: Icon(Icons.add),
  label: Text(
    'إنشاء كورس جديد',
    style: DesignTokens.button(context),
  ),
  elevation: 4,
),
```

##### E. التخطيط العام (Layout)
```dart
[ ] Responsive Grid:
    [ ] Desktop (>900px): 3 أعمدة
    [ ] Tablet (600-900px): 2 عمودين
    [ ] Mobile (<600px): عمود واحد
    [ ] مسافات متساوية بين البطاقات
    [ ] Padding على الجوانب
```

**الكود المقترح**:
```dart
body: RefreshIndicator(
  onRefresh: () async {
    ref.invalidate(trainerCoursesProvider);
  },
  child: CustomScrollView(
    slivers: [
      // Stats Dashboard
      SliverToBoxAdapter(
        child: _buildStatsSection(context),
      ),
      
      // Courses Grid
      SliverPadding(
        padding: EdgeInsets.all(DesignTokens.spacingLg),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(context),
            mainAxisSpacing: DesignTokens.spacingLg,
            crossAxisSpacing: DesignTokens.spacingLg,
            childAspectRatio: 0.75,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => CourseCard(course: courses[index]),
            childCount: courses.length,
          ),
        ),
      ),
    ],
  ),
)

int _getCrossAxisCount(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width > 900) return 3;  // Desktop
  if (width > 600) return 2;  // Tablet
  return 1;                   // Mobile
}
```

##### F. حالات فارغة وتحميل
```dart
[ ] Loading State:
    [ ] Shimmer loading skeletons
    [ ] 6 بطاقات skeleton
    [ ] Animation سلسة
    
[ ] Empty State:
    [ ] أيقونة كبيرة (illustration)
    [ ] نص "لا توجد كورسات بعد"
    [ ] زر "إنشاء أول كورس"
    [ ] تصميم جذاب ومشجع
    
[ ] Error State:
    [ ] أيقونة خطأ
    [ ] رسالة الخطأ
    [ ] زر "إعادة المحاولة"
```

#### 📋 Checklist التنفيذ

- [ ] **التحضير**
  - [ ] فحص الكود الحالي
  - [ ] أخذ Screenshot للمقارنة
  - [ ] عمل Git commit قبل التعديل
  
- [ ] **التنفيذ**
  - [ ] تحديث AppBar
  - [ ] إضافة Stats Dashboard
  - [ ] إنشاء CourseCard جديدة
  - [ ] تحديث FAB
  - [ ] تطبيق Responsive Grid
  - [ ] إضافة Loading Skeletons
  - [ ] إضافة Empty State
  - [ ] إضافة Error State
  
- [ ] **الاختبار**
  - [ ] Desktop (>900px)
  - [ ] Tablet (600-900px)
  - [ ] Mobile (<600px)
  - [ ] Light Mode
  - [ ] Dark Mode
  - [ ] RTL (العربية)
  - [ ] Pull to refresh
  - [ ] Navigation
  
- [ ] **التوثيق**
  - [ ] Git commit
  - [ ] Update checklist
  - [ ] Screenshot للمقارنة

---

### 3.2 الشاشة الرئيسية للطالب (`trainee_home_screen.dart`)

#### ✅ الوظائف الحالية
- [x] عرض الكورسات المسجل فيها
- [x] زر الانضمام لكورس جديد
- [x] عرض التقدم لكل كورس
- [x] Auto-refresh عند العودة

#### 🎨 التحسينات المطلوبة

##### A. الـ AppBar (نفس المدرب)
```dart
[ ] تصميم AppBar:
    [ ] شعار التطبيق
    [ ] أيقونة بحث
    [ ] أيقونة إشعارات + badge
    [ ] صورة الطالب + اسم
```

##### B. Gamification Dashboard
```dart
[ ] لوحة التلعيب في الأعلى:
    [ ] النقاط الكلية + أيقونة نجمة
    [ ] المستوى الحالي + Progress bar للمستوى القادم
    [ ] Streak (السلسلة اليومية) + أيقونة نار 🔥
    [ ] عدد الشارات + أيقونة
    [ ] تصميم: 4 بطاقات أفقية ملونة
    [ ] Animation عند تحديث القيم
```

**التصميم المقترح**:
```dart
Container(
  margin: EdgeInsets.all(DesignTokens.spacingLg),
  padding: EdgeInsets.all(DesignTokens.spacingLg),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        theme.colorScheme.primary,
        theme.colorScheme.primary.withOpacity(0.7),
      ],
    ),
    borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
    boxShadow: DesignTokens.shadowMd(context),
  ),
  child: Column(
    children: [
      Row(
        children: [
          Expanded(child: _GamificationCard(
            icon: Icons.stars,
            iconColor: Colors.amber,
            label: 'النقاط',
            value: '1,250',
            backgroundColor: Colors.white,
          )),
          SizedBox(width: DesignTokens.spacingMd),
          Expanded(child: _GamificationCard(
            icon: Icons.military_tech,
            iconColor: Colors.purple,
            label: 'المستوى',
            value: '5',
            backgroundColor: Colors.white,
          )),
        ],
      ),
      SizedBox(height: DesignTokens.spacingMd),
      Row(
        children: [
          Expanded(child: _GamificationCard(
            icon: Icons.local_fire_department,
            iconColor: Colors.orange,
            label: 'Streak',
            value: '7 يوم',
            backgroundColor: Colors.white,
          )),
          SizedBox(width: DesignTokens.spacingMd),
          Expanded(child: _GamificationCard(
            icon: Icons.emoji_events,
            iconColor: Colors.green,
            label: 'الشارات',
            value: '12',
            backgroundColor: Colors.white,
          )),
        ],
      ),
    ],
  ),
)
```

##### C. Tabs للفلترة
```dart
[ ] تبويبات لتصنيف الكورسات:
    [ ] الكل
    [ ] قيد التقدم (In Progress)
    [ ] مكتملة (Completed)
    [ ] غير مبدوءة (Not Started)
    [ ] تصميم Material Design 3 tabs
    [ ] Indicator ملون
```

**الكود المقترح**:
```dart
DefaultTabController(
  length: 4,
  child: Column(
    children: [
      TabBar(
        labelColor: theme.colorScheme.primary,
        unselectedLabelColor: DesignTokens.textSecondary(context),
        indicatorColor: theme.colorScheme.primary,
        indicatorWeight: 3,
        tabs: [
          Tab(text: 'الكل'),
          Tab(text: 'قيد التقدم'),
          Tab(text: 'مكتملة'),
          Tab(text: 'غير مبدوءة'),
        ],
      ),
      Expanded(
        child: TabBarView(
          children: [
            _buildCoursesList(allCourses),
            _buildCoursesList(inProgressCourses),
            _buildCoursesList(completedCourses),
            _buildCoursesList(notStartedCourses),
          ],
        ),
      ),
    ],
  ),
)
```

##### D. بطاقة الكورس للطالب
```dart
[ ] بطاقة كورس الطالب:
    [ ] صورة الكورس + Gradient
    [ ] عنوان الكورس
    [ ] اسم المدرب + صورة صغيرة
    [ ] Progress bar كبير واضح
    [ ] نسبة الإكمال %
    [ ] آخر درس تم الوصول إليه
    [ ] شارة "جديد" إذا كان غير مبدوء
    [ ] شارة "مكتمل" + ✓ إذا انتهى
    [ ] زر "متابعة" أو "ابدأ"
```

**التصميم المقترح**:
```dart
class StudentCourseCard extends StatelessWidget {
  final CourseEnrollment enrollment;
  
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CourseDetailsScreen(
            courseId: enrollment.courseId,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة الكورس
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(DesignTokens.radiusLg),
                  ),
                  child: Image.network(
                    enrollment.course.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Badges
              Positioned(
                top: DesignTokens.spacingSm,
                right: DesignTokens.spacingSm,
                child: _buildStatusBadge(enrollment),
              ),
            ],
          ),
          
          Padding(
            padding: EdgeInsets.all(DesignTokens.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان
                Text(
                  enrollment.course.title,
                  style: DesignTokens.h6(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: DesignTokens.spacingSm),
                
                // المدرب
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(
                        enrollment.course.trainerPhotoUrl,
                      ),
                    ),
                    SizedBox(width: DesignTokens.spacingXs),
                    Text(
                      enrollment.course.trainerName,
                      style: DesignTokens.body2(context),
                    ),
                  ],
                ),
                
                SizedBox(height: DesignTokens.spacingMd),
                
                // Progress
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'التقدم',
                          style: DesignTokens.body2(context).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${enrollment.progressPercentage}%',
                          style: DesignTokens.h6(context).copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: DesignTokens.spacingXs),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusFull,
                      ),
                      child: LinearProgressIndicator(
                        value: enrollment.progressPercentage / 100,
                        backgroundColor: DesignTokens.fillColor(context),
                        valueColor: AlwaysStoppedAnimation(
                          _getProgressColor(enrollment.progressPercentage),
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: DesignTokens.spacingMd),
                
                // آخر درس
                if (enrollment.lastAccessedLesson != null)
                  Row(
                    children: [
                      Icon(
                        Icons.play_circle_outline,
                        size: 16,
                        color: DesignTokens.textSecondary(context),
                      ),
                      SizedBox(width: DesignTokens.spacingXs),
                      Expanded(
                        child: Text(
                          'آخر درس: ${enrollment.lastAccessedLesson}',
                          style: DesignTokens.caption(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                
                SizedBox(height: DesignTokens.spacingMd),
                
                // زر الإجراء
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _continueCourse(context, enrollment),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: DesignTokens.textOnColor(context),
                      padding: EdgeInsets.symmetric(
                        vertical: DesignTokens.spacingMd,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
                        ),
                      ),
                    ),
                    child: Text(
                      enrollment.progressPercentage > 0 
                        ? 'متابعة' 
                        : 'ابدأ الآن',
                      style: DesignTokens.button(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Color _getProgressColor(double progress) {
    if (progress < 30) return Colors.red;
    if (progress < 70) return Colors.orange;
    return DesignTokens.success;
  }
  
  Widget _buildStatusBadge(CourseEnrollment enrollment) {
    if (enrollment.isCompleted) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingSm,
          vertical: DesignTokens.spacingXs,
        ),
        decoration: BoxDecoration(
          color: DesignTokens.success,
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check, color: Colors.white, size: 14),
            SizedBox(width: 4),
            Text(
              'مكتمل',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }
    
    if (enrollment.progressPercentage == 0) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingSm,
          vertical: DesignTokens.spacingXs,
        ),
        decoration: BoxDecoration(
          color: DesignTokens.info,
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        ),
        child: Text(
          'جديد',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    
    return SizedBox.shrink();
  }
}
```

##### E. FAB (زر الانضمام لكورس)
```dart
[ ] FAB للانضمام:
    [ ] أيقونة + نص "انضم لكورس"
    [ ] لون أخضر (success)
    [ ] Extended FAB
```

**الكود المقترح**:
```dart
floatingActionButton: FloatingActionButton.extended(
  onPressed: () => _showJoinCourseDialog(context),
  backgroundColor: DesignTokens.success,
  foregroundColor: Colors.white,
  icon: Icon(Icons.add),
  label: Text('انضم لكورس', style: DesignTokens.button(context)),
  elevation: 4,
),
```

#### 📋 Checklist التنفيذ

- [ ] **التحضير**
  - [ ] فحص الكود الحالي
  - [ ] Screenshot للمقارنة
  - [ ] Git commit
  
- [ ] **التنفيذ**
  - [ ] تحديث AppBar
  - [ ] إضافة Gamification Dashboard
  - [ ] إضافة Tabs
  - [ ] إنشاء StudentCourseCard
  - [ ] تحديث FAB
  - [ ] تطبيق Responsive Grid
  - [ ] إضافة Loading/Empty/Error States
  
- [ ] **الاختبار**
  - [ ] جميع الأحجام
  - [ ] Light/Dark Mode
  - [ ] RTL
  - [ ] Navigation
  - [ ] Tabs switching
  - [ ] Pull to refresh
  
- [ ] **التوثيق**
  - [ ] Git commit
  - [ ] Update checklist

---

### 3.3 تفاصيل الكورس (`course_details_screen.dart`)

#### 🎨 التحسينات المطلوبة

##### A. Header (Hero Section)
```dart
[ ] صورة غلاف كبيرة:
    [ ] Full width hero image
    [ ] Gradient overlay
    [ ] عنوان الكورس overlaid
    [ ] اسم المدرب + صورة
    [ ] AppBar شفاف/floating
    [ ] زر رجوع
    [ ] زر Menu (للمدرب)
```

##### B. Tabs
```dart
[ ] تبويبات:
    [ ] دروس (Lessons)
    [ ] الجدار (Wall)
    [ ] المحادثات (Chat)
    [ ] الطلاب (Students - للمدرب فقط)
    [ ] Material Design 3 tabs
```

##### C. بطاقة الدرس
```dart
[ ] تصميم بطاقة درس:
    [ ] أيقونة الحالة (✅ مكتمل، 🔒 مقفل، ▶️ متاح)
    [ ] عنوان واضح
    [ ] المدة الزمنية
    [ ] نوع الدرس (فيديو، كويز، نص)
    [ ] Progress indicator للمكتمل
    [ ] تأثير hover
```

#### 📋 Checklist

- [ ] تحديث Hero header
- [ ] إضافة Tabs
- [ ] تحديث Lesson cards
- [ ] اختبار
- [ ] توثيق

---

## 📝 المرحلة 4: شاشات الإنشاء والتعديل

### الحالة: ⏳ قادمة
### الأولوية: 🟡 متوسطة
### المدة: 2-3 أيام

### 4.1 إنشاء كورس (`create_course_screen.dart`)
- [ ] Stepper بصري (3 خطوات)
- [ ] معاينة الصورة محسّنة
- [ ] حقول بتصميم Design System
- [ ] Validation واضحة

### 4.2 إضافة درس (`add_lesson_screen.dart`)
- [ ] اختيار نوع الدرس بتصميم بطاقات
- [ ] Drop zone للملفات
- [ ] Progress bar للرفع
- [ ] محرر نصوص محسّن

### 4.3 إنشاء كويز (`create_quiz_screen.dart`)
- [ ] بطاقة لكل سؤال
- [ ] Drag to reorder
- [ ] تحديد الإجابة الصحيحة واضح
- [ ] معاينة الكويز

---

## 💬 المرحلة 5: التواصل والتفاعل

### الحالة: ⏳ قادمة
### الأولوية: 🟡 متوسطة
### المدة: 2 يوم

### 5.1 جدار المشاركات (`course_wall_widget.dart`)
- [ ] صندوق إنشاء مشاركة (Facebook-style)
- [ ] بطاقة مشاركة محسّنة
- [ ] Reactions bar
- [ ] Comments
- [ ] Polls

### 5.2 المحادثات (`chat_screen.dart`)
- [ ] قائمة المحادثات
- [ ] Bubbles للرسائل
- [ ] Typing indicator
- [ ] معاينة الصور inline

---

## 🏆 المرحلة 6: التلعيب

### الحالة: ⏳ قادمة
### الأولوية: 🟢 منخفضة
### المدة: 2-3 أيام

### 6.1 لوحة المتصدرين (`leaderboard_screen.dart`)
- [ ] Podium للقمة 3
- [ ] قائمة المراكز
- [ ] Tabs (أسبوعي، شهري، كل الأوقات)

### 6.2 الشارات (`badges_screen.dart`)
- [ ] Grid للشارات
- [ ] Locked/Unlocked states
- [ ] Dialog عند الحصول على شارة

### 6.3 الملف الشخصي (`profile_screen.dart`)
- [ ] Cover photo + Profile photo
- [ ] Stats cards
- [ ] Activity tabs
- [ ] Charts

---

## ⚙️ المرحلة 7: الإعدادات والإدارة

### الحالة: ⏳ قادمة
### الأولوية: 🟢 منخفضة
### المدة: 1-2 يوم

### 7.1 الإعدادات (`settings_screen.dart`)
- [ ] تنظيم بمجموعات
- [ ] Switches ملونة
- [ ] Dark Mode toggle

### 7.2 Admin Screens
- [ ] Dashboard للإحصائيات
- [ ] جدول المستخدمين
- [ ] HRIS Import wizard

---

## ✨ المرحلة 8: التحسينات المتقدمة

### الحالة: ⏳ قادمة
### الأولوية: 🟢 منخفضة
### المدة: 1 أسبوع

### 8.1 Dark Mode 🌙
- [ ] تعريف dark theme
- [ ] اختبار كل الشاشات
- [ ] Smooth transition

### 8.2 Animations ✨
- [ ] Hero animations
- [ ] Fade/Slide transitions
- [ ] Loading skeletons (Shimmer)
- [ ] Success/Error animations

### 8.3 Responsive Design 📱💻
- [ ] Breakpoints واضحة
- [ ] Grid columns تتكيف
- [ ] Navigation تتغير
- [ ] اختبار على أحجام مختلفة

### 8.4 Accessibility ♿
- [ ] Semantic labels
- [ ] Screen reader support
- [ ] Keyboard navigation
- [ ] Contrast checking

---

## � أفكار مستقبلية (من التطبيقات المرجعية)

### 📱 من Coursera
#### تجربة الفيديو المحسّنة
```dart
✨ Video Player Enhancements:
- [ ] Playback speed (0.5x - 2x)
- [ ] 10-second skip forward/backward
- [ ] Auto-play next lesson
- [ ] Picture-in-Picture mode
- [ ] Video bookmarks/notes
- [ ] Quality selector (Auto, 360p, 720p, 1080p)
- [ ] Download for offline viewing
```

#### الصفحة الرئيسية الذكية
```dart
HomePage Improvements:
- [ ] "استكمل التعلم" - Quick resume cards (آخر 3 كورسات)
- [ ] "موصى به لك" - AI-driven recommendations
- [ ] Weekly streak counter بتصميم جذاب
- [ ] Pull-to-refresh
- [ ] Skeleton loaders بدلاً من spinners
```

### 🎮 من Duolingo
#### League System
```dart
✨ Leagues (تنافس أسبوعي):
- [ ] 5 مستويات: Bronze → Silver → Gold → Platinum → Diamond
- [ ] Promotion/Relegation كل أسبوع
- [ ] Top 3 في كل league يحصلون على مكافآت خاصة
- [ ] Leaderboard أسبوعي لكل league
```

#### Daily Quests System
```dart
✨ مهام يومية متجددة (3 مهام/يوم):
- [ ] "أكمل 3 دروس اليوم" → +50 XP
- [ ] "احصل على 5 نجوم في Quiz" → +30 XP
- [ ] "شارك إنجازك" → +20 XP
- [ ] Animated rewards عند إكمال المهمة
```

#### Streak Enhancements
```dart
✨ Streak Features:
- [ ] رسوم متحركة نارية 🔥 عند إكمال الـ streak
- [ ] Streak Freeze: حفظ الـ streak ليوم واحد (يمكن شراؤه)
- [ ] Streak Rewards: شارات خاصة (7, 30, 100, 365 يوم)
- [ ] Streak Restoration: استعادة streak مفقود (مرة واحدة)
```

### 📚 من Udemy
#### Q&A System لكل درس
```dart
✨ Features:
- [ ] سؤال وجواب مرتبط بكل lesson
- [ ] Upvote/Downvote للأجوبة
- [ ] Filter: All, Unanswered, Most voted
- [ ] Instructor can mark "Best Answer"
- [ ] Search في الأسئلة السابقة
- [ ] Notifications للمدرب عند سؤال جديد
- [ ] Auto-suggest من الأسئلة المشابهة
```

#### Enhanced Analytics Dashboard
```dart
📊 New Charts للمدربين:
- [ ] Student Progress Heatmap (من يتقدم ومن متوقف)
- [ ] Lesson Drop-off Points (أين يتوقف الطلاب)
- [ ] Engagement Timeline (نشاط الطلاب عبر الوقت)
- [ ] Quiz Performance Analysis (أصعب الأسئلة)
- [ ] Time Spent per Module
- [ ] Revenue tracking (لو في اشتراكات)
```

### 🎓 من Khan Academy
#### Mastery System
```dart
✨ 4 مستويات لكل مهارة:
- [ ] Attempted (محاولة) - أول مرة
- [ ] Familiar (مألوف) - 60-80%
- [ ] Proficient (متقن) - 80-95%
- [ ] Mastered (إتقان) - 95%+
- [ ] Color-coded progress (رمادي → أصفر → برتقالي → أخضر)
- [ ] Re-testing بعد فترة للتأكد من الاحتفاظ
```

#### Learning Path Visualization
```dart
✨ Skill Tree:
- [ ] عرض مرئي لمسار التعلم
- [ ] Unlock system (أكمل المستوى للوصول للتالي)
- [ ] Prerequisites واضحة
- [ ] Branching paths (مسارات متعددة)
```

---

## 🔮 أفكار متقدمة (Long-term)

### 🎥 Live Classes Integration
```dart
Features:
- [ ] جدولة حصص مباشرة
- [ ] تكامل مع Zoom/Google Meet
- [ ] Whiteboard مشترك
- [ ] Screen sharing
- [ ] Recording وحفظه في المحتوى
- [ ] Chat مباشر أثناء الحصة
```

### 📜 Certificate System
```dart
✨ Certificates:
- [ ] Auto-generated عند الإكمال 100%
- [ ] QR code للتحقق من صحة الشهادة
- [ ] LinkedIn integration (مشاركة مباشرة)
- [ ] Company branding على الشهادة
- [ ] Digital wallet integration
- [ ] PDF download
```

### 🤝 Social Learning Features
```dart
✨ Social:
- [ ] Follow System: المتدربون يتابعون بعض
- [ ] Study Groups: مجموعات دراسة داخل الكورس
- [ ] Share Achievements: مشاركة على السوشيال ميديا
- [ ] Peer Review: المتدربون يراجعون أعمال بعض
- [ ] Discussion Forums: منتدى لكل كورس
```

### 🧠 Adaptive Learning Path (AI)
```dart
AI-Powered:
- [ ] تحليل نقاط ضعف المتدرب
- [ ] اقتراح دروس إضافية للتقوية
- [ ] تخطي المحتوى المعروف (بناءً على اختبار تحديد مستوى)
- [ ] Personalized study plan
- [ ] Difficulty adjustment بناءً على الأداء
```

---

## �🛠️ الأدوات والموارد

### Design Tokens
```dart
// الموقع: lib/core/design/tokens.dart
DesignTokens.background(context)
DesignTokens.surface(context)
DesignTokens.textPrimary(context)
DesignTokens.h1(context) - DesignTokens.h6(context)
DesignTokens.shadowMd(context)
```

### Widgets المشتركة (قيد الإنشاء)
```dart
// AppCard - كارت موحد
// AppTextField - حقل إدخال موحد  
// AppButton - زر موحد
// AppAvatar - صورة مستخدم موحدة
```

### مراجع التصميم
- [Material Design 3](https://m3.material.io/)
- [Facebook Design](https://www.facebook.com/design)
- [Duolingo Design](https://www.duolingo.com/)
- [Coursera Mobile](https://www.coursera.org/)
- [Udemy Design System](https://www.udemy.com/)
- [Khan Academy](https://www.khanacademy.org/)

---

## 📊 مؤشرات الأداء

### KPIs للمتابعة
- [ ] عدد الشاشات المكتملة: **2/15** (13%)
- [ ] نسبة تطبيق Design System: **15%**
- [ ] اختبار Light/Dark Mode: **2/15 شاشة**
- [ ] اختبار Responsive: **2/15 شاشة**
- [ ] عدد الـ Widgets المشتركة: **0/10**

---

## 📝 ملاحظات عامة

### قبل بداية أي مرحلة
1. ✅ فحص الكود الحالي
2. ✅ أخذ Screenshot للمقارنة
3. ✅ عمل Git commit

### أثناء التطوير
1. 🔨 استخدام Design Tokens دائماً
2. 🔨 اختبار Light/Dark Mode
3. 🔨 اختبار Responsive
4. 🔨 اختبار RTL (العربية)

### بعد كل مرحلة
1. ✅ اختبار كل الوظائف
2. ✅ Git commit
3. ✅ تحديث Checklist
4. ✅ Screenshot للمقارنة

---

## 🎯 الخطوة القادمة

**المرحلة الحالية**: المرحلة 3 - الشاشات الرئيسية

**المهمة التالية**: تحديث شاشة الـ Trainer Home Screen

**الوقت المتوقع**: 4-6 ساعات عمل

**الأولوية**: 🔴 عالية جداً

---

**آخر تحديث**: 17 أكتوبر 2025 - 23:30
