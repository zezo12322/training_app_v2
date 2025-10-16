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
  String get emailVerificationTitle => 'التحقق من البريد الإلكتروني';

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
}
