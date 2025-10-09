import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/core/timestamp_converter.dart';

void main() {
  const conv = TimestampConverter();
  test('TimestampConverter fromJson handles Timestamp & DateTime', () {
    final ts = Timestamp.fromDate(DateTime.utc(2024, 1, 1));
    final dt = conv.fromJson(ts)!;
    expect(dt.year, 2024);
    final again = conv.fromJson(dt)!;
    expect(again.year, 2024);
  });

  test('TimestampConverter toJson returns Timestamp', () {
    final now = DateTime.now();
    final json = conv.toJson(now);
    expect(json, isA<Timestamp>());
  });
}
