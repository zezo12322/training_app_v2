# Structured Logging & Correlation

## Goals
Consistent machine-parseable logs for audit, debugging, and analytics.

## Format
JSON line per event (no multiline):
```
{
  "ts":"2025-10-09T12:00:00.123Z",
  "lvl":"INFO|WARN|ERROR|DEBUG",
  "comp":"cf|client|provider|ui|rule-sim",
  "op":"computeUserRiskScores",
  "msg":"Risk scores batch written",
  "corrId":"<uuid-v4>",
  "tenantId":"<institutionOrCompanyId?>",
  "userId":"<uid?>",
  "durationMs":123,
  "meta":{ "count":42, "phase":"scoring" }
}
```

## Correlation ID
- Generated client-side for user-driven flows; propagate via callable headers / payload.
- Cloud Functions: if missing, generate and echo in response.

## Severity Guidelines
| lvl | Use |
|-----|-----|
| DEBUG | High-frequency internal steps (omit in prod by default) |
| INFO | Successful milestone (batch complete, toggle changed) |
| WARN | Recoverable anomaly (retry succeeded, threshold near limit) |
| ERROR | Failure affecting operation or user-visible result |

## Cloud Functions Wrapper Pseudocode
```js
function withLog(op, handler) {
  return async (ctx) => {
    const start = Date.now();
    const corrId = ctx.corrId || ctx.req?.headers['x-corr-id'] || randomUUID();
    try {
      const result = await handler(ctx, corrId);
      logInfo({ op, corrId, durationMs: Date.now()-start, meta: result?.meta });
      return result.payload;
    } catch (e) {
      logError({ op, corrId, durationMs: Date.now()-start, meta: { error: e.message } });
      throw e;
    }
  };
}
```

## Redaction
- NEVER log PII beyond userId/email hash.
- Hash email if needed: sha256(lower(email)+staticSaltRotationKey).

## Retention
Mirrors retention strategy: hot 30d aggregated beyond.

## Next Steps
- [ ] Implement `logInfo/logWarn/logError` helpers in Cloud Functions.
- [ ] Add correlation ID injection on client HTTP / callable wrapper.
- [ ] Introduce sampling for high-volume DEBUG events.
