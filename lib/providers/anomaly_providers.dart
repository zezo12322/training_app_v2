import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/anomaly_detection_service.dart';
import '../models/anomaly.dart';

/// مزود خدمة الكشف عن الشذوذ
final anomalyDetectionServiceProvider = Provider<AnomalyDetectionService>((ref) {
  return AnomalyDetectionService();
});

/// مزود إعدادات الكشف
final anomalySettingsProvider = FutureProvider.family<AnomalyDetectionSettings?, String>((ref, institutionId) async {
  final service = ref.watch(anomalyDetectionServiceProvider);
  return service.getSettings(institutionId);
});

/// مزود قائمة الشذوذات
final anomaliesProvider = StreamProvider.family<List<AnomalyScore>, AnomalyFilter>((ref, filter) {
  final service = ref.watch(anomalyDetectionServiceProvider);
  return service.getAnomalies(
    filter.institutionId,
    status: filter.status,
    severity: filter.severity,
  );
});

/// مزود التنبيهات
final anomalyAlertsProvider = StreamProvider.family<List<AnomalyAlert>, String>((ref, institutionId) {
  final service = ref.watch(anomalyDetectionServiceProvider);
  return service.getAlerts(institutionId);
});

/// فلتر الشذوذات
class AnomalyFilter {
  final String institutionId;
  final InvestigationStatus? status;
  final AnomalySeverity? severity;

  const AnomalyFilter({
    required this.institutionId,
    this.status,
    this.severity,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnomalyFilter &&
          runtimeType == other.runtimeType &&
          institutionId == other.institutionId &&
          status == other.status &&
          severity == other.severity;

  @override
  int get hashCode => Object.hash(institutionId, status, severity);
}
