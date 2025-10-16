# Security & Intrusion Detection Model

Companion deep-dive for sections in MASTER_ROADMAP.md (SuperAdmin + Predictive + Intrusion).

## Goals
1. Detect misuse early (brute force, enumeration, privilege escalation, exploitation attempts).
2. Provide clear, explainable signals (why was a user/tenant flagged?).
3. Minimize false positives while preserving sensitivity to genuine threats.
4. Keep infra lightweight (Firestore + Cloud Functions + client instrumentation) initially.

## Architecture Layers
| Layer | Responsibility | Tech |
|-------|----------------|------|
| Client Instrumentation | Emit structured security events on notable failures | Dart wrapper around service calls |
| Firestore Raw Events | Append-only storage of `security_events` | Firestore collection |
| Aggregation Jobs | Periodic rollups & anomaly scoring | Scheduled Cloud Functions |
| Detection Engine | Evaluate thresholds / heuristics, open/update alerts | Cloud Functions (batch + triggers) |
| Alerting & Triage UI | Surface & manage alerts | Flutter SuperAdmin dashboard |
| Audit Trail | Record admin actions & alert resolutions | `admin_audit_logs` CF callable |

## Data Contracts
### security_events
```
{
  type: 'privilege_denied' | 'rules_denial' | 'payload_suspect' | 'rate_limit' | 'points_velocity' | 'token_replay' | ...,
  vector: 'PRIV_ESC' | 'ENUM_DOC' | 'INJ_JSON' | 'RATE_FLOOD' | 'POINTS_FARM' | 'BOT_PATTERN' | 'RULES_SPIKE' | ...,
  userId?,
  ipHash, // SHA256(IP + salt)
  uaHash, // SHA256(UserAgent)
  ts: Timestamp,
  meta: { docPath?, attemptCount?, samplePayloadHash?, jitterMs?, deltaSeconds?, failureCode? },
  severity: 'low' | 'med' | 'high'
}
```
### intrusion_alerts
```
{
  vector: 'PRIV_ESC',
  category: 'auth' | 'rules' | 'integrity' | 'enumeration' | 'automation',
  firstSeen: Timestamp,
  lastSeen: Timestamp,
  count: Number,
  impactedUsers: [userId?],
  status: 'open' | 'resolved' | 'muted',
  severity: 'low' | 'med' | 'high'
}
```

## Detection Heuristics (Initial)
| Vector | Condition | Action |
|--------|----------|--------|
| PRIV_ESC | ≥5 denied role field updates in 60m | Open/Increment alert (severity med) |
| ENUM_DOC | ≥40 permission_denied + not_found mix with <10 successes in 30m per ipHash | Alert (low→med) |
| INJ_JSON | payload_suspect events ≥3 in 10m | High severity if patterns escalate |
| RATE_FLOOD | rate_limit events > threshold (dynamic p95) | Alert (med) + suggest temporary block |
| POINTS_FARM | points_velocity high events >3σ baseline | Raise integrity flag + high alert |
| BOT_PATTERN | jitter variance < configured floor with >N events | Low severity automation alert |
| TOKEN_REPLAY | Same auth userId distinct ipHash within <2m, geoDistance > threshold | High severity token_replay |
| RULES_SPIKE | Global rules_denial ratio >0.35 this hour | High severity rules spike |

## Aggregation Job Flow
1. Fetch last window of `security_events` partitioned by vector.
2. Apply heuristics & compute rolling metrics (store ephemeral state in `security_daily_rollups`).
3. Upsert/update `intrusion_alerts` documents.
4. Write secondary notifications (future: email/webhook) after dedupe (cooldown window).
5. Log job run in `admin_audit_logs` as system actor.

## Pseudocode Example (Detection Batch)
```js
for each vector in VECTORS:
  events = query security_events where ts > now - WINDOW
  if condition(vector, events):
     alert = get existing intrusion_alerts doc
     if !alert: create with firstSeen
     update lastSeen, count, severity
```

## Client Instrumentation Strategy
Wrap Firestore/HTTP operations and on
- permission-denied
- aborted writes to protected fields
- suspicious payload pattern (regex test)
- rapid repeated identical action
Emit a lightweight event (avoid PII: hash IP & UA). Batch events (in-memory queue) flush every N seconds or size threshold.

## Privacy & Compliance
- Store hashed IP (salt rotate every 90d, keep active + previous salts for rolling correlation).
- Avoid raw user-agent; use normalized hash + coarse classification (mobile/web/desktop).
- Provide user deletion path: purge related security_events by userId (retain aggregated counts without mapping user).

## Scaling & Cost Considerations
| Concern | Mitigation |
|---------|------------|
| High write volume | Batch writes in CF, sampling for high-frequency events |
| Query fan-out | Time-partition queries using `ts >= lastRun` |
| Cold start latency | Use min instances for detection CF (later) |

## Evolution Roadmap
Stage 1: Heuristics (current)
Stage 2: Statistical baselines (rolling z-scores)
Stage 3: ML anomaly detection (BigQuery + scheduled export)
Stage 4: Real-time streaming (Pub/Sub + Dataflow) – future only if scale demands

## SuperAdmin UI Integrations
Widgets:
- Intrusion Alert Count (open) badge
- Top Vectors donut
- Recent Security Events stream (last 20)
- Heatmap: Alerts by hour (24h)
- Table: Open Alerts (sortable by severity, lastSeen)
- Drilldown: Alert details → timeline of contributing events

## Actions (Triage)
- Resolve (closes alert, logs audit)
- Mute (suppresses re-open for defined horizon)
- Escalate (tag severity higher, optional notification)
- View Raw Events (filtered query) with export (CSV future)

## Index Suggestions
```
security_events: [vector, ts DESC]
security_events: [ipHash, ts DESC]
intrusion_alerts: [status, severity, lastSeen DESC]
risk_user_scores: [userId, date DESC]
engagement_snapshots: [userId, date DESC]
```

## Testing Strategy
1. Unit: heuristic functions with synthetic event sets
2. Integration: generate mock security_events window → run detection CF → validate intrusion_alerts outputs
3. Load: simulate 10k benign + 200 malicious events → ensure cost within target
4. False Positive Audit: curated edge case dataset

## KPIs
- Time from event to alert < 5m (heuristic batch schedule 1–2m)
- False positive rate < 15% first month
- Mean time to resolve < 24h

---
_End of SECURITY_INTRUSION_MODEL_
