import 'package:flutter/material.dart';

class Skeleton extends StatefulWidget {
  final double height;
  final double width;
  final BorderRadius? radius;
  const Skeleton({
    super.key,
    this.height = 16,
    this.width = double.infinity,
    this.radius,
  });

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(
      context,
    ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.35);
    final highlight = Theme.of(
      context,
    ).colorScheme.surface.withValues(alpha: 0.9);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final value = _controller.value; // 0..1
        return ClipRRect(
          borderRadius: widget.radius ?? BorderRadius.circular(8),
          child: Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [base, base, highlight, base, base],
                stops: [
                  0,
                  (value * 0.5).clamp(0, 0.4),
                  (value * 0.8).clamp(0.2, 0.7),
                  (value * 1.0).clamp(0.5, 0.9),
                  1,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ListTileSkeleton extends StatelessWidget {
  final bool withAvatar;
  const ListTileSkeleton({super.key, this.withAvatar = true});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (withAvatar) ...[
            const Skeleton(
              height: 48,
              width: 48,
              radius: BorderRadius.all(Radius.circular(24)),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Skeleton(height: 16, width: 140),
                SizedBox(height: 8),
                Skeleton(height: 14, width: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
