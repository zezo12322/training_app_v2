# BigQuery Export Feature - نظام تصدير BigQuery

## نظرة عامة

نظام تصدير البيانات التدريبية إلى Google BigQuery للتحليلات المتقدمة والتقارير والذكاء الاصطناعي.

## الميزات

### 1. تصدير أنواع متعددة من البيانات
- **المستخدمين** - بيانات الحسابات والملفات الشخصية
- **الدورات** - معلومات الدورات التدريبية
- **التسجيلات** - تسجيلات المستخدمين في الدورات
- **نتائج الاختبارات** - درجات وأداء الاختبارات
- **الشهادات** - الشهادات الصادرة
- **النقاط والإنجازات** - بيانات التحفيز
- **جميع البيانات** - تصدير شامل

### 2. إدارة الإعدادات
- **معلومات المشروع** - Project ID, Dataset ID
- **المصادقة** - Service Account JSON
- **أنواع مفعّلة** - اختيار البيانات المراد تصديرها
- **الجدولة** - يدوي، يومي، أسبوعي، شهري

### 3. تتبع العمليات
- **حالات متعددة** - pending, processing, uploading, completed, failed
- **التقدم الفوري** - تحديث عدد السجلات المُصدّرة
- **سجل كامل** - جميع عمليات التصدير السابقة
- **معالجة الأخطاء** - تسجيل وعرض الأخطاء

### 4. مخططات بيانات محددة مسبقاً
- **مخططات جاهزة** - لكل نوع بيانات
- **أنواع صحيحة** - STRING, INTEGER, FLOAT, BOOLEAN, TIMESTAMP
- **حقول موثقة** - وصف لكل حقل

## البنية التقنية

### النماذج

#### BigQueryExport
```dart
class BigQueryExport {
  String id;
  String institutionId;
  String? companyId;
  ExportType exportType;       // users, courses, enrollments, etc.
  ExportStatus status;         // pending, processing, uploading, completed, failed
  ExportFrequency frequency;   // manual, daily, weekly, monthly
  String projectId;            // Google Cloud Project ID
  String datasetId;            // BigQuery Dataset ID
  String tableId;              // BigQuery Table ID
  int totalRecords;
  int exportedRecords;
  int failedRecords;
  List<String> errors;
  String triggeredBy;
  String triggeredByName;
  DateTime startedAt;
  DateTime? completedAt;
  String? cronExpression;
  DateTime? nextRunAt;
  bool? isEnabled;
}
```

#### BigQueryConfig
```dart
class BigQueryConfig {
  String id;
  String institutionId;
  String? companyId;
  String projectId;
  String datasetId;
  String credentialsJson;      // Service Account JSON
  bool isEnabled;
  List<ExportType> enabledExports;
  ExportFrequency? defaultFrequency;
  String? defaultCronExpression;
  DateTime createdAt;
  String createdBy;
  DateTime? updatedAt;
  String? updatedBy;
}
```

#### ExportSchema
```dart
class ExportSchema {
  ExportType exportType;
  String tableName;
  String description;
  List<SchemaField> fields;
}

class SchemaField {
  String name;
  String type;        // STRING, INTEGER, FLOAT, BOOLEAN, TIMESTAMP
  String mode;        // REQUIRED, NULLABLE, REPEATED
  String? description;
}
```

### المخططات المحددة مسبقاً

#### 1. Users Schema
```sql
CREATE TABLE `project.dataset.users` (
  user_id STRING NOT NULL,
  email STRING NOT NULL,
  name STRING NOT NULL,
  role STRING NOT NULL,
  institution_id STRING NOT NULL,
  company_id STRING,
  created_at TIMESTAMP NOT NULL,
  last_login_at TIMESTAMP
);
```

#### 2. Courses Schema
```sql
CREATE TABLE `project.dataset.courses` (
  course_id STRING NOT NULL,
  title STRING NOT NULL,
  description STRING,
  category STRING,
  level STRING,
  duration_hours FLOAT,
  instructor_id STRING,
  institution_id STRING NOT NULL,
  created_at TIMESTAMP NOT NULL
);
```

