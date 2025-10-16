import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'add_question_screen.dart';
import '../core/l10n_ext.dart';

class CreateQuizScreen extends StatefulWidget {
  final String courseId;

  const CreateQuizScreen({super.key, required this.courseId});

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _createQuizAndProceed() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      // التعامل مع حالة عدم وجود مستخدم
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      // 1. إضافة مستند الاختبار الجديد إلى Firestore
      final quizDocRef = await FirebaseFirestore.instance
          .collection('quizzes')
          .add({
            'title': _titleController.text.trim(),
            'courseId': widget.courseId,
            'trainerId': currentUser.uid,
            'createdAt': FieldValue.serverTimestamp(),
            // Added default fields so quiz hub shows consistent info immediately
            'totalQuestions': 0,
            'passScore': 60,
            'allowRetake': true,
            'maxAttempts': 2,
            'rewardPoints': 15,
          });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l.createQuizSuccess),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddQuestionScreen(quizId: quizDocRef.id),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l.createQuizError.replaceAll('{error}', e.toString())),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally{
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l.createQuizTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: context.l.createQuizTitleLabel,
                  hintText: context.l.createQuizTitleHint,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.l.createQuizTitleRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(context.l.createQuizNextButton),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: _createQuizAndProceed,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
