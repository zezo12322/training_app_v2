import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Persistent keys
const _kThemeModeKey = 'app_theme_mode';
const _kNotificationsKey = 'app_notifications_enabled';
const _kFunAnimationsKey = 'app_fun_animations';
const _kAutoplayAudioKey = 'app_autoplay_audio';
const _kLocaleKey = 'app_locale_code';

// Core providers (backed by SharedPreferences at startup override)
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
final notificationsEnabledProvider = StateProvider<bool>((ref) => true);
final funAnimationsProvider = StateProvider<bool>((ref) => true);
final autoplayAudioProvider = StateProvider<bool>((ref) => false);
// null => follow system. Otherwise Locale(languageCode)
final appLocaleProvider = StateProvider<Locale?>((ref) => null);

// Helper for saving preferences (late-initialized in main)
typedef PrefsWriteFn = Future<void> Function(String key, Object value);
final _prefsWriterProvider = Provider<PrefsWriteFn>(
  (ref) => (k, v) async {},
); // no-op default, overridden in main
// internal provider getter for main override
Provider<PrefsWriteFn> get prefsWriterProvider => _prefsWriterProvider;

Future<void> saveThemeMode(WidgetRef ref, ThemeMode mode) async {
  ref.read(themeModeProvider.notifier).state = mode;
  final write = ref.read(_prefsWriterProvider);
  await write(_kThemeModeKey, mode.name);
}

Future<void> toggleNotifications(WidgetRef ref, bool value) async {
  ref.read(notificationsEnabledProvider.notifier).state = value;
  final write = ref.read(_prefsWriterProvider);
  await write(_kNotificationsKey, value);
}

Future<void> toggleFunAnimations(WidgetRef ref, bool value) async {
  ref.read(funAnimationsProvider.notifier).state = value;
  final write = ref.read(_prefsWriterProvider);
  await write(_kFunAnimationsKey, value);
}

Future<void> toggleAutoplayAudio(WidgetRef ref, bool value) async {
  ref.read(autoplayAudioProvider.notifier).state = value;
  final write = ref.read(_prefsWriterProvider);
  await write(_kAutoplayAudioKey, value);
}

Future<void> setAppLocale(WidgetRef ref, Locale? locale) async {
  ref.read(appLocaleProvider.notifier).state = locale;
  final write = ref.read(_prefsWriterProvider);
  if (locale == null) {
    await write(_kLocaleKey, '');
  } else {
    await write(_kLocaleKey, locale.languageCode);
  }
}

// Expose keys for main init logic
class SettingsKeys {
  static const themeMode = _kThemeModeKey;
  static const notifications = _kNotificationsKey;
  static const funAnimations = _kFunAnimationsKey;
  static const autoplayAudio = _kAutoplayAudioKey;
  static const locale = _kLocaleKey;
}
