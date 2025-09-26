import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/common/index.dart';
import '../utils/ui_helpers.dart';
import '../utils/form_validators.dart';

class AddQuestionScreen extends StatefulWidget {
  final String quizId;

  const AddQuestionScreen({super.key, required this.quizId});

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _option1Controller = TextEditingController();
  final _option2Controller = TextEditingController();
  final _option3Controller = TextEditingController();
  final _option4Controller = TextEditingController();

  int? _correctAnswerIndex;
  bool _isLoading = false;

  @override
  void dispose() {
    _questionController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    _option4Controller.dispose();
    super.dispose();
  }

  Future<void> _addQuestion() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_correctAnswerIndex == null) {
      UIHelpers.showErrorSnackBar(context, 'الرجاء تحديد الإجابة الصحيحة');
      return;
    }

    setState(() { _isLoading = true; });

    try {
      await FirebaseFirestore.instance.collection('quiz_questions').add({
        'quizId': widget.quizId,
        'questionText': _questionController.text.trim(),
        'options': [
          _option1Controller.text.trim(),
          _option2Controller.text.trim(),
          _option3Controller.text.trim(),
          _option4Controller.text.trim(),
        ],
        'correctAnswerIndex': _correctAnswerIndex,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // مسح الحقول بعد الإضافة بنجاح
      _formKey.currentState!.reset();
      _questionController.clear();
      _option1Controller.clear();
      _option2Controller.clear();
      _option3Controller.clear();
      _option4Controller.clear();
      setState(() {
        _correctAnswerIndex = null;
      });

    } catch (e) {
      if(mounted) UIHelpers.showErrorSnackBar(context, 'حدث خطأ: $e');
    } finally {
      if(mounted) setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة أسئلة للاختبار'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(UIHelpers.defaultPadding),
        child: Column(
          children: [
            // قسم عرض الأسئلة المضافة بالفعل
            AsyncDataBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('quiz_questions')
                  .where('quizId', isEqualTo: widget.quizId)
                  .orderBy('createdAt').snapshots(),
              emptyMessage: 'لم يتم إضافة أي أسئلة بعد.',
              emptyIcon: Icons.quiz_outlined,
              builder: (context, snapshot) {
                final questions = snapshot.docs;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('الأسئلة المضافة: ${questions.length}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Divider(),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        final question = questions[index];
                        return ListTile(
                          leading: Text('${index + 1}.'),
                          title: Text(question['questionText']),
                        );
                      },
                    ),
                    const Divider(height: 30),
                  ],
                );
              },
            ),

            // قسم إضافة سؤال جديد
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('إضافة سؤال جديد:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: UIHelpers.defaultPadding),
                  CustomTextField(
                    controller: _questionController, 
                    labelText: 'نص السؤال', 
                    validator: FormValidators.required,
                  ),
                  const SizedBox(height: UIHelpers.defaultSpacing),
                  CustomTextField(
                    controller: _option1Controller, 
                    labelText: 'الخيار 1', 
                    validator: FormValidators.required,
                  ),
                  const SizedBox(height: UIHelpers.defaultSpacing),
                  CustomTextField(
                    controller: _option2Controller, 
                    labelText: 'الخيار 2', 
                    validator: FormValidators.required,
                  ),
                  const SizedBox(height: UIHelpers.defaultSpacing),
                  CustomTextField(
                    controller: _option3Controller, 
                    labelText: 'الخيار 3', 
                    validator: FormValidators.required,
                  ),
                  const SizedBox(height: UIHelpers.defaultSpacing),
                  CustomTextField(
                    controller: _option4Controller, 
                    labelText: 'الخيار 4', 
                    validator: FormValidators.required,
                  ),
                  const SizedBox(height: UIHelpers.defaultPadding),
                  const Text('حدد الإجابة الصحيحة:', style: TextStyle(fontSize: 16)),
                  RadioListTile<int>(title: const Text('الخيار 1'), value: 0, groupValue: _correctAnswerIndex, onChanged: (v) => setState(() => _correctAnswerIndex = v)),
                  RadioListTile<int>(title: const Text('الخيار 2'), value: 1, groupValue: _correctAnswerIndex, onChanged: (v) => setState(() => _correctAnswerIndex = v)),
                  RadioListTile<int>(title: const Text('الخيار 3'), value: 2, groupValue: _correctAnswerIndex, onChanged: (v) => setState(() => _correctAnswerIndex = v)),
                  RadioListTile<int>(title: const Text('الخيار 4'), value: 3, groupValue: _correctAnswerIndex, onChanged: (v) => setState(() => _correctAnswerIndex = v)),
                  const SizedBox(height: UIHelpers.largeSpacing),
                  CustomButton(
                    onPressed: _addQuestion,
                    text: 'إضافة السؤال',
                    icon: Icons.add,
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}