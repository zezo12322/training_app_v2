import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateBadgeScreen extends StatefulWidget {
  const CreateBadgeScreen({super.key});
  @override
  State<CreateBadgeScreen> createState() => _CreateBadgeScreenState();
}

class _CreateBadgeScreenState extends State<CreateBadgeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _iconCtrl = TextEditingController();
  final _pointsCtrl = TextEditingController();
  final _streakCtrl = TextEditingController();
  final _quizPassCtrl = TextEditingController();
  final _tasksCtrl = TextEditingController();
  final _lessonsCtrl = TextEditingController();
  final _reviewsCtrl = TextEditingController();
  bool _active = true;
  bool _auto = true;
  bool _submitting = false;

  @override
  void dispose() {
    _idCtrl.dispose();
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _iconCtrl.dispose();
    _pointsCtrl.dispose();
    _streakCtrl.dispose();
    _quizPassCtrl.dispose();
    _tasksCtrl.dispose();
    _lessonsCtrl.dispose();
    _reviewsCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    try {
      final criteria = <String, int>{};
      int? parse(TextEditingController c) =>
          c.text.trim().isEmpty ? null : int.tryParse(c.text.trim());
      void put(String k, TextEditingController c) {
        final v = parse(c);
        if (v != null) criteria[k] = v;
      }

      put('pointsGte', _pointsCtrl);
      put('dailyStreakGte', _streakCtrl);
      put('quizzesPassedGte', _quizPassCtrl);
      put('tasksCompletedGte', _tasksCtrl);
      put('lessonsCompletedGte', _lessonsCtrl);
      put('reviewsWrittenGte', _reviewsCtrl);
      await FirebaseFirestore.instance
          .collection('badges')
          .doc(_idCtrl.text.trim())
          .set({
            'name': _nameCtrl.text.trim(),
            'description': _descCtrl.text.trim(),
            'iconUrl': _iconCtrl.text.trim(),
            'active': _active,
            'autoAward': _auto,
            'criteria': criteria,
          });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('تم إنشاء الشارة')));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('خطأ: $e')));
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء شارة جديدة')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _idCtrl,
                decoration: const InputDecoration(labelText: 'المعرف (فريد)'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'مطلوب';
                  return null;
                },
              ),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'الاسم'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'مطلوب';
                  return null;
                },
              ),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: 'الوصف'),
              ),
              TextFormField(
                controller: _iconCtrl,
                decoration: const InputDecoration(
                  labelText: 'رابط الأيقونة (اختياري)',
                ),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                value: _active,
                onChanged: (v) => setState(() => _active = v),
                title: const Text('مفعلة'),
              ),
              SwitchListTile(
                value: _auto,
                onChanged: (v) => setState(() => _auto = v),
                title: const Text('منح تلقائي'),
              ),
              const Divider(height: 32),
              const Text(
                'المعايير (اختيارية)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: 140,
                    child: TextField(
                      controller: _pointsCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'نقاط ≥'),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: TextField(
                      controller: _streakCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'سلسلة أيام ≥',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: TextField(
                      controller: _quizPassCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'اختبارات مجتازة ≥',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: TextField(
                      controller: _tasksCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'مهام منجزة ≥',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: TextField(
                      controller: _lessonsCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'دروس مكتملة ≥',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: TextField(
                      controller: _reviewsCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'مراجعات مكتوبة ≥',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _submitting
                  ? const Center(child: CircularProgressIndicator())
                  : FilledButton.icon(
                      onPressed: _save,
                      icon: const Icon(Icons.save),
                      label: const Text('حفظ'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
