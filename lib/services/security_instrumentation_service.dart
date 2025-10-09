import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// Lightweight client-side security instrumentation.
/// Usage: SecurityInstrumentation.instance.recordPermissionDenied(docPath: 'users/abc', vector: 'RULES_SPIKE');
class SecurityInstrumentation {
  SecurityInstrumentation._();
  static final instance = SecurityInstrumentation._();

  final _fs = FirebaseFirestore.instance;

  Future<void> record({
    required String type,
    required String vector,
    String? docPath,
    String severity = 'low',
    Map<String, dynamic>? meta,
  }) async {
    try {
      final data = {
        'type': type,
        'vector': vector,
        if (docPath != null) 'docPath': docPath,
        'severity': severity,
        // We rely on rules expecting ts == request.time (client sends a sentinel) so we set nothing special here.
        'ts': FieldValue.serverTimestamp(),
        'meta': meta ?? <String, dynamic>{},
      };
      await _fs.collection('security_events').add(data);
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('[security_instrumentation][error] $e\n$st');
      }
    }
  }

  Future<void> recordPermissionDenied({required String docPath}) => record(
    type: 'permission_denied',
    vector: 'RULES_SPIKE',
    docPath: docPath,
    severity: 'low',
  );

  Future<void> recordPrivilegeEscalationAttempt({required String docPath}) =>
      record(
        type: 'privilege_denied',
        vector: 'PRIV_ESC',
        docPath: docPath,
        severity: 'med',
      );

  Future<void> recordPayloadSuspect({
    required String docPath,
    Map<String, dynamic>? meta,
  }) => record(
    type: 'payload_suspect',
    vector: 'INJ_JSON',
    docPath: docPath,
    severity: 'med',
    meta: meta,
  );
}
