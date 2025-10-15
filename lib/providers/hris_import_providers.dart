import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/hris_import_service.dart';
import '../models/hris_import.dart';

/// مزود خدمة HRIS Import
final hrisImportServiceProvider = Provider<HRISImportService>((ref) {
  return HRISImportService();
});

/// مزود القوالب
final importTemplatesProvider = FutureProvider.family<List<ImportTemplate>, String>((ref, institutionId) async {
  final service = ref.watch(hrisImportServiceProvider);
  return service.getTemplates(institutionId);
});
