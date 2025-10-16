# 🧪 سيناريوهات الاختبار التفصيلية
# Detailed Testing Scenarios

**الهدف**: ضمان جاهزية المنصة من خلال اختبارات شاملة ومنهجية  
**تاريخ الإنشاء**: 16 أكتوبر 2025

---

## 📋 جدول المحتويات

1. [سيناريوهات المدرب](#سيناريوهات-المدرب)
2. [سيناريوهات المتدرب](#سيناريوهات-المتدرب)
3. [سيناريوهات Course Wall](#سيناريوهات-course-wall)
4. [سيناريوهات Gamification](#سيناريوهات-gamification)
5. [سيناريوهات الأمان](#سيناريوهات-الأمان)
6. [سيناريوهات الأداء](#سيناريوهات-الأداء)

---

## 🎓 سيناريوهات المدرب (Trainer Test Scenarios)

### Test Case #1: إنشاء حساب مدرب جديد

**الهدف**: التحقق من صحة عملية التسجيل للمدرب

**الخطوات**:
1. فتح التطبيق
2. الضغط على "إنشاء حساب جديد"
3. إدخال البيانات:
   - الاسم: "أحمد المدرب"
   - البريد: `ahmad.trainer+test@gmail.com`
   - كلمة المرور: `Test123!`
4. اختيار Role: "Trainer"
5. الضغط على "Sign Up"

**النتائج المتوقعة**:
- ✅ يتم إنشاء الحساب بنجاح
- ✅ يتم إرسال Email Verification (إذا مُفعّل)
- ✅ يتم توجيه المستخدم لـ Trainer Dashboard
- ✅ يظهر Welcome Message
- ✅ البيانات تُحفظ في Firestore بشكل صحيح

**كيفية التحقق**:
```
1. افتح Firebase Console → Authentication
2. تأكد من وجود المستخدم
3. افتح Firestore → users collection
4. ابحث عن document بنفس UID
5. تحقق من:
   - name = "أحمد المدرب"
   - email = "ahmad.trainer+test@gmail.com"
   - role = "trainer"
   - createdAt موجود
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

**ملاحظات**:
```
[أضف أي ملاحظات أو bugs هنا]
```

---

### Test Case #2: إنشاء دورة تدريبية جديدة

**الهدف**: التحقق من إمكانية المدرب لإنشاء دورة

**المتطلبات المسبقة**:
- يجب أن يكون المستخدم مُسجل دخول كـ Trainer

**الخطوات**:
1. من Trainer Dashboard، اضغط على "إنشاء دورة جديدة"
2. إدخال البيانات:
   - اسم الدورة: "Flutter للمبتدئين"
   - الوصف: "دورة شاملة لتعلم Flutter من الصفر"
3. الضغط على "Create Course"
4. انتظار ظهور كود الدورة

**النتائج المتوقعة**:
- ✅ يتم إنشاء الدورة بنجاح
- ✅ يظهر كود الدورة (6 أحرف، مثل: ABC123)
- ✅ رسالة نجاح تظهر: "Course created successfully!"
- ✅ يتم توجيه المستخدم لصفحة تفاصيل الدورة
- ✅ الدورة تظهر في قائمة دورات المدرب

**كيفية التحقق**:
```
1. افتح Firestore → courses collection
2. ابحث عن الدورة الجديدة
3. تحقق من:
   - name = "Flutter للمبتدئين"
   - instructorId = UID المدرب الحالي
   - code موجود (6 أحرف)
   - createdAt موجود
   - status = "active"
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

### Test Case #3: إضافة Module و Lesson

**الهدف**: التحقق من إمكانية إضافة محتوى للدورة

**المتطلبات المسبقة**:
- دورة موجودة (من Test Case #2)

**الخطوات**:
1. فتح تفاصيل الدورة
2. الضغط على "Add Module"
3. إدخال:
   - اسم Module: "أساسيات Dart"
   - الترتيب: 1
4. حفظ Module
5. من داخل Module، الضغط على "Add Lesson"
6. إدخال:
   - اسم Lesson: "المتغيرات في Dart"
   - المحتوى: "في هذا الدرس سنتعلم..."
   - الترتيب: 1
7. حفظ Lesson

**النتائج المتوقعة**:
- ✅ Module يُنشأ بنجاح
- ✅ يظهر في قائمة Modules
- ✅ Lesson تُنشأ بنجاح
- ✅ تظهر داخل Module
- ✅ Lesson قابلة للفتح والقراءة

**كيفية التحقق**:
```
Firestore → courses → [courseId] → modules → [moduleId]
تحقق من:
- name = "أساسيات Dart"
- order = 1

Firestore → learning_modules → [moduleId] → lessons → [lessonId]
تحقق من:
- name = "المتغيرات في Dart"
- order = 1
- content موجود
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

### Test Case #4: رفع ملف PDF لدرس

**الهدف**: التحقق من إمكانية رفع ملفات

**المتطلبات المسبقة**:
- Lesson موجود (من Test Case #3)
- ملف PDF جاهز للرفع (< 10 MB)

**الخطوات**:
1. فتح Lesson
2. الضغط على "Upload File" أو زر الرفع
3. اختيار ملف PDF من الجهاز
4. انتظار اكتمال الرفع
5. حفظ

**النتائج المتوقعة**:
- ✅ شريط تقدم الرفع يظهر
- ✅ الرفع ينتهي بنجاح
- ✅ رابط الملف يُحفظ
- ✅ الملف قابل للتحميل
- ✅ رسالة نجاح تظهر

**كيفية التحقق**:
```
1. Firestore → lessons → [lessonId]
   تحقق من: fileUrl موجود

2. Firebase Storage → course_materials/
   تحقق من وجود الملف

3. اضغط على رابط الملف في التطبيق
   تحقق من: يتم فتح/تحميل الملف بشكل صحيح
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

## 🎓 سيناريوهات المتدرب (Trainee Test Scenarios)

### Test Case #5: إنشاء حساب متدرب والانضمام لدورة

**الهدف**: التحقق من رحلة المتدرب الكاملة

**المتطلبات المسبقة**:
- دورة موجودة بكود معروف (من Test Case #2)

**الخطوات**:
1. فتح التطبيق (جهاز أو حساب مختلف)
2. الضغط على "إنشاء حساب جديد"
3. إدخال البيانات:
   - الاسم: "محمد المتدرب"
   - البريد: `mohamed.trainee+test@gmail.com`
   - كلمة المرور: `Test123!`
4. اختيار Role: "Trainee"
5. Sign Up
6. من Dashboard، اضغط "Join Course"
7. إدخال كود الدورة (من Test Case #2)
8. الضغط على "Join"

**النتائج المتوقعة**:
- ✅ حساب المتدرب يُنشأ بنجاح
- ✅ توجيه لـ Trainee Dashboard
- ✅ الانضمام للدورة ينجح
- ✅ رسالة نجاح: "Joined course successfully!"
- ✅ الدورة تظهر في قائمة الدورات
- ✅ يمكن فتح الدورة ورؤية المحتوى

**كيفية التحقق**:
```
Firestore → course_enrollments
ابحث عن enrollment بـ:
- userId = UID المتدرب
- courseId = ID الدورة
- status = "active"
- enrolledAt موجود
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

### Test Case #6: إكمال درس وكسب نقاط

**الهدف**: التحقق من Gamification عند إكمال درس

**المتطلبات المسبقة**:
- متدرب مُسجل دخول ومنضم لدورة
- درس موجود في الدورة

**الخطوات**:
1. فتح الدورة
2. فتح Module
3. فتح Lesson
4. قراءة المحتوى
5. الضغط على "Mark as Complete" (إذا موجود)
6. العودة للـ Dashboard

**النتائج المتوقعة**:
- ✅ Lesson تُعلّم كـ completed
- ✅ Progress bar للدورة يتحدث
- ✅ المستخدم يحصل على 10 نقاط
- ✅ إشعار يظهر: "+10 نقاط!"
- ✅ إذا كان أول درس، يحصل على شارة "First Step"

**كيفية التحقق**:
```
1. Firestore → user_progress
   ابحث عن:
   - userId + courseId + lessonId
   - completed = true
   - completedAt موجود

2. Firestore → user_points
   تحقق من:
   - totalPoints زادت بـ 10
   - courseProgress محدّث

3. Firestore → user_badges
   إذا أول درس:
   - تحقق من وجود badge "first_step"
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

## 📰 سيناريوهات Course Wall

### Test Case #7: إنشاء منشور نصي

**الهدف**: التحقق من إمكانية النشر على Course Wall

**المتطلبات المسبقة**:
- مستخدم مُسجل دخول (trainer أو trainee)
- منضم لدورة

**الخطوات**:
1. فتح الدورة
2. الذهاب لـ "Course Wall" tab
3. الضغط على حقل النص "What's on your mind?"
4. كتابة منشور: "مرحباً! هذا أول منشور لي في الدورة 👋"
5. الضغط على "Post"

**النتائج المتوقعة**:
- ✅ المنشور يُنشر فوراً
- ✅ يظهر في أعلى القائمة
- ✅ يحتوي على اسم الناشر
- ✅ يحتوي على وقت النشر ("منذ ثانية")
- ✅ الناشر يحصل على 5 نقاط

**كيفية التحقق**:
```
Firestore → course_wall
ابحث عن آخر منشور:
- content = "مرحباً! هذا أول منشور لي..."
- authorId = UID الناشر
- courseId = ID الدورة
- createdAt موجود
- isPinned = false
- isArchived = false
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

### Test Case #8: إضافة Reaction على منشور

**الهدف**: التحقق من نظام Reactions

**المتطلبات المسبقة**:
- منشور موجود على Course Wall

**الخطوات**:
1. عرض المنشور
2. الضغط على زر Reaction (الوجه المبتسم)
3. اختيار emoji من القائمة (مثلاً: 👍)
4. الانتظار لحظة

**النتائج المتوقعة**:
- ✅ الـ Reaction يُضاف فوراً
- ✅ العداد يزيد (1 👍)
- ✅ الزر يُظهر أن المستخدم فعّل الـ reaction (highlighted)
- ✅ إذا ضغط مرة أخرى، يُلغى الـ reaction

**كيفية التحقق**:
```
Firestore → course_wall → [postId]
تحقق من:
- reactions.👍 = 1 (أو العدد الصحيح)
- reactionUsers.👍 = [userId] (array يحتوي المستخدم)

ثم اضغط مرة أخرى على نفس Reaction:
- reactions.👍 = 0 (أو undefined)
- reactionUsers.👍 = [] (array فارغة)
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

### Test Case #9: إضافة تعليق على منشور

**الهدف**: التحقق من نظام التعليقات

**المتطلبات المسبقة**:
- منشور موجود على Course Wall

**الخطوات**:
1. عرض المنشور
2. الضغط على "Comments" أو أيقونة التعليقات
3. في الـ Bottom Sheet، كتابة تعليق: "تعليق رائع! شكراً على المشاركة"
4. الضغط على زر الإرسال

**النتائج المتوقعة**:
- ✅ التعليق يظهر فوراً في القائمة
- ✅ يحتوي على اسم المُعلّق
- ✅ يحتوي على وقت التعليق
- ✅ عداد التعليقات على المنشور يزيد
- ✅ المُعلّق يحصل على 3 نقاط

**كيفية التحقق**:
```
Firestore → course_wall → [postId] → comments
ابحث عن آخر تعليق:
- content = "تعليق رائع!..."
- authorId = UID المُعلّق
- postId = ID المنشور
- createdAt موجود

Firestore → course_wall → [postId]
تحقق من:
- commentCount زاد بـ 1
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

### Test Case #10: إنشاء استطلاع رأي (Poll)

**الهدف**: التحقق من Poll System

**المتطلبات المسبقة**:
- مستخدم مُسجل دخول (trainer يُفضّل)
- منضم لدورة

**الخطوات**:
1. فتح Course Wall
2. الضغط على أيقونة Poll
3. إدخال البيانات:
   - السؤال: "ما هو وقتك المفضل للدراسة؟"
   - الخيارات:
     1. "صباحاً (6-12)"
     2. "ظهراً (12-6)"
     3. "مساءً (6-12)"
     4. "ليلاً (12-6)"
   - نوع التصويت: Single Choice
   - مدة الاستطلاع: 7 أيام
4. الضغط على "Create Poll"

**النتائج المتوقعة**:
- ✅ الاستطلاع يُنشر كمنشور خاص
- ✅ يظهر السؤال والخيارات
- ✅ يمكن التصويت
- ✅ النتائج تظهر في الوقت الفعلي
- ✅ لا يمكن التصويت مرتين (إذا Single Choice)

**كيفية التحقق**:
```
1. Firestore → course_wall → [postId]
   تحقق من:
   - pollId موجود

2. Firestore → polls → [pollId]
   تحقق من:
   - question = "ما هو وقتك المفضل..."
   - options = [4 خيارات]
   - allowMultipleVotes = false
   - endsAt موجود (7 أيام من الآن)

3. صوّت في الاستطلاع:
   Firestore → polls → [pollId] → votes
   تحقق من:
   - userId موجود
   - optionIndex = الخيار المُختار
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

### Test Case #11: تثبيت منشور (Trainer Only)

**الهدف**: التحقق من صلاحية Trainer لتثبيت المنشورات

**المتطلبات المسبقة**:
- مستخدم مُسجل دخول كـ Trainer
- منشور موجود في دورة يملكها

**الخطوات**:
1. عرض المنشور
2. الضغط على أيقونة Menu (⋮)
3. اختيار "Pin Post"
4. تأكيد

**النتائج المتوقعة**:
- ✅ المنشور يُثبّت فوراً
- ✅ يظهر في أعلى القائمة دائماً
- ✅ أيقونة 📌 تظهر على المنشور
- ✅ إذا كان هناك منشور مُثبّت سابق، يُلغى تثبيته

**كيفية التحقق**:
```
Firestore → course_wall → [postId]
تحقق من:
- isPinned = true

اعرض القائمة:
- المنشور المُثبّت في الأعلى دائماً
```

**الاختبار السلبي (Negative Test)**:
- سجّل دخول كـ Trainee
- حاول تثبيت منشور
- **النتيجة المتوقعة**: ❌ الخيار غير متاح أو رسالة خطأ

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

## 🏆 سيناريوهات Gamification

### Test Case #12: الحصول على شارة "First Step"

**الهدف**: التحقق من منح الشارات

**المتطلبات المسبقة**:
- متدرب جديد لم يُكمل أي درس

**الخطوات**:
1. إكمال أول درس (Test Case #6)
2. الانتظار لحظات
3. مشاهدة الإشعار أو التحقق من صفحة Achievements

**النتائج المتوقعة**:
- ✅ شارة "First Step" تُمنح تلقائياً
- ✅ إشعار يظهر: "Congratulations! You earned 'First Step' badge!"
- ✅ الشارة تظهر في صفحة Achievements
- ✅ لا تُمنح مرة أخرى (idempotent)

**كيفية التحقق**:
```
Firestore → user_badges
ابحث عن:
- userId = المتدرب
- badgeId = "first_step"
- awardedAt موجود

جرّب إكمال درس آخر:
- الشارة لا تُمنح مرة أخرى
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

### Test Case #13: Daily Streak

**الهدف**: التحقق من نظام السلاسل اليومية

**المتطلبات المسبقة**:
- متدرب مُسجل دخول

**الخطوات**:
- **اليوم 1**:
  1. سجّل دخول
  2. افعل أي نشاط (اقرأ درس، علّق، الخ)
  3. تحقق من الـ Streak

- **اليوم 2** (في اليوم التالي):
  1. سجّل دخول
  2. افعل أي نشاط
  3. تحقق من الـ Streak

- **اليوم 3**:
  1. نفس الخطوات
  2. تحقق من الـ Streak

**النتائج المتوقعة**:
- ✅ اليوم 1: Daily Streak = 1
- ✅ اليوم 2: Daily Streak = 2
- ✅ اليوم 3: Daily Streak = 3
- ✅ كل يوم: +5 نقاط للـ Streak
- ✅ إذا فاتت يوم، تُصفّر السلسلة

**كيفية التحقق**:
```
Firestore → user_points → [userId]
تحقق من:
- dailyStreak = 1, 2, 3...
- lastActiveDay = تاريخ اليوم (YYYY-MM-DD format)
- totalPoints تزيد بـ 5 يومياً
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

### Test Case #14: Leaderboard

**الهدف**: التحقق من لوحة المتصدرين

**المتطلبات المسبقة**:
- دورة بها متدربين متعددين
- متدربين لديهم نقاط مختلفة

**الخطوات**:
1. فتح الدورة
2. الذهاب لـ "Leaderboard" tab
3. عرض القائمة

**النتائج المتوقعة**:
- ✅ المتدربين مرتّبين حسب النقاط (الأعلى أولاً)
- ✅ تظهر أسماء المتدربين
- ✅ تظهر عدد النقاط لكل واحد
- ✅ تظهر المستويات (Levels)
- ✅ موقع المستخدم الحالي يُظهر highlighted

**كيفية التحقق**:
```
افتح التطبيق كـ 3 متدربين مختلفين:
- Trainee A: 50 نقطة
- Trainee B: 100 نقطة  
- Trainee C: 30 نقطة

Leaderboard يجب أن يعرض:
1. Trainee B (100)
2. Trainee A (50)
3. Trainee C (30)
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

## 🔒 سيناريوهات الأمان (Security Test Scenarios)

### Test Case #15: منع الوصول لدورات Tenant آخر

**الهدف**: التحقق من Tenant Isolation

**الإعداد**:
- **Trainer A**: institution = "inst_1", course = "course_A"
- **Trainee B**: institution = "inst_2"

**الخطوات**:
1. سجّل دخول كـ Trainee B
2. حاول الانضمام لـ course_A (بكود معروف)
3. أو حاول الوصول مباشرة عبر deep link

**النتائج المتوقعة**:
- ❌ **يجب أن يفشل**: رسالة خطأ تظهر
- ❌ لا يتم إنشاء enrollment
- ❌ Firestore Rules تمنع الوصول

**كيفية التحقق**:
```
Firebase Console → Firestore Rules Playground:

1. Simulate: Read on courses/course_A
   - Signed in as: Trainee B
   - Result: ❌ Permission Denied

2. تحقق من عدم وجود enrollment:
   Firestore → course_enrollments
   - لا يوجد document بـ userId=B + courseId=A
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

### Test Case #16: منع Trainee من تعديل محتوى الدورة

**الهدف**: التحقق من Role-Based Access Control

**المتطلبات المسبقة**:
- Trainee مُسجل دخول ومنضم لدورة

**الخطوات**:
1. حاول الوصول لشاشة "Edit Lesson"
2. أو حاول تعديل lesson عبر API مباشرة (DevTools)

**النتائج المتوقعة**:
- ❌ الشاشة غير متاحة في الـ UI
- ❌ إذا تم الوصول بطريقة ما، Firestore Rules تمنع الكتابة
- ❌ رسالة خطأ: "Permission Denied"

**كيفية التحقق**:
```
Firebase Console → Firestore Rules Playground:

Simulate: Update on lessons/[lessonId]
- Signed in as: Trainee
- Result: ❌ Permission Denied
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

### Test Case #17: منع حذف تعليق شخص آخر (غير Trainer)

**الهدف**: التحقق من صلاحيات الحذف

**الإعداد**:
- User A ينشر تعليق
- User B يحاول حذفه

**الخطوات**:
1. User A: أضف تعليق على منشور
2. User B: سجّل دخول
3. User B: حاول حذف تعليق User A

**النتائج المتوقعة**:
- ❌ زر Delete غير متاح لـ User B (إلا إذا كان Trainer)
- ❌ إذا تم محاولة الحذف عبر API، Firestore Rules تمنع
- ✅ Trainer يمكنه حذف أي تعليق

**كيفية التحقق**:
```
Test 1: User B (Trainee) يحاول حذف تعليق User A:
- Result: ❌ Permission Denied

Test 2: Trainer يحذف تعليق User A:
- Result: ✅ Success
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

### Test Case #18: Content Validation - منع منشور طويل جداً

**الهدف**: التحقق من Validation Rules

**الخطوات**:
1. حاول إنشاء منشور بـ 6000 حرف (أكثر من الحد 5000)
2. اضغط "Post"

**النتائج المتوقعة**:
- ❌ رسالة خطأ تظهر: "Content too long (max 5000 characters)"
- ❌ المنشور لا يُنشر
- ❌ Firestore Rules ترفض الكتابة

**كيفية التحقق**:
```
1. في التطبيق: 
   - UI يمنع الإرسال (Validation في Client)

2. إذا تم تجاوز Client Validation:
   - Firestore Rules ترفض
   - Error في Console
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

## ⚡ سيناريوهات الأداء (Performance Test Scenarios)

### Test Case #19: تحميل Course Wall بـ 100+ منشور

**الهدف**: قياس أداء Pagination

**الإعداد**:
- دورة بها 100+ منشور (يمكن seed data)

**الخطوات**:
1. فتح Course Wall
2. قياس وقت التحميل الأولي
3. Scroll للأسفل
4. قياس وقت تحميل Pagination

**النتائج المتوقعة**:
- ✅ التحميل الأولي < 2 ثانية
- ✅ يتم تحميل 20 منشور فقط (صفحة أولى)
- ✅ عند Scroll، يتم تحميل 20 منشور إضافي
- ✅ لا Lag أو Jank
- ✅ Smooth scrolling (60 FPS)

**كيفية القياس**:
```
استخدم Flutter DevTools:
1. افتح Performance tab
2. سجّل Timeline
3. افتح Course Wall
4. قس Frame Rendering Time
5. تحقق من:
   - Build Time < 16ms
   - Raster Time < 16ms
   - لا Dropped Frames
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

### Test Case #20: Memory Leaks بعد استخدام لمدة ساعة

**الهدف**: التحقق من عدم وجود Memory Leaks

**الخطوات**:
1. فتح التطبيق
2. تسجيل Memory Usage الأولي
3. استخدام التطبيق بشكل طبيعي لمدة ساعة:
   - فتح دورات
   - قراءة دروس
   - النشر على Course Wall
   - الدردشة
   - تسجيل خروج ودخول
4. قياس Memory Usage النهائي

**النتائج المتوقعة**:
- ✅ Memory Usage لا يزيد بشكل خطي (مع الوقت)
- ✅ بعد إغلاق الشاشات، Memory يتحرر
- ✅ لا Crash بسبب Out of Memory
- ✅ App Size في الذاكرة < 200 MB

**كيفية القياس**:
```
Flutter DevTools → Memory tab:
1. سجّل Memory Snapshot
2. استخدم التطبيق
3. Force Garbage Collection
4. قارن Memory قبل وبعد
5. ابحث عن Objects لم تُحرّر
```

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

### Test Case #21: Offline Mode

**الهدف**: سلوك التطبيق بدون إنترنت

**الخطوات**:
1. فتح التطبيق مع إنترنت
2. تحميل بعض البيانات (دورة، منشورات)
3. قطع الإنترنت (Airplane Mode)
4. محاولة استخدام التطبيق

**النتائج المتوقعة**:
- ✅ البيانات المُحمّلة سابقاً تبقى متاحة (Firestore Cache)
- ✅ رسالة واضحة تظهر: "لا يوجد اتصال بالإنترنت"
- ⚠️ لا يمكن إضافة منشورات جديدة (ولكن رسالة خطأ واضحة)
- ⚠️ لا Crash
- ✅ عند عودة الإنترنت، البيانات تتزامن

**Status**: ⬜ Not Tested | ✅ Passed | ❌ Failed

---

## 📊 نموذج تقرير الاختبار (Test Report Template)

### التاريخ: [__/__/____]
### المُختبِر: [الاسم]
### الجهاز: [Android/iOS, إصدار النظام]
### Build Version: [رقم الإصدار]

---

### ملخص النتائج:
- **إجمالي الاختبارات**: __
- **نجحت**: __ ✅
- **فشلت**: __ ❌
- **لم تُختبر**: __ ⬜

---

### الاختبارات الفاشلة (Failures):

#### Test Case #__: [اسم الاختبار]
- **المشكلة**: [وصف المشكلة]
- **الخطوات لإعادة الإنتاج**: 
  1. ...
  2. ...
- **النتيجة الفعلية**: ...
- **النتيجة المتوقعة**: ...
- **Screenshot**: [إرفاق إن أمكن]
- **الأولوية**: 🔴 High | 🟠 Medium | 🟢 Low

---

### ملاحظات إضافية:
```
[أي ملاحظات أو اقتراحات]
```

---

## ✅ Checklist سريع للإطلاق

قبل الإطلاق، تأكد من:

### الميزات الأساسية:
- [ ] Test Case #1: تسجيل مدرب ✅
- [ ] Test Case #2: إنشاء دورة ✅
- [ ] Test Case #5: تسجيل متدرب والانضمام ✅
- [ ] Test Case #6: إكمال درس + Gamification ✅
- [ ] Test Case #7: منشور على Course Wall ✅
- [ ] Test Case #10: Poll ✅

### الأمان:
- [ ] Test Case #15: Tenant Isolation ✅
- [ ] Test Case #16: Role-Based Access ✅
- [ ] Test Case #18: Content Validation ✅

### الأداء:
- [ ] Test Case #19: Pagination ✅
- [ ] Test Case #21: Offline Mode ✅

---

**إذا نجحت جميع الاختبارات أعلاه، المنصة جاهزة للإطلاق!** 🚀

---

**تاريخ الإنشاء**: 16 أكتوبر 2025  
**آخر تحديث**: __/__/____
