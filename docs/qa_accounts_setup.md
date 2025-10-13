# إعداد حسابات الأدوار المختلفة

## حسابات الأدوار:

### 1. Super Admin
- **البريد الإلكتروني**: super_admin@example.com
- **كلمة المرور**: password123
- **الوصف**: حساب مسؤول النظام الأعلى.

### 2. Company Admin
- **البريد الإلكتروني**: company_admin@example.com
- **كلمة المرور**: password123
- **الوصف**: حساب مسؤول الشركة.

### 3. Manager
- **البريد الإلكتروني**: manager@example.com
- **كلمة المرور**: password123
- **الوصف**: حساب مدير.

### 4. Trainer
- **البريد الإلكتروني**: trainer@example.com
- **كلمة المرور**: password123
- **الوصف**: حساب مدرب.

### 5. Trainee
- **البريد الإلكتروني**: trainee@example.com
- **كلمة المرور**: password123
- **الوصف**: حساب متدرب.

## الخطوات:
1. تسجيل الدخول إلى Firebase Console.
2. الانتقال إلى قسم Authentication.
3. إضافة المستخدمين يدويًا باستخدام البيانات أعلاه.
4. التأكد من تعيين الدور المناسب لكل مستخدم في قاعدة بيانات Firestore ضمن مجموعة `users`.

## ملاحظات:
- تأكد من أن كل حساب لديه الحقول التالية في Firestore:
  - `role`: الدور (super_admin, company_admin, manager, trainer, trainee).
  - `institutionId` أو `companyId` حسب الحاجة.
- تحقق من أن القواعد المطبقة في Firestore تمنع أي وصول غير مصرح به.