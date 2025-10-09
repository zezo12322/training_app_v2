/*
 Requires a service account with Editor access. Set env:
   $env:GOOGLE_APPLICATION_CREDENTIALS="C:\\path\\to\\service-account.json"
 Then run:
   node tools/admin/seed_users_admin.js
*/
const admin = require('firebase-admin');

if (!process.env.GOOGLE_APPLICATION_CREDENTIALS) {
  console.error('GOOGLE_APPLICATION_CREDENTIALS not set. Please point it to a service account JSON.');
  process.exit(1);
}

admin.initializeApp();
const db = admin.firestore();
const auth = admin.auth();

async function ensureUser(email, password) {
  try {
    const user = await auth.getUserByEmail(email);
    return user.uid;
  } catch (e) {
    if (e.code === 'auth/user-not-found') {
      const cred = await auth.createUser({ email, password, emailVerified: true, disabled: false });
      return cred.uid;
    }
    throw e;
  }
}

async function main() {
  // Tenants
  await db.doc('institutions/inst_demo').set({ name: 'Demo Institution', planTier: 'free', active: true, createdAt: admin.firestore.FieldValue.serverTimestamp() }, { merge: true });
  await db.doc('companies/comp_demo').set({ name: 'Demo Company', planTier: 'free', active: true, createdAt: admin.firestore.FieldValue.serverTimestamp() }, { merge: true });

  const password = 'P@ssw0rd123';
  const roles = [
    { role: 'super_admin', meta: {} },
    { role: 'trainer', meta: { institutionId: 'inst_demo' } },
    { role: 'trainee', meta: { institutionId: 'inst_demo' } },
    { role: 'org_admin', meta: { institutionId: 'inst_demo' } },
    { role: 'company_admin', meta: { companyId: 'comp_demo' } },
    { role: 'manager', meta: { companyId: 'comp_demo' } },
    { role: 'employee', meta: { companyId: 'comp_demo' } },
  ];

  const created = {};
  for (const { role, meta } of roles) {
    const email = `demo+${role}@example.com`;
    const uid = await ensureUser(email, password);
    created[role] = uid;
    await db.collection('users').doc(uid).set({
      email,
      role,
      institutionId: meta.institutionId || null,
      companyId: meta.companyId || null,
      status: 'active',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    }, { merge: true });
  }

  console.log('Seed complete. User IDs:');
  for (const [role, uid] of Object.entries(created)) {
    console.log(`- ${role}: ${uid}`);
  }
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
