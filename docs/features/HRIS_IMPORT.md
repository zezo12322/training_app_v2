# HRIS Import Feature - نظام استيراد HRIS

## نظرة عامة

نظام استيراد المستخدمين من ملفات CSV أو Excel لتسهيل عملية إضافة المستخدمين بشكل مجمّع من أنظمة الموارد البشرية (HRIS).

## الميزات

### 1. استيراد من CSV/Excel
- **دعم ملفات CSV** - قراءة وتحليل ملفات CSV
- **دعم ملفات Excel** - قراءة ملفات .xlsx و .xls
- **معاينة قبل الاستيراد** - عرض البيانات قبل الاستيراد الفعلي
- **تعيين أعمدة مرن** - ربط أعمدة الملف بحقول المستخدم

### 2. التحقق من الصحة
- **التحقق من البريد الإلكتروني** - فحص صحة تنسيق البريد الإلكتروني
- **الحقول المطلوبة** - التأكد من وجود البريد الإلكتروني والاسم
- **إظهار الأخطاء** - عرض أخطاء التحقق لكل سجل
- **نجاح جزئي** - السماح بنجاح بعض السجلات حتى مع وجود أخطاء

### 3. تتبع التقدم
- **حالات متعددة** - pending, processing, completed, failed, partialSuccess
- **عدادات دقيقة** - إجمالي/معالج/ناجح/فاشل
- **سجل الأخطاء** - تتبع تفصيلي للأخطاء
- **التحديث الفوري** - تحديث الحالة في الوقت الفعلي

### 4. القوالب القابلة لإعادة الاستخدام
- **حفظ التعيينات** - حفظ ربط الأعمدة كقالب
- **تحميل القوالب** - إعادة استخدام التعيينات المحفوظة
- **القوالب المؤسسية** - مشاركة القوالب داخل المؤسسة

## البنية التقنية

### النماذج

#### HRISImport
```dart
class HRISImport {
  String id;
  ImportFileType fileType;        // csv, excel
  String fileName;
  ImportStatus status;            // pending, processing, completed, failed, partialSuccess
  int totalRows;
  int processedRows;
  int successfulRows;
  int failedRows;
  List<String> errors;
  Map<String, dynamic> errorDetails;
  String uploadedBy;
  String uploaderName;
  DateTime uploadedAt;
  DateTime? completedAt;
  String institutionId;
  String? companyId;
  FieldMapping fieldMapping;
  bool updateExistingUsers;
  bool skipInvalidRows;
  String? defaultRole;
  String? defaultPassword;
}
```

#### FieldMapping
```dart
class FieldMapping {
  String emailColumn;             // مطلوب
  String nameColumn;              // مطلوب
  String? roleColumn;
  String? phoneColumn;
  String? departmentColumn;
  String? jobTitleColumn;
  String? employeeIdColumn;
  String? managerEmailColumn;
  Map<String, String> customFields;
}
```

#### ImportedUserRecord
```dart
class ImportedUserRecord {
  int rowNumber;
  String email;
  String name;
  String? role;
  String? phone;
  String? department;
  String? jobTitle;
  String? employeeId;
  String? managerEmail;
  Map<String, dynamic> customData;
  bool isValid;
  List<String> validationErrors;
  bool isProcessed;
  bool isSuccess;
  String? userId;
  String? errorMessage;
}
```

#### ImportTemplate
```dart
class ImportTemplate {
  String id;
  String name;
  String? description;
  FieldMapping fieldMapping;
  String institutionId;
  String? companyId;
  DateTime createdAt;
  String createdBy;
}
```

### الخدمات

#### HRISImportService
```dart
// قراءة الملفات
Future<List<List<String>>> parseCSV(File file)
Future<List<List<String>>> parseExcel(File file)

// استخراج البيانات
List<ImportedUserRecord> extractUserRecords({
  required List<List<String>> data,
  required FieldMapping fieldMapping,
})

// الاستيراد
Future<HRISImport> importUsers({
  required String importId,
  required List<ImportedUserRecord> records,
  required String institutionId,
  String? companyId,
  String? defaultRole,
  String? defaultPassword,
  bool updateExisting = true,
})

// القوالب
Future<bool> saveTemplate(ImportTemplate template)
Future<List<ImportTemplate>> getTemplates(String institutionId)
```

### الشاشات

#### HRISImportScreen
- اختيار الملف (CSV/Excel)
- تعيين الأعمدة
- معاينة البيانات
- بدء الاستيراد
- حفظ/تحميل القوالب

#### ImportHistoryScreen
- عرض سجل الاستيرادات
- تتبع الحالة
- عرض التفاصيل والأخطاء
- إحصائيات الاستيراد

## سير العمل

### 1. اختيار الملف
```
المستخدم → اختيار ملف CSV/Excel
      ↓
HRISImportService.parseCSV/parseExcel()
      ↓
عرض رؤوس الأعمدة
```

### 2. تعيين الأعمدة
```
المستخدم → ربط الأعمدة بحقول المستخدم
      ↓
Email Column → emailColumn
Name Column  → nameColumn
Role Column  → roleColumn (اختياري)
      ↓
(اختياري) حفظ كقالب
```

