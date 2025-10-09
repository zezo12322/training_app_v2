import 'package:flutter/widgets.dart';
// Use the generated localization classes (gen/). The manual copies in lib/l10n should not be imported here.
import '../l10n/gen/app_localizations.dart';

/// Convenience extension to get non-null localizations (assumes widget tree is wrapped properly).
extension L10nX on BuildContext {
  /// Primary localized strings accessor (non-null; assumes MaterialApp configured).
  AppLocalizations get l => AppLocalizations.of(this);

  // Forwarders to generated localization keys (keeps call-sites stable)
  // Settings → Administration entries
  String get orgAdminDashboardTitle => l.orgAdminDashboardTitle;
  String get orgAdminDashboardSubtitle => l.orgAdminDashboardSubtitle;

  String get companyAdminDashboardTitle => l.companyAdminDashboardTitle;
  String get companyAdminDashboardSubtitle => l.companyAdminDashboardSubtitle;

  String get departmentsTitle => l.departmentsTitle;
  String get departmentsSubtitle => l.departmentsSubtitle;

  String get learningPathsTitle => l.learningPathsTitle;
  String get learningPathsSubtitle => l.learningPathsSubtitle;

  String get managerDashboardTitle => l.managerDashboardTitle;
  String get managerDashboardSubtitle => l.managerDashboardSubtitle;

  String get bulkImportTitle => l.bulkImportTitle;
  String get bulkImportSubtitle => l.bulkImportSubtitle;

  String get selectDepartmentHint => l.selectDepartmentHint;

  // Company Admin Dashboard labels
  String get labelActiveUsers => l.labelActiveUsers;
  String get labelAvgEventsPerUser7d => l.labelAvgEventsPerUser7d;
  String get labelAvgMastery => l.labelAvgMastery;
  String get labelAvgMasteryDelta14d => l.labelAvgMasteryDelta14d;
  String get labelLatestPrefix => l.labelLatestPrefix;
  String get labelLatest7Days => l.labelLatest7Days;
  String get labelDate => l.labelDate;
  String get labelActiveShort => l.labelActiveShort;
  String get labelAvgEvPerUsrShort => l.labelAvgEvPerUsrShort;
  String get labelAvgMasteryShort => l.labelAvgMasteryShort;
  String get labelDelta14dShort => l.labelDelta14dShort;

  // Departments screen helpers
  String get noDepartments => l.noDepartments;
  String idLabel(String id) => l.idLabel(id);

  // Manager dashboard helpers
  String get noTeamMembers => l.noTeamMembers;
  String get topSkillGapsTitle => l.topSkillGapsTitle;
  String get noSkillData => l.noSkillData;

  // Learning paths helpers
  String get activeChip => l.activeChip;
  String get inactiveChip => l.inactiveChip;
  String pathTitle(String title) => l.pathTitle(title);
  String get noLearningPaths => l.noLearningPaths;
  String get noSteps => l.noSteps;

  // Departments/Assignments extras
  String get departmentsAddAction => l.departmentsAddAction;
  String get departmentNameLabel => l.departmentNameLabel;
  String get assignUserToDepartmentTitle => l.assignUserToDepartmentTitle;
  String get departmentMembersTitle => l.departmentMembersTitle;
  String get manageMembersAction => l.manageMembersAction;
  String get assignMemberAction => l.assignMemberAction;
  String get searchUsersLabel => l.searchUsersLabel;
  String get noResults => l.noResults;
  String get assignSelectedAction => l.assignSelectedAction;
  String get selectAtLeastOneUser => l.selectAtLeastOneUser;
  String assignmentCompletedToast(int count) => l.assignmentCompletedToast(count);
  String get removeMemberConfirm => l.removeMemberConfirm;
  String get memberRemovedToast => l.memberRemovedToast;
  String departmentCreatedToast(String name) => l.departmentCreatedToast(name);
  String get alreadyMemberLabel => l.alreadyMemberLabel;
}

