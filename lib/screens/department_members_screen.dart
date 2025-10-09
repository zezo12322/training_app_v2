import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/team_providers.dart';
import '../providers/department_providers.dart';
import '../widgets/user_search_dialog.dart';
import 'package:training_app/core/l10n_ext.dart';

class DepartmentMembersScreen extends ConsumerWidget {
  final String departmentId;
  final String companyId;
  const DepartmentMembersScreen({super.key, required this.departmentId, required this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deptAsync = ref.watch(departmentByIdProvider(departmentId));
    final title = deptAsync.when(
      data: (d) => d == null ? context.l.departmentMembersTitle : '${context.l.departmentMembersTitle} — ${d.name}',
      loading: () => context.l.departmentMembersTitle,
      error: (e, st) => context.l.departmentMembersTitle,
    );
    final userIdsAsync = ref.watch(teamUserIdsByDepartmentProvider(departmentId));
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: userIdsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (userIds) {
          if (userIds.isEmpty) {
            return Center(child: Text(context.noTeamMembers));
          }
          return ListView.separated(
            itemCount: userIds.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (ctx, i) {
              final uid = userIds[i];
              final userAsync = ref.watch(appUserByIdProvider(uid));
              return ListTile(
                leading: const Icon(Icons.person_outline),
                title: userAsync.when(
                  data: (u) => Text(u?.name ?? uid),
                  loading: () => Text(uid),
                  error: (e, st) => Text(uid),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.person_remove_outlined),
                  tooltip: context.l.deleteAction,
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(context.l.confirmationTitle),
                        content: Text(context.l.removeMemberConfirm),
                        actions: [
                          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text(context.l.dialogCancel)),
                          FilledButton(onPressed: () => Navigator.of(ctx).pop(true), child: Text(context.l.deleteAction)),
                        ],
                      ),
                    );
                    if (confirm != true) return;
                    final targetUser = await ref.read(appUserByIdProvider(uid).future);
                    if (targetUser == null) return;
                    await ref.read(removeUserFromDepartmentProvider((userId: targetUser.id, departmentId: departmentId)).future);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(context.l.memberRemovedToast)),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.person_add_alt_1_outlined),
        label: Text(context.l.assignMemberAction),
        onPressed: () async {
          final currentIds = await ref.read(teamUserIdsByDepartmentProvider(departmentId).future);
          if (!context.mounted) return;
          final selected = await showDialog(
            context: context,
            builder: (ctx) => UserSearchDialog(
              companyId: companyId,
              multiSelect: true,
              excludedUserIds: currentIds.toSet(),
            ),
          ) as List?;
          if (selected == null || selected.isEmpty) return;
          for (final u in selected) {
            await ref.read(addUserToDepartmentProvider((userId: u.id, departmentId: departmentId)).future);
          }
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l.assignmentCompletedToast(selected.length))),
          );
        },
      ),
    );
  }
}
