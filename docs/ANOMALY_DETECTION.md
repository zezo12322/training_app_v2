# ML Anomaly Detection

## نظرة عامة

نظام كشف الشذوذات (Anomaly Detection) يستخدم تقنيات التحليل الإحصائي لاكتشاف السلوكيات غير الطبيعية في النظام تلقائياً. يساعد هذا النظام في:

- كشف الغش في الاختبارات
- تحديد أنماط تسجيل الدخول المشبوهة
- رصد التقدم غير الواقعي في الدورات
- اكتشاف محاولات الدخول الفاشلة المتكررة

## خوارزميات الكشف

### 1. درجات الاختبارات غير الطبيعية (Unusual Quiz Scores)

**الخوارزمية**: Z-Score Analysis
- **الطريقة**: تحسب متوسط الدرجات والانحراف المعياري للمستخدم
- **المعادلة**: `z = (score - mean) / stdDev`
- **العتبة الافتراضية**: 2.5 انحراف معياري
- **أمثلة**:
  * مستخدم متوسط درجاته 60% حصل على 95%
  * مستخدم فشل في كل اختبار ثم نجح بامتياز فجأة

**الشدة (Severity)**:
- `critical`: z-score > 3.5 (احتمال < 0.02%)
- `high`: z-score > 3.0 (احتمال < 0.13%)
- `medium`: z-score > 2.5 (احتمال < 0.62%)

### 2. أنماط تسجيل الدخول المشبوهة (Suspicious Login)

**الخوارزمية**: Pattern Analysis
- **التحقق من الوقت**: تسجيل دخول خارج ساعات العمل (6 صباحاً - 10 مساءً)
- **الجهاز الجديد**: اكتشاف جهاز أو موقع جديد (قيد التطوير)
- **محاولات فاشلة**: عدد محاولات فاشلة > 5 خلال ساعة

**الشدة**:
- `high`: محاولات فاشلة > 10
- `medium`: محاولات فاشلة > 5
- `low`: تسجيل دخول في وقت غير عادي

### 3. التقدم السريع (Rapid Progress)

**الخوارزمية**: Time Analysis
- **المنطق**: حساب الوقت بين إكمال الاختبارات المتتالية
- **العتبة الافتراضية**: 15 دقيقة
- **أمثلة**:
  * إكمال 3 اختبارات في 10 دقائق
  * إنهاء دورة كاملة في يوم واحد

**الشدة**:
- `high`: وقت < 5 دقائق
- `medium`: وقت < 10 دقائق
- `low`: وقت < 15 دقيقة

### 4. محاولات الفشل المتكررة (Multiple Failed Attempts)

**الخوارزمية**: Failure Pattern Analysis
- **المنطق**: حساب عدد محاولات الفشل المتتالية
- **العتبة الافتراضية**: 3 محاولات فاشلة متتالية
- **الهدف**: اكتشاف المستخدمين الذين يحتاجون مساعدة أو تدخل

**الشدة**:
- `high`: فشل > 5 مرات متتالية
- `medium`: فشل > 3 مرات

### 5. أنماط الوصول غير الطبيعية (Unusual Access Pattern)

**الخوارزمية**: Behavior Analysis (قيد التطوير)
- الوصول إلى صفحات غير مصرح بها
- تغييرات مشبوهة في البيانات
- استخدام API غير عادي

### 6. عدم اتساق البيانات (Data Inconsistency)

**الخوارزمية**: Validation Checks (قيد التطوير)
- بيانات متناقضة في السجلات
- قيم خارج النطاق المتوقع
- علاقات غير صحيحة بين الكيانات

## الاستخدام

### تفعيل الكشف التلقائي

```dart
final service = ref.read(anomalyDetectionServiceProvider);

// تفعيل الكشف
await service.saveSettings(
  AnomalySettings(
    enabled: true,
    quizScoreThreshold: 2.5,
    rapidProgressThreshold: 15,
    loginPatternThreshold: 2.0,
    autoNotify: true,
    autoBlock: false,
    notificationRecipients: ['admin@example.com'],
  ),
);
```

### الكشف اليدوي

```dart
// كشف درجات الاختبارات
final anomalies = await service.detectUnusualQuizScore(
  userId: 'user123',
  quizId: 'quiz456',
  score: 95.0,
  institutionId: 'inst1',
);

// كشف التقدم السريع
await service.detectRapidProgress(
  userId: 'user123',
  courseId: 'course789',
);

// مسح شامل
final allAnomalies = await service.scanForAnomalies(
  institutionId: 'inst1',
);
```

### مراقبة الشذوذات

```dart
// الحصول على جميع الشذوذات
final anomaliesStream = ref.watch(anomaliesStreamProvider('inst1'));

// الحصول على الشذوذات المعلقة فقط
final pendingAnomalies = ref.watch(pendingAnomaliesProvider('inst1'));

// تحديث حالة الشذوذ
await service.updateStatus(
  anomalyId: 'anomaly123',
  status: AnomalyStatus.resolved,
  investigatedBy: 'admin@example.com',
  resolution: 'تم التأكد من أن الطالب حسّن مستواه فعلاً',
);
```

