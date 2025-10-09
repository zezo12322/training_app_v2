import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/gamification_providers.dart';
import '../providers/auth_provider.dart';
import '../core/l10n_ext.dart';

/// Widget يوضع أعلى الشجرة (داخل Scaffold) ليستمع لأي شارات جديدة ويعرض SnackBar
class BadgeAwardListener extends ConsumerStatefulWidget {
  final Widget child;
  const BadgeAwardListener({super.key, required this.child});
  @override
  ConsumerState<BadgeAwardListener> createState() => _BadgeAwardListenerState();
}

class _BadgeAwardListenerState extends ConsumerState<BadgeAwardListener> {
  static const _debounce = Duration(milliseconds: 350);
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authStateProvider).value;
    if (auth == null) return widget.child; // لا مستخدم
    final l = context.l;
    final awards = ref.watch(badgeAwardEventsProvider(auth.uid));

    if (awards.isNotEmpty) {
      _timer?.cancel();
      _timer = Timer(_debounce, () {
        if (!mounted) return;
        final provider = badgeAwardEventsProvider(auth.uid);
        final notifier = ref.read(provider.notifier);
        final current = List<String>.from(ref.read(provider));
        final badgeMap = ref.read(badgeIdToBadgeProvider);
        final nameMap = {for (final e in badgeMap.entries) e.key: e.value.name};
        if (current.isEmpty) return;
        String displayFirst = nameMap[current.first] ?? current.first;
        String message;
        if (current.length == 1) {
          message = l.badgeEarnedToast(displayFirst);
        } else {
          final others = current.length - 1;
          // نحاول استخدام صيغة محلية إن توفرت (badgesEarnedBatch)
          try {
            // ignore: invalid_use_of_protected_member
            // سيتم توليد getter لاحقاً بعد إعادة توليد الملف، نستخدم dynamic safeguard
            // لكن حالياً نستدعي عبر dynamic
            // ignore: avoid_dynamic_calls
            final dyn = (l as dynamic).badgesEarnedBatch(
              displayFirst,
              others.toString(),
            );
            message = dyn is String
                ? dyn
                : '${l.badgeEarnedToast(displayFirst)} +$others';
          } catch (_) {
            message = '${l.badgeEarnedToast(displayFirst)} +$others';
          }
        }
        HapticFeedback.mediumImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.emoji_events_outlined, color: Colors.amber),
                const SizedBox(width: 8),
                Expanded(child: Text(message)),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
        _showOverlayCelebration(message);
        notifier.consumeAll();
      });
    }

    return widget.child;
  }
}

extension on _BadgeAwardListenerState {
  void _showOverlayCelebration(String message) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (ctx) {
        return Positioned(
          top: 100,
          left: 24,
          right: 24,
          child: _CelebrationBanner(message: message),
        );
      },
    );
    overlay.insert(entry);
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) entry.remove();
    });
  }
}

class _CelebrationBanner extends StatefulWidget {
  final String message;
  const _CelebrationBanner({required this.message});
  @override
  State<_CelebrationBanner> createState() => _CelebrationBannerState();
}

class _CelebrationBannerState extends State<_CelebrationBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 650),
  );
  late final Animation<double> _scale = CurvedAnimation(
    parent: _c,
    curve: Curves.elasticOut,
  );
  @override
  void initState() {
    super.initState();
    _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(16),
        color: Colors.black.withValues(alpha: 0.85),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: Colors.amber),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
