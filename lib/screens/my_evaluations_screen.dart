import 'package:flutter/material.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import '../core/logging.dart';
import '../providers/auth_provider.dart';
import '../providers/evaluation_providers.dart';
import '../models/evaluation.dart';
import '../widgets/evaluation_card.dart';
import '../providers/settings_providers.dart';
import '../widgets/skeleton.dart';

class MyEvaluationsScreen extends ConsumerStatefulWidget {
  final String courseId;
  const MyEvaluationsScreen({super.key, required this.courseId});

  @override
  ConsumerState<MyEvaluationsScreen> createState() =>
      _MyEvaluationsScreenState();
}

class _MyEvaluationsScreenState extends ConsumerState<MyEvaluationsScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String? _currentlyPlayingUrl;
  bool _autoPlayedOnce = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _currentlyPlayingUrl = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _toggleAudio(String url) async {
    if (_isPlaying && _currentlyPlayingUrl == url) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      try {
        // Quick pre-flight HEAD/GET to ensure URL reachable (avoid silent failures)
        final resp = await http
            .head(Uri.parse(url))
            .timeout(const Duration(seconds: 8));
        if (resp.statusCode >= 400) {
          logger.w(
            'Audio URL not reachable (status=${resp.statusCode}) -> $url',
          );
          if (mounted) {
            AppSnackBar.show(
              context,
              'تعذر تشغيل التقييم الصوتي (رابط غير متاح حالياً)',
            );
          }
          return;
        }
      } catch (e, st) {
        logger.e('Audio preflight failed $url', error: e, stackTrace: st);
        if (mounted) {
          AppSnackBar.show(context, 'تعذر الوصول لملف الصوت. تحقق من الاتصال.');
        }
        return;
      }

      try {
        await _audioPlayer.stop();
        await _audioPlayer.play(UrlSource(url));
        logger.i('Started audio playback url=$url');
        setState(() {
          _isPlaying = true;
          _currentlyPlayingUrl = url;
        });
      } catch (e, st) {
        logger.e('Failed to start playback', error: e, stackTrace: st);
        if (mounted) {
          AppSnackBar.show(context, 'فشل تشغيل الصوت: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(authStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقييمات الخاصة بي'),
        actions: [
          // Theme toggle button
          Consumer(
            builder: (context, ref, _) {
              final mode = ref.watch(themeModeProvider);
              final isDark =
                  mode == ThemeMode.dark ||
                  (mode == ThemeMode.system &&
                      MediaQuery.of(context).platformBrightness ==
                          Brightness.dark);
              return IconButton(
                tooltip: 'تبديل المظهر',
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () {
                  ref.read(themeModeProvider.notifier).state = isDark
                      ? ThemeMode.light
                      : ThemeMode.dark;
                },
              );
            },
          ),
        ],
      ),
      body: authAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('يجب تسجيل الدخول أولاً'));
          }
          final evalsStream = ref.watch(
            userEvaluationsProvider((
              courseId: widget.courseId,
              traineeId: user.uid,
            )),
          );
          return evalsStream.when(
            data: (list) {
              if (list.isEmpty) {
                return const Center(
                  child: Text('لم يتم إضافة أي تقييمات لك بعد.'),
                );
              }
              // Autoplay logic (first evaluation with audio) if enabled
              final autoplay = ref.watch(autoplayAudioProvider);
              if (autoplay && !_autoPlayedOnce) {
                final firstWithAudio = list.firstWhere(
                  (e) => e.audioUrl != null,
                  orElse: () => list.first,
                );
                if (firstWithAudio.audioUrl != null) {
                  // Delay slightly to allow build & player readiness
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    if (mounted && !_autoPlayedOnce) {
                      _autoPlayedOnce = true;
                      await _toggleAudio(firstWithAudio.audioUrl!);
                    }
                  });
                } else {
                  _autoPlayedOnce = true; // nothing to autoplay
                }
              }
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final EvaluationModel eval = list[index];
                    return EvaluationCard(
                      evaluation: eval,
                      isPlaying: _isPlaying,
                      currentlyPlayingUrl: _currentlyPlayingUrl,
                      hasAudio: eval.audioUrl != null,
                      onToggleAudio: (url) => _toggleAudio(url),
                    );
                  },
                ),
              );
            },
            loading: () => ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (_, __) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Skeleton(height: 110),
              ),
            ),
            error: (e, st) => Center(child: Text('خطأ: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('خطأ بالمصادقة: $e')),
      ),
    );
  }
}
