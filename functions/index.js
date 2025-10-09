const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { logInfo, logError, withLog } = require('./logging');
admin.initializeApp();

// ================= Engagement Snapshots (Scheduled Placeholder) =================
// Runs daily (or more frequently) to materialize per-user engagement snapshots.
// TODO: Implement logic: iterate active users (recent events), compute events7d, streak, lastActiveTs.
exports.buildEngagementSnapshots = functions.pubsub.schedule('every 24 hours').onRun(async (context) => {
  const db = admin.firestore();
  const now = new Date();
  const dateStr = now.toISOString().slice(0,10); // YYYY-MM-DD
  // Placeholder: Currently just logs count of users; extend with actual aggregation later.
  const usersSnap = await db.collection('users').limit(50).get();
  logInfo('engagement_snapshot.batch_start', null, { size: usersSnap.size });
  const batch = db.batch();
  usersSnap.docs.forEach(doc => {
    const userId = doc.id;
    const docId = `${userId}_${dateStr}`;
    const ref = db.collection('engagement_snapshots').doc(docId);
    batch.set(ref, {
      userId,
      date: dateStr,
      events7d: 0, // TODO compute
      streak: 0, // TODO compute
      lastActiveTs: admin.firestore.FieldValue.serverTimestamp(),
      masteryDelta14d: 0,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    }, { merge: true });
  });
  await batch.commit();
  logInfo('engagement_snapshot.batch_commit');
  return null;
});

// ================= Risk User Scores (Scheduled Placeholder) =================
exports.computeUserRiskScores = functions.pubsub.schedule('every 24 hours').onRun(async (context) => {
  const db = admin.firestore();
  const now = new Date();
  const dateStr = now.toISOString().slice(0,10);
  // Fetch engagement snapshots of today (limit for placeholder)
  const snaps = await db.collection('engagement_snapshots').where('date','==',dateStr).limit(100).get();
  if (snaps.empty) {
    logInfo('risk.no_snapshots');
    return null;
  }
  const batch = db.batch();
  snaps.docs.forEach(doc => {
    const d = doc.data();
    const userId = d.userId;
    const events7d = d.events7d || 0;
    const streak = d.streak || 0;
    // Heuristic: higher events7d & streak => lower risk
    // Normalize rough factors
    const activityComponent = Math.min(events7d / 20, 1); // assume 20+ = fully active
    const streakComponent = Math.min(streak / 7, 1); // 7+ streak good
    const rawScore = 1 - (0.6 * activityComponent + 0.4 * streakComponent);
    const score = Number(rawScore.toFixed(3));
    let level = 'low';
    if (score >= 0.6) level = 'high'; else if (score >= 0.35) level = 'med';
    const id = `${userId}_${dateStr}`;
    batch.set(db.collection('risk_user_scores').doc(id), {
      userId,
      date: dateStr,
      score,
      factors: { events7d, streak, activityComponent, streakComponent },
      level,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    }, { merge: true });
    if (level === 'high') {
      const alertRef = db.collection('predictive_alerts').doc();
      batch.set(alertRef, {
        category: 'user_risk',
        targetId: userId,
        score,
        severity: 'high',
        factors: { events7d, streak },
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        resolved: false,
      });
    }
  });
  await batch.commit();
  logInfo('risk.processed_snapshots', null, { count: snaps.size });
  return null;
});

// Note: setUserPathProgress callable removed to avoid requiring Blaze plan.

// هذه الدالة ستعمل كلما تم إنشاء مستند جديد في 'course_wall'
exports.sendPostNotification = functions.firestore
  .document("course_wall/{postId}")
  .onCreate(async (snapshot, context) => {
    // 1. الحصول على بيانات المنشور الجديد
    const postData = snapshot.data();
    const courseId = postData.courseId;
    const authorEmail = postData.authorEmail;

    // 2. جلب تفاصيل الكورس للحصول على قائمة المتدربين
    const courseDoc = await admin
      .firestore()
      .collection("courses")
      .doc(courseId)
      .get();

    if (!courseDoc.exists) {
      console.log("Course not found!");
      return;
    }

    const courseData = courseDoc.data();
    const courseName = courseData.name;
    const traineeIds = courseData.trainees;

    if (!traineeIds || traineeIds.length === 0) {
      console.log("No trainees in this course.");
      return;
    }

    // 3. جلب "توكن" كل متدرب
    const tokens = [];
    for (const traineeId of traineeIds) {
      const userDoc = await admin
        .firestore()
        .collection("users")
        .doc(traineeId)
        .get();

      if (userDoc.exists && userDoc.data().fcmToken) {
        tokens.push(userDoc.data().fcmToken);
      }
    }

    if (tokens.length === 0) {
      console.log("No registered device tokens found for trainees.");
      return;
    }

    // 4. بناء رسالة الإشعار
    const payload = {
      notification: {
        title: `منشور جديد في: ${courseName}`,
        body: `قام ${authorEmail} بإضافة منشور جديد.`,
        sound: "default",
      },
    };

    // 5. إرسال الإشعار لجميع الأجهزة
    try {
      const response = await admin.messaging().sendToDevice(tokens, payload);
      console.log("Successfully sent notification:", response);
    } catch (error) {
      console.log("Error sending notification:", error);
    }
  });

// =============================================================
// DigitalOcean Spaces presign endpoint
// استدعاء من التطبيق: GET https://<region>-<project>.cloudfunctions.net/presignSpaceAudio?ext=m4a&courseId=123
// أو عبر استدعاء SDK: functions.httpsCallable('presignSpaceAudio')({ ext: 'm4a', courseId: '123' })
// يعتمد على إعداد مفاتيح في:
// firebase functions:config:set spaces.key="DO_KEY" spaces.secret="DO_SECRET" spaces.name="SPACE_NAME" spaces.region="fra1" spaces.cdn="https://your-cdn.example.com"
// =============================================================
const { S3Client, PutObjectCommand } = require('@aws-sdk/client-s3');
const { getSignedUrl } = require('@aws-sdk/s3-request-presigner');

// =============================================================
// OneSignal notification callable (using external user ids).
// Works on Spark plan because we target firebase-functions v4 (1st gen style) with Node 18.
// Set config:
//   firebase functions:config:set onesignal.app_id="YOUR_APP_ID" onesignal.rest_api_key="YOUR_REST_KEY"
// Call from client:
//   functions.httpsCallable('sendOneSignalNotification')({ userIds: [...], title: '...', content: '...' })
// =============================================================
const fetch = (...args) => import('node-fetch').then(({default: fetch}) => fetch(...args));

