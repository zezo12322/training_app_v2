import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bigquery_export.dart';
import '../providers/bigquery_providers.dart';
import '../providers/user_providers.dart';
import '../core/logging.dart';
import '../core/l10n_ext.dart';

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
            SnackBar(content: Text(context.l.bigquerySettingsSaved)),
          );
          // تحديث البيانات
          ref.invalidate(bigQueryConfigProvider(user.institutionId ?? ''));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l.bigquerySettingsSaveFailed)),
          );
        }
      }
    } catch (e) {
      logger.e('Error saving config', error: e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.bigquerySettingsError(e.toString()))),
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
    final l = context.l;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.bigquerySettingsTitle),
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
                      title: Text(l.bigquerySettingsEnableExport),
                      subtitle: Text(l.bigquerySettingsExportDescription),
                      value: _isEnabled,
                      onChanged: (value) => setState(() => _isEnabled = value),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l.bigquerySettingsProjectInfo,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _projectIdController,
                      decoration: InputDecoration(
                        labelText: 'Project ID *',
                        hintText: 'my-project-id',
                        border: const OutlineInputBorder(),
                        helperText: l.bigquerySettingsProjectIdHelper,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l.bigquerySettingsProjectIdRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _datasetIdController,
                      decoration: InputDecoration(
                        labelText: 'Dataset ID *',
                        hintText: 'training_data',
                        border: const OutlineInputBorder(),
                        helperText: l.bigquerySettingsDatasetIdHelper,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l.bigquerySettingsDatasetIdRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _credentialsController,
                      decoration: InputDecoration(
                        labelText: 'Service Account JSON *',
                        hintText: '{"type": "service_account", ...}',
                        border: const OutlineInputBorder(),
                        helperText: l.bigquerySettingsServiceAccountHelper,
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l.bigquerySettingsServiceAccountRequired;
                        }
                        // تحقق بسيط من صيغة JSON
                        try {
                          // ignore: unused_local_variable
                          final json = value.trim();
                          if (!json.startsWith('{') || !json.endsWith('}')) {
                            return l.bigquerySettingsInvalidJSON;
                          }
                        } catch (e) {
                          return l.bigquerySettingsInvalidJSON;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l.bigquerySettingsEnabledDataTypes,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _buildExportTypeCheckbox(
                      ExportType.users,
                      l.bigquerySettingsUsersTitle,
                      l.bigquerySettingsUsersSubtitle,
                    ),
                    _buildExportTypeCheckbox(
                      ExportType.courses,
                      l.bigquerySettingsCoursesTitle,
                      l.bigquerySettingsCoursesSubtitle,
                    ),
                    _buildExportTypeCheckbox(
                      ExportType.enrollments,
                      l.bigquerySettingsEnrollmentsTitle,
                      l.bigquerySettingsEnrollmentsSubtitle,
                    ),
                    _buildExportTypeCheckbox(
                      ExportType.quizResults,
                      l.bigquerySettingsQuizResultsTitle,
                      l.bigquerySettingsQuizResultsSubtitle,
                    ),
                    _buildExportTypeCheckbox(
                      ExportType.certificates,
                      l.bigquerySettingsCertificatesTitle,
                      l.bigquerySettingsCertificatesSubtitle,
                    ),
                    _buildExportTypeCheckbox(
                      ExportType.gamification,
                      l.bigquerySettingsGamificationTitle,
                      l.bigquerySettingsGamificationSubtitle,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l.bigquerySettingsSchedule,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<ExportFrequency>(
                      initialValue: _defaultFrequency,
                      decoration: InputDecoration(
                        labelText: l.bigquerySettingsSchedule,
                        border: const OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: ExportFrequency.manual,
                          child: Text(l.bigquerySettingsScheduleManual),
                        ),
                        DropdownMenuItem(
                          value: ExportFrequency.daily,
                          child: Text(l.bigquerySettingsScheduleDaily),
                        ),
                        DropdownMenuItem(
                          value: ExportFrequency.weekly,
                          child: Text(l.bigquerySettingsScheduleWeekly),
                        ),
                        DropdownMenuItem(
                          value: ExportFrequency.monthly,
                          child: Text('Monthly'),
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
                                  l.bigquerySettingsImportantNotes,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              l.bigquerySettingsSetupSteps,
                              style: const TextStyle(fontSize: 14),
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
