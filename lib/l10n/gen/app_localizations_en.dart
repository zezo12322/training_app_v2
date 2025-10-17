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
  String get leaderboardWeekly => 'Weekly';

  @override
  String get leaderboardMonthly => 'Monthly';

  @override
  String get leaderboardAllTime => 'All Time';

  @override
  String get leaderboardRetry => 'Retry';

  @override
  String get leaderboardLoadError =>
      'An error occurred while loading leaderboard';

  @override
  String get leaderboardNoEntries => 'No leaderboard entries yet';

  @override
  String get leaderboardYou => 'You';

  @override
  String get leaderboardRank => 'Rank';

  @override
  String leaderboardPointsWithLabel(Object points) {
    return '$points points';
  }

  @override
  String get leaderboardPointsShort => 'points';

  @override
  String leaderboardLevelFormat(Object level, Object name) {
    return 'Level $level • $name';
  }

  @override
  String get leaderboardEmptyTitle => 'No top players yet';

  @override
  String get leaderboardEmptySubtitle => 'Be the first to earn points!';

  @override
  String get leaderboardErrorLoad =>
      'An error occurred while loading top players';

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
  String orgAdminLatest(Object value) {
    return 'Latest: $value';
  }

  @override
  String get orgAdminActiveUsers => 'Active Users';

  @override
  String get orgAdminAvgEventsPerUser7d => 'Avg Events/User (7d)';

  @override
  String get orgAdminAvgMastery => 'Avg Mastery';

  @override
  String get orgAdminAvgMasteryDelta14d => 'Avg Mastery Delta (14d)';

  @override
  String get orgAdminLatest7Days => 'Latest 7 Days';

  @override
  String get orgAdminDate => 'Date';

  @override
  String get orgAdminActive => 'Active';

  @override
  String get orgAdminAvgEvPerUsr => 'Avg Ev/Usr';

  @override
  String get orgAdminAvgMasteryShort => 'Avg Mast';

  @override
  String get orgAdminDelta14d => 'Δ14d';

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

  @override
  String get wallCommentsTitle => 'Comments';

  @override
  String get wallCommentsReplyAdded => 'Reply added';

  @override
  String get wallCommentsCommentAdded => 'Comment added';

  @override
  String wallCommentsError(Object error) {
    return 'Error: $error';
  }

  @override
  String get wallCommentsNoCommentsYet => 'No comments yet';

  @override
  String get wallCommentsBeFirstToComment => 'Be the first to comment!';

  @override
  String wallCommentsReplyingTo(Object username) {
    return 'Replying to $username';
  }

  @override
  String get wallCommentsReplyPlaceholder => 'Write your reply...';

  @override
  String get wallCommentsCommentPlaceholder => 'Write a comment...';

  @override
  String get wallCommentsCommentEdited => 'Comment edited';

  @override
  String get wallCommentsHideReplies => 'Hide replies';

  @override
  String wallCommentsShowReplies(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'replies',
      one: 'reply',
    );
    return '$count $_temp0';
  }

  @override
  String get recommendationDismissTooltip => 'Dismiss recommendation';

  @override
  String get recommendationHighPriority => 'High priority';

  @override
  String recommendationConfidence(Object percent) {
    return '$percent% confidence';
  }

  @override
  String recommendationMinutes(Object minutes) {
    return '$minutes minutes';
  }

  @override
  String get recommendationReasonWeakPerformance => 'To improve performance';

  @override
  String get recommendationReasonInterests => 'Based on your interests';

  @override
  String get recommendationReasonNextStep => 'Next step';

  @override
  String get recommendationReasonSkillGap => 'To fill a skill gap';

  @override
  String get recommendationReasonPopularWithPeers => 'Popular among your peers';

  @override
  String get recommendationReasonPathCompletion => 'To complete the path';

  @override
  String get recommendationReasonStrengthenSkill => 'To strengthen your skills';

  @override
  String get recommendationsEmpty => 'No recommendations currently';

  @override
  String get recommendationsEmptyHint =>
      'We will create personalized recommendations for you soon';

  @override
  String recommendationsOpenSnackbar(Object title) {
    return 'Opened: $title';
  }

  @override
  String get recommendationsDismissedSnackbar => 'Recommendation dismissed';

  @override
  String get recommendationsError =>
      'An error occurred loading recommendations';

  @override
  String get networkStatusOfflineBanner =>
      'No internet connection - Working offline';

  @override
  String get networkStatusOfflineMessage =>
      'No internet connection. Check your connection and try again.';

  @override
  String get networkStatusPermissionDenied =>
      'You don\'t have permission to access this data';

  @override
  String get networkStatusNotFound => 'The requested data was not found';

  @override
  String get networkStatusUnknownError =>
      'An unexpected error occurred. Try again.';

  @override
  String get networkStatusRetryButton => 'Retry';

  @override
  String get commentReactionLoginRequired => 'You must log in to react';

  @override
  String get commentReactionPickerTitle => 'Choose your reaction';

  @override
  String get progressCardNextLevel => 'Next Level';

  @override
  String get progressCardMaxLevel =>
      'Congratulations! You\'ve reached the maximum level 🎉';

  @override
  String get progressCardEmptyTitle => 'Start your learning journey!';

  @override
  String get progressCardEmptyHint =>
      'Complete lessons and quizzes to earn points';

  @override
  String get progressCardError => 'An error occurred loading progress';

  @override
  String get messageListEmpty => 'No messages yet';

  @override
  String get messageListEmptyHint =>
      'Start the conversation by sending a message';

  @override
  String messageBubbleYesterday(Object time) {
    return 'Yesterday $time';
  }

  @override
  String get chatInputPlaceholder => 'Type a message...';

  @override
  String get messageBubbleEdited => '(edited)';

  @override
  String messageSearchError(Object error) {
    return 'Search error: $error';
  }

  @override
  String get messageSearchPlaceholderRoom => 'Search in this conversation...';

  @override
  String get messageSearchPlaceholderAll => 'Search in all messages...';

  @override
  String get messageSearchTitle => 'Search in messages';

  @override
  String get messageSearchNoResults => 'No results';

  @override
  String get messageSearchNoResultsHint => 'Try different search terms';

  @override
  String messageSearchResultsCount(Object count) {
    return 'Results: $count';
  }

  @override
  String get messageSearchEdited => 'edited';

  @override
  String get messageSearchDefaultRoom => 'conversation';

  @override
  String get messageSearchTooltip => 'Search';

  @override
  String get messageThreadTitle => 'Replies';

  @override
  String get messageThreadParentNotFound => 'Message not found';

  @override
  String get messageThreadUserNotFound => 'User data not found';

  @override
  String get messageThreadSendFailed => 'Failed to send reply';

  @override
  String get messageThreadNoReplies => 'No replies yet';

  @override
  String messageThreadError(Object error) {
    return 'Error: $error';
  }

  @override
  String get messageThreadReplyPlaceholder => 'Type your reply...';

  @override
  String get messageThreadReplySingular => 'reply';

  @override
  String get messageThreadReplyPlural => 'replies';

  @override
  String messageThreadLastReply(Object author) {
    return 'Last reply: $author';
  }

  @override
  String get userPickerError => 'Error creating conversation';

  @override
  String get userPickerLoginRequired => 'Please log in';

  @override
  String get userPickerLoadError => 'Cannot load user data';

  @override
  String get userPickerTitle => 'Choose a user to chat with';

  @override
  String get userPickerSearchHint => 'Search for a user...';

  @override
  String get userPickerNoResults => 'No results';

  @override
  String get userPickerNoUsers => 'No users';

  @override
  String get userPickerNoResultsHint => 'Try different search terms';

  @override
  String get userPickerNoUsersHint => 'No other users in your institution';

  @override
  String userPickerErrorWithDetails(Object error) {
    return 'An error occurred: $error';
  }

  @override
  String get userPickerRetry => 'Retry';

  @override
  String get userPickerRoleManager => 'Manager';

  @override
  String get userPickerRoleTrainer => 'Trainer';

  @override
  String get userPickerRoleTrainee => 'Trainee';

  @override
  String quizSubmissionsTitle(Object quizTitle) {
    return 'Submissions: $quizTitle';
  }

  @override
  String personalProfileUploadFailed(Object error) {
    return 'Image upload failed: $error';
  }

  @override
  String get personalProfileSaved => 'Saved';

  @override
  String personalProfileSaveFailed(Object error) {
    return 'Save failed: $error';
  }

  @override
  String get settingsArabicLabel => 'Arabic';

  @override
  String privacyPolicyLoadFailed(Object error) {
    return 'Failed to load privacy policy: $error';
  }

  @override
  String termsOfServiceLoadFailed(Object error) {
    return 'Failed to load terms of service: $error';
  }

  @override
  String get traineeListTitle => 'Trainees';

  @override
  String get traineeListEmpty => 'No trainees in this course yet.';

  @override
  String resourceLibraryUploadFailed(Object error) {
    return 'File upload failed: $error';
  }

  @override
  String get resourceLibraryDefaultCourseName => 'Course';

  @override
  String resourceLibraryNotificationTitle(Object courseName) {
    return 'New file in: $courseName';
  }

  @override
  String resourceLibraryNotificationContent(Object fileName) {
    return 'New file added with title: $fileName';
  }

  @override
  String resourceLibraryCannotOpen(Object fileUrl) {
    return 'Cannot open this file: $fileUrl';
  }

  @override
  String get resourceLibraryTitle => 'Resource Library';

  @override
  String resourceLibraryError(Object error) {
    return 'An error occurred. Make sure to create the required index.\\n\\n$error';
  }

  @override
  String get resourceLibraryEmpty => 'No files in the library yet.';

  @override
  String get resourceLibraryUploading => 'Uploading...';

  @override
  String get resourceLibraryUploadButton => 'Upload File';

  @override
  String get quizListTitle => 'Quizzes';

  @override
  String quizListError(Object error) {
    return 'An error occurred. Make sure to create the required index.\\n\\n$error';
  }

  @override
  String get quizListEmpty => 'No quizzes created yet.';

  @override
  String get quizListViewSubmissions => 'View submissions';

  @override
  String get quizListCreateButton => 'Create Quiz';

  @override
  String quizSubmissionsError(Object error) {
    return 'An error occurred. Make sure to create the required index.\\n\\n$error';
  }

  @override
  String get quizSubmissionsEmpty => 'No trainee has submitted this quiz yet.';

  @override
  String quizSubmissionsResultFormat(Object score, Object total, Object date) {
    return 'Score: $score out of $total\\nSubmitted on: $date';
  }

  @override
  String get traineeListLoading => 'Loading...';

  @override
  String traineeListNotFound(Object traineeId) {
    return 'Trainee not found: $traineeId';
  }

  @override
  String get traineeListUnknownEmail => 'Unknown email';

  @override
  String get personalProfileSectionData => 'Data';

  @override
  String get personalProfileNameLabel => 'Name';

  @override
  String get personalProfileNameRequired => 'Name is required';

  @override
  String get personalProfileEmailLabel => 'Email';

  @override
  String get personalProfileStatsTitle => 'Statistics';

  @override
  String get personalProfileAchievementsTitle => 'Achievements';

  @override
  String get personalProfileRecentActivityTitle => 'Recent activity';

  @override
  String get personalProfileTrainerStatsTitle => 'Training statistics';

  @override
  String get personalProfileSaveButton => 'Save changes';

  @override
  String get personalProfileRoleTrainee => 'Trainee';

  @override
  String get personalProfileRoleTrainer => 'Trainer';

  @override
  String personalProfilePointsLabelShort(Object points) {
    return 'Points: $points';
  }

  @override
  String personalProfileAuthError(Object error) {
    return 'Auth error: $error';
  }

  @override
  String get personalProfileLoginRequired => 'Please log in';

  @override
  String get personalProfileTitle => 'Personal profile';

  @override
  String personalProfileDataLoadError(Object error) {
    return 'Error: $error';
  }

  @override
  String get personalProfileActivitiesLabel => 'Activities';

  @override
  String get personalProfileEvaluationsLabel => 'Evaluations';

  @override
  String get personalProfileEvaluationsGivenLabel => 'Evaluations you gave';

  @override
  String get personalProfileSinceLabel => 'Since';

  @override
  String get personalProfilePointsLabel => 'Points';

  @override
  String get personalProfileNoBadges => 'No badges yet';

  @override
  String personalProfileActivityLoadError(Object error) {
    return 'Failed to load activity: $error';
  }

  @override
  String get personalProfileNoRecentActivity => 'No recent activity yet';

  @override
  String personalProfilePointsCountFormat(Object points) {
    return '$points points';
  }

  @override
  String get personalProfileEventTestPassed => 'Test passed';

  @override
  String get personalProfileEventTaskCompleted => 'Task completed';

  @override
  String get personalProfileEventLessonCompleted => 'Lesson completed';

  @override
  String get personalProfileEventDailyStreak => 'Daily streak';

  @override
  String get personalProfileEventDefault => 'Point event';

  @override
  String get trainerStatsCoursesLabel => 'Courses';

  @override
  String get trainerStatsEvaluationsLabel => 'Evaluations';

  @override
  String get achievementsTitle => 'Achievements';

  @override
  String get achievementsMustLogin => 'You must log in first';

  @override
  String get achievementsFilterByCategory => 'Filter by Category';

  @override
  String get achievementsAll => 'All';

  @override
  String get achievementsSecretAchievement => 'Secret Achievement';

  @override
  String achievementsPoints(Object points) {
    return '$points points';
  }

  @override
  String get achievementsUnlocked => 'Unlocked ✓';

  @override
  String get achievementsLocked => 'Locked 🔒';

  @override
  String achievementsUnlockedOn(Object date) {
    return 'Unlocked: $date';
  }

  @override
  String get achievementsThisIsSecret => 'This is a secret achievement! 🤫';

  @override
  String get achievementsWillDiscoverWhenUnlock =>
      'You\'ll discover it when you unlock it';

  @override
  String get achievementsClose => 'Close';

  @override
  String get achievementsNoAchievementsYet => 'No achievements yet';

  @override
  String get achievementsLoadError =>
      'An error occurred while loading achievements';

  @override
  String get achievementsRetry => 'Retry';

  @override
  String get achievementsStatUnlocked => 'Unlocked';

  @override
  String get achievementsStatPercentage => 'Percentage';

  @override
  String get achievementsStatRemaining => 'Remaining';

  @override
  String get achievementsSecretLocked => 'Secret achievement 🔒';

  @override
  String get analyticsTitle => 'Analytics';

  @override
  String get analyticsOverview => 'Overview';

  @override
  String get analyticsTotalStudents => 'Total Students';

  @override
  String get analyticsActiveStudents => 'Active Students';

  @override
  String get analyticsAvgPoints => 'Avg Points';

  @override
  String get analyticsAvgLevel => 'Avg Level';

  @override
  String get analyticsEngagementRate => 'Engagement Rate';

  @override
  String analyticsEngagementPercent(Object percent) {
    return '$percent% of students are active';
  }

  @override
  String analyticsActiveOf(Object active, Object total) {
    return 'Active: $active of $total';
  }

  @override
  String get analyticsTopStudents => 'Top Students';

  @override
  String get analyticsNoStudents => 'No students yet';

  @override
  String analyticsLevel(Object level) {
    return 'Level $level';
  }

  @override
  String get analyticsPointsLabel => 'Points';

  @override
  String get analyticsPointsStats => 'Points Statistics';

  @override
  String get analyticsPointsAwarded => 'Points Awarded';

  @override
  String get analyticsAchievementsUnlocked => 'Achievements Unlocked';

  @override
  String get analyticsLoadError => 'An error occurred while loading analytics';

  @override
  String get analyticsRetry => 'Retry';

  @override
  String get gamificationSettingsTitle => 'Points Settings';

  @override
  String get gamificationSettingsSave => 'Save';

  @override
  String get gamificationSettingsLoadError =>
      'An error occurred while loading settings';

  @override
  String get gamificationSettingsUnauthorized => 'Unauthorized';

  @override
  String get gamificationSettingsSaveSuccess => '✅ Settings saved successfully';

  @override
  String gamificationSettingsSaveError(Object error) {
    return 'An error occurred while saving settings: $error';
  }

  @override
  String get gamificationSettingsEnableSystem => 'Enable Points System';

  @override
  String get gamificationSettingsDisableNote =>
      'If disabled, no points will be awarded';

  @override
  String get gamificationSettingsCoreActivities =>
      'Core Activities (Mandatory)';

  @override
  String get gamificationSettingsCoreNote =>
      'These activities are always enabled';

  @override
  String get gamificationSettingsCompleteLesson => 'Complete Lesson';

  @override
  String get gamificationSettingsPassQuiz => 'Pass Quiz';

  @override
  String get gamificationSettingsPerfectQuiz => 'Perfect Quiz Score';

  @override
  String get gamificationSettingsCompleteTask => 'Complete Task';

  @override
  String get gamificationSettingsCompleteModule => 'Complete Module';

  @override
  String get gamificationSettingsEnableSocial =>
      'Enable Social Interaction Points';

  @override
  String get gamificationSettingsSocialNote => 'Posts and Comments';

  @override
  String get gamificationSettingsCreatePost => 'Create Post';

  @override
  String get gamificationSettingsWriteComment => 'Write Comment';

  @override
  String get gamificationSettingsHelpPeer => 'Help Peer';

  @override
  String get gamificationSettingsGetReaction => 'Get Reaction';

  @override
  String get gamificationSettingsEnableStreak => 'Enable Daily Login Streak';

  @override
  String get gamificationSettingsStreakNote => 'Encourage continuous login';

  @override
  String get gamificationSettingsDailyLogin => 'Daily Login';

  @override
  String get gamificationSettingsWeekStreak => 'Weekly Streak';

  @override
  String get gamificationSettingsSaveButton => 'Save Settings';

  @override
  String get gamificationSettingsResetDefaults => 'Reset to Defaults';

  @override
  String get gamificationSettingsResetSuccess => 'Default values restored';

  @override
  String gamificationSettingsPointsLabel(Object points) {
    return '$points points';
  }

  @override
  String get moduleDetailTitle => 'Module Details';

  @override
  String moduleDetailError(Object error) {
    return 'An error occurred: $error';
  }

  @override
  String get moduleDetailRetry => 'Retry';

  @override
  String moduleDetailProgressError(Object error) {
    return 'Error loading progress: $error';
  }

  @override
  String get moduleDetailDescription => 'Description';

  @override
  String get moduleDetailContents => 'Module Contents';

  @override
  String moduleDetailCompleteForPoints(Object points) {
    return 'Complete all contents to get $points points';
  }

  @override
  String get moduleDetailModuleCompleted => 'Module Completed! 🎉';

  @override
  String moduleDetailEarnedPoints(Object points) {
    return 'You earned $points points';
  }

  @override
  String get moduleDetailCompleted => 'Completed';

  @override
  String get moduleDetailProgress => 'Progress';

  @override
  String moduleDetailPointsOnCompletion(Object points) {
    return '$points points on completion';
  }

  @override
  String get moduleDetailUnmarkedComplete => 'Unmarked content as completed';

  @override
  String get moduleDetailMarkedComplete => 'Marked content as completed ✓';

  @override
  String moduleDetailMarkError(Object error) {
    return 'An error occurred: $error';
  }

  @override
  String get moduleDetailRequired => 'Required';

  @override
  String get moduleDetailTypeLesson => 'Lesson';

  @override
  String get moduleDetailTypeQuiz => 'Quiz';

  @override
  String get moduleDetailTypeAssignment => 'Assignment';

  @override
  String get moduleDetailTypeResource => 'Resource';

  @override
  String get anomalyDashboardTitle => 'Anomaly Detection';

  @override
  String get anomalyDashboardMustLogin => 'Must be logged in';

  @override
  String get anomalyDashboardFilterStatus => 'Filter by status';

  @override
  String get anomalyDashboardAllStates => 'All States';

  @override
  String get anomalyDashboardPending => 'Pending';

  @override
  String get anomalyDashboardInvestigating => 'Investigating';

  @override
  String get anomalyDashboardResolved => 'Resolved';

  @override
  String get anomalyDashboardTabAll => 'All';

  @override
  String get anomalyDashboardTabHigh => 'High';

  @override
  String get anomalyDashboardTabAlerts => 'Alerts';

  @override
  String get anomalyDashboardNoAnomalies => 'No anomalies detected';

  @override
  String get anomalyDashboardSystemNormal => 'System operating normally';

  @override
  String anomalyDashboardError(Object error) {
    return 'Error: $error';
  }

  @override
  String get anomalyDashboardNoHighRisk => 'No high-risk anomalies';

  @override
  String get anomalyDashboardNoAlerts => 'No alerts';

  @override
  String get anomalyDashboardReviewSuccess => 'Reviewed successfully';

  @override
  String get anomalyDashboardReviewFailed => 'Review failed';

  @override
  String get anomalyDashboardReviewButton => 'Review';

  @override
  String get anomalyDashboardType => 'Type';

  @override
  String get anomalyDashboardSeverity => 'Severity';

  @override
  String get anomalyDashboardStatus => 'Status';

  @override
  String get anomalyDashboardUser => 'User';

  @override
  String get anomalyDashboardDetectedAt => 'Detected At';

  @override
  String get anomalyDashboardDescription => 'Description';

  @override
  String get anomalyDashboardActions => 'Actions';

  @override
  String get anomalyDashboardMarkResolved => 'Mark as Resolved';

  @override
  String get anomalyDashboardInvestigate => 'Investigate';

  @override
  String get myEvaluationsTitle => 'My Evaluations';

  @override
  String get myEvaluationsToggleView => 'Toggle View';

  @override
  String get myEvaluationsMustLogin => 'Must log in first';

  @override
  String get myEvaluationsNoEvaluations => 'No evaluations added for you yet.';

  @override
  String myEvaluationsError(Object error) {
    return 'Error: $error';
  }

  @override
  String myEvaluationsAuthError(Object error) {
    return 'Authentication error: $error';
  }

  @override
  String get myEvaluationsAudioUnavailable =>
      'Unable to play audio evaluation (link currently unavailable)';

  @override
  String get myEvaluationsAudioAccessError =>
      'Unable to access audio file. Check connection.';

  @override
  String myEvaluationsAudioPlayError(Object error) {
    return 'Audio playback failed: $error';
  }

  @override
  String get anomalySettingsTitle => 'Anomaly Detection Settings';

  @override
  String get anomalySettingsSaveSuccess => 'Settings saved successfully';

  @override
  String get anomalySettingsSaveFailed => 'Failed to save settings';

  @override
  String anomalySettingsSaveError(Object error) {
    return 'Error: $error';
  }

  @override
  String get anomalySettingsEnableDetection => 'Enable Anomaly Detection';

  @override
  String get anomalySettingsEnableDetectionSubtitle =>
      'Automatically detect abnormal behavior';

  @override
  String get anomalySettingsEnabledTypes => 'Enabled Anomaly Types';

  @override
  String get anomalySettingsSuspiciousLogin => 'Suspicious Login';

  @override
  String get anomalySettingsSuspiciousLoginDesc =>
      'Unusual devices or locations';

  @override
  String get anomalySettingsAbnormalScores => 'Abnormal Test Scores';

  @override
  String get anomalySettingsAbnormalScoresDesc =>
      'Very high or very low scores';

  @override
  String get anomalySettingsRapidProgress => 'Rapid Progress';

  @override
  String get anomalySettingsRapidProgressDesc =>
      'Completing courses or tests abnormally fast';

  @override
  String get anomalySettingsMultipleDevices => 'Multiple Devices';

  @override
  String get anomalySettingsMultipleDevicesDesc =>
      'Using multiple devices in short time';

  @override
  String get anomalySettingsUnusualActivity => 'Unusual Activity';

  @override
  String get anomalySettingsUnusualActivityDesc =>
      'Excessive or atypical activity';

  @override
  String get anomalySettingsCheatingPattern => 'Cheating Pattern';

  @override
  String get anomalySettingsCheatingPatternDesc =>
      'Patterns indicating cheating attempt';

  @override
  String get anomalySettingsAccountSharing => 'Account Sharing';

  @override
  String get anomalySettingsAccountSharingDesc =>
      'Account used by different people';

  @override
  String get anomalySettingsSensitivity => 'Sensitivity';

  @override
  String get anomalySettingsSensitivityLow => 'Low';

  @override
  String get anomalySettingsSensitivityHigh => 'High';

  @override
  String anomalySettingsSensitivityCurrent(Object percent) {
    return 'Current sensitivity: $percent%';
  }

  @override
  String get anomalySettingsAlerts => 'Alerts';

  @override
  String get anomalySettingsSendAlerts => 'Send Alerts';

  @override
  String get anomalySettingsSendAlertsSubtitle =>
      'Notify admins when anomaly detected';

  @override
  String get anomalySettingsMinimumSeverity => 'Minimum Alert Severity';

  @override
  String get anomalySettingsSeverityLow => 'Low';

  @override
  String get anomalySettingsSeverityMedium => 'Medium';

  @override
  String get anomalySettingsSeverityHigh => 'High';

  @override
  String get anomalySettingsSeverityCritical => 'Critical';

  @override
  String get anomalySettingsAutomatedActions => 'Automated Actions';

  @override
  String get anomalySettingsSuspendCritical => 'Suspend Critical Accounts';

  @override
  String get anomalySettingsSuspendCriticalSubtitle =>
      'Automatically suspend accounts with critical anomalies';

  @override
  String get anomalySettingsFlagCheating => 'Flag Cheating';

  @override
  String get anomalySettingsFlagCheatingSubtitle =>
      'Automatically flag cheating attempts';

  @override
  String get anomalySettingsImportantNotes => 'Important Notes';

  @override
  String get anomalySettingsNote1 =>
      '• Detection uses advanced statistical algorithms';

  @override
  String get anomalySettingsNote2 =>
      '• False positives may occur - always review before action';

  @override
  String get anomalySettingsNote3 =>
      '• Detection improves over time as data accumulates';

  @override
  String get anomalySettingsNote4 =>
      '• High sensitivity = more detections (including false ones)';

  @override
  String get anomalySettingsNote5 =>
      '• Periodic review of settings and results recommended';

  @override
  String get moderationQueueTitle => 'Moderation Queue';

  @override
  String moderationQueueError(Object error) {
    return 'Error: $error';
  }

  @override
  String get moderationQueueNoPending => 'No pending reports';

  @override
  String moderationQueueLoadError(Object error) {
    return 'Error loading reports: $error';
  }

  @override
  String get moderationQueuePending => 'Pending';

  @override
  String get moderationQueueResolved => 'Resolved';

  @override
  String get moderationQueueDismissed => 'Dismissed';

  @override
  String get moderationQueueTotal => 'Total';

  @override
  String moderationQueueReportedBy(Object name) {
    return 'Reported by: $name';
  }

  @override
  String get moderationQueueReason => 'Reason';

  @override
  String get moderationQueueDetails => 'Details';

  @override
  String get moderationQueueContentType => 'Content Type';

  @override
  String get moderationQueueActionWarn => 'Warn';

  @override
  String get moderationQueueActionDelete => 'Delete Content';

  @override
  String get moderationQueueActionMute => 'Mute';

  @override
  String get moderationQueueActionBan => 'Ban';

  @override
  String get moderationQueueActionDismiss => 'Dismiss Report';

  @override
  String get moderationQueueStatusPending => 'Pending Review';

  @override
  String get moderationQueueStatusInvestigating => 'Investigating';

  @override
  String get moderationQueueStatusActionTaken => 'Action Taken';

  @override
  String get moderationQueueStatusDismissed => 'Dismissed';

  @override
  String get moderationQueueStatusResolved => 'Resolved';

  @override
  String moderationQueueConfirmTitle(Object action) {
    return 'Confirm Action: $action';
  }

  @override
  String moderationQueueConfirmMessage(Object action) {
    return 'Are you sure about $action?';
  }

  @override
  String get moderationQueueCancel => 'Cancel';

  @override
  String get moderationQueueConfirm => 'Confirm';

  @override
  String moderationQueueActionCompleted(Object action) {
    return 'Completed $action';
  }

  @override
  String get moderationQueueActionSuccess => 'Action completed successfully';

  @override
  String get moderationQueueActionFailed => 'Action failed';

  @override
  String get moderationQueueReasonInappropriate => 'Inappropriate Content';

  @override
  String get moderationQueueReasonHarassment => 'Harassment';

  @override
  String get moderationQueueReasonSpam => 'Spam';

  @override
  String get moderationQueueReasonMisinformation => 'Misinformation';

  @override
  String get moderationQueueReasonHarmful => 'Harmful Content';

  @override
  String get moderationQueueReasonCopyright => 'Copyright Violation';

  @override
  String get moderationQueueReasonOther => 'Other';

  @override
  String get createBadgeTitle => 'Create New Badge';

  @override
  String get createBadgeSuccess => 'Badge created';

  @override
  String createBadgeError(Object error) {
    return 'Error: $error';
  }

  @override
  String get createBadgeIdLabel => 'ID (unique)';

  @override
  String get createBadgeIdRequired => 'Required';

  @override
  String get createBadgeNameLabel => 'Name';

  @override
  String get createBadgeNameRequired => 'Required';

  @override
  String get createBadgeDescLabel => 'Description';

  @override
  String get createBadgeIconLabel => 'Icon URL (optional)';

  @override
  String get createBadgeIsActive => 'Active';

  @override
  String get createBadgeAutoAward => 'Auto Award';

  @override
  String get createBadgeCriteria => 'Criteria (optional)';

  @override
  String get createBadgePointsMin => 'Points ≥';

  @override
  String get createBadgeStreakMin => 'Daily Streak ≥';

  @override
  String get createBadgeQuizzesMin => 'Quizzes Passed ≥';

  @override
  String get createBadgeTasksMin => 'Tasks Completed ≥';

  @override
  String get createBadgeLessonsMin => 'Lessons Completed ≥';

  @override
  String get createBadgeReviewsMin => 'Reviews Written ≥';

  @override
  String get createBadgeSaveButton => 'Save';

  @override
  String get hrisImportTitle => 'Import Users';

  @override
  String get hrisImportChooseFile => 'Choose CSV or Excel file';

  @override
  String get hrisImportSelectFile => 'Select File';

  @override
  String get hrisImportLoadTemplate => 'Load Saved Template';

  @override
  String get hrisImportUnsupportedFile => 'Unsupported file type';

  @override
  String get hrisImportEmptyFile => 'File is empty or contains only one row';

  @override
  String hrisImportError(Object error) {
    return 'Error: $error';
  }

  @override
  String get hrisImportMapColumns => 'Map Columns';

  @override
  String get hrisImportEmailRequired => 'Email *';

  @override
  String get hrisImportNameRequired => 'Name *';

  @override
  String get hrisImportRoleOptional => 'Role (optional)';

  @override
  String get hrisImportPhoneOptional => 'Phone (optional)';

  @override
  String get hrisImportDepartmentOptional => 'Department (optional)';

  @override
  String get hrisImportJobTitleOptional => 'Job Title (optional)';

  @override
  String get hrisImportSaveAsTemplate => 'Save as Template';

  @override
  String get hrisImportTemplateName => 'Template Name';

  @override
  String get hrisImportPreviewButton => 'Preview';

  @override
  String get hrisImportBackButton => 'Back';

  @override
  String get hrisImportNone => '-- None --';

  @override
  String get hrisImportPreviewTitle => 'Import Preview';

  @override
  String get hrisImportTotal => 'Total';

  @override
  String get hrisImportValid => 'Valid';

  @override
  String get hrisImportInvalid => 'Invalid';

  @override
  String get hrisImportUpdateExisting => 'Update Existing Users';

  @override
  String get hrisImportSampleRecords => 'Sample Records:';

  @override
  String get hrisImportStartButton => 'Start Import';

  @override
  String get hrisImportSuccess => 'Import completed successfully';

  @override
  String get hrisImportNoTemplates => 'No saved templates';

  @override
  String get hrisImportChooseTemplate => 'Choose Template';

  @override
  String get hrisImportCancel => 'Cancel';

  @override
  String get importHistoryTitle => 'Import History';

  @override
  String get importHistoryAuthRequired => 'You must be logged in';

  @override
  String importHistoryError(Object error) {
    return 'Error: $error';
  }

  @override
  String get importHistoryEmpty => 'No import operations';

  @override
  String get importHistoryNewImport => 'New Import';

  @override
  String get importHistoryStatus => 'Status';

  @override
  String get importHistoryTotalRows => 'Total Rows';

  @override
  String get importHistoryProcessed => 'Processed';

  @override
  String get importHistorySuccessful => 'Successful';

  @override
  String get importHistoryFailed => 'Failed';

  @override
  String get importHistoryUploader => 'User';

  @override
  String get importHistoryDate => 'Date';

  @override
  String get importHistoryCompletedAt => 'Completed at';

  @override
  String get importHistoryErrors => 'Errors:';

  @override
  String get importHistoryStatusPending => 'Pending';

  @override
  String get importHistoryStatusProcessing => 'Processing';

  @override
  String get importHistoryStatusCompleted => 'Completed';

  @override
  String get importHistoryStatusFailed => 'Failed';

  @override
  String get importHistoryStatusPartial => 'Partial Success';

  @override
  String get bigqueryExportTitle => 'BigQuery Export';

  @override
  String get bigqueryExportAuthRequired => 'You must be logged in';

  @override
  String get bigqueryExportNotConfigured => 'BigQuery must be configured first';

  @override
  String get bigqueryExportNotEnabled => 'BigQuery is not enabled';

  @override
  String get bigqueryExportStarted => 'Export started successfully';

  @override
  String bigqueryExportError(Object error) {
    return 'Error: $error';
  }

  @override
  String get bigqueryExportNewExport => 'New Export';

  @override
  String get bigqueryExportDataType => 'Data Type';

  @override
  String get bigqueryExportUsers => 'Users';

  @override
  String get bigqueryExportCourses => 'Courses';

  @override
  String get bigqueryExportEnrollments => 'Enrollments';

  @override
  String get bigqueryExportQuizResults => 'Quiz Results';

  @override
  String get bigqueryExportCertificates => 'Certificates';

  @override
  String get bigqueryExportPointsAchievements => 'Points & Achievements';

  @override
  String get bigqueryExportAll => 'All Data';

  @override
  String get bigqueryExportExporting => 'Exporting...';

  @override
  String get bigqueryExportStart => 'Start Export';

  @override
  String get bigqueryExportHistory => 'Export History';

  @override
  String get bigqueryExportRefresh => 'Refresh';

  @override
  String get bigqueryExportNoExports => 'No export operations';

  @override
  String get bigqueryExportDetailStatus => 'Status';

  @override
  String get bigqueryExportDetailType => 'Export Type';

  @override
  String get bigqueryExportDetailTotal => 'Total Records';

  @override
  String get bigqueryExportDetailExported => 'Exported';

  @override
  String get bigqueryExportDetailFailed => 'Failed';

  @override
  String get bigqueryExportDetailUser => 'User';

  @override
  String get bigqueryExportDetailStarted => 'Started at';

  @override
  String get bigqueryExportDetailCompleted => 'Completed at';

  @override
  String get bigqueryExportDetailErrors => 'Errors:';

  @override
  String get bigqueryExportAnalytics => 'Analytics';

  @override
  String get bigqueryExportProgress => 'Progress';

  @override
  String get bigqueryExportStatusPending => 'Pending';

  @override
  String get bigqueryExportStatusProcessing => 'Processing';

  @override
  String get bigqueryExportStatusUploading => 'Uploading';

  @override
  String get bigqueryExportStatusCompleted => 'Completed';

  @override
  String get bigqueryExportStatusFailed => 'Failed';

  @override
  String get bigquerySettingsTitle => 'BigQuery Settings';

  @override
  String get bigquerySettingsSaved => 'Settings saved successfully';

  @override
  String get bigquerySettingsSaveFailed => 'Failed to save settings';

  @override
  String bigquerySettingsError(Object error) {
    return 'Error: $error';
  }

  @override
  String get bigquerySettingsEnableExport => 'Enable BigQuery Export';

  @override
  String get bigquerySettingsExportDescription => 'Export data to BigQuery';

  @override
  String get bigquerySettingsProjectInfo => 'Project Information';

  @override
  String get bigquerySettingsProjectIdHelper => 'Google Cloud Project ID';

  @override
  String get bigquerySettingsProjectIdRequired => 'Project ID is required';

  @override
  String get bigquerySettingsDatasetIdHelper => 'BigQuery Dataset ID';

  @override
  String get bigquerySettingsDatasetIdRequired => 'Dataset ID is required';

  @override
  String get bigquerySettingsServiceAccountHelper =>
      'Service Account JSON credentials';

  @override
  String get bigquerySettingsServiceAccountRequired =>
      'Service Account JSON is required';

  @override
  String get bigquerySettingsInvalidJSON => 'Invalid JSON format';

  @override
  String get bigquerySettingsEnabledDataTypes => 'Enabled Data Types';

  @override
  String get bigquerySettingsUsersTitle => 'Users';

  @override
  String get bigquerySettingsUsersSubtitle => 'User account data';

  @override
  String get bigquerySettingsCoursesTitle => 'Courses';

  @override
  String get bigquerySettingsCoursesSubtitle => 'Training course information';

  @override
  String get bigquerySettingsEnrollmentsTitle => 'Enrollments';

  @override
  String get bigquerySettingsEnrollmentsSubtitle =>
      'Course registration records';

  @override
  String get bigquerySettingsQuizResultsTitle => 'Quiz Results';

  @override
  String get bigquerySettingsQuizResultsSubtitle =>
      'Quiz and assessment results';

  @override
  String get bigquerySettingsCertificatesTitle => 'Certificates';

  @override
  String get bigquerySettingsCertificatesSubtitle =>
      'Certificate issuance records';

  @override
  String get bigquerySettingsGamificationTitle => 'Points & Achievements';

  @override
  String get bigquerySettingsGamificationSubtitle => 'Gamification system data';

  @override
  String get bigquerySettingsAnalyticsTitle => 'Analytics';

  @override
  String get bigquerySettingsAnalyticsSubtitle => 'Usage analytics data';

  @override
  String get bigquerySettingsProgressTitle => 'Progress';

  @override
  String get bigquerySettingsProgressSubtitle => 'Learning progress data';

  @override
  String get bigquerySettingsSchedule => 'Export Schedule';

  @override
  String get bigquerySettingsScheduleHourly => 'Hourly';

  @override
  String get bigquerySettingsScheduleDaily => 'Daily';

  @override
  String get bigquerySettingsScheduleWeekly => 'Weekly';

  @override
  String get bigquerySettingsScheduleManual => 'Manual';

  @override
  String get bigquerySettingsSaveButton => 'Save Settings';

  @override
  String get bigquerySettingsImportantNotes => 'Important Notes';

  @override
  String get bigquerySettingsSetupSteps =>
      '• Create a Google Cloud project and enable BigQuery API\n• Create a Service Account and download JSON file\n• Grant appropriate permissions to the Service Account\n• Create a Dataset in BigQuery beforehand\n• Tables will be created automatically during export';

  @override
  String courseDetailsNewPostTitle(Object courseName) {
    return 'New post in: $courseName';
  }

  @override
  String courseDetailsNewPostContent(Object authorEmail) {
    return '$authorEmail added a new post.';
  }

  @override
  String courseDetailsError(Object error) {
    return 'An error occurred: $error';
  }

  @override
  String get courseDetailsMoreOptions => 'More options';

  @override
  String get courseDetailsBadges => 'Badges & Achievements';

  @override
  String get courseDetailsLeaderboard => 'Leaderboard';

  @override
  String get courseDetailsAchievements => 'Achievements';

  @override
  String get courseDetailsModules => 'Learning Modules';

  @override
  String get courseDetailsQuizzes => 'Quizzes';

  @override
  String get courseDetailsResources => 'Resource Library';

  @override
  String get courseDetailsTrainees => 'Trainees';

  @override
  String get courseDetailsAnalytics => 'Course Analytics';

  @override
  String get courseDetailsPointsSettings => 'Points Settings';

  @override
  String get courseDetailsMyEvaluations => 'My Evaluations';

  @override
  String get courseDetailsInfoTitle => 'Course Information';

  @override
  String get courseDetailsInfoContent => 'Full course details';

  @override
  String get courseDetailsClose => 'Close';

  @override
  String get courseDetailsNoPosts => 'No posts';

  @override
  String get courseDetailsChangeFilters => 'Try changing the search settings';

  @override
  String get courseDetailsPlaceholder => 'What do you want to share?';

  @override
  String get courseDetailsAddImages => 'Add images';

  @override
  String get courseDetailsCreatePoll => 'Create poll';

  @override
  String get courseDetailsTrainerFallback => 'Trainer';

  @override
  String get courseDetailsAuthRequired => 'You must log in first';

  @override
  String get modulesEmptyTitle => 'No learning modules yet';

  @override
  String get modulesEmptySubtitle => 'Modules will be added soon';

  @override
  String get modulesLoadError => 'An error occurred while loading modules';

  @override
  String get modulesLockedMessage => 'Locked - complete the previous module';

  @override
  String modulesContentCount(Object count) {
    return '$count content';
  }

  @override
  String modulesProgressFormat(Object completed, Object total) {
    return '$completed/$total completed';
  }

  @override
  String get forgotPasswordSuccess => 'Password reset link sent to your email';

  @override
  String get evaluationLoadError => 'Error loading evaluation';

  @override
  String get quizHubCreatingTask => '... Creating task';

  @override
  String get quizHubNoAttempts => 'No attempts yet';

  @override
  String quizHubLatestScore(Object score, Object count) {
    return 'Latest score: $score | Total attempts: $count';
  }

  @override
  String get unknownUserInitial => '?';

  @override
  String get emailVerificationSuccess =>
      'Your email has been verified successfully! 🎉';

  @override
  String get emailVerificationPending =>
      'Email not verified yet. Please open your email and click the verification link.';

  @override
  String emailVerificationError(Object error) {
    return 'An error occurred: $error';
  }

  @override
  String emailVerificationLinkSent(Object email) {
    return 'Verification link sent to $email';
  }

  @override
  String emailVerificationSendError(Object error) {
    return 'Error sending email: $error';
  }

  @override
  String get emailVerificationLogout => 'Log out';

  @override
  String get emailVerificationTitle => 'Verify Your Email';

  @override
  String get emailVerificationSentTo => 'We sent a verification link to:';

  @override
  String get emailVerificationInstructions =>
      'Please open your email and click the verification link';

  @override
  String get emailVerificationSpamNote =>
      '(Check your Spam folder if you don\'t see the message)';

  @override
  String get emailVerificationChecking => 'Checking...';

  @override
  String get emailVerificationChecked => 'I verified my email';

  @override
  String get emailVerificationResending => 'Sending...';

  @override
  String get emailVerificationResend => 'Resend email';

  @override
  String get emailVerificationWhy =>
      'Why do we need verification?\nTo ensure your email is correct and you can recover your account later.';

  @override
  String anomalyError(Object error) {
    return 'Error: $error';
  }

  @override
  String get anomalyDetailType => 'Type';

  @override
  String get anomalyDetailSeverity => 'Severity';

  @override
  String get anomalyDetailScore => 'Score';

  @override
  String get anomalyDetailConfidence => 'Confidence Level';

  @override
  String get anomalyDetailUser => 'User';

  @override
  String get anomalyDetailStatus => 'Status';

  @override
  String get anomalyDetailDetected => 'Detected';

  @override
  String get anomalyDetailEvidence => 'Evidence:';

  @override
  String get anomalyDetailReview => 'Review:';

  @override
  String get anomalyDetailReviewer => 'Reviewer';

  @override
  String get anomalyDetailReviewDate => 'Review Date';

  @override
  String get anomalyDetailNotes => 'Notes';

  @override
  String get anomalyTypeSuspiciousLogin => 'Suspicious login';

  @override
  String get anomalyTypeAbnormalQuizScore => 'Abnormal quiz score';

  @override
  String get anomalyTypeRapidProgress => 'Rapid progress';

  @override
  String get anomalyTypeMultipleDevices => 'Multiple devices';

  @override
  String get anomalyTypeUnusualActivity => 'Unusual activity';

  @override
  String get anomalyTypeCheatingPattern => 'Cheating pattern';

  @override
  String get anomalyTypeAccountSharing => 'Account sharing';

  @override
  String get anomalySeverityLow => 'Low';

  @override
  String get anomalySeverityMedium => 'Medium';

  @override
  String get anomalySeverityHigh => 'High';

  @override
  String get anomalySeverityCritical => 'Critical';

  @override
  String get anomalyStatusPending => 'Pending';

  @override
  String get anomalyStatusInvestigating => 'Investigating';

  @override
  String get anomalyStatusResolved => 'Resolved';

  @override
  String get anomalyStatusFalsePositive => 'False Positive';

  @override
  String get anomalyStatusConfirmed => 'Confirmed';

  @override
  String get anomalyReviewDialogTitle => 'Review Anomaly';

  @override
  String get anomalyReviewStatusLabel => 'Status';

  @override
  String get anomalyReviewNotesLabel => 'Notes (optional)';

  @override
  String get manualGradeTitle => 'Manual Grading';

  @override
  String get manualGradeSaveSuccess => 'Grading saved';

  @override
  String manualGradeSaveError(Object error) {
    return 'Failed: $error';
  }

  @override
  String get manualGradeNotFound => 'Submission not found';

  @override
  String manualGradeTraineeLabel(Object trainee) {
    return 'Trainee: $trainee';
  }

  @override
  String manualGradeAutoScore(Object score) {
    return 'Auto score: $score';
  }

  @override
  String get manualGradeNoAnswer => 'No answer';

  @override
  String get manualGradeQuestionScore => 'Question score (integer)';

  @override
  String get manualGradeSaveButton => 'Save Grading';

  @override
  String get manualGradingReviewTitle => 'Review Text Answers';

  @override
  String get manualGradingNoSubmissions =>
      'No submissions need manual grading.';

  @override
  String manualGradingAutoScoreLabel(Object auto, Object total) {
    return 'Auto score: $auto / $total';
  }
}