## واجهة المستخدم

### شاشة لوحة التحكم (`AnomalyDashboardScreen`)

**الميزات**:
- عرض الشذوذات في الوقت الفعلي
- تصفية حسب الحالة: جميع | معلقة | محلولة | إيجابيات كاذبة
- تصفية حسب النوع
- رموز الشدة الملونة:
  * 🔴 حرج (Critical)
  * 🟠 عالي (High)
  * 🟡 متوسط (Medium)
  * ⚪ منخفض (Low)

**بطاقة الشذوذ**:
```
┌─────────────────────────────┐
│ 🔴 حرج  درجة اختبار غير طبيعية │
│                              │
│ أحمد محمد                     │
│ حصل على 95% بينما متوسطه 60% │
│ منذ ساعتين                    │
└─────────────────────────────┘
```

**تفاصيل الشذوذ**:
- الوصف الكامل
- البيانات الوصفية (Metadata)
- الأدلة (Evidence)
- إجراءات الحالة:
  * 🔍 تحت التحقيق
  * ✅ تم الحل
  * ❌ إيجابية كاذبة
  * 🚫 تم التجاهل

### شاشة الإعدادات (`AnomalySettingsScreen`)

**التكوين**:

1. **التفعيل العام**
   - مفتاح تفعيل/تعطيل الكشف

2. **عتبات الكشف**
   - درجات الاختبارات: 1.5 - 3.5 انحراف معياري
   - التقدم السريع: 5 - 60 دقيقة
   - أنماط الدخول: 1.0 - 3.0

3. **الإجراءات التلقائية**
   - ✉️ إرسال إشعارات للمسؤولين
   - 🚫 حظر المستخدمين المشبوهين تلقائياً

4. **مستلمو الإشعارات**
   - قائمة بريد إلكتروني للمسؤولين

## نموذج البيانات

### Anomaly

```dart
class Anomaly {
  final String id;
  final AnomalyType type;
  final AnomalySeverity severity;
  final double score;        // 0.0 - 1.0
  final double threshold;
  
  final String userId;
  final String userName;
  final String? institutionId;
  final String? companyId;
  
  final String description;
  final Map<String, dynamic> metadata;
  final List<String> evidence;
  
  final AnomalyStatus status;
  final String? investigatedBy;
  final DateTime? investigatedAt;
  final String? resolution;
  
  final DateTime detectedAt;
  final DateTime? resolvedAt;
}
```

### AnomalySettings

```dart
class AnomalySettings {
  final bool enabled;
  
  final double quizScoreThreshold;      // default: 2.5
  final int rapidProgressThreshold;     // minutes, default: 15
  final double loginPatternThreshold;   // default: 2.0
  
  final bool autoNotify;
  final bool autoBlock;
  final List<String> notificationRecipients;
  
  final String? institutionId;
  final String? companyId;
}
```

## التكامل مع Firestore

### هيكل المجموعات

```
anomalies/
  {anomalyId}/
    id: string
    type: string
    severity: string
    score: number
    threshold: number
    userId: string
    userName: string
    institutionId: string
    companyId: string
    description: string
    metadata: map
    evidence: array
    status: string
    investigatedBy: string
    investigatedAt: timestamp
    resolution: string
    detectedAt: timestamp
    resolvedAt: timestamp

anomaly_settings/
  {institutionId}/
    enabled: boolean
    quizScoreThreshold: number
    rapidProgressThreshold: number
    loginPatternThreshold: number
    autoNotify: boolean
    autoBlock: boolean
    notificationRecipients: array
```

### قواعد الأمان (Security Rules)

```javascript
match /anomalies/{anomalyId} {
  // المسؤولون فقط يمكنهم القراءة
  allow read: if isAdmin();
  
  // النظام فقط يمكنه الكتابة
  allow create: if isSystem();
  
  // المسؤولون يمكنهم تحديث الحالة
  allow update: if isAdmin() && 
    request.resource.data.diff(resource.data).affectedKeys()
      .hasOnly(['status', 'investigatedBy', 'investigatedAt', 'resolution', 'resolvedAt']);
}

match /anomaly_settings/{institutionId} {
  allow read: if isAdmin();
  allow write: if isAdmin();
}
```

## أفضل الممارسات

### 1. ضبط العتبات

**البداية**:
- استخدم العتبات الافتراضية لمدة أسبوع
- راقب عدد الإيجابيات الكاذبة (False Positives)
- اضبط العتبات بناءً على البيانات الفعلية

**التحسين**:
```dart
// إذا كانت الإيجابيات الكاذبة > 30%
settings = settings.copyWith(
  quizScoreThreshold: 3.0,  // زيادة العتبة
);

// إذا كنت تفوت حالات حقيقية
settings = settings.copyWith(
  quizScoreThreshold: 2.0,  // تقليل العتبة
);
```

### 2. معالجة الشذوذات

