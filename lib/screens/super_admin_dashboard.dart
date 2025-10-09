import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/super_admin_providers.dart';
import '../models/system_settings.dart';
import 'package:flutter/services.dart';

class SuperAdminDashboard extends ConsumerWidget {
  const SuperAdminDashboard({super.key});

  Stream<QuerySnapshot<Map<String, dynamic>>> _col(
    String name, {
    int limit = 20,
  }) => FirebaseFirestore.instance
      .collection(name)
      .orderBy('createdAt', descending: true)
      .limit(limit)
      .snapshots();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allowed = ref.watch(ensureSuperAdminProvider);
    if (!allowed) {
      return const Scaffold(
        body: Center(child: Text('Unauthorized (Super Admin only)')),
      );
    }

    final stats = ref.watch(globalStatsProvider);
    final usersAsync = ref.watch(superAdminUsersProvider);
    final settingsAsync = ref.watch(systemSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Super Admin')),
      body: RefreshIndicator(
        onRefresh: () async {
          // For now streams auto-update; placeholder for future manual triggers.
          await Future.delayed(const Duration(milliseconds: 300));
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _StatCard(
                  title: 'Total Users',
                  value: stats?.totalUsers.toString() ?? '…',
                  icon: Icons.people_outline,
                ),
                _StatCard(
                  title: 'Trainers',
                  value: stats?.trainers.toString() ?? '…',
                  icon: Icons.school_outlined,
                ),
                _StatCard(
                  title: 'Trainees',
                  value: stats?.trainees.toString() ?? '…',
                  icon: Icons.person_outline,
                ),
                _SystemSettingsCard(settingsAsync: settingsAsync),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Users (first 50)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            usersAsync.when(
              data: (list) => Card(
                child: Column(
                  children: [
                    for (final u in list)
                      ListTile(
                        dense: true,
                        title: Text(u.name),
                        subtitle: Text(u.email),
                        trailing: Text(
                          u.role,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                ),
              ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e, st) => Text('Error loading users: $e'),
            ),
            const SizedBox(height: 32),
            Text('Alerts', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            _AlertsSection(
              stream: _col('intrusion_alerts', limit: 10),
              title: 'Intrusion Alerts',
              type: 'intrusion',
            ),
            _AlertsSection(
              stream: _col('predictive_alerts', limit: 10),
              title: 'Predictive Alerts',
              type: 'predictive',
            ),
            _AlertsSection(
              stream: _col('integrity_flags', limit: 10),
              title: 'Integrity Flags',
              type: 'integrity',
            ),
            const SizedBox(height: 32),
            Text('Tenants', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            _TenantsSection(),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => const _CreateInstitutionDialog(),
                    );
                  },
                  icon: const Icon(Icons.apartment_outlined),
                  label: const Text('Create Institution'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => const _CreateCompanyDialog(),
                    );
                  },
                  icon: const Icon(Icons.business_outlined),
                  label: const Text('Create Company'),
                ),
              ],
            ),
            const SizedBox(height: 48),
            Text(
              'Next: Predictive & Intrusion widgets (Phase 0.2+)',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(title, style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class _SystemSettingsCard extends ConsumerWidget {
  final AsyncValue<SystemSettings?> settingsAsync;
  const _SystemSettingsCard({required this.settingsAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 250,
      child: settingsAsync.when(
        data: (s) => Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.settings_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 6),
                    const Text('System Settings'),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Flags: ${s?.featureFlags.length ?? 0}'),
                Text('Thresholds: ${s?.thresholds.length ?? 0}'),
                const Divider(height: 16),
                _FlagsStatus(s: s),
              ],
            ),
          ),
        ),
        loading: () => const Card(
          child: SizedBox(
            height: 80,
            width: 250,
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
        error: (e, st) => Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Settings error: $e'),
          ),
        ),
      ),
    );
  }
}

