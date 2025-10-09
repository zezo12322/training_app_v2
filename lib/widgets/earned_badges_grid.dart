import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/gamification_providers.dart';
import '../providers/auth_provider.dart';
import '../core/l10n_ext.dart';

class EarnedBadgesGrid extends ConsumerWidget {
  final int columns;
  const EarnedBadgesGrid({super.key, this.columns = 4});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider).value;
    if (auth == null) return const SizedBox.shrink();
    final l = context.l;
    final tuple = ref.watch(earnedLockedBadgesProvider(auth.uid));
    final earned = tuple.$1;
    if (earned.isEmpty) {
      return Center(child: Text(l.noBadgesYet));
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: earned.length,
      itemBuilder: (_, i) {
        final b = earned[i];
        return Tooltip(
          message: b.description,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.4),
              ),
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.08),
            ),
            child: Center(
              child: Text(
                b.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11),
              ),
            ),
          ),
        );
      },
    );
  }
}
