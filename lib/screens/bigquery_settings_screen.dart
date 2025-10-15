import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bigquery_export.dart';
import '../providers/bigquery_providers.dart';
import '../providers/user_providers.dart';
import '../core/logging.dart';

/// شاشة إعدادات BigQuery
class BigQuerySettingsScreen extends ConsumerStatefulWidget {
  const BigQuerySettingsScreen({super.key});

  @override
  ConsumerState<BigQuerySettingsScreen> createState() => _BigQuerySettingsScreenState();
}

class _BigQuerySettingsScreenState extends ConsumerState<BigQuerySettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _projectIdController = TextEditingController();
  final _datasetIdController = TextEditingController();
  final _credentialsController = TextEditingController();
  
  bool _isEnabled = false;
  final Set<ExportType> _enabledExports = {};
  ExportFrequency _defaultFrequency = ExportFrequency.manual;
  bool _isLoading = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  @override
  void dispose() {
    _projectIdController.dispose();
    _datasetIdController.dispose();
    _credentialsController.dispose();
    super.dispose();
  }

  Future<void> _loadConfig() async {
    final user = ref.read(currentUserProvider).value;
    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      final config = await ref.read(bigQueryConfigProvider(user.institutionId ?? '').future);
      
      if (config != null && mounted) {
        setState(() {
          _projectIdController.text = config.projectId;
          _datasetIdController.text = config.datasetId;
          _credentialsController.text = config.credentialsJson;
          _isEnabled = config.isEnabled;
          _enabledExports.addAll(config.enabledExports);
          _defaultFrequency = config.defaultFrequency ?? ExportFrequency.manual;
        });
      }
    } catch (e) {
      logger.e('Error loading config', error: e);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveConfig() async {
    if (!_formKey.currentState!.validate()) return;

    final user = ref.read(currentUserProvider).value;
    if (user == null) return;

    setState(() => _isSaving = true);

    try {
      final service = ref.read(bigQueryExportServiceProvider);
      
      final config = BigQueryConfig(
        id: user.institutionId ?? '',
        institutionId: user.institutionId ?? '',
        companyId: user.companyId,
        projectId: _projectIdController.text.trim(),
        datasetId: _datasetIdController.text.trim(),
        credentialsJson: _credentialsController.text.trim(),
        isEnabled: _isEnabled,
        enabledExports: _enabledExports.toList(),
        defaultFrequency: _defaultFrequency,
        createdAt: DateTime.now(),
        createdBy: user.id,
        updatedAt: DateTime.now(),
        updatedBy: user.id,
      );

      final success = await service.saveConfig(config);

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم حفظ الإعدادات بنجاح')),
          );
          // تحديث البيانات
          ref.invalidate(bigQueryConfigProvider(user.institutionId ?? ''));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('فشل حفظ الإعدادات')),
          );
        }
      }
    } catch (e) {
      logger.e('Error saving config', error: e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات BigQuery'),
        actions: [
          if (!_isLoading)
            IconButton(
              icon: _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save),
              onPressed: _isSaving ? null : _saveConfig,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SwitchListTile(
                      title: const Text('تفعيل BigQuery Export'),
                      subtitle: const Text('تصدير البيانات إلى BigQuery'),
                      value: _isEnabled,
                      onChanged: (value) => setState(() => _isEnabled = value),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'معلومات المشروع',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _projectIdController,
                      decoration: const InputDecoration(
                        labelText: 'Project ID *',
                        hintText: 'my-project-id',
                        border: OutlineInputBorder(),
                        helperText: 'معرّف مشروع Google Cloud',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Project ID مطلوب';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _datasetIdController,
                      decoration: const InputDecoration(
                        labelText: 'Dataset ID *',
                        hintText: 'training_data',
                        border: OutlineInputBorder(),
                        helperText: 'معرّف مجموعة البيانات في BigQuery',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Dataset ID مطلوب';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _credentialsController,
                      decoration: const InputDecoration(
                        labelText: 'Service Account JSON *',
                        hintText: '{"type": "service_account", ...}',
                        border: OutlineInputBorder(),
                        helperText: 'بيانات Service Account بصيغة JSON',
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Service Account JSON مطلوب';
                        }
                        // تحقق بسيط من صيغة JSON
                        try {
                          // ignore: unused_local_variable
                          final json = value.trim();
                          if (!json.startsWith('{') || !json.endsWith('}')) {
                            return 'صيغة JSON غير صحيحة';
                          }
                        } catch (e) {
                          return 'صيغة JSON غير صحيحة';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'أنواع البيانات المُفعّلة',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _buildExportTypeCheckbox(
                      ExportType.users,
                      'المستخدمين',
                      'بيانات حسابات المستخدمين',
                    ),
                    _buildExportTypeCheckbox(
                      ExportType.courses,
                      'الدورات',
                      'معلومات الدورات التدريبية',
                    ),
                    _buildExportTypeCheckbox(
                      ExportType.enrollments,
                      'التسجيلات',
                      'تسجيلات المستخدمين في الدورات',
                    ),
                    _buildExportTypeCheckbox(
                      ExportType.quizResults,
                      'نتائج الاختبارات',
                      'نتائج وأداء الاختبارات',
                    ),
                    _buildExportTypeCheckbox(
                      ExportType.certificates,
                      'الشهادات',
                      'الشهادات الصادرة',
                    ),
                    _buildExportTypeCheckbox(
                      ExportType.gamification,
                      'النقاط والإنجازات',
                      'بيانات النقاط والإنجازات',
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'الجدولة الافتراضية',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<ExportFrequency>(
                      value: _defaultFrequency,
                      decoration: const InputDecoration(
                        labelText: 'تكرار التصدير',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: ExportFrequency.manual,
                          child: Text('يدوي'),
                        ),
                        DropdownMenuItem(
                          value: ExportFrequency.daily,
                          child: Text('يومي'),
                        ),
                        DropdownMenuItem(
                          value: ExportFrequency.weekly,
                          child: Text('أسبوعي'),
                        ),
                        DropdownMenuItem(
                          value: ExportFrequency.monthly,
                          child: Text('شهري'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _defaultFrequency = value);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Card(
                      color: Colors.blue.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.info_outline, color: Colors.blue.shade700),
                                const SizedBox(width: 8),
                                Text(
                                  'ملاحظات مهمة',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              '• يجب إنشاء مشروع Google Cloud وتفعيل BigQuery API\n'
                              '• إنشاء Service Account وتنزيل ملف JSON\n'
                              '• منح الصلاحيات المناسبة للـ Service Account\n'
                              '• إنشاء Dataset في BigQuery مسبقاً\n'
                              '• الجداول سيتم إنشاؤها تلقائياً عند التصدير',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildExportTypeCheckbox(
    ExportType type,
    String title,
    String subtitle,
  ) {
    return CheckboxListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: _enabledExports.contains(type),
      onChanged: (value) {
        setState(() {
          if (value == true) {
            _enabledExports.add(type);
          } else {
            _enabledExports.remove(type);
          }
        });
      },
    );
  }
}
