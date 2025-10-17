// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق التدريب';

  @override
  String get navDashboardTrainer => 'لوحة';

  @override
  String get navHomeTrainee => 'الرئيسية';

  @override
  String get navProfile => 'حسابي';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get actionNewCourse => 'كورس جديد';

  @override
  String get actionJoin => 'انضمام';

  @override
  String greetingTrainer(Object name) {
    return 'مرحباً، $name!';
  }

  @override
  String get greetingTrainerFallback => 'مرحباً أيها المدرب!';

  @override
  String greetingTrainee(Object name) {
    return 'أهلاً بك، $name!';
  }

  @override
  String get greetingTraineeFallback => 'أهلاً أيها المتدرب!';

  @override
  String get trainerCoursesSubtitle => 'كورساتك الحالية:';

  @override
  String get traineeCoursesSubtitle => 'كورساتك المسجل بها:';

  @override
  String get noTrainerCoursesTitle => 'لم تقم بإنشاء أي كورسات بعد';

  @override
  String get noTrainerCoursesHint => 'اضغط على زر + في الأسفل للبدء';

  @override
  String get noTraineeCoursesTitle => 'لم تنضم إلى أي كورسات بعد';

  @override
  String get noTraineeCoursesHint => 'اضغط على زر + للانضمام إلى كورس جديد';

  @override
  String courseCodeLabel(Object code) {
    return 'الكود: $code';
  }

  @override
  String get onboardingTitle => 'دليل سريع';

  @override
  String get onboardingPointDashboardTitle => 'الرئيسية / اللوحة';

  @override
  String get onboardingPointDashboardBody => 'عرض الكورسات وإدارة الأساسيات.';

  @override
  String get onboardingPointProfileTitle => 'حسابي';

  @override
  String get onboardingPointProfileBody => 'تحديث الاسم والصورة وبياناتك.';

  @override
  String get onboardingPointSettingsTitle => 'الإعدادات';

  @override
  String get onboardingPointSettingsBody => 'تحكم بالمظهر، الحركات، التشغيل.';

  @override
  String get onboardingRoleNote => 'التبويب الأول يتغير حسب دورك (مدرب/متدرب)';

  @override
  String get onboardingStart => 'ابدأ';

  @override
  String get onboardingLater => 'لاحقاً';

  @override
  String get onboardingFullTour => 'جولة كاملة';

  @override
  String get tourNext => 'التالي';

  @override
  String get tourSkip => 'تخطي';

  @override
  String get tourDone => 'إنهاء';

  @override
  String get tourDashboardTitle => 'اللوحة';

  @override
  String get tourDashboardBody => 'نقطة البداية. تعرض ملخصات وإجراءات سريعة.';

  @override
  String get tourFabTitleTrainer => 'إنشاء كورس';

  @override
  String get tourFabBodyTrainer => 'من هنا تضيف كورساً جديداً للمتدربين.';

  @override
  String get tourFabTitleTrainee => 'انضمام لكورس';

  @override
  String get tourFabBodyTrainee => 'اضغط للانضمام باستخدام كود يرسله المدرب.';

  @override
  String get tourProfileTitle => 'الملف الشخصي';

  @override
  String get tourProfileBody => 'حرر اسمك وصورتك وشاهد الإحصائيات والإنجازات.';

  @override
  String get tourSettingsTitle => 'الإعدادات';

  @override
  String get tourSettingsBody => 'غيّر المظهر واللغة وتفضيلات الإشعارات.';

  @override
  String get loading => 'جار التحميل...';

  @override
  String errorGeneric(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get notificationsSubtitle => 'السماح بتنبيهات الدفع (OneSignal / FCM)';

  @override
  String get errorNetwork => 'مشكلة في الشبكة. أعد المحاولة.';

  @override
  String errorAuth(Object details) {
    return 'خطأ مصادقة: $details';
  }

  @override
  String get errorNotFound => 'العنصر غير موجود';

  @override
  String errorNotFoundResource(Object resource) {
    return 'غير موجود: $resource';
  }

  @override
  String get errorValidation => 'بعض الحقول غير صحيحة';

  @override
  String get errorPermission => 'ليست لديك صلاحية';

  @override
  String get errorRateLimited => 'طلبات كثيرة جداً. حاول لاحقاً.';

  @override
  String errorRateLimitedRetry(Object seconds) {
    return 'أعد المحاولة بعد $secondsث';
  }

  @override
  String get errorStorage => 'حدث خطأ في التخزين';

  @override
  String get errorUnknown => 'حدث خطأ غير متوقع';

  @override
  String get funAnimationsTitle => 'الحركات الممتعة';

  @override
  String get funAnimationsSubtitle => 'تفعيل الحركات اللطيفة عند العرض';

  @override
  String get autoplayAudioTitle => 'تشغيل الصوت تلقائياً';

  @override
  String get autoplayAudioSubtitle => 'عند فتح تقييم صوتي جديد';

  @override
  String get clearCacheTitle => 'تفريغ الذاكرة المؤقتة';

  @override
  String get clearCacheSubtitle => 'قد يحل بعض مشاكل التزامن';

  @override
  String get confirmationTitle => 'تأكيد';

  @override
  String get clearCacheConfirm => 'تنفيذ مسح صوري للذاكرة المؤقتة؟';

  @override
  String get cancelAction => 'إلغاء';

  @override
  String get continueAction => 'متابعة';

  @override
  String get cacheClearedToast => 'تم مسح الكاش (صوريًا)';

  @override
  String get aboutTitle => 'حول التطبيق';

  @override
  String get aboutSubtitle => 'إصدار تجريبي للتدريب';

  @override
  String get logoutAction => 'تسجيل الخروج';

  @override
  String get logoutConfirm => 'هل أنت متأكد من تسجيل الخروج؟';

  @override
  String logoutFailed(Object error) {
    return 'فشل تسجيل الخروج: $error';
  }

  @override
  String get dumpSettingsAction => 'طباعة حالة الإعدادات في السجل';

  @override
  String get dumpSettingsToast => 'تم إرسال الحالة إلى السجل';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsOfService => 'شروط الاستخدام';

  @override
  String get aboutSection => 'حول التطبيق';

  @override
  String get languagePickerTitle => 'اللغة';

  @override
  String get systemLocaleLabel => 'النظام';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get loginWelcomeBack => 'مرحباً بعودتك!';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get passwordTooShort => 'على الأقل 6 أحرف';

  @override
  String get fieldRequired => 'مطلوب';

  @override
  String get invalidEmail => 'بريد غير صالح';

  @override
  String get loginAction => 'تسجيل الدخول';

  @override
  String get orContinueWith => 'أو تابع باستخدام';

  @override
  String get signInWithGoogle => 'تسجيل الدخول باستخدام Google';

  @override
  String get signInWithApple => 'تسجيل الدخول باستخدام Apple';

  @override
  String ssoLoginFailed(Object error) {
    return 'فشل تسجيل الدخول: $error';
  }

  @override
  String get signupNavigate => 'ليس لديك حساب؟ إنشاء حساب جديد';

  @override
  String get forgotPasswordNavigate => 'نسيت كلمة المرور؟';

  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور';

  @override
  String get forgotPasswordDescription =>
      'أدخل بريدك الإلكتروني وسنرسل لك رابط لإعادة تعيين كلمة المرور';

  @override
  String get sendResetEmail => 'إرسال رابط إعادة التعيين';

  @override
  String get passwordResetEmailSent =>
      'تم إرسال رسالة إعادة تعيين كلمة المرور إلى بريدك الإلكتروني';

  @override
  String get passwordResetFailed => 'فشل إرسال رسالة إعادة التعيين';

  @override
  String get emailSent => 'تم الإرسال';

  @override
  String get backToLogin => 'العودة لتسجيل الدخول';

  @override
  String get forgotPasswordNote =>
      'تأكد من التحقق من صندوق البريد الوارد ومجلد الرسائل غير المرغوب فيها';

  @override
  String get signupTitle => 'إنشاء حساب جديد';

  @override
  String get fullNameLabel => 'الاسم الكامل';

  @override
  String get chooseRole => 'اختر دورك:';

  @override
  String get roleTrainer => 'مدرب';

  @override
  String get roleTrainee => 'متدرب';

  @override
  String get signupAction => 'إنشاء الحساب';

  @override
  String get haveAccountLogin => 'لديك حساب بالفعل؟ تسجيل الدخول';

  @override
  String get selectRoleError => 'يرجى تحديد دورك (مدرب أو متدرب)';

  @override
  String get createCourseTitle => 'إنشاء كورس جديد';

  @override
  String get courseNameLabel => 'اسم الكورس';

  @override
  String get createCourseAction => 'إنشاء الكورس';

  @override
  String get courseCreatedSuccess => 'تم إنشاء الكورس بنجاح!';

  @override
  String get shareCodeHint => 'شارك هذا الكود مع متدربيك للانضمام:';

  @override
  String get backToHome => 'العودة إلى الرئيسية';

  @override
  String get joinCourseTitle => 'الانضمام إلى كورس';

  @override
  String get enterCourseCode => 'أدخل كود الكورس';

  @override
  String get joinCourseSuccess => 'تم الانضمام إلى الكورس بنجاح!';

  @override
  String get enterCourseCodeError => 'يرجى إدخال كود الكورس';

  @override
  String loginFailed(Object error) {
    return 'فشل تسجيل الدخول: $error';
  }

  @override
  String unexpectedError(Object error) {
    return 'حدث خطأ غير متوقع: $error';
  }

  @override
  String signupFailed(Object error) {
    return 'فشل إنشاء الحساب: $error';
  }

  @override
  String get signupSuccessCheckEmail =>
      'تم إنشاء الحساب! يرجى التحقق من بريدك الإلكتروني للتحقق من حسابك.';

  @override
  String createCourseFailed(Object error) {
    return 'فشل إنشاء الكورس: $error';
  }

  @override
  String joinCourseFailed(Object error) {
    return 'فشل الانضمام إلى الكورس: $error';
  }

  @override
  String get userNotLoggedIn => 'المستخدم غير مسجل دخوله';

  @override
  String get threadTitle => 'المناقشة';

  @override
  String get refreshTooltip => 'تحديث';

  @override
  String get noRepliesYet => 'لا يوجد ردود بعد';

  @override
  String get newTaskHint => 'مهمة جديدة (خطة العمل)';

  @override
  String get addTaskTooltip => 'إضافة مهمة';

  @override
  String get noTasksYet => 'لا مهام بعد';

  @override
  String get autoStopRecording =>
      'تم إيقاف التسجيل تلقائياً (٣ دقائق كحد أقصى)';

  @override
  String previewPlayError(Object error) {
    return 'تعذر تشغيل المعاينة: $error';
  }

  @override
  String get trainerAccountMissing =>
      'تعذر تحديد حساب المدرب. أعد تسجيل الدخول.';

  @override
  String get evaluationSendSuccess => 'تم إرسال التقييم بنجاح!';

  @override
  String evaluationSendFailure(Object message) {
    return 'فشل: $message';
  }

  @override
  String unexpectedErrorMsg(Object error) {
    return 'خطأ غير متوقع: $error';
  }

  @override
  String get courseNameFallback => 'أحد كورساتك';

  @override
  String get notificationNewEvaluationTitle => 'لديك تقييم جديد!';

  @override
  String notificationNewEvaluationBody(Object courseName) {
    return 'قام مدربك بإضافة تقييم جديد لك في كورس: $courseName';
  }

  @override
  String get cancelRecordingTitle => 'إلغاء التسجيل؟';

  @override
  String get cancelRecordingBody =>
      'أنت تسجل الآن. هل تريد إنهاء و فقدان التسجيل الحالي؟';

  @override
  String get dialogNo => 'لا';

  @override
  String get dialogYes => 'نعم';

  @override
  String reportTitle(Object email) {
    return 'تقرير: $email';
  }

  @override
  String get scoreFieldLabel => 'الدرجة (من 100)';

  @override
  String get scoreRequired => 'يرجى إدخال الدرجة';

  @override
  String get scoreRangeError => 'الرجاء إدخال درجة بين 0 و 100';

  @override
  String get feedbackFieldLabel => 'الملاحظات والتقييم';

  @override
  String get feedbackRequired => 'يرجى كتابة الملاحظات';

  @override
  String get audioSectionOptional => 'إضافة تقييم صوتي (اختياري):';

  @override
  String get submitEvaluation => 'إرسال التقييم';

  @override
  String get recordingStartLabel => 'تسجيل تقييم صوتي';

  @override
  String get recordingInProgress => 'جارٍ التسجيل';

  @override
  String get recordedLabel => 'تم التسجيل';

  @override
  String get previewAudioLabel => 'معاينة التسجيل الصوتي';

  @override
  String get previewButton => 'معاينة';

  @override
  String durationLabel(Object value) {
    return 'المدة: $value';
  }

  @override
  String get reRecord => 'إعادة التسجيل';

  @override
  String get pinAction => 'تثبيت';

  @override
  String get unpinAction => 'إلغاء التثبيت';

  @override
  String get copyTextAction => 'نسخ النص';

  @override
  String get editAction => 'تعديل';

  @override
  String get deleteAction => 'حذف';

  @override
  String get copiedToast => 'تم النسخ';

  @override
  String get writeReplyHint => 'اكتب رد...';

  @override
  String get retryLabel => 'إعادة';

  @override
  String get uploadingAudio => 'جاري رفع الصوت...';

  @override
  String get audioFailed => 'فشل';

  @override
  String get audioLabel => 'صوت';

  @override
  String get editCancel => 'إلغاء';

  @override
  String get editSave => 'حفظ';

  @override
  String pinnedReplyLabel(Object id) {
    return 'رد مثبت (ID: $id)';
  }

  @override
  String get commentUnknownUser => 'مستخدم غير معروف';

  @override
  String get commentFallbackName => 'مستخدم';

  @override
  String get commentHint => 'اكتب تعليقًا...';

  @override
  String get noFeedback => 'لا توجد ملاحظات';

  @override
  String get discussionButton => 'الحوار التدريبي';

  @override
  String scoreLabel(Object score) {
    return 'الدرجة: $score/100';
  }

  @override
  String get audioPauseSemantic => 'إيقاف تشغيل التقييم الصوتي';

  @override
  String get audioPlaySemantic => 'تشغيل التقييم الصوتي';

  @override
  String get audioEvaluation => 'التقييم الصوتي';

  @override
  String get audioPlayingNow => 'قيد التشغيل الآن';

  @override
  String get audioTapToPlay => 'إضغط للتشغيل';

  @override
  String get userMissing => 'المستخدم غير موجود';

  @override
  String get dashboardTitleTrainer => 'لوحة التحكم';

  @override
  String get createCourseFab => 'كورس جديد';

  @override
  String loadCoursesError(Object error) {
    return 'خطأ في تحميل الكورسات: $error';
  }

  @override
  String get noTrainerCoursesTitleAlt => 'لم تقم بإنشاء أي كورسات بعد';

  @override
  String get noTrainerCoursesHintAlt => 'اضغط على زر + في الأسفل للبدء';

  @override
  String get loadMore => 'تحميل المزيد';

  @override
  String courseCodePrefix(Object code) {
    return 'الكود: $code';
  }

  @override
  String get homeTitleTrainee => 'الصفحة الرئيسية';

  @override
  String loadErrorGeneric(Object error) {
    return 'خطأ في التحميل: $error';
  }

  @override
  String get noTraineeCoursesTitleAlt => 'لم تنضم إلى أي كورسات بعد';

  @override
  String get noTraineeCoursesHintAlt => 'اضغط على زر + للانضمام إلى كورس جديد';

  @override
  String trainerPrefix(Object id) {
    return 'المدرب: $id';
  }

  @override
  String get joinCourseAction => 'انضمام';

  @override
  String get reportGeneralSection => 'التقييمات العامة';

  @override
  String get reportQuizzesSection => 'نتائج الاختبارات';

  @override
  String get addEvaluationFab => 'إضافة تقييم جديد';

  @override
  String get reportNoEvaluations => 'لا توجد تقييمات عامة لهذا المتدرب بعد.';

  @override
  String get reportNoQuizzes => 'لم يقم المتدرب بتسليم أي اختبارات بعد.';

  @override
  String get leaderboardTitle => 'لوحة الصدارة';

  @override
  String get leaderboardEmpty => 'لا توجد بيانات بعد';

  @override
  String leaderboardPoints(Object points) {
    return '$points نقطة';
  }

  @override
  String get leaderboardWeekly => 'أسبوعي';

  @override
  String get leaderboardMonthly => 'شهري';

  @override
  String get leaderboardAllTime => 'كل الأوقات';

  @override
  String get leaderboardRetry => 'إعادة المحاولة';

  @override
  String get leaderboardLoadError => 'حدث خطأ في تحميل لوحة الصدارة';

  @override
  String get leaderboardNoEntries => 'لا توجد بيانات بعد';

  @override
  String get leaderboardYou => 'أنت';

  @override
  String get leaderboardRank => 'المرتبة';

  @override
  String leaderboardPointsWithLabel(Object points) {
    return '$points نقطة';
  }

  @override
  String get leaderboardPointsShort => 'نقطة';

  @override
  String leaderboardLevelFormat(Object level, Object name) {
    return 'المستوى $level • $name';
  }

  @override
  String get leaderboardEmptyTitle => 'لا يوجد متصدرون بعد';

  @override
  String get leaderboardEmptySubtitle => 'كن أول من يحصل على نقاط!';

  @override
  String get leaderboardErrorLoad => 'حدث خطأ في تحميل المتصدرين';

  @override
  String get pointsLabel => 'النقاط';

  @override
  String get dashboardSeeAll => 'عرض الكل';

  @override
  String get timelineFilterAll => 'الكل';

  @override
  String get timelineFilterQuizzes => 'الاختبارات';

  @override
  String get timelineFilterTasks => 'المهام';

  @override
  String get timelineFilterLessons => 'الدروس';

  @override
  String get timelineFilterStreak => 'السلسلة';

  @override
  String get timelineNoMoreEvents => 'لا مزيد من الأحداث';

  @override
  String get nextBadgeShort => 'الشارة التالية';

  @override
  String get badgesLabel => 'الشارات';

  @override
  String levelLabel(Object level) {
    return 'المستوى $level';
  }

  @override
  String get earnedBadgesSection => 'مكتسبة';

  @override
  String get allBadgesSection => 'الكل';

  @override
  String get noBadgesYet => 'لا شارات بعد';

  @override
  String get reviewsTitle => 'التقييمات';

  @override
  String get addReviewAction => 'إضافة تقييم';

  @override
  String get ratingLabel => 'التقييم';

  @override
  String get reviewSubmitSuccess => 'تم إرسال التقييم';

  @override
  String get reviewSubmitFailure => 'فشل إرسال التقييم';

  @override
  String averageRatingLabel(Object value) {
    return 'المتوسط: $value';
  }

  @override
  String streakLabel(Object days) {
    return 'سلسلة الأيام: $days يوم';
  }

  @override
  String nextBadgeProgress(Object points) {
    return 'الشارة التالية عند $points نقطة';
  }

  @override
  String dailyStreakAward(Object points) {
    return '+$points سلسلة يومية';
  }

  @override
  String quizPassedAward(Object points) {
    return '+$points اجتياز اختبار';
  }

  @override
  String lessonCompletedAward(Object points) {
    return '+$points إكمال درس';
  }

  @override
  String badgeEarnedToast(Object name) {
    return 'حصلت على شارة: $name';
  }

  @override
  String badgesEarnedBatch(Object first, Object more) {
    return 'حصلت على شارة: $first +$more';
  }

  @override
  String get noReviewsYet => 'لا توجد تقييمات بعد';

  @override
  String get submitReview => 'إرسال التقييم';

  @override
  String get reviewCommentHint => 'تعليقك';

  @override
  String get reviewRatingHint => 'اضغط على النجوم للتقييم';

  @override
  String get gamificationSection => 'التقدم والإنجازات';

  @override
  String get progressTitle => 'التقدم';

  @override
  String get testsTabLabel => 'اختبارات';

  @override
  String get tasksTabLabel => 'تاسكات';

  @override
  String get noQuizzesYet => 'لا توجد اختبارات حالياً';

  @override
  String quizLastScore(Object score) {
    return 'آخر نتيجة: $score%';
  }

  @override
  String get quizNotStarted => 'لم تبدأ بعد';

  @override
  String get quizStartAction => 'ابدأ';

  @override
  String get quizRetakeAction => 'إعادة';

  @override
  String get noTasksYetAlt => 'لا توجد تاسكات حالياً';

  @override
  String get addTaskDialogTitle => 'تاسك جديدة';

  @override
  String get fieldTitleHint => 'العنوان';

  @override
  String get fieldDetailsHint => 'تفاصيل (اختياري)';

  @override
  String get fieldPointsHint => 'النقاط';

  @override
  String get priorityLabel => 'الأولوية';

  @override
  String get priorityHigh => 'أولوية عالية';

  @override
  String get priorityMed => 'أولوية متوسطة';

  @override
  String get priorityLow => 'أولوية منخفضة';

  @override
  String get taskStatusNew => 'جديد';

  @override
  String get taskStatusInProgress => 'قيد التنفيذ';

  @override
  String get taskStatusDone => 'مكتمل';

  @override
  String get badgeManageTitle => 'إدارة الشارات';

  @override
  String get noBadgesDefined => 'لا توجد شارات';

  @override
  String get newBadgeTitle => 'شارة جديدة';

  @override
  String get editBadgeTitle => 'تعديل الشارة';

  @override
  String get deleteBadgeTitle => 'حذف الشارة';

  @override
  String deleteConfirmBody(Object name) {
    return 'حذف الشارة: $name?';
  }

  @override
  String get badgeIconUrlLabel => 'رابط الأيقونة';

  @override
  String get criteriaSectionLabel => 'المعايير';

  @override
  String get activeLabel => 'مفعلة';

  @override
  String get autoAwardLabel => 'منح تلقائي';

  @override
  String get saveActionLabel => 'حفظ';

  @override
  String get dialogCancel => 'إلغاء';

  @override
  String get taskStatusSkipped => 'متجاوز';

  @override
  String get filterAll => 'الكل';

  @override
  String get selectDueDate => 'اختر تاريخ الاستحقاق';

  @override
  String get dueDatePickerLabel => 'الاستحقاق';

  @override
  String get pickAction => 'اختيار';

  @override
  String get changeAction => 'تغيير';

  @override
  String get clearAction => 'مسح';

  @override
  String get duePast => 'منتهي';

  @override
  String get dueToday => 'اليوم';

  @override
  String get dueTomorrow => 'غداً';

  @override
  String dueInDays(Object days) {
    return 'بعد $days يوم';
  }

  @override
  String get quizPassedLabel => 'ناجح';

  @override
  String get quizSubmitAction => 'إرسال الاختبار';

  @override
  String quizPassThreshold(Object score) {
    return 'نجاح >= $score%';
  }

  @override
  String get taskDueFilterOverdue => 'متأخرة';

  @override
  String get taskDueFilterToday => 'اليوم';

  @override
  String get taskDueFilterWeek => 'هذا الأسبوع';

  @override
  String quizAttemptsUsed(Object used, Object max) {
    return 'المحاولات: $used/$max';
  }

  @override
  String get quizAttemptExceeded => 'لا مزيد من المحاولات';

  @override
  String get quizAttemptSingle => 'محاولة واحدة';

  @override
  String quizAttemptMultiple(Object max) {
    return 'حتى $max محاولات';
  }

  @override
  String get quizReviewAction => 'مراجعة';

  @override
  String get quizSettingsTitle => 'إعدادات الاختبار';

  @override
  String get quizPassPercentLabel => 'نسبة النجاح %';

  @override
  String get quizRewardPointsLabel => 'نقاط المكافأة';

  @override
  String get quizMaxAttemptsLabel => 'الحد الأقصى للمحاولات';

  @override
  String get quizUpdateSuccess => 'تم التحديث';

  @override
  String get quizUpdateFailed => 'فشل التحديث';

  @override
  String get postPublishing => '... يتم نشر المنشور';

  @override
  String get postPublished => 'تم نشر المنشور';

  @override
  String get orgAdminDashboardTitle => 'لوحة إدارة المؤسسة';

  @override
  String get orgAdminDashboardSubtitle => 'مقاييس واتجاهات للمؤسسة';

  @override
  String get companyAdminDashboardTitle => 'لوحة إدارة الشركة';

  @override
  String get companyAdminDashboardSubtitle => 'مقاييس واتجاهات لشركتك';

  @override
  String get departmentsTitle => 'الأقسام';

  @override
  String get departmentsSubtitle => 'عرض أقسام شركتك';

  @override
  String get learningPathsTitle => 'مسارات التعلم';

  @override
  String get learningPathsSubtitle => 'عرض مسارات التعلم لشركتك';

  @override
  String get managerDashboardTitle => 'لوحة المدير';

  @override
  String get managerDashboardSubtitle =>
      'نظرة عامة على الفريق وفجوات المهارات (تجريبي)';

  @override
  String get bulkImportTitle => 'استيراد دفعة (CSV)';

  @override
  String get bulkImportSubtitle => 'استيراد تغييرات مجمعة من ملف CSV';

  @override
  String get selectDepartmentHint => 'اختر قسمًا من قائمة الأقسام لعرض الفريق.';

  @override
  String get labelActiveUsers => 'المستخدمون النشطون';

  @override
  String get labelAvgEventsPerUser7d => 'متوسط الأحداث/مستخدم (٧ أيام)';

  @override
  String get labelAvgMastery => 'متوسط الإتقان';

  @override
  String get labelAvgMasteryDelta14d => 'متوسط الإتقان Δ14ي';

  @override
  String get labelLatestPrefix => 'الأحدث';

  @override
  String get labelLatest7Days => 'آخر 7 أيام';

  @override
  String get labelDate => 'التاريخ';

  @override
  String get labelActiveShort => 'نشط';

  @override
  String get labelAvgEvPerUsrShort => 'متوسط/مستخدم';

  @override
  String get labelAvgMasteryShort => 'متوسط إتقان';

  @override
  String get labelDelta14dShort => 'Δ14ي';

  @override
  String get noDepartments => 'لا توجد أقسام';

  @override
  String idLabel(Object id) {
    return 'المعرف: $id';
  }

  @override
  String get noTeamMembers => 'لا يوجد أعضاء فريق في هذا القسم';

  @override
  String get topSkillGapsTitle => 'أكبر فجوات المهارات';

  @override
  String get noSkillData => 'لا توجد بيانات مهارات';

  @override
  String get activeChip => 'مفعل';

  @override
  String get inactiveChip => 'غير مفعل';

  @override
  String pathTitle(Object title) {
    return 'المسار: $title';
  }

  @override
  String get noLearningPaths => 'لا توجد مسارات تعلم';

  @override
  String get noSteps => 'لا توجد خطوات';

  @override
  String get bulkImportCsvFormat =>
      'صيغة CSV: collection,docId,field.path,value';

  @override
  String get bulkImportPickCsv => 'اختيار CSV';

  @override
  String get departmentsAddAction => 'إضافة قسم';

  @override
  String get departmentNameLabel => 'اسم القسم';

  @override
  String get assignUserToDepartmentTitle => 'تعيين مستخدم إلى القسم';

  @override
  String get departmentMembersTitle => 'أعضاء القسم';

  @override
  String get manageMembersAction => 'إدارة الأعضاء';

  @override
  String get assignMemberAction => 'تعيين عضو';

  @override
  String get searchUsersLabel => 'ابحث عن المستخدمين بالاسم أو البريد';

  @override
  String get noResults => 'لا توجد نتائج';

  @override
  String get assignSelectedAction => 'تعيين المحددين';

  @override
  String get selectAtLeastOneUser => 'اختر مستخدمًا واحدًا على الأقل';

  @override
  String assignmentCompletedToast(Object count) {
    return 'تم تعيين $count عضو/أعضاء';
  }

  @override
  String get removeMemberConfirm => 'هل تريد إزالة هذا العضو من القسم؟';

  @override
  String get memberRemovedToast => 'تمت إزالة العضو';

  @override
  String departmentCreatedToast(Object name) {
    return 'تم إنشاء القسم: $name';
  }

  @override
  String get alreadyMemberLabel => 'عضو بالفعل في هذا القسم';

  @override
  String get pleaseSelectRole => 'الرجاء اختيار الدور';

  @override
  String get authErrorWrongPassword =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة';

  @override
  String get authErrorUserNotFound => 'البريد الإلكتروني غير مسجل';

  @override
  String get authErrorEmailInUse => 'البريد الإلكتروني مسجل بالفعل';

  @override
  String get authErrorInvalidEmail => 'البريد الإلكتروني غير صحيح';

  @override
  String get authErrorWeakPassword => 'كلمة المرور ضعيفة جداً';

  @override
  String get authErrorUserDisabled => 'هذا الحساب معطل. يرجى التواصل مع الدعم';

  @override
  String get authErrorTooManyRequests => 'محاولات كثيرة. يرجى المحاولة لاحقاً';

  @override
  String get authErrorNetworkFailed => 'خطأ في الاتصال بالإنترنت';

  @override
  String get authErrorOperationNotAllowed => 'العملية غير مسموح بها';

  @override
  String get authErrorDefault => 'حدث خطأ أثناء المصادقة';

  @override
  String get dialogConfirmTitle => 'تأكيد';

  @override
  String get dialogDeleteTitle => 'حذف';

  @override
  String get dialogCancelButton => 'إلغاء';

  @override
  String get dialogConfirmButton => 'تأكيد';

  @override
  String get dialogDeleteButton => 'حذف';

  @override
  String get dialogSaveButton => 'حفظ';

  @override
  String get dialogCloseButton => 'إغلاق';

  @override
  String get commentReply => 'رد';

  @override
  String get commentEdit => 'تعديل';

  @override
  String get commentDelete => 'حذف';

  @override
  String get commentDeleteConfirm => 'هل أنت متأكد؟';

  @override
  String get commentDeleteTitle => 'حذف التعليق';

  @override
  String get filterPostsTitle => 'تصفية المنشورات';

  @override
  String get sortPostsTitle => 'ترتيب المنشورات';

  @override
  String get filterClearDates => 'مسح التواريخ';

  @override
  String get filterReset => 'إعادة تعيين';

  @override
  String get filterApply => 'تطبيق';

  @override
  String get sortPinnedFirst => 'المثبتة أولاً';

  @override
  String get reactionsClose => 'إغلاق';

  @override
  String get privacyPolicyTitle => 'سياسة الخصوصية';

  @override
  String get termsOfServiceTitle => 'شروط الاستخدام';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get superAdminDashboard => 'لوحة الإدارة الرئيسية';

  @override
  String get superAdminDashboardSubtitle =>
      'إدارة المؤسسات والشركات والإعدادات';

  @override
  String get searchPostsPlaceholder => 'البحث في المنشورات...';

  @override
  String get filterButtonTooltip => 'تصفية';

  @override
  String get sortButtonTooltip => 'ترتيب';

  @override
  String get postTypeFilter => 'نوع المنشور';

  @override
  String get dateRangeFilter => 'نطاق التاريخ';

  @override
  String get dateFromLabel => 'من تاريخ';

  @override
  String get dateToLabel => 'إلى تاريخ';

  @override
  String get postDeleteTitle => 'حذف المنشور';

  @override
  String get postDeleteConfirm => 'هل أنت متأكد من حذف هذا المنشور؟';

  @override
  String get postDeleted => 'تم حذف المنشور';

  @override
  String get postPinned => 'تم التثبيت';

  @override
  String get postUnpinned => 'تم إلغاء التثبيت';

  @override
  String get postEditButton => 'تعديل';

  @override
  String get postPinButton => 'تثبيت';

  @override
  String get postUnpinButton => 'إلغاء التثبيت';

  @override
  String get postDeleteButton => 'حذف';

  @override
  String get postEditedLabel => 'معدّل';

  @override
  String get postAuthorFallback => 'مستخدم';

  @override
  String postCommentCount(Object count) {
    return '$count تعليق';
  }

  @override
  String get postCommentButton => 'تعليق';

  @override
  String get reactionPickerTitle => 'اختر تفاعلك';

  @override
  String get reactionAddTooltip => 'إضافة تفاعل';

  @override
  String get addPostTitle => 'منشور جديد';

  @override
  String get addPostContentPlaceholder => 'ماذا تريد أن تشارك؟';

  @override
  String get addPostContentRequired => 'يرجى كتابة محتوى أو إضافة صورة';

  @override
  String get addPostPickImages => 'اختيار صور';

  @override
  String get addPostTakePhoto => 'التقاط صورة';

  @override
  String addPostSelectedImages(Object count) {
    return 'الصور المحددة ($count/5):';
  }

  @override
  String addPostUploadingImages(Object percent) {
    return 'جاري رفع الصور... $percent%';
  }

  @override
  String get addPostPublishing => 'جاري نشر المنشور...';

  @override
  String get addPostPublishButton => 'نشر';

  @override
  String get addPostPublishingButton => 'جاري النشر...';

  @override
  String get addPostSuccess => 'تم نشر المنشور بنجاح';

  @override
  String addPostUploadError(Object error) {
    return 'خطأ في رفع الصور: $error';
  }

  @override
  String addPostCharacterCount(Object current, Object max) {
    return '$current/$max';
  }

  @override
  String get editPostTitle => 'تعديل المنشور';

  @override
  String get editPostPlaceholder => 'اكتب محتوى المنشور...';

  @override
  String editPostCharacterCount(Object current, Object max) {
    return '$current/$max حرف';
  }

  @override
  String get editPostSaveButton => 'حفظ';

  @override
  String get editPostSuccess => 'تم تحديث المنشور';

  @override
  String get createPollTitle => 'إنشاء استطلاع';

  @override
  String get createPollQuestionLabel => 'السؤال';

  @override
  String get createPollQuestionHint => 'اكتب سؤال الاستطلاع...';

  @override
  String get createPollQuestionRequired => 'الرجاء إدخال السؤال';

  @override
  String get createPollOptionsTitle => 'الخيارات';

  @override
  String createPollOptionLabel(Object number) {
    return 'الخيار $number';
  }

  @override
  String get createPollOptionRequired => 'مطلوب';

  @override
  String get createPollAddOption => 'إضافة خيار';

  @override
  String get createPollMaxOptionsError => 'الحد الأقصى 10 خيارات';

  @override
  String get createPollMinOptionsError => 'يجب أن يكون هناك على الأقل خيارين';

  @override
  String get createPollMinOptionsSubmitError => 'يجب إضافة خيارين على الأقل';

  @override
  String get createPollSettingsTitle => 'الإعدادات';

  @override
  String get createPollAllowMultiple => 'السماح باختيار أكثر من خيار';

  @override
  String get createPollShowResults => 'إظهار النتائج قبل التصويت';

  @override
  String get createPollEndDateLabel => 'تاريخ انتهاء الاستطلاع';

  @override
  String get createPollEndDateNone => 'لا يوجد (مفتوح دائماً)';

  @override
  String get createPollCreateButton => 'إنشاء';

  @override
  String get createPollCreatingButton => 'جاري الإنشاء...';

  @override
  String get createPollSuccess => 'تم إنشاء الاستطلاع بنجاح';

  @override
  String get reportDialogTitle => 'الإبلاغ عن محتوى';

  @override
  String get reportTypeLabel => 'نوع البلاغ';

  @override
  String get reportTypeInappropriate => 'محتوى غير لائق';

  @override
  String get reportTypeHarassment => 'تحرش أو مضايقة';

  @override
  String get reportTypeSpam => 'رسائل غير مرغوب فيها';

  @override
  String get reportTypeMisinformation => 'معلومات مضللة';

  @override
  String get reportTypeHarmful => 'محتوى ضار';

  @override
  String get reportTypeCopyright => 'انتهاك حقوق النشر';

  @override
  String get reportTypeOther => 'أخرى';

  @override
  String get reportReasonLabel => 'السبب *';

  @override
  String get reportReasonHint => 'أدخل سبب الإبلاغ';

  @override
  String get reportReasonRequired => 'يرجى إدخال سبب الإبلاغ';

  @override
  String get reportDescriptionLabel => 'تفاصيل إضافية (اختياري)';

  @override
  String get reportDescriptionHint => 'أضف أي تفاصيل إضافية تساعد في المراجعة';

  @override
  String get reportReviewNote => 'سيتم مراجعة البلاغ من قبل فريق الإشراف';

  @override
  String get reportSubmitButton => 'إرسال البلاغ';

  @override
  String get reportSuccess =>
      'تم إرسال البلاغ بنجاح. سيتم مراجعته من قبل المشرفين.';

  @override
  String get reportError => 'حدث خطأ أثناء إرسال البلاغ';

  @override
  String get reportLoginRequired => 'يجب تسجيل الدخول أولاً';

  @override
  String get reportButtonLabel => 'الإبلاغ';

  @override
  String get commentPlaceholder => 'اكتب تعليقك...';

  @override
  String get pollNotFound => 'لم يتم العثور على الاستطلاع';

  @override
  String pollError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get pollHeaderLabel => 'استطلاع رأي';

  @override
  String get pollEndedLabel => 'منتهي';

  @override
  String get pollVotesSingular => 'صوت';

  @override
  String get pollVotesPlural => 'أصوات';

  @override
  String pollVotesCount(Object count, Object votes) {
    return '$count $votes';
  }

  @override
  String pollEndsIn(Object time) {
    return 'ينتهي $time';
  }

  @override
  String pollEnded(Object time) {
    return 'انتهى $time';
  }

  @override
  String pollVoteError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String pollOptionVotesSingular(Object count) {
    return '$count صوت';
  }

  @override
  String pollOptionVotesPlural(Object count) {
    return '$count أصوات';
  }

  @override
  String imageViewerTitle(Object current, Object total) {
    return '$current / $total';
  }

  @override
  String get imageDownloadTooltip => 'تحميل';

  @override
  String get imageDownloadSuccess => 'تم فتح الصورة في المتصفح للتحميل';

  @override
  String get imageDownloadError => 'لا يمكن فتح الرابط';

  @override
  String get imageLoadError => 'فشل تحميل الصورة';

  @override
  String imageErrorGeneric(Object error) {
    return 'حدث خطأ: $error';
  }

  @override
  String get reactionPickerTitleAlt => 'اختر تفاعلك';

  @override
  String reactionError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get reactionLiked => 'أعجبني';

  @override
  String get reactionLike => 'إعجاب';

  @override
  String get courseChatTitle => 'محادثة الكورس';

  @override
  String get courseChatLoginRequired => 'يجب تسجيل الدخول';

  @override
  String courseChatLoadError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get courseChatMute => 'كتم الإشعارات';

  @override
  String get courseChatUnmute => 'إلغاء كتم الإشعارات';

  @override
  String get courseChatInfo => 'معلومات المحادثة';

  @override
  String courseChatMessageSendError(Object error) {
    return 'فشل إرسال الرسالة: $error';
  }

  @override
  String get courseChatEditMessage => 'تعديل';

  @override
  String get courseChatDeleteMessage => 'حذف';

  @override
  String get courseChatFlagMessage => 'إبلاغ';

  @override
  String get courseChatEditTitle => 'تعديل الرسالة';

  @override
  String get courseChatEditPlaceholder => 'الرسالة الجديدة';

  @override
  String get courseChatEditSuccess => 'تم تعديل الرسالة';

  @override
  String courseChatEditError(Object error) {
    return 'فشل التعديل: $error';
  }

  @override
  String get courseChatDeleteTitle => 'حذف الرسالة';

  @override
  String get courseChatDeleteConfirm => 'هل أنت متأكد من حذف هذه الرسالة؟';

  @override
  String get courseChatDeleteSuccess => 'تم حذف الرسالة';

  @override
  String courseChatDeleteError(Object error) {
    return 'فشل الحذف: $error';
  }

  @override
  String get courseChatFlagSuccess => 'تم الإبلاغ عن الرسالة';

  @override
  String courseChatFlagError(Object error) {
    return 'فشل الإبلاغ: $error';
  }

  @override
  String get courseChatMuteSuccess => 'تم كتم الإشعارات';

  @override
  String get courseChatUnmuteSuccess => 'تم إلغاء كتم الإشعارات';

  @override
  String get courseChatMuteError => 'حدث خطأ في تغيير حالة الكتم';

  @override
  String get courseChatInfoTitle => 'معلومات المحادثة';

  @override
  String courseChatInfoCourse(Object name) {
    return 'الكورس: $name';
  }

  @override
  String courseChatInfoParticipants(Object count) {
    return 'عدد المشاركين: $count';
  }

  @override
  String courseChatInfoCreated(Object date) {
    return 'تاريخ الإنشاء: $date';
  }

  @override
  String get courseChatInfoClose => 'إغلاق';

  @override
  String get directChatTitle => 'محادثة مباشرة';

  @override
  String get directChatTyping => 'يكتب...';

  @override
  String get directChatLoginError => 'خطأ: لم يتم العثور على بيانات المستخدم';

  @override
  String get directChatBlockTitle => 'حظر المستخدم';

  @override
  String get directChatBlockConfirm =>
      'هل تريد حظر هذا المستخدم؟ لن تتمكن من استقبال رسائله.';

  @override
  String get directChatBlockSuccess => 'تم حظر المستخدم';

  @override
  String get directChatBlockError => 'فشل حظر المستخدم';

  @override
  String get directChatBlock => 'حظر';

  @override
  String get directChatReport => 'إبلاغ';

  @override
  String get directChatDeleteTitle => 'حذف المحادثة';

  @override
  String get directChatDeleteConfirm =>
      'هل تريد حذف هذه المحادثة؟ سيتم إخفاؤها من قائمتك فقط.';

  @override
  String get directChatDeleteSuccess => 'تم حذف المحادثة';

  @override
  String get directChatDeleteError => 'فشل حذف المحادثة';

  @override
  String get directChatEmptyMessage => 'ابدأ المحادثة...';

  @override
  String directChatError(Object error) {
    return 'حدث خطأ: $error';
  }

  @override
  String get directChatAttachFile => 'إرفاق';

  @override
  String directChatFileUploadError(Object error) {
    return 'فشل رفع الملف: $error';
  }

  @override
  String get directChatAttachImage => 'صورة';

  @override
  String directChatImageUploadError(Object error) {
    return 'فشل رفع الصورة: $error';
  }

  @override
  String get directChatImageLabel => 'صورة';

  @override
  String get directChatMessagePlaceholder => 'اكتب رسالة...';

  @override
  String get directChatMessageDeleted => 'تم حذف هذه الرسالة';

  @override
  String get directChatMessageEdited => 'معدلة';

  @override
  String get directChatEditTitle => 'تعديل الرسالة';

  @override
  String get directChatEditPlaceholder => 'الرسالة الجديدة';

  @override
  String get directChatEditSuccess => 'تم التعديل';

  @override
  String get directChatEditError => 'فشل التعديل';

  @override
  String get directChatDeleteMessageTitle => 'حذف الرسالة';

  @override
  String get directChatDeleteMessageConfirm =>
      'هل أنت متأكد من حذف هذه الرسالة؟';

  @override
  String get directChatDeleteMessageSuccess => 'تم الحذف';

  @override
  String get directChatDeleteMessageError => 'فشل الحذف';

  @override
  String get directMessagesTitle => 'المحادثات';

  @override
  String get directMessagesLoginRequired => 'يرجى تسجيل الدخول';

  @override
  String get directMessagesSearchPlaceholder => 'ابحث في المحادثات...';

  @override
  String get directMessagesSearchCancel => 'إلغاء البحث';

  @override
  String get directMessagesSearchTooltip => 'بحث';

  @override
  String get directMessagesEmpty => 'لا توجد محادثات بعد';

  @override
  String get directMessagesNoResults => 'لا توجد نتائج';

  @override
  String get directMessagesNoResultsHint => 'جرب كلمات بحث مختلفة';

  @override
  String get directMessagesEmptyHint => 'ابدأ محادثة جديدة من قائمة الأعضاء';

  @override
  String get directMessagesArchiveSuccess => 'تم الأرشفة';

  @override
  String get directMessagesMuteSuccess => 'تم كتم الإشعارات';

  @override
  String get directMessagesUnmuteSuccess => 'تم إلغاء الكتم';

  @override
  String get directMessagesNewChatTooltip => 'محادثة جديدة';

  @override
  String directMessagesError(Object error) {
    return 'حدث خطأ: $error';
  }

  @override
  String get directMessagesUser => 'مستخدم';

  @override
  String get directMessagesNoMessages => 'لا توجد رسائل';

  @override
  String get superAdminDashboardTitle => 'المدير الأعلى';

  @override
  String get superAdminDashboardHome => 'الرئيسية';

  @override
  String get superAdminDashboardUnauthorized => 'غير مصرح (المدير الأعلى فقط)';

  @override
  String get superAdminTotalUsers => 'إجمالي المستخدمين';

  @override
  String get superAdminTrainers => 'المدربون';

  @override
  String get superAdminTrainees => 'المتدربون';

  @override
  String get superAdminSystemSettings => 'إعدادات النظام';

  @override
  String superAdminFlags(Object count) {
    return 'الأعلام: $count';
  }

  @override
  String superAdminThresholds(Object count) {
    return 'العتبات: $count';
  }

  @override
  String get superAdminNoSettings => 'لم يتم تحميل الإعدادات';

  @override
  String get superAdminTenantReads => 'قراءات المستأجر';

  @override
  String get superAdminTenantWrites => 'كتابات المستأجر';

  @override
  String get superAdminFlagRecommendation =>
      'توصية: فعّل القراءات أولاً، ثم الكتابات بعد التحقق من عدم وجود تسرب بين المستأجرين.';

  @override
  String superAdminSettingsError(Object error) {
    return 'خطأ في الإعدادات: $error';
  }

  @override
  String get superAdminUsersFirst50 => 'المستخدمون (أول 50)';

  @override
  String superAdminUsersLoadError(Object error) {
    return 'خطأ في تحميل المستخدمين: $error';
  }

  @override
  String get superAdminAlerts => 'التنبيهات';

  @override
  String get superAdminIntrusionAlerts => 'تنبيهات الاختراق';

  @override
  String get superAdminPredictiveAlerts => 'التنبيهات التنبؤية';

  @override
  String get superAdminIntegrityFlags => 'أعلام التكامل';

  @override
  String superAdminAlertError(Object title, Object error) {
    return '$title خطأ: $error';
  }

  @override
  String superAdminNoAlerts(Object title) {
    return 'لا توجد $title';
  }

  @override
  String superAdminMoreAlerts(Object count) {
    return '+$count أكثر…';
  }

  @override
  String get superAdminTenants => 'المستأجرون';

  @override
  String get superAdminInstitutions => 'المؤسسات';

  @override
  String get superAdminNoInstitutions => 'لا توجد مؤسسات';

  @override
  String superAdminInstitutionsError(Object error) {
    return 'خطأ في المؤسسات: $error';
  }

  @override
  String get superAdminCompanies => 'الشركات';

  @override
  String get superAdminNoCompanies => 'لا توجد شركات';

  @override
  String superAdminCompaniesError(Object error) {
    return 'خطأ في الشركات: $error';
  }

  @override
  String get superAdminCreateInstitution => 'إنشاء مؤسسة';

  @override
  String get superAdminCreateCompany => 'إنشاء شركة';

  @override
  String get superAdminInstitutionDialogTitle => 'إنشاء مؤسسة';

  @override
  String get superAdminCompanyDialogTitle => 'إنشاء شركة';

  @override
  String get superAdminNameLabel => 'الاسم';

  @override
  String get superAdminNameRequired => 'مطلوب';

  @override
  String get superAdminPlanTierLabel => 'مستوى الخطة';

  @override
  String get superAdminPlanTierRequired => 'مطلوب';

  @override
  String get superAdminDialogCancel => 'إلغاء';

  @override
  String get superAdminDialogCreate => 'إنشاء';

  @override
  String get superAdminInstitutionCreated => 'تم إنشاء المؤسسة';

  @override
  String get superAdminCompanyCreated => 'تم إنشاء الشركة';

  @override
  String superAdminCreateError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get companyAdminHome => 'الرئيسية';

  @override
  String companyAdminError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get orgAdminHome => 'الرئيسية';

  @override
  String orgAdminError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String orgAdminLatest(Object value) {
    return 'الأحدث: $value';
  }

  @override
  String get orgAdminActiveUsers => 'المستخدمين النشطين';

  @override
  String get orgAdminAvgEventsPerUser7d => 'متوسط الأحداث/مستخدم (7 أيام)';

  @override
  String get orgAdminAvgMastery => 'متوسط الإتقان';

  @override
  String get orgAdminAvgMasteryDelta14d => 'تغيير متوسط الإتقان (14 يوم)';

  @override
  String get orgAdminLatest7Days => 'آخر 7 أيام';

  @override
  String get orgAdminDate => 'التاريخ';

  @override
  String get orgAdminActive => 'نشط';

  @override
  String get orgAdminAvgEvPerUsr => 'متوسط أح/مستخدم';

  @override
  String get orgAdminAvgMasteryShort => 'متوسط إتقان';

  @override
  String get orgAdminDelta14d => 'Δ14 يوم';

  @override
  String get takeQuizNoQuestions => 'لا توجد أسئلة في هذا الاختبار بعد.';

  @override
  String takeQuizQuestionProgress(Object current, Object total) {
    return 'السؤال $current من $total';
  }

  @override
  String get takeQuizShortAnswerLabel => 'إجابتك القصيرة';

  @override
  String get takeQuizEssayAnswerLabel => 'إجابتك المقالية';

  @override
  String get takeQuizMatchingSelect => 'اختر';

  @override
  String get takeQuizUnsupportedType => 'نوع سؤال غير مدعوم بعد';

  @override
  String get takeQuizPreviousButton => 'السابق';

  @override
  String get takeQuizNextButton => 'التالي';

  @override
  String get takeQuizSubmitButton => 'تسليم الإجابات';

  @override
  String takeQuizSubmissionFailed(Object message) {
    return 'فشل التسليم: $message';
  }

  @override
  String get quizResultsTitle => 'نتيجة الاختبار';

  @override
  String get quizResultsCompleted => 'لقد أكملت الاختبار!';

  @override
  String get quizResultsYourScore => 'نتيجتك هي:';

  @override
  String quizResultsScoreDisplay(Object score, Object total) {
    return '$score / $total';
  }

  @override
  String get quizResultsBackButton => 'العودة إلى قائمة الاختبارات';

  @override
  String get createQuizTitle => 'إنشاء اختبار جديد';

  @override
  String get createQuizTitleLabel => 'عنوان الاختبار';

  @override
  String get createQuizTitleHint => 'مثال: اختبار أساسيات Flutter';

  @override
  String get createQuizTitleRequired => 'يرجى إدخال عنوان للاختبار';

  @override
  String get createQuizNextButton => 'التالي: إضافة الأسئلة';

  @override
  String get createQuizSuccess => 'تم إنشاء الاختبار - أضف الأسئلة الآن';

  @override
  String createQuizError(Object error) {
    return 'حدث خطأ: $error';
  }

  @override
  String get addQuestionTitle => 'إضافة أسئلة للاختبار';

  @override
  String get addQuestionNoQuestionsYet => 'لم يتم إضافة أي أسئلة بعد.';

  @override
  String addQuestionQuestionsAdded(Object count) {
    return 'الأسئلة المضافة: $count';
  }

  @override
  String get addQuestionNewQuestion => 'إضافة سؤال جديد:';

  @override
  String get addQuestionTypeLabel => 'نوع السؤال: ';

  @override
  String get addQuestionTypeMultipleChoice => 'اختيار من متعدد';

  @override
  String get addQuestionTypeShortAnswer => 'إجابة قصيرة';

  @override
  String get addQuestionTypeLongAnswer => 'إجابة طويلة';

  @override
  String get addQuestionTypeMatching => 'مطابقة (توصيل)';

  @override
  String get addQuestionTextLabel => 'نص السؤال';

  @override
  String get addQuestionFieldRequired => 'الحقل مطلوب';

  @override
  String get addQuestionOption1 => 'الخيار 1';

  @override
  String get addQuestionOption2 => 'الخيار 2';

  @override
  String get addQuestionOption3 => 'الخيار 3';

  @override
  String get addQuestionOption4 => 'الخيار 4';

  @override
  String get addQuestionSelectCorrect => 'حدد الإجابة الصحيحة:';

  @override
  String get addQuestionMatchingPairs => 'أزواج المطابقة (يسار ⇄ يمين):';

  @override
  String addQuestionLeft(Object n) {
    return 'يسار $n';
  }

  @override
  String addQuestionRight(Object n) {
    return 'يمين $n';
  }

  @override
  String get addQuestionAddButton => 'إضافة السؤال';

  @override
  String get addQuestionSelectCorrectSnackbar =>
      'حدد الإجابة الصحيحة (اختيار من متعدد)';

  @override
  String get addQuestionValidPairsError =>
      'أدخل أزواج مطابقة صالحة (على الأقل زوجان وبعدد متساوٍ)';

  @override
  String addQuestionError(Object error) {
    return 'حدث خطأ: $error';
  }

  @override
  String get wallCommentsTitle => 'التعليقات';

  @override
  String get wallCommentsReplyAdded => 'تم إضافة الرد';

  @override
  String get wallCommentsCommentAdded => 'تم إضافة التعليق';

  @override
  String wallCommentsError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get wallCommentsNoCommentsYet => 'لا توجد تعليقات حتى الآن';

  @override
  String get wallCommentsBeFirstToComment => 'كن أول من يعلّق!';

  @override
  String wallCommentsReplyingTo(Object username) {
    return 'الرد على $username';
  }

  @override
  String get wallCommentsReplyPlaceholder => 'اكتب ردك...';

  @override
  String get wallCommentsCommentPlaceholder => 'اكتب تعليقاً...';

  @override
  String get wallCommentsCommentEdited => 'تم تعديل التعليق';

  @override
  String get wallCommentsHideReplies => 'إخفاء الردود';

  @override
  String wallCommentsShowReplies(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ردود',
      one: 'رد',
    );
    return '$count $_temp0';
  }

  @override
  String get recommendationDismissTooltip => 'رفض التوصية';

  @override
  String get recommendationHighPriority => 'أولوية عالية';

  @override
  String recommendationConfidence(Object percent) {
    return '$percent% ثقة';
  }

  @override
  String recommendationMinutes(Object minutes) {
    return '$minutes دقيقة';
  }

  @override
  String get recommendationReasonWeakPerformance => 'لتحسين الأداء';

  @override
  String get recommendationReasonInterests => 'بناءً على اهتماماتك';

  @override
  String get recommendationReasonNextStep => 'الخطوة التالية';

  @override
  String get recommendationReasonSkillGap => 'لسد فجوة مهارية';

  @override
  String get recommendationReasonPopularWithPeers => 'شائع بين زملائك';

  @override
  String get recommendationReasonPathCompletion => 'لإكمال المسار';

  @override
  String get recommendationReasonStrengthenSkill => 'لتعزيز مهاراتك';

  @override
  String get recommendationsEmpty => 'لا توجد توصيات حالياً';

  @override
  String get recommendationsEmptyHint => 'سنقوم بإنشاء توصيات مخصصة لك قريباً';

  @override
  String recommendationsOpenSnackbar(Object title) {
    return 'فتح: $title';
  }

  @override
  String get recommendationsDismissedSnackbar => 'تم رفض التوصية';

  @override
  String get recommendationsError => 'حدث خطأ في تحميل التوصيات';

  @override
  String get networkStatusOfflineBanner =>
      'لا يوجد اتصال بالإنترنت - العمل في وضع عدم الاتصال';

  @override
  String get networkStatusOfflineMessage =>
      'لا يوجد اتصال بالإنترنت. تحقق من الاتصال وحاول مرة أخرى.';

  @override
  String get networkStatusPermissionDenied =>
      'ليس لديك صلاحية للوصول لهذه البيانات';

  @override
  String get networkStatusNotFound => 'البيانات المطلوبة غير موجودة';

  @override
  String get networkStatusUnknownError => 'حدث خطأ غير متوقع. حاول مرة أخرى.';

  @override
  String get networkStatusRetryButton => 'إعادة المحاولة';

  @override
  String get commentReactionLoginRequired => 'يجب تسجيل الدخول للتفاعل';

  @override
  String get commentReactionPickerTitle => 'اختر تفاعلك';

  @override
  String get progressCardNextLevel => 'المستوى التالي';

  @override
  String get progressCardMaxLevel => 'تهانينا! وصلت للمستوى الأقصى 🎉';

  @override
  String get progressCardEmptyTitle => 'ابدأ رحلتك التعليمية!';

  @override
  String get progressCardEmptyHint => 'أكمل الدروس والاختبارات لكسب النقاط';

  @override
  String get progressCardError => 'حدث خطأ في تحميل التقدم';

  @override
  String get messageListEmpty => 'لا توجد رسائل بعد';

  @override
  String get messageListEmptyHint => 'ابدأ المحادثة بإرسال رسالة';

  @override
  String messageBubbleYesterday(Object time) {
    return 'أمس $time';
  }

  @override
  String get chatInputPlaceholder => 'اكتب رسالة...';

  @override
  String get messageBubbleEdited => '(معدلة)';

  @override
  String messageSearchError(Object error) {
    return 'خطأ في البحث: $error';
  }

  @override
  String get messageSearchPlaceholderRoom => 'ابحث في هذه المحادثة...';

  @override
  String get messageSearchPlaceholderAll => 'ابحث في جميع الرسائل...';

  @override
  String get messageSearchTitle => 'ابحث في الرسائل';

  @override
  String get messageSearchNoResults => 'لا توجد نتائج';

  @override
  String get messageSearchNoResultsHint => 'جرب كلمات بحث مختلفة';

  @override
  String messageSearchResultsCount(Object count) {
    return 'عدد النتائج: $count';
  }

  @override
  String get messageSearchEdited => 'معدلة';

  @override
  String get messageSearchDefaultRoom => 'محادثة';

  @override
  String get messageSearchTooltip => 'بحث';

  @override
  String get messageThreadTitle => 'الردود';

  @override
  String get messageThreadParentNotFound => 'لم يتم العثور على الرسالة الأصلية';

  @override
  String get messageThreadUserNotFound => 'لم يتم العثور على بيانات المستخدم';

  @override
  String get messageThreadSendFailed => 'فشل إرسال الرد';

  @override
  String get messageThreadNoReplies => 'لا توجد ردود بعد';

  @override
  String messageThreadError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get messageThreadReplyPlaceholder => 'اكتب ردك...';

  @override
  String get messageThreadReplySingular => 'رد';

  @override
  String get messageThreadReplyPlural => 'ردود';

  @override
  String messageThreadLastReply(Object author) {
    return 'آخر رد: $author';
  }

  @override
  String get userPickerError => 'حدث خطأ في إنشاء المحادثة';

  @override
  String get userPickerLoginRequired => 'يرجى تسجيل الدخول';

  @override
  String get userPickerLoadError => 'لا يمكن تحميل بيانات المستخدم';

  @override
  String get userPickerTitle => 'اختر مستخدم للمحادثة';

  @override
  String get userPickerSearchHint => 'ابحث عن مستخدم...';

  @override
  String get userPickerNoResults => 'لا توجد نتائج';

  @override
  String get userPickerNoUsers => 'لا يوجد مستخدمون';

  @override
  String get userPickerNoResultsHint => 'جرب كلمات بحث مختلفة';

  @override
  String get userPickerNoUsersHint => 'لا يوجد مستخدمون آخرون في مؤسستك';

  @override
  String userPickerErrorWithDetails(Object error) {
    return 'حدث خطأ: $error';
  }

  @override
  String get userPickerRetry => 'إعادة المحاولة';

  @override
  String get userPickerRoleManager => 'مدير';

  @override
  String get userPickerRoleTrainer => 'مدرب';

  @override
  String get userPickerRoleTrainee => 'متدرب';

  @override
  String quizSubmissionsTitle(Object quizTitle) {
    return 'تسليمات: $quizTitle';
  }

  @override
  String personalProfileUploadFailed(Object error) {
    return 'فشل رفع الصورة: $error';
  }

  @override
  String get personalProfileSaved => 'تم الحفظ';

  @override
  String personalProfileSaveFailed(Object error) {
    return 'فشل الحفظ: $error';
  }

  @override
  String get settingsArabicLabel => 'العربية';

  @override
  String privacyPolicyLoadFailed(Object error) {
    return 'فشل تحميل سياسة الخصوصية: $error';
  }

  @override
  String termsOfServiceLoadFailed(Object error) {
    return 'فشل تحميل شروط الاستخدام: $error';
  }

  @override
  String get traineeListTitle => 'المتدربون';

  @override
  String get traineeListEmpty => 'لا يوجد متدربون في هذا الكورس بعد.';

  @override
  String resourceLibraryUploadFailed(Object error) {
    return 'فشل رفع الملف: $error';
  }

  @override
  String get resourceLibraryDefaultCourseName => 'كورس';

  @override
  String resourceLibraryNotificationTitle(Object courseName) {
    return 'ملف جديد في: $courseName';
  }

  @override
  String resourceLibraryNotificationContent(Object fileName) {
    return 'تمت إضافة ملف جديد بعنوان: $fileName';
  }

  @override
  String resourceLibraryCannotOpen(Object fileUrl) {
    return 'لا يمكن فتح هذا الملف: $fileUrl';
  }

  @override
  String get resourceLibraryTitle => 'مكتبة الموارد';

  @override
  String resourceLibraryError(Object error) {
    return 'حدث خطأ. تأكد من إنشاء الفهرس المطلوب.\\n\\n$error';
  }

  @override
  String get resourceLibraryEmpty => 'لا توجد ملفات في المكتبة بعد.';

  @override
  String get resourceLibraryUploading => 'جار الرفع...';

  @override
  String get resourceLibraryUploadButton => 'رفع ملف';

  @override
  String get quizListTitle => 'الاختبارات';

  @override
  String quizListError(Object error) {
    return 'حدث خطأ. تأكد من إنشاء الفهرس المطلوب.\\n\\n$error';
  }

  @override
  String get quizListEmpty => 'لم يتم إنشاء أي اختبارات بعد.';

  @override
  String get quizListViewSubmissions => 'عرض التسليمات';

  @override
  String get quizListCreateButton => 'إنشاء اختبار';

  @override
  String quizSubmissionsError(Object error) {
    return 'حدث خطأ. تأكد من إنشاء الفهرس المطلوب.\\n\\n$error';
  }

  @override
  String get quizSubmissionsEmpty => 'لم يقم أي متدرب بتسليم هذا الاختبار بعد.';

  @override
  String quizSubmissionsResultFormat(Object score, Object total, Object date) {
    return 'النتيجة: $score من $total\\nتم التسليم في: $date';
  }

  @override
  String get traineeListLoading => 'جار التحميل...';

  @override
  String traineeListNotFound(Object traineeId) {
    return 'متدرب غير موجود: $traineeId';
  }

  @override
  String get traineeListUnknownEmail => 'بريد غير معروف';

  @override
  String get personalProfileSectionData => 'البيانات';

  @override
  String get personalProfileNameLabel => 'الاسم';

  @override
  String get personalProfileNameRequired => 'الاسم مطلوب';

  @override
  String get personalProfileEmailLabel => 'البريد الإلكتروني';

  @override
  String get personalProfileStatsTitle => 'الإحصائيات';

  @override
  String get personalProfileAchievementsTitle => 'الإنجازات';

  @override
  String get personalProfileRecentActivityTitle => 'النشاط الأخير';

  @override
  String get personalProfileTrainerStatsTitle => 'إحصائيات التدريب';

  @override
  String get personalProfileSaveButton => 'حفظ التعديلات';

  @override
  String get personalProfileRoleTrainee => 'متدرب';

  @override
  String get personalProfileRoleTrainer => 'مدرب';

  @override
  String personalProfilePointsLabelShort(Object points) {
    return 'نقاط: $points';
  }

  @override
  String personalProfileAuthError(Object error) {
    return 'خطأ بالمصادقة: $error';
  }

  @override
  String get personalProfileLoginRequired => 'يرجى تسجيل الدخول';

  @override
  String get personalProfileTitle => 'الملف الشخصي';

  @override
  String personalProfileDataLoadError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get personalProfileActivitiesLabel => 'الأنشطة';

  @override
  String get personalProfileEvaluationsLabel => 'تقييمات';

  @override
  String get personalProfileEvaluationsGivenLabel => 'تقييمات قمت بها';

  @override
  String get personalProfileSinceLabel => 'منذ';

  @override
  String get personalProfilePointsLabel => 'نقاط';

  @override
  String get personalProfileNoBadges => 'لا توجد شارات بعد';

  @override
  String personalProfileActivityLoadError(Object error) {
    return 'خطأ تحميل النشاط: $error';
  }

  @override
  String get personalProfileNoRecentActivity => 'لا يوجد نشاط حديث بعد';

  @override
  String personalProfilePointsCountFormat(Object points) {
    return '$points نقطة';
  }

  @override
  String get personalProfileEventTestPassed => 'اجتياز اختبار';

  @override
  String get personalProfileEventTaskCompleted => 'إكمال مهمة';

  @override
  String get personalProfileEventLessonCompleted => 'إنهاء درس';

  @override
  String get personalProfileEventDailyStreak => 'سلسلة يومية';

  @override
  String get personalProfileEventDefault => 'حدث نقاط';

  @override
  String get trainerStatsCoursesLabel => 'الدورات';

  @override
  String get trainerStatsEvaluationsLabel => 'التقييمات';

  @override
  String get achievementsTitle => 'الإنجازات';

  @override
  String get achievementsMustLogin => 'يجب تسجيل الدخول أولاً';

  @override
  String get achievementsFilterByCategory => 'تصفية حسب الفئة';

  @override
  String get achievementsAll => 'الكل';

  @override
  String get achievementsSecretAchievement => 'إنجاز سري';

  @override
  String achievementsPoints(Object points) {
    return '$points نقطة';
  }

  @override
  String get achievementsUnlocked => 'مفتوح ✓';

  @override
  String get achievementsLocked => 'مقفل 🔒';

  @override
  String achievementsUnlockedOn(Object date) {
    return 'تم الفتح: $date';
  }

  @override
  String get achievementsThisIsSecret => 'هذا إنجاز سري! 🤫';

  @override
  String get achievementsWillDiscoverWhenUnlock => 'ستكتشفه عندما تفتحه';

  @override
  String get achievementsClose => 'إغلاق';

  @override
  String get achievementsNoAchievementsYet => 'لا توجد إنجازات بعد';

  @override
  String get achievementsLoadError => 'حدث خطأ في تحميل الإنجازات';

  @override
  String get achievementsRetry => 'إعادة المحاولة';

  @override
  String get achievementsStatUnlocked => 'مفتوحة';

  @override
  String get achievementsStatPercentage => 'النسبة';

  @override
  String get achievementsStatRemaining => 'متبقية';

  @override
  String get achievementsSecretLocked => 'إنجاز سري 🔒';

  @override
  String get analyticsTitle => 'التحليلات';

  @override
  String get analyticsOverview => 'نظرة عامة';

  @override
  String get analyticsTotalStudents => 'إجمالي الطلاب';

  @override
  String get analyticsActiveStudents => 'النشطون';

  @override
  String get analyticsAvgPoints => 'متوسط النقاط';

  @override
  String get analyticsAvgLevel => 'متوسط المستوى';

  @override
  String get analyticsEngagementRate => 'معدل التفاعل';

  @override
  String analyticsEngagementPercent(Object percent) {
    return '$percent% من الطلاب نشطون';
  }

  @override
  String analyticsActiveOf(Object active, Object total) {
    return 'النشطون: $active من $total';
  }

  @override
  String get analyticsTopStudents => 'أفضل الطلاب';

  @override
  String get analyticsNoStudents => 'لا يوجد طلاب بعد';

  @override
  String analyticsLevel(Object level) {
    return 'المستوى $level';
  }

  @override
  String get analyticsPointsLabel => 'نقطة';

  @override
  String get analyticsPointsStats => 'إحصائيات النقاط';

  @override
  String get analyticsPointsAwarded => 'نقطة ممنوحة';

  @override
  String get analyticsAchievementsUnlocked => 'إنجاز مفتوح';

  @override
  String get analyticsLoadError => 'حدث خطأ في تحميل التحليلات';

  @override
  String get analyticsRetry => 'إعادة المحاولة';

  @override
  String get gamificationSettingsTitle => 'إعدادات النقاط';

  @override
  String get gamificationSettingsSave => 'حفظ';

  @override
  String get gamificationSettingsLoadError => 'حدث خطأ في تحميل الإعدادات';

  @override
  String get gamificationSettingsUnauthorized => 'غير مصرح';

  @override
  String get gamificationSettingsSaveSuccess => '✅ تم حفظ الإعدادات بنجاح';

  @override
  String gamificationSettingsSaveError(Object error) {
    return 'حدث خطأ في حفظ الإعدادات: $error';
  }

  @override
  String get gamificationSettingsEnableSystem => 'تفعيل نظام النقاط';

  @override
  String get gamificationSettingsDisableNote =>
      'إذا تم التعطيل، لن يتم منح أي نقاط';

  @override
  String get gamificationSettingsCoreActivities => 'الأنشطة الأساسية (إجبارية)';

  @override
  String get gamificationSettingsCoreNote => 'هذه الأنشطة دائماً مفعلة';

  @override
  String get gamificationSettingsCompleteLesson => 'إتمام درس';

  @override
  String get gamificationSettingsPassQuiz => 'اجتياز اختبار';

  @override
  String get gamificationSettingsPerfectQuiz => 'درجة كاملة في اختبار';

  @override
  String get gamificationSettingsCompleteTask => 'إتمام مهمة';

  @override
  String get gamificationSettingsCompleteModule => 'إتمام وحدة كاملة';

  @override
  String get gamificationSettingsEnableSocial => 'تفعيل نقاط التفاعل الاجتماعي';

  @override
  String get gamificationSettingsSocialNote => 'المنشورات والتعليقات';

  @override
  String get gamificationSettingsCreatePost => 'إنشاء منشور';

  @override
  String get gamificationSettingsWriteComment => 'كتابة تعليق';

  @override
  String get gamificationSettingsHelpPeer => 'مساعدة زميل';

  @override
  String get gamificationSettingsGetReaction => 'الحصول على reaction';

  @override
  String get gamificationSettingsEnableStreak => 'تفعيل سلسلة الدخول اليومي';

  @override
  String get gamificationSettingsStreakNote => 'تشجيع الدخول المتواصل';

  @override
  String get gamificationSettingsDailyLogin => 'الدخول اليومي';

  @override
  String get gamificationSettingsWeekStreak => 'أسبوع متواصل';

  @override
  String get gamificationSettingsSaveButton => 'حفظ الإعدادات';

  @override
  String get gamificationSettingsResetDefaults => 'إعادة القيم الافتراضية';

  @override
  String get gamificationSettingsResetSuccess => 'تم إعادة القيم الافتراضية';

  @override
  String gamificationSettingsPointsLabel(Object points) {
    return '$points نقطة';
  }

  @override
  String get moduleDetailTitle => 'تفاصيل الوحدة';

  @override
  String moduleDetailError(Object error) {
    return 'حدث خطأ: $error';
  }

  @override
  String get moduleDetailRetry => 'إعادة المحاولة';

  @override
  String moduleDetailProgressError(Object error) {
    return 'خطأ في تحميل التقدم: $error';
  }

  @override
  String get moduleDetailDescription => 'الوصف';

  @override
  String get moduleDetailContents => 'محتويات الوحدة';

  @override
  String moduleDetailCompleteForPoints(Object points) {
    return 'أكمل جميع المحتويات للحصول على $points نقطة';
  }

  @override
  String get moduleDetailModuleCompleted => 'تم إكمال الوحدة! 🎉';

  @override
  String moduleDetailEarnedPoints(Object points) {
    return 'حصلت على $points نقطة';
  }

  @override
  String get moduleDetailCompleted => 'مكتملة';

  @override
  String get moduleDetailProgress => 'التقدم';

  @override
  String moduleDetailPointsOnCompletion(Object points) {
    return '$points نقطة عند الإكمال';
  }

  @override
  String get moduleDetailUnmarkedComplete =>
      'تم إلغاء وضع علامة على المحتوى كمكتمل';

  @override
  String get moduleDetailMarkedComplete => 'تم وضع علامة على المحتوى كمكتمل ✓';

  @override
  String moduleDetailMarkError(Object error) {
    return 'حدث خطأ: $error';
  }

  @override
  String get moduleDetailRequired => 'مطلوب';

  @override
  String get moduleDetailTypeLesson => 'درس';

  @override
  String get moduleDetailTypeQuiz => 'اختبار';

  @override
  String get moduleDetailTypeAssignment => 'واجب';

  @override
  String get moduleDetailTypeResource => 'مصدر';

  @override
  String get anomalyDashboardTitle => 'الكشف عن الشذوذ';

  @override
  String get anomalyDashboardMustLogin => 'يجب تسجيل الدخول';

  @override
  String get anomalyDashboardFilterStatus => 'فلترة حسب الحالة';

  @override
  String get anomalyDashboardAllStates => 'جميع الحالات';

  @override
  String get anomalyDashboardPending => 'قيد الانتظار';

  @override
  String get anomalyDashboardInvestigating => 'قيد التحقيق';

  @override
  String get anomalyDashboardResolved => 'تم الحل';

  @override
  String get anomalyDashboardTabAll => 'الكل';

  @override
  String get anomalyDashboardTabHigh => 'عالي';

  @override
  String get anomalyDashboardTabAlerts => 'التنبيهات';

  @override
  String get anomalyDashboardNoAnomalies => 'لا توجد شذوذات مكتشفة';

  @override
  String get anomalyDashboardSystemNormal => 'النظام يعمل بشكل طبيعي';

  @override
  String anomalyDashboardError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get anomalyDashboardNoHighRisk => 'لا توجد شذوذات عالية الخطورة';

  @override
  String get anomalyDashboardNoAlerts => 'لا توجد تنبيهات';

  @override
  String get anomalyDashboardReviewSuccess => 'تمت المراجعة بنجاح';

  @override
  String get anomalyDashboardReviewFailed => 'فشلت المراجعة';

  @override
  String get anomalyDashboardReviewButton => 'مراجعة';

  @override
  String get anomalyDashboardType => 'النوع';

  @override
  String get anomalyDashboardSeverity => 'الخطورة';

  @override
  String get anomalyDashboardStatus => 'الحالة';

  @override
  String get anomalyDashboardUser => 'المستخدم';

  @override
  String get anomalyDashboardDetectedAt => 'وقت الاكتشاف';

  @override
  String get anomalyDashboardDescription => 'الوصف';

  @override
  String get anomalyDashboardActions => 'الإجراءات';

  @override
  String get anomalyDashboardMarkResolved => 'وضع علامة كمحلول';

  @override
  String get anomalyDashboardInvestigate => 'تحقيق';

  @override
  String get myEvaluationsTitle => 'التقييمات الخاصة بي';

  @override
  String get myEvaluationsToggleView => 'تبديل المظهر';

  @override
  String get myEvaluationsMustLogin => 'يجب تسجيل الدخول أولاً';

  @override
  String get myEvaluationsNoEvaluations => 'لم يتم إضافة أي تقييمات لك بعد.';

  @override
  String myEvaluationsError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String myEvaluationsAuthError(Object error) {
    return 'خطأ بالمصادقة: $error';
  }

  @override
  String get myEvaluationsAudioUnavailable =>
      'تعذر تشغيل التقييم الصوتي (رابط غير متاح حالياً)';

  @override
  String get myEvaluationsAudioAccessError =>
      'تعذر الوصول لملف الصوت. تحقق من الاتصال.';

  @override
  String myEvaluationsAudioPlayError(Object error) {
    return 'فشل تشغيل الصوت: $error';
  }

  @override
  String get anomalySettingsTitle => 'إعدادات الكشف عن الشذوذ';

  @override
  String get anomalySettingsSaveSuccess => 'تم حفظ الإعدادات بنجاح';

  @override
  String get anomalySettingsSaveFailed => 'فشل حفظ الإعدادات';

  @override
  String anomalySettingsSaveError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get anomalySettingsEnableDetection => 'تفعيل الكشف عن الشذوذ';

  @override
  String get anomalySettingsEnableDetectionSubtitle =>
      'اكتشاف السلوك غير الطبيعي تلقائياً';

  @override
  String get anomalySettingsEnabledTypes => 'أنواع الشذوذ المُفعّلة';

  @override
  String get anomalySettingsSuspiciousLogin => 'تسجيل دخول مشبوه';

  @override
  String get anomalySettingsSuspiciousLoginDesc => 'أجهزة أو مواقع غير معتادة';

  @override
  String get anomalySettingsAbnormalScores => 'درجات اختبار غير طبيعية';

  @override
  String get anomalySettingsAbnormalScoresDesc =>
      'درجات عالية جداً أو منخفضة جداً';

  @override
  String get anomalySettingsRapidProgress => 'تقدم سريع';

  @override
  String get anomalySettingsRapidProgressDesc =>
      'إكمال دورات أو اختبارات بسرعة غير طبيعية';

  @override
  String get anomalySettingsMultipleDevices => 'أجهزة متعددة';

  @override
  String get anomalySettingsMultipleDevicesDesc =>
      'استخدام عدة أجهزة في وقت قصير';

  @override
  String get anomalySettingsUnusualActivity => 'نشاط غير معتاد';

  @override
  String get anomalySettingsUnusualActivityDesc => 'نشاط مفرط أو غير نمطي';

  @override
  String get anomalySettingsCheatingPattern => 'نمط غش';

  @override
  String get anomalySettingsCheatingPatternDesc => 'أنماط تشير إلى محاولة غش';

  @override
  String get anomalySettingsAccountSharing => 'مشاركة حساب';

  @override
  String get anomalySettingsAccountSharingDesc =>
      'استخدام الحساب من قبل أشخاص مختلفين';

  @override
  String get anomalySettingsSensitivity => 'الحساسية';

  @override
  String get anomalySettingsSensitivityLow => 'منخفضة';

  @override
  String get anomalySettingsSensitivityHigh => 'عالية';

  @override
  String anomalySettingsSensitivityCurrent(Object percent) {
    return 'الحساسية الحالية: $percent%';
  }

  @override
  String get anomalySettingsAlerts => 'التنبيهات';

  @override
  String get anomalySettingsSendAlerts => 'إرسال تنبيهات';

  @override
  String get anomalySettingsSendAlertsSubtitle =>
      'إخطار المسؤولين عند اكتشاف شذوذ';

  @override
  String get anomalySettingsMinimumSeverity => 'الحد الأدنى للتنبيه';

  @override
  String get anomalySettingsSeverityLow => 'منخفض';

  @override
  String get anomalySettingsSeverityMedium => 'متوسط';

  @override
  String get anomalySettingsSeverityHigh => 'عالي';

  @override
  String get anomalySettingsSeverityCritical => 'حرج';

  @override
  String get anomalySettingsAutomatedActions => 'الإجراءات التلقائية';

  @override
  String get anomalySettingsSuspendCritical => 'تعليق الحسابات الحرجة';

  @override
  String get anomalySettingsSuspendCriticalSubtitle =>
      'تعليق تلقائي للحسابات ذات الشذوذ الحرج';

  @override
  String get anomalySettingsFlagCheating => 'وضع علامة على الغش';

  @override
  String get anomalySettingsFlagCheatingSubtitle =>
      'وضع علامة تلقائية على محاولات الغش';

  @override
  String get anomalySettingsImportantNotes => 'ملاحظات مهمة';

  @override
  String get anomalySettingsNote1 =>
      '• الكشف يعمل باستخدام خوارزميات إحصائية متقدمة';

  @override
  String get anomalySettingsNote2 =>
      '• قد تحدث إيجابيات خاطئة - راجع دائماً قبل اتخاذ إجراء';

  @override
  String get anomalySettingsNote3 =>
      '• يتحسن الكشف مع مرور الوقت وتجميع البيانات';

  @override
  String get anomalySettingsNote4 =>
      '• الحساسية العالية = المزيد من الاكتشافات (بما في ذلك الخاطئة)';

  @override
  String get anomalySettingsNote5 => '• يوصى بمراجعة دورية للإعدادات والنتائج';

  @override
  String get moderationQueueTitle => 'قائمة الإشراف';

  @override
  String moderationQueueError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get moderationQueueNoPending => 'لا توجد تقارير قيد المراجعة';

  @override
  String moderationQueueLoadError(Object error) {
    return 'خطأ في تحميل التقارير: $error';
  }

  @override
  String get moderationQueuePending => 'قيد المراجعة';

  @override
  String get moderationQueueResolved => 'تم الحل';

  @override
  String get moderationQueueDismissed => 'مرفوض';

  @override
  String get moderationQueueTotal => 'الإجمالي';

  @override
  String moderationQueueReportedBy(Object name) {
    return 'بلّغ عنه: $name';
  }

  @override
  String get moderationQueueReason => 'السبب';

  @override
  String get moderationQueueDetails => 'التفاصيل';

  @override
  String get moderationQueueContentType => 'نوع المحتوى';

  @override
  String get moderationQueueActionWarn => 'تحذير';

  @override
  String get moderationQueueActionDelete => 'حذف المحتوى';

  @override
  String get moderationQueueActionMute => 'كتم';

  @override
  String get moderationQueueActionBan => 'حظر';

  @override
  String get moderationQueueActionDismiss => 'رفض البلاغ';

  @override
  String get moderationQueueStatusPending => 'قيد المراجعة';

  @override
  String get moderationQueueStatusInvestigating => 'جاري التحقيق';

  @override
  String get moderationQueueStatusActionTaken => 'تم اتخاذ إجراء';

  @override
  String get moderationQueueStatusDismissed => 'مرفوض';

  @override
  String get moderationQueueStatusResolved => 'تم الحل';

  @override
  String moderationQueueConfirmTitle(Object action) {
    return 'تأكيد الإجراء: $action';
  }

  @override
  String moderationQueueConfirmMessage(Object action) {
    return 'هل أنت متأكد من $action؟';
  }

  @override
  String get moderationQueueCancel => 'إلغاء';

  @override
  String get moderationQueueConfirm => 'تأكيد';

  @override
  String moderationQueueActionCompleted(Object action) {
    return 'تم $action';
  }

  @override
  String get moderationQueueActionSuccess => 'تم تنفيذ الإجراء بنجاح';

  @override
  String get moderationQueueActionFailed => 'فشل تنفيذ الإجراء';

  @override
  String get moderationQueueReasonInappropriate => 'محتوى غير لائق';

  @override
  String get moderationQueueReasonHarassment => 'تحرش';

  @override
  String get moderationQueueReasonSpam => 'بريد مزعج';

  @override
  String get moderationQueueReasonMisinformation => 'معلومات مضللة';

  @override
  String get moderationQueueReasonHarmful => 'محتوى ضار';

  @override
  String get moderationQueueReasonCopyright => 'انتهاك حقوق النشر';

  @override
  String get moderationQueueReasonOther => 'أخرى';

  @override
  String get createBadgeTitle => 'إنشاء شارة جديدة';

  @override
  String get createBadgeSuccess => 'تم إنشاء الشارة';

  @override
  String createBadgeError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get createBadgeIdLabel => 'المعرف (فريد)';

  @override
  String get createBadgeIdRequired => 'مطلوب';

  @override
  String get createBadgeNameLabel => 'الاسم';

  @override
  String get createBadgeNameRequired => 'مطلوب';

  @override
  String get createBadgeDescLabel => 'الوصف';

  @override
  String get createBadgeIconLabel => 'رابط الأيقونة (اختياري)';

  @override
  String get createBadgeIsActive => 'مفعلة';

  @override
  String get createBadgeAutoAward => 'منح تلقائي';

  @override
  String get createBadgeCriteria => 'المعايير (اختيارية)';

  @override
  String get createBadgePointsMin => 'نقاط ≥';

  @override
  String get createBadgeStreakMin => 'سلسلة أيام ≥';

  @override
  String get createBadgeQuizzesMin => 'اختبارات مجتازة ≥';

  @override
  String get createBadgeTasksMin => 'مهام منجزة ≥';

  @override
  String get createBadgeLessonsMin => 'دروس مكتملة ≥';

  @override
  String get createBadgeReviewsMin => 'مراجعات مكتوبة ≥';

  @override
  String get createBadgeSaveButton => 'حفظ';

  @override
  String get hrisImportTitle => 'استيراد المستخدمين';

  @override
  String get hrisImportChooseFile => 'اختر ملف CSV أو Excel';

  @override
  String get hrisImportSelectFile => 'اختيار ملف';

  @override
  String get hrisImportLoadTemplate => 'تحميل قالب محفوظ';

  @override
  String get hrisImportUnsupportedFile => 'نوع الملف غير مدعوم';

  @override
  String get hrisImportEmptyFile => 'الملف فارغ أو يحتوي على صف واحد فقط';

  @override
  String hrisImportError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get hrisImportMapColumns => 'تعيين الأعمدة';

  @override
  String get hrisImportEmailRequired => 'البريد الإلكتروني *';

  @override
  String get hrisImportNameRequired => 'الاسم *';

  @override
  String get hrisImportRoleOptional => 'الدور (اختياري)';

  @override
  String get hrisImportPhoneOptional => 'الهاتف (اختياري)';

  @override
  String get hrisImportDepartmentOptional => 'القسم (اختياري)';

  @override
  String get hrisImportJobTitleOptional => 'المسمى الوظيفي (اختياري)';

  @override
  String get hrisImportSaveAsTemplate => 'حفظ كقالب';

  @override
  String get hrisImportTemplateName => 'اسم القالب';

  @override
  String get hrisImportPreviewButton => 'معاينة';

  @override
  String get hrisImportBackButton => 'رجوع';

  @override
  String get hrisImportNone => '-- لا شيء --';

  @override
  String get hrisImportPreviewTitle => 'معاينة الاستيراد';

  @override
  String get hrisImportTotal => 'إجمالي';

  @override
  String get hrisImportValid => 'صحيح';

  @override
  String get hrisImportInvalid => 'خطأ';

  @override
  String get hrisImportUpdateExisting => 'تحديث المستخدمين الموجودين';

  @override
  String get hrisImportSampleRecords => 'عينة من السجلات:';

  @override
  String get hrisImportStartButton => 'بدء الاستيراد';

  @override
  String get hrisImportSuccess => 'تم الاستيراد بنجاح';

  @override
  String get hrisImportNoTemplates => 'لا توجد قوالب محفوظة';

  @override
  String get hrisImportChooseTemplate => 'اختر قالب';

  @override
  String get hrisImportCancel => 'إلغاء';

  @override
  String get importHistoryTitle => 'سجل الاستيرادات';

  @override
  String get importHistoryAuthRequired => 'يجب تسجيل الدخول';

  @override
  String importHistoryError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get importHistoryEmpty => 'لا توجد عمليات استيراد';

  @override
  String get importHistoryNewImport => 'استيراد جديد';

  @override
  String get importHistoryStatus => 'الحالة';

  @override
  String get importHistoryTotalRows => 'إجمالي الصفوف';

  @override
  String get importHistoryProcessed => 'تم معالجتها';

  @override
  String get importHistorySuccessful => 'نجحت';

  @override
  String get importHistoryFailed => 'فشلت';

  @override
  String get importHistoryUploader => 'المستخدم';

  @override
  String get importHistoryDate => 'التاريخ';

  @override
  String get importHistoryCompletedAt => 'اكتملت في';

  @override
  String get importHistoryErrors => 'الأخطاء:';

  @override
  String get importHistoryStatusPending => 'قيد الانتظار';

  @override
  String get importHistoryStatusProcessing => 'جاري المعالجة';

  @override
  String get importHistoryStatusCompleted => 'مكتمل';

  @override
  String get importHistoryStatusFailed => 'فشل';

  @override
  String get importHistoryStatusPartial => 'نجاح جزئي';

  @override
  String get bigqueryExportTitle => 'تصدير BigQuery';

  @override
  String get bigqueryExportAuthRequired => 'يجب تسجيل الدخول';

  @override
  String get bigqueryExportNotConfigured => 'يجب إعداد BigQuery أولاً';

  @override
  String get bigqueryExportNotEnabled => 'BigQuery غير مُفعّل';

  @override
  String get bigqueryExportStarted => 'بدأ التصدير بنجاح';

  @override
  String bigqueryExportError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get bigqueryExportNewExport => 'تصدير جديد';

  @override
  String get bigqueryExportDataType => 'نوع البيانات';

  @override
  String get bigqueryExportUsers => 'المستخدمين';

  @override
  String get bigqueryExportCourses => 'الدورات';

  @override
  String get bigqueryExportEnrollments => 'التسجيلات';

  @override
  String get bigqueryExportQuizResults => 'نتائج الاختبارات';

  @override
  String get bigqueryExportCertificates => 'الشهادات';

  @override
  String get bigqueryExportPointsAchievements => 'النقاط والإنجازات';

  @override
  String get bigqueryExportAll => 'جميع البيانات';

  @override
  String get bigqueryExportExporting => 'جاري التصدير...';

  @override
  String get bigqueryExportStart => 'بدء التصدير';

  @override
  String get bigqueryExportHistory => 'سجل التصديرات';

  @override
  String get bigqueryExportRefresh => 'تحديث';

  @override
  String get bigqueryExportNoExports => 'لا توجد عمليات تصدير';

  @override
  String get bigqueryExportDetailStatus => 'الحالة';

  @override
  String get bigqueryExportDetailType => 'نوع التصدير';

  @override
  String get bigqueryExportDetailTotal => 'إجمالي السجلات';

  @override
  String get bigqueryExportDetailExported => 'تم تصديره';

  @override
  String get bigqueryExportDetailFailed => 'فشل';

  @override
  String get bigqueryExportDetailUser => 'المستخدم';

  @override
  String get bigqueryExportDetailStarted => 'بدأ في';

  @override
  String get bigqueryExportDetailCompleted => 'اكتمل في';

  @override
  String get bigqueryExportDetailErrors => 'الأخطاء:';

  @override
  String get bigqueryExportAnalytics => 'التحليلات';

  @override
  String get bigqueryExportProgress => 'التقدم';

  @override
  String get bigqueryExportStatusPending => 'قيد الانتظار';

  @override
  String get bigqueryExportStatusProcessing => 'جاري المعالجة';

  @override
  String get bigqueryExportStatusUploading => 'جاري الرفع';

  @override
  String get bigqueryExportStatusCompleted => 'مكتمل';

  @override
  String get bigqueryExportStatusFailed => 'فشل';

  @override
  String get bigquerySettingsTitle => 'إعدادات BigQuery';

  @override
  String get bigquerySettingsSaved => 'تم حفظ الإعدادات بنجاح';

  @override
  String get bigquerySettingsSaveFailed => 'فشل حفظ الإعدادات';

  @override
  String bigquerySettingsError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get bigquerySettingsEnableExport => 'تفعيل BigQuery Export';

  @override
  String get bigquerySettingsExportDescription => 'تصدير البيانات إلى BigQuery';

  @override
  String get bigquerySettingsProjectInfo => 'معلومات المشروع';

  @override
  String get bigquerySettingsProjectIdHelper => 'معرّف مشروع Google Cloud';

  @override
  String get bigquerySettingsProjectIdRequired => 'Project ID مطلوب';

  @override
  String get bigquerySettingsDatasetIdHelper =>
      'معرّف مجموعة البيانات في BigQuery';

  @override
  String get bigquerySettingsDatasetIdRequired => 'Dataset ID مطلوب';

  @override
  String get bigquerySettingsServiceAccountHelper =>
      'بيانات Service Account بصيغة JSON';

  @override
  String get bigquerySettingsServiceAccountRequired =>
      'Service Account JSON مطلوب';

  @override
  String get bigquerySettingsInvalidJSON => 'صيغة JSON غير صحيحة';

  @override
  String get bigquerySettingsEnabledDataTypes => 'أنواع البيانات المُفعّلة';

  @override
  String get bigquerySettingsUsersTitle => 'المستخدمين';

  @override
  String get bigquerySettingsUsersSubtitle => 'بيانات حسابات المستخدمين';

  @override
  String get bigquerySettingsCoursesTitle => 'الدورات';

  @override
  String get bigquerySettingsCoursesSubtitle => 'معلومات الدورات التدريبية';

  @override
  String get bigquerySettingsEnrollmentsTitle => 'التسجيلات';

  @override
  String get bigquerySettingsEnrollmentsSubtitle => 'سجلات التسجيل في الدورات';

  @override
  String get bigquerySettingsQuizResultsTitle => 'نتائج الاختبارات';

  @override
  String get bigquerySettingsQuizResultsSubtitle =>
      'نتائج الاختبارات والتقييمات';

  @override
  String get bigquerySettingsCertificatesTitle => 'الشهادات';

  @override
  String get bigquerySettingsCertificatesSubtitle => 'سجلات إصدار الشهادات';

  @override
  String get bigquerySettingsGamificationTitle => 'النقاط والإنجازات';

  @override
  String get bigquerySettingsGamificationSubtitle => 'بيانات نظام التحفيز';

  @override
  String get bigquerySettingsAnalyticsTitle => 'التحليلات';

  @override
  String get bigquerySettingsAnalyticsSubtitle => 'بيانات تحليل الاستخدام';

  @override
  String get bigquerySettingsProgressTitle => 'التقدم';

  @override
  String get bigquerySettingsProgressSubtitle => 'بيانات التقدم التعليمي';

  @override
  String get bigquerySettingsSchedule => 'جدول التصدير';

  @override
  String get bigquerySettingsScheduleHourly => 'كل ساعة';

  @override
  String get bigquerySettingsScheduleDaily => 'يومياً';

  @override
  String get bigquerySettingsScheduleWeekly => 'أسبوعياً';

  @override
  String get bigquerySettingsScheduleManual => 'يدوي';

  @override
  String get bigquerySettingsSaveButton => 'حفظ الإعدادات';

  @override
  String get bigquerySettingsImportantNotes => 'ملاحظات مهمة';

  @override
  String get bigquerySettingsSetupSteps =>
      '• يجب إنشاء مشروع Google Cloud وتفعيل BigQuery API\n• إنشاء Service Account وتنزيل ملف JSON\n• منح الصلاحيات المناسبة للـ Service Account\n• إنشاء Dataset في BigQuery مسبقاً\n• الجداول سيتم إنشاؤها تلقائياً عند التصدير';

  @override
  String courseDetailsNewPostTitle(Object courseName) {
    return 'منشور جديد في: $courseName';
  }

  @override
  String courseDetailsNewPostContent(Object authorEmail) {
    return 'قام $authorEmail بإضافة منشور جديد.';
  }

  @override
  String courseDetailsError(Object error) {
    return 'حدث خطأ: $error';
  }

  @override
  String get courseDetailsMoreOptions => 'المزيد من الخيارات';

  @override
  String get courseDetailsBadges => 'الشارات والإنجازات';

  @override
  String get courseDetailsLeaderboard => 'لوحة المتصدرين';

  @override
  String get courseDetailsAchievements => 'الإنجازات';

  @override
  String get courseDetailsModules => 'الوحدات التعليمية';

  @override
  String get courseDetailsQuizzes => 'الاختبارات';

  @override
  String get courseDetailsResources => 'مكتبة الموارد';

  @override
  String get courseDetailsTrainees => 'المتدربين';

  @override
  String get courseDetailsAnalytics => 'تحليلات الكورس';

  @override
  String get courseDetailsPointsSettings => 'إعدادات النقاط';

  @override
  String get courseDetailsMyEvaluations => 'تقييماتي';

  @override
  String get courseDetailsInfoTitle => 'معلومات الكورس';

  @override
  String get courseDetailsInfoContent => 'تفاصيل الكورس الكاملة';

  @override
  String get courseDetailsClose => 'إغلاق';

  @override
  String get courseDetailsNoPosts => 'لا توجد منشورات';

  @override
  String get courseDetailsChangeFilters => 'جرّب تغيير إعدادات البحث';

  @override
  String get courseDetailsPlaceholder => 'ماذا تريد أن تشارك؟';

  @override
  String get courseDetailsAddImages => 'إضافة صور';

  @override
  String get courseDetailsCreatePoll => 'إنشاء استطلاع';

  @override
  String get courseDetailsTrainerFallback => 'المدرب';

  @override
  String get courseDetailsAuthRequired => 'يجب تسجيل الدخول أولاً';

  @override
  String get modulesEmptyTitle => 'لا توجد وحدات تعليمية بعد';

  @override
  String get modulesEmptySubtitle => 'سيتم إضافة الوحدات قريباً';

  @override
  String get modulesLoadError => 'حدث خطأ في تحميل الوحدات';

  @override
  String get modulesLockedMessage => 'مقفلة - أكمل الوحدة السابقة';

  @override
  String modulesContentCount(Object count) {
    return '$count محتوى';
  }

  @override
  String modulesProgressFormat(Object completed, Object total) {
    return '$completed/$total مكتمل';
  }

  @override
  String get forgotPasswordSuccess =>
      'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك';

  @override
  String get evaluationLoadError => 'خطأ في تحميل التقييم';

  @override
  String get quizHubCreatingTask => '... جاري إنشاء المهمة';

  @override
  String get quizHubNoAttempts => 'لا توجد محاولات بعد';

  @override
  String quizHubLatestScore(Object score, Object count) {
    return 'أحدث درجة: $score | إجمالي المحاولات: $count';
  }

  @override
  String get unknownUserInitial => '؟';

  @override
  String get emailVerificationSuccess => 'تم التحقق من بريدك بنجاح! 🎉';

  @override
  String get emailVerificationPending =>
      'البريد لم يتم التحقق منه بعد. الرجاء فتح البريد والضغط على رابط التحقق.';

  @override
  String emailVerificationError(Object error) {
    return 'حدث خطأ: $error';
  }

  @override
  String emailVerificationLinkSent(Object email) {
    return 'تم إرسال رابط التحقق إلى $email';
  }

  @override
  String emailVerificationSendError(Object error) {
    return 'خطأ في إرسال البريد: $error';
  }

  @override
  String get emailVerificationLogout => 'تسجيل خروج';

  @override
  String get emailVerificationTitle => 'تحقق من بريدك الإلكتروني';

  @override
  String get emailVerificationSentTo => 'أرسلنا رابط التحقق إلى:';

  @override
  String get emailVerificationInstructions =>
      'الرجاء فتح بريدك الإلكتروني والضغط على رابط التحقق';

  @override
  String get emailVerificationSpamNote =>
      '(تحقق من مجلد Spam إذا لم تجد الرسالة)';

  @override
  String get emailVerificationChecking => 'جاري التحقق...';

  @override
  String get emailVerificationChecked => 'لقد تحققت من البريد';

  @override
  String get emailVerificationResending => 'جاري الإرسال...';

  @override
  String get emailVerificationResend => 'إعادة إرسال البريد';

  @override
  String get emailVerificationWhy =>
      'لماذا نحتاج التحقق؟\nللتأكد من أن البريد الإلكتروني صحيح وتتمكن من استعادة حسابك لاحقاً.';

  @override
  String anomalyError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get anomalyDetailType => 'النوع';

  @override
  String get anomalyDetailSeverity => 'الخطورة';

  @override
  String get anomalyDetailScore => 'الدرجة';

  @override
  String get anomalyDetailConfidence => 'مستوى الثقة';

  @override
  String get anomalyDetailUser => 'المستخدم';

  @override
  String get anomalyDetailStatus => 'الحالة';

  @override
  String get anomalyDetailDetected => 'تم الكشف';

  @override
  String get anomalyDetailEvidence => 'الأدلة:';

  @override
  String get anomalyDetailReview => 'المراجعة:';

  @override
  String get anomalyDetailReviewer => 'المراجع';

  @override
  String get anomalyDetailReviewDate => 'تاريخ المراجعة';

  @override
  String get anomalyDetailNotes => 'الملاحظات';

  @override
  String get anomalyTypeSuspiciousLogin => 'تسجيل دخول مشبوه';

  @override
  String get anomalyTypeAbnormalQuizScore => 'درجة اختبار غير طبيعية';

  @override
  String get anomalyTypeRapidProgress => 'تقدم سريع';

  @override
  String get anomalyTypeMultipleDevices => 'أجهزة متعددة';

  @override
  String get anomalyTypeUnusualActivity => 'نشاط غير معتاد';

  @override
  String get anomalyTypeCheatingPattern => 'نمط غش';

  @override
  String get anomalyTypeAccountSharing => 'مشاركة حساب';

  @override
  String get anomalySeverityLow => 'منخفض';

  @override
  String get anomalySeverityMedium => 'متوسط';

  @override
  String get anomalySeverityHigh => 'عالي';

  @override
  String get anomalySeverityCritical => 'حرج';

  @override
  String get anomalyStatusPending => 'قيد الانتظار';

  @override
  String get anomalyStatusInvestigating => 'قيد التحقيق';

  @override
  String get anomalyStatusResolved => 'تم الحل';

  @override
  String get anomalyStatusFalsePositive => 'إيجابي خاطئ';

  @override
  String get anomalyStatusConfirmed => 'مؤكد';

  @override
  String get anomalyReviewDialogTitle => 'مراجعة الشذوذ';

  @override
  String get anomalyReviewStatusLabel => 'الحالة';

  @override
  String get anomalyReviewNotesLabel => 'ملاحظات (اختياري)';

  @override
  String get manualGradeTitle => 'تصحيح يدوي';

  @override
  String get manualGradeSaveSuccess => 'تم حفظ التصحيح';

  @override
  String manualGradeSaveError(Object error) {
    return 'فشل: $error';
  }

  @override
  String get manualGradeNotFound => 'التسليم غير موجود';

  @override
  String manualGradeTraineeLabel(Object trainee) {
    return 'المتدرب: $trainee';
  }

  @override
  String manualGradeAutoScore(Object score) {
    return 'درجة آلية: $score';
  }

  @override
  String get manualGradeNoAnswer => 'لا توجد إجابة';

  @override
  String get manualGradeQuestionScore => 'درجة السؤال (عدد صحيح)';

  @override
  String get manualGradeSaveButton => 'حفظ التصحيح';

  @override
  String get manualGradingReviewTitle => 'مراجعة إجابات نصية';

  @override
  String get manualGradingNoSubmissions => 'لا توجد تسليمات تحتاج تصحيح يدوي.';

  @override
  String manualGradingAutoScoreLabel(Object auto, Object total) {
    return 'درجة آلية: $auto / $total';
  }
}
