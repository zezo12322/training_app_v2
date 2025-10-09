import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/team_providers.dart';
import '../providers/department_providers.dart';
import 'package:training_app/core/l10n_ext.dart';

class ManagerDashboard extends ConsumerWidget {
  final String departmentId;
  const ManagerDashboard({super.key, required this.departmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // teamMemberMasteriesProvider handles team user aggregation
    final deptAsync = ref.watch(departmentByIdProvider(departmentId));
    final title = deptAsync.when(
      data: (d) => d == null
          ? context.managerDashboardTitle
          : '${context.managerDashboardTitle} — ${d.name}',
      loading: () => context.managerDashboardTitle,
      error: (e, st) => context.managerDashboardTitle,
    );
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: ref.watch(teamMemberMasteriesProvider(departmentId)).when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text('Error: $e')),
                  data: (members) {
                    if (members.isEmpty) {
                      return Center(child: Text(context.noTeamMembers));
                    }
                    // We keep local sorting in a stateful wrapper around DataTable via StatefulBuilder
                    return StatefulBuilder(
                      builder: (ctx, setState) {
                        var sortColumnIndex = 1; // 0=name,1=avg,2=delta,3=risk
                        var sortAscending = true;
                        List<TeamMemberMastery> sorted = List.of(members);
                        void applySort() {
                          sorted.sort((a, b) {
                            int cmp;
                            if (sortColumnIndex == 1) {
                              cmp = a.avgMastery.compareTo(b.avgMastery);
                            } else if (sortColumnIndex == 2) {
                              cmp = a.avgDelta14d.compareTo(b.avgDelta14d);
                            } else {
                              cmp = a.userId.compareTo(b.userId);
                            }
                            return sortAscending ? cmp : -cmp;
                          });
                        }
                        applySort();

                        DataColumn sortableCol(String label, int idx) => DataColumn(
                              label: Text(label),
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  sortColumnIndex = idx;
                                  sortAscending = ascending;
                                  applySort();
                                });
                              },
                              numeric: idx != 0,
                            );

                        final plateauSetAsync = ref.watch(teamPlateauFlagsProvider(departmentId));
                        final riskAsync = ref.watch(teamMemberRiskProvider(departmentId));
                        return plateauSetAsync.when(
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (e, st) => const SizedBox.shrink(),
                          data: (plateauSet) => riskAsync.when(
                            loading: () => const Center(child: CircularProgressIndicator()),
                            error: (e, st) => const SizedBox.shrink(),
                            data: (risks) => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            sortColumnIndex: sortColumnIndex,
                            sortAscending: sortAscending,
                            columns: [
                              sortableCol(context.l.navProfile, 0),
                              sortableCol('Avg', 1),
                              sortableCol('Δ14d', 2),
                                sortableCol('Risk', 3),
                              const DataColumn(label: Text('')),
                            ],
                            rows: [
                              for (final m in sorted)
                                DataRow(cells: [
                                  DataCell(_UserNameCell(userId: m.userId)),
                                  DataCell(Text(m.avgMastery.toStringAsFixed(3))),
                                  DataCell(Text(
                                    m.avgDelta14d.toStringAsFixed(3),
                                    style: TextStyle(
                                      color: plateauSet.contains(m.userId)
                                          ? Colors.red
                                          : null,
                                      fontWeight: plateauSet.contains(m.userId)
                                          ? FontWeight.w600
                                          : null,
                                    ),
                                  )),
                                  DataCell(_RiskCell(
                                    userId: m.userId,
                                    risks: risks,
                                  )),
                                  DataCell(_MemberActions(
                                    departmentId: departmentId,
                                    userId: m.userId,
                                  )),
                                ]),
                            ],
                          ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
          ),
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              context.topSkillGapsTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            flex: 1,
            child: ref
                .watch(departmentSkillGapsProvider(departmentId))
                .when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text('Error: $e')),
                  data: (aggs) {
                    if (aggs.isEmpty) {
                      return Center(child: Text(context.noSkillData));
                    }
                    final top = aggs.take(5).toList();
                    return ListView.separated(
                      itemCount: top.length,
                      separatorBuilder: (_, __) => const Divider(height: 0),
                      itemBuilder: (ctx, i) {
                        final a = top[i];
                        return ListTile(
                          leading: const Icon(Icons.analytics_outlined),
                          title: Text(a.skillCode),
                          subtitle: Text(
                            'Avg: ${a.avgMastery.toStringAsFixed(3)} · Δ14d: ${a.avgDelta14d.toStringAsFixed(3)} · n=${a.usersCount}',
                          ),
                        );
                      },
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}

class _UserNameCell extends ConsumerWidget {
  final String userId;
  const _UserNameCell({required this.userId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(appUserByIdProvider(userId));
    return userAsync.when(
      data: (u) => Text(u?.name ?? userId),
      loading: () => Text(userId),
      error: (e, st) => Text(userId),
    );
  }
}

class _MemberActions extends ConsumerWidget {
  final String departmentId;
  final String userId;
  const _MemberActions({required this.departmentId, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      onSelected: (value) async {
        if (value == 'remove') {
          if (!context.mounted) return;
          final confirm = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(context.l.confirmationTitle),
              content: Text(context.l.removeMemberConfirm),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: Text(context.l.dialogCancel)),
                FilledButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: Text(context.l.deleteAction)),
              ],
            ),
          );
          if (confirm != true) return;
          final targetUser = await ref.read(appUserByIdProvider(userId).future);
          if (targetUser == null) return;
          await ref.read(removeUserFromDepartmentProvider((userId: targetUser.id, departmentId: departmentId)).future);
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l.memberRemovedToast)),
          );
        }
      },
      itemBuilder: (ctx) => [
        PopupMenuItem(
          value: 'remove',
          child: Text(context.l.deleteAction),
        ),
      ],
    );
  }
}

class _RiskCell extends StatelessWidget {
  final String userId;
  final List<TeamMemberRisk> risks;
  const _RiskCell({required this.userId, required this.risks});

  @override
  Widget build(BuildContext context) {
    final r = risks.firstWhere(
      (e) => e.userId == userId,
      orElse: () => const TeamMemberRisk(
        userId: '',
        risk: 0,
        componentsDelta: 0,
        componentsEvents: 0,
      ),
    );
    final val = r.userId.isEmpty ? 0.0 : r.risk;
    Color colorFor(double v) {
      // green (low) → yellow → red (high)
      if (v < 0.33) return Colors.green;
      if (v < 0.66) return Colors.orange;
      return Colors.red;
    }
    return Text(
      val.toStringAsFixed(2),
      style: TextStyle(
        color: colorFor(val),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
