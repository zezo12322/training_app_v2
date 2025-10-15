import 'package:flutter/material.dart';
import 'l10n/gen/app_localizations.dart';
import 'package:training_app/core/l10n_ext.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/firebase_options.dart';
import 'package:training_app/screens/auth_wrapper.dart'; // <--- استيراد الشاشة الجديدة
import 'package:training_app/core/bootstrap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/config/app_config.dart';
import 'package:training_app/core/logging.dart';
import 'package:training_app/core/timeago_setup.dart';
import 'package:training_app/providers/fcm_providers.dart';
import 'core/theme/app_theme.dart';
import 'providers/settings_providers.dart';
import 'services/preferences_service.dart';

/// Widget يسمح بعمل إعادة تشغيل منطقية للتطبيق (Rebuild شبيه بالـ restart)
/// عن طريق تغيير مفتاح الجذر (Key) وإعادة بناء الشجرة كاملة.
class AppRestart extends StatefulWidget {
  final Widget child;
  const AppRestart({super.key, required this.child});

  static void restartApp(BuildContext context) {
    final _AppRestartState? state = context
        .findAncestorStateOfType<_AppRestartState>();
    state?.restart();
  }

  @override
  State<AppRestart> createState() => _AppRestartState();
}

class _AppRestartState extends State<AppRestart> {
  Key _key = UniqueKey();

  void restart() {
    setState(() {
      _key = UniqueKey(); // تغيير المفتاح يعيد بناء كل الشجرة تحت هذا الويجت
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: _key, child: widget.child);
  }
}

void main() async {
  final start = DateTime.now();
  WidgetsFlutterBinding.ensureInitialized();
  initAppMonitoring();
  setupTimeago(); // تهيئة timeago للعربية
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Log storage backend configuration (R2 vs none)
  logger.i(
    '[Startup] Spaces enabled? ${AppConfig.useSpaces} | presignEndpoint="${AppConfig.spacesPresignEndpoint}"',
  );
  if (!AppConfig.useSpaces || AppConfig.spacesPresignEndpoint.isEmpty) {
    logger.w(
      '[Startup] DigitalOcean Spaces disabled (USE_SPACES=false أو SPACES_PRESIGN_ENDPOINT فارغ). سيتم تجاهل الصوت في التقييمات.',
    );
  }
  // Enable local persistence & reasonable cache (only once).
  try {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  } catch (_) {
    // ignore if already set or platform not supporting.
  }
  // Load persisted settings before runApp
  final prefsService = await PreferencesService.instance();
  ThemeMode initialTheme = ThemeMode.system;
  final rawTheme = prefsService.getString(SettingsKeys.themeMode);
  if (rawTheme != null) {
    initialTheme = ThemeMode.values.firstWhere(
      (m) => m.name == rawTheme,
      orElse: () => ThemeMode.system,
    );
  }
  final notif = prefsService.getBool(SettingsKeys.notifications) ?? true;
  final funAnim = prefsService.getBool(SettingsKeys.funAnimations) ?? true;
  final autoplay = prefsService.getBool(SettingsKeys.autoplayAudio) ?? false;
  // Locale persistence
  Locale? initialLocale;
  final storedLocale = prefsService.getString(SettingsKeys.locale);
  if (storedLocale != null && storedLocale.isNotEmpty) {
    initialLocale = Locale(storedLocale);
  }

  final startupMs = DateTime.now().difference(start).inMilliseconds;
  logger.i('[Startup] Finished init in ${startupMs}ms');
  runApp(
    ProviderScope(
      overrides: [
        themeModeProvider.overrideWith((ref) => initialTheme),
        notificationsEnabledProvider.overrideWith((ref) => notif),
        funAnimationsProvider.overrideWith((ref) => funAnim),
        autoplayAudioProvider.overrideWith((ref) => autoplay),
        appLocaleProvider.overrideWith((ref) => initialLocale),
        prefsWriterProvider.overrideWithValue(
          (key, value) => prefsService.set(key, value),
        ),
      ],
      child: const AppRestart(child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    final locale = ref.watch(appLocaleProvider);
    
    // Initialize FCM on app startup
    ref.listen(fcmInitializationProvider, (previous, next) {
      next.when(
        data: (_) => logger.i('[App] FCM initialized successfully'),
        loading: () => logger.i('[App] Initializing FCM...'),
        error: (error, stack) => logger.e('[App] FCM initialization failed', error: error, stackTrace: stack),
      );
    });
    
    return MaterialApp(
      title: 'Training App',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: mode,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (ctx) => ctx.l.appTitle,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: locale,
      home: const AuthWrapper(),
    );
  }
}
