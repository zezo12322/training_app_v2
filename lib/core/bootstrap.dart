import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:training_app/core/logging.dart';

/// Enable/disable perf logs at compile time: --dart-define=PERF_LOGS=true
const bool kEnablePerfLogs = bool.fromEnvironment(
  'PERF_LOGS',
  defaultValue: true,
);

/// Thresholds (ms) for warning.
const int kBuildWarnMs = 16; // >16ms jank risk (1 frame @60fps)
const int kRasterWarnMs = 16;
const int kSevereMs = 48; // >3 frames

bool _frameTimingsAttached = false;

void initAppMonitoring({bool attachFrameTimings = true}) {
  if (kEnablePerfLogs && attachFrameTimings && !_frameTimingsAttached) {
    _frameTimingsAttached = true;
    SchedulerBinding.instance.addTimingsCallback(_onFrameTimings);
  }

  // Capture Flutter framework errors.
  FlutterError.onError = (details) {
    logger.e(
      'FlutterError: ${details.exceptionAsString()}',
      error: details.exception,
      stackTrace: details.stack,
    );
    FlutterError.presentError(
      details,
    ); // keep default behavior (red screen in debug)
  };

  // Capture all zone uncaught errors.
  runZonedGuarded(() {}, (error, stack) {
    logger.e('Uncaught zone error', error: error, stackTrace: stack);
  });

  // VM / Platform dispatcher errors (Dart >= 3).
  PlatformDispatcher.instance.onError = (error, stack) {
    logger.e('PlatformDispatcher error', error: error, stackTrace: stack);
    return true; // mark handled
  };
}

void _onFrameTimings(List<FrameTiming> timings) {
  for (final t in timings) {
    final buildMs = t.buildDuration.inMilliseconds;
    final rasterMs = t.rasterDuration.inMilliseconds;
    if (buildMs < kBuildWarnMs && rasterMs < kRasterWarnMs) continue;
    final severity = (buildMs > kSevereMs || rasterMs > kSevereMs)
        ? 'SEVERE'
        : 'WARN';
    logger.i('[FRAME][$severity] build=${buildMs}ms raster=${rasterMs}ms');
  }
}

/// Utility to measure async operations (e.g., Firestore get) and log if slow.
Future<T> traceAsync<T>(
  String label,
  Future<T> Function() op, {
  int warnMs = 120,
}) async {
  final sw = Stopwatch()..start();
  try {
    final result = await op();
    return result;
  } finally {
    sw.stop();
    final elapsed = sw.elapsedMilliseconds;
    if (elapsed > warnMs) {
      logger.i('[TRACE] $label took ${elapsed}ms');
    }
  }
}

/// Inline sync tracing.
T trace<T>(String label, T Function() op, {int warnMs = 8}) {
  final sw = Stopwatch()..start();
  try {
    return op();
  } finally {
    sw.stop();
    final e = sw.elapsedMilliseconds;
    if (e > warnMs) logger.i('[TRACE] sync $label ${e}ms');
  }
}