exports.sendOneSignalNotification = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Must be signed in');
  }
  const corrId = data?.corrId || null;
  const { userIds, title, content, data: extraData } = data || {};
  if (!Array.isArray(userIds) || userIds.length === 0) {
    throw new functions.https.HttpsError('invalid-argument', 'userIds (non-empty array) required');
  }
  if (typeof title !== 'string' || typeof content !== 'string') {
    throw new functions.https.HttpsError('invalid-argument', 'title/content required');
  }

  const appId = functions.config().onesignal?.app_id;
  const apiKey = functions.config().onesignal?.rest_api_key;
  if (!appId || !apiKey) {
    throw new functions.https.HttpsError('failed-precondition', 'OneSignal config missing');
  }

  // Build request
  const body = {
    app_id: appId,
    include_external_user_ids: userIds,
    headings: { en: title },
    contents: { en: content },
    channel_for_external_user_ids: 'push',
    data: extraData || {},
  };

  try {
    const resp = await fetch('https://api.onesignal.com/notifications', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': `Basic ${apiKey}`,
      },
      body: JSON.stringify(body),
    });
    const json = await resp.json();
    if (!resp.ok) {
      logError('onesignal.send', corrId, { stage: 'response_not_ok', body: json });
      throw new functions.https.HttpsError('internal', 'OneSignal send failed');
    }
      logInfo('onesignal.send', corrId, { id: json.id, recipients: json.recipients });
      return { id: json.id, recipients: json.recipients, corrId };
  } catch (e) {
      logError('onesignal.send', corrId, { error: e.message });
    throw new functions.https.HttpsError('internal', 'Exception sending notification');
  }
});

// =============================================================
// Server-side processing of point award events
// Trigger: on create of user_points_events/{eventId}
// Responsibilities:
//  - Increment user_points.points and per-type counters (quizzesPassed, tasksCompleted, lessonsCompleted)
//  - (Optional) update dailyStreak if event type daily_streak includes streakAfter
//  - Evaluate dynamic badges (active && autoAward) and award newly satisfied ones
// Idempotency: relies on single event creation (client no longer increments points directly).
// =============================================================
exports.onPointEventCreate = functions.firestore
  .document('user_points_events/{eventId}')
  .onCreate(async (snap, context) => {
    const data = snap.data() || {};
    const { userId, type, points } = data;
    if (!userId || typeof points !== 'number' || points <= 0) {
      console.log('Skipping event missing essentials', data);
      return;
    }
    const db = admin.firestore();
    await db.runTransaction(async (tx) => {
      const userRef = db.collection('user_points').doc(userId);
      const userSnap = await tx.get(userRef);
      const userData = userSnap.exists ? userSnap.data() : {};
      const update = { points: admin.firestore.FieldValue.increment(points) };
      if (type === 'quiz_pass') update.quizzesPassed = admin.firestore.FieldValue.increment(1);
      if (type === 'task_completed') update.tasksCompleted = admin.firestore.FieldValue.increment(1);
      if (type === 'lesson_completed') update.lessonsCompleted = admin.firestore.FieldValue.increment(1);
      if (type === 'daily_streak' && typeof data.streakAfter === 'number') {
        update.dailyStreak = data.streakAfter; // client computed
      }
      tx.set(userRef, update, { merge: true });
      // Evaluate badges after projecting new state
      const projected = {
        points: (userData.points || 0) + points,
        quizzesPassed: (userData.quizzesPassed || 0) + (type === 'quiz_pass' ? 1 : 0),
        tasksCompleted: (userData.tasksCompleted || 0) + (type === 'task_completed' ? 1 : 0),
        lessonsCompleted: (userData.lessonsCompleted || 0) + (type === 'lesson_completed' ? 1 : 0),
        dailyStreak: type === 'daily_streak' && typeof data.streakAfter === 'number' ? data.streakAfter : (userData.dailyStreak || 0),
        badges: Array.isArray(userData.badges) ? [...userData.badges] : [],
      };
      const badgesSnap = await db.collection('badges').where('active','==',true).get();
      const addBadge = async (badgeId) => {
        if (projected.badges.includes(badgeId)) return;
        projected.badges.push(badgeId);
        const awardRef = userRef.collection('badge_awards').doc(badgeId);
        tx.set(userRef, { badges: projected.badges }, { merge: true });
        tx.set(awardRef, { awardedAt: admin.firestore.FieldValue.serverTimestamp() }, { merge: true });
      };
      // Lazy review count (only if a badge needs it)
      let reviewsCount = null;
      const ensureReviews = async () => {
        if (reviewsCount != null) return reviewsCount;
        const revs = await db.collection('user_reviews').where('reviewerId','==', userId).get();
        reviewsCount = revs.size;
        return reviewsCount;
      };
      for (const badgeDoc of badgesSnap.docs) {
        const b = badgeDoc.data();
        if (b.autoAward === false) continue;
        const crit = b.criteria || {};
        if (Object.keys(crit).length === 0) continue; // skip empty criteria
        const checks = [];
        const gte = (key, actual) => {
          if (crit[key] == null) return true; return actual >= crit[key];
        };
        checks.push(gte('pointsGte', projected.points));
        checks.push(gte('dailyStreakGte', projected.dailyStreak));
        checks.push(gte('quizzesPassedGte', projected.quizzesPassed));
        checks.push(gte('tasksCompletedGte', projected.tasksCompleted));
        checks.push(gte('lessonsCompletedGte', projected.lessonsCompleted));
        if (crit.reviewsWrittenGte != null) {
          const rc = await ensureReviews();
          checks.push(rc >= crit.reviewsWrittenGte);
        }
        if (checks.every(Boolean)) {
          await addBadge(badgeDoc.id);
        }
      }
    });
  });

// تهيئة عميل S3 لِـ Spaces (S3-compatible)
function buildSpacesClient() {
  const key = functions.config().spaces?.key;
  const secret = functions.config().spaces?.secret;
  const region = functions.config().spaces?.region || 'fra1';
  if (!key || !secret) {
    throw new Error('Spaces credentials not configured. Run: firebase functions:config:set spaces.key="..." spaces.secret="..." spaces.name="..."');
  }
  return new S3Client({
    region,
    endpoint: `https://${region}.digitaloceanspaces.com`,
    forcePathStyle: false,
    credentials: { accessKeyId: key, secretAccessKey: secret }
  });
}

exports.presignSpaceAudio = functions.https.onRequest(async (req, res) => {
  // سماح مؤقت لـ GET فقط
  if (req.method !== 'GET') {
    return res.status(405).json({ error: 'Only GET allowed' });
  }
  try {
    const extRaw = (req.query.ext || 'm4a').toString();
    const courseIdRaw = (req.query.courseId || 'general').toString();
    const folderRaw = (req.query.folder || 'evaluation_audio').toString();
    const sanitize = v => v.replace(/[^a-zA-Z0-9_\-]/g, '');
    const ext = sanitize(extRaw).toLowerCase();
    const courseId = sanitize(courseIdRaw);
    const folder = sanitize(folderRaw);

    const spaceName = functions.config().spaces?.name;
    const region = functions.config().spaces?.region || 'fra1';
    const cdnBase = functions.config().spaces?.cdn || '';
    if (!spaceName) {
      throw new Error('spaces.name not configured');
    }

    const contentTypeMap = {
      m4a: 'audio/m4a', mp3: 'audio/mpeg', wav: 'audio/wav', aac: 'audio/aac'
    };
    const contentType = contentTypeMap[ext] || 'application/octet-stream';
    const objectKey = `${folder}/${courseId}/${Date.now()}.${ext}`;

    const client = buildSpacesClient();
    const command = new PutObjectCommand({
      Bucket: spaceName,
      Key: objectKey,
      ContentType: contentType,
      ACL: 'public-read'
    });
    const putUrl = await getSignedUrl(client, command, { expiresIn: 300 });
    const publicUrl = cdnBase
      ? `${cdnBase}/${objectKey}`
      : `https://${spaceName}.${region}.digitaloceanspaces.com/${objectKey}`;

    logInfo('spaces.presign', req.headers['x-corr-id'] || null, { objectKey });
    return res.json({ putUrl, publicUrl, contentType });
  } catch (e) {
    logError('spaces.presign', null, { error: e.message });
    return res.status(500).json({ error: e.message });
  }
});

