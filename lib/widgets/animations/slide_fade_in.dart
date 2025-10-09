import 'package:flutter/material.dart';

class SlideFadeIn extends StatelessWidget {
  final Widget child;
  final int index;
  final bool enable;
  final Duration baseDuration;
  const SlideFadeIn({
    super.key,
    required this.child,
    required this.index,
    this.enable = true,
    this.baseDuration = const Duration(milliseconds: 400),
  });

  @override
  Widget build(BuildContext context) {
    if (!enable) return child;
    final delay = Duration(milliseconds: 40 * (index.clamp(0, 15)));
    return _Delayed(
      index: index,
      delay: delay,
      duration: baseDuration,
      child: child,
    );
  }
}

class _Delayed extends StatefulWidget {
  final Widget child;
  final int index;
  final Duration delay;
  final Duration duration;
  const _Delayed({
    required this.child,
    required this.index,
    required this.delay,
    required this.duration,
  });
  @override
  State<_Delayed> createState() => _DelayedState();
}

class _DelayedState extends State<_Delayed>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: widget.duration);
    _a = CurvedAnimation(parent: _c, curve: Curves.easeOutCubic);
    Future.delayed(widget.delay, () {
      if (mounted) _c.forward();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _a,
      builder: (ctx, _) => Opacity(
        opacity: _a.value,
        child: Transform.translate(
          offset: Offset(0, (1 - _a.value) * 18),
          child: widget.child,
        ),
      ),
    );
  }
}
