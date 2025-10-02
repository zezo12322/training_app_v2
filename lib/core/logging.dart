import 'package:logger/logger.dart';

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
