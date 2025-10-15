import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/anomaly.dart';
import '../providers/anomaly_providers.dart';
import '../providers/user_providers.dart';
import '../core/logging.dart';

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
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم حفظ الإعدادات بنجاح')),
          );
          ref.invalidate(anomalySettingsProvider(user.institutionId ?? ''));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('فشل حفظ الإعدادات')),
          );
        }
      }
    } catch (e) {
      logger.e('Error saving settings', error: e);
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
        title: const Text('إعدادات الكشف عن الشذوذ'),
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
                    title: const Text('تفعيل الكشف عن الشذوذ'),
                    subtitle: const Text('اكتشاف السلوك غير الطبيعي تلقائياً'),
                    value: _isEnabled,
                    onChanged: (value) => setState(() => _isEnabled = value),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'أنواع الشذوذ المُفعّلة',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildTypeCheckbox(
                    AnomalyType.suspiciousLogin,
                    'تسجيل دخول مشبوه',
                    'أجهزة أو مواقع غير معتادة',
                  ),
                  _buildTypeCheckbox(
                    AnomalyType.unusualQuizScore,
                    'درجات اختبار غير طبيعية',
                    'درجات عالية جداً أو منخفضة جداً',
                  ),
                  _buildTypeCheckbox(
                    AnomalyType.rapidProgress,
                    'تقدم سريع',
                    'إكمال دورات أو اختبارات بسرعة غير طبيعية',
                  ),
                  _buildTypeCheckbox(
                    AnomalyType.multipleDevices,
                    'أجهزة متعددة',
                    'استخدام عدة أجهزة في وقت قصير',
                  ),
                  _buildTypeCheckbox(
                    AnomalyType.unusualActivity,
                    'نشاط غير معتاد',
                    'نشاط مفرط أو غير نمطي',
                  ),
                  _buildTypeCheckbox(
                    AnomalyType.cheatingPattern,
                    'نمط غش',
                    'أنماط تشير إلى محاولة غش',
                  ),
                  _buildTypeCheckbox(
                    AnomalyType.accountSharing,
                    'مشاركة حساب',
                    'استخدام الحساب من قبل أشخاص مختلفين',
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'الحساسية',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text('منخفضة'),
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
                      const Text('عالية'),
                    ],
                  ),
                  Text(
                    'الحساسية الحالية: ${(_sensitivityLevel * 100).toStringAsFixed(0)}%',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'التنبيهات',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('إرسال تنبيهات'),
                    subtitle: const Text('إخطار المسؤولين عند اكتشاف شذوذ'),
                    value: _sendAlerts,
                    onChanged: (value) => setState(() => _sendAlerts = value),
                  ),
                  if (_sendAlerts) ...[
                    const SizedBox(height: 12),
                    DropdownButtonFormField<AnomalySeverity>(
                      value: _minAlertSeverity,
                      decoration: const InputDecoration(
                        labelText: 'الحد الأدنى للتنبيه',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: AnomalySeverity.low,
                          child: Text('منخفض'),
                        ),
                        DropdownMenuItem(
                          value: AnomalySeverity.medium,
                          child: Text('متوسط'),
                        ),
                        DropdownMenuItem(
                          value: AnomalySeverity.high,
                          child: Text('عالي'),
                        ),
                        DropdownMenuItem(
                          value: AnomalySeverity.critical,
                          child: Text('حرج'),
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
                  const Text(
                    'الإجراءات التلقائية',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('تعليق الحسابات الحرجة'),
                    subtitle: const Text('تعليق تلقائي للحسابات ذات الشذوذ الحرج'),
                    value: _autoSuspendCritical,
                    onChanged: (value) => setState(() => _autoSuspendCritical = value),
                  ),
                  SwitchListTile(
                    title: const Text('وضع علامة على الغش'),
                    subtitle: const Text('وضع علامة تلقائية على محاولات الغش'),
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
                            '• الكشف يعمل باستخدام خوارزميات إحصائية متقدمة\n'
                            '• قد تحدث إيجابيات خاطئة - راجع دائماً قبل اتخاذ إجراء\n'
                            '• يتحسن الكشف مع مرور الوقت وتجميع البيانات\n'
                            '• الحساسية العالية = المزيد من الاكتشافات (بما في ذلك الخاطئة)\n'
                            '• يوصى بمراجعة دورية للإعدادات والنتائج',
                            style: TextStyle(fontSize: 14),
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
