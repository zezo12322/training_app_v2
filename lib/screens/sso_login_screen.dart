import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io' show Platform;
import '../models/sso_provider.dart';
import '../services/sso_service.dart';

/// مزود خدمة SSO
final ssoServiceProvider = Provider<SSOService>((ref) {
  return SSOService();
});

/// شاشة تسجيل الدخول بـ SSO
class SSOLoginScreen extends ConsumerStatefulWidget {
  final String? institutionId;
  final String? companyId;
  final VoidCallback? onLoginSuccess;

  const SSOLoginScreen({
    super.key,
    this.institutionId,
    this.companyId,
    this.onLoginSuccess,
  });

  @override
  ConsumerState<SSOLoginScreen> createState() => _SSOLoginScreenState();
}

class _SSOLoginScreenState extends ConsumerState<SSOLoginScreen> {
  bool _isLoading = false;

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);

    try {
      final service = ref.read(ssoServiceProvider);
      final result = await service.signInWithGoogle(
        institutionId: widget.institutionId,
        companyId: widget.companyId,
      );

      if (!mounted) return;

      if (result.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('مرحباً ${result.displayName ?? result.email}!'),
            backgroundColor: Colors.green,
          ),
        );
        widget.onLoginSuccess?.call();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.errorMessage ?? 'فشل تسجيل الدخول'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signInWithApple() async {
    setState(() => _isLoading = true);

    try {
      final service = ref.read(ssoServiceProvider);
      final result = await service.signInWithApple(
        institutionId: widget.institutionId,
        companyId: widget.companyId,
      );

      if (!mounted) return;

      if (result.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('مرحباً ${result.displayName ?? result.email}!'),
            backgroundColor: Colors.green,
          ),
        );
        widget.onLoginSuccess?.call();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.errorMessage ?? 'فشل تسجيل الدخول'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // الشعار
              Icon(
                Icons.school,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 24),
              
              const Text(
                'مرحباً بك',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              const Text(
                'اختر طريقة تسجيل الدخول',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              
              const SizedBox(height: 48),
              
              // زر Google Sign-In
              _SSOButton(
                onPressed: _isLoading ? null : _signInWithGoogle,
                icon: Icons.g_mobiledata,
                label: 'تسجيل الدخول بـ Google',
                backgroundColor: Colors.white,
                textColor: Colors.black87,
                borderColor: Colors.grey[300],
              ),
              
              const SizedBox(height: 16),
              
              // زر Apple Sign-In (iOS/macOS فقط)
              if (Platform.isIOS || Platform.isMacOS)
                _SSOButton(
                  onPressed: _isLoading ? null : _signInWithApple,
                  icon: Icons.apple,
                  label: 'تسجيل الدخول بـ Apple',
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                ),
              
              const SizedBox(height: 32),
              
              // مؤشر التحميل
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              
              const SizedBox(height: 16),
              
              // نص الشروط
              Text(
                'بتسجيل الدخول، أنت توافق على شروط الاستخدام وسياسة الخصوصية',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// زر SSO مخصص
class _SSOButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  const _SSOButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 24),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: borderColor != null
              ? BorderSide(color: borderColor!)
              : BorderSide.none,
        ),
        elevation: 2,
      ),
    );
  }
}

/// شاشة إعدادات SSO (للمسؤولين)
class SSOSettingsScreen extends ConsumerStatefulWidget {
  final String institutionId;

  const SSOSettingsScreen({
    super.key,
    required this.institutionId,
  });

  @override
  ConsumerState<SSOSettingsScreen> createState() => _SSOSettingsScreenState();
}

class _SSOSettingsScreenState extends ConsumerState<SSOSettingsScreen> {
  bool _isLoading = true;
  SSOSettings? _settings;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() => _isLoading = true);
    
    final service = ref.read(ssoServiceProvider);
    final settings = await service.getSSOSettings(widget.institutionId);
    
    if (mounted) {
      setState(() {
        _settings = settings;
        _isLoading = false;
      });
    }
  }

  Future<void> _saveSettings() async {
    if (_settings == null) return;

    final service = ref.read(ssoServiceProvider);
    final success = await service.saveSSOSettings(_settings!);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? 'تم حفظ الإعدادات' : 'فشل حفظ الإعدادات'),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات SSO'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
            tooltip: 'حفظ',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'مزودات تسجيل الدخول',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // Google
          SwitchListTile(
            title: const Text('Google Sign-In'),
            subtitle: const Text('السماح بتسجيل الدخول عبر Google'),
            value: _settings?.googleEnabled ?? false,
            onChanged: (value) {
              setState(() {
                _settings = _settings?.copyWith(googleEnabled: value);
              });
            },
          ),
          
          // Apple
          SwitchListTile(
            title: const Text('Apple Sign-In'),
            subtitle: const Text('السماح بتسجيل الدخول عبر Apple'),
            value: _settings?.appleEnabled ?? false,
            onChanged: (value) {
              setState(() {
                _settings = _settings?.copyWith(appleEnabled: value);
              });
            },
          ),
          
          const Divider(height: 32),
          
          const Text(
            'إعدادات إضافية',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // إنشاء حساب تلقائي
          SwitchListTile(
            title: const Text('إنشاء حساب تلقائي'),
            subtitle: const Text('إنشاء حساب جديد عند أول تسجيل دخول'),
            value: _settings?.autoCreateAccount ?? true,
            onChanged: (value) {
              setState(() {
                _settings = _settings?.copyWith(autoCreateAccount: value);
              });
            },
          ),
          
          const SizedBox(height: 16),
          
          // الدور الافتراضي
          ListTile(
            title: const Text('الدور الافتراضي'),
            subtitle: Text(_settings?.defaultRole ?? 'trainee'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: فتح قائمة الأدوار
            },
          ),
        ],
      ),
    );
  }
}