#### 3. Enrollments Schema
```sql
CREATE TABLE `project.dataset.enrollments` (
  enrollment_id STRING NOT NULL,
  user_id STRING NOT NULL,
  course_id STRING NOT NULL,
  enrolled_at TIMESTAMP NOT NULL,
  completed_at TIMESTAMP,
  progress_percentage FLOAT,
  status STRING NOT NULL
);
```

#### 4. Quiz Results Schema
```sql
CREATE TABLE `project.dataset.quiz_results` (
  result_id STRING NOT NULL,
  user_id STRING NOT NULL,
  quiz_id STRING NOT NULL,
  course_id STRING NOT NULL,
  score FLOAT NOT NULL,
  max_score FLOAT NOT NULL,
  percentage FLOAT NOT NULL,
  passed BOOLEAN NOT NULL,
  completed_at TIMESTAMP NOT NULL,
  time_spent_seconds INTEGER
);
```

#### 5. Certificates Schema
```sql
CREATE TABLE `project.dataset.certificates` (
  certificate_id STRING NOT NULL,
  user_id STRING NOT NULL,
  course_id STRING NOT NULL,
  certificate_number STRING NOT NULL,
  issued_at TIMESTAMP NOT NULL,
  verification_code STRING NOT NULL
);
```

#### 6. Gamification Schema
```sql
CREATE TABLE `project.dataset.gamification` (
  record_id STRING NOT NULL,
  user_id STRING NOT NULL,
  event_type STRING NOT NULL,
  points_earned INTEGER,
  total_points INTEGER,
  achievement_id STRING,
  occurred_at TIMESTAMP NOT NULL
);
```

### الخدمات

#### BigQueryExportService
```dart
// بدء التصدير
Future<BigQueryExport> startExport({
  required ExportType exportType,
  required String institutionId,
  String? companyId,
  required String userId,
  required String userName,
  required BigQueryConfig config,
})

// جمع البيانات حسب النوع
Future<List<Map<String, dynamic>>> _exportDataByType(
  ExportType type,
  String institutionId,
  String? companyId,
)

// رفع إلى BigQuery (محاكاة)
Future<void> _uploadToBigQuery(
  BigQueryExport export,
  List<Map<String, dynamic>> data,
  BigQueryConfig config,
)

// إدارة الإعدادات
Future<bool> saveConfig(BigQueryConfig config)
Future<BigQueryConfig?> getConfig(String institutionId)

// سجل التصديرات
Stream<List<BigQueryExport>> getExportsHistory(String institutionId)
```

### الشاشات

#### BigQuerySettingsScreen
- إدخال Project ID و Dataset ID
- إعداد Service Account JSON
- تفعيل/تعطيل التصدير
- اختيار أنواع البيانات المفعّلة
- تحديد الجدولة الافتراضية

#### BigQueryExportScreen
- بدء تصدير جديد
- اختيار نوع البيانات
- عرض سجل التصديرات
- تتبع التقدم الفوري
- عرض التفاصيل والأخطاء

## سير العمل

### 1. الإعداد الأولي

```
المسؤول → BigQuerySettingsScreen
         ↓
إدخال Project ID: "my-training-project"
إدخال Dataset ID: "training_data"
إدخال Service Account JSON: {...}
         ↓
اختيار أنواع البيانات:
  ☑ المستخدمين
  ☑ الدورات
  ☑ التسجيلات
  ☑ نتائج الاختبارات
         ↓
حفظ الإعدادات
```

### 2. بدء التصدير

```
المستخدم → BigQueryExportScreen
         ↓
اختيار نوع: "المستخدمين"
         ↓
بدء التصدير
         ↓
BigQueryExportService.startExport()
         ↓
الحالة: pending → processing → uploading → completed
```

### 3. معالجة البيانات

```
جمع البيانات من Firestore:
  - users collection
  - WHERE institutionId = '...'
         ↓
تحويل إلى تنسيق BigQuery:
  {
    "user_id": "abc123",
    "email": "user@example.com",
    "name": "John Doe",
    ...
  }
         ↓
رفع إلى BigQuery:
  INSERT INTO `project.dataset.users`
  VALUES (...)
         ↓
تحديث التقدم: 100/500 سجل
```

### 4. التحقق

```
BigQuery Console
         ↓
SELECT * FROM `my-training-project.training_data.users`
LIMIT 10;
         ↓
عرض البيانات المُصدّرة
```

## مثال استخدام