// ================= Security Daily Rollups (Scheduled) =================
exports.buildSecurityDailyRollups = functions.pubsub.schedule('every 24 hours').onRun(async () => {
  const db = admin.firestore();
  const now = new Date();
  const dateStr = now.toISOString().slice(0,10); // YYYY-MM-DD
  const start = new Date(dateStr + 'T00:00:00.000Z');
  const end = new Date(start.getTime() + 24*60*60*1000);
  // Query events for last 24h (could refine to exact dateStr via stored date field later)
  const eventsSnap = await db.collection('security_events')
    .where('ts','>=', start)
    .where('ts','<', end)
    .limit(1000) // safety cap placeholder
    .get();
  let permissionDenied=0, privilegeEscalation=0, suspectPayload=0, highSeverity=0; const userSet = new Set();
  const vectorCounts = {};
  eventsSnap.docs.forEach(d => {
    const e = d.data();
    userSet.add(e.meta?.userId || e.userId || '');
    if (e.type === 'permission_denied') permissionDenied++;
    if (e.vector === 'PRIV_ESC') privilegeEscalation++;
    if (e.type === 'payload_suspect') suspectPayload++;
    if ((e.severity||'low') === 'high') highSeverity++;
    const v = e.vector || 'UNK';
    vectorCounts[v] = (vectorCounts[v]||0)+1;
  });
  const docRef = db.collection('security_daily_rollups').doc(dateStr);
  await docRef.set({
    date: dateStr,
    totalEvents: eventsSnap.size,
    permissionDenied,
    privilegeEscalation,
    suspectPayload,
    highSeverity,
    distinctUsers: [...userSet].filter(x=>x).length,
    computedAt: admin.firestore.FieldValue.serverTimestamp(),
    meta: { vectorCounts }
  }, { merge: true });
  logInfo('security_rollup.stored', null, { date: dateStr, events: eventsSnap.size });
  return null;
});

// ================= Intrusion Detection (Scheduled) =================
// Heuristic pass converting spikes / privilege escalation bursts into intrusion_alerts.
exports.runIntrusionDetection = functions.pubsub.schedule('every 24 hours').onRun(async () => {
  const db = admin.firestore();
  const now = new Date();
  const dateStr = now.toISOString().slice(0,10);
  const rollupRef = db.collection('security_daily_rollups').doc(dateStr);
  const rollSnap = await rollupRef.get();
  if (!rollSnap.exists) {
    logInfo('intrusion.no_rollup');
    return null;
  }
  const roll = rollSnap.data();
  const alertsCol = db.collection('intrusion_alerts');
  const vectorCounts = roll.meta?.vectorCounts || {};
  // Simple heuristic thresholds (placeholder):
  const candidates = [];
  if ((roll.privilegeEscalation||0) >= 5) {
    candidates.push({ vector: 'PRIV_ESC', category: 'auth', severity: roll.privilegeEscalation >= 10 ? 'high':'med', meta: { count: roll.privilegeEscalation }});
  }
  if ((roll.permissionDenied||0) >= 20) {
    candidates.push({ vector: 'RULES_SPIKE', category: 'rules', severity: roll.permissionDenied >= 50 ? 'high':'med', meta: { count: roll.permissionDenied }});
  }
  Object.entries(vectorCounts).forEach(([v,c]) => {
    if (c >= 25 && v !== 'PRIV_ESC') {
      candidates.push({ vector: v, category: 'enumeration', severity: c >= 60 ? 'high':'med', meta: { count: c } });
    }
  });
  if (candidates.length === 0) {
    logInfo('intrusion.no_candidates');
    return null;
  }
  const batch = db.batch();
  for (const c of candidates) {
    const id = `${dateStr}_${c.vector}`;
    const ref = alertsCol.doc(id);
    batch.set(ref, {
      vector: c.vector,
      category: c.category,
      severity: c.severity,
      status: 'open',
      count: c.meta.count,
      firstSeen: admin.firestore.FieldValue.serverTimestamp(),
      lastSeen: admin.firestore.FieldValue.serverTimestamp(),
      impactedUsers: [],
      meta: c.meta,
    }, { merge: true });
  }
  await batch.commit();
  logInfo('intrusion.alerts_upserted', null, { count: candidates.length });
  return null;
});

// ================= Integrity Flags Detection (Scheduled) =================
exports.runIntegrityDetection = functions.pubsub.schedule('every 24 hours').onRun(async () => {
  const db = admin.firestore();
  const since = new Date(Date.now() - 6 * 60 * 60 * 1000); // last 6h window simple heuristic
  const eventsSnap = await db.collection('user_points_events')
    .where('createdAt','>=', since) // assuming createdAt exists; else would need different field
    .limit(2000)
    .get();
  if (eventsSnap.empty) {
    logInfo('integrity.no_events');
    return null;
  }
  const byUser = new Map();
  eventsSnap.docs.forEach(d => {
    const e = d.data();
    const uid = e.userId; if (!uid) return;
    const arr = byUser.get(uid) || []; arr.push(e); byUser.set(uid, arr);
  });
  const batch = db.batch();
  let created = 0;
  for (const [uid, list] of byUser.entries()) {
    list.sort((a,b) => (a.createdAt?.toMillis?.()||0) - (b.createdAt?.toMillis?.()||0));
    // Very naive spike heuristic: > 30 events in 10 minutes or > 8 events in any 1 minute bucket
    const minuteBuckets = {};
    list.forEach(ev => {
      const ts = ev.createdAt?.toDate?.() || new Date();
      const key = ts.toISOString().slice(0,16); // YYYY-MM-DDTHH:MM
      minuteBuckets[key] = (minuteBuckets[key]||0)+1;
    });
    const total = list.length;
    const maxPerMinute = Math.max(...Object.values(minuteBuckets));
    if (total >= 30 || maxPerMinute >= 8) {
      const sev = (total >= 60 || maxPerMinute >= 15) ? 'high' : (total >= 40 || maxPerMinute >= 10) ? 'med' : 'low';
      const id = `${uid}_${Date.now()}`;
      batch.set(db.collection('integrity_flags').doc(id), {
        userId: uid,
        type: 'points_spike',
        ts: admin.firestore.FieldValue.serverTimestamp(),
        severity: sev,
        details: { total, maxPerMinute, buckets: Object.keys(minuteBuckets).length },
        resolved: false,
      });
      created++;
    }
  }
  if (created > 0) {
    await batch.commit();
    logInfo('integrity.flags_created', null, { count: created });
  } else {
    logInfo('integrity.no_spikes');
  }
  return null;
});

