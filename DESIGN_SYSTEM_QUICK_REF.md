# 🚀 Quick Reference - Design System

**آخر تحديث**: 17 أكتوبر 2025

---

## 📦 استيراد Design Tokens

```dart
import 'package:training_app/core/design/tokens.dart';
```

---

## 🎨 الألوان (Colors)

### الألوان التكيفية (تتغير مع Light/Dark Mode)

```dart
// الخلفية الرئيسية
Container(
  color: DesignTokens.background(context),
)

// السطح (الكروت)
Container(
  color: DesignTokens.surface(context),
)

// خلفية الحقول
TextField(
  decoration: InputDecoration(
    fillColor: DesignTokens.fillColor(context),
  ),
)

// الحدود
Container(
  decoration: BoxDecoration(
    border: Border.all(color: DesignTokens.borderColor(context)),
  ),
)

// النص الأساسي
Text(
  'مرحباً',
  style: TextStyle(color: DesignTokens.textPrimary(context)),
)

// النص الثانوي
Text(
  'وصف',
  style: TextStyle(color: DesignTokens.textSecondary(context)),
)

// النص على الألوان (الأزرار)
ElevatedButton(
  style: ElevatedButton.styleFrom(
    foregroundColor: DesignTokens.textOnColor(context),
  ),
)
```

### الألوان الثابتة

```dart
// النجاح (أخضر)
DesignTokens.success  // #42B72A

// الخطأ (أحمر)
DesignTokens.error  // #E41E3F

// التحذير (برتقالي)
DesignTokens.warning  // #FFC107

// المعلومات (أزرق)
DesignTokens.info  // #1877F2
```

---

## 📏 المسافات (Spacing)

```dart
// XXS = 2px
SizedBox(height: DesignTokens.spacingXxs)

// XS = 4px
SizedBox(height: DesignTokens.spacingXs)

// SM = 8px
SizedBox(height: DesignTokens.spacingSm)

// MD = 12px ⭐ الأكثر استخداماً
SizedBox(height: DesignTokens.spacingMd)

// LG = 16px ⭐ الأكثر استخداماً
SizedBox(height: DesignTokens.spacingLg)

// XL = 24px
SizedBox(height: DesignTokens.spacingXl)

// XXL = 32px
SizedBox(height: DesignTokens.spacingXxl)

// 3XL = 48px
SizedBox(height: DesignTokens.spacing3xl)
```

---

## 📐 Border Radius

```dart
// XS = 4px
BorderRadius.circular(DesignTokens.radiusXs)

// SM = 8px
BorderRadius.circular(DesignTokens.radiusSm)

// MD = 10px ⭐ للحقول والأزرار
BorderRadius.circular(DesignTokens.radiusMd)

// LG = 12px ⭐ للكروت
BorderRadius.circular(DesignTokens.radiusLg)

// XL = 16px
BorderRadius.circular(DesignTokens.radiusXl)

// Full = 999px (دائري كامل)
BorderRadius.circular(DesignTokens.radiusFull)
```

---

## ✍️ الخطوط (Typography)

### العناوين

```dart
// H1 - 56px, Bold (للعناوين الرئيسية الكبيرة)
Text('عنوان كبير', style: DesignTokens.h1(context))

// H2 - 48px, Bold
Text('عنوان', style: DesignTokens.h2(context))

// H3 - 36px, Bold
Text('عنوان', style: DesignTokens.h3(context))

// H4 - 28px, Bold ⭐ عناوين الكروت
Text('عنوان', style: DesignTokens.h4(context))

// H5 - 24px, Semi-bold
Text('عنوان', style: DesignTokens.h5(context))

// H6 - 20px, Semi-bold ⭐ عناوين فرعية
Text('عنوان', style: DesignTokens.h6(context))
```

### النصوص العادية

```dart
// Body1 - 16px ⭐ النص الأساسي
Text('نص عادي', style: DesignTokens.body1(context))

// Body2 - 14px (نصوص ثانوية)
Text('نص صغير', style: DesignTokens.body2(context))

// Caption - 12px (نصوص صغيرة جداً)
Text('ملاحظة', style: DesignTokens.caption(context))

// Button - 17px, Semi-bold (نصوص الأزرار)
Text('زر', style: DesignTokens.button(context))
```

### تخصيص الخط