### 1. إعداد Google Cloud

```bash
# 1. إنشاء مشروع Google Cloud
gcloud projects create my-training-project

# 2. تفعيل BigQuery API
gcloud services enable bigquery.googleapis.com

# 3. إنشاء Service Account
gcloud iam service-accounts create bigquery-exporter \
  --display-name="BigQuery Exporter"

# 4. منح الصلاحيات
gcloud projects add-iam-policy-binding my-training-project \
  --member="serviceAccount:bigquery-exporter@my-training-project.iam.gserviceaccount.com" \
  --role="roles/bigquery.dataEditor"

# 5. إنشاء مفتاح JSON
gcloud iam service-accounts keys create service-account-key.json \
  --iam-account=bigquery-exporter@my-training-project.iam.gserviceaccount.com
```

### 2. إنشاء Dataset في BigQuery

```sql
-- في BigQuery Console
CREATE SCHEMA `my-training-project.training_data`
OPTIONS(
  location="US",
  description="Training application data"
);
```

### 3. الاستخدام في التطبيق

```dart
// في الواجهة
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => BigQuerySettingsScreen(),
  ),
);

// إدخال الإعدادات:
// Project ID: my-training-project
// Dataset ID: training_data
// Service Account JSON: <محتوى service-account-key.json>

// ثم
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => BigQueryExportScreen(),
  ),
);

// اختيار: المستخدمين
// بدء التصدير
// ✅ تم تصدير 1,234 مستخدم بنجاح
```

### 4. استعلامات BigQuery

```sql
-- إجمالي المستخدمين لكل دور
SELECT 
  role,
  COUNT(*) as total_users
FROM `my-training-project.training_data.users`
GROUP BY role;

-- أداء الاختبارات
SELECT 
  u.name,
  AVG(qr.percentage) as avg_score,
  COUNT(qr.result_id) as total_quizzes
FROM `my-training-project.training_data.quiz_results` qr
JOIN `my-training-project.training_data.users` u ON qr.user_id = u.user_id
WHERE qr.passed = true
GROUP BY u.name
ORDER BY avg_score DESC
LIMIT 10;

-- معدل الإكمال
SELECT 
  c.title as course_name,
  COUNT(e.enrollment_id) as total_enrollments,
  SUM(IF(e.completed_at IS NOT NULL, 1, 0)) as completed,
  ROUND(SUM(IF(e.completed_at IS NOT NULL, 1, 0)) * 100.0 / COUNT(e.enrollment_id), 2) as completion_rate
FROM `my-training-project.training_data.enrollments` e
JOIN `my-training-project.training_data.courses` c ON e.course_id = c.course_id
GROUP BY c.title
ORDER BY completion_rate DESC;
```

## قاعدة البيانات (Firestore)

### المجموعات

#### bigquery_configs
```
bigquery_configs/
  {institutionId}/
    id: string
    institutionId: string
    companyId: string?
    projectId: string
    datasetId: string
    credentialsJson: string
    isEnabled: boolean
    enabledExports: ExportType[]
    defaultFrequency: ExportFrequency?
    defaultCronExpression: string?
    createdAt: timestamp
    createdBy: string
    updatedAt: timestamp?
    updatedBy: string?
```

#### bigquery_exports
```
bigquery_exports/
  {exportId}/
    id: string
    institutionId: string
    companyId: string?
    exportType: ExportType
    status: ExportStatus
    frequency: ExportFrequency
    projectId: string
    datasetId: string
    tableId: string
    totalRecords: number
    exportedRecords: number
    failedRecords: number
    errors: string[]
    triggeredBy: string
    triggeredByName: string
    startedAt: timestamp
    completedAt: timestamp?
    cronExpression: string?
    nextRunAt: timestamp?
    isEnabled: boolean?
```

## الأمان

### Service Account Permissions

```yaml
roles:
  - roles/bigquery.dataEditor    # إنشاء/تعديل البيانات
  - roles/bigquery.jobUser       # تنفيذ الاستعلامات
```

### قواعد Firestore

