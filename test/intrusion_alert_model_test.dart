import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/models/intrusion_alert.dart';

void main() {
  test('IntrusionAlert severity + copyWith', () {
    final a = IntrusionAlert(
      id: 'd_priv',
      vector: 'PRIV_ESC',
      category: 'auth',
    );
    final b = a.copyWith(severity: 'high');
    expect(b.severity, 'high');
    expect(a.severity, isNot('high'));
  });
}