```dart
// إضافة لون
Text(
  'نص',
  style: DesignTokens.h4(context).copyWith(
    color: theme.colorScheme.primary,
  ),
)

// إضافة وزن
Text(
  'نص',
  style: DesignTokens.body1(context).copyWith(
    fontWeight: FontWeight.bold,
  ),
)
```

---

## 🌫️ الظلال (Shadows)

```dart
// Small Shadow (للعناصر الصغيرة)
Container(
  decoration: BoxDecoration(
    boxShadow: DesignTokens.shadowSm(context),
  ),
)

// Medium Shadow ⭐ للكروت
Container(
  decoration: BoxDecoration(
    boxShadow: DesignTokens.shadowMd(context),
  ),
)

// Large Shadow (للعناصر المرتفعة)
Container(
  decoration: BoxDecoration(
    boxShadow: DesignTokens.shadowLg(context),
  ),
)
```

---

## ⏱️ Animations

```dart
// Fast - 150ms (تفاعلات سريعة)
AnimatedContainer(
  duration: DesignTokens.durationFast,
)

// Medium - 300ms ⭐ الأكثر استخداماً
AnimatedOpacity(
  duration: DesignTokens.durationMedium,
)

// Slow - 500ms (تحولات كبيرة)
AnimatedSwitcher(
  duration: DesignTokens.durationSlow,
)
```

---

## 📦 أمثلة كاملة

### كارت بسيط

```dart
Container(
  padding: EdgeInsets.all(DesignTokens.spacingLg),
  decoration: BoxDecoration(
    color: DesignTokens.surface(context),
    borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
    boxShadow: DesignTokens.shadowMd(context),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('العنوان', style: DesignTokens.h4(context)),
      SizedBox(height: DesignTokens.spacingSm),
      Text('الوصف', style: DesignTokens.body1(context)),
    ],
  ),
)
```

### حقل إدخال

```dart
TextFormField(
  style: DesignTokens.body1(context),
  decoration: InputDecoration(
    hintText: 'أدخل النص',
    hintStyle: DesignTokens.body1(context).copyWith(
      color: DesignTokens.textSecondary(context),
    ),
    filled: true,
    fillColor: DesignTokens.fillColor(context),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      borderSide: BorderSide(
        color: DesignTokens.borderColor(context),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      borderSide: BorderSide(
        color: theme.colorScheme.primary,
        width: 2,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: DesignTokens.spacingLg,
      vertical: DesignTokens.spacingLg,
    ),
  ),
)
```

### زر

```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: theme.colorScheme.primary,
    foregroundColor: DesignTokens.textOnColor(context),
    padding: EdgeInsets.symmetric(
      horizontal: DesignTokens.spacingXl,
      vertical: DesignTokens.spacingLg,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
    ),
    elevation: 0,
  ),
  child: Text('زر', style: DesignTokens.button(context)),
)
```

### Scaffold كامل

```dart
Scaffold(
  backgroundColor: DesignTokens.background(context),
  appBar: AppBar(
    backgroundColor: DesignTokens.surface(context),
    elevation: 0,
    title: Text('العنوان', style: DesignTokens.h6(context)),
  ),
  body: Padding(
    padding: EdgeInsets.all(DesignTokens.spacingLg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('مرحباً', style: DesignTokens.h4(context)),
        SizedBox(height: DesignTokens.spacingMd),
        Text('وصف', style: DesignTokens.body1(context)),
      ],
    ),
  ),
)
```

---

## 🎯 نصائح سريعة

### ✅ افعل

```dart
✅ استخدم Design Tokens دائماً
✅ اختبر Light و Dark Mode
✅ استخدم .copyWith() للتخصيص
✅ استخدم spacingMd و spacingLg بكثرة
✅ استخدم radiusLg للكروت
✅ استخدم radiusMd للحقول والأزرار
```

### ❌ لا تفعل

```dart
❌ Colors.grey[50]  // استخدم DesignTokens.background(context)
❌ Colors.white     // استخدم DesignTokens.surface(context)
❌ fontSize: 16     // استخدم DesignTokens.body1(context)
❌ SizedBox(height: 12)  // استخدم DesignTokens.spacingMd
❌ BorderRadius.circular(10)  // استخدم DesignTokens.radiusMd
```

---

## 📱 Responsive Design

