import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/team_providers.dart';
import '../providers/department_providers.dart';
import 'package:training_app/core/l10n_ext.dart';
import '../providers/teaching_assignment_providers.dart';
import '../core/roles.dart';

enum _AssignmentFilter { activeNow, upcoming, archive }

class ManagerDashboard extends ConsumerStatefulWidget {
  final String departmentId;
  const ManagerDashboard({super.key, required this.departmentId});

  @override
  ConsumerState<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends ConsumerState<ManagerDashboard> {
  _AssignmentFilter _filter = _AssignmentFilter.activeNow;
  // For simplicity, use a fixed window for upcoming/archive (30d)
  final int _windowDays = 30;

  @override
  Widget build(BuildContext context) {
    // teamMemberMasteriesProvider handles team user aggregation
    final deptAsync = ref.watch(departmentByIdProvider(widget.departmentId));
    final title = deptAsync.when(
      data: (d) => d == null
          ? context.managerDashboardTitle
          : '${context.managerDashboardTitle} — ${d.name}',
      loading: () => context.managerDashboardTitle,
      error: (e, st) => context.managerDashboardTitle,
    );
    final scaffold = Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            tooltip: 'Home',
            icon: const Icon(Icons.home_outlined),
            onPressed: () async {
              if (!context.mounted) return;
              // Route back through AuthWrapper by popping to root.
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Assignments panel
          deptAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (e, st) => const SizedBox.shrink(),
            data: (dept) {
              if (dept == null) return const SizedBox.shrink();
              final asgAsync = ref.watch(assignmentsByTenantProvider((
                tenantType: 'company',
                tenantId: dept.companyId,
                status: null,
              )));
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Assignments', style: Theme.of(context).textTheme.titleMedium),
                        const Spacer(),
                        DropdownButton<_AssignmentFilter>(
                          value: _filter,
                          onChanged: (v) {
                            if (v != null) setState(() => _filter = v);
                          },
                          items: const [
                            DropdownMenuItem(value: _AssignmentFilter.activeNow, child: Text('Active Now')),
                            DropdownMenuItem(value: _AssignmentFilter.upcoming, child: Text('Upcoming 30d')),
                            DropdownMenuItem(value: _AssignmentFilter.archive, child: Text('Archive 30d')),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    asgAsync.when(
                      loading: () => const LinearProgressIndicator(),
                      error: (e, st) => Text('Error: $e'),
                      data: (list) {
                        final now = DateTime.now();
                        final endWindow = now.add(Duration(days: _windowDays));
                        final pastWindow = now.subtract(Duration(days: _windowDays));
                        // Filter by this department and selected window
                        final filtered = list.where((a) {
                          if (a.departmentId != widget.departmentId) return false;
                          final s = a.startAt;
                          final e = a.endAt;
                          if (_filter == _AssignmentFilter.activeNow) {
                            return s.isBefore(now) && e.isAfter(now);
                          } else if (_filter == _AssignmentFilter.upcoming) {
                            return s.isAfter(now) && s.isBefore(endWindow);
                          } else if (_filter == _AssignmentFilter.archive) {
                            return e.isBefore(now) && e.isAfter(pastWindow);
                          }
                          return false;
                        }).toList();

                        if (filtered.isEmpty) {
                          return Center(
                            child: Text(
                              'No assignments found for the selected filter.',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          );
                        }

                        return SizedBox(
                          height: 120,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: filtered.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 8),
                            itemBuilder: (_, i) {
                              final a = filtered[i];
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(a.title, style: Theme.of(context).textTheme.titleSmall),
                                      const SizedBox(height: 4),
                                      Text('Start: ${a.startAt}', style: Theme.of(context).textTheme.bodySmall),
                                      Text('End: ${a.endAt}', style: Theme.of(context).textTheme.bodySmall),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            flex: 2,
            child: ref.watch(teamMemberMasteriesProvider(widget.departmentId)).when(
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

                        final plateauSetAsync = ref.watch(teamPlateauFlagsProvider(widget.departmentId));
                        final riskAsync = ref.watch(teamMemberRiskProvider(widget.departmentId));
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
                                    departmentId: widget.departmentId,
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
        .watch(departmentSkillGapsProvider(widget.departmentId))
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
    return const bool.fromEnvironment('dart.vm.product')
        ? scaffold
        : RoleDebugWrapper(child: scaffold);
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
