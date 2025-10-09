#!/usr/bin/env node
/**
 * Extended Firestore Rules Simulation: Write Enforcement & Scoped Logic
 * Run with: node tools/rules_simulation_write_enforcement.js
 * Requires Firestore emulator running.
 */
const { initializeTestEnvironment, assertSucceeds, assertFails } = require('@firebase/rules-unit-testing');
const fs = require('fs');

(async () => {
  const testEnv = await initializeTestEnvironment({
    projectId: 'demo-training-app',
    firestore: { rules: fs.readFileSync('../firestore.rules', 'utf8') }
  });
  const sys = testEnv.unauthenticatedContext().firestore();
  // Seed flags: enforceTenantWrites = true
  await sys.collection('system_settings').doc('global').set({ featureFlags: { enforceTenantWrites: true } });
  // Seed users
  await sys.collection('users').doc('trainerA').set({ role: 'trainer', institutionId: 'inst1' });
  await sys.collection('users').doc('trainerB').set({ role: 'trainer', institutionId: 'inst2' });
  await sys.collection('users').doc('superX').set({ role: 'super_admin' });

  const ctxTrainerA = testEnv.authenticatedContext('trainerA');
  const ctxTrainerB = testEnv.authenticatedContext('trainerB');
  const ctxSuper = testEnv.authenticatedContext('superX');
  const dbA = ctxTrainerA.firestore();
  const dbB = ctxTrainerB.firestore();
  const dbSuper = ctxSuper.firestore();

  // Course create: trainerA sets inst1 -> allowed; mismatched inst2 -> denied
  await assertSucceeds(dbA.collection('courses').doc('c1').set({ trainerId: 'trainerA', institutionId: 'inst1' }));
  await assertFails(dbA.collection('courses').doc('cBad').set({ trainerId: 'trainerA', institutionId: 'inst2' }));

  // TrainerB cannot update trainerA's course
  await assertFails(dbB.collection('courses').doc('c1').update({ name: 'Hack' }));

  // Super admin bypass write (different tenant)
  await assertSucceeds(dbSuper.collection('courses').doc('cSuper').set({ trainerId: 'superX', institutionId: 'inst999' }));

  // Task create inside enforced writes: valid tenant ok, mismatched denied
  await assertSucceeds(dbA.collection('tasks').doc('t1').set({ parentType: 'course', institutionId: 'inst1', pointsOnComplete: 10 }));
  await assertFails(dbA.collection('tasks').doc('tBad').set({ parentType: 'course', institutionId: 'inst2', pointsOnComplete: 5 }));

  // Course resource create mismatched -> denied
  await assertSucceeds(dbA.collection('course_resources').doc('r1').set({ institutionId: 'inst1', title: 'Doc' }));
  await assertFails(dbA.collection('course_resources').doc('rBad').set({ institutionId: 'inst2', title: 'Leak' }));

  console.log('Write enforcement scenarios passed');
  await testEnv.cleanup();
})();
