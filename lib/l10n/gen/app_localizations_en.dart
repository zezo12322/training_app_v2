// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Training App';

  @override
  String get navDashboardTrainer => 'Dashboard';

  @override
  String get navHomeTrainee => 'Home';

  @override
  String get navProfile => 'My Account';

  @override
  String get navSettings => 'Settings';

  @override
  String get actionNewCourse => 'New Course';

  @override
  String get actionJoin => 'Join';

  @override
  String greetingTrainer(Object name) {
    return 'Hello, $name!';
  }

  @override
  String get greetingTrainerFallback => 'Hello, Trainer!';

  @override
  String greetingTrainee(Object name) {
    return 'Welcome, $name!';
  }

  @override
  String get greetingTraineeFallback => 'Hello, Trainee!';

  @override
  String get trainerCoursesSubtitle => 'Your current courses:';

  @override
  String get traineeCoursesSubtitle => 'Your enrolled courses:';

  @override
  String get noTrainerCoursesTitle => 'You haven\'t created any courses yet';

  @override
  String get noTrainerCoursesHint => 'Press + below to start';

  @override
  String get noTraineeCoursesTitle => 'You haven\'t joined any courses yet';

  @override
  String get noTraineeCoursesHint => 'Press + to join a new course';

  @override
  String courseCodeLabel(Object code) {
    return 'Code: $code';
  }

  @override
  String get onboardingTitle => 'Quick Guide';

  @override
  String get onboardingPointDashboardTitle => 'Home / Dashboard';

  @override
  String get onboardingPointDashboardBody => 'View and manage your courses.';

  @override
  String get onboardingPointProfileTitle => 'My Account';

  @override
  String get onboardingPointProfileBody => 'Update your name, photo and info.';

  @override
  String get onboardingPointSettingsTitle => 'Settings';

  @override
  String get onboardingPointSettingsBody =>
      'Control theme, animations and playback.';

  @override
  String get onboardingRoleNote =>
      'First tab changes based on your role (trainer/trainee).';

  @override
  String get onboardingStart => 'Start';

  @override
  String get onboardingLater => 'Later';

  @override
  String get onboardingFullTour => 'Full Tour';

  @override
  String get tourNext => 'Next';

  @override
  String get tourSkip => 'Skip';

  @override
  String get tourDone => 'Done';

  @override
  String get tourDashboardTitle => 'Dashboard';

  @override
  String get tourDashboardBody =>
      'Your starting point. Shows summaries and quick actions.';

  @override
  String get tourFabTitleTrainer => 'Create Course';

  @override
  String get tourFabBodyTrainer =>
      'Tap here any time to add a new course for trainees.';

  @override
  String get tourFabTitleTrainee => 'Join Course';

  @override
  String get tourFabBodyTrainee =>
      'Tap to join a course using a code shared by a trainer.';

  @override
  String get tourProfileTitle => 'Profile';

  @override
  String get tourProfileBody =>
      'Edit your name, photo and view stats & achievements.';

  @override
  String get tourSettingsTitle => 'Settings';

  @override
  String get tourSettingsBody =>
      'Change theme, language and notification preferences.';

  @override
  String get loading => 'Loading...';

  @override
  String errorGeneric(Object error) {
    return 'Error: $error';
  }

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsSubtitle =>
      'Allow push notifications (OneSignal / FCM)';

  @override
  String get errorNetwork => 'Network issue. Please retry.';

  @override
  String errorAuth(Object details) {
    return 'Authentication error: $details';
  }

  @override
  String get errorNotFound => 'Resource not found';

  @override
  String errorNotFoundResource(Object resource) {
    return 'Not found: $resource';
  }

  @override
  String get errorValidation => 'Some fields are invalid';

  @override
  String get errorPermission => 'You don\'t have permission';

  @override
  String get errorRateLimited => 'Too many requests. Try later.';

  @override
  String errorRateLimitedRetry(Object seconds) {
    return 'Please retry after ${seconds}s';
  }

  @override
  String get errorStorage => 'Storage error occurred';

  @override
  String get errorUnknown => 'An unexpected error occurred';

  @override
  String get funAnimationsTitle => 'Fun animations';

  @override
  String get funAnimationsSubtitle => 'Enable subtle entrance animations';

  @override
  String get autoplayAudioTitle => 'Autoplay audio';

  @override
  String get autoplayAudioSubtitle => 'When opening a new voice evaluation';

  @override
  String get clearCacheTitle => 'Clear cache (pseudo)';

  @override
  String get clearCacheSubtitle => 'May fix some sync issues';

  @override
  String get confirmationTitle => 'Confirm';

  @override
  String get clearCacheConfirm => 'Perform a pseudo clear of local cache?';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get continueAction => 'Continue';

  @override
  String get cacheClearedToast => 'Cache cleared (simulated)';

  @override
  String get aboutTitle => 'About';

  @override
  String get aboutSubtitle => 'Training beta build';

  @override
  String get logoutAction => 'Logout';

  @override
  String get logoutConfirm => 'Are you sure you want to logout?';

  @override
  String logoutFailed(Object error) {
    return 'Logout failed: $error';
  }

  @override
  String get dumpSettingsAction => 'Print settings state to log';

  @override
  String get dumpSettingsToast => 'Settings state logged';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get aboutSection => 'About';

  @override
  String get languagePickerTitle => 'Language';

  @override
  String get systemLocaleLabel => 'System';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get loginTitle => 'Login';

  @override
  String get loginWelcomeBack => 'Welcome back!';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordTooShort => 'At least 6 characters';

  @override
  String get fieldRequired => 'Required';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get loginAction => 'Login';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get signInWithApple => 'Sign in with Apple';

  @override
  String ssoLoginFailed(Object error) {
    return 'SSO login failed: $error';
  }

  @override
  String get signupNavigate => 'Don\'t have an account? Create one';

  @override
  String get forgotPasswordNavigate => 'Forgot Password?';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get forgotPasswordDescription =>
      'Enter your email and we\'ll send you a link to reset your password';

  @override
  String get sendResetEmail => 'Send Reset Link';

  @override
  String get passwordResetEmailSent =>
      'Password reset email has been sent to your inbox';

  @override
  String get passwordResetFailed => 'Failed to send reset email';

  @override
  String get emailSent => 'Email Sent';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get forgotPasswordNote =>
      'Make sure to check your inbox and spam folder';

  @override
  String get signupTitle => 'Create Account';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get chooseRole => 'Choose your role:';

  @override
  String get roleTrainer => 'Trainer';

  @override
  String get roleTrainee => 'Trainee';

  @override
  String get signupAction => 'Sign Up';

  @override
  String get haveAccountLogin => 'Already have an account? Login';

  @override
  String get selectRoleError => 'Please select a role (trainer or trainee)';

  @override
  String get createCourseTitle => 'Create New Course';

  @override
  String get courseNameLabel => 'Course name';

  @override
  String get createCourseAction => 'Create Course';

  @override
  String get courseCreatedSuccess => 'Course created successfully!';

  @override
  String get shareCodeHint => 'Share this code with your trainees to join:';

  @override
  String get backToHome => 'Back to home';

  @override
  String get joinCourseTitle => 'Join Course';

  @override
  String get enterCourseCode => 'Enter course code';

  @override
  String get joinCourseSuccess => 'Joined course successfully!';

  @override
  String get enterCourseCodeError => 'Please enter a course code';

  @override
  String loginFailed(Object error) {
    return 'Login failed: $error';
  }

  @override
  String unexpectedError(Object error) {
    return 'Unexpected error: $error';
  }

  @override
  String signupFailed(Object error) {
    return 'Signup failed: $error';
  }

  @override
  String get signupSuccessCheckEmail =>
      'Account created! Please check your email to verify your account.';

  @override
  String createCourseFailed(Object error) {
    return 'Failed to create course: $error';
  }

  @override
  String joinCourseFailed(Object error) {
    return 'Failed to join course: $error';
  }

  @override
  String get userNotLoggedIn => 'User not signed in';

  @override
  String get threadTitle => 'Discussion';

  @override
  String get refreshTooltip => 'Refresh';

  @override
  String get noRepliesYet => 'No replies yet';

  @override
  String get newTaskHint => 'New task (Action plan)';

  @override
  String get addTaskTooltip => 'Add task';

  @override
  String get noTasksYet => 'No tasks yet';

  @override
  String get autoStopRecording =>
      'Recording stopped automatically after reaching the time limit.';

  @override
  String previewPlayError(Object error) {
    return 'Could not play preview: $error';
  }

  @override
  String get trainerAccountMissing =>
      'Could not identify trainer account. Please log in again.';

  @override
  String get evaluationSendSuccess => 'Evaluation sent successfully!';

  @override
  String evaluationSendFailure(Object message) {
    return 'Failed: $message';
  }

  @override
  String unexpectedErrorMsg(Object error) {
    return 'Unexpected error: $error';
  }

  @override
  String get courseNameFallback => 'One of your courses';

  @override
  String get notificationNewEvaluationTitle => 'You have a new evaluation!';

  @override
  String notificationNewEvaluationBody(Object courseName) {
    return 'Your trainer added a new evaluation for you in course: $courseName';
  }

  @override
  String get cancelRecordingTitle => 'Cancel recording?';

  @override
  String get cancelRecordingBody =>
      'You are currently recording. Do you want to stop and lose the current recording?';

  @override
  String get dialogNo => 'No';

  @override
  String get dialogYes => 'Yes';

  @override
  String reportTitle(Object email) {
    return 'Report: $email';
  }

  @override
  String get scoreFieldLabel => 'Score (out of 100)';

  @override
  String get scoreRequired => 'Please enter a score';

  @override
  String get scoreRangeError => 'Please enter a score between 0 and 100';

  @override
  String get feedbackFieldLabel => 'Feedback and evaluation';

  @override
  String get feedbackRequired => 'Please enter feedback';

  @override
  String get audioSectionOptional => 'Add audio evaluation (optional):';

  @override
  String get submitEvaluation => 'Submit Evaluation';

  @override
  String get recordingStartLabel => 'Record audio evaluation';

  @override
  String get recordingInProgress => 'Recording in progress';

  @override
  String get recordedLabel => 'Recorded';

  @override
  String get previewAudioLabel => 'Preview audio recording';

  @override
  String get previewButton => 'Preview';

  @override
  String durationLabel(Object value) {
    return 'Duration: $value';
  }

  @override
  String get reRecord => 'Re-record';

  @override
  String get pinAction => 'Pin';

  @override
  String get unpinAction => 'Unpin';

  @override
  String get copyTextAction => 'Copy text';

  @override
  String get editAction => 'Edit';

  @override
  String get deleteAction => 'Delete';

  @override
  String get copiedToast => 'Copied!';

  @override
  String get writeReplyHint => 'Write a reply...';

  @override
  String get retryLabel => 'Retry';

  @override
  String get uploadingAudio => 'Uploading audio...';

  @override
  String get audioFailed => 'Audio upload failed';

  @override
  String get audioLabel => 'Audio';

  @override
  String get editCancel => 'Cancel';

  @override
  String get editSave => 'Save';

  @override
  String pinnedReplyLabel(Object id) {
    return 'Pinned reply: $id';
  }

  @override
  String get commentUnknownUser => 'Unknown user';

  @override
  String get commentFallbackName => 'Anonymous';

  @override
  String get commentHint => 'Add a comment...';

  @override
  String get noFeedback => 'No feedback provided';

  @override
  String get discussionButton => 'Discussion';

  @override
  String scoreLabel(Object score) {
    return 'Score: $score';
  }

  @override
  String get audioPauseSemantic => 'Pause audio';

  @override
  String get audioPlaySemantic => 'Play audio';

  @override
  String get audioEvaluation => 'Audio evaluation';

  @override
  String get audioPlayingNow => 'Playing now';

  @override
  String get audioTapToPlay => 'Tap to play';

  @override
  String get userMissing => 'User not found';

  @override
  String get dashboardTitleTrainer => 'Trainer Dashboard';

  @override
  String get createCourseFab => 'Create Course';

  @override
  String loadCoursesError(Object error) {
    return 'Error loading courses: $error';
  }

  @override
  String get noTrainerCoursesTitleAlt => 'No courses created yet';

  @override
  String get noTrainerCoursesHintAlt => 'Press + to create your first course';

  @override
  String get loadMore => 'Load more';

  @override
  String courseCodePrefix(Object code) {
    return 'Course code: $code';
  }

  @override
  String get homeTitleTrainee => 'Trainee Home';

  @override
  String loadErrorGeneric(Object error) {
    return 'Error loading data: $error';
  }

  @override
  String get noTraineeCoursesTitleAlt => 'No courses joined yet';

  @override
  String get noTraineeCoursesHintAlt => 'Press + to join your first course';

  @override
  String trainerPrefix(Object id) {
    return 'Trainer: $id';
  }

  @override
  String get joinCourseAction => 'Join Course';

  @override
  String get reportGeneralSection => 'General Information';

  @override
  String get reportQuizzesSection => 'Quizzes';

  @override
  String get addEvaluationFab => 'Add Evaluation';

  @override
  String get reportNoEvaluations => 'No evaluations yet';

  @override
  String get reportNoQuizzes => 'No quizzes yet';

  @override
  String get leaderboardTitle => 'Leaderboard';

  @override
  String get leaderboardEmpty => 'No players yet';

  @override
  String leaderboardPoints(Object points) {
    return '$points pts';
  }

  @override
  String get pointsLabel => 'Points';

  @override
  String get dashboardSeeAll => 'See all';

  @override
  String get timelineFilterAll => 'All';

  @override
  String get timelineFilterQuizzes => 'Quizzes';

  @override
  String get timelineFilterTasks => 'Tasks';

  @override
  String get timelineFilterLessons => 'Lessons';

  @override
  String get timelineFilterStreak => 'Streak';

  @override
  String get timelineNoMoreEvents => 'No more events';

  @override
  String get nextBadgeShort => 'Next badge';

  @override
  String get badgesLabel => 'Badges';

  @override
  String levelLabel(Object level) {
    return 'Level $level';
  }

  @override
  String get earnedBadgesSection => 'Earned';

  @override
  String get allBadgesSection => 'All';

  @override
  String get noBadgesYet => 'No badges yet';

  @override
  String get reviewsTitle => 'Reviews';

  @override
  String get addReviewAction => 'Add Review';

  @override
  String get ratingLabel => 'Rating';

  @override
  String get reviewSubmitSuccess => 'Review submitted';

  @override
  String get reviewSubmitFailure => 'Failed to submit review';

  @override
  String averageRatingLabel(Object value) {
    return 'Average: $value';
  }

  @override
  String streakLabel(Object days) {
    return 'Streak: ${days}d';
  }

  @override
  String nextBadgeProgress(Object points) {
    return 'Next badge at $points pts';
  }

  @override
  String dailyStreakAward(Object points) {
    return 'Daily streak +$points';
  }

  @override
  String quizPassedAward(Object points) {
    return 'Quiz passed +$points';
  }

  @override
  String lessonCompletedAward(Object points) {
    return 'Lesson completed +$points';
  }

  @override
  String badgeEarnedToast(Object name) {
    return 'Badge earned: $name';
  }

  @override
  String badgesEarnedBatch(Object first, Object more) {
    return 'Badge earned: $first +$more';
  }

  @override
  String get noReviewsYet => 'No reviews yet';

  @override
  String get submitReview => 'Submit Review';

  @override
  String get reviewCommentHint => 'Your comment';

  @override
  String get reviewRatingHint => 'Tap stars to rate';

  @override
  String get gamificationSection => 'Progress & Achievements';

  @override
  String get progressTitle => 'Progress';

  @override
  String get testsTabLabel => 'Tests';

  @override
  String get tasksTabLabel => 'Tasks';

  @override
  String get noQuizzesYet => 'No quizzes available yet';

  @override
  String quizLastScore(Object score) {
    return 'Last score: $score%';
  }

  @override
  String get quizNotStarted => 'Not started yet';

  @override
  String get quizStartAction => 'Start';

  @override
  String get quizRetakeAction => 'Retake';

  @override
  String get noTasksYetAlt => 'No tasks right now';

  @override
  String get addTaskDialogTitle => 'New Task';

  @override
  String get fieldTitleHint => 'Title';

  @override
  String get fieldDetailsHint => 'Details (optional)';

  @override
  String get fieldPointsHint => 'Points';

  @override
  String get priorityLabel => 'Priority';

  @override
  String get priorityHigh => 'High priority';

  @override
  String get priorityMed => 'Medium priority';

  @override
  String get priorityLow => 'Low priority';

  @override
  String get taskStatusNew => 'New';

  @override
  String get taskStatusInProgress => 'In progress';

  @override
  String get taskStatusDone => 'Done';

  @override
  String get badgeManageTitle => 'Manage Badges';

  @override
  String get noBadgesDefined => 'No badges defined yet';

  @override
  String get newBadgeTitle => 'New Badge';

  @override
  String get editBadgeTitle => 'Edit Badge';

  @override
  String get deleteBadgeTitle => 'Delete Badge';

  @override
  String deleteConfirmBody(Object name) {
    return 'Delete badge: $name?';
  }

  @override
  String get badgeIconUrlLabel => 'Icon URL';

  @override
  String get criteriaSectionLabel => 'Criteria';

  @override
  String get activeLabel => 'Active';

  @override
  String get autoAwardLabel => 'Auto award';

  @override
  String get saveActionLabel => 'Save';

  @override
  String get dialogCancel => 'Cancel';

  @override
  String get taskStatusSkipped => 'Skipped';

  @override
  String get filterAll => 'All';

  @override
  String get selectDueDate => 'Select due date';

  @override
  String get dueDatePickerLabel => 'Due';

  @override
  String get pickAction => 'Pick';

  @override
  String get changeAction => 'Change';

  @override
  String get clearAction => 'Clear';

  @override
  String get duePast => 'Past';

  @override
  String get dueToday => 'Today';

  @override
  String get dueTomorrow => 'Tomorrow';

  @override
  String dueInDays(Object days) {
    return 'In $days days';
  }

  @override
  String get quizPassedLabel => 'Passed';

  @override
  String get quizSubmitAction => 'Submit Quiz';

  @override
  String quizPassThreshold(Object score) {
    return 'Pass >= $score%';
  }

  @override
  String get taskDueFilterOverdue => 'Overdue';

  @override
  String get taskDueFilterToday => 'Today';

  @override
  String get taskDueFilterWeek => 'This Week';

  @override
  String quizAttemptsUsed(Object used, Object max) {
    return 'Attempts: $used/$max';
  }

  @override
  String get quizAttemptExceeded => 'No more attempts';

  @override
  String get quizAttemptSingle => 'Single attempt';

  @override
  String quizAttemptMultiple(Object max) {
    return 'Up to $max attempts';
  }

  @override
  String get quizReviewAction => 'Review';

  @override
  String get quizSettingsTitle => 'Quiz Settings';

  @override
  String get quizPassPercentLabel => 'Pass %';

  @override
  String get quizRewardPointsLabel => 'Reward Points';

  @override
  String get quizMaxAttemptsLabel => 'Max Attempts';

  @override
  String get quizUpdateSuccess => 'Quiz updated';

  @override
  String get quizUpdateFailed => 'Update failed';

  @override
  String get postPublishing => 'Posting...';

  @override
  String get postPublished => 'Post published';

  @override
  String get orgAdminDashboardTitle => 'Organization Admin Dashboard';

  @override
  String get orgAdminDashboardSubtitle =>
      'Metrics and trends for your institution';

  @override
  String get companyAdminDashboardTitle => 'Company Admin Dashboard';

  @override
  String get companyAdminDashboardSubtitle =>
      'Metrics and trends for your company';

  @override
  String get departmentsTitle => 'Departments';

  @override
  String get departmentsSubtitle => 'View your company departments';

  @override
  String get learningPathsTitle => 'Learning Paths';

  @override
  String get learningPathsSubtitle => 'View learning paths for your company';

  @override
  String get managerDashboardTitle => 'Manager Dashboard';

  @override
  String get managerDashboardSubtitle =>
      'Team overview and skill gaps (preview)';

  @override
  String get bulkImportTitle => 'Bulk Import (CSV)';

  @override
  String get bulkImportSubtitle => 'Import batched changes from CSV file';

  @override
  String get selectDepartmentHint =>
      'Select a department from Departments to view team.';

  @override
  String get labelActiveUsers => 'Active Users';

  @override
  String get labelAvgEventsPerUser7d => 'Avg Events/User (7d)';

  @override
  String get labelAvgMastery => 'Avg Mastery';

  @override
  String get labelAvgMasteryDelta14d => 'Avg Mastery Δ14d';

  @override
  String get labelLatestPrefix => 'Latest';

  @override
  String get labelLatest7Days => 'Latest 7 days';

  @override
  String get labelDate => 'Date';

  @override
  String get labelActiveShort => 'Active';

  @override
  String get labelAvgEvPerUsrShort => 'AvgEv/Usr';

  @override
  String get labelAvgMasteryShort => 'AvgMastery';

  @override
  String get labelDelta14dShort => 'Δ14d';

  @override
  String get noDepartments => 'No departments';

  @override
  String idLabel(Object id) {
    return 'ID: $id';
  }

  @override
  String get noTeamMembers => 'No team members in this department';

  @override
  String get topSkillGapsTitle => 'Top skill gaps';

  @override
  String get noSkillData => 'No skill data';

  @override
  String get activeChip => 'Active';

  @override
  String get inactiveChip => 'Inactive';

  @override
  String pathTitle(Object title) {
    return 'Path: $title';
  }

  @override
  String get noLearningPaths => 'No learning paths';

  @override
  String get noSteps => 'No steps';

  @override
  String get bulkImportCsvFormat =>
      'CSV Format: collection,docId,field.path,value';

  @override
  String get bulkImportPickCsv => 'Pick CSV';

  @override
  String get departmentsAddAction => 'Add Department';

  @override
  String get departmentNameLabel => 'Department name';

  @override
  String get assignUserToDepartmentTitle => 'Assign user to department';

  @override
  String get departmentMembersTitle => 'Department Members';

  @override
  String get manageMembersAction => 'Manage members';

  @override
  String get assignMemberAction => 'Assign member';

  @override
  String get searchUsersLabel => 'Search users by name or email';

  @override
  String get noResults => 'No results';

  @override
  String get assignSelectedAction => 'Assign selected';

  @override
  String get selectAtLeastOneUser => 'Select at least one user';

  @override
  String assignmentCompletedToast(Object count) {
    return 'Assigned $count member(s)';
  }

  @override
  String get removeMemberConfirm => 'Remove this member from the department?';

  @override
  String get memberRemovedToast => 'Member removed';

  @override
  String departmentCreatedToast(Object name) {
    return 'Department created: $name';
  }

  @override
  String get alreadyMemberLabel => 'Already in this department';

  @override
  String get pleaseSelectRole => 'Please select a role';

  @override
  String get authErrorWrongPassword => 'Email or password is incorrect';

  @override
  String get authErrorUserNotFound => 'Email is not registered';

  @override
  String get authErrorEmailInUse => 'Email is already registered';

  @override
  String get authErrorInvalidEmail => 'Invalid email address';

  @override
  String get authErrorWeakPassword => 'Password is too weak';

  @override
  String get authErrorUserDisabled =>
      'This account is disabled. Contact support';

  @override
  String get authErrorTooManyRequests => 'Too many attempts. Try again later';

  @override
  String get authErrorNetworkFailed => 'Network connection error';

  @override
  String get authErrorOperationNotAllowed => 'Operation not allowed';

  @override
  String get authErrorDefault => 'An error occurred during authentication';

  @override
  String get dialogConfirmTitle => 'Confirm';

  @override
  String get dialogDeleteTitle => 'Delete';

  @override
  String get dialogCancelButton => 'Cancel';

  @override
  String get dialogConfirmButton => 'Confirm';

  @override
  String get dialogDeleteButton => 'Delete';

  @override
  String get dialogSaveButton => 'Save';

  @override
  String get dialogCloseButton => 'Close';

  @override
  String get commentReply => 'Reply';

  @override
  String get commentEdit => 'Edit';

  @override
  String get commentDelete => 'Delete';

  @override
  String get commentDeleteConfirm => 'Are you sure?';

  @override
  String get commentDeleteTitle => 'Delete Comment';

  @override
  String get filterPostsTitle => 'Filter Posts';

  @override
  String get sortPostsTitle => 'Sort Posts';

  @override
  String get filterClearDates => 'Clear Dates';

  @override
  String get filterReset => 'Reset';

  @override
  String get filterApply => 'Apply';

  @override
  String get sortPinnedFirst => 'Pinned First';

  @override
  String get reactionsClose => 'Close';

  @override
  String get emailVerificationTitle => 'Email Verification';

  @override
  String get privacyPolicyTitle => 'Privacy Policy';

  @override
  String get termsOfServiceTitle => 'Terms of Service';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get superAdminDashboard => 'Super Admin Dashboard';

  @override
  String get superAdminDashboardSubtitle =>
      'Manage institutions, companies, and settings';

  @override
  String get searchPostsPlaceholder => 'Search in posts...';

  @override
  String get filterButtonTooltip => 'Filter';

  @override
  String get sortButtonTooltip => 'Sort';

  @override
  String get postTypeFilter => 'Post Type';

  @override
  String get dateRangeFilter => 'Date Range';

  @override
  String get dateFromLabel => 'From Date';

  @override
  String get dateToLabel => 'To Date';

  @override
  String get postDeleteTitle => 'Delete Post';

  @override
  String get postDeleteConfirm => 'Are you sure you want to delete this post?';

  @override
  String get postDeleted => 'Post deleted';

  @override
  String get postPinned => 'Post pinned';

  @override
  String get postUnpinned => 'Post unpinned';

  @override
  String get postEditButton => 'Edit';

  @override
  String get postPinButton => 'Pin';

  @override
  String get postUnpinButton => 'Unpin';

  @override
  String get postDeleteButton => 'Delete';

  @override
  String get postEditedLabel => 'edited';

  @override
  String get postAuthorFallback => 'User';

  @override
  String postCommentCount(Object count) {
    return '$count comment';
  }

  @override
  String get postCommentButton => 'Comment';

  @override
  String get reactionPickerTitle => 'Choose your reaction';

  @override
  String get reactionAddTooltip => 'Add reaction';

  @override
  String get addPostTitle => 'New Post';

  @override
  String get addPostContentPlaceholder => 'What do you want to share?';

  @override
  String get addPostContentRequired => 'Please write content or add an image';

  @override
  String get addPostPickImages => 'Choose Images';

  @override
  String get addPostTakePhoto => 'Take Photo';

  @override
  String addPostSelectedImages(Object count) {
    return 'Selected images ($count/5):';
  }

  @override
  String addPostUploadingImages(Object percent) {
    return 'Uploading images... $percent%';
  }

  @override
  String get addPostPublishing => 'Publishing post...';

  @override
  String get addPostPublishButton => 'Publish';

  @override
  String get addPostPublishingButton => 'Publishing...';

  @override
  String get addPostSuccess => 'Post published successfully';

  @override
  String addPostUploadError(Object error) {
    return 'Error uploading images: $error';
  }

  @override
  String addPostCharacterCount(Object current, Object max) {
    return '$current/$max';
  }

  @override
  String get editPostTitle => 'Edit Post';

  @override
  String get editPostPlaceholder => 'Write post content...';

  @override
  String editPostCharacterCount(Object current, Object max) {
    return '$current/$max characters';
  }

  @override
  String get editPostSaveButton => 'Save';

  @override
  String get editPostSuccess => 'Post updated';

  @override
  String get createPollTitle => 'Create Poll';

  @override
  String get createPollQuestionLabel => 'Question';

  @override
  String get createPollQuestionHint => 'Write your poll question...';

  @override
  String get createPollQuestionRequired => 'Please enter the question';

  @override
  String get createPollOptionsTitle => 'Options';

  @override
  String createPollOptionLabel(Object number) {
    return 'Option $number';
  }

  @override
  String get createPollOptionRequired => 'Required';

  @override
  String get createPollAddOption => 'Add Option';

  @override
  String get createPollMaxOptionsError => 'Maximum 10 options';

  @override
  String get createPollMinOptionsError => 'Must have at least 2 options';

  @override
  String get createPollMinOptionsSubmitError => 'Must add at least 2 options';

  @override
  String get createPollSettingsTitle => 'Settings';

  @override
  String get createPollAllowMultiple => 'Allow multiple selections';

  @override
  String get createPollShowResults => 'Show results before voting';

  @override
  String get createPollEndDateLabel => 'Poll end date';

  @override
  String get createPollEndDateNone => 'None (always open)';

  @override
  String get createPollCreateButton => 'Create';

  @override
  String get createPollCreatingButton => 'Creating...';

  @override
  String get createPollSuccess => 'Poll created successfully';

  @override
  String get reportDialogTitle => 'Report Content';

  @override
  String get reportTypeLabel => 'Report Type';

  @override
  String get reportTypeInappropriate => 'Inappropriate content';

  @override
  String get reportTypeHarassment => 'Harassment';

  @override
  String get reportTypeSpam => 'Spam';

  @override
  String get reportTypeMisinformation => 'Misinformation';

  @override
  String get reportTypeHarmful => 'Harmful content';

  @override
  String get reportTypeCopyright => 'Copyright violation';

  @override
  String get reportTypeOther => 'Other';

  @override
  String get reportReasonLabel => 'Reason *';

  @override
  String get reportReasonHint => 'Enter report reason';

  @override
  String get reportReasonRequired => 'Please enter a reason';

  @override
  String get reportDescriptionLabel => 'Additional details (optional)';

  @override
  String get reportDescriptionHint =>
      'Add any additional details to help with review';

  @override
  String get reportReviewNote => 'Report will be reviewed by moderation team';

  @override
  String get reportSubmitButton => 'Submit Report';

  @override
  String get reportSuccess =>
      'Report submitted successfully. Will be reviewed by moderators.';

  @override
  String get reportError => 'Error submitting report';

  @override
  String get reportLoginRequired => 'Must be logged in first';

  @override
  String get reportButtonLabel => 'Report';

  @override
  String get commentPlaceholder => 'Write your comment...';

  @override
  String get pollNotFound => 'Poll not found';

  @override
  String pollError(Object error) {
    return 'Error: $error';
  }

  @override
  String get pollHeaderLabel => 'Poll';

  @override
  String get pollEndedLabel => 'Ended';

  @override
  String get pollVotesSingular => 'vote';

  @override
  String get pollVotesPlural => 'votes';

  @override
  String pollVotesCount(Object count, Object votes) {
    return '$count $votes';
  }

  @override
  String pollEndsIn(Object time) {
    return 'Ends $time';
  }

  @override
  String pollEnded(Object time) {
    return 'Ended $time';
  }

  @override
  String pollVoteError(Object error) {
    return 'Error: $error';
  }

  @override
  String pollOptionVotesSingular(Object count) {
    return '$count vote';
  }

  @override
  String pollOptionVotesPlural(Object count) {
    return '$count votes';
  }

  @override
  String imageViewerTitle(Object current, Object total) {
    return '$current / $total';
  }

  @override
  String get imageDownloadTooltip => 'Download';

  @override
  String get imageDownloadSuccess => 'Image opened in browser for download';

  @override
  String get imageDownloadError => 'Cannot open link';

  @override
  String get imageLoadError => 'Failed to load image';

  @override
  String imageErrorGeneric(Object error) {
    return 'Error occurred: $error';
  }

  @override
  String get reactionPickerTitleAlt => 'Choose your reaction';

  @override
  String reactionError(Object error) {
    return 'Error: $error';
  }

  @override
  String get reactionLiked => 'Liked';

  @override
  String get reactionLike => 'Like';

  @override
  String get courseChatTitle => 'Course Chat';

  @override
  String get courseChatLoginRequired => 'Login required';

  @override
  String courseChatLoadError(Object error) {
    return 'Error: $error';
  }

  @override
  String get courseChatMute => 'Mute notifications';

  @override
  String get courseChatUnmute => 'Unmute notifications';

  @override
  String get courseChatInfo => 'Chat info';

  @override
  String courseChatMessageSendError(Object error) {
    return 'Failed to send message: $error';
  }

  @override
  String get courseChatEditMessage => 'Edit';

  @override
  String get courseChatDeleteMessage => 'Delete';

  @override
  String get courseChatFlagMessage => 'Report';

  @override
  String get courseChatEditTitle => 'Edit Message';

  @override
  String get courseChatEditPlaceholder => 'New message';

  @override
  String get courseChatEditSuccess => 'Message edited';

  @override
  String courseChatEditError(Object error) {
    return 'Edit failed: $error';
  }

  @override
  String get courseChatDeleteTitle => 'Delete Message';

  @override
  String get courseChatDeleteConfirm =>
      'Are you sure you want to delete this message?';

  @override
  String get courseChatDeleteSuccess => 'Message deleted';

  @override
  String courseChatDeleteError(Object error) {
    return 'Delete failed: $error';
  }

  @override
  String get courseChatFlagSuccess => 'Message reported';

  @override
  String courseChatFlagError(Object error) {
    return 'Report failed: $error';
  }

  @override
  String get courseChatMuteSuccess => 'Notifications muted';

  @override
  String get courseChatUnmuteSuccess => 'Notifications unmuted';

  @override
  String get courseChatMuteError => 'Error changing mute status';

  @override
  String get courseChatInfoTitle => 'Chat Info';

  @override
  String courseChatInfoCourse(Object name) {
    return 'Course: $name';
  }

  @override
  String courseChatInfoParticipants(Object count) {
    return 'Participants: $count';
  }

  @override
  String courseChatInfoCreated(Object date) {
    return 'Created: $date';
  }

  @override
  String get courseChatInfoClose => 'Close';

  @override
  String get directChatTitle => 'Direct Chat';

  @override
  String get directChatTyping => 'typing...';

  @override
  String get directChatLoginError => 'Error: User data not found';

  @override
  String get directChatBlockTitle => 'Block User';

  @override
  String get directChatBlockConfirm =>
      'Do you want to block this user? You won\'t be able to receive their messages.';

  @override
  String get directChatBlockSuccess => 'User blocked';

  @override
  String get directChatBlockError => 'Failed to block user';

  @override
  String get directChatBlock => 'Block';

  @override
  String get directChatReport => 'Report';

  @override
  String get directChatDeleteTitle => 'Delete Conversation';

  @override
  String get directChatDeleteConfirm =>
      'Do you want to delete this conversation? It will be hidden from your list only.';

  @override
  String get directChatDeleteSuccess => 'Conversation deleted';

  @override
  String get directChatDeleteError => 'Failed to delete conversation';

  @override
  String get directChatEmptyMessage => 'Start the conversation...';

  @override
  String directChatError(Object error) {
    return 'Error occurred: $error';
  }

  @override
  String get directChatAttachFile => 'Attach';

  @override
  String directChatFileUploadError(Object error) {
    return 'Failed to upload file: $error';
  }

  @override
  String get directChatAttachImage => 'Image';

  @override
  String directChatImageUploadError(Object error) {
    return 'Failed to upload image: $error';
  }

  @override
  String get directChatImageLabel => 'Image';

  @override
  String get directChatMessagePlaceholder => 'Type a message...';

  @override
  String get directChatMessageDeleted => 'This message was deleted';

  @override
  String get directChatMessageEdited => 'edited';

  @override
  String get directChatEditTitle => 'Edit Message';

  @override
  String get directChatEditPlaceholder => 'New message';

  @override
  String get directChatEditSuccess => 'Edited';

  @override
  String get directChatEditError => 'Edit failed';

  @override
  String get directChatDeleteMessageTitle => 'Delete Message';

  @override
  String get directChatDeleteMessageConfirm =>
      'Are you sure you want to delete this message?';

  @override
  String get directChatDeleteMessageSuccess => 'Deleted';

  @override
  String get directChatDeleteMessageError => 'Delete failed';

  @override
  String get directMessagesTitle => 'Messages';

  @override
  String get directMessagesLoginRequired => 'Please login';

  @override
  String get directMessagesSearchPlaceholder => 'Search in messages...';

  @override
  String get directMessagesSearchCancel => 'Cancel search';

  @override
  String get directMessagesSearchTooltip => 'Search';

  @override
  String get directMessagesEmpty => 'No conversations yet';

  @override
  String get directMessagesNoResults => 'No results';

  @override
  String get directMessagesNoResultsHint => 'Try different search terms';

  @override
  String get directMessagesEmptyHint =>
      'Start a new conversation from members list';

  @override
  String get directMessagesArchiveSuccess => 'Archived';

  @override
  String get directMessagesMuteSuccess => 'Notifications muted';

  @override
  String get directMessagesUnmuteSuccess => 'Unmuted';

  @override
  String get directMessagesNewChatTooltip => 'New conversation';

  @override
  String directMessagesError(Object error) {
    return 'Error occurred: $error';
  }

  @override
  String get directMessagesUser => 'User';

  @override
  String get directMessagesNoMessages => 'No messages';

  @override
  String get superAdminDashboardTitle => 'Super Admin';

  @override
  String get superAdminDashboardHome => 'Home';

  @override
  String get superAdminDashboardUnauthorized =>
      'Unauthorized (Super Admin only)';

  @override
  String get superAdminTotalUsers => 'Total Users';

  @override
  String get superAdminTrainers => 'Trainers';

  @override
  String get superAdminTrainees => 'Trainees';

  @override
  String get superAdminSystemSettings => 'System Settings';

  @override
  String superAdminFlags(Object count) {
    return 'Flags: $count';
  }

  @override
  String superAdminThresholds(Object count) {
    return 'Thresholds: $count';
  }

  @override
  String get superAdminNoSettings => 'No settings loaded';

  @override
  String get superAdminTenantReads => 'Tenant Reads';

  @override
  String get superAdminTenantWrites => 'Tenant Writes';

  @override
  String get superAdminFlagRecommendation =>
      'Recommendation: Enable reads first, then writes after validating cross-tenant leakage is zero.';

  @override
  String superAdminSettingsError(Object error) {
    return 'Settings error: $error';
  }

  @override
  String get superAdminUsersFirst50 => 'Users (first 50)';

  @override
  String superAdminUsersLoadError(Object error) {
    return 'Error loading users: $error';
  }

  @override
  String get superAdminAlerts => 'Alerts';

  @override
  String get superAdminIntrusionAlerts => 'Intrusion Alerts';

  @override
  String get superAdminPredictiveAlerts => 'Predictive Alerts';

  @override
  String get superAdminIntegrityFlags => 'Integrity Flags';

  @override
  String superAdminAlertError(Object title, Object error) {
    return '$title error: $error';
  }

  @override
  String superAdminNoAlerts(Object title) {
    return 'No $title';
  }

  @override
  String superAdminMoreAlerts(Object count) {
    return '+$count more…';
  }

  @override
  String get superAdminTenants => 'Tenants';

  @override
  String get superAdminInstitutions => 'Institutions';

  @override
  String get superAdminNoInstitutions => 'No institutions';

  @override
  String superAdminInstitutionsError(Object error) {
    return 'Institutions error: $error';
  }

  @override
  String get superAdminCompanies => 'Companies';

  @override
  String get superAdminNoCompanies => 'No companies';

  @override
  String superAdminCompaniesError(Object error) {
    return 'Companies error: $error';
  }

  @override
  String get superAdminCreateInstitution => 'Create Institution';

  @override
  String get superAdminCreateCompany => 'Create Company';

  @override
  String get superAdminInstitutionDialogTitle => 'Create Institution';

  @override
  String get superAdminCompanyDialogTitle => 'Create Company';

  @override
  String get superAdminNameLabel => 'Name';

  @override
  String get superAdminNameRequired => 'Required';

  @override
  String get superAdminPlanTierLabel => 'Plan Tier';

  @override
  String get superAdminPlanTierRequired => 'Required';

  @override
  String get superAdminDialogCancel => 'Cancel';

  @override
  String get superAdminDialogCreate => 'Create';

  @override
  String get superAdminInstitutionCreated => 'Institution created';

  @override
  String get superAdminCompanyCreated => 'Company created';

  @override
  String superAdminCreateError(Object error) {
    return 'Error: $error';
  }

  @override
  String get companyAdminHome => 'Home';

  @override
  String companyAdminError(Object error) {
    return 'Error: $error';
  }

  @override
  String get orgAdminHome => 'Home';

  @override
  String orgAdminError(Object error) {
    return 'Error: $error';
  }

  @override
  String get takeQuizNoQuestions => 'No questions in this quiz yet.';

  @override
  String takeQuizQuestionProgress(Object current, Object total) {
    return 'Question $current of $total';
  }

  @override
  String get takeQuizShortAnswerLabel => 'Your short answer';

  @override
  String get takeQuizEssayAnswerLabel => 'Your essay answer';

  @override
  String get takeQuizMatchingSelect => 'Choose';

  @override
  String get takeQuizUnsupportedType => 'Unsupported question type yet';

  @override
  String get takeQuizPreviousButton => 'Previous';

  @override
  String get takeQuizNextButton => 'Next';

  @override
  String get takeQuizSubmitButton => 'Submit Answers';

  @override
  String takeQuizSubmissionFailed(Object message) {
    return 'Submission failed: $message';
  }

  @override
  String get quizResultsTitle => 'Quiz Result';

  @override
  String get quizResultsCompleted => 'You\'ve completed the quiz!';

  @override
  String get quizResultsYourScore => 'Your score is:';

  @override
  String quizResultsScoreDisplay(Object score, Object total) {
    return '$score / $total';
  }

  @override
  String get quizResultsBackButton => 'Back to Quiz List';

  @override
  String get createQuizTitle => 'Create New Quiz';

  @override
  String get createQuizTitleLabel => 'Quiz Title';

  @override
  String get createQuizTitleHint => 'Example: Flutter Basics Quiz';

  @override
  String get createQuizTitleRequired => 'Please enter a title for the quiz';

  @override
  String get createQuizNextButton => 'Next: Add Questions';

  @override
  String get createQuizSuccess => 'Quiz created - Add questions now';

  @override
  String createQuizError(Object error) {
    return 'An error occurred: $error';
  }

  @override
  String get addQuestionTitle => 'Add Questions to Quiz';

  @override
  String get addQuestionNoQuestionsYet => 'No questions added yet.';

  @override
  String addQuestionQuestionsAdded(Object count) {
    return 'Questions added: $count';
  }

  @override
  String get addQuestionNewQuestion => 'Add new question:';

  @override
  String get addQuestionTypeLabel => 'Question type: ';

  @override
  String get addQuestionTypeMultipleChoice => 'Multiple Choice';

  @override
  String get addQuestionTypeShortAnswer => 'Short Answer';

  @override
  String get addQuestionTypeLongAnswer => 'Long Answer';

  @override
  String get addQuestionTypeMatching => 'Matching';

  @override
  String get addQuestionTextLabel => 'Question text';

  @override
  String get addQuestionFieldRequired => 'Field required';

  @override
  String get addQuestionOption1 => 'Option 1';

  @override
  String get addQuestionOption2 => 'Option 2';

  @override
  String get addQuestionOption3 => 'Option 3';

  @override
  String get addQuestionOption4 => 'Option 4';

  @override
  String get addQuestionSelectCorrect => 'Select the correct answer:';

  @override
  String get addQuestionMatchingPairs => 'Matching pairs (left ⇄ right):';

  @override
  String addQuestionLeft(Object n) {
    return 'Left $n';
  }

  @override
  String addQuestionRight(Object n) {
    return 'Right $n';
  }

  @override
  String get addQuestionAddButton => 'Add Question';

  @override
  String get addQuestionSelectCorrectSnackbar =>
      'Select the correct answer (Multiple Choice)';

  @override
  String get addQuestionValidPairsError =>
      'Enter valid matching pairs (at least 2 pairs with equal counts)';

  @override
  String addQuestionError(Object error) {
    return 'An error occurred: $error';
  }
}