// ================= Admin Audit Log Callable =================
exports.logAdminAction = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError('unauthenticated','auth required');
  const uid = context.auth.uid;
  // NOTE: We trust rules to enforce only super_admin can read; here we re-check role.
  const db = admin.firestore();
  const userDoc = await db.collection('users').doc(uid).get();
  if (!userDoc.exists || userDoc.data().role !== 'super_admin') {
    throw new functions.https.HttpsError('permission-denied','super_admin only');
  }
  const { actionType, target, meta } = data || {};
  if (typeof actionType !== 'string' || actionType.length > 64) {
    throw new functions.https.HttpsError('invalid-argument','actionType required');
  }
  await db.collection('admin_audit_logs').add({
    actorId: uid,
    actionType,
    target: target || null,
    meta: meta || {},
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  logInfo('admin.action_logged', null, { actionType, actorId: uid });
  return { ok: true };
});

// ================= Intrusion / Predictive Alert Triage Callable =================
exports.triageAlert = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError('unauthenticated','auth required');
  const uid = context.auth.uid;
  const db = admin.firestore();
  const userDoc = await db.collection('users').doc(uid).get();
  if (!userDoc.exists || userDoc.data().role !== 'super_admin') {
    throw new functions.https.HttpsError('permission-denied','super_admin only');
  }
  const { collection, id, action } = data || {};
  if (!['intrusion_alerts','predictive_alerts','integrity_flags'].includes(collection)) {
    throw new functions.https.HttpsError('invalid-argument','unsupported collection');
  }
  if (typeof id !== 'string') throw new functions.https.HttpsError('invalid-argument','id required');
  if (!['resolve','mute','reopen'].includes(action)) {
    throw new functions.https.HttpsError('invalid-argument','invalid action');
  }
  const ref = db.collection(collection).doc(id);
  const snap = await ref.get();
  if (!snap.exists) throw new functions.https.HttpsError('not-found','doc missing');
  const update = {};
  if (action === 'resolve') update.status = 'resolved';
  if (action === 'mute') update.status = 'muted';
  if (action === 'reopen') update.status = 'open';
  if (collection === 'predictive_alerts') {
    // predictive_alerts had 'resolved' boolean previously
    if (action === 'resolve') update.resolved = true;
    if (action === 'reopen') update.resolved = false;
  } else if (collection === 'integrity_flags') {
    if (action === 'resolve') update.resolved = true;
    if (action === 'reopen') update.resolved = false;
  }
  await ref.set(update, { merge: true });
  await db.collection('admin_audit_logs').add({
    actorId: uid,
    actionType: `triage_${action}`,
    target: `${collection}/${id}`,
    meta: {},
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  logInfo('alert.triage', null, { collection, id, action, actorId: uid });
  return { ok: true };
});

// ================= Feature Flag Toggle Callable =================
// Securely toggles a feature flag in system_settings/global.featureFlags
// data: { flag: string, value: boolean }
exports.toggleFeatureFlag = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError('unauthenticated','auth required');
  const uid = context.auth.uid;
  const { flag, value } = data || {};
  if (typeof flag !== 'string' || flag.length === 0) {
    throw new functions.https.HttpsError('invalid-argument','flag required');
  }
  if (typeof value !== 'boolean') {
    throw new functions.https.HttpsError('invalid-argument','value must be boolean');
  }
  const db = admin.firestore();
  const userDoc = await db.collection('users').doc(uid).get();
  if (!userDoc.exists || userDoc.data().role !== 'super_admin') {
    throw new functions.https.HttpsError('permission-denied','super_admin only');
  }
  const settingsRef = db.collection('system_settings').doc('global');
  await db.runTransaction(async (tx) => {
    const snap = await tx.get(settingsRef);
    const current = snap.exists ? snap.data() : { featureFlags: {} };
    const featureFlags = { ...(current.featureFlags || {}) };
    featureFlags[flag] = value;
    tx.set(settingsRef, { featureFlags, updatedAt: admin.firestore.FieldValue.serverTimestamp() }, { merge: true });
  });
  await db.collection('admin_audit_logs').add({
    actorId: uid,
    actionType: 'feature_flag_toggle',
    target: `featureFlags.${flag}`,
    meta: { value },
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  logInfo('feature_flag.toggled', null, { flag, value, actorId: uid });
  return { ok: true, flag, value };
});

// ================= Tenant Metrics Daily (Scheduled) =================
// Aggregates active user counts & basic engagement per tenant (institutionId / companyId)
exports.buildTenantMetricsDaily = functions.pubsub.schedule('every 24 hours').onRun(async () => {
  const db = admin.firestore();
  const dateStr = new Date().toISOString().slice(0,10);
  // Fetch today's engagement snapshots (represents active users), limit for placeholder
  const snaps = await db.collection('engagement_snapshots').where('date','==',dateStr).limit(2000).get();
  const instAgg = new Map(); // key -> { users, events7dTotal, masterySum, masteryUsers, deltaSum }
  const compAgg = new Map();
  for (const s of snaps.docs) {
    const snap = s.data();
    const userId = snap.userId;
    if (!userId) continue;
    // Look up user doc (could batch; for now naive per-user fetch limited by 2k)
    const userDoc = await db.collection('users').doc(userId).get();
    if (!userDoc.exists) continue;
    const u = userDoc.data();
    const events7d = snap.events7d || 0;
    // Fetch limited skill stats to compute per-user average mastery and delta
    let userAvgMastery = null;
    let userAvgDelta = null;
    try {
      const statsSnap = await db.collection('user_skill_stats')
        .where('userId','==', userId)
        .limit(20)
        .get();
      if (!statsSnap.empty) {
        let mSum = 0, dSum = 0, c = 0;
        statsSnap.docs.forEach(d => {
          const st = d.data();
          if (typeof st.masteryScore === 'number') { mSum += st.masteryScore; c++; }
          if (typeof st.delta14d === 'number') { dSum += st.delta14d; }
        });
        if (c > 0) {
          userAvgMastery = mSum / c;
          userAvgDelta = dSum / c;
        }
      }
    } catch (_) { /* ignore per-user stats failure to keep job resilient */ }
    if (u.institutionId) {
      const prev = instAgg.get(u.institutionId) || { users: 0, events: 0, masterySum: 0, masteryUsers: 0, deltaSum: 0 };
      instAgg.set(u.institutionId, {
        users: prev.users + 1,
        events: prev.events + events7d,
        masterySum: prev.masterySum + (userAvgMastery ?? 0),
        masteryUsers: prev.masteryUsers + (userAvgMastery == null ? 0 : 1),
        deltaSum: prev.deltaSum + (userAvgDelta ?? 0),
      });
    }
    if (u.companyId) {
      const prev = compAgg.get(u.companyId) || { users: 0, events: 0, masterySum: 0, masteryUsers: 0, deltaSum: 0 };
      compAgg.set(u.companyId, {
        users: prev.users + 1,
        events: prev.events + events7d,
        masterySum: prev.masterySum + (userAvgMastery ?? 0),
        masteryUsers: prev.masteryUsers + (userAvgMastery == null ? 0 : 1),
        deltaSum: prev.deltaSum + (userAvgDelta ?? 0),
      });
    }
  }
  const batch = db.batch();
  instAgg.forEach((v, k) => {
    const id = `inst_${k}_${dateStr}`;
    batch.set(db.collection('tenant_metrics_daily').doc(id), {
      tenantType: 'institution', tenantId: k, date: dateStr,
      activeUsers: v.users, events: v.events, avgEventsPerUser7d: v.users ? Number((v.events / v.users).toFixed(2)) : 0,
      avgMastery: v.masteryUsers ? Number((v.masterySum / v.masteryUsers).toFixed(3)) : 0,
      avgMasteryDelta14d: v.masteryUsers ? Number((v.deltaSum / v.masteryUsers).toFixed(3)) : 0,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    }, { merge: true });
  });
  compAgg.forEach((v, k) => {
    const id = `comp_${k}_${dateStr}`;
    batch.set(db.collection('tenant_metrics_daily').doc(id), {
      tenantType: 'company', tenantId: k, date: dateStr,
      activeUsers: v.users, events: v.events, avgEventsPerUser7d: v.users ? Number((v.events / v.users).toFixed(2)) : 0,
      avgMastery: v.masteryUsers ? Number((v.masterySum / v.masteryUsers).toFixed(3)) : 0,
      avgMasteryDelta14d: v.masteryUsers ? Number((v.deltaSum / v.masteryUsers).toFixed(3)) : 0,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    }, { merge: true });
  });
  await batch.commit();
  logInfo('tenant_metrics.daily_written', null, { instGroups: instAgg.size, compGroups: compAgg.size, usersProcessed: snaps.size });
  return null;
});

