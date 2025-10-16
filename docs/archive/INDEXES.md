# Firestore Indexes Plan

This file tracks required and candidate composite indexes. Keep it updated when adding queries.

## Principles
- Prefer single-field indexes already auto-created unless composite needed.
- Always justify composite by an actual query shape (fields, filters, order).
- Avoid over-indexing high-churn collections (write amplification cost).

## Current / Planned Composite Indexes
| Collection | Fields (order) | Query Use | Status |
|------------|----------------|-----------|--------|
| user_points_events | userId ASC, createdAt DESC | Per-user recent events feed | pending |
| engagement_snapshots | userId ASC, date DESC | Pull last N snapshots per user | pending |
| risk_user_scores | userId ASC, date DESC | Sparkline / trend for a user | pending |
| security_events | type ASC, ts DESC | Filter by type with recent ordering | pending |
| security_events | userId ASC, ts DESC | Investigate one actor recent events | pending |
| predictive_alerts | severity DESC, createdAt DESC | Severity-sorted alert table | pending |
| intrusion_alerts | status ASC, severity DESC | Triage queue ordering | pending |
| integrity_flags | userId ASC, ts DESC | User integrity history | pending |
| admin_audit_logs | actionType ASC, createdAt DESC | Filter actions quickly | pending |
| learning_paths | tenantType ASC, tenantId ASC, createdAt DESC | Company/institution paths list ordered by createdAt | pending |
| path_steps | pathId ASC, order ASC | Steps for a path ordered by order | pending |
| risk_user_scores | userId ASC, createdAt DESC | Latest risk score per user (where userId + orderBy createdAt) | pending |
| tenant_metrics_daily | tenantType ASC, tenantId ASC, date DESC | Latest tenant metrics chart/table | pending |
| badge_awards | userId ASC, awardedAt DESC | Per-user badge feed ordered by awardedAt | pending |
| quizzes | courseId ASC, createdAt DESC | Quizzes list by course ordered by createdAt | pending |
| quiz_submissions | traineeId ASC, courseId ASC, submittedAt DESC | Trainee submissions for a course ordered by submittedAt | pending |

## Single Field Index Exceptions
If a query only filters on one field and orders by another different field, a composite may still be required (filter + order). Document here when discovered.

| Query Pattern | Needed Composite? | Notes |
|---------------|------------------|-------|
| security_events where vector==X order by ts desc | maybe | Add if fails in console |
| risk_user_scores where userId==X order by createdAt desc | yes | Added above |
| learning_paths where tenantType==X and tenantId==Y order by createdAt desc | yes | Added above |
| tenant_metrics_daily where tenantType==X and tenantId==Y order by date desc | yes | Added above |
| path_steps where pathId==X order by order | yes | Added above |
| badge_awards where userId==X order by awardedAt desc | yes | Added above |

## Index Review Checklist
- [ ] Query appears in production code (provider / repository)
- [ ] Explain necessity (latency, ordering, filtering)
- [ ] Evaluate write amplification impact
- [ ] Confirm not replaceable by denormalized field or alternative structure

## Maintenance
Quarterly: prune unused indexes (check console usage stats).