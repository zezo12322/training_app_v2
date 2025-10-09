/// Backfill / scaffolding script (manual run) for assigning institutionId / companyId
/// to existing users before enforcing tenant scoping.
///
/// Usage (one-off, run from project root with proper Firebase credentials):
///   dart run tools/backfill_tenants.dart
///
/// Strategy:
/// 1. Fetch all users (batched) – for MVP keep under 1000; for >1k implement pagination / startAfter.
/// 2. Decide assignment rule:
///    - If email domain matches known company domain map -> assign companyId
///    - Else if flagged list of academic domains -> assign institutionId
///    - Else leave null (remains in global / B2C context)
/// 3. Write updates in small batches (<= 400 writes) respecting Firestore limits.
/// 4. Dry run mode first (set DRY_RUN=true env to simulate without writes).
///
/// NOTE: This is a simplistic helper; in production consider an Admin SDK script outside the client repo
/// with stronger logging & retry semantics.
library;

import 'dart:io';
import 'package:training_app/core/logging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:training_app/firebase_options.dart';

final domainCompanyMap = <String, String>{
  'acme.com': 'company_acme',
  'megacorp.io': 'company_megacorp',
};
final academicDomains = <String, String>{
  'uni.edu': 'inst_uni',
  'college.edu': 'inst_college',
};

Future<void> main() async {
  final dryRun =
      (Platform.environment['DRY_RUN'] ?? 'true').toLowerCase() == 'true';
  logger.i('Starting tenant backfill (dryRun=$dryRun)');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final fs = FirebaseFirestore.instance;
  final usersSnap = await fs.collection('users').limit(1000).get();
  logger.i('Fetched ${usersSnap.docs.length} users');
  int toUpdate = 0;
  WriteBatch? batch = dryRun ? null : fs.batch();
  for (final doc in usersSnap.docs) {
    final data = doc.data();
    final email = (data['email'] as String?) ?? '';
    if (email.isEmpty) continue;
    final domain = email.split('@').length == 2
        ? email.split('@')[1].toLowerCase()
        : '';
    String? companyId;
    String? institutionId;
    if (domainCompanyMap.containsKey(domain)) {
      companyId = domainCompanyMap[domain];
    } else if (academicDomains.containsKey(domain)) {
      institutionId = academicDomains[domain];
    }
    if (companyId == null && institutionId == null) {
      continue; // nothing to assign
    }
    // Skip if already assigned
    if ((data['companyId'] != null && companyId != null) ||
        (data['institutionId'] != null && institutionId != null)) {
      continue;
    }
    toUpdate++;
    logger.i('Will update user ${doc.id}: companyId=$companyId institutionId=$institutionId');
    if (!dryRun) {
      final update = <String, dynamic>{};
      if (companyId != null) update['companyId'] = companyId;
      if (institutionId != null) update['institutionId'] = institutionId;
      batch!.update(doc.reference, update);
      if (toUpdate % 400 == 0) {
        await batch.commit();
  logger.i('Committed 400 updates');
        batch = fs.batch();
      }
    }
  }
  if (!dryRun && batch != null && toUpdate % 400 != 0) {
    await batch.commit();
  }
  logger.i('Backfill complete. Updated candidates: $toUpdate (dryRun=$dryRun)');
}