// ================= Retention Planning Placeholder (Scheduled) =================
// Logs what would be purged (dry-run). Future: guarded by feature flag.
exports.planRetentionTasks = functions.pubsub.schedule('every 24 hours').onRun(async () => {
  const db = admin.firestore();
  const now = Date.now();
  const windows = [
    { col: 'security_events', days: 60 },
    { col: 'engagement_snapshots', days: 90 },
    { col: 'user_points_events', days: 180 },
  ];
  for (const w of windows) {
    const cutoff = new Date(now - w.days * 24 * 60 * 60 * 1000);
    // NOTE: assumes createdAt/ts field—placeholder counts limited for cost
    try {
      const snap = await db.collection(w.col).where('createdAt','<', cutoff).limit(5).get();
      logInfo('retention.plan_sample', null, { collection: w.col, sampleCount: snap.size, cutoff: cutoff.toISOString() });
    } catch (e) {
      logError('retention.plan_error', null, { collection: w.col, error: e.message });
    }
  }
  return null;
});

// ================= Tenant Invitations (Callables) =================
// createInvite: super_admin OR tenant admin (org/company) creates an invitation for email+role.
// acceptInvite: authenticated user claims invite token, linking to tenant & applying role (with safeguards).
function _randomToken(len=32) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  let out=''; for (let i=0;i<len;i++) out += chars[Math.floor(Math.random()*chars.length)];
  return out;
}
const ALLOWED_INVITE_ROLES = new Set(['trainer','trainee','org_admin','company_admin']);
exports.createInvite = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError('unauthenticated','auth required');
  const { tenantType, tenantId, email, roleRequested } = data || {};
  if (!['institution','company'].includes(tenantType)) throw new functions.https.HttpsError('invalid-argument','invalid tenantType');
  if (typeof tenantId !== 'string' || tenantId.length === 0) throw new functions.https.HttpsError('invalid-argument','tenantId required');
  if (typeof email !== 'string' || !email.includes('@')) throw new functions.https.HttpsError('invalid-argument','valid email required');
  if (!ALLOWED_INVITE_ROLES.has(roleRequested)) throw new functions.https.HttpsError('invalid-argument','role not allowed');
  const db = admin.firestore();
  const actorSnap = await db.collection('users').doc(context.auth.uid).get();
  if (!actorSnap.exists) throw new functions.https.HttpsError('permission-denied','user missing');
  const actor = actorSnap.data();
  const isSuper = actor.role === 'super_admin';
  const isOrgAdmin = actor.role === 'org_admin';
  const isCompanyAdmin = actor.role === 'company_admin';
  // Authorization: super_admin always; org_admin only for institution & same institution; company_admin only for company & same company.
  if (!isSuper) {
    if (tenantType === 'institution' && (!isOrgAdmin || actor.institutionId !== tenantId)) {
      throw new functions.https.HttpsError('permission-denied','org_admin mismatch');
    }
    if (tenantType === 'company' && (!isCompanyAdmin || actor.companyId !== tenantId)) {
      throw new functions.https.HttpsError('permission-denied','company_admin mismatch');
    }
    // Non-super admins cannot invite another *admin* of different type (e.g. org_admin inviting company_admin) or escalate to super_admin.
    if ((roleRequested === 'org_admin' && !isSuper) || (roleRequested === 'company_admin' && !isSuper)) {
      // allow inviting same admin type only if same tenantType
      if (!((roleRequested === 'org_admin' && tenantType === 'institution' && isOrgAdmin) || (roleRequested === 'company_admin' && tenantType === 'company' && isCompanyAdmin))) {
        throw new functions.https.HttpsError('permission-denied','cannot invite elevated admin role');
      }
    }
  }
  const token = _randomToken(40);
  const expiresAt = new Date(Date.now() + 7*24*60*60*1000);
  const doc = {
    token,
    tenantType,
    tenantId,
    email: email.toLowerCase(),
    roleRequested,
    status: 'pending',
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    expiresAt,
    createdBy: context.auth.uid,
  };
  await db.collection('tenant_invites').doc(token).set(doc, { merge: false });
  await db.collection('admin_audit_logs').add({
    actorId: context.auth.uid,
    actionType: 'invite_create',
    target: `tenant_invites/${token}`,
    meta: { tenantType, tenantId, roleRequested, email: email.toLowerCase() },
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  logInfo('invite.created', null, { tenantType, tenantId, role: roleRequested });
  return { token, expiresAt: expiresAt.toISOString() };
});