class _AlertsSection extends StatelessWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  final String title;
  final String type;
  const _AlertsSection({
    required this.stream,
    required this.title,
    required this.type,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: stream,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: LinearProgressIndicator(),
            );
          }
          if (snap.hasError) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Text('$title error: ${snap.error}'),
            );
          }
          final docs = snap.data?.docs ?? [];
          if (docs.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Text('No $title'),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              for (final d in docs.take(5))
                _AlertTile(data: d.data(), type: type),
              if (docs.length > 5)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                    left: 12,
                    right: 12,
                  ),
                  child: Text(
                    '+${docs.length - 5} more…',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _AlertTile extends StatelessWidget {
  final Map<String, dynamic> data;
  final String type;
  const _AlertTile({required this.data, required this.type});
  Color _sev(String s) {
    switch (s) {
      case 'high':
        return Colors.red.shade400;
      case 'med':
        return Colors.orange.shade400;
      default:
        return Colors.amber.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    final severity = (data['severity'] ?? data['level'] ?? 'low').toString();
    final status =
        data['status']?.toString() ??
        (data['resolved'] == true ? 'resolved' : 'open');
    return ListTile(
      dense: true,
      leading: Icon(Icons.warning_amber_rounded, color: _sev(severity)),
      title: Text(
        data['vector']?.toString() ?? data['category']?.toString() ?? type,
      ),
      subtitle: Text('${severity.toUpperCase()} • $status'),
      trailing: Text(
        (data['count'] ?? data['score'] ?? '').toString(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _TenantsSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final instAsync = ref.watch(institutionsProvider);
    final compAsync = ref.watch(companiesProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Institutions', style: Theme.of(context).textTheme.titleSmall),
            instAsync.when(
              data: (list) => list.isEmpty
                  ? const Text('No institutions')
                  : Column(
                      children: list
                          .take(5)
                          .map(
                            (i) => ListTile(
                              dense: true,
                              title: Text(i.name),
                              subtitle: Text(i.planTier),
                            ),
                          )
                          .toList(),
                    ),
              loading: () => const LinearProgressIndicator(),
              error: (e, st) => Text('Institutions error: $e'),
            ),
            const SizedBox(height: 12),
            Text('Companies', style: Theme.of(context).textTheme.titleSmall),
            compAsync.when(
              data: (list) => list.isEmpty
                  ? const Text('No companies')
                  : Column(
                      children: list
                          .take(5)
                          .map(
                            (c) => ListTile(
                              dense: true,
                              title: Text(c.name),
                              subtitle: Text(c.planTier),
                            ),
                          )
                          .toList(),
                    ),
              loading: () => const LinearProgressIndicator(),
              error: (e, st) => Text('Companies error: $e'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlagsStatus extends StatelessWidget {
  final SystemSettings? s;
  const _FlagsStatus({required this.s});

  @override
  Widget build(BuildContext context) {
    if (s == null) {
      return const Text('No settings loaded');
    }
    final reads = s!.enforceTenantReads;
    final writes = s!.enforceTenantWrites;
    Color badgeColor(bool on) =>
        on ? Colors.green.shade600 : Colors.grey.shade500;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _FlagBadge(
              label: 'Tenant Reads',
              active: reads,
              color: badgeColor(reads),
            ),
            const SizedBox(width: 8),
            _FlagBadge(
              label: 'Tenant Writes',
              active: writes,
              color: badgeColor(writes),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (!reads || !writes)
          Text(
            'Recommendation: Enable reads first, then writes after validating cross-tenant leakage is zero.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }
}

class _CreateInstitutionDialog extends ConsumerStatefulWidget {
  const _CreateInstitutionDialog();
  @override
  ConsumerState<_CreateInstitutionDialog> createState() => _CreateInstitutionDialogState();
}

class _CreateInstitutionDialogState extends ConsumerState<_CreateInstitutionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _planCtrl = TextEditingController(text: 'free');
  bool _saving = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _planCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Institution'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            TextFormField(
              controller: _planCtrl,
              decoration: const InputDecoration(labelText: 'Plan Tier'),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-z_]+'))],
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: _saving ? null : () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: _saving
              ? null
              : () async {
                  if (!_formKey.currentState!.validate()) return;
                  setState(() => _saving = true);
                  try {
                    await ref.read(createInstitutionProvider((name: _nameCtrl.text.trim(), planTier: _planCtrl.text.trim())).future);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Institution created')));
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  } finally {
                    if (mounted) setState(() => _saving = false);
                  }
                },
          child: const Text('Create'),
        ),
      ],
    );
  }
}

class _CreateCompanyDialog extends ConsumerStatefulWidget {
  const _CreateCompanyDialog();
  @override
  ConsumerState<_CreateCompanyDialog> createState() => _CreateCompanyDialogState();
}

class _CreateCompanyDialogState extends ConsumerState<_CreateCompanyDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _planCtrl = TextEditingController(text: 'free');
  bool _saving = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _planCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Company'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            TextFormField(
              controller: _planCtrl,
              decoration: const InputDecoration(labelText: 'Plan Tier'),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-z_]+'))],
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: _saving ? null : () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: _saving
              ? null
              : () async {
                  if (!_formKey.currentState!.validate()) return;
                  setState(() => _saving = true);
                  try {
                    await ref.read(createCompanyProvider((name: _nameCtrl.text.trim(), planTier: _planCtrl.text.trim())).future);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Company created')));
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  } finally {
                    if (mounted) setState(() => _saving = false);
                  }
                },
          child: const Text('Create'),
        ),
      ],
    );
  }
}

class _FlagBadge extends StatelessWidget {
  final String label;
  final bool active;
  final Color color;
  const _FlagBadge({
    required this.label,
    required this.active,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            active ? Icons.check_circle : Icons.cancel,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
