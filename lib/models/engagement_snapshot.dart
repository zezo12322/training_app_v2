import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/timestamp_converter.dart';

part 'engagement_snapshot.freezed.dart';
part 'engagement_snapshot.g.dart';

@freezed
class EngagementSnapshot with _$EngagementSnapshot {
  const EngagementSnapshot._();
  const factory EngagementSnapshot({
    required String id, // composite userId_YYYYMMDD
    required String userId,
    required String date, // YYYY-MM-DD
    @Default(0) int events7d,
    @TimestampConverter() DateTime? lastActiveTs,
    @Default(0) int streak,
    // Optional mastery delta placeholder for future skill stats
    @Default(0) double masteryDelta14d,
    @TimestampConverter() DateTime? createdAt,
  }) = _EngagementSnapshot;

  factory EngagementSnapshot.fromJson(Map<String, dynamic> json) =>
      _$EngagementSnapshotFromJson(json);

  factory EngagementSnapshot.fromDoc(DocumentSnapshot<Map<String, dynamic>> d) {
    final data = d.data() ?? {};
    return EngagementSnapshot.fromJson({'id': d.id, ...data});
  }
}
