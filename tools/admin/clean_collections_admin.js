/*
 Batch delete utility using admin SDK. Requires service account:
   $env:GOOGLE_APPLICATION_CREDENTIALS="C:\\path\\to\\service-account.json"
 Run:
   node tools/admin/clean_collections_admin.js
*/
const admin = require('firebase-admin');
if (!process.env.GOOGLE_APPLICATION_CREDENTIALS) {
  console.error('GOOGLE_APPLICATION_CREDENTIALS not set.');
  process.exit(1);
}
admin.initializeApp();
const db = admin.firestore();

async function deleteCollection(coll, batchSize = 300) {
  while (true) {
    const snap = await db.collection(coll).limit(batchSize).get();
    if (snap.empty) break;
    const batch = db.batch();
    snap.docs.forEach((d) => batch.delete(d.ref));
    await batch.commit();
    console.log(`Deleted ${snap.size} from ${coll}`);
    if (snap.size < batchSize) break;
  }
}

async function main() {
  const targets = [
    'user_points_events',
    'engagement_snapshots',
    'risk_user_scores',
    'security_events',
    'security_daily_rollups',
    'intrusion_alerts',
    'predictive_alerts',
    'tenant_metrics_daily',
    'course_wall',
    'post_comments',
  ];
  for (const c of targets) {
    await deleteCollection(c);
  }
  console.log('Cleanup complete');
}

main().catch((e) => { console.error(e); process.exit(1); });
