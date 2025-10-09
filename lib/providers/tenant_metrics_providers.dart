import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tenant_metric_daily.dart';

final _fs = Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);

Stream<List<TenantMetricDaily>> _metricsStream(
  FirebaseFirestore fs,
  String tenantType,
  String tenantId,
  int limitDays,
) {
  // Ordered by date desc, limited
  return fs
      .collection('tenant_metrics_daily')
      .where('tenantType', isEqualTo: tenantType)
      .where('tenantId', isEqualTo: tenantId)
      .orderBy('date', descending: true)
      .limit(limitDays)
      .withConverter<Map<String, dynamic>>(
        fromFirestore: (snap, _) => snap.data() ?? {},
        toFirestore: (value, _) => value,
      )
      .snapshots()
      .map(
        (q) => q.docs
            .map(
              (d) => TenantMetricDaily.fromDoc(
                d as DocumentSnapshot<Map<String, dynamic>>,
              ),
            )
            .toList(),
      );
}

final orgTenantMetricsProvider =
    StreamProvider.family<
      List<TenantMetricDaily>,
      ({String tenantId, int days})
    >((ref, params) {
      final fs = ref.watch(_fs);
      return _metricsStream(fs, 'institution', params.tenantId, params.days);
    });

final companyTenantMetricsProvider =
    StreamProvider.family<
      List<TenantMetricDaily>,
      ({String tenantId, int days})
    >((ref, params) {
      final fs = ref.watch(_fs);
      return _metricsStream(fs, 'company', params.tenantId, params.days);
    });
