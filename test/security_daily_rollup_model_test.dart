import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/models/security_daily_rollup.dart';

void main() {
  test('SecurityDailyRollup defaults and json', () {
    final r = SecurityDailyRollup(id: '2025-10-09', date: '2025-10-09');
    expect(r.totalEvents, 0);
    final json = r.toJson();
    expect(json['totalEvents'], 0);
    final back = SecurityDailyRollup.fromJson({...json, 'id': '2025-10-09'});
    expect(back.date, '2025-10-09');
  });
}
