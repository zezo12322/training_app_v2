import 'package:timeago/timeago.dart' as timeago;

/// تهيئة timeago للعربية
void setupTimeago() {
  timeago.setLocaleMessages('ar', timeago.ArMessages());
}
