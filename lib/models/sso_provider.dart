import 'package:freezed_annotation/freezed_annotation.dart';

part 'sso_provider.freezed.dart';
part 'sso_provider.g.dart';

/// نوع مزود SSO
enum SSOProviderType {
  google,
  apple,
  microsoft,
  facebook,
}

/// معلومات مزود SSO
@freezed
class SSOProvider with _$SSOProvider {
  const factory SSOProvider({
    required String id,
    required SSOProviderType type,
    required String name,
    required String displayName,
    required bool isEnabled,
    
    /// معلومات التكوين
    String? clientId,
    String? clientSecret,
    String? redirectUri,
    
    /// معلومات المستخدم من المزود
    String? providerId,
    String? providerEmail,
    String? providerName,
    String? providerPhotoUrl,
    
    /// Tenant
    String? institutionId,
    String? companyId,
  }) = _SSOProvider;

  factory SSOProvider.fromJson(Map<String, dynamic> json) =>
      _$SSOProviderFromJson(json);
}

/// نتيجة تسجيل الدخول بـ SSO
@freezed
class SSOLoginResult with _$SSOLoginResult {
  const factory SSOLoginResult({
    required bool success,
    required SSOProviderType provider,
    
    /// معلومات المستخدم
    String? userId,
    String? email,
    String? displayName,
    String? photoUrl,
    String? idToken,
    String? accessToken,
    
    /// رسالة الخطأ
    String? errorMessage,
  }) = _SSOLoginResult;

  factory SSOLoginResult.fromJson(Map<String, dynamic> json) =>
      _$SSOLoginResultFromJson(json);
}

/// إعدادات SSO للمؤسسة
@freezed
class SSOSettings with _$SSOSettings {
  const factory SSOSettings({
    required String institutionId,
    
    /// المزودات المفعلة
    @Default(false) bool googleEnabled,
    @Default(false) bool appleEnabled,
    @Default(false) bool microsoftEnabled,
    
    /// إعدادات Google
    String? googleClientId,
    String? googleClientSecret,
    
    /// إعدادات Apple
    String? appleClientId,
    String? appleTeamId,
    
    /// إعدادات Microsoft
    String? microsoftTenantId,
    String? microsoftClientId,
    
    /// إنشاء حساب تلقائي عند أول تسجيل دخول
    @Default(true) bool autoCreateAccount,
    
    /// المجالات المسموح بها (للبريد الإلكتروني)
    @Default([]) List<String> allowedDomains,
    
    /// الدور الافتراضي للمستخدمين الجدد
    @Default('trainee') String defaultRole,
  }) = _SSOSettings;

  factory SSOSettings.fromJson(Map<String, dynamic> json) =>
      _$SSOSettingsFromJson(json);
}
