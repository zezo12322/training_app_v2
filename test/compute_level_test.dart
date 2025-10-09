import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/providers/gamification_providers.dart';

void main() {
  group('computeLevel', () {
    test('level 1 at 0 points', () {
      expect(computeLevel(0), 1);
    });
    test('still level 1 below 50', () {
      expect(computeLevel(49), 1);
    });
    test('level 2 at 50 points', () {
      expect(computeLevel(50), 2);
    });
    test('level 2 until <200', () {
      expect(computeLevel(199), 2);
    });
    test('level 3 at 200', () {
      expect(computeLevel(200), 3);
    });
  });
}
