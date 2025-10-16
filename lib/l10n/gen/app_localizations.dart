import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Training App'**
  String get appTitle;

  /// No description provided for @navDashboardTrainer.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboardTrainer;

  /// No description provided for @navHomeTrainee.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHomeTrainee;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get navProfile;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @actionNewCourse.
  ///
  /// In en, this message translates to:
  /// **'New Course'**
  String get actionNewCourse;

  /// No description provided for @actionJoin.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get actionJoin;

  /// No description provided for @greetingTrainer.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}!'**
  String greetingTrainer(Object name);

  /// No description provided for @greetingTrainerFallback.
  ///
  /// In en, this message translates to:
  /// **'Hello, Trainer!'**
  String get greetingTrainerFallback;

  /// No description provided for @greetingTrainee.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String greetingTrainee(Object name);

  /// No description provided for @greetingTraineeFallback.
  ///
  /// In en, this message translates to:
  /// **'Hello, Trainee!'**
  String get greetingTraineeFallback;

  /// No description provided for @trainerCoursesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your current courses:'**
  String get trainerCoursesSubtitle;

  /// No description provided for @traineeCoursesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your enrolled courses:'**
  String get traineeCoursesSubtitle;

  /// No description provided for @noTrainerCoursesTitle.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t created any courses yet'**
  String get noTrainerCoursesTitle;

  /// No description provided for @noTrainerCoursesHint.
  ///
  /// In en, this message translates to:
  /// **'Press + below to start'**
  String get noTrainerCoursesHint;

  /// No description provided for @noTraineeCoursesTitle.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t joined any courses yet'**
  String get noTraineeCoursesTitle;

  /// No description provided for @noTraineeCoursesHint.
  ///
  /// In en, this message translates to:
  /// **'Press + to join a new course'**
  String get noTraineeCoursesHint;

  /// No description provided for @courseCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Code: {code}'**
  String courseCodeLabel(Object code);

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Guide'**
  String get onboardingTitle;

  /// No description provided for @onboardingPointDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Home / Dashboard'**
  String get onboardingPointDashboardTitle;

  /// No description provided for @onboardingPointDashboardBody.
  ///
  /// In en, this message translates to:
  /// **'View and manage your courses.'**
  String get onboardingPointDashboardBody;

  /// No description provided for @onboardingPointProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get onboardingPointProfileTitle;

  /// No description provided for @onboardingPointProfileBody.
  ///
  /// In en, this message translates to:
  /// **'Update your name, photo and info.'**
  String get onboardingPointProfileBody;

  /// No description provided for @onboardingPointSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get onboardingPointSettingsTitle;

  /// No description provided for @onboardingPointSettingsBody.
  ///
  /// In en, this message translates to:
  /// **'Control theme, animations and playback.'**
  String get onboardingPointSettingsBody;

  /// No description provided for @onboardingRoleNote.
  ///
  /// In en, this message translates to:
  /// **'First tab changes based on your role (trainer/trainee).'**
  String get onboardingRoleNote;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get onboardingStart;

  /// No description provided for @onboardingLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get onboardingLater;

  /// No description provided for @onboardingFullTour.
  ///
  /// In en, this message translates to:
  /// **'Full Tour'**
  String get onboardingFullTour;

  /// No description provided for @tourNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get tourNext;

  /// No description provided for @tourSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get tourSkip;

  /// No description provided for @tourDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get tourDone;

  /// No description provided for @tourDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get tourDashboardTitle;

  /// No description provided for @tourDashboardBody.
  ///
  /// In en, this message translates to:
  /// **'Your starting point. Shows summaries and quick actions.'**
  String get tourDashboardBody;

  /// No description provided for @tourFabTitleTrainer.
  ///
  /// In en, this message translates to:
  /// **'Create Course'**
  String get tourFabTitleTrainer;

  /// No description provided for @tourFabBodyTrainer.
  ///
  /// In en, this message translates to:
  /// **'Tap here any time to add a new course for trainees.'**
  String get tourFabBodyTrainer;

  /// No description provided for @tourFabTitleTrainee.
  ///
  /// In en, this message translates to:
  /// **'Join Course'**
  String get tourFabTitleTrainee;

  /// No description provided for @tourFabBodyTrainee.
  ///
  /// In en, this message translates to:
  /// **'Tap to join a course using a code shared by a trainer.'**
  String get tourFabBodyTrainee;

  /// No description provided for @tourProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tourProfileTitle;

  /// No description provided for @tourProfileBody.
  ///
  /// In en, this message translates to:
  /// **'Edit your name, photo and view stats & achievements.'**
  String get tourProfileBody;

  /// No description provided for @tourSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tourSettingsTitle;

  /// No description provided for @tourSettingsBody.
  ///
  /// In en, this message translates to:
  /// **'Change theme, language and notification preferences.'**
  String get tourSettingsBody;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorGeneric(Object error);

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow push notifications (OneSignal / FCM)'**
  String get notificationsSubtitle;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network issue. Please retry.'**
  String get errorNetwork;

  /// No description provided for @errorAuth.
  ///
  /// In en, this message translates to:
  /// **'Authentication error: {details}'**
  String errorAuth(Object details);

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'Resource not found'**
  String get errorNotFound;

  /// No description provided for @errorNotFoundResource.
  ///
  /// In en, this message translates to:
  /// **'Not found: {resource}'**
  String errorNotFoundResource(Object resource);

  /// No description provided for @errorValidation.
  ///
  /// In en, this message translates to:
  /// **'Some fields are invalid'**
  String get errorValidation;

  /// No description provided for @errorPermission.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have permission'**
  String get errorPermission;

  /// No description provided for @errorRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Try later.'**
  String get errorRateLimited;

  /// No description provided for @errorRateLimitedRetry.
  ///
  /// In en, this message translates to:
  /// **'Please retry after {seconds}s'**
  String errorRateLimitedRetry(Object seconds);

  /// No description provided for @errorStorage.
  ///
  /// In en, this message translates to:
  /// **'Storage error occurred'**
  String get errorStorage;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get errorUnknown;

  /// No description provided for @funAnimationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Fun animations'**
  String get funAnimationsTitle;

  /// No description provided for @funAnimationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable subtle entrance animations'**
  String get funAnimationsSubtitle;

  /// No description provided for @autoplayAudioTitle.
  ///
  /// In en, this message translates to:
  /// **'Autoplay audio'**
  String get autoplayAudioTitle;

  /// No description provided for @autoplayAudioSubtitle.
  ///
  /// In en, this message translates to:
  /// **'When opening a new voice evaluation'**
  String get autoplayAudioSubtitle;

  /// No description provided for @clearCacheTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear cache (pseudo)'**
  String get clearCacheTitle;

  /// No description provided for @clearCacheSubtitle.
  ///
  /// In en, this message translates to:
  /// **'May fix some sync issues'**
  String get clearCacheSubtitle;

  /// No description provided for @confirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmationTitle;

  /// No description provided for @clearCacheConfirm.
  ///
  /// In en, this message translates to:
  /// **'Perform a pseudo clear of local cache?'**
  String get clearCacheConfirm;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @cacheClearedToast.
  ///
  /// In en, this message translates to:
  /// **'Cache cleared (simulated)'**
  String get cacheClearedToast;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// No description provided for @aboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Training beta build'**
  String get aboutSubtitle;

  /// No description provided for @logoutAction.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutAction;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirm;

  /// No description provided for @logoutFailed.
  ///
  /// In en, this message translates to:
  /// **'Logout failed: {error}'**
  String logoutFailed(Object error);

  /// No description provided for @dumpSettingsAction.
  ///
  /// In en, this message translates to:
  /// **'Print settings state to log'**
  String get dumpSettingsAction;

  /// No description provided for @dumpSettingsToast.
  ///
  /// In en, this message translates to:
  /// **'Settings state logged'**
  String get dumpSettingsToast;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @aboutSection.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutSection;

  /// No description provided for @languagePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languagePickerTitle;

  /// No description provided for @systemLocaleLabel.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemLocaleLabel;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @loginWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get loginWelcomeBack;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'At least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get fieldRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @loginAction.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginAction;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @signInWithApple.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get signInWithApple;

  /// No description provided for @ssoLoginFailed.
  ///
  /// In en, this message translates to:
  /// **'SSO login failed: {error}'**
  String ssoLoginFailed(Object error);

  /// No description provided for @signupNavigate.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Create one'**
  String get signupNavigate;

  /// No description provided for @forgotPasswordNavigate.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordNavigate;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send you a link to reset your password'**
  String get forgotPasswordDescription;

  /// No description provided for @sendResetEmail.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetEmail;

  /// No description provided for @passwordResetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email has been sent to your inbox'**
  String get passwordResetEmailSent;

  /// No description provided for @passwordResetFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send reset email'**
  String get passwordResetFailed;

  /// No description provided for @emailSent.
  ///
  /// In en, this message translates to:
  /// **'Email Sent'**
  String get emailSent;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @forgotPasswordNote.
  ///
  /// In en, this message translates to:
  /// **'Make sure to check your inbox and spam folder'**
  String get forgotPasswordNote;

  /// No description provided for @signupTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signupTitle;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullNameLabel;

  /// No description provided for @chooseRole.
  ///
  /// In en, this message translates to:
  /// **'Choose your role:'**
  String get chooseRole;

  /// No description provided for @roleTrainer.
  ///
  /// In en, this message translates to:
  /// **'Trainer'**
  String get roleTrainer;

  /// No description provided for @roleTrainee.
  ///
  /// In en, this message translates to:
  /// **'Trainee'**
  String get roleTrainee;

  /// No description provided for @signupAction.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signupAction;

  /// No description provided for @haveAccountLogin.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Login'**
  String get haveAccountLogin;

  /// No description provided for @selectRoleError.
  ///
  /// In en, this message translates to:
  /// **'Please select a role (trainer or trainee)'**
  String get selectRoleError;

  /// No description provided for @createCourseTitle.
  ///
  /// In en, this message translates to:
  /// **'Create New Course'**
  String get createCourseTitle;

  /// No description provided for @courseNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Course name'**
  String get courseNameLabel;

  /// No description provided for @createCourseAction.
  ///
  /// In en, this message translates to:
  /// **'Create Course'**
  String get createCourseAction;

  /// No description provided for @courseCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Course created successfully!'**
  String get courseCreatedSuccess;

  /// No description provided for @shareCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Share this code with your trainees to join:'**
  String get shareCodeHint;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;

  /// No description provided for @joinCourseTitle.
  ///
  /// In en, this message translates to:
  /// **'Join Course'**
  String get joinCourseTitle;

  /// No description provided for @enterCourseCode.
  ///
  /// In en, this message translates to:
  /// **'Enter course code'**
  String get enterCourseCode;

  /// No description provided for @joinCourseSuccess.
  ///
  /// In en, this message translates to:
  /// **'Joined course successfully!'**
  String get joinCourseSuccess;

  /// No description provided for @enterCourseCodeError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a course code'**
  String get enterCourseCodeError;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed: {error}'**
  String loginFailed(Object error);

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error: {error}'**
  String unexpectedError(Object error);

  /// No description provided for @signupFailed.
  ///
  /// In en, this message translates to:
  /// **'Signup failed: {error}'**
  String signupFailed(Object error);

  /// No description provided for @signupSuccessCheckEmail.
  ///
  /// In en, this message translates to:
  /// **'Account created! Please check your email to verify your account.'**
  String get signupSuccessCheckEmail;

  /// No description provided for @createCourseFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to create course: {error}'**
  String createCourseFailed(Object error);

  /// No description provided for @joinCourseFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to join course: {error}'**
  String joinCourseFailed(Object error);

  /// No description provided for @userNotLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'User not signed in'**
  String get userNotLoggedIn;

  /// No description provided for @threadTitle.
  ///
  /// In en, this message translates to:
  /// **'Discussion'**
  String get threadTitle;

  /// No description provided for @refreshTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refreshTooltip;

  /// No description provided for @noRepliesYet.
  ///
  /// In en, this message translates to:
  /// **'No replies yet'**
  String get noRepliesYet;

  /// No description provided for @newTaskHint.
  ///
  /// In en, this message translates to:
  /// **'New task (Action plan)'**
  String get newTaskHint;

  /// No description provided for @addTaskTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add task'**
  String get addTaskTooltip;

  /// No description provided for @noTasksYet.
  ///
  /// In en, this message translates to:
  /// **'No tasks yet'**
  String get noTasksYet;

  /// No description provided for @autoStopRecording.
  ///
  /// In en, this message translates to:
  /// **'Recording stopped automatically after reaching the time limit.'**
  String get autoStopRecording;

  /// No description provided for @previewPlayError.
  ///
  /// In en, this message translates to:
  /// **'Could not play preview: {error}'**
  String previewPlayError(Object error);

  /// No description provided for @trainerAccountMissing.
  ///
  /// In en, this message translates to:
  /// **'Could not identify trainer account. Please log in again.'**
  String get trainerAccountMissing;

  /// No description provided for @evaluationSendSuccess.
  ///
  /// In en, this message translates to:
  /// **'Evaluation sent successfully!'**
  String get evaluationSendSuccess;

  /// No description provided for @evaluationSendFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed: {message}'**
  String evaluationSendFailure(Object message);

  /// No description provided for @unexpectedErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error: {error}'**
  String unexpectedErrorMsg(Object error);

  /// No description provided for @courseNameFallback.
  ///
  /// In en, this message translates to:
  /// **'One of your courses'**
  String get courseNameFallback;

  /// No description provided for @notificationNewEvaluationTitle.
  ///
  /// In en, this message translates to:
  /// **'You have a new evaluation!'**
  String get notificationNewEvaluationTitle;

  /// No description provided for @notificationNewEvaluationBody.
  ///
  /// In en, this message translates to:
  /// **'Your trainer added a new evaluation for you in course: {courseName}'**
  String notificationNewEvaluationBody(Object courseName);

  /// No description provided for @cancelRecordingTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel recording?'**
  String get cancelRecordingTitle;

  /// No description provided for @cancelRecordingBody.
  ///
  /// In en, this message translates to:
  /// **'You are currently recording. Do you want to stop and lose the current recording?'**
  String get cancelRecordingBody;

  /// No description provided for @dialogNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get dialogNo;

  /// No description provided for @dialogYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get dialogYes;

  /// No description provided for @reportTitle.
  ///
  /// In en, this message translates to:
  /// **'Report: {email}'**
  String reportTitle(Object email);

  /// No description provided for @scoreFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Score (out of 100)'**
  String get scoreFieldLabel;

  /// No description provided for @scoreRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a score'**
  String get scoreRequired;

  /// No description provided for @scoreRangeError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a score between 0 and 100'**
  String get scoreRangeError;

  /// No description provided for @feedbackFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Feedback and evaluation'**
  String get feedbackFieldLabel;

  /// No description provided for @feedbackRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter feedback'**
  String get feedbackRequired;

  /// No description provided for @audioSectionOptional.
  ///
  /// In en, this message translates to:
  /// **'Add audio evaluation (optional):'**
  String get audioSectionOptional;

  /// No description provided for @submitEvaluation.
  ///
  /// In en, this message translates to:
  /// **'Submit Evaluation'**
  String get submitEvaluation;

  /// No description provided for @recordingStartLabel.
  ///
  /// In en, this message translates to:
  /// **'Record audio evaluation'**
  String get recordingStartLabel;

  /// No description provided for @recordingInProgress.
  ///
  /// In en, this message translates to:
  /// **'Recording in progress'**
  String get recordingInProgress;

  /// No description provided for @recordedLabel.
  ///
  /// In en, this message translates to:
  /// **'Recorded'**
  String get recordedLabel;

  /// No description provided for @previewAudioLabel.
  ///
  /// In en, this message translates to:
  /// **'Preview audio recording'**
  String get previewAudioLabel;

  /// No description provided for @previewButton.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get previewButton;

  /// No description provided for @durationLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration: {value}'**
  String durationLabel(Object value);

  /// No description provided for @reRecord.
  ///
  /// In en, this message translates to:
  /// **'Re-record'**
  String get reRecord;

  /// No description provided for @pinAction.
  ///
  /// In en, this message translates to:
  /// **'Pin'**
  String get pinAction;

  /// No description provided for @unpinAction.
  ///
  /// In en, this message translates to:
  /// **'Unpin'**
  String get unpinAction;

  /// No description provided for @copyTextAction.
  ///
  /// In en, this message translates to:
  /// **'Copy text'**
  String get copyTextAction;

  /// No description provided for @editAction.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editAction;

  /// No description provided for @deleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAction;

  /// No description provided for @copiedToast.
  ///
  /// In en, this message translates to:
  /// **'Copied!'**
  String get copiedToast;

  /// No description provided for @writeReplyHint.
  ///
  /// In en, this message translates to:
  /// **'Write a reply...'**
  String get writeReplyHint;

  /// No description provided for @retryLabel.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryLabel;

  /// No description provided for @uploadingAudio.
  ///
  /// In en, this message translates to:
  /// **'Uploading audio...'**
  String get uploadingAudio;

  /// No description provided for @audioFailed.
  ///
  /// In en, this message translates to:
  /// **'Audio upload failed'**
  String get audioFailed;

  /// No description provided for @audioLabel.
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get audioLabel;

  /// No description provided for @editCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get editCancel;

  /// No description provided for @editSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get editSave;

  /// No description provided for @pinnedReplyLabel.
  ///
  /// In en, this message translates to:
  /// **'Pinned reply: {id}'**
  String pinnedReplyLabel(Object id);

  /// No description provided for @commentUnknownUser.
  ///
  /// In en, this message translates to:
  /// **'Unknown user'**
  String get commentUnknownUser;

  /// No description provided for @commentFallbackName.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get commentFallbackName;

  /// No description provided for @commentHint.
  ///
  /// In en, this message translates to:
  /// **'Add a comment...'**
  String get commentHint;

  /// No description provided for @noFeedback.
  ///
  /// In en, this message translates to:
  /// **'No feedback provided'**
  String get noFeedback;

  /// No description provided for @discussionButton.
  ///
  /// In en, this message translates to:
  /// **'Discussion'**
  String get discussionButton;

  /// No description provided for @scoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Score: {score}'**
  String scoreLabel(Object score);

  /// No description provided for @audioPauseSemantic.
  ///
  /// In en, this message translates to:
  /// **'Pause audio'**
  String get audioPauseSemantic;

  /// No description provided for @audioPlaySemantic.
  ///
  /// In en, this message translates to:
  /// **'Play audio'**
  String get audioPlaySemantic;

  /// No description provided for @audioEvaluation.
  ///
  /// In en, this message translates to:
  /// **'Audio evaluation'**
  String get audioEvaluation;

  /// No description provided for @audioPlayingNow.
  ///
  /// In en, this message translates to:
  /// **'Playing now'**
  String get audioPlayingNow;

  /// No description provided for @audioTapToPlay.
  ///
  /// In en, this message translates to:
  /// **'Tap to play'**
  String get audioTapToPlay;

  /// No description provided for @userMissing.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userMissing;

  /// No description provided for @dashboardTitleTrainer.
  ///
  /// In en, this message translates to:
  /// **'Trainer Dashboard'**
  String get dashboardTitleTrainer;

  /// No description provided for @createCourseFab.
  ///
  /// In en, this message translates to:
  /// **'Create Course'**
  String get createCourseFab;

  /// No description provided for @loadCoursesError.
  ///
  /// In en, this message translates to:
  /// **'Error loading courses: {error}'**
  String loadCoursesError(Object error);

  /// No description provided for @noTrainerCoursesTitleAlt.
  ///
  /// In en, this message translates to:
  /// **'No courses created yet'**
  String get noTrainerCoursesTitleAlt;

  /// No description provided for @noTrainerCoursesHintAlt.
  ///
  /// In en, this message translates to:
  /// **'Press + to create your first course'**
  String get noTrainerCoursesHintAlt;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get loadMore;

  /// No description provided for @courseCodePrefix.
  ///
  /// In en, this message translates to:
  /// **'Course code: {code}'**
  String courseCodePrefix(Object code);

  /// No description provided for @homeTitleTrainee.
  ///
  /// In en, this message translates to:
  /// **'Trainee Home'**
  String get homeTitleTrainee;

  /// No description provided for @loadErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Error loading data: {error}'**
  String loadErrorGeneric(Object error);

  /// No description provided for @noTraineeCoursesTitleAlt.
  ///
  /// In en, this message translates to:
  /// **'No courses joined yet'**
  String get noTraineeCoursesTitleAlt;

  /// No description provided for @noTraineeCoursesHintAlt.
  ///
  /// In en, this message translates to:
  /// **'Press + to join your first course'**
  String get noTraineeCoursesHintAlt;

  /// No description provided for @trainerPrefix.
  ///
  /// In en, this message translates to:
  /// **'Trainer: {id}'**
  String trainerPrefix(Object id);

  /// No description provided for @joinCourseAction.
  ///
  /// In en, this message translates to:
  /// **'Join Course'**
  String get joinCourseAction;

  /// No description provided for @reportGeneralSection.
  ///
  /// In en, this message translates to:
  /// **'General Information'**
  String get reportGeneralSection;

  /// No description provided for @reportQuizzesSection.
  ///
  /// In en, this message translates to:
  /// **'Quizzes'**
  String get reportQuizzesSection;

  /// No description provided for @addEvaluationFab.
  ///
  /// In en, this message translates to:
  /// **'Add Evaluation'**
  String get addEvaluationFab;

  /// No description provided for @reportNoEvaluations.
  ///
  /// In en, this message translates to:
  /// **'No evaluations yet'**
  String get reportNoEvaluations;

  /// No description provided for @reportNoQuizzes.
  ///
  /// In en, this message translates to:
  /// **'No quizzes yet'**
  String get reportNoQuizzes;

  /// No description provided for @leaderboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboardTitle;

  /// No description provided for @leaderboardEmpty.
  ///
  /// In en, this message translates to:
  /// **'No players yet'**
  String get leaderboardEmpty;

  /// No description provided for @leaderboardPoints.
  ///
  /// In en, this message translates to:
  /// **'{points} pts'**
  String leaderboardPoints(Object points);

  /// No description provided for @pointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get pointsLabel;

  /// No description provided for @dashboardSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get dashboardSeeAll;

  /// No description provided for @timelineFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get timelineFilterAll;

  /// No description provided for @timelineFilterQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Quizzes'**
  String get timelineFilterQuizzes;

  /// No description provided for @timelineFilterTasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get timelineFilterTasks;

  /// No description provided for @timelineFilterLessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get timelineFilterLessons;

  /// No description provided for @timelineFilterStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get timelineFilterStreak;

  /// No description provided for @timelineNoMoreEvents.
  ///
  /// In en, this message translates to:
  /// **'No more events'**
  String get timelineNoMoreEvents;

  /// No description provided for @nextBadgeShort.
  ///
  /// In en, this message translates to:
  /// **'Next badge'**
  String get nextBadgeShort;

  /// No description provided for @badgesLabel.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get badgesLabel;

  /// No description provided for @levelLabel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String levelLabel(Object level);

  /// No description provided for @earnedBadgesSection.
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get earnedBadgesSection;

  /// No description provided for @allBadgesSection.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allBadgesSection;

  /// No description provided for @noBadgesYet.
  ///
  /// In en, this message translates to:
  /// **'No badges yet'**
  String get noBadgesYet;

  /// No description provided for @reviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviewsTitle;

  /// No description provided for @addReviewAction.
  ///
  /// In en, this message translates to:
  /// **'Add Review'**
  String get addReviewAction;

  /// No description provided for @ratingLabel.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get ratingLabel;

  /// No description provided for @reviewSubmitSuccess.
  ///
  /// In en, this message translates to:
  /// **'Review submitted'**
  String get reviewSubmitSuccess;

  /// No description provided for @reviewSubmitFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit review'**
  String get reviewSubmitFailure;

  /// No description provided for @averageRatingLabel.
  ///
  /// In en, this message translates to:
  /// **'Average: {value}'**
  String averageRatingLabel(Object value);

  /// No description provided for @streakLabel.
  ///
  /// In en, this message translates to:
  /// **'Streak: {days}d'**
  String streakLabel(Object days);

  /// No description provided for @nextBadgeProgress.
  ///
  /// In en, this message translates to:
  /// **'Next badge at {points} pts'**
  String nextBadgeProgress(Object points);

  /// No description provided for @dailyStreakAward.
  ///
  /// In en, this message translates to:
  /// **'Daily streak +{points}'**
  String dailyStreakAward(Object points);

  /// No description provided for @quizPassedAward.
  ///
  /// In en, this message translates to:
  /// **'Quiz passed +{points}'**
  String quizPassedAward(Object points);

  /// No description provided for @lessonCompletedAward.
  ///
  /// In en, this message translates to:
  /// **'Lesson completed +{points}'**
  String lessonCompletedAward(Object points);

  /// No description provided for @badgeEarnedToast.
  ///
  /// In en, this message translates to:
  /// **'Badge earned: {name}'**
  String badgeEarnedToast(Object name);

  /// No description provided for @badgesEarnedBatch.
  ///
  /// In en, this message translates to:
  /// **'Badge earned: {first} +{more}'**
  String badgesEarnedBatch(Object first, Object more);

  /// No description provided for @noReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviewsYet;

  /// No description provided for @submitReview.
  ///
  /// In en, this message translates to:
  /// **'Submit Review'**
  String get submitReview;

  /// No description provided for @reviewCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Your comment'**
  String get reviewCommentHint;

  /// No description provided for @reviewRatingHint.
  ///
  /// In en, this message translates to:
  /// **'Tap stars to rate'**
  String get reviewRatingHint;

  /// No description provided for @gamificationSection.
  ///
  /// In en, this message translates to:
  /// **'Progress & Achievements'**
  String get gamificationSection;

  /// No description provided for @progressTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progressTitle;

  /// No description provided for @testsTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Tests'**
  String get testsTabLabel;

  /// No description provided for @tasksTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasksTabLabel;

  /// No description provided for @noQuizzesYet.
  ///
  /// In en, this message translates to:
  /// **'No quizzes available yet'**
  String get noQuizzesYet;

  /// No description provided for @quizLastScore.
  ///
  /// In en, this message translates to:
  /// **'Last score: {score}%'**
  String quizLastScore(Object score);

  /// No description provided for @quizNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Not started yet'**
  String get quizNotStarted;

  /// No description provided for @quizStartAction.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get quizStartAction;

  /// No description provided for @quizRetakeAction.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get quizRetakeAction;

  /// No description provided for @noTasksYetAlt.
  ///
  /// In en, this message translates to:
  /// **'No tasks right now'**
  String get noTasksYetAlt;

  /// No description provided for @addTaskDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get addTaskDialogTitle;

  /// No description provided for @fieldTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get fieldTitleHint;

  /// No description provided for @fieldDetailsHint.
  ///
  /// In en, this message translates to:
  /// **'Details (optional)'**
  String get fieldDetailsHint;

  /// No description provided for @fieldPointsHint.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get fieldPointsHint;

  /// No description provided for @priorityLabel.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priorityLabel;

  /// No description provided for @priorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High priority'**
  String get priorityHigh;

  /// No description provided for @priorityMed.
  ///
  /// In en, this message translates to:
  /// **'Medium priority'**
  String get priorityMed;

  /// No description provided for @priorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low priority'**
  String get priorityLow;

  /// No description provided for @taskStatusNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get taskStatusNew;

  /// No description provided for @taskStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get taskStatusInProgress;

  /// No description provided for @taskStatusDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get taskStatusDone;

  /// No description provided for @badgeManageTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Badges'**
  String get badgeManageTitle;

  /// No description provided for @noBadgesDefined.
  ///
  /// In en, this message translates to:
  /// **'No badges defined yet'**
  String get noBadgesDefined;

  /// No description provided for @newBadgeTitle.
  ///
  /// In en, this message translates to:
  /// **'New Badge'**
  String get newBadgeTitle;

  /// No description provided for @editBadgeTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Badge'**
  String get editBadgeTitle;

  /// No description provided for @deleteBadgeTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Badge'**
  String get deleteBadgeTitle;

  /// No description provided for @deleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Delete badge: {name}?'**
  String deleteConfirmBody(Object name);

  /// No description provided for @badgeIconUrlLabel.
  ///
  /// In en, this message translates to:
  /// **'Icon URL'**
  String get badgeIconUrlLabel;

  /// No description provided for @criteriaSectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Criteria'**
  String get criteriaSectionLabel;

  /// No description provided for @activeLabel.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeLabel;

  /// No description provided for @autoAwardLabel.
  ///
  /// In en, this message translates to:
  /// **'Auto award'**
  String get autoAwardLabel;

  /// No description provided for @saveActionLabel.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveActionLabel;

  /// No description provided for @dialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get dialogCancel;

  /// No description provided for @taskStatusSkipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get taskStatusSkipped;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @selectDueDate.
  ///
  /// In en, this message translates to:
  /// **'Select due date'**
  String get selectDueDate;

  /// No description provided for @dueDatePickerLabel.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get dueDatePickerLabel;

  /// No description provided for @pickAction.
  ///
  /// In en, this message translates to:
  /// **'Pick'**
  String get pickAction;

  /// No description provided for @changeAction.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get changeAction;

  /// No description provided for @clearAction.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearAction;

  /// No description provided for @duePast.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get duePast;

  /// No description provided for @dueToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dueToday;

  /// No description provided for @dueTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get dueTomorrow;

  /// No description provided for @dueInDays.
  ///
  /// In en, this message translates to:
  /// **'In {days} days'**
  String dueInDays(Object days);

  /// No description provided for @quizPassedLabel.
  ///
  /// In en, this message translates to:
  /// **'Passed'**
  String get quizPassedLabel;

  /// No description provided for @quizSubmitAction.
  ///
  /// In en, this message translates to:
  /// **'Submit Quiz'**
  String get quizSubmitAction;

  /// No description provided for @quizPassThreshold.
  ///
  /// In en, this message translates to:
  /// **'Pass >= {score}%'**
  String quizPassThreshold(Object score);

  /// No description provided for @taskDueFilterOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get taskDueFilterOverdue;

  /// No description provided for @taskDueFilterToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get taskDueFilterToday;

  /// No description provided for @taskDueFilterWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get taskDueFilterWeek;

  /// No description provided for @quizAttemptsUsed.
  ///
  /// In en, this message translates to:
  /// **'Attempts: {used}/{max}'**
  String quizAttemptsUsed(Object used, Object max);

  /// No description provided for @quizAttemptExceeded.
  ///
  /// In en, this message translates to:
  /// **'No more attempts'**
  String get quizAttemptExceeded;

  /// No description provided for @quizAttemptSingle.
  ///
  /// In en, this message translates to:
  /// **'Single attempt'**
  String get quizAttemptSingle;

  /// No description provided for @quizAttemptMultiple.
  ///
  /// In en, this message translates to:
  /// **'Up to {max} attempts'**
  String quizAttemptMultiple(Object max);

  /// No description provided for @quizReviewAction.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get quizReviewAction;

  /// No description provided for @quizSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz Settings'**
  String get quizSettingsTitle;

  /// No description provided for @quizPassPercentLabel.
  ///
  /// In en, this message translates to:
  /// **'Pass %'**
  String get quizPassPercentLabel;

  /// No description provided for @quizRewardPointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Reward Points'**
  String get quizRewardPointsLabel;

  /// No description provided for @quizMaxAttemptsLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Attempts'**
  String get quizMaxAttemptsLabel;

  /// No description provided for @quizUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Quiz updated'**
  String get quizUpdateSuccess;

  /// No description provided for @quizUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Update failed'**
  String get quizUpdateFailed;

  /// No description provided for @postPublishing.
  ///
  /// In en, this message translates to:
  /// **'Posting...'**
  String get postPublishing;

  /// No description provided for @postPublished.
  ///
  /// In en, this message translates to:
  /// **'Post published'**
  String get postPublished;

  /// No description provided for @orgAdminDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Organization Admin Dashboard'**
  String get orgAdminDashboardTitle;

  /// No description provided for @orgAdminDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Metrics and trends for your institution'**
  String get orgAdminDashboardSubtitle;

  /// No description provided for @companyAdminDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Company Admin Dashboard'**
  String get companyAdminDashboardTitle;

  /// No description provided for @companyAdminDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Metrics and trends for your company'**
  String get companyAdminDashboardSubtitle;

  /// No description provided for @departmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Departments'**
  String get departmentsTitle;

  /// No description provided for @departmentsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View your company departments'**
  String get departmentsSubtitle;

  /// No description provided for @learningPathsTitle.
  ///
  /// In en, this message translates to:
  /// **'Learning Paths'**
  String get learningPathsTitle;

  /// No description provided for @learningPathsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View learning paths for your company'**
  String get learningPathsSubtitle;

  /// No description provided for @managerDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Manager Dashboard'**
  String get managerDashboardTitle;

  /// No description provided for @managerDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Team overview and skill gaps (preview)'**
  String get managerDashboardSubtitle;

  /// No description provided for @bulkImportTitle.
  ///
  /// In en, this message translates to:
  /// **'Bulk Import (CSV)'**
  String get bulkImportTitle;

  /// No description provided for @bulkImportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Import batched changes from CSV file'**
  String get bulkImportSubtitle;

  /// No description provided for @selectDepartmentHint.
  ///
  /// In en, this message translates to:
  /// **'Select a department from Departments to view team.'**
  String get selectDepartmentHint;

  /// No description provided for @labelActiveUsers.
  ///
  /// In en, this message translates to:
  /// **'Active Users'**
  String get labelActiveUsers;

  /// No description provided for @labelAvgEventsPerUser7d.
  ///
  /// In en, this message translates to:
  /// **'Avg Events/User (7d)'**
  String get labelAvgEventsPerUser7d;

  /// No description provided for @labelAvgMastery.
  ///
  /// In en, this message translates to:
  /// **'Avg Mastery'**
  String get labelAvgMastery;

  /// No description provided for @labelAvgMasteryDelta14d.
  ///
  /// In en, this message translates to:
  /// **'Avg Mastery Δ14d'**
  String get labelAvgMasteryDelta14d;

  /// No description provided for @labelLatestPrefix.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get labelLatestPrefix;

  /// No description provided for @labelLatest7Days.
  ///
  /// In en, this message translates to:
  /// **'Latest 7 days'**
  String get labelLatest7Days;

  /// No description provided for @labelDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get labelDate;

  /// No description provided for @labelActiveShort.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get labelActiveShort;

  /// No description provided for @labelAvgEvPerUsrShort.
  ///
  /// In en, this message translates to:
  /// **'AvgEv/Usr'**
  String get labelAvgEvPerUsrShort;

  /// No description provided for @labelAvgMasteryShort.
  ///
  /// In en, this message translates to:
  /// **'AvgMastery'**
  String get labelAvgMasteryShort;

  /// No description provided for @labelDelta14dShort.
  ///
  /// In en, this message translates to:
  /// **'Δ14d'**
  String get labelDelta14dShort;

  /// No description provided for @noDepartments.
  ///
  /// In en, this message translates to:
  /// **'No departments'**
  String get noDepartments;

  /// No description provided for @idLabel.
  ///
  /// In en, this message translates to:
  /// **'ID: {id}'**
  String idLabel(Object id);

  /// No description provided for @noTeamMembers.
  ///
  /// In en, this message translates to:
  /// **'No team members in this department'**
  String get noTeamMembers;

  /// No description provided for @topSkillGapsTitle.
  ///
  /// In en, this message translates to:
  /// **'Top skill gaps'**
  String get topSkillGapsTitle;

  /// No description provided for @noSkillData.
  ///
  /// In en, this message translates to:
  /// **'No skill data'**
  String get noSkillData;

  /// No description provided for @activeChip.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeChip;

  /// No description provided for @inactiveChip.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactiveChip;

  /// No description provided for @pathTitle.
  ///
  /// In en, this message translates to:
  /// **'Path: {title}'**
  String pathTitle(Object title);

  /// No description provided for @noLearningPaths.
  ///
  /// In en, this message translates to:
  /// **'No learning paths'**
  String get noLearningPaths;

  /// No description provided for @noSteps.
  ///
  /// In en, this message translates to:
  /// **'No steps'**
  String get noSteps;

  /// No description provided for @bulkImportCsvFormat.
  ///
  /// In en, this message translates to:
  /// **'CSV Format: collection,docId,field.path,value'**
  String get bulkImportCsvFormat;

  /// No description provided for @bulkImportPickCsv.
  ///
  /// In en, this message translates to:
  /// **'Pick CSV'**
  String get bulkImportPickCsv;

  /// No description provided for @departmentsAddAction.
  ///
  /// In en, this message translates to:
  /// **'Add Department'**
  String get departmentsAddAction;

  /// No description provided for @departmentNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Department name'**
  String get departmentNameLabel;

  /// No description provided for @assignUserToDepartmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Assign user to department'**
  String get assignUserToDepartmentTitle;

  /// No description provided for @departmentMembersTitle.
  ///
  /// In en, this message translates to:
  /// **'Department Members'**
  String get departmentMembersTitle;

  /// No description provided for @manageMembersAction.
  ///
  /// In en, this message translates to:
  /// **'Manage members'**
  String get manageMembersAction;

  /// No description provided for @assignMemberAction.
  ///
  /// In en, this message translates to:
  /// **'Assign member'**
  String get assignMemberAction;

  /// No description provided for @searchUsersLabel.
  ///
  /// In en, this message translates to:
  /// **'Search users by name or email'**
  String get searchUsersLabel;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get noResults;

  /// No description provided for @assignSelectedAction.
  ///
  /// In en, this message translates to:
  /// **'Assign selected'**
  String get assignSelectedAction;

  /// No description provided for @selectAtLeastOneUser.
  ///
  /// In en, this message translates to:
  /// **'Select at least one user'**
  String get selectAtLeastOneUser;

  /// No description provided for @assignmentCompletedToast.
  ///
  /// In en, this message translates to:
  /// **'Assigned {count} member(s)'**
  String assignmentCompletedToast(Object count);

  /// No description provided for @removeMemberConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove this member from the department?'**
  String get removeMemberConfirm;

  /// No description provided for @memberRemovedToast.
  ///
  /// In en, this message translates to:
  /// **'Member removed'**
  String get memberRemovedToast;

  /// No description provided for @departmentCreatedToast.
  ///
  /// In en, this message translates to:
  /// **'Department created: {name}'**
  String departmentCreatedToast(Object name);

  /// No description provided for @alreadyMemberLabel.
  ///
  /// In en, this message translates to:
  /// **'Already in this department'**
  String get alreadyMemberLabel;

  /// No description provided for @pleaseSelectRole.
  ///
  /// In en, this message translates to:
  /// **'Please select a role'**
  String get pleaseSelectRole;

  /// No description provided for @authErrorWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect'**
  String get authErrorWrongPassword;

  /// No description provided for @authErrorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'Email is not registered'**
  String get authErrorUserNotFound;

  /// No description provided for @authErrorEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'Email is already registered'**
  String get authErrorEmailInUse;

  /// No description provided for @authErrorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get authErrorInvalidEmail;

  /// No description provided for @authErrorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak'**
  String get authErrorWeakPassword;

  /// No description provided for @authErrorUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account is disabled. Contact support'**
  String get authErrorUserDisabled;

  /// No description provided for @authErrorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Try again later'**
  String get authErrorTooManyRequests;

  /// No description provided for @authErrorNetworkFailed.
  ///
  /// In en, this message translates to:
  /// **'Network connection error'**
  String get authErrorNetworkFailed;

  /// No description provided for @authErrorOperationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Operation not allowed'**
  String get authErrorOperationNotAllowed;

  /// No description provided for @authErrorDefault.
  ///
  /// In en, this message translates to:
  /// **'An error occurred during authentication'**
  String get authErrorDefault;

  /// No description provided for @dialogConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get dialogConfirmTitle;

  /// No description provided for @dialogDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get dialogDeleteTitle;

  /// No description provided for @dialogCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get dialogCancelButton;

  /// No description provided for @dialogConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get dialogConfirmButton;

  /// No description provided for @dialogDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get dialogDeleteButton;

  /// No description provided for @dialogSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get dialogSaveButton;

  /// No description provided for @dialogCloseButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get dialogCloseButton;

  /// No description provided for @commentReply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get commentReply;

  /// No description provided for @commentEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commentEdit;

  /// No description provided for @commentDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commentDelete;

  /// No description provided for @commentDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get commentDeleteConfirm;

  /// No description provided for @commentDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Comment'**
  String get commentDeleteTitle;

  /// No description provided for @filterPostsTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter Posts'**
  String get filterPostsTitle;

  /// No description provided for @sortPostsTitle.
  ///
  /// In en, this message translates to:
  /// **'Sort Posts'**
  String get sortPostsTitle;

  /// No description provided for @filterClearDates.
  ///
  /// In en, this message translates to:
  /// **'Clear Dates'**
  String get filterClearDates;

  /// No description provided for @filterReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get filterReset;

  /// No description provided for @filterApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get filterApply;

  /// No description provided for @sortPinnedFirst.
  ///
  /// In en, this message translates to:
  /// **'Pinned First'**
  String get sortPinnedFirst;

  /// No description provided for @reactionsClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get reactionsClose;

  /// No description provided for @emailVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get emailVerificationTitle;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @termsOfServiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfServiceTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @superAdminDashboard.
  ///
  /// In en, this message translates to:
  /// **'Super Admin Dashboard'**
  String get superAdminDashboard;

  /// No description provided for @superAdminDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage institutions, companies, and settings'**
  String get superAdminDashboardSubtitle;

  /// No description provided for @searchPostsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search in posts...'**
  String get searchPostsPlaceholder;

  /// No description provided for @filterButtonTooltip.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterButtonTooltip;

  /// No description provided for @sortButtonTooltip.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sortButtonTooltip;

  /// No description provided for @postTypeFilter.
  ///
  /// In en, this message translates to:
  /// **'Post Type'**
  String get postTypeFilter;

  /// No description provided for @dateRangeFilter.
  ///
  /// In en, this message translates to:
  /// **'Date Range'**
  String get dateRangeFilter;

  /// No description provided for @dateFromLabel.
  ///
  /// In en, this message translates to:
  /// **'From Date'**
  String get dateFromLabel;

  /// No description provided for @dateToLabel.
  ///
  /// In en, this message translates to:
  /// **'To Date'**
  String get dateToLabel;

  /// No description provided for @postDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Post'**
  String get postDeleteTitle;

  /// No description provided for @postDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this post?'**
  String get postDeleteConfirm;

  /// No description provided for @postDeleted.
  ///
  /// In en, this message translates to:
  /// **'Post deleted'**
  String get postDeleted;

  /// No description provided for @postPinned.
  ///
  /// In en, this message translates to:
  /// **'Post pinned'**
  String get postPinned;

  /// No description provided for @postUnpinned.
  ///
  /// In en, this message translates to:
  /// **'Post unpinned'**
  String get postUnpinned;

  /// No description provided for @postEditButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get postEditButton;

  /// No description provided for @postPinButton.
  ///
  /// In en, this message translates to:
  /// **'Pin'**
  String get postPinButton;

  /// No description provided for @postUnpinButton.
  ///
  /// In en, this message translates to:
  /// **'Unpin'**
  String get postUnpinButton;

  /// No description provided for @postDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get postDeleteButton;

  /// No description provided for @postEditedLabel.
  ///
  /// In en, this message translates to:
  /// **'edited'**
  String get postEditedLabel;

  /// No description provided for @postAuthorFallback.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get postAuthorFallback;

  /// No description provided for @postCommentCount.
  ///
  /// In en, this message translates to:
  /// **'{count} comment'**
  String postCommentCount(Object count);

  /// No description provided for @postCommentButton.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get postCommentButton;

  /// No description provided for @reactionPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your reaction'**
  String get reactionPickerTitle;

  /// No description provided for @reactionAddTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add reaction'**
  String get reactionAddTooltip;

  /// No description provided for @addPostTitle.
  ///
  /// In en, this message translates to:
  /// **'New Post'**
  String get addPostTitle;

  /// No description provided for @addPostContentPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'What do you want to share?'**
  String get addPostContentPlaceholder;

  /// No description provided for @addPostContentRequired.
  ///
  /// In en, this message translates to:
  /// **'Please write content or add an image'**
  String get addPostContentRequired;

  /// No description provided for @addPostPickImages.
  ///
  /// In en, this message translates to:
  /// **'Choose Images'**
  String get addPostPickImages;

  /// No description provided for @addPostTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get addPostTakePhoto;

  /// No description provided for @addPostSelectedImages.
  ///
  /// In en, this message translates to:
  /// **'Selected images ({count}/5):'**
  String addPostSelectedImages(Object count);

  /// No description provided for @addPostUploadingImages.
  ///
  /// In en, this message translates to:
  /// **'Uploading images... {percent}%'**
  String addPostUploadingImages(Object percent);

  /// No description provided for @addPostPublishing.
  ///
  /// In en, this message translates to:
  /// **'Publishing post...'**
  String get addPostPublishing;

  /// No description provided for @addPostPublishButton.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get addPostPublishButton;

  /// No description provided for @addPostPublishingButton.
  ///
  /// In en, this message translates to:
  /// **'Publishing...'**
  String get addPostPublishingButton;

  /// No description provided for @addPostSuccess.
  ///
  /// In en, this message translates to:
  /// **'Post published successfully'**
  String get addPostSuccess;

  /// No description provided for @addPostUploadError.
  ///
  /// In en, this message translates to:
  /// **'Error uploading images: {error}'**
  String addPostUploadError(Object error);

  /// No description provided for @addPostCharacterCount.
  ///
  /// In en, this message translates to:
  /// **'{current}/{max}'**
  String addPostCharacterCount(Object current, Object max);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
