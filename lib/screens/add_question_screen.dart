import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء تحديد الإجابة الصحيحة')),
      );
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
      if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // قسم عرض الأسئلة المضافة بالفعل
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('quiz_questions')
                  .where('quizId', isEqualTo: widget.quizId)
                  .orderBy('createdAt').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('لم يتم إضافة أي أسئلة بعد.');
                }
                final questions = snapshot.data!.docs;
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
                  const SizedBox(height: 16),
                  TextFormField(controller: _questionController, decoration: const InputDecoration(labelText: 'نص السؤال', border: OutlineInputBorder()), validator: (v) => v!.isEmpty ? 'الحقل مطلوب' : null),
                  const SizedBox(height: 12),
                  TextFormField(controller: _option1Controller, decoration: const InputDecoration(labelText: 'الخيار 1', border: OutlineInputBorder()), validator: (v) => v!.isEmpty ? 'الحقل مطلوب' : null),
                  const SizedBox(height: 12),
                  TextFormField(controller: _option2Controller, decoration: const InputDecoration(labelText: 'الخيار 2', border: OutlineInputBorder()), validator: (v) => v!.isEmpty ? 'الحقل مطلوب' : null),
                  const SizedBox(height: 12),
                  TextFormField(controller: _option3Controller, decoration: const InputDecoration(labelText: 'الخيار 3', border: OutlineInputBorder()), validator: (v) => v!.isEmpty ? 'الحقل مطلوب' : null),
                  const SizedBox(height: 12),
                  TextFormField(controller: _option4Controller, decoration: const InputDecoration(labelText: 'الخيار 4', border: OutlineInputBorder()), validator: (v) => v!.isEmpty ? 'الحقل مطلوب' : null),
                  const SizedBox(height: 16),
                  const Text('حدد الإجابة الصحيحة:', style: TextStyle(fontSize: 16)),
                  RadioListTile<int>(title: const Text('الخيار 1'), value: 0, groupValue: _correctAnswerIndex, onChanged: (v) => setState(() => _correctAnswerIndex = v)),
                  RadioListTile<int>(title: const Text('الخيار 2'), value: 1, groupValue: _correctAnswerIndex, onChanged: (v) => setState(() => _correctAnswerIndex = v)),
                  RadioListTile<int>(title: const Text('الخيار 3'), value: 2, groupValue: _correctAnswerIndex, onChanged: (v) => setState(() => _correctAnswerIndex = v)),
                  RadioListTile<int>(title: const Text('الخيار 4'), value: 3, groupValue: _correctAnswerIndex, onChanged: (v) => setState(() => _correctAnswerIndex = v)),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('إضافة السؤال'),
                    onPressed: _addQuestion,
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
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