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

  /// No description provided for @leaderboardWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get leaderboardWeekly;

  /// No description provided for @leaderboardMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get leaderboardMonthly;

  /// No description provided for @leaderboardAllTime.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get leaderboardAllTime;

  /// No description provided for @leaderboardRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get leaderboardRetry;

  /// No description provided for @leaderboardLoadError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading leaderboard'**
  String get leaderboardLoadError;

  /// No description provided for @leaderboardNoEntries.
  ///
  /// In en, this message translates to:
  /// **'No leaderboard entries yet'**
  String get leaderboardNoEntries;

  /// No description provided for @leaderboardYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get leaderboardYou;

  /// No description provided for @leaderboardRank.
  ///
  /// In en, this message translates to:
  /// **'Rank'**
  String get leaderboardRank;

  /// No description provided for @leaderboardPointsWithLabel.
  ///
  /// In en, this message translates to:
  /// **'{points} points'**
  String leaderboardPointsWithLabel(Object points);

  /// No description provided for @leaderboardPointsShort.
  ///
  /// In en, this message translates to:
  /// **'points'**
  String get leaderboardPointsShort;

  /// No description provided for @leaderboardLevelFormat.
  ///
  /// In en, this message translates to:
  /// **'Level {level} • {name}'**
  String leaderboardLevelFormat(Object level, Object name);

  /// No description provided for @leaderboardEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No top players yet'**
  String get leaderboardEmptyTitle;

  /// No description provided for @leaderboardEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Be the first to earn points!'**
  String get leaderboardEmptySubtitle;

  /// No description provided for @leaderboardErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading top players'**
  String get leaderboardErrorLoad;

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

  /// No description provided for @editPostTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Post'**
  String get editPostTitle;

  /// No description provided for @editPostPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write post content...'**
  String get editPostPlaceholder;

  /// No description provided for @editPostCharacterCount.
  ///
  /// In en, this message translates to:
  /// **'{current}/{max} characters'**
  String editPostCharacterCount(Object current, Object max);

  /// No description provided for @editPostSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get editPostSaveButton;

  /// No description provided for @editPostSuccess.
  ///
  /// In en, this message translates to:
  /// **'Post updated'**
  String get editPostSuccess;

  /// No description provided for @createPollTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Poll'**
  String get createPollTitle;

  /// No description provided for @createPollQuestionLabel.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get createPollQuestionLabel;

  /// No description provided for @createPollQuestionHint.
  ///
  /// In en, this message translates to:
  /// **'Write your poll question...'**
  String get createPollQuestionHint;

  /// No description provided for @createPollQuestionRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter the question'**
  String get createPollQuestionRequired;

  /// No description provided for @createPollOptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get createPollOptionsTitle;

  /// No description provided for @createPollOptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Option {number}'**
  String createPollOptionLabel(Object number);

  /// No description provided for @createPollOptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get createPollOptionRequired;

  /// No description provided for @createPollAddOption.
  ///
  /// In en, this message translates to:
  /// **'Add Option'**
  String get createPollAddOption;

  /// No description provided for @createPollMaxOptionsError.
  ///
  /// In en, this message translates to:
  /// **'Maximum 10 options'**
  String get createPollMaxOptionsError;

  /// No description provided for @createPollMinOptionsError.
  ///
  /// In en, this message translates to:
  /// **'Must have at least 2 options'**
  String get createPollMinOptionsError;

  /// No description provided for @createPollMinOptionsSubmitError.
  ///
  /// In en, this message translates to:
  /// **'Must add at least 2 options'**
  String get createPollMinOptionsSubmitError;

  /// No description provided for @createPollSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get createPollSettingsTitle;

  /// No description provided for @createPollAllowMultiple.
  ///
  /// In en, this message translates to:
  /// **'Allow multiple selections'**
  String get createPollAllowMultiple;

  /// No description provided for @createPollShowResults.
  ///
  /// In en, this message translates to:
  /// **'Show results before voting'**
  String get createPollShowResults;

  /// No description provided for @createPollEndDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Poll end date'**
  String get createPollEndDateLabel;

  /// No description provided for @createPollEndDateNone.
  ///
  /// In en, this message translates to:
  /// **'None (always open)'**
  String get createPollEndDateNone;

  /// No description provided for @createPollCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createPollCreateButton;

  /// No description provided for @createPollCreatingButton.
  ///
  /// In en, this message translates to:
  /// **'Creating...'**
  String get createPollCreatingButton;

  /// No description provided for @createPollSuccess.
  ///
  /// In en, this message translates to:
  /// **'Poll created successfully'**
  String get createPollSuccess;

  /// No description provided for @reportDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Content'**
  String get reportDialogTitle;

  /// No description provided for @reportTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Report Type'**
  String get reportTypeLabel;

  /// No description provided for @reportTypeInappropriate.
  ///
  /// In en, this message translates to:
  /// **'Inappropriate content'**
  String get reportTypeInappropriate;

  /// No description provided for @reportTypeHarassment.
  ///
  /// In en, this message translates to:
  /// **'Harassment'**
  String get reportTypeHarassment;

  /// No description provided for @reportTypeSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam'**
  String get reportTypeSpam;

  /// No description provided for @reportTypeMisinformation.
  ///
  /// In en, this message translates to:
  /// **'Misinformation'**
  String get reportTypeMisinformation;

  /// No description provided for @reportTypeHarmful.
  ///
  /// In en, this message translates to:
  /// **'Harmful content'**
  String get reportTypeHarmful;

  /// No description provided for @reportTypeCopyright.
  ///
  /// In en, this message translates to:
  /// **'Copyright violation'**
  String get reportTypeCopyright;

  /// No description provided for @reportTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get reportTypeOther;

  /// No description provided for @reportReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason *'**
  String get reportReasonLabel;

  /// No description provided for @reportReasonHint.
  ///
  /// In en, this message translates to:
  /// **'Enter report reason'**
  String get reportReasonHint;

  /// No description provided for @reportReasonRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a reason'**
  String get reportReasonRequired;

  /// No description provided for @reportDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Additional details (optional)'**
  String get reportDescriptionLabel;

  /// No description provided for @reportDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Add any additional details to help with review'**
  String get reportDescriptionHint;

  /// No description provided for @reportReviewNote.
  ///
  /// In en, this message translates to:
  /// **'Report will be reviewed by moderation team'**
  String get reportReviewNote;

  /// No description provided for @reportSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit Report'**
  String get reportSubmitButton;

  /// No description provided for @reportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Report submitted successfully. Will be reviewed by moderators.'**
  String get reportSuccess;

  /// No description provided for @reportError.
  ///
  /// In en, this message translates to:
  /// **'Error submitting report'**
  String get reportError;

  /// No description provided for @reportLoginRequired.
  ///
  /// In en, this message translates to:
  /// **'Must be logged in first'**
  String get reportLoginRequired;

  /// No description provided for @reportButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get reportButtonLabel;

  /// No description provided for @commentPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write your comment...'**
  String get commentPlaceholder;

  /// No description provided for @pollNotFound.
  ///
  /// In en, this message translates to:
  /// **'Poll not found'**
  String get pollNotFound;

  /// No description provided for @pollError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String pollError(Object error);

  /// No description provided for @pollHeaderLabel.
  ///
  /// In en, this message translates to:
  /// **'Poll'**
  String get pollHeaderLabel;

  /// No description provided for @pollEndedLabel.
  ///
  /// In en, this message translates to:
  /// **'Ended'**
  String get pollEndedLabel;

  /// No description provided for @pollVotesSingular.
  ///
  /// In en, this message translates to:
  /// **'vote'**
  String get pollVotesSingular;

  /// No description provided for @pollVotesPlural.
  ///
  /// In en, this message translates to:
  /// **'votes'**
  String get pollVotesPlural;

  /// No description provided for @pollVotesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} {votes}'**
  String pollVotesCount(Object count, Object votes);

  /// No description provided for @pollEndsIn.
  ///
  /// In en, this message translates to:
  /// **'Ends {time}'**
  String pollEndsIn(Object time);

  /// No description provided for @pollEnded.
  ///
  /// In en, this message translates to:
  /// **'Ended {time}'**
  String pollEnded(Object time);

  /// No description provided for @pollVoteError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String pollVoteError(Object error);

  /// No description provided for @pollOptionVotesSingular.
  ///
  /// In en, this message translates to:
  /// **'{count} vote'**
  String pollOptionVotesSingular(Object count);

  /// No description provided for @pollOptionVotesPlural.
  ///
  /// In en, this message translates to:
  /// **'{count} votes'**
  String pollOptionVotesPlural(Object count);

  /// No description provided for @imageViewerTitle.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String imageViewerTitle(Object current, Object total);

  /// No description provided for @imageDownloadTooltip.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get imageDownloadTooltip;

  /// No description provided for @imageDownloadSuccess.
  ///
  /// In en, this message translates to:
  /// **'Image opened in browser for download'**
  String get imageDownloadSuccess;

  /// No description provided for @imageDownloadError.
  ///
  /// In en, this message translates to:
  /// **'Cannot open link'**
  String get imageDownloadError;

  /// No description provided for @imageLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load image'**
  String get imageLoadError;

  /// No description provided for @imageErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Error occurred: {error}'**
  String imageErrorGeneric(Object error);

  /// No description provided for @reactionPickerTitleAlt.
  ///
  /// In en, this message translates to:
  /// **'Choose your reaction'**
  String get reactionPickerTitleAlt;

  /// No description provided for @reactionError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String reactionError(Object error);

  /// No description provided for @reactionLiked.
  ///
  /// In en, this message translates to:
  /// **'Liked'**
  String get reactionLiked;

  /// No description provided for @reactionLike.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get reactionLike;

  /// No description provided for @courseChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Course Chat'**
  String get courseChatTitle;

  /// No description provided for @courseChatLoginRequired.
  ///
  /// In en, this message translates to:
  /// **'Login required'**
  String get courseChatLoginRequired;

  /// No description provided for @courseChatLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String courseChatLoadError(Object error);

  /// No description provided for @courseChatMute.
  ///
  /// In en, this message translates to:
  /// **'Mute notifications'**
  String get courseChatMute;

  /// No description provided for @courseChatUnmute.
  ///
  /// In en, this message translates to:
  /// **'Unmute notifications'**
  String get courseChatUnmute;

  /// No description provided for @courseChatInfo.
  ///
  /// In en, this message translates to:
  /// **'Chat info'**
  String get courseChatInfo;

  /// No description provided for @courseChatMessageSendError.
  ///
  /// In en, this message translates to:
  /// **'Failed to send message: {error}'**
  String courseChatMessageSendError(Object error);

  /// No description provided for @courseChatEditMessage.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get courseChatEditMessage;

  /// No description provided for @courseChatDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get courseChatDeleteMessage;

  /// No description provided for @courseChatFlagMessage.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get courseChatFlagMessage;

  /// No description provided for @courseChatEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Message'**
  String get courseChatEditTitle;

  /// No description provided for @courseChatEditPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'New message'**
  String get courseChatEditPlaceholder;

  /// No description provided for @courseChatEditSuccess.
  ///
  /// In en, this message translates to:
  /// **'Message edited'**
  String get courseChatEditSuccess;

  /// No description provided for @courseChatEditError.
  ///
  /// In en, this message translates to:
  /// **'Edit failed: {error}'**
  String courseChatEditError(Object error);

  /// No description provided for @courseChatDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Message'**
  String get courseChatDeleteTitle;

  /// No description provided for @courseChatDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this message?'**
  String get courseChatDeleteConfirm;

  /// No description provided for @courseChatDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Message deleted'**
  String get courseChatDeleteSuccess;

  /// No description provided for @courseChatDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Delete failed: {error}'**
  String courseChatDeleteError(Object error);

  /// No description provided for @courseChatFlagSuccess.
  ///
  /// In en, this message translates to:
  /// **'Message reported'**
  String get courseChatFlagSuccess;

  /// No description provided for @courseChatFlagError.
  ///
  /// In en, this message translates to:
  /// **'Report failed: {error}'**
  String courseChatFlagError(Object error);

  /// No description provided for @courseChatMuteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Notifications muted'**
  String get courseChatMuteSuccess;

  /// No description provided for @courseChatUnmuteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Notifications unmuted'**
  String get courseChatUnmuteSuccess;

  /// No description provided for @courseChatMuteError.
  ///
  /// In en, this message translates to:
  /// **'Error changing mute status'**
  String get courseChatMuteError;

  /// No description provided for @courseChatInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat Info'**
  String get courseChatInfoTitle;

  /// No description provided for @courseChatInfoCourse.
  ///
  /// In en, this message translates to:
  /// **'Course: {name}'**
  String courseChatInfoCourse(Object name);

  /// No description provided for @courseChatInfoParticipants.
  ///
  /// In en, this message translates to:
  /// **'Participants: {count}'**
  String courseChatInfoParticipants(Object count);

  /// No description provided for @courseChatInfoCreated.
  ///
  /// In en, this message translates to:
  /// **'Created: {date}'**
  String courseChatInfoCreated(Object date);

  /// No description provided for @courseChatInfoClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get courseChatInfoClose;

  /// No description provided for @directChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Direct Chat'**
  String get directChatTitle;

  /// No description provided for @directChatTyping.
  ///
  /// In en, this message translates to:
  /// **'typing...'**
  String get directChatTyping;

  /// No description provided for @directChatLoginError.
  ///
  /// In en, this message translates to:
  /// **'Error: User data not found'**
  String get directChatLoginError;

  /// No description provided for @directChatBlockTitle.
  ///
  /// In en, this message translates to:
  /// **'Block User'**
  String get directChatBlockTitle;

  /// No description provided for @directChatBlockConfirm.
  ///
  /// In en, this message translates to:
  /// **'Do you want to block this user? You won\'t be able to receive their messages.'**
  String get directChatBlockConfirm;

  /// No description provided for @directChatBlockSuccess.
  ///
  /// In en, this message translates to:
  /// **'User blocked'**
  String get directChatBlockSuccess;

  /// No description provided for @directChatBlockError.
  ///
  /// In en, this message translates to:
  /// **'Failed to block user'**
  String get directChatBlockError;

  /// No description provided for @directChatBlock.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get directChatBlock;

  /// No description provided for @directChatReport.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get directChatReport;

  /// No description provided for @directChatDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Conversation'**
  String get directChatDeleteTitle;

  /// No description provided for @directChatDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this conversation? It will be hidden from your list only.'**
  String get directChatDeleteConfirm;

  /// No description provided for @directChatDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Conversation deleted'**
  String get directChatDeleteSuccess;

  /// No description provided for @directChatDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete conversation'**
  String get directChatDeleteError;

  /// No description provided for @directChatEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Start the conversation...'**
  String get directChatEmptyMessage;

  /// No description provided for @directChatError.
  ///
  /// In en, this message translates to:
  /// **'Error occurred: {error}'**
  String directChatError(Object error);

  /// No description provided for @directChatAttachFile.
  ///
  /// In en, this message translates to:
  /// **'Attach'**
  String get directChatAttachFile;

  /// No description provided for @directChatFileUploadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload file: {error}'**
  String directChatFileUploadError(Object error);

  /// No description provided for @directChatAttachImage.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get directChatAttachImage;

  /// No description provided for @directChatImageUploadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload image: {error}'**
  String directChatImageUploadError(Object error);

  /// No description provided for @directChatImageLabel.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get directChatImageLabel;

  /// No description provided for @directChatMessagePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get directChatMessagePlaceholder;

  /// No description provided for @directChatMessageDeleted.
  ///
  /// In en, this message translates to:
  /// **'This message was deleted'**
  String get directChatMessageDeleted;

  /// No description provided for @directChatMessageEdited.
  ///
  /// In en, this message translates to:
  /// **'edited'**
  String get directChatMessageEdited;

  /// No description provided for @directChatEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Message'**
  String get directChatEditTitle;

  /// No description provided for @directChatEditPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'New message'**
  String get directChatEditPlaceholder;

  /// No description provided for @directChatEditSuccess.
  ///
  /// In en, this message translates to:
  /// **'Edited'**
  String get directChatEditSuccess;

  /// No description provided for @directChatEditError.
  ///
  /// In en, this message translates to:
  /// **'Edit failed'**
  String get directChatEditError;

  /// No description provided for @directChatDeleteMessageTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Message'**
  String get directChatDeleteMessageTitle;

  /// No description provided for @directChatDeleteMessageConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this message?'**
  String get directChatDeleteMessageConfirm;

  /// No description provided for @directChatDeleteMessageSuccess.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get directChatDeleteMessageSuccess;

  /// No description provided for @directChatDeleteMessageError.
  ///
  /// In en, this message translates to:
  /// **'Delete failed'**
  String get directChatDeleteMessageError;

  /// No description provided for @directMessagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get directMessagesTitle;

  /// No description provided for @directMessagesLoginRequired.
  ///
  /// In en, this message translates to:
  /// **'Please login'**
  String get directMessagesLoginRequired;

  /// No description provided for @directMessagesSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search in messages...'**
  String get directMessagesSearchPlaceholder;

  /// No description provided for @directMessagesSearchCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel search'**
  String get directMessagesSearchCancel;

  /// No description provided for @directMessagesSearchTooltip.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get directMessagesSearchTooltip;

  /// No description provided for @directMessagesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No conversations yet'**
  String get directMessagesEmpty;

  /// No description provided for @directMessagesNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get directMessagesNoResults;

  /// No description provided for @directMessagesNoResultsHint.
  ///
  /// In en, this message translates to:
  /// **'Try different search terms'**
  String get directMessagesNoResultsHint;

  /// No description provided for @directMessagesEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Start a new conversation from members list'**
  String get directMessagesEmptyHint;

  /// No description provided for @directMessagesArchiveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get directMessagesArchiveSuccess;

  /// No description provided for @directMessagesMuteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Notifications muted'**
  String get directMessagesMuteSuccess;

  /// No description provided for @directMessagesUnmuteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Unmuted'**
  String get directMessagesUnmuteSuccess;

  /// No description provided for @directMessagesNewChatTooltip.
  ///
  /// In en, this message translates to:
  /// **'New conversation'**
  String get directMessagesNewChatTooltip;

  /// No description provided for @directMessagesError.
  ///
  /// In en, this message translates to:
  /// **'Error occurred: {error}'**
  String directMessagesError(Object error);

  /// No description provided for @directMessagesUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get directMessagesUser;

  /// No description provided for @directMessagesNoMessages.
  ///
  /// In en, this message translates to:
  /// **'No messages'**
  String get directMessagesNoMessages;

  /// No description provided for @superAdminDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Super Admin'**
  String get superAdminDashboardTitle;

  /// No description provided for @superAdminDashboardHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get superAdminDashboardHome;

  /// No description provided for @superAdminDashboardUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized (Super Admin only)'**
  String get superAdminDashboardUnauthorized;

  /// No description provided for @superAdminTotalUsers.
  ///
  /// In en, this message translates to:
  /// **'Total Users'**
  String get superAdminTotalUsers;

  /// No description provided for @superAdminTrainers.
  ///
  /// In en, this message translates to:
  /// **'Trainers'**
  String get superAdminTrainers;

  /// No description provided for @superAdminTrainees.
  ///
  /// In en, this message translates to:
  /// **'Trainees'**
  String get superAdminTrainees;

  /// No description provided for @superAdminSystemSettings.
  ///
  /// In en, this message translates to:
  /// **'System Settings'**
  String get superAdminSystemSettings;

  /// No description provided for @superAdminFlags.
  ///
  /// In en, this message translates to:
  /// **'Flags: {count}'**
  String superAdminFlags(Object count);

  /// No description provided for @superAdminThresholds.
  ///
  /// In en, this message translates to:
  /// **'Thresholds: {count}'**
  String superAdminThresholds(Object count);

  /// No description provided for @superAdminNoSettings.
  ///
  /// In en, this message translates to:
  /// **'No settings loaded'**
  String get superAdminNoSettings;

  /// No description provided for @superAdminTenantReads.
  ///
  /// In en, this message translates to:
  /// **'Tenant Reads'**
  String get superAdminTenantReads;

  /// No description provided for @superAdminTenantWrites.
  ///
  /// In en, this message translates to:
  /// **'Tenant Writes'**
  String get superAdminTenantWrites;

  /// No description provided for @superAdminFlagRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Recommendation: Enable reads first, then writes after validating cross-tenant leakage is zero.'**
  String get superAdminFlagRecommendation;

  /// No description provided for @superAdminSettingsError.
  ///
  /// In en, this message translates to:
  /// **'Settings error: {error}'**
  String superAdminSettingsError(Object error);

  /// No description provided for @superAdminUsersFirst50.
  ///
  /// In en, this message translates to:
  /// **'Users (first 50)'**
  String get superAdminUsersFirst50;

  /// No description provided for @superAdminUsersLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error loading users: {error}'**
  String superAdminUsersLoadError(Object error);

  /// No description provided for @superAdminAlerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get superAdminAlerts;

  /// No description provided for @superAdminIntrusionAlerts.
  ///
  /// In en, this message translates to:
  /// **'Intrusion Alerts'**
  String get superAdminIntrusionAlerts;

  /// No description provided for @superAdminPredictiveAlerts.
  ///
  /// In en, this message translates to:
  /// **'Predictive Alerts'**
  String get superAdminPredictiveAlerts;

  /// No description provided for @superAdminIntegrityFlags.
  ///
  /// In en, this message translates to:
  /// **'Integrity Flags'**
  String get superAdminIntegrityFlags;

  /// No description provided for @superAdminAlertError.
  ///
  /// In en, this message translates to:
  /// **'{title} error: {error}'**
  String superAdminAlertError(Object title, Object error);

  /// No description provided for @superAdminNoAlerts.
  ///
  /// In en, this message translates to:
  /// **'No {title}'**
  String superAdminNoAlerts(Object title);

  /// No description provided for @superAdminMoreAlerts.
  ///
  /// In en, this message translates to:
  /// **'+{count} more…'**
  String superAdminMoreAlerts(Object count);

  /// No description provided for @superAdminTenants.
  ///
  /// In en, this message translates to:
  /// **'Tenants'**
  String get superAdminTenants;

  /// No description provided for @superAdminInstitutions.
  ///
  /// In en, this message translates to:
  /// **'Institutions'**
  String get superAdminInstitutions;

  /// No description provided for @superAdminNoInstitutions.
  ///
  /// In en, this message translates to:
  /// **'No institutions'**
  String get superAdminNoInstitutions;

  /// No description provided for @superAdminInstitutionsError.
  ///
  /// In en, this message translates to:
  /// **'Institutions error: {error}'**
  String superAdminInstitutionsError(Object error);

  /// No description provided for @superAdminCompanies.
  ///
  /// In en, this message translates to:
  /// **'Companies'**
  String get superAdminCompanies;

  /// No description provided for @superAdminNoCompanies.
  ///
  /// In en, this message translates to:
  /// **'No companies'**
  String get superAdminNoCompanies;

  /// No description provided for @superAdminCompaniesError.
  ///
  /// In en, this message translates to:
  /// **'Companies error: {error}'**
  String superAdminCompaniesError(Object error);

  /// No description provided for @superAdminCreateInstitution.
  ///
  /// In en, this message translates to:
  /// **'Create Institution'**
  String get superAdminCreateInstitution;

  /// No description provided for @superAdminCreateCompany.
  ///
  /// In en, this message translates to:
  /// **'Create Company'**
  String get superAdminCreateCompany;

  /// No description provided for @superAdminInstitutionDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Institution'**
  String get superAdminInstitutionDialogTitle;

  /// No description provided for @superAdminCompanyDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Company'**
  String get superAdminCompanyDialogTitle;

  /// No description provided for @superAdminNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get superAdminNameLabel;

  /// No description provided for @superAdminNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get superAdminNameRequired;

  /// No description provided for @superAdminPlanTierLabel.
  ///
  /// In en, this message translates to:
  /// **'Plan Tier'**
  String get superAdminPlanTierLabel;

  /// No description provided for @superAdminPlanTierRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get superAdminPlanTierRequired;

  /// No description provided for @superAdminDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get superAdminDialogCancel;

  /// No description provided for @superAdminDialogCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get superAdminDialogCreate;

  /// No description provided for @superAdminInstitutionCreated.
  ///
  /// In en, this message translates to:
  /// **'Institution created'**
  String get superAdminInstitutionCreated;

  /// No description provided for @superAdminCompanyCreated.
  ///
  /// In en, this message translates to:
  /// **'Company created'**
  String get superAdminCompanyCreated;

  /// No description provided for @superAdminCreateError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String superAdminCreateError(Object error);

  /// No description provided for @companyAdminHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get companyAdminHome;

  /// No description provided for @companyAdminError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String companyAdminError(Object error);

  /// No description provided for @orgAdminHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get orgAdminHome;

  /// No description provided for @orgAdminError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String orgAdminError(Object error);

  /// No description provided for @orgAdminLatest.
  ///
  /// In en, this message translates to:
  /// **'Latest: {value}'**
  String orgAdminLatest(Object value);

  /// No description provided for @orgAdminActiveUsers.
  ///
  /// In en, this message translates to:
  /// **'Active Users'**
  String get orgAdminActiveUsers;

  /// No description provided for @orgAdminAvgEventsPerUser7d.
  ///
  /// In en, this message translates to:
  /// **'Avg Events/User (7d)'**
  String get orgAdminAvgEventsPerUser7d;

  /// No description provided for @orgAdminAvgMastery.
  ///
  /// In en, this message translates to:
  /// **'Avg Mastery'**
  String get orgAdminAvgMastery;

  /// No description provided for @orgAdminAvgMasteryDelta14d.
  ///
  /// In en, this message translates to:
  /// **'Avg Mastery Delta (14d)'**
  String get orgAdminAvgMasteryDelta14d;

  /// No description provided for @orgAdminLatest7Days.
  ///
  /// In en, this message translates to:
  /// **'Latest 7 Days'**
  String get orgAdminLatest7Days;

  /// No description provided for @orgAdminDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get orgAdminDate;

  /// No description provided for @orgAdminActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get orgAdminActive;

  /// No description provided for @orgAdminAvgEvPerUsr.
  ///
  /// In en, this message translates to:
  /// **'Avg Ev/Usr'**
  String get orgAdminAvgEvPerUsr;

  /// No description provided for @orgAdminAvgMasteryShort.
  ///
  /// In en, this message translates to:
  /// **'Avg Mast'**
  String get orgAdminAvgMasteryShort;

  /// No description provided for @orgAdminDelta14d.
  ///
  /// In en, this message translates to:
  /// **'Δ14d'**
  String get orgAdminDelta14d;

  /// No description provided for @takeQuizNoQuestions.
  ///
  /// In en, this message translates to:
  /// **'No questions in this quiz yet.'**
  String get takeQuizNoQuestions;

  /// No description provided for @takeQuizQuestionProgress.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String takeQuizQuestionProgress(Object current, Object total);

  /// No description provided for @takeQuizShortAnswerLabel.
  ///
  /// In en, this message translates to:
  /// **'Your short answer'**
  String get takeQuizShortAnswerLabel;

  /// No description provided for @takeQuizEssayAnswerLabel.
  ///
  /// In en, this message translates to:
  /// **'Your essay answer'**
  String get takeQuizEssayAnswerLabel;

  /// No description provided for @takeQuizMatchingSelect.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get takeQuizMatchingSelect;

  /// No description provided for @takeQuizUnsupportedType.
  ///
  /// In en, this message translates to:
  /// **'Unsupported question type yet'**
  String get takeQuizUnsupportedType;

  /// No description provided for @takeQuizPreviousButton.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get takeQuizPreviousButton;

  /// No description provided for @takeQuizNextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get takeQuizNextButton;

  /// No description provided for @takeQuizSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit Answers'**
  String get takeQuizSubmitButton;

  /// No description provided for @takeQuizSubmissionFailed.
  ///
  /// In en, this message translates to:
  /// **'Submission failed: {message}'**
  String takeQuizSubmissionFailed(Object message);

  /// No description provided for @quizResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz Result'**
  String get quizResultsTitle;

  /// No description provided for @quizResultsCompleted.
  ///
  /// In en, this message translates to:
  /// **'You\'ve completed the quiz!'**
  String get quizResultsCompleted;

  /// No description provided for @quizResultsYourScore.
  ///
  /// In en, this message translates to:
  /// **'Your score is:'**
  String get quizResultsYourScore;

  /// No description provided for @quizResultsScoreDisplay.
  ///
  /// In en, this message translates to:
  /// **'{score} / {total}'**
  String quizResultsScoreDisplay(Object score, Object total);

  /// No description provided for @quizResultsBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back to Quiz List'**
  String get quizResultsBackButton;

  /// No description provided for @createQuizTitle.
  ///
  /// In en, this message translates to:
  /// **'Create New Quiz'**
  String get createQuizTitle;

  /// No description provided for @createQuizTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Quiz Title'**
  String get createQuizTitleLabel;

  /// No description provided for @createQuizTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Example: Flutter Basics Quiz'**
  String get createQuizTitleHint;

  /// No description provided for @createQuizTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title for the quiz'**
  String get createQuizTitleRequired;

  /// No description provided for @createQuizNextButton.
  ///
  /// In en, this message translates to:
  /// **'Next: Add Questions'**
  String get createQuizNextButton;

  /// No description provided for @createQuizSuccess.
  ///
  /// In en, this message translates to:
  /// **'Quiz created - Add questions now'**
  String get createQuizSuccess;

  /// No description provided for @createQuizError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String createQuizError(Object error);

  /// No description provided for @addQuestionTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Questions to Quiz'**
  String get addQuestionTitle;

  /// No description provided for @addQuestionNoQuestionsYet.
  ///
  /// In en, this message translates to:
  /// **'No questions added yet.'**
  String get addQuestionNoQuestionsYet;

  /// No description provided for @addQuestionQuestionsAdded.
  ///
  /// In en, this message translates to:
  /// **'Questions added: {count}'**
  String addQuestionQuestionsAdded(Object count);

  /// No description provided for @addQuestionNewQuestion.
  ///
  /// In en, this message translates to:
  /// **'Add new question:'**
  String get addQuestionNewQuestion;

  /// No description provided for @addQuestionTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Question type: '**
  String get addQuestionTypeLabel;

  /// No description provided for @addQuestionTypeMultipleChoice.
  ///
  /// In en, this message translates to:
  /// **'Multiple Choice'**
  String get addQuestionTypeMultipleChoice;

  /// No description provided for @addQuestionTypeShortAnswer.
  ///
  /// In en, this message translates to:
  /// **'Short Answer'**
  String get addQuestionTypeShortAnswer;

  /// No description provided for @addQuestionTypeLongAnswer.
  ///
  /// In en, this message translates to:
  /// **'Long Answer'**
  String get addQuestionTypeLongAnswer;

  /// No description provided for @addQuestionTypeMatching.
  ///
  /// In en, this message translates to:
  /// **'Matching'**
  String get addQuestionTypeMatching;

  /// No description provided for @addQuestionTextLabel.
  ///
  /// In en, this message translates to:
  /// **'Question text'**
  String get addQuestionTextLabel;

  /// No description provided for @addQuestionFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Field required'**
  String get addQuestionFieldRequired;

  /// No description provided for @addQuestionOption1.
  ///
  /// In en, this message translates to:
  /// **'Option 1'**
  String get addQuestionOption1;

  /// No description provided for @addQuestionOption2.
  ///
  /// In en, this message translates to:
  /// **'Option 2'**
  String get addQuestionOption2;

  /// No description provided for @addQuestionOption3.
  ///
  /// In en, this message translates to:
  /// **'Option 3'**
  String get addQuestionOption3;

  /// No description provided for @addQuestionOption4.
  ///
  /// In en, this message translates to:
  /// **'Option 4'**
  String get addQuestionOption4;

  /// No description provided for @addQuestionSelectCorrect.
  ///
  /// In en, this message translates to:
  /// **'Select the correct answer:'**
  String get addQuestionSelectCorrect;

  /// No description provided for @addQuestionMatchingPairs.
  ///
  /// In en, this message translates to:
  /// **'Matching pairs (left ⇄ right):'**
  String get addQuestionMatchingPairs;

  /// No description provided for @addQuestionLeft.
  ///
  /// In en, this message translates to:
  /// **'Left {n}'**
  String addQuestionLeft(Object n);

  /// No description provided for @addQuestionRight.
  ///
  /// In en, this message translates to:
  /// **'Right {n}'**
  String addQuestionRight(Object n);

  /// No description provided for @addQuestionAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add Question'**
  String get addQuestionAddButton;

  /// No description provided for @addQuestionSelectCorrectSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Select the correct answer (Multiple Choice)'**
  String get addQuestionSelectCorrectSnackbar;

  /// No description provided for @addQuestionValidPairsError.
  ///
  /// In en, this message translates to:
  /// **'Enter valid matching pairs (at least 2 pairs with equal counts)'**
  String get addQuestionValidPairsError;

  /// No description provided for @addQuestionError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String addQuestionError(Object error);

  /// No description provided for @wallCommentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get wallCommentsTitle;

  /// No description provided for @wallCommentsReplyAdded.
  ///
  /// In en, this message translates to:
  /// **'Reply added'**
  String get wallCommentsReplyAdded;

  /// No description provided for @wallCommentsCommentAdded.
  ///
  /// In en, this message translates to:
  /// **'Comment added'**
  String get wallCommentsCommentAdded;

  /// No description provided for @wallCommentsError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String wallCommentsError(Object error);

  /// No description provided for @wallCommentsNoCommentsYet.
  ///
  /// In en, this message translates to:
  /// **'No comments yet'**
  String get wallCommentsNoCommentsYet;

  /// No description provided for @wallCommentsBeFirstToComment.
  ///
  /// In en, this message translates to:
  /// **'Be the first to comment!'**
  String get wallCommentsBeFirstToComment;

  /// No description provided for @wallCommentsReplyingTo.
  ///
  /// In en, this message translates to:
  /// **'Replying to {username}'**
  String wallCommentsReplyingTo(Object username);

  /// No description provided for @wallCommentsReplyPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write your reply...'**
  String get wallCommentsReplyPlaceholder;

  /// No description provided for @wallCommentsCommentPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write a comment...'**
  String get wallCommentsCommentPlaceholder;

  /// No description provided for @wallCommentsCommentEdited.
  ///
  /// In en, this message translates to:
  /// **'Comment edited'**
  String get wallCommentsCommentEdited;

  /// No description provided for @wallCommentsHideReplies.
  ///
  /// In en, this message translates to:
  /// **'Hide replies'**
  String get wallCommentsHideReplies;

  /// No description provided for @wallCommentsShowReplies.
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, =1{reply} other{replies}}'**
  String wallCommentsShowReplies(num count);

  /// No description provided for @recommendationDismissTooltip.
  ///
  /// In en, this message translates to:
  /// **'Dismiss recommendation'**
  String get recommendationDismissTooltip;

  /// No description provided for @recommendationHighPriority.
  ///
  /// In en, this message translates to:
  /// **'High priority'**
  String get recommendationHighPriority;

  /// No description provided for @recommendationConfidence.
  ///
  /// In en, this message translates to:
  /// **'{percent}% confidence'**
  String recommendationConfidence(Object percent);

  /// No description provided for @recommendationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes'**
  String recommendationMinutes(Object minutes);

  /// No description provided for @recommendationReasonWeakPerformance.
  ///
  /// In en, this message translates to:
  /// **'To improve performance'**
  String get recommendationReasonWeakPerformance;

  /// No description provided for @recommendationReasonInterests.
  ///
  /// In en, this message translates to:
  /// **'Based on your interests'**
  String get recommendationReasonInterests;

  /// No description provided for @recommendationReasonNextStep.
  ///
  /// In en, this message translates to:
  /// **'Next step'**
  String get recommendationReasonNextStep;

  /// No description provided for @recommendationReasonSkillGap.
  ///
  /// In en, this message translates to:
  /// **'To fill a skill gap'**
  String get recommendationReasonSkillGap;

  /// No description provided for @recommendationReasonPopularWithPeers.
  ///
  /// In en, this message translates to:
  /// **'Popular among your peers'**
  String get recommendationReasonPopularWithPeers;

  /// No description provided for @recommendationReasonPathCompletion.
  ///
  /// In en, this message translates to:
  /// **'To complete the path'**
  String get recommendationReasonPathCompletion;

  /// No description provided for @recommendationReasonStrengthenSkill.
  ///
  /// In en, this message translates to:
  /// **'To strengthen your skills'**
  String get recommendationReasonStrengthenSkill;

  /// No description provided for @recommendationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No recommendations currently'**
  String get recommendationsEmpty;

  /// No description provided for @recommendationsEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'We will create personalized recommendations for you soon'**
  String get recommendationsEmptyHint;

  /// No description provided for @recommendationsOpenSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Opened: {title}'**
  String recommendationsOpenSnackbar(Object title);

  /// No description provided for @recommendationsDismissedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Recommendation dismissed'**
  String get recommendationsDismissedSnackbar;

  /// No description provided for @recommendationsError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred loading recommendations'**
  String get recommendationsError;

  /// No description provided for @networkStatusOfflineBanner.
  ///
  /// In en, this message translates to:
  /// **'No internet connection - Working offline'**
  String get networkStatusOfflineBanner;

  /// No description provided for @networkStatusOfflineMessage.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Check your connection and try again.'**
  String get networkStatusOfflineMessage;

  /// No description provided for @networkStatusPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have permission to access this data'**
  String get networkStatusPermissionDenied;

  /// No description provided for @networkStatusNotFound.
  ///
  /// In en, this message translates to:
  /// **'The requested data was not found'**
  String get networkStatusNotFound;

  /// No description provided for @networkStatusUnknownError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Try again.'**
  String get networkStatusUnknownError;

  /// No description provided for @networkStatusRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get networkStatusRetryButton;

  /// No description provided for @commentReactionLoginRequired.
  ///
  /// In en, this message translates to:
  /// **'You must log in to react'**
  String get commentReactionLoginRequired;

  /// No description provided for @commentReactionPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your reaction'**
  String get commentReactionPickerTitle;

  /// No description provided for @progressCardNextLevel.
  ///
  /// In en, this message translates to:
  /// **'Next Level'**
  String get progressCardNextLevel;

  /// No description provided for @progressCardMaxLevel.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You\'ve reached the maximum level 🎉'**
  String get progressCardMaxLevel;

  /// No description provided for @progressCardEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Start your learning journey!'**
  String get progressCardEmptyTitle;

  /// No description provided for @progressCardEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Complete lessons and quizzes to earn points'**
  String get progressCardEmptyHint;

  /// No description provided for @progressCardError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred loading progress'**
  String get progressCardError;

  /// No description provided for @messageListEmpty.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get messageListEmpty;

  /// No description provided for @messageListEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Start the conversation by sending a message'**
  String get messageListEmptyHint;

  /// No description provided for @messageBubbleYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday {time}'**
  String messageBubbleYesterday(Object time);

  /// No description provided for @chatInputPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get chatInputPlaceholder;

  /// No description provided for @messageBubbleEdited.
  ///
  /// In en, this message translates to:
  /// **'(edited)'**
  String get messageBubbleEdited;

  /// No description provided for @messageSearchError.
  ///
  /// In en, this message translates to:
  /// **'Search error: {error}'**
  String messageSearchError(Object error);

  /// No description provided for @messageSearchPlaceholderRoom.
  ///
  /// In en, this message translates to:
  /// **'Search in this conversation...'**
  String get messageSearchPlaceholderRoom;

  /// No description provided for @messageSearchPlaceholderAll.
  ///
  /// In en, this message translates to:
  /// **'Search in all messages...'**
  String get messageSearchPlaceholderAll;

  /// No description provided for @messageSearchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search in messages'**
  String get messageSearchTitle;

  /// No description provided for @messageSearchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get messageSearchNoResults;

  /// No description provided for @messageSearchNoResultsHint.
  ///
  /// In en, this message translates to:
  /// **'Try different search terms'**
  String get messageSearchNoResultsHint;

  /// No description provided for @messageSearchResultsCount.
  ///
  /// In en, this message translates to:
  /// **'Results: {count}'**
  String messageSearchResultsCount(Object count);

  /// No description provided for @messageSearchEdited.
  ///
  /// In en, this message translates to:
  /// **'edited'**
  String get messageSearchEdited;

  /// No description provided for @messageSearchDefaultRoom.
  ///
  /// In en, this message translates to:
  /// **'conversation'**
  String get messageSearchDefaultRoom;

  /// No description provided for @messageSearchTooltip.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get messageSearchTooltip;

  /// No description provided for @messageThreadTitle.
  ///
  /// In en, this message translates to:
  /// **'Replies'**
  String get messageThreadTitle;

  /// No description provided for @messageThreadParentNotFound.
  ///
  /// In en, this message translates to:
  /// **'Message not found'**
  String get messageThreadParentNotFound;

  /// No description provided for @messageThreadUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'User data not found'**
  String get messageThreadUserNotFound;

  /// No description provided for @messageThreadSendFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send reply'**
  String get messageThreadSendFailed;

  /// No description provided for @messageThreadNoReplies.
  ///
  /// In en, this message translates to:
  /// **'No replies yet'**
  String get messageThreadNoReplies;

  /// No description provided for @messageThreadError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String messageThreadError(Object error);

  /// No description provided for @messageThreadReplyPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Type your reply...'**
  String get messageThreadReplyPlaceholder;

  /// No description provided for @messageThreadReplySingular.
  ///
  /// In en, this message translates to:
  /// **'reply'**
  String get messageThreadReplySingular;

  /// No description provided for @messageThreadReplyPlural.
  ///
  /// In en, this message translates to:
  /// **'replies'**
  String get messageThreadReplyPlural;

  /// No description provided for @messageThreadLastReply.
  ///
  /// In en, this message translates to:
  /// **'Last reply: {author}'**
  String messageThreadLastReply(Object author);

  /// No description provided for @userPickerError.
  ///
  /// In en, this message translates to:
  /// **'Error creating conversation'**
  String get userPickerError;

  /// No description provided for @userPickerLoginRequired.
  ///
  /// In en, this message translates to:
  /// **'Please log in'**
  String get userPickerLoginRequired;

  /// No description provided for @userPickerLoadError.
  ///
  /// In en, this message translates to:
  /// **'Cannot load user data'**
  String get userPickerLoadError;

  /// No description provided for @userPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a user to chat with'**
  String get userPickerTitle;

  /// No description provided for @userPickerSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a user...'**
  String get userPickerSearchHint;

  /// No description provided for @userPickerNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get userPickerNoResults;

  /// No description provided for @userPickerNoUsers.
  ///
  /// In en, this message translates to:
  /// **'No users'**
  String get userPickerNoUsers;

  /// No description provided for @userPickerNoResultsHint.
  ///
  /// In en, this message translates to:
  /// **'Try different search terms'**
  String get userPickerNoResultsHint;

  /// No description provided for @userPickerNoUsersHint.
  ///
  /// In en, this message translates to:
  /// **'No other users in your institution'**
  String get userPickerNoUsersHint;

  /// No description provided for @userPickerErrorWithDetails.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String userPickerErrorWithDetails(Object error);

  /// No description provided for @userPickerRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get userPickerRetry;

  /// No description provided for @userPickerRoleManager.
  ///
  /// In en, this message translates to:
  /// **'Manager'**
  String get userPickerRoleManager;

  /// No description provided for @userPickerRoleTrainer.
  ///
  /// In en, this message translates to:
  /// **'Trainer'**
  String get userPickerRoleTrainer;

  /// No description provided for @userPickerRoleTrainee.
  ///
  /// In en, this message translates to:
  /// **'Trainee'**
  String get userPickerRoleTrainee;

  /// No description provided for @quizSubmissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Submissions: {quizTitle}'**
  String quizSubmissionsTitle(Object quizTitle);

  /// No description provided for @personalProfileUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Image upload failed: {error}'**
  String personalProfileUploadFailed(Object error);

  /// No description provided for @personalProfileSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get personalProfileSaved;

  /// No description provided for @personalProfileSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {error}'**
  String personalProfileSaveFailed(Object error);

  /// No description provided for @settingsArabicLabel.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get settingsArabicLabel;

  /// No description provided for @privacyPolicyLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load privacy policy: {error}'**
  String privacyPolicyLoadFailed(Object error);

  /// No description provided for @termsOfServiceLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load terms of service: {error}'**
  String termsOfServiceLoadFailed(Object error);

  /// No description provided for @traineeListTitle.
  ///
  /// In en, this message translates to:
  /// **'Trainees'**
  String get traineeListTitle;

  /// No description provided for @traineeListEmpty.
  ///
  /// In en, this message translates to:
  /// **'No trainees in this course yet.'**
  String get traineeListEmpty;

  /// No description provided for @resourceLibraryUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'File upload failed: {error}'**
  String resourceLibraryUploadFailed(Object error);

  /// No description provided for @resourceLibraryDefaultCourseName.
  ///
  /// In en, this message translates to:
  /// **'Course'**
  String get resourceLibraryDefaultCourseName;

  /// No description provided for @resourceLibraryNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'New file in: {courseName}'**
  String resourceLibraryNotificationTitle(Object courseName);

  /// No description provided for @resourceLibraryNotificationContent.
  ///
  /// In en, this message translates to:
  /// **'New file added with title: {fileName}'**
  String resourceLibraryNotificationContent(Object fileName);

  /// No description provided for @resourceLibraryCannotOpen.
  ///
  /// In en, this message translates to:
  /// **'Cannot open this file: {fileUrl}'**
  String resourceLibraryCannotOpen(Object fileUrl);

  /// No description provided for @resourceLibraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Resource Library'**
  String get resourceLibraryTitle;

  /// No description provided for @resourceLibraryError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Make sure to create the required index.\\n\\n{error}'**
  String resourceLibraryError(Object error);

  /// No description provided for @resourceLibraryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No files in the library yet.'**
  String get resourceLibraryEmpty;

  /// No description provided for @resourceLibraryUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get resourceLibraryUploading;

  /// No description provided for @resourceLibraryUploadButton.
  ///
  /// In en, this message translates to:
  /// **'Upload File'**
  String get resourceLibraryUploadButton;

  /// No description provided for @quizListTitle.
  ///
  /// In en, this message translates to:
  /// **'Quizzes'**
  String get quizListTitle;

  /// No description provided for @quizListError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Make sure to create the required index.\\n\\n{error}'**
  String quizListError(Object error);

  /// No description provided for @quizListEmpty.
  ///
  /// In en, this message translates to:
  /// **'No quizzes created yet.'**
  String get quizListEmpty;

  /// No description provided for @quizListViewSubmissions.
  ///
  /// In en, this message translates to:
  /// **'View submissions'**
  String get quizListViewSubmissions;

  /// No description provided for @quizListCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create Quiz'**
  String get quizListCreateButton;

  /// No description provided for @quizSubmissionsError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Make sure to create the required index.\\n\\n{error}'**
  String quizSubmissionsError(Object error);

  /// No description provided for @quizSubmissionsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No trainee has submitted this quiz yet.'**
  String get quizSubmissionsEmpty;

  /// No description provided for @quizSubmissionsResultFormat.
  ///
  /// In en, this message translates to:
  /// **'Score: {score} out of {total}\\nSubmitted on: {date}'**
  String quizSubmissionsResultFormat(Object score, Object total, Object date);

  /// No description provided for @traineeListLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get traineeListLoading;

  /// No description provided for @traineeListNotFound.
  ///
  /// In en, this message translates to:
  /// **'Trainee not found: {traineeId}'**
  String traineeListNotFound(Object traineeId);

  /// No description provided for @traineeListUnknownEmail.
  ///
  /// In en, this message translates to:
  /// **'Unknown email'**
  String get traineeListUnknownEmail;

  /// No description provided for @personalProfileSectionData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get personalProfileSectionData;

  /// No description provided for @personalProfileNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get personalProfileNameLabel;

  /// No description provided for @personalProfileNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get personalProfileNameRequired;

  /// No description provided for @personalProfileEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get personalProfileEmailLabel;

  /// No description provided for @personalProfileStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get personalProfileStatsTitle;

  /// No description provided for @personalProfileAchievementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get personalProfileAchievementsTitle;

  /// No description provided for @personalProfileRecentActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent activity'**
  String get personalProfileRecentActivityTitle;

  /// No description provided for @personalProfileTrainerStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Training statistics'**
  String get personalProfileTrainerStatsTitle;

  /// No description provided for @personalProfileSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get personalProfileSaveButton;

  /// No description provided for @personalProfileRoleTrainee.
  ///
  /// In en, this message translates to:
  /// **'Trainee'**
  String get personalProfileRoleTrainee;

  /// No description provided for @personalProfileRoleTrainer.
  ///
  /// In en, this message translates to:
  /// **'Trainer'**
  String get personalProfileRoleTrainer;

  /// No description provided for @personalProfilePointsLabelShort.
  ///
  /// In en, this message translates to:
  /// **'Points: {points}'**
  String personalProfilePointsLabelShort(Object points);

  /// No description provided for @personalProfileAuthError.
  ///
  /// In en, this message translates to:
  /// **'Auth error: {error}'**
  String personalProfileAuthError(Object error);

  /// No description provided for @personalProfileLoginRequired.
  ///
  /// In en, this message translates to:
  /// **'Please log in'**
  String get personalProfileLoginRequired;

  /// No description provided for @personalProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal profile'**
  String get personalProfileTitle;

  /// No description provided for @personalProfileDataLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String personalProfileDataLoadError(Object error);

  /// No description provided for @personalProfileActivitiesLabel.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get personalProfileActivitiesLabel;

  /// No description provided for @personalProfileEvaluationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Evaluations'**
  String get personalProfileEvaluationsLabel;

  /// No description provided for @personalProfileEvaluationsGivenLabel.
  ///
  /// In en, this message translates to:
  /// **'Evaluations you gave'**
  String get personalProfileEvaluationsGivenLabel;

  /// No description provided for @personalProfileSinceLabel.
  ///
  /// In en, this message translates to:
  /// **'Since'**
  String get personalProfileSinceLabel;

  /// No description provided for @personalProfilePointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get personalProfilePointsLabel;

  /// No description provided for @personalProfileNoBadges.
  ///
  /// In en, this message translates to:
  /// **'No badges yet'**
  String get personalProfileNoBadges;

  /// No description provided for @personalProfileActivityLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load activity: {error}'**
  String personalProfileActivityLoadError(Object error);

  /// No description provided for @personalProfileNoRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'No recent activity yet'**
  String get personalProfileNoRecentActivity;

  /// No description provided for @personalProfilePointsCountFormat.
  ///
  /// In en, this message translates to:
  /// **'{points} points'**
  String personalProfilePointsCountFormat(Object points);

  /// No description provided for @personalProfileEventTestPassed.
  ///
  /// In en, this message translates to:
  /// **'Test passed'**
  String get personalProfileEventTestPassed;

  /// No description provided for @personalProfileEventTaskCompleted.
  ///
  /// In en, this message translates to:
  /// **'Task completed'**
  String get personalProfileEventTaskCompleted;

  /// No description provided for @personalProfileEventLessonCompleted.
  ///
  /// In en, this message translates to:
  /// **'Lesson completed'**
  String get personalProfileEventLessonCompleted;

  /// No description provided for @personalProfileEventDailyStreak.
  ///
  /// In en, this message translates to:
  /// **'Daily streak'**
  String get personalProfileEventDailyStreak;

  /// No description provided for @personalProfileEventDefault.
  ///
  /// In en, this message translates to:
  /// **'Point event'**
  String get personalProfileEventDefault;

  /// No description provided for @trainerStatsCoursesLabel.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get trainerStatsCoursesLabel;

  /// No description provided for @trainerStatsEvaluationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Evaluations'**
  String get trainerStatsEvaluationsLabel;

  /// No description provided for @achievementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsTitle;

  /// No description provided for @achievementsMustLogin.
  ///
  /// In en, this message translates to:
  /// **'You must log in first'**
  String get achievementsMustLogin;

  /// No description provided for @achievementsFilterByCategory.
  ///
  /// In en, this message translates to:
  /// **'Filter by Category'**
  String get achievementsFilterByCategory;

  /// No description provided for @achievementsAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get achievementsAll;

  /// No description provided for @achievementsSecretAchievement.
  ///
  /// In en, this message translates to:
  /// **'Secret Achievement'**
  String get achievementsSecretAchievement;

  /// No description provided for @achievementsPoints.
  ///
  /// In en, this message translates to:
  /// **'{points} points'**
  String achievementsPoints(Object points);

  /// No description provided for @achievementsUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked ✓'**
  String get achievementsUnlocked;

  /// No description provided for @achievementsLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked 🔒'**
  String get achievementsLocked;

  /// No description provided for @achievementsUnlockedOn.
  ///
  /// In en, this message translates to:
  /// **'Unlocked: {date}'**
  String achievementsUnlockedOn(Object date);

  /// No description provided for @achievementsThisIsSecret.
  ///
  /// In en, this message translates to:
  /// **'This is a secret achievement! 🤫'**
  String get achievementsThisIsSecret;

  /// No description provided for @achievementsWillDiscoverWhenUnlock.
  ///
  /// In en, this message translates to:
  /// **'You\'ll discover it when you unlock it'**
  String get achievementsWillDiscoverWhenUnlock;

  /// No description provided for @achievementsClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get achievementsClose;

  /// No description provided for @achievementsNoAchievementsYet.
  ///
  /// In en, this message translates to:
  /// **'No achievements yet'**
  String get achievementsNoAchievementsYet;

  /// No description provided for @achievementsLoadError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading achievements'**
  String get achievementsLoadError;

  /// No description provided for @achievementsRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get achievementsRetry;

  /// No description provided for @achievementsStatUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get achievementsStatUnlocked;

  /// No description provided for @achievementsStatPercentage.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get achievementsStatPercentage;

  /// No description provided for @achievementsStatRemaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get achievementsStatRemaining;

  /// No description provided for @achievementsSecretLocked.
  ///
  /// In en, this message translates to:
  /// **'Secret achievement 🔒'**
  String get achievementsSecretLocked;

  /// No description provided for @analyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analyticsTitle;

  /// No description provided for @analyticsOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get analyticsOverview;

  /// No description provided for @analyticsTotalStudents.
  ///
  /// In en, this message translates to:
  /// **'Total Students'**
  String get analyticsTotalStudents;

  /// No description provided for @analyticsActiveStudents.
  ///
  /// In en, this message translates to:
  /// **'Active Students'**
  String get analyticsActiveStudents;

  /// No description provided for @analyticsAvgPoints.
  ///
  /// In en, this message translates to:
  /// **'Avg Points'**
  String get analyticsAvgPoints;

  /// No description provided for @analyticsAvgLevel.
  ///
  /// In en, this message translates to:
  /// **'Avg Level'**
  String get analyticsAvgLevel;

  /// No description provided for @analyticsEngagementRate.
  ///
  /// In en, this message translates to:
  /// **'Engagement Rate'**
  String get analyticsEngagementRate;

  /// No description provided for @analyticsEngagementPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of students are active'**
  String analyticsEngagementPercent(Object percent);

  /// No description provided for @analyticsActiveOf.
  ///
  /// In en, this message translates to:
  /// **'Active: {active} of {total}'**
  String analyticsActiveOf(Object active, Object total);

  /// No description provided for @analyticsTopStudents.
  ///
  /// In en, this message translates to:
  /// **'Top Students'**
  String get analyticsTopStudents;

  /// No description provided for @analyticsNoStudents.
  ///
  /// In en, this message translates to:
  /// **'No students yet'**
  String get analyticsNoStudents;

  /// No description provided for @analyticsLevel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String analyticsLevel(Object level);

  /// No description provided for @analyticsPointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get analyticsPointsLabel;

  /// No description provided for @analyticsPointsStats.
  ///
  /// In en, this message translates to:
  /// **'Points Statistics'**
  String get analyticsPointsStats;

  /// No description provided for @analyticsPointsAwarded.
  ///
  /// In en, this message translates to:
  /// **'Points Awarded'**
  String get analyticsPointsAwarded;

  /// No description provided for @analyticsAchievementsUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Achievements Unlocked'**
  String get analyticsAchievementsUnlocked;

  /// No description provided for @analyticsLoadError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading analytics'**
  String get analyticsLoadError;

  /// No description provided for @analyticsRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get analyticsRetry;

  /// No description provided for @gamificationSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Points Settings'**
  String get gamificationSettingsTitle;

  /// No description provided for @gamificationSettingsSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get gamificationSettingsSave;

  /// No description provided for @gamificationSettingsLoadError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading settings'**
  String get gamificationSettingsLoadError;

  /// No description provided for @gamificationSettingsUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized'**
  String get gamificationSettingsUnauthorized;

  /// No description provided for @gamificationSettingsSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'✅ Settings saved successfully'**
  String get gamificationSettingsSaveSuccess;

  /// No description provided for @gamificationSettingsSaveError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while saving settings: {error}'**
  String gamificationSettingsSaveError(Object error);

  /// No description provided for @gamificationSettingsEnableSystem.
  ///
  /// In en, this message translates to:
  /// **'Enable Points System'**
  String get gamificationSettingsEnableSystem;

  /// No description provided for @gamificationSettingsDisableNote.
  ///
  /// In en, this message translates to:
  /// **'If disabled, no points will be awarded'**
  String get gamificationSettingsDisableNote;

  /// No description provided for @gamificationSettingsCoreActivities.
  ///
  /// In en, this message translates to:
  /// **'Core Activities (Mandatory)'**
  String get gamificationSettingsCoreActivities;

  /// No description provided for @gamificationSettingsCoreNote.
  ///
  /// In en, this message translates to:
  /// **'These activities are always enabled'**
  String get gamificationSettingsCoreNote;

  /// No description provided for @gamificationSettingsCompleteLesson.
  ///
  /// In en, this message translates to:
  /// **'Complete Lesson'**
  String get gamificationSettingsCompleteLesson;

  /// No description provided for @gamificationSettingsPassQuiz.
  ///
  /// In en, this message translates to:
  /// **'Pass Quiz'**
  String get gamificationSettingsPassQuiz;

  /// No description provided for @gamificationSettingsPerfectQuiz.
  ///
  /// In en, this message translates to:
  /// **'Perfect Quiz Score'**
  String get gamificationSettingsPerfectQuiz;

  /// No description provided for @gamificationSettingsCompleteTask.
  ///
  /// In en, this message translates to:
  /// **'Complete Task'**
  String get gamificationSettingsCompleteTask;

  /// No description provided for @gamificationSettingsCompleteModule.
  ///
  /// In en, this message translates to:
  /// **'Complete Module'**
  String get gamificationSettingsCompleteModule;

  /// No description provided for @gamificationSettingsEnableSocial.
  ///
  /// In en, this message translates to:
  /// **'Enable Social Interaction Points'**
  String get gamificationSettingsEnableSocial;

  /// No description provided for @gamificationSettingsSocialNote.
  ///
  /// In en, this message translates to:
  /// **'Posts and Comments'**
  String get gamificationSettingsSocialNote;

  /// No description provided for @gamificationSettingsCreatePost.
  ///
  /// In en, this message translates to:
  /// **'Create Post'**
  String get gamificationSettingsCreatePost;

  /// No description provided for @gamificationSettingsWriteComment.
  ///
  /// In en, this message translates to:
  /// **'Write Comment'**
  String get gamificationSettingsWriteComment;

  /// No description provided for @gamificationSettingsHelpPeer.
  ///
  /// In en, this message translates to:
  /// **'Help Peer'**
  String get gamificationSettingsHelpPeer;

  /// No description provided for @gamificationSettingsGetReaction.
  ///
  /// In en, this message translates to:
  /// **'Get Reaction'**
  String get gamificationSettingsGetReaction;

  /// No description provided for @gamificationSettingsEnableStreak.
  ///
  /// In en, this message translates to:
  /// **'Enable Daily Login Streak'**
  String get gamificationSettingsEnableStreak;

  /// No description provided for @gamificationSettingsStreakNote.
  ///
  /// In en, this message translates to:
  /// **'Encourage continuous login'**
  String get gamificationSettingsStreakNote;

  /// No description provided for @gamificationSettingsDailyLogin.
  ///
  /// In en, this message translates to:
  /// **'Daily Login'**
  String get gamificationSettingsDailyLogin;

  /// No description provided for @gamificationSettingsWeekStreak.
  ///
  /// In en, this message translates to:
  /// **'Weekly Streak'**
  String get gamificationSettingsWeekStreak;

  /// No description provided for @gamificationSettingsSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get gamificationSettingsSaveButton;

  /// No description provided for @gamificationSettingsResetDefaults.
  ///
  /// In en, this message translates to:
  /// **'Reset to Defaults'**
  String get gamificationSettingsResetDefaults;

  /// No description provided for @gamificationSettingsResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Default values restored'**
  String get gamificationSettingsResetSuccess;

  /// No description provided for @gamificationSettingsPointsLabel.
  ///
  /// In en, this message translates to:
  /// **'{points} points'**
  String gamificationSettingsPointsLabel(Object points);

  /// No description provided for @moduleDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Module Details'**
  String get moduleDetailTitle;

  /// No description provided for @moduleDetailError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String moduleDetailError(Object error);

  /// No description provided for @moduleDetailRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get moduleDetailRetry;

  /// No description provided for @moduleDetailProgressError.
  ///
  /// In en, this message translates to:
  /// **'Error loading progress: {error}'**
  String moduleDetailProgressError(Object error);

  /// No description provided for @moduleDetailDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get moduleDetailDescription;

  /// No description provided for @moduleDetailContents.
  ///
  /// In en, this message translates to:
  /// **'Module Contents'**
  String get moduleDetailContents;

  /// No description provided for @moduleDetailCompleteForPoints.
  ///
  /// In en, this message translates to:
  /// **'Complete all contents to get {points} points'**
  String moduleDetailCompleteForPoints(Object points);

  /// No description provided for @moduleDetailModuleCompleted.
  ///
  /// In en, this message translates to:
  /// **'Module Completed! 🎉'**
  String get moduleDetailModuleCompleted;

  /// No description provided for @moduleDetailEarnedPoints.
  ///
  /// In en, this message translates to:
  /// **'You earned {points} points'**
  String moduleDetailEarnedPoints(Object points);

  /// No description provided for @moduleDetailCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get moduleDetailCompleted;

  /// No description provided for @moduleDetailProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get moduleDetailProgress;

  /// No description provided for @moduleDetailPointsOnCompletion.
  ///
  /// In en, this message translates to:
  /// **'{points} points on completion'**
  String moduleDetailPointsOnCompletion(Object points);

  /// No description provided for @moduleDetailUnmarkedComplete.
  ///
  /// In en, this message translates to:
  /// **'Unmarked content as completed'**
  String get moduleDetailUnmarkedComplete;

  /// No description provided for @moduleDetailMarkedComplete.
  ///
  /// In en, this message translates to:
  /// **'Marked content as completed ✓'**
  String get moduleDetailMarkedComplete;

  /// No description provided for @moduleDetailMarkError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String moduleDetailMarkError(Object error);

  /// No description provided for @moduleDetailRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get moduleDetailRequired;

  /// No description provided for @moduleDetailTypeLesson.
  ///
  /// In en, this message translates to:
  /// **'Lesson'**
  String get moduleDetailTypeLesson;

  /// No description provided for @moduleDetailTypeQuiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get moduleDetailTypeQuiz;

  /// No description provided for @moduleDetailTypeAssignment.
  ///
  /// In en, this message translates to:
  /// **'Assignment'**
  String get moduleDetailTypeAssignment;

  /// No description provided for @moduleDetailTypeResource.
  ///
  /// In en, this message translates to:
  /// **'Resource'**
  String get moduleDetailTypeResource;

  /// No description provided for @anomalyDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Anomaly Detection'**
  String get anomalyDashboardTitle;

  /// No description provided for @anomalyDashboardMustLogin.
  ///
  /// In en, this message translates to:
  /// **'Must be logged in'**
  String get anomalyDashboardMustLogin;

  /// No description provided for @anomalyDashboardFilterStatus.
  ///
  /// In en, this message translates to:
  /// **'Filter by status'**
  String get anomalyDashboardFilterStatus;

  /// No description provided for @anomalyDashboardAllStates.
  ///
  /// In en, this message translates to:
  /// **'All States'**
  String get anomalyDashboardAllStates;

  /// No description provided for @anomalyDashboardPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get anomalyDashboardPending;

  /// No description provided for @anomalyDashboardInvestigating.
  ///
  /// In en, this message translates to:
  /// **'Investigating'**
  String get anomalyDashboardInvestigating;

  /// No description provided for @anomalyDashboardResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get anomalyDashboardResolved;

  /// No description provided for @anomalyDashboardTabAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get anomalyDashboardTabAll;

  /// No description provided for @anomalyDashboardTabHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get anomalyDashboardTabHigh;

  /// No description provided for @anomalyDashboardTabAlerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get anomalyDashboardTabAlerts;

  /// No description provided for @anomalyDashboardNoAnomalies.
  ///
  /// In en, this message translates to:
  /// **'No anomalies detected'**
  String get anomalyDashboardNoAnomalies;

  /// No description provided for @anomalyDashboardSystemNormal.
  ///
  /// In en, this message translates to:
  /// **'System operating normally'**
  String get anomalyDashboardSystemNormal;

  /// No description provided for @anomalyDashboardError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String anomalyDashboardError(Object error);

  /// No description provided for @anomalyDashboardNoHighRisk.
  ///
  /// In en, this message translates to:
  /// **'No high-risk anomalies'**
  String get anomalyDashboardNoHighRisk;

  /// No description provided for @anomalyDashboardNoAlerts.
  ///
  /// In en, this message translates to:
  /// **'No alerts'**
  String get anomalyDashboardNoAlerts;

  /// No description provided for @anomalyDashboardReviewSuccess.
  ///
  /// In en, this message translates to:
  /// **'Reviewed successfully'**
  String get anomalyDashboardReviewSuccess;

  /// No description provided for @anomalyDashboardReviewFailed.
  ///
  /// In en, this message translates to:
  /// **'Review failed'**
  String get anomalyDashboardReviewFailed;

  /// No description provided for @anomalyDashboardReviewButton.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get anomalyDashboardReviewButton;

  /// No description provided for @anomalyDashboardType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get anomalyDashboardType;

  /// No description provided for @anomalyDashboardSeverity.
  ///
  /// In en, this message translates to:
  /// **'Severity'**
  String get anomalyDashboardSeverity;

  /// No description provided for @anomalyDashboardStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get anomalyDashboardStatus;

  /// No description provided for @anomalyDashboardUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get anomalyDashboardUser;

  /// No description provided for @anomalyDashboardDetectedAt.
  ///
  /// In en, this message translates to:
  /// **'Detected At'**
  String get anomalyDashboardDetectedAt;

  /// No description provided for @anomalyDashboardDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get anomalyDashboardDescription;

  /// No description provided for @anomalyDashboardActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get anomalyDashboardActions;

  /// No description provided for @anomalyDashboardMarkResolved.
  ///
  /// In en, this message translates to:
  /// **'Mark as Resolved'**
  String get anomalyDashboardMarkResolved;

  /// No description provided for @anomalyDashboardInvestigate.
  ///
  /// In en, this message translates to:
  /// **'Investigate'**
  String get anomalyDashboardInvestigate;

  /// No description provided for @myEvaluationsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Evaluations'**
  String get myEvaluationsTitle;

  /// No description provided for @myEvaluationsToggleView.
  ///
  /// In en, this message translates to:
  /// **'Toggle View'**
  String get myEvaluationsToggleView;

  /// No description provided for @myEvaluationsMustLogin.
  ///
  /// In en, this message translates to:
  /// **'Must log in first'**
  String get myEvaluationsMustLogin;

  /// No description provided for @myEvaluationsNoEvaluations.
  ///
  /// In en, this message translates to:
  /// **'No evaluations added for you yet.'**
  String get myEvaluationsNoEvaluations;

  /// No description provided for @myEvaluationsError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String myEvaluationsError(Object error);

  /// No description provided for @myEvaluationsAuthError.
  ///
  /// In en, this message translates to:
  /// **'Authentication error: {error}'**
  String myEvaluationsAuthError(Object error);

  /// No description provided for @myEvaluationsAudioUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unable to play audio evaluation (link currently unavailable)'**
  String get myEvaluationsAudioUnavailable;

  /// No description provided for @myEvaluationsAudioAccessError.
  ///
  /// In en, this message translates to:
  /// **'Unable to access audio file. Check connection.'**
  String get myEvaluationsAudioAccessError;

  /// No description provided for @myEvaluationsAudioPlayError.
  ///
  /// In en, this message translates to:
  /// **'Audio playback failed: {error}'**
  String myEvaluationsAudioPlayError(Object error);

  /// No description provided for @anomalySettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Anomaly Detection Settings'**
  String get anomalySettingsTitle;

  /// No description provided for @anomalySettingsSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Settings saved successfully'**
  String get anomalySettingsSaveSuccess;

  /// No description provided for @anomalySettingsSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save settings'**
  String get anomalySettingsSaveFailed;

  /// No description provided for @anomalySettingsSaveError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String anomalySettingsSaveError(Object error);

  /// No description provided for @anomalySettingsEnableDetection.
  ///
  /// In en, this message translates to:
  /// **'Enable Anomaly Detection'**
  String get anomalySettingsEnableDetection;

  /// No description provided for @anomalySettingsEnableDetectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Automatically detect abnormal behavior'**
  String get anomalySettingsEnableDetectionSubtitle;

  /// No description provided for @anomalySettingsEnabledTypes.
  ///
  /// In en, this message translates to:
  /// **'Enabled Anomaly Types'**
  String get anomalySettingsEnabledTypes;

  /// No description provided for @anomalySettingsSuspiciousLogin.
  ///
  /// In en, this message translates to:
  /// **'Suspicious Login'**
  String get anomalySettingsSuspiciousLogin;

  /// No description provided for @anomalySettingsSuspiciousLoginDesc.
  ///
  /// In en, this message translates to:
  /// **'Unusual devices or locations'**
  String get anomalySettingsSuspiciousLoginDesc;

  /// No description provided for @anomalySettingsAbnormalScores.
  ///
  /// In en, this message translates to:
  /// **'Abnormal Test Scores'**
  String get anomalySettingsAbnormalScores;

  /// No description provided for @anomalySettingsAbnormalScoresDesc.
  ///
  /// In en, this message translates to:
  /// **'Very high or very low scores'**
  String get anomalySettingsAbnormalScoresDesc;

  /// No description provided for @anomalySettingsRapidProgress.
  ///
  /// In en, this message translates to:
  /// **'Rapid Progress'**
  String get anomalySettingsRapidProgress;

  /// No description provided for @anomalySettingsRapidProgressDesc.
  ///
  /// In en, this message translates to:
  /// **'Completing courses or tests abnormally fast'**
  String get anomalySettingsRapidProgressDesc;

  /// No description provided for @anomalySettingsMultipleDevices.
  ///
  /// In en, this message translates to:
  /// **'Multiple Devices'**
  String get anomalySettingsMultipleDevices;

  /// No description provided for @anomalySettingsMultipleDevicesDesc.
  ///
  /// In en, this message translates to:
  /// **'Using multiple devices in short time'**
  String get anomalySettingsMultipleDevicesDesc;

  /// No description provided for @anomalySettingsUnusualActivity.
  ///
  /// In en, this message translates to:
  /// **'Unusual Activity'**
  String get anomalySettingsUnusualActivity;

  /// No description provided for @anomalySettingsUnusualActivityDesc.
  ///
  /// In en, this message translates to:
  /// **'Excessive or atypical activity'**
  String get anomalySettingsUnusualActivityDesc;

  /// No description provided for @anomalySettingsCheatingPattern.
  ///
  /// In en, this message translates to:
  /// **'Cheating Pattern'**
  String get anomalySettingsCheatingPattern;

  /// No description provided for @anomalySettingsCheatingPatternDesc.
  ///
  /// In en, this message translates to:
  /// **'Patterns indicating cheating attempt'**
  String get anomalySettingsCheatingPatternDesc;

  /// No description provided for @anomalySettingsAccountSharing.
  ///
  /// In en, this message translates to:
  /// **'Account Sharing'**
  String get anomalySettingsAccountSharing;

  /// No description provided for @anomalySettingsAccountSharingDesc.
  ///
  /// In en, this message translates to:
  /// **'Account used by different people'**
  String get anomalySettingsAccountSharingDesc;

  /// No description provided for @anomalySettingsSensitivity.
  ///
  /// In en, this message translates to:
  /// **'Sensitivity'**
  String get anomalySettingsSensitivity;

  /// No description provided for @anomalySettingsSensitivityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get anomalySettingsSensitivityLow;

  /// No description provided for @anomalySettingsSensitivityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get anomalySettingsSensitivityHigh;

  /// No description provided for @anomalySettingsSensitivityCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current sensitivity: {percent}%'**
  String anomalySettingsSensitivityCurrent(Object percent);

  /// No description provided for @anomalySettingsAlerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get anomalySettingsAlerts;

  /// No description provided for @anomalySettingsSendAlerts.
  ///
  /// In en, this message translates to:
  /// **'Send Alerts'**
  String get anomalySettingsSendAlerts;

  /// No description provided for @anomalySettingsSendAlertsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Notify admins when anomaly detected'**
  String get anomalySettingsSendAlertsSubtitle;

  /// No description provided for @anomalySettingsMinimumSeverity.
  ///
  /// In en, this message translates to:
  /// **'Minimum Alert Severity'**
  String get anomalySettingsMinimumSeverity;

  /// No description provided for @anomalySettingsSeverityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get anomalySettingsSeverityLow;

  /// No description provided for @anomalySettingsSeverityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get anomalySettingsSeverityMedium;

  /// No description provided for @anomalySettingsSeverityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get anomalySettingsSeverityHigh;

  /// No description provided for @anomalySettingsSeverityCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get anomalySettingsSeverityCritical;

  /// No description provided for @anomalySettingsAutomatedActions.
  ///
  /// In en, this message translates to:
  /// **'Automated Actions'**
  String get anomalySettingsAutomatedActions;

  /// No description provided for @anomalySettingsSuspendCritical.
  ///
  /// In en, this message translates to:
  /// **'Suspend Critical Accounts'**
  String get anomalySettingsSuspendCritical;

  /// No description provided for @anomalySettingsSuspendCriticalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Automatically suspend accounts with critical anomalies'**
  String get anomalySettingsSuspendCriticalSubtitle;

  /// No description provided for @anomalySettingsFlagCheating.
  ///
  /// In en, this message translates to:
  /// **'Flag Cheating'**
  String get anomalySettingsFlagCheating;

  /// No description provided for @anomalySettingsFlagCheatingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Automatically flag cheating attempts'**
  String get anomalySettingsFlagCheatingSubtitle;

  /// No description provided for @anomalySettingsImportantNotes.
  ///
  /// In en, this message translates to:
  /// **'Important Notes'**
  String get anomalySettingsImportantNotes;

  /// No description provided for @anomalySettingsNote1.
  ///
  /// In en, this message translates to:
  /// **'• Detection uses advanced statistical algorithms'**
  String get anomalySettingsNote1;

  /// No description provided for @anomalySettingsNote2.
  ///
  /// In en, this message translates to:
  /// **'• False positives may occur - always review before action'**
  String get anomalySettingsNote2;

  /// No description provided for @anomalySettingsNote3.
  ///
  /// In en, this message translates to:
  /// **'• Detection improves over time as data accumulates'**
  String get anomalySettingsNote3;

  /// No description provided for @anomalySettingsNote4.
  ///
  /// In en, this message translates to:
  /// **'• High sensitivity = more detections (including false ones)'**
  String get anomalySettingsNote4;

  /// No description provided for @anomalySettingsNote5.
  ///
  /// In en, this message translates to:
  /// **'• Periodic review of settings and results recommended'**
  String get anomalySettingsNote5;

  /// No description provided for @moderationQueueTitle.
  ///
  /// In en, this message translates to:
  /// **'Moderation Queue'**
  String get moderationQueueTitle;

  /// No description provided for @moderationQueueError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String moderationQueueError(Object error);

  /// No description provided for @moderationQueueNoPending.
  ///
  /// In en, this message translates to:
  /// **'No pending reports'**
  String get moderationQueueNoPending;

  /// No description provided for @moderationQueueLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error loading reports: {error}'**
  String moderationQueueLoadError(Object error);

  /// No description provided for @moderationQueuePending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get moderationQueuePending;

  /// No description provided for @moderationQueueResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get moderationQueueResolved;

  /// No description provided for @moderationQueueDismissed.
  ///
  /// In en, this message translates to:
  /// **'Dismissed'**
  String get moderationQueueDismissed;

  /// No description provided for @moderationQueueTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get moderationQueueTotal;

  /// No description provided for @moderationQueueReportedBy.
  ///
  /// In en, this message translates to:
  /// **'Reported by: {name}'**
  String moderationQueueReportedBy(Object name);

  /// No description provided for @moderationQueueReason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get moderationQueueReason;

  /// No description provided for @moderationQueueDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get moderationQueueDetails;

  /// No description provided for @moderationQueueContentType.
  ///
  /// In en, this message translates to:
  /// **'Content Type'**
  String get moderationQueueContentType;

  /// No description provided for @moderationQueueActionWarn.
  ///
  /// In en, this message translates to:
  /// **'Warn'**
  String get moderationQueueActionWarn;

  /// No description provided for @moderationQueueActionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete Content'**
  String get moderationQueueActionDelete;

  /// No description provided for @moderationQueueActionMute.
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get moderationQueueActionMute;

  /// No description provided for @moderationQueueActionBan.
  ///
  /// In en, this message translates to:
  /// **'Ban'**
  String get moderationQueueActionBan;

  /// No description provided for @moderationQueueActionDismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss Report'**
  String get moderationQueueActionDismiss;

  /// No description provided for @moderationQueueStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending Review'**
  String get moderationQueueStatusPending;

  /// No description provided for @moderationQueueStatusInvestigating.
  ///
  /// In en, this message translates to:
  /// **'Investigating'**
  String get moderationQueueStatusInvestigating;

  /// No description provided for @moderationQueueStatusActionTaken.
  ///
  /// In en, this message translates to:
  /// **'Action Taken'**
  String get moderationQueueStatusActionTaken;

  /// No description provided for @moderationQueueStatusDismissed.
  ///
  /// In en, this message translates to:
  /// **'Dismissed'**
  String get moderationQueueStatusDismissed;

  /// No description provided for @moderationQueueStatusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get moderationQueueStatusResolved;

  /// No description provided for @moderationQueueConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Action: {action}'**
  String moderationQueueConfirmTitle(Object action);

  /// No description provided for @moderationQueueConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure about {action}?'**
  String moderationQueueConfirmMessage(Object action);

  /// No description provided for @moderationQueueCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get moderationQueueCancel;

  /// No description provided for @moderationQueueConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get moderationQueueConfirm;

  /// No description provided for @moderationQueueActionCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed {action}'**
  String moderationQueueActionCompleted(Object action);

  /// No description provided for @moderationQueueActionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Action completed successfully'**
  String get moderationQueueActionSuccess;

  /// No description provided for @moderationQueueActionFailed.
  ///
  /// In en, this message translates to:
  /// **'Action failed'**
  String get moderationQueueActionFailed;

  /// No description provided for @moderationQueueReasonInappropriate.
  ///
  /// In en, this message translates to:
  /// **'Inappropriate Content'**
  String get moderationQueueReasonInappropriate;

  /// No description provided for @moderationQueueReasonHarassment.
  ///
  /// In en, this message translates to:
  /// **'Harassment'**
  String get moderationQueueReasonHarassment;

  /// No description provided for @moderationQueueReasonSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam'**
  String get moderationQueueReasonSpam;

  /// No description provided for @moderationQueueReasonMisinformation.
  ///
  /// In en, this message translates to:
  /// **'Misinformation'**
  String get moderationQueueReasonMisinformation;

  /// No description provided for @moderationQueueReasonHarmful.
  ///
  /// In en, this message translates to:
  /// **'Harmful Content'**
  String get moderationQueueReasonHarmful;

  /// No description provided for @moderationQueueReasonCopyright.
  ///
  /// In en, this message translates to:
  /// **'Copyright Violation'**
  String get moderationQueueReasonCopyright;

  /// No description provided for @moderationQueueReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get moderationQueueReasonOther;

  /// No description provided for @createBadgeTitle.
  ///
  /// In en, this message translates to:
  /// **'Create New Badge'**
  String get createBadgeTitle;

  /// No description provided for @createBadgeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Badge created'**
  String get createBadgeSuccess;

  /// No description provided for @createBadgeError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String createBadgeError(Object error);

  /// No description provided for @createBadgeIdLabel.
  ///
  /// In en, this message translates to:
  /// **'ID (unique)'**
  String get createBadgeIdLabel;

  /// No description provided for @createBadgeIdRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get createBadgeIdRequired;

  /// No description provided for @createBadgeNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get createBadgeNameLabel;

  /// No description provided for @createBadgeNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get createBadgeNameRequired;

  /// No description provided for @createBadgeDescLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get createBadgeDescLabel;

  /// No description provided for @createBadgeIconLabel.
  ///
  /// In en, this message translates to:
  /// **'Icon URL (optional)'**
  String get createBadgeIconLabel;

  /// No description provided for @createBadgeIsActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get createBadgeIsActive;

  /// No description provided for @createBadgeAutoAward.
  ///
  /// In en, this message translates to:
  /// **'Auto Award'**
  String get createBadgeAutoAward;

  /// No description provided for @createBadgeCriteria.
  ///
  /// In en, this message translates to:
  /// **'Criteria (optional)'**
  String get createBadgeCriteria;

  /// No description provided for @createBadgePointsMin.
  ///
  /// In en, this message translates to:
  /// **'Points ≥'**
  String get createBadgePointsMin;

  /// No description provided for @createBadgeStreakMin.
  ///
  /// In en, this message translates to:
  /// **'Daily Streak ≥'**
  String get createBadgeStreakMin;

  /// No description provided for @createBadgeQuizzesMin.
  ///
  /// In en, this message translates to:
  /// **'Quizzes Passed ≥'**
  String get createBadgeQuizzesMin;

  /// No description provided for @createBadgeTasksMin.
  ///
  /// In en, this message translates to:
  /// **'Tasks Completed ≥'**
  String get createBadgeTasksMin;

  /// No description provided for @createBadgeLessonsMin.
  ///
  /// In en, this message translates to:
  /// **'Lessons Completed ≥'**
  String get createBadgeLessonsMin;

  /// No description provided for @createBadgeReviewsMin.
  ///
  /// In en, this message translates to:
  /// **'Reviews Written ≥'**
  String get createBadgeReviewsMin;

  /// No description provided for @createBadgeSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get createBadgeSaveButton;

  /// No description provided for @hrisImportTitle.
  ///
  /// In en, this message translates to:
  /// **'Import Users'**
  String get hrisImportTitle;

  /// No description provided for @hrisImportChooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose CSV or Excel file'**
  String get hrisImportChooseFile;

  /// No description provided for @hrisImportSelectFile.
  ///
  /// In en, this message translates to:
  /// **'Select File'**
  String get hrisImportSelectFile;

  /// No description provided for @hrisImportLoadTemplate.
  ///
  /// In en, this message translates to:
  /// **'Load Saved Template'**
  String get hrisImportLoadTemplate;

  /// No description provided for @hrisImportUnsupportedFile.
  ///
  /// In en, this message translates to:
  /// **'Unsupported file type'**
  String get hrisImportUnsupportedFile;

  /// No description provided for @hrisImportEmptyFile.
  ///
  /// In en, this message translates to:
  /// **'File is empty or contains only one row'**
  String get hrisImportEmptyFile;

  /// No description provided for @hrisImportError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String hrisImportError(Object error);

  /// No description provided for @hrisImportMapColumns.
  ///
  /// In en, this message translates to:
  /// **'Map Columns'**
  String get hrisImportMapColumns;

  /// No description provided for @hrisImportEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email *'**
  String get hrisImportEmailRequired;

  /// No description provided for @hrisImportNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name *'**
  String get hrisImportNameRequired;

  /// No description provided for @hrisImportRoleOptional.
  ///
  /// In en, this message translates to:
  /// **'Role (optional)'**
  String get hrisImportRoleOptional;

  /// No description provided for @hrisImportPhoneOptional.
  ///
  /// In en, this message translates to:
  /// **'Phone (optional)'**
  String get hrisImportPhoneOptional;

  /// No description provided for @hrisImportDepartmentOptional.
  ///
  /// In en, this message translates to:
  /// **'Department (optional)'**
  String get hrisImportDepartmentOptional;

  /// No description provided for @hrisImportJobTitleOptional.
  ///
  /// In en, this message translates to:
  /// **'Job Title (optional)'**
  String get hrisImportJobTitleOptional;

  /// No description provided for @hrisImportSaveAsTemplate.
  ///
  /// In en, this message translates to:
  /// **'Save as Template'**
  String get hrisImportSaveAsTemplate;

  /// No description provided for @hrisImportTemplateName.
  ///
  /// In en, this message translates to:
  /// **'Template Name'**
  String get hrisImportTemplateName;

  /// No description provided for @hrisImportPreviewButton.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get hrisImportPreviewButton;

  /// No description provided for @hrisImportBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get hrisImportBackButton;

  /// No description provided for @hrisImportNone.
  ///
  /// In en, this message translates to:
  /// **'-- None --'**
  String get hrisImportNone;

  /// No description provided for @hrisImportPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Import Preview'**
  String get hrisImportPreviewTitle;

  /// No description provided for @hrisImportTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get hrisImportTotal;

  /// No description provided for @hrisImportValid.
  ///
  /// In en, this message translates to:
  /// **'Valid'**
  String get hrisImportValid;

  /// No description provided for @hrisImportInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid'**
  String get hrisImportInvalid;

  /// No description provided for @hrisImportUpdateExisting.
  ///
  /// In en, this message translates to:
  /// **'Update Existing Users'**
  String get hrisImportUpdateExisting;

  /// No description provided for @hrisImportSampleRecords.
  ///
  /// In en, this message translates to:
  /// **'Sample Records:'**
  String get hrisImportSampleRecords;

  /// No description provided for @hrisImportStartButton.
  ///
  /// In en, this message translates to:
  /// **'Start Import'**
  String get hrisImportStartButton;

  /// No description provided for @hrisImportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Import completed successfully'**
  String get hrisImportSuccess;

  /// No description provided for @hrisImportNoTemplates.
  ///
  /// In en, this message translates to:
  /// **'No saved templates'**
  String get hrisImportNoTemplates;

  /// No description provided for @hrisImportChooseTemplate.
  ///
  /// In en, this message translates to:
  /// **'Choose Template'**
  String get hrisImportChooseTemplate;

  /// No description provided for @hrisImportCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get hrisImportCancel;

  /// No description provided for @importHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Import History'**
  String get importHistoryTitle;

  /// No description provided for @importHistoryAuthRequired.
  ///
  /// In en, this message translates to:
  /// **'You must be logged in'**
  String get importHistoryAuthRequired;

  /// No description provided for @importHistoryError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String importHistoryError(Object error);

  /// No description provided for @importHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No import operations'**
  String get importHistoryEmpty;

  /// No description provided for @importHistoryNewImport.
  ///
  /// In en, this message translates to:
  /// **'New Import'**
  String get importHistoryNewImport;

  /// No description provided for @importHistoryStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get importHistoryStatus;

  /// No description provided for @importHistoryTotalRows.
  ///
  /// In en, this message translates to:
  /// **'Total Rows'**
  String get importHistoryTotalRows;

  /// No description provided for @importHistoryProcessed.
  ///
  /// In en, this message translates to:
  /// **'Processed'**
  String get importHistoryProcessed;

  /// No description provided for @importHistorySuccessful.
  ///
  /// In en, this message translates to:
  /// **'Successful'**
  String get importHistorySuccessful;

  /// No description provided for @importHistoryFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get importHistoryFailed;

  /// No description provided for @importHistoryUploader.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get importHistoryUploader;

  /// No description provided for @importHistoryDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get importHistoryDate;

  /// No description provided for @importHistoryCompletedAt.
  ///
  /// In en, this message translates to:
  /// **'Completed at'**
  String get importHistoryCompletedAt;

  /// No description provided for @importHistoryErrors.
  ///
  /// In en, this message translates to:
  /// **'Errors:'**
  String get importHistoryErrors;

  /// No description provided for @importHistoryStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get importHistoryStatusPending;

  /// No description provided for @importHistoryStatusProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get importHistoryStatusProcessing;

  /// No description provided for @importHistoryStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get importHistoryStatusCompleted;

  /// No description provided for @importHistoryStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get importHistoryStatusFailed;

  /// No description provided for @importHistoryStatusPartial.
  ///
  /// In en, this message translates to:
  /// **'Partial Success'**
  String get importHistoryStatusPartial;

  /// No description provided for @bigqueryExportTitle.
  ///
  /// In en, this message translates to:
  /// **'BigQuery Export'**
  String get bigqueryExportTitle;

  /// No description provided for @bigqueryExportAuthRequired.
  ///
  /// In en, this message translates to:
  /// **'You must be logged in'**
  String get bigqueryExportAuthRequired;

  /// No description provided for @bigqueryExportNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'BigQuery must be configured first'**
  String get bigqueryExportNotConfigured;

  /// No description provided for @bigqueryExportNotEnabled.
  ///
  /// In en, this message translates to:
  /// **'BigQuery is not enabled'**
  String get bigqueryExportNotEnabled;

  /// No description provided for @bigqueryExportStarted.
  ///
  /// In en, this message translates to:
  /// **'Export started successfully'**
  String get bigqueryExportStarted;

  /// No description provided for @bigqueryExportError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String bigqueryExportError(Object error);

  /// No description provided for @bigqueryExportNewExport.
  ///
  /// In en, this message translates to:
  /// **'New Export'**
  String get bigqueryExportNewExport;

  /// No description provided for @bigqueryExportDataType.
  ///
  /// In en, this message translates to:
  /// **'Data Type'**
  String get bigqueryExportDataType;

  /// No description provided for @bigqueryExportUsers.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get bigqueryExportUsers;

  /// No description provided for @bigqueryExportCourses.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get bigqueryExportCourses;

  /// No description provided for @bigqueryExportEnrollments.
  ///
  /// In en, this message translates to:
  /// **'Enrollments'**
  String get bigqueryExportEnrollments;

  /// No description provided for @bigqueryExportQuizResults.
  ///
  /// In en, this message translates to:
  /// **'Quiz Results'**
  String get bigqueryExportQuizResults;

  /// No description provided for @bigqueryExportCertificates.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get bigqueryExportCertificates;

  /// No description provided for @bigqueryExportPointsAchievements.
  ///
  /// In en, this message translates to:
  /// **'Points & Achievements'**
  String get bigqueryExportPointsAchievements;

  /// No description provided for @bigqueryExportAll.
  ///
  /// In en, this message translates to:
  /// **'All Data'**
  String get bigqueryExportAll;

  /// No description provided for @bigqueryExportExporting.
  ///
  /// In en, this message translates to:
  /// **'Exporting...'**
  String get bigqueryExportExporting;

  /// No description provided for @bigqueryExportStart.
  ///
  /// In en, this message translates to:
  /// **'Start Export'**
  String get bigqueryExportStart;

  /// No description provided for @bigqueryExportHistory.
  ///
  /// In en, this message translates to:
  /// **'Export History'**
  String get bigqueryExportHistory;

  /// No description provided for @bigqueryExportRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get bigqueryExportRefresh;

  /// No description provided for @bigqueryExportNoExports.
  ///
  /// In en, this message translates to:
  /// **'No export operations'**
  String get bigqueryExportNoExports;

  /// No description provided for @bigqueryExportDetailStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get bigqueryExportDetailStatus;

  /// No description provided for @bigqueryExportDetailType.
  ///
  /// In en, this message translates to:
  /// **'Export Type'**
  String get bigqueryExportDetailType;

  /// No description provided for @bigqueryExportDetailTotal.
  ///
  /// In en, this message translates to:
  /// **'Total Records'**
  String get bigqueryExportDetailTotal;

  /// No description provided for @bigqueryExportDetailExported.
  ///
  /// In en, this message translates to:
  /// **'Exported'**
  String get bigqueryExportDetailExported;

  /// No description provided for @bigqueryExportDetailFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get bigqueryExportDetailFailed;

  /// No description provided for @bigqueryExportDetailUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get bigqueryExportDetailUser;

  /// No description provided for @bigqueryExportDetailStarted.
  ///
  /// In en, this message translates to:
  /// **'Started at'**
  String get bigqueryExportDetailStarted;

  /// No description provided for @bigqueryExportDetailCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed at'**
  String get bigqueryExportDetailCompleted;

  /// No description provided for @bigqueryExportDetailErrors.
  ///
  /// In en, this message translates to:
  /// **'Errors:'**
  String get bigqueryExportDetailErrors;

  /// No description provided for @bigqueryExportAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get bigqueryExportAnalytics;

  /// No description provided for @bigqueryExportProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get bigqueryExportProgress;

  /// No description provided for @bigqueryExportStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get bigqueryExportStatusPending;

  /// No description provided for @bigqueryExportStatusProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get bigqueryExportStatusProcessing;

  /// No description provided for @bigqueryExportStatusUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading'**
  String get bigqueryExportStatusUploading;

  /// No description provided for @bigqueryExportStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get bigqueryExportStatusCompleted;

  /// No description provided for @bigqueryExportStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get bigqueryExportStatusFailed;

  /// No description provided for @bigquerySettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'BigQuery Settings'**
  String get bigquerySettingsTitle;

  /// No description provided for @bigquerySettingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved successfully'**
  String get bigquerySettingsSaved;

  /// No description provided for @bigquerySettingsSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save settings'**
  String get bigquerySettingsSaveFailed;

  /// No description provided for @bigquerySettingsError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String bigquerySettingsError(Object error);

  /// No description provided for @bigquerySettingsEnableExport.
  ///
  /// In en, this message translates to:
  /// **'Enable BigQuery Export'**
  String get bigquerySettingsEnableExport;

  /// No description provided for @bigquerySettingsExportDescription.
  ///
  /// In en, this message translates to:
  /// **'Export data to BigQuery'**
  String get bigquerySettingsExportDescription;

  /// No description provided for @bigquerySettingsProjectInfo.
  ///
  /// In en, this message translates to:
  /// **'Project Information'**
  String get bigquerySettingsProjectInfo;

  /// No description provided for @bigquerySettingsProjectIdHelper.
  ///
  /// In en, this message translates to:
  /// **'Google Cloud Project ID'**
  String get bigquerySettingsProjectIdHelper;

  /// No description provided for @bigquerySettingsProjectIdRequired.
  ///
  /// In en, this message translates to:
  /// **'Project ID is required'**
  String get bigquerySettingsProjectIdRequired;

  /// No description provided for @bigquerySettingsDatasetIdHelper.
  ///
  /// In en, this message translates to:
  /// **'BigQuery Dataset ID'**
  String get bigquerySettingsDatasetIdHelper;

  /// No description provided for @bigquerySettingsDatasetIdRequired.
  ///
  /// In en, this message translates to:
  /// **'Dataset ID is required'**
  String get bigquerySettingsDatasetIdRequired;

  /// No description provided for @bigquerySettingsServiceAccountHelper.
  ///
  /// In en, this message translates to:
  /// **'Service Account JSON credentials'**
  String get bigquerySettingsServiceAccountHelper;

  /// No description provided for @bigquerySettingsServiceAccountRequired.
  ///
  /// In en, this message translates to:
  /// **'Service Account JSON is required'**
  String get bigquerySettingsServiceAccountRequired;

  /// No description provided for @bigquerySettingsInvalidJSON.
  ///
  /// In en, this message translates to:
  /// **'Invalid JSON format'**
  String get bigquerySettingsInvalidJSON;

  /// No description provided for @bigquerySettingsEnabledDataTypes.
  ///
  /// In en, this message translates to:
  /// **'Enabled Data Types'**
  String get bigquerySettingsEnabledDataTypes;

  /// No description provided for @bigquerySettingsUsersTitle.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get bigquerySettingsUsersTitle;

  /// No description provided for @bigquerySettingsUsersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'User account data'**
  String get bigquerySettingsUsersSubtitle;

  /// No description provided for @bigquerySettingsCoursesTitle.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get bigquerySettingsCoursesTitle;

  /// No description provided for @bigquerySettingsCoursesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Training course information'**
  String get bigquerySettingsCoursesSubtitle;

  /// No description provided for @bigquerySettingsEnrollmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Enrollments'**
  String get bigquerySettingsEnrollmentsTitle;

  /// No description provided for @bigquerySettingsEnrollmentsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Course registration records'**
  String get bigquerySettingsEnrollmentsSubtitle;

  /// No description provided for @bigquerySettingsQuizResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz Results'**
  String get bigquerySettingsQuizResultsTitle;

  /// No description provided for @bigquerySettingsQuizResultsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz and assessment results'**
  String get bigquerySettingsQuizResultsSubtitle;

  /// No description provided for @bigquerySettingsCertificatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get bigquerySettingsCertificatesTitle;

  /// No description provided for @bigquerySettingsCertificatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Certificate issuance records'**
  String get bigquerySettingsCertificatesSubtitle;

  /// No description provided for @bigquerySettingsGamificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Points & Achievements'**
  String get bigquerySettingsGamificationTitle;

  /// No description provided for @bigquerySettingsGamificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Gamification system data'**
  String get bigquerySettingsGamificationSubtitle;

  /// No description provided for @bigquerySettingsAnalyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get bigquerySettingsAnalyticsTitle;

  /// No description provided for @bigquerySettingsAnalyticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Usage analytics data'**
  String get bigquerySettingsAnalyticsSubtitle;

  /// No description provided for @bigquerySettingsProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get bigquerySettingsProgressTitle;

  /// No description provided for @bigquerySettingsProgressSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learning progress data'**
  String get bigquerySettingsProgressSubtitle;

  /// No description provided for @bigquerySettingsSchedule.
  ///
  /// In en, this message translates to:
  /// **'Export Schedule'**
  String get bigquerySettingsSchedule;

  /// No description provided for @bigquerySettingsScheduleHourly.
  ///
  /// In en, this message translates to:
  /// **'Hourly'**
  String get bigquerySettingsScheduleHourly;

  /// No description provided for @bigquerySettingsScheduleDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get bigquerySettingsScheduleDaily;

  /// No description provided for @bigquerySettingsScheduleWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get bigquerySettingsScheduleWeekly;

  /// No description provided for @bigquerySettingsScheduleManual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get bigquerySettingsScheduleManual;

  /// No description provided for @bigquerySettingsSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get bigquerySettingsSaveButton;

  /// No description provided for @bigquerySettingsImportantNotes.
  ///
  /// In en, this message translates to:
  /// **'Important Notes'**
  String get bigquerySettingsImportantNotes;

  /// No description provided for @bigquerySettingsSetupSteps.
  ///
  /// In en, this message translates to:
  /// **'• Create a Google Cloud project and enable BigQuery API\n• Create a Service Account and download JSON file\n• Grant appropriate permissions to the Service Account\n• Create a Dataset in BigQuery beforehand\n• Tables will be created automatically during export'**
  String get bigquerySettingsSetupSteps;

  /// No description provided for @courseDetailsNewPostTitle.
  ///
  /// In en, this message translates to:
  /// **'New post in: {courseName}'**
  String courseDetailsNewPostTitle(Object courseName);

  /// No description provided for @courseDetailsNewPostContent.
  ///
  /// In en, this message translates to:
  /// **'{authorEmail} added a new post.'**
  String courseDetailsNewPostContent(Object authorEmail);

  /// No description provided for @courseDetailsError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String courseDetailsError(Object error);

  /// No description provided for @courseDetailsMoreOptions.
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get courseDetailsMoreOptions;

  /// No description provided for @courseDetailsBadges.
  ///
  /// In en, this message translates to:
  /// **'Badges & Achievements'**
  String get courseDetailsBadges;

  /// No description provided for @courseDetailsLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get courseDetailsLeaderboard;

  /// No description provided for @courseDetailsAchievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get courseDetailsAchievements;

  /// No description provided for @courseDetailsModules.
  ///
  /// In en, this message translates to:
  /// **'Learning Modules'**
  String get courseDetailsModules;

  /// No description provided for @courseDetailsQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Quizzes'**
  String get courseDetailsQuizzes;

  /// No description provided for @courseDetailsResources.
  ///
  /// In en, this message translates to:
  /// **'Resource Library'**
  String get courseDetailsResources;

  /// No description provided for @courseDetailsTrainees.
  ///
  /// In en, this message translates to:
  /// **'Trainees'**
  String get courseDetailsTrainees;

  /// No description provided for @courseDetailsAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Course Analytics'**
  String get courseDetailsAnalytics;

  /// No description provided for @courseDetailsPointsSettings.
  ///
  /// In en, this message translates to:
  /// **'Points Settings'**
  String get courseDetailsPointsSettings;

  /// No description provided for @courseDetailsMyEvaluations.
  ///
  /// In en, this message translates to:
  /// **'My Evaluations'**
  String get courseDetailsMyEvaluations;

  /// No description provided for @courseDetailsInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Course Information'**
  String get courseDetailsInfoTitle;

  /// No description provided for @courseDetailsInfoContent.
  ///
  /// In en, this message translates to:
  /// **'Full course details'**
  String get courseDetailsInfoContent;

  /// No description provided for @courseDetailsClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get courseDetailsClose;

  /// No description provided for @courseDetailsNoPosts.
  ///
  /// In en, this message translates to:
  /// **'No posts'**
  String get courseDetailsNoPosts;

  /// No description provided for @courseDetailsChangeFilters.
  ///
  /// In en, this message translates to:
  /// **'Try changing the search settings'**
  String get courseDetailsChangeFilters;

  /// No description provided for @courseDetailsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'What do you want to share?'**
  String get courseDetailsPlaceholder;

  /// No description provided for @courseDetailsAddImages.
  ///
  /// In en, this message translates to:
  /// **'Add images'**
  String get courseDetailsAddImages;

  /// No description provided for @courseDetailsCreatePoll.
  ///
  /// In en, this message translates to:
  /// **'Create poll'**
  String get courseDetailsCreatePoll;

  /// No description provided for @courseDetailsTrainerFallback.
  ///
  /// In en, this message translates to:
  /// **'Trainer'**
  String get courseDetailsTrainerFallback;

  /// No description provided for @courseDetailsAuthRequired.
  ///
  /// In en, this message translates to:
  /// **'You must log in first'**
  String get courseDetailsAuthRequired;

  /// No description provided for @modulesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No learning modules yet'**
  String get modulesEmptyTitle;

  /// No description provided for @modulesEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Modules will be added soon'**
  String get modulesEmptySubtitle;

  /// No description provided for @modulesLoadError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading modules'**
  String get modulesLoadError;

  /// No description provided for @modulesLockedMessage.
  ///
  /// In en, this message translates to:
  /// **'Locked - complete the previous module'**
  String get modulesLockedMessage;

  /// No description provided for @modulesContentCount.
  ///
  /// In en, this message translates to:
  /// **'{count} content'**
  String modulesContentCount(Object count);

  /// No description provided for @modulesProgressFormat.
  ///
  /// In en, this message translates to:
  /// **'{completed}/{total} completed'**
  String modulesProgressFormat(Object completed, Object total);

  /// No description provided for @forgotPasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent to your email'**
  String get forgotPasswordSuccess;

  /// No description provided for @evaluationLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error loading evaluation'**
  String get evaluationLoadError;

  /// No description provided for @quizHubCreatingTask.
  ///
  /// In en, this message translates to:
  /// **'... Creating task'**
  String get quizHubCreatingTask;

  /// No description provided for @quizHubNoAttempts.
  ///
  /// In en, this message translates to:
  /// **'No attempts yet'**
  String get quizHubNoAttempts;

  /// No description provided for @quizHubLatestScore.
  ///
  /// In en, this message translates to:
  /// **'Latest score: {score} | Total attempts: {count}'**
  String quizHubLatestScore(Object score, Object count);

  /// No description provided for @unknownUserInitial.
  ///
  /// In en, this message translates to:
  /// **'?'**
  String get unknownUserInitial;

  /// No description provided for @emailVerificationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your email has been verified successfully! 🎉'**
  String get emailVerificationSuccess;

  /// No description provided for @emailVerificationPending.
  ///
  /// In en, this message translates to:
  /// **'Email not verified yet. Please open your email and click the verification link.'**
  String get emailVerificationPending;

  /// No description provided for @emailVerificationError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String emailVerificationError(Object error);

  /// No description provided for @emailVerificationLinkSent.
  ///
  /// In en, this message translates to:
  /// **'Verification link sent to {email}'**
  String emailVerificationLinkSent(Object email);

  /// No description provided for @emailVerificationSendError.
  ///
  /// In en, this message translates to:
  /// **'Error sending email: {error}'**
  String emailVerificationSendError(Object error);

  /// No description provided for @emailVerificationLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get emailVerificationLogout;

  /// No description provided for @emailVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Email'**
  String get emailVerificationTitle;

  /// No description provided for @emailVerificationSentTo.
  ///
  /// In en, this message translates to:
  /// **'We sent a verification link to:'**
  String get emailVerificationSentTo;

  /// No description provided for @emailVerificationInstructions.
  ///
  /// In en, this message translates to:
  /// **'Please open your email and click the verification link'**
  String get emailVerificationInstructions;

  /// No description provided for @emailVerificationSpamNote.
  ///
  /// In en, this message translates to:
  /// **'(Check your Spam folder if you don\'t see the message)'**
  String get emailVerificationSpamNote;

  /// No description provided for @emailVerificationChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get emailVerificationChecking;

  /// No description provided for @emailVerificationChecked.
  ///
  /// In en, this message translates to:
  /// **'I verified my email'**
  String get emailVerificationChecked;

  /// No description provided for @emailVerificationResending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get emailVerificationResending;

  /// No description provided for @emailVerificationResend.
  ///
  /// In en, this message translates to:
  /// **'Resend email'**
  String get emailVerificationResend;

  /// No description provided for @emailVerificationWhy.
  ///
  /// In en, this message translates to:
  /// **'Why do we need verification?\nTo ensure your email is correct and you can recover your account later.'**
  String get emailVerificationWhy;

  /// No description provided for @anomalyError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String anomalyError(Object error);

  /// No description provided for @anomalyDetailType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get anomalyDetailType;

  /// No description provided for @anomalyDetailSeverity.
  ///
  /// In en, this message translates to:
  /// **'Severity'**
  String get anomalyDetailSeverity;

  /// No description provided for @anomalyDetailScore.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get anomalyDetailScore;

  /// No description provided for @anomalyDetailConfidence.
  ///
  /// In en, this message translates to:
  /// **'Confidence Level'**
  String get anomalyDetailConfidence;

  /// No description provided for @anomalyDetailUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get anomalyDetailUser;

  /// No description provided for @anomalyDetailStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get anomalyDetailStatus;

  /// No description provided for @anomalyDetailDetected.
  ///
  /// In en, this message translates to:
  /// **'Detected'**
  String get anomalyDetailDetected;

  /// No description provided for @anomalyDetailEvidence.
  ///
  /// In en, this message translates to:
  /// **'Evidence:'**
  String get anomalyDetailEvidence;

  /// No description provided for @anomalyDetailReview.
  ///
  /// In en, this message translates to:
  /// **'Review:'**
  String get anomalyDetailReview;

  /// No description provided for @anomalyDetailReviewer.
  ///
  /// In en, this message translates to:
  /// **'Reviewer'**
  String get anomalyDetailReviewer;

  /// No description provided for @anomalyDetailReviewDate.
  ///
  /// In en, this message translates to:
  /// **'Review Date'**
  String get anomalyDetailReviewDate;

  /// No description provided for @anomalyDetailNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get anomalyDetailNotes;

  /// No description provided for @anomalyTypeSuspiciousLogin.
  ///
  /// In en, this message translates to:
  /// **'Suspicious login'**
  String get anomalyTypeSuspiciousLogin;

  /// No description provided for @anomalyTypeAbnormalQuizScore.
  ///
  /// In en, this message translates to:
  /// **'Abnormal quiz score'**
  String get anomalyTypeAbnormalQuizScore;

  /// No description provided for @anomalyTypeRapidProgress.
  ///
  /// In en, this message translates to:
  /// **'Rapid progress'**
  String get anomalyTypeRapidProgress;

  /// No description provided for @anomalyTypeMultipleDevices.
  ///
  /// In en, this message translates to:
  /// **'Multiple devices'**
  String get anomalyTypeMultipleDevices;

  /// No description provided for @anomalyTypeUnusualActivity.
  ///
  /// In en, this message translates to:
  /// **'Unusual activity'**
  String get anomalyTypeUnusualActivity;

  /// No description provided for @anomalyTypeCheatingPattern.
  ///
  /// In en, this message translates to:
  /// **'Cheating pattern'**
  String get anomalyTypeCheatingPattern;

  /// No description provided for @anomalyTypeAccountSharing.
  ///
  /// In en, this message translates to:
  /// **'Account sharing'**
  String get anomalyTypeAccountSharing;

  /// No description provided for @anomalySeverityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get anomalySeverityLow;

  /// No description provided for @anomalySeverityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get anomalySeverityMedium;

  /// No description provided for @anomalySeverityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get anomalySeverityHigh;

  /// No description provided for @anomalySeverityCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get anomalySeverityCritical;

  /// No description provided for @anomalyStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get anomalyStatusPending;

  /// No description provided for @anomalyStatusInvestigating.
  ///
  /// In en, this message translates to:
  /// **'Investigating'**
  String get anomalyStatusInvestigating;

  /// No description provided for @anomalyStatusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get anomalyStatusResolved;

  /// No description provided for @anomalyStatusFalsePositive.
  ///
  /// In en, this message translates to:
  /// **'False Positive'**
  String get anomalyStatusFalsePositive;

  /// No description provided for @anomalyStatusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get anomalyStatusConfirmed;

  /// No description provided for @anomalyReviewDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Review Anomaly'**
  String get anomalyReviewDialogTitle;

  /// No description provided for @anomalyReviewStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get anomalyReviewStatusLabel;

  /// No description provided for @anomalyReviewNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get anomalyReviewNotesLabel;

  /// No description provided for @manualGradeTitle.
  ///
  /// In en, this message translates to:
  /// **'Manual Grading'**
  String get manualGradeTitle;

  /// No description provided for @manualGradeSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Grading saved'**
  String get manualGradeSaveSuccess;

  /// No description provided for @manualGradeSaveError.
  ///
  /// In en, this message translates to:
  /// **'Failed: {error}'**
  String manualGradeSaveError(Object error);

  /// No description provided for @manualGradeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Submission not found'**
  String get manualGradeNotFound;

  /// No description provided for @manualGradeTraineeLabel.
  ///
  /// In en, this message translates to:
  /// **'Trainee: {trainee}'**
  String manualGradeTraineeLabel(Object trainee);

  /// No description provided for @manualGradeAutoScore.
  ///
  /// In en, this message translates to:
  /// **'Auto score: {score}'**
  String manualGradeAutoScore(Object score);

  /// No description provided for @manualGradeNoAnswer.
  ///
  /// In en, this message translates to:
  /// **'No answer'**
  String get manualGradeNoAnswer;

  /// No description provided for @manualGradeQuestionScore.
  ///
  /// In en, this message translates to:
  /// **'Question score (integer)'**
  String get manualGradeQuestionScore;

  /// No description provided for @manualGradeSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Grading'**
  String get manualGradeSaveButton;

  /// No description provided for @manualGradingReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review Text Answers'**
  String get manualGradingReviewTitle;

  /// No description provided for @manualGradingNoSubmissions.
  ///
  /// In en, this message translates to:
  /// **'No submissions need manual grading.'**
  String get manualGradingNoSubmissions;

  /// No description provided for @manualGradingAutoScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Auto score: {auto} / {total}'**
  String manualGradingAutoScoreLabel(Object auto, Object total);
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
