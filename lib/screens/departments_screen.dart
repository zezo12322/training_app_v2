import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/department_providers.dart';
import '../providers/team_providers.dart';
import 'manager_dashboard.dart';
import 'department_members_screen.dart';
import '../widgets/user_search_dialog.dart';
import 'package:training_app/core/l10n_ext.dart';

class DepartmentsScreen extends ConsumerWidget {
  final String companyId;
  const DepartmentsScreen({super.key, required this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final depsAsync = ref.watch(departmentsByCompanyProvider(companyId));
    return Scaffold(
      appBar: AppBar(title: Text(context.departmentsTitle)),
      body: depsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (list) {
          if (list.isEmpty) {
            return Center(child: Text(context.noDepartments));
          }
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (ctx, i) {
              final d = list[i];
              return ListTile(
                leading: const Icon(Icons.apartment_outlined),
                title: Text(d.name),
                subtitle: Text(context.idLabel(d.id)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ManagerDashboard(departmentId: d.id),
                    ),
                  );
                },
                onLongPress: () async {
                  // Enhanced quick-assign via user search dialog (multi-select)
                  final currentIds = await ref.read(teamUserIdsByDepartmentProvider(d.id).future);
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
                    await ref.read(addUserToDepartmentProvider((userId: u.id, departmentId: d.id)).future);
                  }
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.l.assignmentCompletedToast(selected.length))),
                  );
                },
                trailing: IconButton(
                  icon: const Icon(Icons.group_outlined),
                  tooltip: context.l.manageMembersAction,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DepartmentMembersScreen(
                          departmentId: d.id,
                          companyId: companyId,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_business_outlined),
  label: Text(context.l.departmentsAddAction),
        onPressed: () async {
          final nameController = TextEditingController();
          final ok = await showDialog<bool>(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text(context.l.departmentsAddAction),
                content: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: context.l.departmentNameLabel,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: Text(context.l.dialogCancel),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: Text(context.l.saveActionLabel),
                  ),
                ],
              );
            },
          );
          if (ok == true) {
            final name = nameController.text.trim();
            if (name.isEmpty) return;
            await ref.read(createDepartmentProvider((companyId: companyId, name: name)).future);
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.l.departmentCreatedToast(name))),
            );
          }
        },
      ),
    );
  }
}
