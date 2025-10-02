import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import '../providers/auth_provider.dart';
import '../providers/evaluation_providers.dart';
import '../models/evaluation.dart';

class MyEvaluationsScreen extends ConsumerStatefulWidget {
  final String courseId;
  const MyEvaluationsScreen({super.key, required this.courseId});

  @override
  ConsumerState<MyEvaluationsScreen> createState() => _MyEvaluationsScreenState();
}

class _MyEvaluationsScreenState extends ConsumerState<MyEvaluationsScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String? _currentlyPlayingUrl;

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
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(url));
      setState(() {
        _isPlaying = true;
        _currentlyPlayingUrl = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(authStateProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('التقييمات الخاصة بي')),
      body: authAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('يجب تسجيل الدخول أولاً'));
          }
          final evalsStream = ref.watch(
            userEvaluationsProvider((courseId: widget.courseId, traineeId: user.uid)),
          );
          return evalsStream.when(
            data: (list) {
              if (list.isEmpty) {
                return const Center(child: Text('لم يتم إضافة أي تقييمات لك بعد.'));
              }
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final EvaluationModel eval = list[index];
                  final date = eval.createdAt;
                  final formattedDate = date != null ? '${date.year}/${date.month}/${date.day}' : 'بدون تاريخ';
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('الدرجة: ${eval.score}/100', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                              Text(formattedDate, style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                          const Divider(height: 20),
                          if (eval.feedback.isNotEmpty) ...[
                            const Text('الملاحظات:', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            Text(eval.feedback, style: const TextStyle(fontSize: 16, height: 1.5)),
                          ],
                          if (eval.audioUrl != null) ...[
                            const Divider(height: 20),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    (_isPlaying && _currentlyPlayingUrl == eval.audioUrl)
                                        ? Icons.pause_circle_filled
                                        : Icons.play_circle_filled,
                                  ),
                                  iconSize: 40,
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () => _toggleAudio(eval.audioUrl!),
                                ),
                                const Text('استمع للتقييم الصوتي'),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('خطأ: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('خطأ بالمصادقة: $e')),
      ),
    );
  }
}