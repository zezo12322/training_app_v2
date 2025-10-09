import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/badge_management_providers.dart';
import '../models/badge.dart' as model;
import 'badge_detail_screen.dart';
import '../core/l10n_ext.dart';
import '../providers/auth_provider.dart';

class BadgeManagementScreen extends ConsumerStatefulWidget {
  const BadgeManagementScreen({super.key});
  @override
  ConsumerState<BadgeManagementScreen> createState() =>
      _BadgeManagementScreenState();
}

class _BadgeManagementScreenState extends ConsumerState<BadgeManagementScreen> {
  void _openEditor({model.Badge? existing}) async {
    final result = await showDialog<model.Badge>(
      context: context,
      builder: (ctx) => _BadgeEditorDialog(existing: existing),
    );
    if (result != null) {
      await ref.read(createOrUpdateBadgeProvider(result).future);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final auth = ref.watch(authStateProvider).value;
    final all = ref.watch(allBadgesStreamProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l.badgeManageTitle)),
      floatingActionButton: auth == null
          ? null
          : FloatingActionButton(
              onPressed: () => _openEditor(),
              child: const Icon(Icons.add),
            ),
      body: all.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) => list.isEmpty
            ? Center(child: Text(l.noBadgesDefined))
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  final b = list[i];
                  return ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BadgeDetailScreen(badgeId: b.id),
                      ),
                    ),
                    leading: b.iconUrl.isNotEmpty
                        ? CircleAvatar(backgroundImage: NetworkImage(b.iconUrl))
                        : CircleAvatar(
                            child: Text(
                              b.name.isNotEmpty ? b.name[0].toUpperCase() : '?',
                            ),
                          ),
                    title: Text(b.name),
                    subtitle: Text(b.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!b.active)
                          const Icon(
                            Icons.visibility_off,
                            size: 18,
                            color: Colors.orange,
                          ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _openEditor(existing: b),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (c) => AlertDialog(
                                title: Text(l.deleteBadgeTitle),
                                content: Text(l.deleteConfirmBody(b.name)),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(c, false),
                                    child: Text(l.dialogNo),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(c, true),
                                    child: Text(l.dialogYes),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              await ref.read(deleteBadgeProvider(b.id).future);
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _BadgeEditorDialog extends StatefulWidget {
  final model.Badge? existing;
  const _BadgeEditorDialog({this.existing});
  @override
  State<_BadgeEditorDialog> createState() => _BadgeEditorDialogState();
}

class _BadgeEditorDialogState extends State<_BadgeEditorDialog> {
  late final TextEditingController _name = TextEditingController(
    text: widget.existing?.name ?? '',
  );
  late final TextEditingController _desc = TextEditingController(
    text: widget.existing?.description ?? '',
  );
  late final TextEditingController _icon = TextEditingController(
    text: widget.existing?.iconUrl ?? '',
  );
  late final TextEditingController _pointsGte = TextEditingController(
    text: widget.existing?.criteria['pointsGte']?.toString() ?? '',
  );
  late final TextEditingController _quizzesGte = TextEditingController(
    text: widget.existing?.criteria['quizzesPassedGte']?.toString() ?? '',
  );
  late final TextEditingController _tasksGte = TextEditingController(
    text: widget.existing?.criteria['tasksCompletedGte']?.toString() ?? '',
  );
  late final TextEditingController _lessonsGte = TextEditingController(
    text: widget.existing?.criteria['lessonsCompletedGte']?.toString() ?? '',
  );
  late final TextEditingController _streakGte = TextEditingController(
    text: widget.existing?.criteria['dailyStreakGte']?.toString() ?? '',
  );
  late final TextEditingController _reviewsGte = TextEditingController(
    text: widget.existing?.criteria['reviewsWrittenGte']?.toString() ?? '',
  );
  bool _active = true;
  bool _autoAward = true;

  @override
  void initState() {
    super.initState();
    _active = widget.existing?.active ?? true;
    _autoAward = widget.existing?.autoAward ?? true;
  }

  Map<String, dynamic> _buildCriteria() {
    final map = <String, dynamic>{};
    void put(TextEditingController c, String key) {
      if (c.text.trim().isEmpty) return;
      final v = int.tryParse(c.text.trim());
      if (v != null) map[key] = v;
    }

    put(_pointsGte, 'pointsGte');
    put(_quizzesGte, 'quizzesPassedGte');
    put(_tasksGte, 'tasksCompletedGte');
    put(_lessonsGte, 'lessonsCompletedGte');
    put(_streakGte, 'dailyStreakGte');
    put(_reviewsGte, 'reviewsWrittenGte');
    return map;
  }

  void _submit() {
    final id =
        widget.existing?.id ??
        _name.text.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9_]+'), '_');
    final badge = model.Badge(
      id: id,
      name: _name.text.trim(),
      description: _desc.text.trim(),
      iconUrl: _icon.text.trim(),
      active: _active,
      autoAward: _autoAward,
      criteria: _buildCriteria(),
    );
    Navigator.pop(context, badge);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return AlertDialog(
      title: Text(widget.existing == null ? l.newBadgeTitle : l.editBadgeTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _name,
              decoration: InputDecoration(labelText: l.fieldTitleHint),
            ),
            TextField(
              controller: _desc,
              decoration: InputDecoration(labelText: l.fieldDetailsHint),
            ),
            TextField(
              controller: _icon,
              decoration: InputDecoration(labelText: l.badgeIconUrlLabel),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l.criteriaSectionLabel,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: _pointsGte,
                    decoration: InputDecoration(labelText: 'points>='),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: _quizzesGte,
                    decoration: InputDecoration(labelText: 'quizzes>='),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: _tasksGte,
                    decoration: InputDecoration(labelText: 'tasks>='),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: _lessonsGte,
                    decoration: InputDecoration(labelText: 'lessons>='),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: _streakGte,
                    decoration: InputDecoration(labelText: 'streak>='),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: _reviewsGte,
                    decoration: InputDecoration(labelText: 'reviews>='),
                  ),
                ),
              ],
            ),
            SwitchListTile(
              value: _active,
              onChanged: (v) => setState(() => _active = v),
              title: Text(l.activeLabel),
            ),
            SwitchListTile(
              value: _autoAward,
              onChanged: (v) => setState(() => _autoAward = v),
              title: Text(l.autoAwardLabel),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l.dialogCancel),
        ),
        ElevatedButton(onPressed: _submit, child: Text(l.saveActionLabel)),
      ],
    );
  }
}
