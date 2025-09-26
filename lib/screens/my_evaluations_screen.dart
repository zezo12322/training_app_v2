import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // <<< استيراد حزمة تشغيل الصوت

class MyEvaluationsScreen extends StatefulWidget { // <<< تحويلها إلى StatefulWidget
  final String courseId;

  const MyEvaluationsScreen({
    super.key,
    required this.courseId,
  });

  @override
  State<MyEvaluationsScreen> createState() => _MyEvaluationsScreenState();
}

class _MyEvaluationsScreenState extends State<MyEvaluationsScreen> {
  // --- متغيرات جديدة لإدارة حالة الصوت ---
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String? _currentlyPlayingUrl;

  @override
  void initState() {
    super.initState();
    // الاستماع لانتهاء تشغيل الملف الصوتي لإعادة الأيقونة لوضعها الطبيعي
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
        _currentlyPlayingUrl = null;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // --- إيقاف المشغل عند الخروج من الشاشة
    super.dispose();
  }

  // --- دالة جديدة لتشغيل وإيقاف الصوت ---
  Future<void> _toggleAudio(String url) async {
    // إذا كان الملف الحالي هو الذي يعمل، قم بإيقافه
    if (_isPlaying && _currentlyPlayingUrl == url) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      // إيقاف أي ملف صوتي آخر قد يكون يعمل
      await _audioPlayer.stop();
      // تشغيل الملف الصوتي الجديد من الرابط
      await _audioPlayer.play(UrlSource(url));
      setState(() {
        _isPlaying = true;
        _currentlyPlayingUrl = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const Scaffold(body: Center(child: Text('يجب تسجيل الدخول أولاً')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('التقييمات الخاصة بي'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('evaluations')
            .where('courseId', isEqualTo: widget.courseId)
            .where('traineeId', isEqualTo: currentUser.uid)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('لم يتم إضافة أي تقييمات لك بعد.'));
          }

          final evaluations = snapshot.data!.docs;

          return ListView.builder(
            itemCount: evaluations.length,
            itemBuilder: (context, index) {
              final eval = evaluations[index].data() as Map<String, dynamic>;
              final score = eval['score'] as int;
              final feedback = eval['feedback'] as String;
              final audioUrl = eval['audioUrl'] as String?; // <-- جلب رابط الصوت
              final timestamp = eval['createdAt'] as Timestamp?;

              final date = timestamp?.toDate();
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
                          Text('الدرجة: $score/100', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                          Text(formattedDate, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const Divider(height: 20),
                      if (feedback.isNotEmpty) ...[
                        const Text('الملاحظات:', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text(feedback, style: const TextStyle(fontSize: 16, height: 1.5)),
                      ],

                      // --- الواجهة الجديدة لتشغيل الصوت ---
                      // تظهر فقط إذا كان هناك رابط صوتي
                      if (audioUrl != null) ...[
                        const Divider(height: 20),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                  (_isPlaying && _currentlyPlayingUrl == audioUrl)
                                      ? Icons.pause_circle_filled
                                      : Icons.play_circle_filled
                              ),
                              iconSize: 40,
                              color: Theme.of(context).primaryColor,
                              onPressed: () => _toggleAudio(audioUrl),
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
      ),
    );
  }
}