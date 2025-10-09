# Changelog

## [Unreleased]
### Added
- buildTenantMetricsDaily scheduled CF (initial active users per tenant aggregation)
 - buildTenantMetricsDaily refined: now uses engagement_snapshots (events7d) and computes avgEventsPerUser7d
 - Tenant invitation system: createInvite & acceptInvite callables + tenant_invites collection + Firestore rules (read-only to super_admin)
 - Added suspension-aware write gating in Firestore rules (institutionActive/companyActive)
 - Scheduled CFs: purgeOldSecurityEvents (60d cleanup) & aggregateMonthlyPoints (user_points_monthly backfill)
 - B2C Phase 2 kickoff: Added `skills`, `user_skill_stats` models + scheduled placeholder `updateSkillMasteryDeltas`
 - Mastery pipeline: `skill_attempts` collection + rules, scheduled `recomputeSkillMastery` CF (attempt-based masteryScore)
 - Mastery delta14d: Enhanced `recomputeSkillMastery` to compute 14d vs previous 14d performance; deprecated random delta updater
- Firestore rules: tenant_metrics_daily block (server writes only, super_admin read)
- Feature flag toggle callable (toggleFeatureFlag) + audit logging
- Structured logging helpers (logging.js) + integration across CFs
- SuperAdmin dashboard flags status widget (shows enforceTenantReads / enforceTenantWrites)
### Changed
- Scoped write enforcement now feature-flagged (enforceTenantWrites) for courses, tasks, quizzes, course_resources
### Pending
- Expand rule simulation harness for write denial tests
- Implement purge CF (security_events aging) & monthly points aggregation
- Invitation lifecycle (tenant_invites) & governance actions

