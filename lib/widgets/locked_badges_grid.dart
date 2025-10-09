import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/gamification_providers.dart';
import '../providers/auth_provider.dart';
import '../core/l10n_ext.dart';

class LockedBadgesGrid extends ConsumerWidget {
  final int columns;
  const LockedBadgesGrid({super.key, this.columns = 4});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider).value;
    if (auth == null) return const SizedBox.shrink();
    final tuple = ref.watch(earnedLockedBadgesProvider(auth.uid));
    final l = context.l;
    final locked = tuple.$2;
    if (locked.isEmpty) {
      return Center(child: Text(l.allBadgesSection));
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: locked.length,
      itemBuilder: (_, i) {
        final b = locked[i];
        return Tooltip(
          message: b.description,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.4),
              ),
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.25),
            ),
            child: Center(
              child: Text(
                b.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ),
          ),
        );
      },
    );
  }
}
