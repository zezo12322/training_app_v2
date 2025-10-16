# Tenant Migration & Scoping Activation Guide

This document describes the staged approach for moving from a flat user space to multi-tenant (institutions + companies) while minimizing risk.

## Objectives
1. Introduce tenant identifiers (institutionId, companyId) without breaking existing B2C usage.
2. Populate identifiers for existing accounts (best-effort heuristic + manual curation).
3. Gradually restrict read/write access using Firestore rule helpers (`sameInstitution`, `sameCompany`).
4. Provide rollback levers until confidence is achieved.

## Stages
### Stage 0 – Passive Fields
- Fields `institutionId`, `companyId` added to `users` model (nullable).
- No rule changes; all behavior unchanged.

### Stage 1 – Data Population
- Run backfill script: `dart run tools/backfill_tenants.dart` (first in DRY_RUN mode).
- Export mapping CSV for review (future enhancement).
- Manually adjust edge cases (VIP trainers, test accounts).

### Stage 2 – Soft Read Hints (Optional)
- UI surfaces start showing tenant grouping to super admins.
- Add analytics counts (active users per tenant) without enforcement.

### Stage 3 – Scoped Reads
- Enable guarded rule lines (example):
  ```javascript
  // match /courses/{courseId} { allow get: if sameInstitution(resource) || sameCompany(resource); }
  ```
- Keep super_admin override path.
- Monitor error spikes (permission-denied) before proceeding.

### Stage 4 – Scoped Writes
- Apply create/update restrictions where cross-tenant leakage risk is higher (e.g., tasks, evaluations).
- Provide temporary feature flag in `system_settings.thresholds.enforceTenantWrites = true`.

### Stage 5 – Full Enforcement & Auditing
- All sensitive collections require tenant match.
- Audit log entries for elevated changes across tenant boundaries.

## Backfill Script Usage
```
DRY_RUN=true dart run tools/backfill_tenants.dart
DRY_RUN=false dart run tools/backfill_tenants.dart
```
Environment variable `DRY_RUN` controls write execution.

## Mapping Heuristics
- Company assignment: email domain → `domainCompanyMap`.
- Institution assignment: academic domains → `academicDomains`.
- Unknown domain: remain global (null) until manually curated.

## Monitoring & Metrics
Track (by day):
- % users with tenantId assigned.
- Permission-denied count after enforcement enablement.
- Cross-tenant query attempts flagged in `security_events`.

## Rollback
- Revert rule changes (comment out scoped conditions) while retaining data.
- No destructive schema changes required.

## Future Enhancements
- Add tenant onboarding wizard (creates institution/company doc and invites admin user).
- Tenant usage KPIs via `tenant_metrics_daily` aggregation function.
- Dynamic quota / plan enforcement hooks.

---
**End of TENANT_MIGRATION guide**