exports.acceptInvite = functions.https.onCall( async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError('unauthenticated','auth required');
  const { token } = data || {};
  if (typeof token !== 'string' || token.length < 20) throw new functions.https.HttpsError('invalid-argument','token invalid');
  const db = admin.firestore();
  const inviteRef = db.collection('tenant_invites').doc(token);
  const snap = await inviteRef.get();
  if (!snap.exists) throw new functions.https.HttpsError('not-found','invite not found');
  const inv = snap.data();
  if (inv.status !== 'pending') throw new functions.https.HttpsError('failed-precondition','invite not pending');
  const exp = inv.expiresAt?.toDate ? inv.expiresAt.toDate() : new Date(inv.expiresAt);
  if (exp.getTime() < Date.now()) throw new functions.https.HttpsError('deadline-exceeded','invite expired');
  // Fetch user doc
  const userRef = db.collection('users').doc(context.auth.uid);
  const userSnap = await userRef.get();
  if (!userSnap.exists) throw new functions.https.HttpsError('failed-precondition','user profile missing');
  const user = userSnap.data();
  // Basic email match soft-check if user has email field
  if (user.email && user.email.toLowerCase() !== inv.email) {
    logInfo('invite.email_mismatch', null, { userEmail: user.email, inviteEmail: inv.email });
  }
  // Prevent cross-tenant contamination if already bound to a different tenant
  if (inv.tenantType === 'institution' && user.institutionId && user.institutionId !== inv.tenantId) {
    throw new functions.https.HttpsError('already-exists','user already bound to different institution');
  }
  if (inv.tenantType === 'company' && user.companyId && user.companyId !== inv.tenantId) {
    throw new functions.https.HttpsError('already-exists','user already bound to different company');
  }
  // Role application safety: do not overwrite super_admin; cannot escalate beyond requested role list
  const newData = {};
  if (inv.tenantType === 'institution') newData.institutionId = inv.tenantId; else newData.companyId = inv.tenantId;
  if (ALLOWED_INVITE_ROLES.has(inv.roleRequested) && user.role !== 'super_admin') {
    newData.role = inv.roleRequested; // Accept role upgrade within allowed set
  }
  await db.runTransaction(async (tx) => {
    tx.update(userRef, newData);
    tx.update(inviteRef, { status: 'accepted', acceptedBy: context.auth.uid, acceptedAt: admin.firestore.FieldValue.serverTimestamp() });
  });
  await db.collection('admin_audit_logs').add({
    actorId: context.auth.uid,
    actionType: 'invite_accept',
    target: `tenant_invites/${token}`,
    meta: { tenantType: inv.tenantType, tenantId: inv.tenantId, roleApplied: newData.role },
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  logInfo('invite.accepted', null, { token, tenantType: inv.tenantType, tenantId: inv.tenantId });
  return { ok: true };
});

// ================= Data Retention & Monthly Aggregation (Scheduled) =================
// purgeOldSecurityEvents: deletes security_events older than 60d (placeholder: batch limit 200)
exports.purgeOldSecurityEvents = functions.pubsub.schedule('every 24 hours').onRun( async () => {
  const db = admin.firestore();
  const cutoff = new Date(Date.now() - 60*24*60*60*1000);
  const snap = await db.collection('security_events').where('ts','<', cutoff).limit(200).get();
  if (snap.empty) { logInfo('purge.security_events.none'); return null; }
  const batch = db.batch();
  snap.docs.forEach(d => batch.delete(d.ref));
  await batch.commit();
  logInfo('purge.security_events.deleted', null, { count: snap.size });
  return null;
});

// aggregateMonthlyPoints: for previous month, summarize user_points_events into user_points_monthly/{userId_YYYY-MM}
exports.aggregateMonthlyPoints = functions.pubsub.schedule('every 24 hours').onRun(async () => {
  const now = new Date();
  const year = now.getUTCFullYear();
  const month = now.getUTCMonth(); // 0-based current month
  // Target previous month
  const targetMonth = month === 0 ? 12 : month; // 1..12 for previous
  const targetYear = month === 0 ? year - 1 : year;
  const monthStr = String(targetMonth).padStart(2,'0');
  const start = new Date(Date.UTC(targetYear, targetMonth-1, 1,0,0,0));
  const end = new Date(Date.UTC(targetYear, targetMonth, 1,0,0,0));
  const db = admin.firestore();
  // Placeholder: scan limited events; in production paginate / export
  const eventsSnap = await db.collection('user_points_events')
    .where('createdAt','>=', start)
    .where('createdAt','<', end)
    .limit(5000)
    .get();
  if (eventsSnap.empty) { logInfo('points.monthly.no_events', null, { month: monthStr, year: targetYear }); return null; }
  const agg = new Map(); // userId -> { points, counts: {type->n} }
  eventsSnap.docs.forEach(d => {
    const e = d.data();
    const uid = e.userId; if (!uid) return;
    const rec = agg.get(uid) || { points: 0, counts: {} };
    rec.points += (e.points || 0);
    const t = e.type || 'other';
    rec.counts[t] = (rec.counts[t]||0)+1;
    agg.set(uid, rec);
  });
  const batch = db.batch();
  agg.forEach((v, uid) => {
    const id = `${uid}_${targetYear}-${monthStr}`;
    batch.set(db.collection('user_points_monthly').doc(id), {
      userId: uid,
      year: targetYear,
      month: targetMonth,
      points: v.points,
      typeCounts: v.counts,
      computedAt: admin.firestore.FieldValue.serverTimestamp(),
    }, { merge: true });
  });
  await batch.commit();
  logInfo('points.monthly.aggregated', null, { users: agg.size, month: monthStr, year: targetYear });
  return null;
});

// (Deprecated placeholder) updateSkillMasteryDeltas retained for backwards compatibility; now no-op.
exports.updateSkillMasteryDeltas = functions.pubsub.schedule('every 24 hours').onRun(async () => {
  logInfo('mastery.delta_deprecated');
  return null;
});

// ================= Mastery Computation (Attempt-Based with 14d Delta) =================
// Aggregates last 28 days of skill_attempts:
//  - Current window: last 14 days
//  - Previous window: days 15-28
// masteryScore = successRatio(last14d)
// delta14d = successRatio(last14d) - successRatio(prev14d)
exports.recomputeSkillMastery = functions.pubsub.schedule('every 24 hours').onRun(async () => {
  const db = admin.firestore();
  const now = Date.now();
  const windowCurrentStart = new Date(now - 14*24*60*60*1000);
  const windowPrevStart = new Date(now - 28*24*60*60*1000);
  // Fetch attempts for 28d window
  const attemptsSnap = await db.collection('skill_attempts')
    .where('ts','>=', windowPrevStart)
    .limit(8000) // safety cap placeholder
    .get();
  if (attemptsSnap.empty) { logInfo('mastery.no_attempts'); return null; }
  const map = new Map(); // key -> { cur:{s,t}, prev:{s,t} }
  attemptsSnap.docs.forEach(doc => {
    const a = doc.data();
    const ts = a.ts?.toDate ? a.ts.toDate() : (a.ts instanceof Date ? a.ts : null);
    if (!a.userId || !a.skillCode || !ts) return;
    const key = `${a.userId}|${a.skillCode}`;
    const bucket = map.get(key) || { cur:{s:0,t:0}, prev:{s:0,t:0} };
    if (ts >= windowCurrentStart) {
      bucket.cur.t += 1; if (a.success) bucket.cur.s += 1;
    } else {
      bucket.prev.t += 1; if (a.success) bucket.prev.s += 1;
    }
    map.set(key, bucket);
  });
  const batch = db.batch();
  map.forEach((v, key) => {
    const [userId, skillCode] = key.split('|');
    if (!userId || !skillCode) return;
    const curRatio = v.cur.t === 0 ? 0 : v.cur.s / v.cur.t;
    const prevRatio = v.prev.t === 0 ? 0 : v.prev.s / v.prev.t;
    const mastery = Number(curRatio.toFixed(3));
    const delta14d = Number((curRatio - prevRatio).toFixed(3));
    const ref = db.collection('user_skill_stats').doc(`${userId}_${skillCode}`);
    batch.set(ref, {
      userId, skillCode,
      masteryScore: mastery,
      delta14d,
      attempts: admin.firestore.FieldValue.increment(v.cur.t + v.prev.t),
      lastUpdate: admin.firestore.FieldValue.serverTimestamp(),
    }, { merge: true });
  });
  await batch.commit();
  logInfo('mastery.recomputed', null, { pairs: map.size });
  return null;
});

// ================= Weekly Challenges (Phase 2) =================
// Data model:
// weekly_challenges/{id}: { title, description, targetType ('points'|'quizzesPassed'|'tasksCompleted'|'attempts'), targetValue:int, activeRange:{ start:ISO, end:ISO }, createdAt, updatedAt, active:boolean }
// user_challenge_progress/{userId_weekId}: { userId, challengeId, progress, completed:boolean, completedAt?, lastEval }
// Evaluation strategy (daily schedule):
//  - Determine currently active challenges (active==true && now within activeRange)
//  - For each challenge, compute per-user progress metric:
//      * points -> user_points.points delta since challenge.start (requires baseline capture). Simplicity: measure absolute points and treat targetValue as current points (MVP) or fallback to events count.
//      * quizzesPassed / tasksCompleted -> read from user_points document counters.
//      * attempts -> count skill_attempts in window.
//  - Write/update user_challenge_progress docs (server-only). Mark completed when progress >= targetValue.
// NOTE: For v1 we avoid per-user baselines to keep logic simple; improvement later: snapshot baseline at activation.

exports.evaluateWeeklyChallenges = functions.pubsub.schedule('every 24 hours').onRun(async () => {
  const db = admin.firestore();
  const now = new Date();
  const nowIso = now.toISOString();
  const activeSnap = await db.collection('weekly_challenges')
    .where('active','==', true)
    .limit(20) // safety cap
    .get();
  if (activeSnap.empty) { logInfo('challenges.none_active'); return null; }
  // Fetch users limited (improvement: only engaged users / via snapshots). MVP: cap 500 users.
  const usersSnap = await db.collection('users').limit(500).get();
  if (usersSnap.empty) { logInfo('challenges.no_users'); return null; }
  const batch = db.batch();
  let progressWrites = 0;
  for (const chalDoc of activeSnap.docs) {
    const chal = chalDoc.data();
    const range = chal.activeRange || {};
    if (range.start && nowIso < range.start) continue;
    if (range.end && nowIso > range.end) continue;
    const challengeId = chalDoc.id;
    // Preload skill attempts counts for attempts-based challenges per user in window (only if needed)
    let attemptsByUser = null;
    if (chal.targetType === 'attempts') {
      const start = range.start ? new Date(range.start) : new Date(now.getTime() - 7*24*60*60*1000);
      const attemptsSnap = await db.collection('skill_attempts')
        .where('ts','>=', start)
        .limit(5000) // safety cap
        .get();
      attemptsByUser = new Map();
      attemptsSnap.docs.forEach(d => {
        const a = d.data();
        if (!a.userId) return;
        attemptsByUser.set(a.userId, (attemptsByUser.get(a.userId)||0)+1);
      });
    }
    for (const user of usersSnap.docs) {
      const uid = user.id;
      const pointsDoc = await db.collection('user_points').doc(uid).get();
      const p = pointsDoc.exists ? pointsDoc.data() : {};
      let metric = 0;
      switch (chal.targetType) {
        case 'points':
          metric = p.points || 0; // Improvement later: baseline subtraction
          break;
        case 'quizzesPassed':
          metric = p.quizzesPassed || 0;
          break;
        case 'tasksCompleted':
          metric = p.tasksCompleted || 0;
          break;
        case 'attempts':
          metric = attemptsByUser ? (attemptsByUser.get(uid)||0) : 0;
          break;
        default:
          metric = 0;
      }
      const progressId = `${uid}_${challengeId}`;
      const ref = db.collection('user_challenge_progress').doc(progressId);
      const completed = metric >= (chal.targetValue || 0) && (chal.targetValue||0) > 0;
      batch.set(ref, {
        userId: uid,
        challengeId,
        progress: metric,
        target: chal.targetValue || 0,
        lastEval: admin.firestore.FieldValue.serverTimestamp(),
        completed,
        completedAt: completed ? admin.firestore.FieldValue.serverTimestamp() : admin.firestore.FieldValue.delete(),
      }, { merge: true });
      progressWrites++;
      if (progressWrites % 400 === 0) { // commit mid-way to avoid batch size limit
        await batch.commit();
      }
    }
  }
  if (progressWrites % 400 !== 0) {
    await batch.commit();
  }
  logInfo('challenges.evaluated', null, { progressWrites });
  return null;
});

// Callable: createWeeklyChallenge (super_admin only for now)
exports.createWeeklyChallenge = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError('unauthenticated','auth required');
  const db = admin.firestore();
  const actor = await db.collection('users').doc(context.auth.uid).get();
  if (!actor.exists || actor.data().role !== 'super_admin') {
    throw new functions.https.HttpsError('permission-denied','super_admin only');
  }
  const { title, description, targetType, targetValue, start, end } = data || {};
  const allowedTypes = new Set(['points','quizzesPassed','tasksCompleted','attempts']);
  if (typeof title !== 'string' || title.length < 3) throw new functions.https.HttpsError('invalid-argument','title invalid');
  if (!allowedTypes.has(targetType)) throw new functions.https.HttpsError('invalid-argument','targetType invalid');
  if (typeof targetValue !== 'number' || targetValue <= 0) throw new functions.https.HttpsError('invalid-argument','targetValue invalid');
  const range = { start: start || new Date().toISOString(), end: end || new Date(Date.now()+7*24*60*60*1000).toISOString() };
  const doc = {
    title,
    description: description || '',
    targetType,
    targetValue,
    activeRange: range,
    active: true,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  };
  const ref = await db.collection('weekly_challenges').add(doc);
  await db.collection('admin_audit_logs').add({
    actorId: context.auth.uid,
    actionType: 'weekly_challenge_create',
    target: `weekly_challenges/${ref.id}`,
    meta: { targetType, targetValue },
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  logInfo('challenge.created', null, { id: ref.id, targetType });
  return { id: ref.id };
});

// Callable: forceEvaluateChallenges (super_admin manual trigger)
exports.forceEvaluateChallenges = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError('unauthenticated','auth required');
  const db = admin.firestore();
  const actor = await db.collection('users').doc(context.auth.uid).get();
  if (!actor.exists || actor.data().role !== 'super_admin') {
    throw new functions.https.HttpsError('permission-denied','super_admin only');
  }
  await exports.evaluateWeeklyChallenges.run();
  return { ok: true };
});

