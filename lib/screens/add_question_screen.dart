// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/providers/quiz_providers.dart';
import 'package:training_app/models/quiz_question.dart';

class AddQuestionScreen extends ConsumerStatefulWidget {
  final String quizId;

  const AddQuestionScreen({super.key, required this.quizId});

  @override
  ConsumerState<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends ConsumerState<AddQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _option1Controller = TextEditingController();
  final _option2Controller = TextEditingController();
  final _option3Controller = TextEditingController();
  final _option4Controller = TextEditingController();

  // نوع السؤال
  String _questionType = QuizQuestionType.multipleChoice; // includes matching
  // Matching controllers
  final List<TextEditingController> _leftCtrls = [];
  final List<TextEditingController> _rightCtrls = [];
  int _matchingPairs = 3;

  void _initMatchingControllers() {
    while (_leftCtrls.length < _matchingPairs) {
      _leftCtrls.add(TextEditingController());
      _rightCtrls.add(TextEditingController());
    }
  }

  @override
  void initState() {
    super.initState();
    _initMatchingControllers();
  }

  int? _correctAnswerIndex;
  bool _isLoading = false;
  @override
  void dispose() {
    for (final c in _leftCtrls) {
      c.dispose();
    }
    for (final c in _rightCtrls) {
      c.dispose();
    }
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
    // تحقق خاص بأسئلة الاختيار من متعدد فقط
    if (_questionType == 'multiple_choice' && _correctAnswerIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدد الإجابة الصحيحة (اختيار من متعدد)')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final repo = ref.read(quizRepositoryProvider);
      if (_questionType == QuizQuestionType.multipleChoice) {
        await repo.addMultipleChoice(
          quizId: widget.quizId,
          questionText: _questionController.text.trim(),
          options: [
            _option1Controller.text.trim(),
            _option2Controller.text.trim(),
            _option3Controller.text.trim(),
            _option4Controller.text.trim(),
          ],
          correctAnswerIndex: _correctAnswerIndex!,
        );
      } else if (_questionType == QuizQuestionType.shortText ||
          _questionType == QuizQuestionType.longText) {
        await repo.addTextQuestion(
          quizId: widget.quizId,
          questionText: _questionController.text.trim(),
          type: _questionType,
        );
      } else if (_questionType == QuizQuestionType.matching) {
        final left = _leftCtrls
            .take(_matchingPairs)
            .map((c) => c.text.trim())
            .where((e) => e.isNotEmpty)
            .toList();
        final right = _rightCtrls
            .take(_matchingPairs)
            .map((c) => c.text.trim())
            .where((e) => e.isNotEmpty)
            .toList();
        if (left.length < 2 ||
            right.length < 2 ||
            left.length != right.length) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'أدخل أزواج مطابقة صالحة (على الأقل زوجان وبعدد متساوٍ',
                ),
              ),
            );
          }
        } else {
          await repo.addMatchingQuestion(
            quizId: widget.quizId,
            questionText: _questionController.text.trim(),
            leftItems: left,
            rightItems: right,
          );
        }
      }

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
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
      }
    } finally {
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
      appBar: AppBar(title: const Text('إضافة أسئلة للاختبار')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // قسم عرض الأسئلة المضافة بالفعل
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('quiz_questions')
                  .where('quizId', isEqualTo: widget.quizId)
                  .orderBy('createdAt')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('لم يتم إضافة أي أسئلة بعد.');
                }
                final questions = snapshot.data!.docs;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الأسئلة المضافة: ${questions.length}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                  const Text(
                    'إضافة سؤال جديد:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('نوع السؤال: '),
                      const SizedBox(width: 12),
                      DropdownButton<String>(
                        value: _questionType,
                        items: const [
                          DropdownMenuItem(
                            value: QuizQuestionType.multipleChoice,
                            child: Text('اختيار من متعدد'),
                          ),
                          DropdownMenuItem(
                            value: QuizQuestionType.shortText,
                            child: Text('إجابة قصيرة'),
                          ),
                          DropdownMenuItem(
                            value: QuizQuestionType.longText,
                            child: Text('إجابة طويلة'),
                          ),
                          DropdownMenuItem(
                            value: QuizQuestionType.matching,
                            child: Text('مطابقة (توصيل)'),
                          ),
                        ],
                        onChanged: (val) {
                          if (val == null) return;
                          setState(() {
                            _questionType = val;
                            _correctAnswerIndex =
                                null; // إعادة الضبط عند تغيير النوع
                            if (_questionType == QuizQuestionType.matching) {
                              _matchingPairs = 3;
                              _initMatchingControllers();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _questionController,
                    decoration: const InputDecoration(
                      labelText: 'نص السؤال',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v!.isEmpty ? 'الحقل مطلوب' : null,
                  ),
                  const SizedBox(height: 12),
                  if (_questionType == QuizQuestionType.multipleChoice) ...[
                    TextFormField(
                      controller: _option1Controller,
                      decoration: const InputDecoration(
                        labelText: 'الخيار 1',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? 'الحقل مطلوب' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _option2Controller,
                      decoration: const InputDecoration(
                        labelText: 'الخيار 2',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? 'الحقل مطلوب' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _option3Controller,
                      decoration: const InputDecoration(
                        labelText: 'الخيار 3',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? 'الحقل مطلوب' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _option4Controller,
                      decoration: const InputDecoration(
                        labelText: 'الخيار 4',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? 'الحقل مطلوب' : null,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'حدد الإجابة الصحيحة:',
                      style: TextStyle(fontSize: 16),
                    ),
                    RadioListTile<int>(
                      title: const Text('الخيار 1'),
                      value: 0,
                      groupValue: _correctAnswerIndex,
                      onChanged: (v) => setState(() => _correctAnswerIndex = v),
                    ),
                    RadioListTile<int>(
                      title: const Text('الخيار 2'),
                      value: 1,
                      groupValue: _correctAnswerIndex,
                      onChanged: (v) => setState(() => _correctAnswerIndex = v),
                    ),
                    RadioListTile<int>(
                      title: const Text('الخيار 3'),
                      value: 2,
                      groupValue: _correctAnswerIndex,
                      onChanged: (v) => setState(() => _correctAnswerIndex = v),
                    ),
                    RadioListTile<int>(
                      title: const Text('الخيار 4'),
                      value: 3,
                      groupValue: _correctAnswerIndex,
                      onChanged: (v) => setState(() => _correctAnswerIndex = v),
                    ),
                  ],
                  if (_questionType == QuizQuestionType.matching) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('أزواج المطابقة (يسار ⇄ يمين):'),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _matchingPairs++;
                              _initMatchingControllers();
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                        if (_matchingPairs > 2)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _matchingPairs--;
                              });
                            },
                            icon: const Icon(Icons.remove),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _matchingPairs,
                      itemBuilder: (_, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _leftCtrls[i],
                                  decoration: InputDecoration(
                                    labelText: 'يسار ${i + 1}',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: _rightCtrls[i],
                                  decoration: InputDecoration(
                                    labelText: 'يمين ${i + 1}',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                  const SizedBox(height: 24),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('إضافة السؤال'),
                          onPressed: _addQuestion,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
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
