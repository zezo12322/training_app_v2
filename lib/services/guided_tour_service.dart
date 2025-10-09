import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/l10n_ext.dart';

/// Simple in-app guided tour overlay (no external packages) using OverlayEntry.
/// It sequentially highlights given targets (by GlobalKey) with a tooltip.
class TourStep {
  final GlobalKey key;
  final String title;
  final String body;
  final Alignment align;
  TourStep({
    required this.key,
    required this.title,
    required this.body,
    this.align = Alignment.topCenter,
  });
}

final guidedTourServiceProvider = Provider<GuidedTourService>(
  (ref) => GuidedTourService(),
);

class GuidedTourService {
  bool _running = false;
  int _index = 0;
  final List<OverlayEntry> _entries = [];
  List<TourStep> _steps = [];

  bool get isRunning => _running;

  void start(BuildContext context, List<TourStep> steps) {
    if (_running || steps.isEmpty) return;
    _running = true;
    _steps = steps;
    _index = 0;
    _showCurrent(context);
  }

  void next(BuildContext context) {
    if (!_running) return;
    _removeCurrent();
    _index++;
    if (_index >= _steps.length) {
      _finish();
    } else {
      _showCurrent(context);
    }
  }

  void skip() {
    if (!_running) return;
    _removeCurrent();
    _finish();
  }

  void _finish() {
    _running = false;
    _steps = [];
    _index = 0;
  }

  void _removeCurrent() {
    if (_entries.isNotEmpty) {
      final last = _entries.removeLast();
      last.remove();
    }
  }

  void _showCurrent(BuildContext context) {
    final step = _steps[_index];
    final render = step.key.currentContext?.findRenderObject() as RenderBox?;
    final overlay = Overlay.of(context);
    if (render == null || !render.attached) {
      // Skip if target not ready
      next(context);
      return;
    }
    final size = render.size;
    final offset = render.localToGlobal(Offset.zero);

    final isLast = _index == _steps.length - 1;

    final entry = OverlayEntry(
      builder: (ctx) => Stack(
        children: [
          // Dim layer
          GestureDetector(
            onTap: () => next(context),
            child: Container(color: Colors.black54),
          ),
          // Highlight circle
          Positioned(
            left: offset.dx - 8,
            top: offset.dy - 8,
            child: IgnorePointer(
              ignoring: true,
              child: Container(
                width: size.width + 16,
                height: size.height + 16,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 3,
                  ),
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          // Tooltip card
          Positioned(
            left: 16,
            right: 16,
            top:
                offset.dy + size.height + 24 <
                    MediaQuery.of(context).size.height - 160
                ? offset.dy + size.height + 16
                : null,
            bottom: offset.dy > MediaQuery.of(context).size.height / 2
                ? MediaQuery.of(context).size.height - offset.dy + 16
                : null,
            child: _TourCard(
              title: step.title,
              body: step.body,
              isLast: isLast,
              onNext: () => next(context),
              onSkip: skip,
            ),
          ),
        ],
      ),
    );
    overlay.insert(entry);
    _entries.add(entry);
  }
}

class _TourCard extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final bool isLast;
  const _TourCard({
    required this.title,
    required this.body,
    required this.onNext,
    required this.onSkip,
    required this.isLast,
  });
  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              body,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(height: 1.4),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                TextButton(onPressed: onSkip, child: Text(l.tourSkip)),
                const Spacer(),
                FilledButton(
                  onPressed: onNext,
                  child: Text(isLast ? l.tourDone : l.tourNext),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