**سير العمل الموصى به**:
1. **معلقة (Pending)**: كشف تلقائي
2. **تحت التحقيق (Investigating)**: مسؤول يراجع
3. **محلولة (Resolved)**: تم التأكد من المشكلة وحلها
4. **إيجابية كاذبة (False Positive)**: ليست مشكلة حقيقية

**أمثلة**:
```dart
// حالة حقيقية
await service.updateStatus(
  anomalyId: 'anomaly123',
  status: AnomalyStatus.resolved,
  investigatedBy: 'admin@example.com',
  resolution: 'تم حظر الطالب وإلغاء درجته في الاختبار',
);

// إيجابية كاذبة
await service.updateStatus(
  anomalyId: 'anomaly456',
  status: AnomalyStatus.falsePositive,
  investigatedBy: 'admin@example.com',
  resolution: 'الطالب درس بجد فعلاً وتحسن مستواه',
);
```

### 3. الإشعارات

**استراتيجية الإشعارات**:
- فعّل `autoNotify` للشذوذات الحرجة والعالية فقط
- أضف عدة مسؤولين لتوزيع الحمل
- استخدم نظام التناوب (On-call rotation)

```dart
settings = settings.copyWith(
  autoNotify: true,
  notificationRecipients: [
    'admin1@example.com',
    'admin2@example.com',
    'security@example.com',
  ],
);
```

### 4. الحظر التلقائي

**تحذير**: استخدم `autoBlock` بحذر شديد!

**الحالات الآمنة**:
- ✅ محاولات تسجيل دخول فاشلة > 10
- ✅ شذوذات حرجة متكررة من نفس المستخدم

**الحالات غير الآمنة**:
- ❌ درجات اختبارات غير طبيعية (قد تكون تحسن حقيقي)
- ❌ تقدم سريع (قد يكون طالب متفوق)

```dart
// استخدام آمن
settings = settings.copyWith(
  autoBlock: true,  // فقط لمحاولات الدخول المشبوهة
);
```

## التطويرات المستقبلية

### 1. Machine Learning الحقيقي

**حالياً**: إحصائيات بسيطة (Z-scores, Thresholds)
**مستقبلاً**: نماذج ML متقدمة

```dart
// مكتبات مقترحة
dependencies:
  tflite_flutter: ^0.10.0
  ml_linalg: ^13.0.0
```

**النماذج المقترحة**:
- **Isolation Forest**: كشف الشذوذات متعدد الأبعاد
- **Autoencoders**: كشف الأنماط المعقدة
- **LSTM**: تحليل السلاسل الزمنية

### 2. تحليل الموقع الجغرافي

```dart
dependencies:
  geolocator: ^10.0.0
  geocoding: ^2.1.0
```

**الميزات**:
- كشف تسجيل الدخول من مواقع بعيدة
- رصد السفر المستحيل (Impossible Travel)
- تحليل نطاق IP

### 3. تحليل السلوك البيومتري

**الميزات**:
- سرعة الكتابة (Typing Speed)
- أنماط النقر (Click Patterns)
- حركة الماوس (Mouse Movement)

### 4. التكامل مع أنظمة خارجية

```dart
// إرسال للأنظمة الأمنية
await http.post(
  'https://siem.company.com/api/alerts',
  body: jsonEncode(anomaly.toJson()),
);

// تكامل مع Slack/Teams
await slack.sendMessage(
  channel: '#security-alerts',
  message: 'Detected critical anomaly: ${anomaly.description}',
);
```

## الأسئلة الشائعة

### س: كيف أقلل من الإيجابيات الكاذبة؟

**ج**: 
1. زد عتبة Z-score من 2.5 إلى 3.0
2. راقب النتائج لمدة أسبوع
3. استبعد أنواع الشذوذات غير المفيدة
4. استخدم قوائم بيضاء للمستخدمين الموثوقين

### س: هل يمكن استخدام ML حقيقي؟

**ج**: نعم! يمكن التكامل مع:
- TensorFlow Lite لـ Flutter
- Google Cloud AI Platform
- Azure ML
- خدمات API مخصصة

### س: كيف أحسّن الأداء؟

**ج**:
1. استخدم Firestore Indexes للاستعلامات المعقدة
2. نفّذ Caching للبيانات الإحصائية
3. استخدم Cloud Functions للمسح الشامل الدوري
4. قلل فترة الاحتفاظ بالشذوذات القديمة

### س: هل يمكن تخصيص خوارزميات الكشف؟

**ج**: نعم! يمكنك:
1. إضافة أنواع شذوذات جديدة في `AnomalyType`
2. تعديل دوال الكشف في `AnomalyDetectionService`
3. تخصيص حسابات الشدة
4. إنشاء قواعد كشف خاصة بمجالك

## الخلاصة

نظام كشف الشذوذات يوفر:
- ✅ كشف تلقائي للسلوكيات غير الطبيعية
- ✅ 6 أنواع من الشذوذات
- ✅ واجهة مستخدم شاملة
- ✅ قابل للتخصيص والتوسع
- ✅ جاهز للإنتاج

**الاستخدام الأمثل**: راقب، اضبط، تعلم، حسّن!