// ================= Kudos System (Phase 2) =================
// Data model: kudos_events/{id} { fromUserId, toUserId, reason, ts, scope?, weight }
// Constraints:
//  - A user cannot give kudos to self.
//  - Rate limit: max 5 kudos given per 24h per user (configurable).
//  - Optional per-target limit: no more than 2 kudos to same recipient in 24h.
//  - Writes server-only (rules deny creates) enforced in callable.
// Future: integrate into feed (client already can query list) & points bonus.

const KUDOS_DAILY_LIMIT = 5;
const KUDOS_PER_TARGET_LIMIT = 2;

exports.giveKudos = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError('unauthenticated','auth required');
  const { toUserId, reason, weight } = data || {};
  if (typeof toUserId !== 'string' || toUserId.length < 4) throw new functions.https.HttpsError('invalid-argument','toUserId invalid');
  if (toUserId === context.auth.uid) throw new functions.https.HttpsError('failed-precondition','cannot_kudos_self');
  if (reason && typeof reason !== 'string') throw new functions.https.HttpsError('invalid-argument','reason must be string');
  const w = (typeof weight === 'number' && weight > 0 && weight <= 5) ? weight : 1;
  const db = admin.firestore();
  const now = new Date();
  const since = new Date(now.getTime() - 24*60*60*1000);
  const fromUserId = context.auth.uid;
  // Query last 24h kudos given by this user
  const givenSnap = await db.collection('kudos_events')
    .where('fromUserId','==', fromUserId)
    .where('ts','>=', since)
    .limit(30)
    .get();
  if (givenSnap.size >= KUDOS_DAILY_LIMIT) {
    throw new functions.https.HttpsError('resource-exhausted','daily kudos limit reached');
  }
  const sameTargetCount = givenSnap.docs.filter(d => (d.data().toUserId === toUserId)).length;
  if (sameTargetCount >= KUDOS_PER_TARGET_LIMIT) {
    throw new functions.https.HttpsError('resource-exhausted','per-target kudos limit reached');
  }
  const id = `${fromUserId}_${Date.now()}`;
  await db.collection('kudos_events').doc(id).set({
    fromUserId,
    toUserId,
    reason: reason || null,
    weight: w,
    ts: admin.firestore.FieldValue.serverTimestamp(),
  }, { merge: false });
  logInfo('kudos.created', null, { fromUserId, toUserId, weight: w });
  return { ok: true };
});

