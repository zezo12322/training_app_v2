// Application Constants
class AppConstants {
  // User Roles
  static const String trainerRole = 'trainer';
  static const String traineeRole = 'trainee';
  
  // Collection Names
  static const String usersCollection = 'users';
  static const String coursesCollection = 'courses';
  static const String courseWallCollection = 'course_wall';
  static const String postCommentsCollection = 'post_comments';
  static const String evaluationsCollection = 'evaluations';
  static const String quizzesCollection = 'quizzes';
  static const String quizSubmissionsCollection = 'quiz_submissions';
  
  // Field Names
  static const String uidField = 'uid';
  static const String nameField = 'name';
  static const String emailField = 'email';
  static const String roleField = 'role';
  static const String createdAtField = 'createdAt';
  static const String updatedAtField = 'updatedAt';
  static const String courseIdField = 'courseId';
  static const String trainerIdField = 'trainerId';
  static const String traineeIdField = 'traineeId';
  static const String courseCodeField = 'courseCode';
  static const String traineesField = 'trainees';
  static const String oneSignalPlayerIdField = 'oneSignalPlayerId';
  static const String authorIdField = 'authorId';
  static const String authorEmailField = 'authorEmail';
  static const String authorNameField = 'authorName';
  static const String authorImageUrlField = 'authorImageUrl';
  static const String contentField = 'content';
  static const String postIdField = 'postId';
  static const String scoreField = 'score';
  static const String feedbackField = 'feedback';
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 8.0;
  static const double defaultBorderRadius = 8.0;
  static const int defaultAnimationDuration = 300;
  
  // Validation Constants
  static const int minPasswordLength = 6;
  static const int maxCourseNameLength = 100;
  static const int maxPostContentLength = 1000;
  static const int maxCommentLength = 500;
  static const int maxFeedbackLength = 500;
  static const int courseCodeLength = 6;
  
  // Error Messages (Arabic)
  static const String genericErrorMessage = 'حدث خطأ غير متوقع';
  static const String networkErrorMessage = 'تحقق من اتصالك بالإنترنت';
  static const String authErrorMessage = 'خطأ في تسجيل الدخول';
  static const String fillAllFieldsMessage = 'يرجى ملء جميع الحقول';
  static const String weakPasswordMessage = 'كلمة المرور ضعيفة جدًا';
  static const String emailAlreadyInUseMessage = 'هذا البريد الإلكتروني مستخدم بالفعل';
  static const String selectRoleMessage = 'يرجى تحديد دورك (مدرب أو متدرب)';
  static const String invalidEmailPasswordMessage = 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
  
  // Success Messages (Arabic)
  static const String accountCreatedMessage = 'تم إنشاء الحساب بنجاح';
  static const String loginSuccessMessage = 'تم تسجيل الدخول بنجاح';
  static const String courseCreatedMessage = 'تم إنشاء الكورس بنجاح';
  static const String courseJoinedMessage = 'تم الانضمام للكورس بنجاح';
  static const String postAddedMessage = 'تم إضافة المنشور بنجاح';
  static const String commentAddedMessage = 'تم إضافة التعليق بنجاح';
  
  // OneSignal Constants
  static const String oneSignalNotificationUrl = 'https://onesignal.com/api/v1/notifications';
  
  // File Upload Constants
  static const int maxFileSize = 10 * 1024 * 1024; // 10 MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'gif'];
  static const List<String> allowedDocumentTypes = ['pdf', 'doc', 'docx', 'txt'];
  static const List<String> allowedAudioTypes = ['mp3', 'wav', 'aac', 'm4a'];
  
  // Pagination Constants
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}

// Theme Constants
class ThemeConstants {
  static const primaryBlue = 0xFF2196F3;
  static const primaryGreen = 0xFF4CAF50;
  static const primaryRed = 0xFFF44336;
  static const primaryOrange = 0xFFFF9800;
  static const greyLight = 0xFFF5F5F5;
  static const greyMedium = 0xFF757575;
  static const greyDark = 0xFF424242;
}
