import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/models/integrity_flag.dart';

void main() {
  test('IntegrityFlag serialization round trip', () {
    final flag = IntegrityFlag(
      id: 'f1',
      userId: 'u1',
      type: 'points_spike',
      severity: 'high',
      details: {'total': 42},
      resolved: false,
    );
    final json = flag.toJson();
    expect(json['type'], 'points_spike');
    final back = IntegrityFlag.fromJson({...json, 'id': 'f1'});
    expect(back.type, flag.type);
    expect(back.severity, 'high');
  });
}