### 3. المعاينة
```
HRISImportService.extractUserRecords()
      ↓
التحقق من كل سجل:
  - تنسيق البريد الإلكتروني
  - الحقول المطلوبة
      ↓
عرض الإحصائيات:
  - صحيح: X
  - خطأ: Y
```

### 4. الاستيراد
```
إنشاء HRISImport في Firestore
      ↓
HRISImportService.importUsers()
      ↓
لكل سجل صحيح:
  - التحقق من المستخدم الموجود
  - إنشاء/تحديث المستخدم
  - تحديث العدادات
      ↓
تحديث الحالة → completed/partialSuccess/failed
```

## مثال استخدام

### 1. إعداد ملف CSV

```csv
Email,Full Name,Role,Phone,Department
john@example.com,John Doe,trainee,+1234567890,Engineering
jane@example.com,Jane Smith,instructor,+0987654321,HR
bob@example.com,Bob Johnson,manager,+1122334455,Sales
```

### 2. الاستيراد

```dart
// في الواجهة
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => HRISImportScreen(),
  ),
);

// 1. اختيار الملف
// 2. تعيين الأعمدة:
//    - Email → Email
//    - Full Name → Name
//    - Role → Role
//    - Phone → Phone
//    - Department → Department
// 3. معاينة (3 صحيح، 0 خطأ)
// 4. بدء الاستيراد

// النتيجة:
// ✅ 3 مستخدمين تم إنشاؤهم بنجاح
```

### 3. عرض السجل

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ImportHistoryScreen(),
  ),
);
```

## قاعدة البيانات (Firestore)

### المجموعات

#### hris_imports
```
hris_imports/
  {importId}/
    id: string
    fileType: "csv" | "excel"
    fileName: string
    status: "pending" | "processing" | "completed" | "failed" | "partialSuccess"
    totalRows: number
    processedRows: number
    successfulRows: number
    failedRows: number
    errors: string[]
    errorDetails: map
    uploadedBy: string
    uploaderName: string
    uploadedAt: timestamp
    completedAt: timestamp?
    institutionId: string
    companyId: string?
    fieldMapping: {
      emailColumn: string
      nameColumn: string
      roleColumn: string?
      ...
    }
    updateExistingUsers: boolean
    skipInvalidRows: boolean
    defaultRole: string?
    defaultPassword: string?
```

#### import_templates
```
import_templates/
  {templateId}/
    id: string
    name: string
    description: string?
    fieldMapping: FieldMapping
    institutionId: string
    companyId: string?
    createdAt: timestamp
    createdBy: string
```

## الأمان

### قواعد Firestore

```javascript
// السماح للمسؤولين فقط
match /hris_imports/{importId} {
  allow read: if isAuthenticated() && 
    (resource.data.institutionId == request.auth.token.institutionId);
  
  allow create: if isAuthenticated() && 
    (hasRole('admin') || hasRole('manager'));
  
  allow update: if isAuthenticated() && 
    (hasRole('admin') || hasRole('manager')) &&
    (resource.data.institutionId == request.auth.token.institutionId);
}

match /import_templates/{templateId} {
  allow read: if isAuthenticated() && 
    (resource.data.institutionId == request.auth.token.institutionId);
  
  allow write: if isAuthenticated() && 
    (hasRole('admin') || hasRole('manager'));
}
```

## الأداء

### التحسينات

1. **معالجة دفعية** - استيراد 50 مستخدم في المرة الواحدة
2. **التحقق المسبق** - فحص البيانات قبل الاستيراد
3. **التخزين المؤقت** - حفظ القوالب لإعادة الاستخدام
4. **التحديثات التدريجية** - تحديث الحالة كل دفعة

### القيود

- **الحد الأقصى للصفوف**: 10,000 لكل عملية استيراد
- **حجم الملف**: 10 MB كحد أقصى
- **المعالجة المتزامنة**: عملية واحدة لكل مؤسسة

## التوسعات المستقبلية

### قيد النظر

1. **جدولة الاستيراد** - استيراد تلقائي دوري
2. **التزامن مع HRIS** - اتصال مباشر بأنظمة HR
3. **مزيد من التحقق** - فحص التكرارات والبيانات المتعارضة
4. **الإشعارات** - إعلام المسؤولين عند الاكتمال
5. **التصدير** - تصدير البيانات إلى CSV/Excel
6. **التراجع** - التراجع عن عمليات الاستيراد

## الاختبار

### سيناريوهات الاختبار

1. **استيراد CSV صحيح** - جميع البيانات صحيحة
2. **استيراد Excel صحيح** - جميع البيانات صحيحة
3. **بيانات غير صحيحة** - بعض السجلات بها أخطاء
4. **تحديث موجود** - مستخدمون موجودون بالفعل
5. **عمود مفقود** - بدون عمود البريد الإلكتروني
6. **ملف فارغ** - لا توجد بيانات
7. **ملف كبير** - 1000+ صف
8. **القوالب** - حفظ/تحميل القوالب

## المتطلبات

### الحزم

```yaml
dependencies:
  csv: ^6.0.0              # قراءة CSV
  excel: ^4.0.6            # قراءة Excel
  file_picker: ^latest     # اختيار الملفات
  cloud_firestore: ^latest # قاعدة البيانات
  freezed: ^latest         # النماذج غير القابلة للتغيير
```

## الترخيص

جزء من Training App V2 - © 2024
