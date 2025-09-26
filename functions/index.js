const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

// هذه الدالة ستعمل كلما تم إنشاء مستند جديد في 'course_wall'
exports.sendPostNotification = functions.firestore
  .document("course_wall/{postId}")
  .onCreate(async (snapshot, context) => {
    // 1. الحصول على بيانات المنشور الجديد
    const postData = snapshot.data();
    const courseId = postData.courseId;
    const authorEmail = postData.authorEmail;

    // 2. جلب تفاصيل الكورس للحصول على قائمة المتدربين
    const courseDoc = await admin
      .firestore()
      .collection("courses")
      .doc(courseId)
      .get();

    if (!courseDoc.exists) {
      console.log("Course not found!");
      return;
    }

    const courseData = courseDoc.data();
    const courseName = courseData.name;
    const traineeIds = courseData.trainees;

    if (!traineeIds || traineeIds.length === 0) {
      console.log("No trainees in this course.");
      return;
    }

    // 3. جلب "توكن" كل متدرب
    const tokens = [];
    for (const traineeId of traineeIds) {
      const userDoc = await admin
        .firestore()
        .collection("users")
        .doc(traineeId)
        .get();

      if (userDoc.exists && userDoc.data().fcmToken) {
        tokens.push(userDoc.data().fcmToken);
      }
    }

    if (tokens.length === 0) {
      console.log("No registered device tokens found for trainees.");
      return;
    }

    // 4. بناء رسالة الإشعار
    const payload = {
      notification: {
        title: `منشور جديد في: ${courseName}`,
        body: `قام ${authorEmail} بإضافة منشور جديد.`,
        sound: "default",
      },
    };

    // 5. إرسال الإشعار لجميع الأجهزة
    try {
      const response = await admin.messaging().sendToDevice(tokens, payload);
      console.log("Successfully sent notification:", response);
    } catch (error) {
      console.log("Error sending notification:", error);
    }
  });