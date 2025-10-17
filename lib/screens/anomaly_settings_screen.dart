import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/anomaly.dart';
import '../providers/anomaly_providers.dart';
import '../providers/user_providers.dart';
import '../core/logging.dart';
import '../core/l10n_ext.dart';

/// شاشة إعدادات الكشف عن الشذوذ
class AnomalySettingsScreen extends ConsumerStatefulWidget {
  const AnomalySettingsScreen({super.key});

  @override
  ConsumerState<AnomalySettingsScreen> createState() => _AnomalySettingsScreenState();
}

class _AnomalySettingsScreenState extends ConsumerState<AnomalySettingsScreen> {
  bool _isEnabled = false;
  final Set<AnomalyType> _enabledTypes = {};
  double _sensitivityLevel = 0.7;
  bool _sendAlerts = false;
  bool _autoSuspendCritical = false;
  bool _autoFlagCheating = false;
  AnomalySeverity _minAlertSeverity = AnomalySeverity.medium;
  
  bool _isLoading = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final user = ref.read(currentUserProvider).value;
    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      final settings = await ref.read(anomalySettingsProvider(user.institutionId ?? '').future);
      
      if (settings != null && mounted) {
        setState(() {
          _isEnabled = settings.isEnabled;
          _enabledTypes.addAll(settings.enabledTypes);
          _sensitivityLevel = settings.sensitivityLevel;
          _sendAlerts = settings.sendAlerts;
          _autoSuspendCritical = settings.autoSuspendCritical;
          _autoFlagCheating = settings.autoFlagCheating;
          _minAlertSeverity = settings.minAlertSeverity;
        });
      }
    } catch (e) {
      logger.e('Error loading settings', error: e);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveSettings() async {
    final user = ref.read(currentUserProvider).value;
    if (user == null) return;

    setState(() => _isSaving = true);

    try {
      final service = ref.read(anomalyDetectionServiceProvider);
      
      final settings = AnomalyDetectionSettings(
        id: user.institutionId ?? '',
        institutionId: user.institutionId ?? '',
        companyId: user.companyId,
        isEnabled: _isEnabled,
        enabledTypes: _enabledTypes.toList(),
        sensitivityLevel: _sensitivityLevel,
        sendAlerts: _sendAlerts,
        minAlertSeverity: _minAlertSeverity,
        autoSuspendCritical: _autoSuspendCritical,
        autoFlagCheating: _autoFlagCheating,
        updatedAt: DateTime.now(),
        updatedBy: user.id,
      );

      final success = await service.saveSettings(settings);

      if (mounted) {
        final l = context.l;
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.anomalySettingsSaveSuccess)),
          );
          ref.invalidate(anomalySettingsProvider(user.institutionId ?? ''));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.anomalySettingsSaveFailed)),
          );
        }
      }
    } catch (e) {
      logger.e('Error saving settings', error: e);
      if (mounted) {
        final l = context.l;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.anomalySettingsSaveError(e.toString()))),
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
        title: Text(l.anomalySettingsTitle),
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
              onPressed: _isSaving ? null : _saveSettings,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SwitchListTile(
                    title: Text(l.anomalySettingsEnableDetection),
                    subtitle: Text(l.anomalySettingsEnableDetectionSubtitle),
                    value: _isEnabled,
                    onChanged: (value) => setState(() => _isEnabled = value),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l.anomalySettingsEnabledTypes,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildTypeCheckbox(
                    AnomalyType.suspiciousLogin,
                    l.anomalySettingsSuspiciousLogin,
                    l.anomalySettingsSuspiciousLoginDesc,
                  ),
                  _buildTypeCheckbox(
                    AnomalyType.unusualQuizScore,
                    l.anomalySettingsAbnormalScores,
                    l.anomalySettingsAbnormalScoresDesc,
                  ),
                  _buildTypeCheckbox(
                    AnomalyType.rapidProgress,
                    l.anomalySettingsRapidProgress,
                    l.anomalySettingsRapidProgressDesc,
                  ),
                  _buildTypeCheckbox(
                    AnomalyType.multipleDevices,
                    l.anomalySettingsMultipleDevices,
                    l.anomalySettingsMultipleDevicesDesc,
                  ),
                  _buildTypeCheckbox(
                    AnomalyType.unusualActivity,
                    l.anomalySettingsUnusualActivity,
                    l.anomalySettingsUnusualActivityDesc,
                  ),
                  _buildTypeCheckbox(
                    AnomalyType.cheatingPattern,
                    l.anomalySettingsCheatingPattern,
                    l.anomalySettingsCheatingPatternDesc,
                  ),
                  _buildTypeCheckbox(
                    AnomalyType.accountSharing,
                    l.anomalySettingsAccountSharing,
                    l.anomalySettingsAccountSharingDesc,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l.anomalySettingsSensitivity,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(l.anomalySettingsSensitivityLow),
                      Expanded(
                        child: Slider(
                          value: _sensitivityLevel,
                          min: 0.3,
                          max: 0.95,
                          divisions: 13,
                          label: '${(_sensitivityLevel * 100).toStringAsFixed(0)}%',
                          onChanged: (value) {
                            setState(() => _sensitivityLevel = value);
                          },
                        ),
                      ),
                      Text(l.anomalySettingsSensitivityHigh),
                    ],
                  ),
                  Text(
                    l.anomalySettingsSensitivityCurrent((_sensitivityLevel * 100).toStringAsFixed(0)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l.anomalySettingsAlerts,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: Text(l.anomalySettingsSendAlerts),
                    subtitle: Text(l.anomalySettingsSendAlertsSubtitle),
                    value: _sendAlerts,
                    onChanged: (value) => setState(() => _sendAlerts = value),
                  ),
                  if (_sendAlerts) ...[
                    const SizedBox(height: 12),
                    DropdownButtonFormField<AnomalySeverity>(
                      initialValue: _minAlertSeverity,
                      decoration: InputDecoration(
                        labelText: l.anomalySettingsMinimumSeverity,
                        border: const OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: AnomalySeverity.low,
                          child: Text(l.anomalySettingsSeverityLow),
                        ),
                        DropdownMenuItem(
                          value: AnomalySeverity.medium,
                          child: Text(l.anomalySettingsSeverityMedium),
                        ),
                        DropdownMenuItem(
                          value: AnomalySeverity.high,
                          child: Text(l.anomalySettingsSeverityHigh),
                        ),
                        DropdownMenuItem(
                          value: AnomalySeverity.critical,
                          child: Text(l.anomalySettingsSeverityCritical),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _minAlertSeverity = value);
                        }
                      },
                    ),
                  ],
                  const SizedBox(height: 20),
                  Text(
                    l.anomalySettingsAutomatedActions,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: Text(l.anomalySettingsSuspendCritical),
                    subtitle: Text(l.anomalySettingsSuspendCriticalSubtitle),
                    value: _autoSuspendCritical,
                    onChanged: (value) => setState(() => _autoSuspendCritical = value),
                  ),
                  SwitchListTile(
                    title: Text(l.anomalySettingsFlagCheating),
                    subtitle: Text(l.anomalySettingsFlagCheatingSubtitle),
                    value: _autoFlagCheating,
                    onChanged: (value) => setState(() => _autoFlagCheating = value),
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
                                l.anomalySettingsImportantNotes,
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
                            '${l.anomalySettingsNote1}\n'
                            '${l.anomalySettingsNote2}\n'
                            '${l.anomalySettingsNote3}\n'
                            '${l.anomalySettingsNote4}\n'
                            '${l.anomalySettingsNote5}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTypeCheckbox(
    AnomalyType type,
    String title,
    String subtitle,
  ) {
    return CheckboxListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: _enabledTypes.contains(type),
      onChanged: (value) {
        setState(() {
          if (value == true) {
            _enabledTypes.add(type);
          } else {
            _enabledTypes.remove(type);
          }
        });
      },
    );
  }
}
