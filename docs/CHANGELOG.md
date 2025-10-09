# Changelog

## [Unreleased]
- Added structured logging helpers (functions/logging.js) + integrated into CFs.
- Added retention planning scheduled function (planRetentionTasks) (dry-run only).
- Added multi-tenancy role gating (org_admin, company_admin) + feature-flagged read scoping for users.
- Added strategic docs: INDEXES, LOGGING_FORMAT, DATA_RETENTION, RELEASE_PROCESS.
- Added client correlationId helper & wrapper (logging.dart) and marked roadmap item.
- Added initial Firestore rules simulation harness (tools/rules_simulation.js).
- Added SuperAdmin dashboard flags status widget (tenant reads/writes indicators).
- Added secure feature flag toggle callable (toggleFeatureFlag) with audit logging.

## Phase 0.x Completion
- SuperAdmin dashboard foundations, predictive risk, intrusion & integrity detection placeholders.

## Phase 1 (In Progress)
- Tenant models, helpers, feature flags, scoped read enforcement (users collection).
