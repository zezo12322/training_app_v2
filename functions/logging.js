// Structured logging helpers
// Format defined in docs/LOGGING_FORMAT.md
const { randomUUID } = require('crypto');

function baseEnvelope(level, op, corrId, extra) {
  return {
    ts: new Date().toISOString(),
    lvl: level,
    op,
    corrId: corrId || randomUUID(),
    ...extra,
  };
}

function log(level, op, corrId, extra) {
  const env = baseEnvelope(level, op, corrId, extra || {});
  // Ensure flat printable JSON line
  try {
    console.log(JSON.stringify(env));
  } catch (e) {
    console.log(JSON.stringify({ ts: new Date().toISOString(), lvl: 'ERROR', op: 'logger', msg: 'serialize_failed', err: e.message }));
  }
}

const logInfo = (op, corrId, extra) => log('INFO', op, corrId, extra);
const logWarn = (op, corrId, extra) => log('WARN', op, corrId, extra);
const logError = (op, corrId, extra) => log('ERROR', op, corrId, extra);
const logDebug = (op, corrId, extra) => log('DEBUG', op, corrId, extra);

function withLog(op, handler) {
  return async (context = {}, corrIdIn) => {
    const start = Date.now();
    const corrId = corrIdIn || context.corrId || context?.headers?.['x-corr-id'] || context?.req?.headers?.['x-corr-id'] || null;
    try {
      const result = await handler(context, corrId);
      logInfo(op, corrId, { durationMs: Date.now() - start, ...result?.meta });
      return result?.payload ?? result;
    } catch (e) {
      logError(op, corrId, { durationMs: Date.now() - start, error: e.message });
      throw e;
    }
  };
}

module.exports = {
  logInfo,
  logWarn,
  logError,
  logDebug,
  withLog,
};