```javascript
// السماح للمسؤولين فقط
match /bigquery_configs/{institutionId} {
  allow read: if isAuthenticated() && 
    request.auth.token.institutionId == institutionId;
  
  allow write: if isAuthenticated() && 
    (hasRole('admin') || hasRole('org_admin'));
}

match /bigquery_exports/{exportId} {
  allow read: if isAuthenticated() && 
    (resource.data.institutionId == request.auth.token.institutionId);
  
  allow create: if isAuthenticated() && 
    (hasRole('admin') || hasRole('org_admin'));
}
```

## الأداء

### التحسينات

1. **معالجة دفعية** - استعلامات فعالة من Firestore
2. **التخزين المؤقت** - حفظ الإعدادات محلياً
3. **المعالجة غير المتزامنة** - عدم حظر الواجهة
4. **الضغط** - ضغط البيانات قبل الرفع

### القيود

- **حد BigQuery المجاني**: 10 GB تخزين، 1 TB استعلامات/شهر
- **حجم الدفعة**: 10,000 صف كحد أقصى
- **معدل الطلبات**: 100 طلب/ثانية

## ملاحظة مهمة

⚠️ **هذه نسخة محاكاة** - في الإنتاج يجب:

1. إضافة `googleapis` package:
```yaml
dependencies:
  googleapis: ^latest
  googleapis_auth: ^latest
```

2. تنفيذ الرفع الفعلي:
```dart
import 'package:googleapis/bigquery/v2.dart';
import 'package:googleapis_auth/auth_io.dart';

// المصادقة
final credentials = ServiceAccountCredentials.fromJson(config.credentialsJson);
final client = await clientViaServiceAccount(credentials, [BigqueryApi.bigqueryScope]);

// الرفع
final bigquery = BigqueryApi(client);
await bigquery.tabledata.insertAll(...);
```

3. معالجة الأخطاء والإعادة المحاولة
4. جدولة التصدير التلقائي (Cloud Functions أو Cloud Scheduler)

## استعلامات تحليلية مفيدة

### 1. تقرير أداء المتدربين

```sql
SELECT 
  u.name as student_name,
  COUNT(DISTINCT e.course_id) as courses_enrolled,
  COUNT(DISTINCT c.certificate_id) as certificates_earned,
  SUM(g.points_earned) as total_points,
  AVG(qr.percentage) as avg_quiz_score
FROM `project.dataset.users` u
LEFT JOIN `project.dataset.enrollments` e ON u.user_id = e.user_id
LEFT JOIN `project.dataset.certificates` c ON u.user_id = c.user_id
LEFT JOIN `project.dataset.gamification` g ON u.user_id = g.user_id
LEFT JOIN `project.dataset.quiz_results` qr ON u.user_id = qr.user_id
WHERE u.role = 'trainee'
GROUP BY u.user_id, u.name
ORDER BY total_points DESC;
```

### 2. تحليل الدورات الأكثر شعبية

```sql
SELECT 
  c.title,
  COUNT(e.enrollment_id) as total_enrollments,
  AVG(e.progress_percentage) as avg_progress,
  COUNT(DISTINCT cert.certificate_id) as certificates_issued
FROM `project.dataset.courses` c
LEFT JOIN `project.dataset.enrollments` e ON c.course_id = e.course_id
LEFT JOIN `project.dataset.certificates` cert ON c.course_id = cert.course_id
GROUP BY c.course_id, c.title
ORDER BY total_enrollments DESC
LIMIT 20;
```

### 3. تقرير التفاعل الشهري

```sql
SELECT 
  FORMAT_DATE('%Y-%m', DATE(e.enrolled_at)) as month,
  COUNT(DISTINCT e.user_id) as active_users,
  COUNT(e.enrollment_id) as new_enrollments,
  SUM(IF(e.completed_at IS NOT NULL, 1, 0)) as completions
FROM `project.dataset.enrollments` e
WHERE e.enrolled_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 6 MONTH)
GROUP BY month
ORDER BY month DESC;
```

## التوسعات المستقبلية

### قيد النظر

1. **جدولة تلقائية** - Cloud Scheduler للتصدير الدوري
2. **Data Studio Integration** - لوحات تحكم مرئية
3. **التصدير الفوري** - Firestore Triggers → BigQuery
4. **التنبيهات** - إشعارات عند فشل التصدير
5. **التشفير** - تشفير البيانات الحساسة
6. **الأرشفة** - نقل البيانات القديمة

## الترخيص

جزء من Training App V2 - © 2024
