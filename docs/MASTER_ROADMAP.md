# Master Roadmap & Architecture Plan

_Last updated: 2025-10-09 (updated: i18n fallbacks removed, manager auto-open, company_admin write flows for departments and member mappings, member management UI, manager per-member assign/remove, enhanced user search + confirmations/toasts with existing-member exclusion label, l10n config cleanup, onboarding refactor to avoid BuildContext across async gaps, analyzer warnings cleared, learning paths server-side progress callable, indexes doc updated)_

This document unifies: 
1. SuperAdmin Phase (global oversight + predictive risk + intrusion detection)
2. B2C (Trainer ↔ Trainee) feature track
3. Education (Institutions) track
4. Corporate (L&D / Talent) track
5. Cross-cutting analytics, gamification, security, and scalability layers

---
## Table of Contents
- [Vision Layers](#vision-layers)
- [Role Model](#role-model)
- [Data Model Extensions](#data-model-extensions)
- [Security & Firestore Rules Concepts](#security--firestore-rules-concepts)
- [SuperAdmin Capability Suite](#superadmin-capability-suite)
  - [A. Global Oversight](#a-global-oversight)
  - [B. Predictive Risk Dashboard](#b-predictive-risk-dashboard)
  - [C. Intrusion & Attack Detection](#c-intrusion--attack-detection)
  - [D. Audit & Governance](#d-audit--governance)
- [Risk Scoring & Heuristics](#risk-scoring--heuristics)
- [Attack / Exploit Classification Taxonomy](#attack--exploit-classification-taxonomy)
- [Collections Summary](#collections-summary)
- [Phased Roadmap](#phased-roadmap)
  - [Phase 0.x (SuperAdmin + Predictive + Intrusion)](#phase-0x-superadmin--predictive--intrusion)
  - [Phase 1 (Foundations: Multi-Tenancy Seed)](#phase-1-foundations-multi-tenancy-seed)
  - [Phase 2 (B2C Growth: Mastery & Engagement)](#phase-2-b2c-growth-mastery--engagement)
  - [Phase 3 (Education MVP)](#phase-3-education-mvp)
  - [Phase 4 (Corporate MVP)](#phase-4-corporate-mvp)
  - [Phase 5 (Advanced Expansion)](#phase-5-advanced-expansion)
- [Feature Bundles & DoD Templates](#feature-bundles--dod-templates)
- [Checklists (Detailed)](#checklists-detailed)
- [KPIs Per Track](#kpis-per-track)
- [Risk & Mitigation Table](#risk--mitigation-table)
- [Incremental Delivery Strategy](#incremental-delivery-strategy)
- [Appendix: Example Firestore Rule Snippets](#appendix-example-firestore-rule-snippets)

---
## Vision Layers
| Layer | Purpose | Key Artifacts |
|-------|---------|---------------|
| Engagement & Gamification | Drive retention & motivation | Points Events, Badges, Weekly Challenges, Mastery, Quests |
| Intelligence & Predictive | Early warning & personalization | Risk scores, anomaly flags, recommendations |
| Multi-Tenant Delivery | Support institutions & companies | institutionId / companyId scoping, dashboards |
| Security & Integrity | Reliability & defense-in-depth | SuperAdmin oversight, intrusion signals, audit log |
| Analytics & Reporting | Insight & optimization | Aggregations, exports, skill gap stats |

---
## Role Model
```
role ∈ {
  trainee,
  trainer,
  org_admin,
  company_admin,
  manager,
  employee,
  super_admin
}
```
Optional pivot to unified `tenant_admin` later if we merge institutions & companies.

---
## Data Model Extensions
Core new collections / documents (subset):
```
users: { role, institutionId?, companyId?, status, createdAt }
institutions: { name, planTier, active, createdAt }
companies: { name, planTier, active, createdAt }
departments: { companyId, name }
user_department_map: { userId, departmentId }
skills: { code, name, category, priority }
user_skill_stats: { userId, skillCode, masteryScore, attempts, lastUpdate, delta14d }
weekly_challenges: { activeRange, targetType, targetValue, scope }
user_challenge_progress: { userId, challengeId, progress, completedAt? }
quests / quest_steps / user_quest_state
learning_paths / path_steps / user_path_progress
engagement_snapshots: { userId, date, events7d, lastActiveTs, streak, masteryDelta14d }
risk_user_scores: { userId, date, score, factors, level }
tenant_metrics_daily: { tenantId, date, activeUsers, events, avgMastery }
risk_tenant_scores: { tenantId, date, score, factors, level }
user_points_events (existing)
user_points (existing)
badge_awards (existing subcollection)
integrity_flags: { userId, type, ts, details }
predictive_alerts: { category, targetId, score, severity, resolved }
system_settings: { featureFlags, updatedAt }
admin_audit_logs: { actorId, actionType, target, meta, createdAt }
-- Intrusion / Security --
security_events: { type, userId?, ipHash, uaHash, ts, severity, meta }
security_daily_rollups: { date, intrusionCount, topTypes:[], anomalyScore }
intrusion_alerts: { id, category, vector, firstSeen, lastSeen, count, status }
rate_limit_counters: { key (ip|user), windowStart, count }
```

---
## Security & Firestore Rules Concepts
- `isSuperAdmin()`: elevated read across all collections; restricted write to system-wide entities.
- Tenant scoping functions: `sameInstitution(doc)`, `sameCompany(doc)`.
- Write operations for high-integrity surfaces (user_points, risk scores) → server-owned (Cloud Functions only).
- SuperAdmin guard-rails: some updates discouraged (e.g., direct badge awarding) unless via approved endpoints.
 - Company Admin write scope: allow `company_admin` to create/update/delete `departments` and manage `user_department_map` only within their own `companyId` with field restrictions and cross-company moves prevented.

---
## SuperAdmin Capability Suite
### A. Global Oversight
Dashboards:
- Global Stats (total users, active 24h, institutions, companies)
- Role Distribution (pie)
- Points Economy snapshot (total points, average per active user)
- Feature Flags toggle

### B. Predictive Risk Dashboard
**Risk Domains**: user dropout, tenant health, engagement decline, integrity anomalies, permission spikes, function reliability.

**Views**:
- Summary Cards (High-Risk Users, Tenants, Integrity Flags 24h, Error Spike Active)
- Trend Charts (avg userRisk 7d, avg tenantRisk 7d, permissionDeniedRatio, cfFailureRate)
- Tables (Users, Tenants, Alerts) with drilldown (factor contribution breakdown)
- Alert triage (resolve / mute / escalate)

### C. Intrusion & Attack Detection
#### Objectives
Early detection of malicious or abusive patterns before data corruption or service degradation.

#### Signal Categories
| Category | Examples | Detection Method |
|----------|----------|------------------|
| Auth Abuse | Brute-force login attempts | Rate counters on failed auth (if integrated; for now client logs) |
| Privilege Escalation Attempts | Attempts to write forbidden fields (e.g., role change) | Firestore rules denial + client log hook |
| Enumeration | Rapid document ID probing | High get/list denials ratio per user/IP |
| Flood / DoS (Soft) | Spike in identical requests | Rate window counters |
| Injection Patterns | Suspicious characters in free text (e.g., `{ "$gt": ... }`) | Client-side pre-filter + server validation |
| Token Replay | Same auth token used from divergent geo/time windows | IP / UA hash drift events |
| Points Inflation Abuse | Rapid sequence of points events beyond expected thresholds | Integrity flag pipeline |
| Gamification Exploit | Repeated badge award triggers | Deduplicate & escalate frequency |
| Automation / Bot | Extremely consistent inter-request intervals | Jitter variance anomaly |

#### Data Flow
1. Client instrumentation emits `security_events` for notable denied operations.
2. Cloud Functions wrappers (where present) log failures / suspicious payload traits.
3. Scheduler aggregates into `security_daily_rollups` + updates `intrusion_alerts` if thresholds passed.
4. SuperAdmin dashboard consumes aggregated + live feed.

#### Intrusion Alert Structure
```
{ vector: 'privilege_escalation', category:'auth|rules|integrity', count, firstSeen, lastSeen, severity:'low|med|high', status:'open|resolved|muted' }
```

### D. Audit & Governance
- `admin_audit_logs`: every privileged action (create tenant, role elevate, toggle flag, resolve alert)
- Tamper resistance: writes only by Cloud Function callable verifying role.
- Retention: rotate older logs to cold storage (future).

---
## Risk Scoring & Heuristics
### User Risk (baseline)
```
score = 0.35 * lastActiveNormalized
      + 0.25 * lowEventsComponent
      + 0.20 * streakBreakProb
      + 0.20 * skillPlateauFlag
```
### Tenant Risk
```
score = 0.4 * negativeSlope(activeUsers7d)
      + 0.25 * negativeSlope(avgEventsPerUser7d)
      + 0.2 * permissionDeniedRatio
      + 0.15 * cfFailureRate
```
### Integrity / Intrusion Severity (heuristic)
- Points spike > 3σ : severity=high
- Repeated role mutation denial (≥5 in hour): privilege_escalation alert
- Denial ratio > 0.4 for user with ≥ 20 operations: enumeration suspicion

---
## Attack / Exploit Classification Taxonomy
| Code | Name | Description | Sample Trigger |
|------|------|-------------|----------------|
| INJ_JSON | Injection Pattern | Malformed JSON / operator signature | payload contains `$gt`, `$where` |
| PRIV_ESC | Privilege Escalation | Attempt to update protected role fields | denied update on users.role |
| ENUM_DOC | Enumeration | High volume invalid doc IDs | >X not-found + permission-denied combo |
| RATE_FLOOD | Flood / Rate Abuse | Exceeding soft request window | count/window > threshold |
| POINTS_FARM | Points Inflation | High velocity point events | >N events / minute |
| BADGE_SPAM | Badge Attempt Spam | Repeated badge creation attempts denied | denied create badges |
| TOKEN_REPLAY | Token/Session Replay | Suspicious geo/time divergence | IP hash flip + low activity gap |
| BOT_PATTERN | Bot Behavioral | Uniform request timing / no UI variance | low jitter coefficient |
| RULES_SPIKE | Rules Denial Spike | Step-change in permission denied errors | ratio delta > setpoint |

---
## Collections Summary
(See Data Model section; this table focuses on new security/predictive ones.)
| Collection | Ownership | Access | Write Source |
|------------|-----------|--------|--------------|
| security_events | Append-only | super_admin | client (instrumented) + CF |
| security_daily_rollups | Aggregated | super_admin | scheduled CF |
| intrusion_alerts | Managed | super_admin | detection CF |
| integrity_flags | Managed | super_admin | detection CF |
| predictive_alerts | Managed | super_admin | detection CF |
| risk_user_scores | Analytical | super_admin (maybe user self) | scheduled CF |
| risk_tenant_scores | Analytical | super_admin | scheduled CF |
| admin_audit_logs | Compliance | super_admin | CF callable only |

---
## Phased Roadmap
### Phase 0.x (SuperAdmin + Predictive + Intrusion)
Goal: Administrative visibility + early signals foundation.
| Step | Feature | Outcome |
|------|---------|---------|
| 0.1 | SuperAdmin role + basic dashboard | Global list of users & tenants placeholder |
| 0.2 | Predictive baseline (userRisk) | risk_user_scores + simple alerts |
| 0.3 | Intrusion event logging (security_events) | Raw capture of suspicious attempts |
| 0.4 | Aggregations (snapshots + rollups) | engagement_snapshots, security_daily_rollups |
| 0.5 | Alert surfaces (predictive_alerts, intrusion_alerts) | Triage UI in dashboard |
| 0.6 | Integrity flags (points spike) | Early fraud signals |
| 0.7 | Audit log + resolve/mute flows | Governance & accountability |

### Phase 1 (Foundations: Multi-Tenancy Seed)
Add institutionId / companyId fields, role scaffolding, enforcement flags, initial analytics.
Completed:
- [x] Augment user creation with institutionId/companyId fields
- [x] Institution & company models (`institutions`, `companies`) + rule placeholders
- [x] Departments & mapping placeholders
- [x] Tenant helper rule functions: `sameInstitution()`, `sameCompany()`
- [x] Backfill script (`tools/backfill_tenants.dart`)
- [x] SuperAdmin listing UI (Institutions / Companies)
- [x] Migration guide (`docs/TENANT_MIGRATION.md`)
- [x] Feature flag scaffolding (`enforceTenantReads`, `enforceTenantWrites`)
  - [x] org_admin / company_admin roles + rule helpers (scoped user reads)
  - [x] Scoped read activation gated by `enforceTenantReads`
  - [x] Scoped writes gating via `enforceTenantWrites` (courses, tasks, quizzes, course_resources)
- [x] Scheduled CF: `buildTenantMetricsDaily` (initial active user counts per tenant)
Remaining (Phase 1 Hardening):
- [x] Expand rule simulation harness (deny/allow matrix incl. write enforcement)
- [x] Refine tenant metrics (integrate engagement snapshots events7d, avgMastery placeholder)
- [x] Invitation workflow (`tenant_invites` + createInvite / acceptInvite callables + audit)
- [x] Purge CF for aged `security_events` (purgeOldSecurityEvents) & monthly points aggregation (aggregateMonthlyPoints)
- [x] Suspended tenant rule clause (institutionActive/companyActive gating writes)


### Phase 5 (Advanced Expansion)
Adaptive recommendations, Economy tokens, Certificates, SSO, HRIS, BigQuery export, AI tutor, advanced anomaly ML.
---
## Feature Bundles & DoD Templates
### Phase 1 (Foundations) — Checklist (mirrors summary above)
- [x] Augment user creation with institutionId/companyId
- [x] Institution & company models created + placeholders
- [x] Departments & mapping placeholders
- [x] Tenant helper rule functions
- [x] Backfill script placeholder
- [x] SuperAdmin listing UI (tenants)
- [x] Migration guide doc
- [x] Feature flag scaffolding (reads / writes)
  - [x] org_admin & company_admin roles + rule whitelists
  - [x] Scoped user read gating
  - [x] Scoped writes gating (courses, tasks, quizzes, course_resources)
- [x] Scheduled CF: buildTenantMetricsDaily (initial)
- [ ] Rule simulation harness expansion
- [ ] Refine tenant metrics (events7d, avgMastery)
- [ ] Invitation & governance workflows
- [ ] Suspended tenant clause
**Template (applies to each feature):**
```
Design: schema + access rules
Data: collection + indexes
Security: rule additions published
Backend: CF triggers / scheduled jobs
Providers: Riverpod surface (stream/future)
UI: widgets/screens
Telemetry: event instrumentation (optional early)
DoD: manual test cases + no analyzer errors + rule simulation passes
```

---
## Checklists (Detailed)
### Phase 0.x SuperAdmin & Predictive Security
- [x] Add `super_admin` role to `AppUser`
- [x] Helper: `isSuperAdmin()` (rules + client)
- [x] Firestore rules: widen read for super_admin
- [x] Screen: `SuperAdminDashboard` skeleton
- [x] Providers: `globalStatsProvider`, `superAdminUsersProvider`
- [x] Collections: `system_settings`, seed doc (model + provider; server seed pending)
- [x] Logging hook for permission-denied (client) → `security_events`
- [x] CF (scheduled): build `engagement_snapshots` (placeholder logic)
- [x] Risk calc function → write `risk_user_scores` + `predictive_alerts` (placeholder heuristic)
- [x] CF (scheduled): build `security_daily_rollups`
- [x] Detection CF: generate `intrusion_alerts` (threshold examples)
- [x] Integrity detector: points spike → `integrity_flags`
- [x] Dashboard: Alerts table (resolve/mute placeholder UI - read only for now)
- [x] `admin_audit_logs` + helper `logAdminAction` (callable triage + logging)
- [ ] Unit / integration smoke tests (where feasible)


### Phase 2 (B2C)
- [x] `skills`, `user_skill_stats` models (schema + Freezed) & placeholder mastery delta CF (`updateSkillMasteryDeltas`)
- [x] Skill attempts ingestion (`skill_attempts` + rules) + scheduled recompute CF (`recomputeSkillMastery`)
- [x] Replace placeholder delta & random drift with true 14d trend (delta14d = currentAvg - prevAvg)
 - [x] `weekly_challenges` + `user_challenge_progress` (rules + scheduled evaluation + create callable)
 - [x] Feed aggregator provider (merge events + badges + challenges + mastery deltas)
 - [x] Kudos system (`kudos_events` + rate-limiter CF callable + purge job + feed integration)
 - [x] Quest chains core data model (quests, quest_steps, user_quest_state + callables + feed integration)

### Phase 3 (Education)
- [x] Enforce institution scoping in rules (flag-driven `canReadTenantDoc` for courses/quizzes/tasks/resources)
- [x] `tenant_metrics_daily` CF aggregation refined to include avgMastery and avgMasteryDelta14d
- [x] Org Admin metrics providers (streams) wiring for charts/tables
 - [x] Org Admin UI (sparkline + tables)
 - [x] Bulk import (CSV client → batched writes) — screen + parser + batched set(merge)
 - [x] Role-gated navigation entries (Settings → Org Admin Dashboard, Bulk Import)
 - [x] Firestore rules: allow `company_admin` read access to `departments` and `user_department_map` within their company (with helper validation)

### Phase 4 (Corporate)
 - [x] `departments`, `user_department_map` write flows (company_admin)
   - Create/update/delete departments restricted to own company (rules enforced, field restrictions, no cross-company moves)
   - Assign/remove users to/from departments via `user_department_map` (rules enforce same-company department)
   - Providers added: createDepartment, addUserToDepartment, removeUserFromDepartment, findUserByEmailInCompany, departmentById
   - UI implemented: add department (FAB), long-press department to assign by email, dedicated Department Members management screen (add/remove)
   - Manager Dashboard: per-member actions (assign/remove) and title includes department name
- [x] Settings navigation for Company Admin (opens Company Admin Dashboard)
- [x] Company Admin Dashboard (initial metrics view reusing tenant_metrics_daily)
 - [x] Departments read UI (list company departments for company_admin)
 - [x] Manager Dashboard (placeholder screen; team + skill gap analytics pending)
 - [x] Departments → Manager Dashboard navigation (per-department team view)
 - [x] Manager analytics: aggregate department skill gaps (top lowest avg mastery)
 - [x] Learning Paths (read-only): models, providers, screen for company_admin
 - [x] Rules: scoped read access for learning_paths (institution/company)
 - [x] Path Steps (read-only): model, providers, steps screen
 - [x] User Path Progress: model stub + rules (owner/super_admin read) and UI header on path steps showing current user's completion % (reads only; writes deferred to server functions)
  - [x] i18n: Localized titles/labels for Company Admin, Departments, Manager, Learning Paths, and Settings entries
  - [x] i18n hardening: Removed temporary fallback getters from l10n_ext; now using generated ARB keys exclusively
  - [x] Manager direct access UX: department picker in Settings; auto-open Manager Dashboard when only one department exists
  - [x] Assignment UX polish: user search (name/email, multi-select), exclude already assigned members with label, confirmations before removal, and success toasts
  - [x] Manager dashboard (team table + skill gap): sortable team table (avg mastery, Δ14d per member) and top skill gaps list; highlight at-risk members (Δ14d ≤ 0)
- [x] `learning_paths`, `path_steps`, `user_path_progress` (read-only UI complete; per-user progress header on steps; writes deferred to server)
  - [x] Server-side write: callable CF `setUserPathProgress` to update `user_path_progress` with tenant validation and totalSteps computation
  - [x] Documented required composite indexes for learning paths and related queries in `docs/INDEXES.md`
- [x] Risk extension for employees (skill plateau weighting): Δ14d + low activity composite risk surfaced in Manager Dashboard (teamMemberRiskProvider)

Polish backlog (Phase 4):
- [x] Enhanced user search UI for assignments (name + email, multi-select)
- [x] Exclude already assigned members with an inline label in search results
- [x] Removal confirmation and toast feedback across member-management flows
- [x] Cleanup legacy analyzer warnings (brace usage, deprecated APIs, avoid_print) — completed; refactored onboarding flow to return intent to parent and start tour after sheet closes to avoid use_build_context_synchronously
- [x] Remove deprecated l10n.yaml setting (synthetic-package) after tooling update

### Phase 5 (Advanced)
- [ ] Adaptive engine iteration (recommendation provider)
- [ ] Tokens economy schema
- [ ] Certificates issuance + QR verify
- [ ] SSO integration scaffold
- [ ] HRIS ingest stub
- [ ] BigQuery export job
- [ ] ML anomaly (optional post-export)

---
## KPIs Per Track
| Track | Primary KPIs | Supporting |
|-------|--------------|-----------|
| B2C | D7 Retention, Avg Lessons Completed / User / Week | Challenge Completion %, Streak Adoption |
| Education | Cohort Completion %, Active Users / Cohort | Early Warning Precision, Instructor Activity |
| Corporate | Skill Coverage %, Path Completion Rate | Manager Activation %, Time to Upskill |
| Security / Integrity | Mean Time to Detect (MTTD), False Positives | Alert Resolution Time |
| Predictive | Risk Alert Precision, % High-Risk Intervened | Average Risk Score Trend |

---
## Risk & Mitigation Table
| Risk | Impact | Mitigation |
|------|--------|------------|
| Noise in intrusion alerts | Alert fatigue | Adjustable thresholds + mute feature |
| Data cost (writes) | Billing increase | Scope to active users last 30d only |
| False positives (risk scores) | Unnecessary interventions | Hysteresis + multi-day confirmation |
| Over-permissive super_admin | Data misuse | Audit logs + limited write surfaces |
| Performance of wide queries | Latency | Composite indexes + pagination + caching providers |

---
## Operational Excellence & Observability (NEW)
Key Pillars:
- Metrics: user_active_24h, events_write_rate, rules_denied_rate, cf_error_rate, risk_alert_open_count, intrusion_alert_open_count, tenant_active_fraction.
- SLOs (initial targets):
  - Availability (critical CF endpoints): 99.5%
  - Mean CF execution time (p95): < 2.5s
  - Rules Denial Noise Ratio (false positives / total denials sampled): < 5%
  - Alert Triage Latency (median): < 24h
- Dashboards (future): aggregated via export to BigQuery / DataStudio (Phase 4+).
- Tracing: wrap critical Cloud Functions with timing + structured log context (tenantId, userId, correlationId).
- Error Budget Policy: if CF error_rate 7d > threshold, pause new feature deployment next sprint.

Backlog Tasks:
 - [x] Structured logging format spec (JSON keys: ts, lvl, comp, msg, ctx)
 - [x] Implement logging helpers & integrated into core CFs
 - [x] Add correlationId propagation helper in client → CF callables
 - [x] Feature flag toggle callable (secure super_admin only)
- [ ] Export daily metrics snapshot to `ops_metrics_daily` (Phase 3+)

---
## Testing & Quality Strategy (NEW)
Test Layers:
1. Unit: models, converters, providers pure logic
2. Firestore Rule Simulation: deny/allow matrix for each role (scripted with emulator)
3. Cloud Functions: emulator-driven tests (risk calc, intrusion heuristics)
4. Integration (Golden Path): user signup → course → quiz → points award → badge
5. Security Regression: attempt forbidden role change, cross-tenant read, spike events

Backlog Tasks:
- [ ] Add rule simulation harness (Node script + firebase emulator)
- [ ] Add CF test for `computeUserRiskScores` factors weighting
- [ ] Add golden path integration test (emulator suite)
- [ ] Add security regression test matrix (role escalation attempts)

---
## Security Hardening Backlog (NEW)
- [ ] API key / secret rotation playbook (where applicable later)
- [ ] CSP & integrity for web index.html (Phase 2 web tightening)
- [ ] Add Firestore allowlist validation for badge criteria schema (deep shape)
- [ ] Rate limiting: move from heuristic events to enforced counters (Cloud Function token bucket)
- [ ] Add signed action tokens for privileged dashboard mutations
- [ ] Implement soft-delete pattern for users & tasks (preserve audit)
- [ ] Geo/IP anomaly enrichment (hash salt rotation plan)

---
## Performance & Indexing Plan (NEW)
Principles:
- Use narrow projections where possible (future: Firestore count() for leaderboards)
- Paginate with stable ordering (createdAt desc) + index definitions tracked.

Planned Composite Indexes (illustrative):
- user_points_events: userId + createdAt desc
- engagement_snapshots: userId + date desc
- risk_user_scores: userId + date desc
- security_events: ts desc + type
- predictive_alerts: severity + createdAt desc

Backlog Tasks:
- [ ] Document required composite indexes in `docs/INDEXES.md`
- [ ] Add provider-level caching / memoization for repeated leaderboard queries
- [ ] Consider partitioning high-churn collections (future BigQuery sink)

---
## Data Retention & Cost Optimization (NEW)
Retention Guidelines:
- security_events: hot 30d, then summarize → rollups, purge raw >60d
- intrusion_alerts: keep 180d
- admin_audit_logs: 1 year (export older to cold storage)
- engagement_snapshots: 90d rolling

Backlog Tasks:
 - [x] Create retention policy doc `docs/DATA_RETENTION.md`
 - [x] Add scheduled CF (dry-run) `planRetentionTasks` (logging sample candidates)
- [ ] Add scheduled CF to purge aged `security_events` post-rollup
- [ ] Summarize points events older than 180d into monthly aggregates

---
## Multi-Tenancy Onboarding & Governance (NEW)
Workflow States:
1. Tenant Provisioned (inactive)
2. Admin Invited (pending acceptance)
3. Active (flag: active=true)
4. Suspended (soft lock writes except super_admin)

Governance Actions (all audited): tenant_suspend, tenant_resume, admin_invite, role_escalate.

Backlog Tasks:
- [ ] Invitation token model (`tenant_invites`)
- [ ] Governance actions enumeration & audit schema extension
- [ ] Suspended tenant rule clause (deny writes except super_admin & read-only basic)

---
## Internationalization & Accessibility Roadmap (NEW)
Current: Arabic / English .arb files.
Planned:
- [ ] Extraction checklist for new strings (CI guard optional)
- [ ] RTL layout auditing (component-level)
- [ ] Accessibility: text scale testing, semantic labels for key widgets
- [ ] Add locale-based recommendation placeholders (future personalization)

---
## Release & Deployment Strategy (NEW)
Environments: dev (emulators), staging (flag staging), production.
Feature Flags Lifecycle:
1. Dark launch (flag off) → 2. Internal enable → 3. % rollout (future remote config) → 4. General
Rollback Playbook: disable flag, revert config doc, if severe revert last deploy tag.

Backlog Tasks:
 - [x] Add `docs/RELEASE_PROCESS.md`
- [ ] Tag releases with semantic version (git tag vX.Y.Z) aligned to roadmap phases
- [ ] Pre-deploy checklist (lint, tests, rule diff, emulator test)

---
## Future Analytics & ML (Extended) (NEW)
- [ ] Tenant health clustering (unsupervised) for segmentation
- [ ] Skill mastery predictive trajectory model
- [ ] Anomaly detection upgrade: seasonal decomposition for activity dips
- [ ] Alert prioritization model (learning from triage actions)


---
## Incremental Delivery Strategy
1. Deliver *thin vertical slices*: each slice includes schema + rule + provider + minimal UI.
2. Keep predictive & intrusion modular: fallback gracefully if no data.
3. Stabilize each phase with stabilization mini-sprint if error budget exceeded.
4. Maintain `docs/CHANGELOG.md` for tracking enabled capabilities.

---
## Appendix: Example Firestore Rule Snippets
```javascript
function isSuperAdmin() {
  return isSignedIn() && userDoc().data.role == 'super_admin';
}
match /users/{userId} {
  allow get: if isSignedIn();
  allow list: if isSuperAdmin() || (isSignedIn() && request.query.limit <= 30);
  allow update: if isSuperAdmin() || (isSignedIn() && userId == request.auth.uid);
  allow delete: if false; // soft-delete future
}
match /security_events/{id} {
  allow create: if isSignedIn(); // instrumentation (can add field validation)
  allow get, list: if isSuperAdmin();
}
match /risk_user_scores/{id} {
  allow get, list: if isSuperAdmin();
  allow create, update, delete: if false; // server-only
}
```

---
**End of MASTER_ROADMAP**

---
### References & Supporting Docs (NEW)
- `docs/INDEXES.md` – Composite index planning & checklist
- `docs/LOGGING_FORMAT.md` – Structured logging & correlation IDs
- `docs/DATA_RETENTION.md` – Retention schedule & purge strategy
- `docs/RELEASE_PROCESS.md` – Versioning, rollout & rollback playbook
