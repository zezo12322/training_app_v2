import 'dart:math';
import 'package:logger/logger.dart';

/// Lightweight correlation ID generator (base32-ish) for client -> CF callables.
String generateCorrelationId({int length = 20}) {
  const chars = '23456789ABCDEFGHJKMNPQRSTUVWXYZ';
  final rnd = Random.secure();
  return List.generate(length, (_) => chars[rnd.nextInt(chars.length)]).join();
}

/// Wrap a future-producing operation with a correlation ID.
Future<T> withCorrelation<T>(
  Future<T> Function(String corrId) op, {
  String? corrId,
}) {
  final id = corrId ?? generateCorrelationId();
  logger.t('corrId=$id start');
  final started = DateTime.now();
  return op(id)
      .then((value) {
        final dur = DateTime.now().difference(started).inMilliseconds;
        logger.t('corrId=$id success ${dur}ms');
        return value;
      })
      .catchError((e, st) {
        final dur = DateTime.now().difference(started).inMilliseconds;
        logger.e('corrId=$id error ${dur}ms -> $e');
        throw e;
      });
}

final Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 90,
    colors: true,
    printEmojis: true,
    // printTime deprecated: using dateTimeFormat instead (keeps similar output)
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);
