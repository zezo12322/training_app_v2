# Data Retention & Lifecycle Policy

Goal: control storage cost & comply with privacy expectations while preserving analytical value.

## Collections & Retention Windows
| Collection | Hot Window | Warm / Aggregated | Action After Window |
|-----------|------------|-------------------|---------------------|
| security_events | 30d | roll into security_daily_rollups | purge raw >60d |
| intrusion_alerts | 180d | n/a | archive to cold store (optional) |
| integrity_flags | 180d | n/a | archive optional |
| admin_audit_logs | 365d | yearly export (CSV/Parquet) | purge older |
| engagement_snapshots | 90d | monthly aggregates (future) | purge older |
| user_points_events | 180d | monthly_points_events summary | purge older raw |
| risk_user_scores | 120d | n/a (optionally downsample) | downsample older (keep weekly) |

## Aggregation Targets
- `monthly_points_events`: { userId, month, totalPoints, eventsCount }
- `security_daily_rollups`: already in place, basis for pruning `security_events`.

## Purge Cloud Functions
Scheduled daily CF executes retention steps in safe order:
1. Aggregate (if needed for the day that is aging out)
2. Verify aggregate success counters
3. Delete batch (limit chunk size for Firestore quotas)

## Safety & Audit
- Log every purge with: collection, rangeStart, rangeEnd, docCount.
- Add audit entry (actionType: retention_purge) referencing correlationId.

## Configuration
Store dynamic retention overrides in `system_settings.thresholds.retentionOverrides`:
```
retentionOverrides: {
  security_events_days: 45,
  admin_audit_logs_days: 400
}
```
CF logic: use override if present else default table above.

## Backlog
- [ ] Implement retention CF skeleton
- [ ] Add monthly aggregation for user_points_events
- [ ] Add downsampling job for risk_user_scores (keep weekly after 120d)
- [ ] Add admin dashboard view of upcoming purge counts
