import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/widgets.dart';
import 'package:training_app/firebase_options.dart';

/// Seeds minimal tenants (one institution, one company) and users for each role.
/// Run with:
///   flutter pub run tools/seed_users.dart
/// Ensure rules allow super_admin to create tenants and users for this one-time setup
/// or run against Emulator where rules can be relaxed.
Future<void> main() async {
  // Required when running via `flutter run -t tools/seed_users.dart` to init platform/bindings.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final fs = FirebaseFirestore.instance;
  final auth = fb.FirebaseAuth.instance;

  // Helper to create email users if not exists
  Future<String> ensureUser(String email, String password) async {
    try {
      final cred = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return cred.user!.uid;
    } on fb.FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        final signIn = await auth.signInWithEmailAndPassword(email: email, password: password);
        return signIn.user!.uid;
      }
      rethrow;
    }
  }

  // Note: We skip creating institutions/companies docs to comply with rules (server-only writes).

  // Create accounts for each role
  final passwords = 'P@ssw0rd123';
  final roles = <String, Map<String, dynamic>>{
    'super_admin': { },
    'trainer': { 'institutionId': 'inst_demo' },
    'trainee': { 'institutionId': 'inst_demo' },
    'org_admin': { 'institutionId': 'inst_demo' },
    'company_admin': { 'companyId': 'comp_demo' },
    'manager': { 'companyId': 'comp_demo' },
    'employee': { 'companyId': 'comp_demo' },
  };

  final created = <String, String>{};
  for (final entry in roles.entries) {
    final role = entry.key;
    final meta = entry.value;
    final email = 'demo+$role@example.com';
    final displayName = role.replaceAll('_', ' ').split(' ').map((w) =>
        w.isEmpty ? w : (w[0].toUpperCase() + w.substring(1))).join(' ');
    stdout.writeln('[seed] Ensuring user for role="$role" email="$email"');
    final uid = await ensureUser(email, passwords);
    created[role] = uid;
    try {
      await fs.collection('users').doc(uid).set({
        'email': email,
        'name': displayName,
        'role': role,
        'institutionId': meta['institutionId'],
        'companyId': meta['companyId'],
        'status': 'active',
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      stdout.writeln('[seed] Wrote Firestore user doc for role="$role" uid=$uid');
    } catch (e) {
      stderr.writeln('[seed][warn] Failed writing Firestore doc for role="$role" uid=$uid -> $e');
    }
  }

  stdout.writeln('Seed complete. User IDs:');
  created.forEach((role, uid) => stdout.writeln('- $role: $uid'));
  // Terminate the Flutter runner cleanly when invoked via `flutter run -t`.
  exit(0);
}