```dart
double getPadding(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width > 900) return DesignTokens.spacing3xl;  // Desktop
  if (width > 600) return DesignTokens.spacingXl;   // Tablet
  return DesignTokens.spacingLg;                    // Mobile
}

int getColumns(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width > 900) return 3;  // Desktop
  if (width > 600) return 2;  // Tablet
  return 1;                   // Mobile
}
```

---

## 🌓 Light vs Dark Mode

### Light Mode
```
Background: #F0F2F5 (رمادي فاتح)
Surface: #FFFFFF (أبيض)
Fill: #F0F2F5 (رمادي فاتح)
Border: #CED0D4 (رمادي)
Text Primary: #050505 (أسود تقريباً)
Text Secondary: #65676B (رمادي)
```

### Dark Mode
```
Background: #18191A (رمادي داكن جداً)
Surface: #242526 (رمادي داكن)
Fill: #3A3B3C (رمادي متوسط)
Border: #3E4042 (رمادي)
Text Primary: #E4E6EB (أبيض رمادي)
Text Secondary: #B0B3B8 (رمادي فاتح)
```

---

## 🔗 روابط سريعة

- 📄 [الخطة الكاملة](./UI_UX_IMPROVEMENT_PLAN.md)
- 📄 [متابعة التقدم](./PROGRESS_TRACKING.md)
- 📄 [Design Tokens](./lib/core/design/tokens.dart)

---

**نصيحة أخيرة**: احفظ هذا الملف في Bookmarks للرجوع إليه بسرعة! 🔖

---

## 🚀 أمثلة متقدمة

### Responsive Grid

```dart
// تحديد عدد الأعمدة حسب حجم الشاشة
int _getCrossAxisCount(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width > 900) return 3;  // Desktop
  if (width > 600) return 2;  // Tablet
  return 1;                   // Mobile
}

// استخدام في Grid
SliverGrid(
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
)
```

### شاشة كاملة بـ Design System

```dart
class ExampleScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: DesignTokens.background(context),
      appBar: AppBar(
        backgroundColor: DesignTokens.surface(context),
        elevation: 0,
        title: Text(
          'مثال',
          style: DesignTokens.h6(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh logic
        },
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(DesignTokens.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('مرحباً!', style: DesignTokens.h4(context)),
                    SizedBox(height: DesignTokens.spacingSm),
                    Text(
                      'هذا مثال على شاشة كاملة',
                      style: DesignTokens.body1(context).copyWith(
                        color: DesignTokens.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Grid
            SliverPadding(
              padding: EdgeInsets.all(DesignTokens.spacingLg),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(context),
                  mainAxisSpacing: DesignTokens.spacingLg,
                  crossAxisSpacing: DesignTokens.spacingLg,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildCard(context),
                  childCount: 10,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: DesignTokens.textOnColor(context),
        icon: Icon(Icons.add),
        label: Text('جديد', style: DesignTokens.button(context)),
      ),
    );
  }
  
  Widget _buildCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DesignTokens.spacingLg),
      decoration: BoxDecoration(
        color: DesignTokens.surface(context),
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        boxShadow: DesignTokens.shadowMd(context),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: Theme.of(context).colorScheme.primary,
            size: 32,
          ),
          SizedBox(height: DesignTokens.spacingSm),
          Text('عنوان', style: DesignTokens.h6(context)),
          Text('وصف', style: DesignTokens.caption(context)),
        ],
      ),
    );
  }
}
```

### حالات Loading/Empty/Error

