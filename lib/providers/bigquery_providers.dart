import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/bigquery_export_service.dart';
import '../models/bigquery_export.dart';

/// مزود خدمة BigQuery Export
final bigQueryExportServiceProvider = Provider<BigQueryExportService>((ref) {
  return BigQueryExportService();
});

/// مزود إعدادات BigQuery
final bigQueryConfigProvider = FutureProvider.family<BigQueryConfig?, String>((ref, institutionId) async {
  final service = ref.watch(bigQueryExportServiceProvider);
  return service.getConfig(institutionId);
});

/// مزود سجل التصديرات
final exportsHistoryProvider = StreamProvider.family<List<BigQueryExport>, String>((ref, institutionId) {
  final service = ref.watch(bigQueryExportServiceProvider);
  return service.getExportsHistory(institutionId);
});
