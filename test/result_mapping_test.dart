import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/core/result.dart';

void main() {
  test('guard wraps success', () async {
    final r = await guard(() async => 42);
    expect(r.isSuccess, true);
    expect(r.dataOrNull, 42);
  });

  test('guard maps generic error to unknown failure', () async {
    final r = await guard<int>(() async {
      throw Exception('boom');
    });
    expect(r.isFailure, true);
    expect(
      r.failureOrNull!.maybeMap(unknown: (_) => true, orElse: () => false),
      true,
    );
  });
}