// Scheduled cleanup (optional) to cap stale kudos volume (e.g., keep 90d). Placeholder simple delete sample of >90d.
exports.purgeOldKudos = functions.pubsub.schedule('every 24 hours').onRun(async () => {
  const db = admin.firestore();
  const cutoff = new Date(Date.now() - 90*24*60*60*1000);
  const snap = await db.collection('kudos_events')
    .where('ts','<', cutoff)
    .limit(200)
    .get();
  if (snap.empty) { logInfo('kudos.purge.none'); return null; }
  const batch = db.batch();
  snap.docs.forEach(d => batch.delete(d.ref));
  await batch.commit();
  logInfo('kudos.purge.deleted', null, { count: snap.size });
  return null;
});

// ================= Quest Chains (Phase 2) =================
// Data model:
// quests/{id}: { title, description, active:boolean, order:int, createdAt, updatedAt }
// quest_steps/{id}: { questId, index:int, type ('points'|'quiz'|'task'|'skill'), target:int, skillCode?, createdAt }
// user_quest_state/{userId_questId}: { userId, questId, stepCount, completedSteps:[int], progress:{stepIndex:{value:int, completed:boolean}}, completed:boolean, completedAt?, lastEval }
// Simplicity: progress computed on demand + incremental callable for explicit actions.

exports.createQuest = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError('unauthenticated','auth required');
  const db = admin.firestore();
  const actor = await db.collection('users').doc(context.auth.uid).get();
  if (!actor.exists || actor.data().role !== 'super_admin') throw new functions.https.HttpsError('permission-denied','super_admin only');
  const { title, description, steps } = data || {};
  if (typeof title !== 'string' || title.length < 3) throw new functions.https.HttpsError('invalid-argument','title invalid');
  if (!Array.isArray(steps) || steps.length === 0) throw new functions.https.HttpsError('invalid-argument','steps required');
  const questRef = await db.collection('quests').add({
    title,
    description: description || '',
    active: true,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  const batch = db.batch();
  steps.forEach((s, idx) => {
    const ref = db.collection('quest_steps').doc();
    batch.set(ref, {
      questId: questRef.id,
      index: idx,
      type: s.type || 'points',
      target: s.target || 1,
      skillCode: s.skillCode || null,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  });
  await batch.commit();
  logInfo('quest.created', null, { questId: questRef.id, steps: steps.length });
  return { id: questRef.id };
});

// Progress quest step: primarily used for explicit actions (e.g., finish quiz) if we want immediate update.
exports.progressQuestStep = functions.https.onCall(async (data, context) => {
  if (!context.auth) throw new functions.https.HttpsError('unauthenticated','auth required');
  const { questId, stepIndex, increment } = data || {};
  if (typeof questId !== 'string' || typeof stepIndex !== 'number') throw new functions.https.HttpsError('invalid-argument','questId/stepIndex invalid');
  const inc = (typeof increment === 'number' && increment > 0) ? increment : 1;
  const db = admin.firestore();
  const qSnap = await db.collection('quests').doc(questId).get();
  if (!qSnap.exists || qSnap.data().active !== true) throw new functions.https.HttpsError('failed-precondition','quest inactive');
  // Fetch steps count
  const stepsSnap = await db.collection('quest_steps').where('questId','==', questId).get();
  const totalSteps = stepsSnap.size;
  const stateId = `${context.auth.uid}_${questId}`;
  const stateRef = db.collection('user_quest_state').doc(stateId);
  await db.runTransaction(async (tx) => {
    const stSnap = await tx.get(stateRef);
    const st = stSnap.exists ? stSnap.data() : { progress: {}, completedSteps: [], stepCount: totalSteps };
    const prog = st.progress || {};
    const cur = prog[stepIndex] || { value: 0, completed: false };
    if (cur.completed) return; // already done
    cur.value += inc;
    // Find target for this step
    const stepDoc = stepsSnap.docs.find(d => d.data().index === stepIndex);
    const target = stepDoc ? (stepDoc.data().target || 1) : 1;
    if (cur.value >= target) {
      cur.completed = true;
      st.completedSteps = Array.from(new Set([...(st.completedSteps||[]), stepIndex]));
    }
    prog[stepIndex] = cur;
    const allDone = st.completedSteps.length === totalSteps;
    tx.set(stateRef, {
      userId: context.auth.uid,
      questId,
      progress: prog,
      completedSteps: st.completedSteps,
      stepCount: totalSteps,
      completed: allDone,
      completedAt: allDone ? admin.firestore.FieldValue.serverTimestamp() : admin.firestore.FieldValue.delete(),
      lastEval: admin.firestore.FieldValue.serverTimestamp(),
    }, { merge: true });
  });
  logInfo('quest.progress', null, { questId, stepIndex, inc });
  return { ok: true };
});

// Scheduled evaluator (once per day) to reconcile implicit progress types (e.g., points, skill attempts) — MVP placeholder.
exports.evaluateQuests = functions.pubsub.schedule('every 24 hours').onRun( async () => {
  const db = admin.firestore();
  const activeQuests = await db.collection('quests').where('active','==', true).limit(20).get();
  if (activeQuests.empty) { logInfo('quests.none_active'); return null; }
  // For MVP we just log; future: recompute implicit metrics similar to challenges.
  logInfo('quests.evaluate_placeholder', null, { active: activeQuests.size });
  return null;
});