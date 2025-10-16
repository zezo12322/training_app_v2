import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/tenant_metrics_providers.dart';
import '../widgets/sparkline.dart';
import 'package:training_app/core/l10n_ext.dart';
import '../providers/auth_provider.dart';
import 'bottom_nav_shell.dart';
import '../core/roles.dart';

class CompanyAdminDashboard extends ConsumerWidget {
  final String companyId;
  final int days;
  const CompanyAdminDashboard({
    super.key,
    required this.companyId,
    this.days = 14,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(
      companyTenantMetricsProvider((tenantId: companyId, days: days)),
    );
    final scaffold = Scaffold(
      appBar: AppBar(
        title: Text(context.companyAdminDashboardTitle),
        actions: [
          IconButton(
            tooltip: context.l.companyAdminHome,
            icon: const Icon(Icons.home_outlined),
            onPressed: () async {
              final appUser = await ref.read(currentUserModelProvider.future);
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => BottomNavShell(role: appUser?.role ?? 'trainee'),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(context.l.companyAdminError.replaceAll('{error}', e.toString()))),
        data: (list) {
          final dataAsc = list.reversed.toList();
          List<double> toDoubles(List<num> src) =>
              src.map((e) => e.toDouble()).toList();
          final activeUsers = toDoubles(
            dataAsc.map((e) => e.activeUsers).toList(),
          );
          final avgEvents = toDoubles(
            dataAsc.map((e) => e.avgEventsPerUser7d).toList(),
          );
          final avgMastery = toDoubles(
            dataAsc.map((e) => e.avgMastery).toList(),
          );
          final avgDelta = toDoubles(
            dataAsc.map((e) => e.avgMasteryDelta14d ?? 0).toList(),
          );
          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _metricCard(
                  context.labelActiveUsers,
                  activeUsers,
                  Colors.blue,
                  suffix: '',
                ),
                const SizedBox(height: 12),
                _metricCard(
                  context.labelAvgEventsPerUser7d,
                  avgEvents,
                  Colors.teal,
                  fractionDigits: 2,
                ),
                const SizedBox(height: 12),
                _metricCard(
                  context.labelAvgMastery,
                  avgMastery,
                  Colors.purple,
                  fractionDigits: 3,
                ),
                const SizedBox(height: 12),
                _metricCard(
                  context.labelAvgMasteryDelta14d,
                  avgDelta,
                  Colors.orange,
                  fractionDigits: 3,
                ),
                const SizedBox(height: 24),
                _latestTable(context, dataAsc),
              ],
            ),
          );
        },
      ),
    );
    return const bool.fromEnvironment('dart.vm.product')
        ? scaffold
        : RoleDebugWrapper(child: scaffold);
  }

  Widget _metricCard(
    String title,
    List<double> values,
    Color color, {
    int fractionDigits = 0,
    String suffix = '',
  }) {
    final latest = values.isNotEmpty ? values.last : 0.0;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Sparkline(values: values, color: color),
            const SizedBox(height: 8),
            Builder(
              builder: (context) {
                return Text(
                  '${context.labelLatestPrefix}: ${latest.toStringAsFixed(fractionDigits)}$suffix',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _latestTable(BuildContext context, List dataAsc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.labelLatest7Days,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(),
                4: FlexColumnWidth(),
              },
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        context.labelDate,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(context.labelActiveShort),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(context.labelAvgEvPerUsrShort),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(context.labelAvgMasteryShort),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(context.labelDelta14dShort),
                    ),
                  ],
                ),
                ...dataAsc
                    .take(7)
                    .map<TableRow>(
                      (e) => TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(e.date),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text('${e.activeUsers}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              e.avgEventsPerUser7d.toStringAsFixed(2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(e.avgMastery.toStringAsFixed(3)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              (e.avgMasteryDelta14d ?? 0).toStringAsFixed(3),
                            ),
                          ),
                        ],
                      ),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
