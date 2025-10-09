import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/providers/gamification_providers.dart';

void main() {
  group('computeLevel', () {
    test('level 1 at 0 points', () {
      expect(computeLevel(0), 1);
      expect(computeLevel(-10), 1);
    });
    test('progresses with quadratic scaling', () {
      // Points = 50*(n-1)^2 boundaries:
      // level 1: 0..49
      // level 2: 50..199
      // level 3: 200..449
      expect(computeLevel(1), 1);
      expect(computeLevel(49), 1);
      expect(computeLevel(50), 2);
      expect(computeLevel(199), 2);
      expect(computeLevel(200), 3);
    });
  });

  group('computeLevelProgress', () {
    test('level 1 early', () {
      final lp = computeLevelProgress(0);
      expect(lp.level, 1);
      expect(lp.baseLevelPoints, 0);
      expect(lp.nextLevelPoints, 50);
      expect(lp.percent, 0);
    });

    test('mid level 2', () {
      final lp = computeLevelProgress(120); // inside level 2 range 50..199
      expect(lp.level, 2);
      expect(lp.baseLevelPoints, 50);
      expect(lp.nextLevelPoints, 200);
      // 120 - 50 = 70 of span 150 => 70/150 ≈ 0.4666
      expect((lp.percent * 1000).round(), (70 / 150 * 1000).round());
    });

    test('start of level 3', () {
      final lp = computeLevelProgress(200);
      expect(lp.level, 3);
      expect(lp.baseLevelPoints, 200);
      expect(lp.percent, 0);
    });
  });
}
