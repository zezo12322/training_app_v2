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
  
  // ⚡ العمليات الحرجة فقط - باقي الحاجات تتأجل
  initAppMonitoring();
  setupTimeago(); // خفيفة - ممكن تفضل
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // ⚡ Firestore settings - Critical for performance
  try {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  } catch (_) {
    // ignore if already set or platform not supporting.
  }

  final startupMs = DateTime.now().difference(start).inMilliseconds;
  logger.i('[Startup] Finished critical init in ${startupMs}ms');
  
  // ⚡ تحميل الإعدادات بشكل async بعد بدء التطبيق
  runApp(
    ProviderScope(
      child: const AppRestart(child: MyApp()),
    ),
  );
  
  // 🔥 تأجيل العمليات الثقيلة لبعد رسم أول frame
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    // Log storage backend configuration (non-critical)
    logger.i(
      '[Startup] Spaces enabled? ${AppConfig.useSpaces} | presignEndpoint="${AppConfig.spacesPresignEndpoint}"',
    );
    if (!AppConfig.useSpaces || AppConfig.spacesPresignEndpoint.isEmpty) {
      logger.w(
        '[Startup] DigitalOcean Spaces disabled (USE_SPACES=false أو SPACES_PRESIGN_ENDPOINT فارغ). سيتم تجاهل الصوت في التقييمات.',
      );
    }
  });
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // 🔥 تأجيل FCM initialization لبعد بناء أول frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initialize FCM lazily
      ref.read(fcmInitializationProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(themeModeProvider);
    final locale = ref.watch(appLocaleProvider);
    
    // Listen to FCM initialization status (non-blocking)
    ref.listen(fcmInitializationProvider, (previous, next) {
      next.whenOrNull(
        data: (_) => logger.i('[App] FCM initialized successfully'),
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