```dart
// Loading State (Shimmer)
class LoadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DesignTokens.spacingLg),
      decoration: BoxDecoration(
        color: DesignTokens.surface(context),
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: DesignTokens.fillColor(context),
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            ),
          ),
          SizedBox(height: DesignTokens.spacingMd),
          Container(
            height: 20,
            width: double.infinity,
            color: DesignTokens.fillColor(context),
          ),
          SizedBox(height: DesignTokens.spacingSm),
          Container(
            height: 16,
            width: 150,
            color: DesignTokens.fillColor(context),
          ),
        ],
      ),
    );
  }
}

// Empty State
class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionLabel;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(DesignTokens.spacingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: DesignTokens.textSecondary(context),
            ),
            SizedBox(height: DesignTokens.spacingLg),
            Text(
              message,
              style: DesignTokens.h6(context),
              textAlign: TextAlign.center,
            ),
            if (onAction != null) ...[
              SizedBox(height: DesignTokens.spacingXl),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: DesignTokens.textOnColor(context),
                  padding: EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacingXl,
                    vertical: DesignTokens.spacingMd,
                  ),
                ),
                child: Text(
                  actionLabel ?? 'ابدأ الآن',
                  style: DesignTokens.button(context),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Error State
class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(DesignTokens.spacingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: DesignTokens.error,
            ),
            SizedBox(height: DesignTokens.spacingLg),
            Text(
              'حدث خطأ',
              style: DesignTokens.h5(context),
            ),
            SizedBox(height: DesignTokens.spacingSm),
            Text(
              message,
              style: DesignTokens.body1(context).copyWith(
                color: DesignTokens.textSecondary(context),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: DesignTokens.spacingXl),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: Icon(Icons.refresh),
              label: Text('حاول مرة أخرى'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: DesignTokens.textOnColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Bottom Sheet مع Design System

```dart
void showExampleBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: DesignTokens.surface(context),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(DesignTokens.radiusXl),
      ),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.all(DesignTokens.spacingLg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: DesignTokens.borderColor(context),
                borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
              ),
            ),
          ),
          SizedBox(height: DesignTokens.spacingLg),
          
          // Title
          Text('خيارات', style: DesignTokens.h5(context)),
          SizedBox(height: DesignTokens.spacingMd),
          
          // Options
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('تعديل', style: DesignTokens.body1(context)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, color: DesignTokens.error),
            title: Text(
              'حذف',
              style: DesignTokens.body1(context).copyWith(
                color: DesignTokens.error,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}
```

### Dialog مع Design System

```dart
void showExampleDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: DesignTokens.surface(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      ),
      title: Text('تأكيد', style: DesignTokens.h5(context)),
      content: Text(
        'هل أنت متأكد من الحذف؟',
        style: DesignTokens.body1(context),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'إلغاء',
            style: DesignTokens.button(context).copyWith(
              color: DesignTokens.textSecondary(context),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            // Delete logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: DesignTokens.error,
            foregroundColor: DesignTokens.textOnColor(context),
          ),
          child: Text('حذف', style: DesignTokens.button(context)),
        ),
      ],
    ),
  );
}
```

---

## 🎨 Design Patterns شائعة

### Status Badge (Published/Draft/etc)

```dart
Widget _buildStatusBadge(String status) {
  Color color;
  String text;
  
  switch (status) {
    case 'published':
      color = DesignTokens.success;
      text = 'منشور';
      break;
    case 'draft':
      color = DesignTokens.warning;
      text = 'مسودة';
      break;
    case 'archived':
      color = DesignTokens.textSecondary(context);
      text = 'مؤرشف';
      break;
    default:
      color = DesignTokens.info;
      text = status;
  }
  
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: DesignTokens.spacingSm,
      vertical: DesignTokens.spacingXs,
    ),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      border: Border.all(color: color.withOpacity(0.5)),
    ),
    child: Text(
      text,
      style: DesignTokens.caption(context).copyWith(
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
```

### Progress Bar مع نسبة

```dart
Widget _buildProgressBar(BuildContext context, double percentage) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('التقدم', style: DesignTokens.caption(context)),
          Text(
            '${percentage.toInt()}%',
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
          value: percentage / 100,
          backgroundColor: DesignTokens.fillColor(context),
          valueColor: AlwaysStoppedAnimation(
            percentage < 30
                ? DesignTokens.error
                : percentage < 70
                    ? DesignTokens.warning
                    : DesignTokens.success,
          ),
          minHeight: 6,
        ),
      ),
    ],
  );
}
```

### Stat Card (للأرقام)

```dart
Widget _buildStatCard({
  required IconData icon,
  required Color iconColor,
  required String label,
  required String value,
}) {
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
        Text(
          label,
          style: DesignTokens.caption(context),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
```

---

## 🔗 روابط سريعة

- 📄 [الخطة الكاملة](./UI_UX_IMPROVEMENT_PLAN.md) - خطة العمل الشاملة
- 📄 [متابعة التقدم](./PROGRESS_TRACKING.md) - تتبع يومي
- 📄 [Design Tokens](./lib/core/design/tokens.dart) - الملف المصدري
- 📄 [خطة المشروع](./PROJECT_PLAN.md) - النظرة الشاملة

---

**آخر تحديث**: 17 أكتوبر 2025 - 23:55  
**نصيحة**: Ctrl+F للبحث السريع في هذا الملف! 🔍
