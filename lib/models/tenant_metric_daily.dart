import 'package:cloud_firestore/cloud_firestore.dart';

class TenantMetricDaily {
  final String id;
  final String tenantType; // 'institution' | 'company'
  final String tenantId;
  final String date; // YYYY-MM-DD
  final int activeUsers;
  final int events;
  final double avgEventsPerUser7d;
  final double avgMastery;
  final double? avgMasteryDelta14d;
  final DateTime? createdAt;

  TenantMetricDaily({
    required this.id,
    required this.tenantType,
    required this.tenantId,
    required this.date,
    required this.activeUsers,
    required this.events,
    required this.avgEventsPerUser7d,
    required this.avgMastery,
    this.avgMasteryDelta14d,
    this.createdAt,
  });

  factory TenantMetricDaily.fromDoc(DocumentSnapshot<Map<String, dynamic>> d) {
    final m = d.data() ?? {};
    return TenantMetricDaily(
      id: d.id,
      tenantType: (m['tenantType'] ?? '').toString(),
      tenantId: (m['tenantId'] ?? '').toString(),
      date: (m['date'] ?? '').toString(),
      activeUsers: (m['activeUsers'] ?? 0) is int
          ? m['activeUsers'] as int
          : int.tryParse('${m['activeUsers']}') ?? 0,
      events: (m['events'] ?? 0) is int
          ? m['events'] as int
          : int.tryParse('${m['events']}') ?? 0,
      avgEventsPerUser7d: (m['avgEventsPerUser7d'] ?? 0.0).toDouble(),
      avgMastery: (m['avgMastery'] ?? 0.0).toDouble(),
      avgMasteryDelta14d: m['avgMasteryDelta14d'] == null
          ? null
          : (m['avgMasteryDelta14d'] as num).toDouble(),
      createdAt: (m['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
