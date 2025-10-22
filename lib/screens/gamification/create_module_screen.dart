import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/design/tokens.dart';
import '../../core/ui/snackbar_helper.dart';
import '../../widgets/widgets.dart';
import '../../providers/gamification/module_providers.dart';

/// شاشة إنشاء وحدة تعليمية جديدة
class CreateModuleScreen extends ConsumerStatefulWidget {
  final String courseId;

  const CreateModuleScreen({
    super.key,
    required this.courseId,
  });

  @override
  ConsumerState<CreateModuleScreen> createState() => _CreateModuleScreenState();
}

class _CreateModuleScreenState extends ConsumerState<CreateModuleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _orderIndexController = TextEditingController(text: '1');
  
  bool _isActive = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _orderIndexController.dispose();
    super.dispose();
  }

  Future<void> _saveModule() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final orderIndex = int.parse(_orderIndexController.text);
      
      // Create module document
      final moduleRef = FirebaseFirestore.instance
          .collection('learning_modules')
          .doc();

      await moduleRef.set({
        'courseId': widget.courseId,
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'orderIndex': orderIndex,
        'contents': [], // Empty initially, can be added later
        'isActive': _isActive,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      // Invalidate the modules provider to refresh the list
      ref.invalidate(courseModulesProvider(widget.courseId));

      AppSnackBar.show(
        context,
        'Module "${_titleController.text}" created successfully!',
        isError: false,
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      AppSnackBar.show(
        context,
        'Failed to create module: $e',
        isError: true,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Learning Module'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Help',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Module Guidelines'),
                  content: const Text(
                    '• Title: Clear, descriptive name (e.g., "Introduction to Python")\n'
                    '• Description: Brief overview of module content\n'
                    '• Order Index: Determines module sequence (1, 2, 3...)\n'
                    '• Active: Only active modules are visible to students',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Got it'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(DesignTokens.spacingLg),
          children: [
            // Header Info Card
            AppCard(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(DesignTokens.spacingMd),
                    decoration: BoxDecoration(
                      color: DesignTokens.info.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                    ),
                    child: Icon(
                      Icons.school,
                      color: DesignTokens.info,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: DesignTokens.spacingMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Learning Module',
                          style: DesignTokens.h4(context).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: DesignTokens.spacingXs),
                        Text(
                          'Organize course content into structured modules',
                          style: DesignTokens.body2(context).copyWith(
                            color: DesignTokens.textSecondary(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: DesignTokens.spacingXl),

            // Module Title
            Text(
              'Module Title *',
              style: DesignTokens.body1(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: DesignTokens.spacingSm),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'e.g., Introduction to Programming',
                prefixIcon: const Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                ),
                filled: true,
                fillColor: DesignTokens.fillColor(context),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a module title';
                }
                if (value.trim().length < 3) {
                  return 'Title must be at least 3 characters';
                }
                return null;
              },
              textCapitalization: TextCapitalization.words,
            ),

            SizedBox(height: DesignTokens.spacingLg),

            // Module Description
            Text(
              'Description *',
              style: DesignTokens.body1(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: DesignTokens.spacingSm),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Brief overview of module content...',
                prefixIcon: const Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                ),
                filled: true,
                fillColor: DesignTokens.fillColor(context),
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a description';
                }
                if (value.trim().length < 10) {
                  return 'Description must be at least 10 characters';
                }
                return null;
              },
              textCapitalization: TextCapitalization.sentences,
            ),

            SizedBox(height: DesignTokens.spacingLg),

            // Order Index
            Text(
              'Order Index *',
              style: DesignTokens.body1(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: DesignTokens.spacingSm),
            TextFormField(
              controller: _orderIndexController,
              decoration: InputDecoration(
                hintText: '1',
                prefixIcon: const Icon(Icons.format_list_numbered),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                ),
                filled: true,
                fillColor: DesignTokens.fillColor(context),
                helperText: 'Determines the order of modules (1, 2, 3...)',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an order index';
                }
                final number = int.tryParse(value);
                if (number == null || number < 1) {
                  return 'Order index must be a positive number';
                }
                return null;
              },
            ),

            SizedBox(height: DesignTokens.spacingLg),

            // Active Status
            AppCard(
              child: SwitchListTile(
                title: Text(
                  'Active Module',
                  style: DesignTokens.body1(context).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  _isActive
                      ? 'Module is visible to students'
                      : 'Module is hidden from students',
                  style: DesignTokens.body2(context).copyWith(
                    color: DesignTokens.textSecondary(context),
                  ),
                ),
                value: _isActive,
                onChanged: (value) => setState(() => _isActive = value),
                activeColor: DesignTokens.success,
              ),
            ),

            SizedBox(height: DesignTokens.spacingXl),

            // Save Button
            ElevatedButton(
              onPressed: _isLoading ? null : _saveModule,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: DesignTokens.spacingLg),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                ),
              ),
              child: _isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle),
                        SizedBox(width: DesignTokens.spacingSm),
                        const Text(
                          'Create Module',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
            ),

            SizedBox(height: DesignTokens.spacingMd),

            // Cancel Button
            OutlinedButton(
              onPressed: _isLoading ? null : () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: DesignTokens.spacingLg),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
