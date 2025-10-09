import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/models/risk_user_score.dart';

void main() {
  test('RiskUserScore json factors', () {
    final r = RiskUserScore(
      id: 'u1_2025-10-09',
      userId: 'u1',
      date: '2025-10-09',
      score: 0.73,
      level: 'high',
      factors: {'events7d': 3},
    );
    final json = r.toJson();
    expect(json['score'], 0.73);
    final back = RiskUserScore.fromJson({...json, 'id': 'u1_2025-10-09'});
    expect(back.level, 'high');
    expect(back.factors['events7d'], 3);
  });
}
