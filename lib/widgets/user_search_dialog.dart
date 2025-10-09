import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../providers/user_providers.dart';
import 'package:training_app/core/l10n_ext.dart';

class UserSearchDialog extends ConsumerStatefulWidget {
  final String companyId;
  final bool multiSelect;
  final Set<String> excludedUserIds;
  const UserSearchDialog({
    super.key,
    required this.companyId,
    this.multiSelect = true,
    this.excludedUserIds = const <String>{},
  });

  @override
  ConsumerState<UserSearchDialog> createState() => _UserSearchDialogState();
}

class _UserSearchDialogState extends ConsumerState<UserSearchDialog> {
  final TextEditingController _search = TextEditingController();
  final Set<String> _selected = <String>{};

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  final usersAsync = ref.watch(usersInCompanyProvider(widget.companyId));
  final q = _search.text.trim().toLowerCase();
    return AlertDialog(
      title: Text(context.assignMemberAction),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _search,
              decoration: InputDecoration(
                labelText: context.l.searchUsersLabel,
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: usersAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => Center(child: Text('Error: $e')),
                data: (users) {
                  final filtered = users
                      .where((u) {
                        final name = u.name.toLowerCase();
                        final email = u.email.toLowerCase();
                        if (q.isEmpty) return true;
                        return name.contains(q) || email.contains(q);
                      })
                      .toList()
                    ..sort((a, b) => (a.name.isNotEmpty ? a.name : a.email)
                        .toLowerCase()
                        .compareTo((b.name.isNotEmpty ? b.name : b.email)
                            .toLowerCase()));
                  if (filtered.isEmpty) {
                    return Center(child: Text(context.l.noResults));
                  }
                  return ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (ctx, i) {
                      final u = filtered[i];
                      final checked = _selected.contains(u.id);
                      final isExcluded = widget.excludedUserIds.contains(u.id);
                      return CheckboxListTile(
                        value: checked || isExcluded,
                        onChanged: isExcluded
                            ? null
                            : (v) {
                          setState(() {
                            if (widget.multiSelect) {
                              if (v == true) {
                                _selected.add(u.id);
                              } else {
                                _selected.remove(u.id);
                              }
                            } else {
                              _selected
                                ..clear()
                                ..add(u.id);
                            }
                          });
                            },
                        title: Text(u.name.isNotEmpty ? u.name : u.email),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (u.email.isNotEmpty) Text(u.email),
                            if (isExcluded)
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  context.l.alreadyMemberLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(color: Theme.of(context).colorScheme.secondary),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(<AppUser>[]),
          child: Text(context.l.dialogCancel),
        ),
        FilledButton(
          onPressed: () async {
            final all = await ref.read(usersInCompanyProvider(widget.companyId).future);
            final selected = all.where((u) => _selected.contains(u.id)).toList();
            if (selected.isEmpty) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.l.selectAtLeastOneUser)),
                );
              }
              return;
            }
            if (context.mounted) {
              Navigator.of(context).pop(selected);
            }
          },
          child: Text(context.l.assignSelectedAction),
        ),
      ],
    );
  }
}
