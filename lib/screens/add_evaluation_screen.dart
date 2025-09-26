import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:record/record.dart';
import 'package:training_app/services/notification_service.dart';
import '../widgets/common/index.dart';
import '../utils/ui_helpers.dart';
import '../utils/form_validators.dart';

class AddEvaluationScreen extends StatefulWidget {
  final String courseId;
  final String traineeId;
  final String traineeEmail;

  const AddEvaluationScreen({
    super.key,
    required this.courseId,
    required this.traineeId,
    required this.traineeEmail,
  });

  @override
  State<AddEvaluationScreen> createState() => _AddEvaluationScreenState();
}

class _AddEvaluationScreenState extends State<AddEvaluationScreen> {
  final _scoreController = TextEditingController();
  final _feedbackController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  String? _audioPath;

  @override
  void dispose() {
    _scoreController.dispose();
    _feedbackController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    if (await _audioRecorder.isRecording()) {
      final path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        _audioPath = path;
      });
    } else {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start(const RecordConfig(), path: 'audio_evaluation.m4a');
        setState(() {
          _isRecording = true;
          _audioPath = null;
        });
      }
    }
  }

  Future<void> _submitEvaluation() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() { _isLoading = true; });

    try {
      String? audioUrl;
      if (_audioPath != null) {
        final file = File(_audioPath!);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('evaluation_audio')
            .child(widget.courseId)
            .child('${DateTime.now().millisecondsSinceEpoch}.m4a');

        await storageRef.putFile(file);
        audioUrl = await storageRef.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('evaluations').add({
        'courseId': widget.courseId,
        'traineeId': widget.traineeId,
        'traineeEmail': widget.traineeEmail,
        'score': int.tryParse(_scoreController.text.trim()) ?? 0,
        'feedback': _feedbackController.text.trim(),
        'audioUrl': audioUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });

      UIHelpers.showSuccessSnackBar(context, 'تم إرسال التقييم بنجاح!');

      // --- إرسال الإشعار للمتدرب المعني ---
      await _sendNewEvaluationNotification();

      if (mounted) Navigator.of(context).pop();

    } catch (e) {
      UIHelpers.showErrorSnackBar(context, 'حدث خطأ: $e');
    } finally {
      if (mounted) setState(() { _isLoading = false; });
    }
  }

  Future<void> _sendNewEvaluationNotification() async {
    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.traineeId).get();
      if (!userDoc.exists) return;
      final playerId = userDoc.data()?['oneSignalPlayerId'] as String?;
      if (playerId == null) return;

      final courseDoc = await FirebaseFirestore.instance.collection('courses').doc(widget.courseId).get();
      final courseName = courseDoc.data()?['name'] ?? 'أحد كورساتك';

      await OneSignalNotificationService().sendNotification(
        playerIds: [playerId], // نرسل للمتدرب المحدد فقط
        title: 'لديك تقييم جديد!',
        content: 'قام مدربك بإضافة تقييم جديد لك في كورس: $courseName',
      );
    } catch(e) {
      print("Could not send evaluation notification: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تقييم ${widget.traineeEmail}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                controller: _scoreController,
                labelText: 'الدرجة (من 100)',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => FormValidators.range(value, 0, 100),
              ),
              const SizedBox(height: UIHelpers.defaultPadding),
              CustomTextField(
                controller: _feedbackController,
                labelText: 'الملاحظات والتقييم',
                maxLines: 5,
                validator: FormValidators.required,
              ),
              const SizedBox(height: UIHelpers.largeSpacing),
              const Text('إضافة تقييم صوتي (اختياري):', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(_isRecording ? Icons.stop_circle : Icons.mic),
                    iconSize: 40,
                    color: _isRecording ? Colors.red : Theme.of(context).primaryColor,
                    onPressed: _toggleRecording,
                  ),
                  if (_audioPath != null && !_isRecording)
                    const Icon(Icons.check_circle, color: Colors.green, size: 30),
                ],
              ),
              const SizedBox(height: UIHelpers.largeSpacing),
              CustomButton(
                onPressed: _submitEvaluation,
                text: 'إرسال التقييم',
                icon: Icons.send,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}