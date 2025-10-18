import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'add_question_screen.dart';
import '../core/l10n_ext.dart';
import 'package:training_app/widgets/widgets.dart';
import 'package:training_app/core/design/tokens.dart';

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
            content: Text(context.l.createQuizError(e.toString())),
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
        padding: EdgeInsets.all(DesignTokens.spacingLg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppCard(
                padding: EdgeInsets.all(DesignTokens.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(DesignTokens.spacingSm),
                          decoration: BoxDecoration(
                            color: DesignTokens.info.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                          ),
                          child: Icon(
                            Icons.quiz_outlined,
                            color: DesignTokens.info,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: DesignTokens.spacingSm),
                        Text(
                          'Quiz Details',
                          style: DesignTokens.h5(context),
                        ),
                      ],
                    ),
                    SizedBox(height: DesignTokens.spacingLg),
                    AppTextField(
                      controller: _titleController,
                      label: context.l.createQuizTitleLabel,
                      hint: context.l.createQuizTitleHint,
                      prefixIcon: Icons.title_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return context.l.createQuizTitleRequired;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: DesignTokens.spacingXl),
              _isLoading
                  ? Center(
                      child: Column(
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(height: DesignTokens.spacingMd),
                          Text(
                            'Creating quiz...',
                            style: DesignTokens.body2(context).copyWith(
                              color: DesignTokens.textSecondary(context),
                            ),
                          ),
                        ],
                      ),
                    )
                  : AppButton(
                      text: context.l.createQuizNextButton,
                      icon: Icons.arrow_forward,
                      onPressed: _createQuizAndProceed,
                      type: AppButtonType.primary,
                      fullWidth: true,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
