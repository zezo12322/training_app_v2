import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/hris_import.dart';
import '../models/user_model.dart';
import '../providers/hris_import_providers.dart';
import '../providers/user_providers.dart';
import '../core/logging.dart';
import '../core/l10n_ext.dart';

/// شاشة استيراد HRIS
class HRISImportScreen extends ConsumerStatefulWidget {
  const HRISImportScreen({super.key});

  @override
  ConsumerState<HRISImportScreen> createState() => _HRISImportScreenState();
}

class _HRISImportScreenState extends ConsumerState<HRISImportScreen> {
  File? _selectedFile;
  ImportFileType? _fileType;
  List<List<String>>? _fileData;
  List<String>? _headers;
  FieldMapping? _fieldMapping;
  List<ImportedUserRecord>? _previewRecords;
  String? _templateName;
  bool _saveAsTemplate = false;
  bool _isLoading = false;
  bool _updateExisting = true;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final user = ref.watch(currentUserProvider).value;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l.hrisImportTitle),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _fileData == null
              ? _buildFilePicker(user, context)
              : _fieldMapping == null
                  ? _buildColumnMapping(context)
                  : _buildPreview(context),
    );
  }

  /// اختيار الملف
  Widget _buildFilePicker(AppUser? user, BuildContext context) {
    final l = context.l;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.upload_file, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          Text(
            l.hrisImportChooseFile,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: _pickFile,
            icon: const Icon(Icons.folder_open),
            label: Text(l.hrisImportSelectFile),
          ),
          const SizedBox(height: 20),
          if (user != null)
            TextButton.icon(
              onPressed: () => _loadTemplate(user.institutionId ?? ''),
              icon: const Icon(Icons.bookmark),
              label: Text(l.hrisImportLoadTemplate),
            ),
        ],
      ),
    );
  }

  /// اختيار ملف
  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv', 'xlsx', 'xls'],
      );

      if (result == null) return;

      setState(() => _isLoading = true);

      final file = File(result.files.single.path!);
      final extension = result.files.single.extension?.toLowerCase();

      ImportFileType fileType;
      if (extension == 'csv') {
        fileType = ImportFileType.csv;
      } else if (extension == 'xlsx' || extension == 'xls') {
        fileType = ImportFileType.excel;
      } else {
        throw Exception(context.l.hrisImportUnsupportedFile);
      }

      // قراءة الملف
      final service = ref.read(hrisImportServiceProvider);
      List<List<String>> data;
      
      if (fileType == ImportFileType.csv) {
        data = await service.parseCSV(file);
      } else {
        data = await service.parseExcel(file);
      }

      if (data.isEmpty || data.length < 2) {
        throw Exception(context.l.hrisImportEmptyFile);
      }

      setState(() {
        _selectedFile = file;
        _fileType = fileType;
        _fileData = data;
        _headers = data.first;
        _isLoading = false;
      });
    } catch (e) {
      logger.e('Error picking file', error: e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.hrisImportError(e.toString()))),
        );
      }
      setState(() => _isLoading = false);
    }
  }

  /// تعيين الأعمدة
  Widget _buildColumnMapping(BuildContext context) {
    final l = context.l;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l.hrisImportMapColumns,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildColumnDropdown(
            l.hrisImportEmailRequired,
            (value) => setState(() {
              _fieldMapping = FieldMapping(
                emailColumn: value!,
                nameColumn: _fieldMapping?.nameColumn ?? '',
              );
            }),
          ),
          const SizedBox(height: 12),
          _buildColumnDropdown(
            l.hrisImportNameRequired,
            (value) => setState(() {
              _fieldMapping = FieldMapping(
                emailColumn: _fieldMapping?.emailColumn ?? '',
                nameColumn: value!,
              );
            }),
          ),
          const SizedBox(height: 12),
          _buildColumnDropdown(
            l.hrisImportRoleOptional,
            (value) => setState(() {
              _fieldMapping = _fieldMapping?.copyWith(roleColumn: value);
            }),
            required: false,
          ),
          const SizedBox(height: 12),
          _buildColumnDropdown(
            l.hrisImportPhoneOptional,
            (value) => setState(() {
              _fieldMapping = _fieldMapping?.copyWith(phoneColumn: value);
            }),
            required: false,
          ),
          const SizedBox(height: 12),
          _buildColumnDropdown(
            l.hrisImportDepartmentOptional,
            (value) => setState(() {
              _fieldMapping = _fieldMapping?.copyWith(departmentColumn: value);
            }),
            required: false,
          ),
          const SizedBox(height: 12),
          _buildColumnDropdown(
            l.hrisImportJobTitleOptional,
            (value) => setState(() {
              _fieldMapping = _fieldMapping?.copyWith(jobTitleColumn: value);
            }),
            required: false,
          ),
          const SizedBox(height: 20),
          CheckboxListTile(
            title: Text(l.hrisImportSaveAsTemplate),
            value: _saveAsTemplate,
            onChanged: (value) => setState(() => _saveAsTemplate = value!),
          ),
          if (_saveAsTemplate)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  labelText: l.hrisImportTemplateName,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) => _templateName = value,
              ),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _canPreview() ? _previewImport : null,
            child: Text(l.hrisImportPreviewButton),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () => setState(() {
              _fileData = null;
              _headers = null;
              _fieldMapping = null;
            }),
            child: Text(l.hrisImportBackButton),
          ),
        ],
      ),
    );
  }

  /// قائمة اختيار عمود
  Widget _buildColumnDropdown(
    String label,
    void Function(String?) onChanged, {
    bool required = true,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: [
        if (!required)
          DropdownMenuItem(
            value: null,
            child: Text(context.l.hrisImportNone),
          ),
        ..._headers!.map((header) {
          return DropdownMenuItem(
            value: header,
            child: Text(header),
          );
        }),
      ],
      onChanged: onChanged,
    );
  }

  /// هل يمكن المعاينة
  bool _canPreview() {
    return _fieldMapping != null &&
        _fieldMapping!.emailColumn.isNotEmpty &&
        _fieldMapping!.nameColumn.isNotEmpty;
  }

  /// معاينة الاستيراد
  Future<void> _previewImport() async {
    setState(() => _isLoading = true);

    try {
      final service = ref.read(hrisImportServiceProvider);
      final records = service.extractUserRecords(
        data: _fileData!,
        fieldMapping: _fieldMapping!,
      );

      setState(() {
        _previewRecords = records;
        _isLoading = false;
      });
    } catch (e) {
      logger.e('Error previewing import', error: e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.hrisImportError(e.toString()))),
        );
      }
      setState(() => _isLoading = false);
    }
  }

  /// معاينة السجلات
  Widget _buildPreview(BuildContext context) {
    final l = context.l;
    final validCount = _previewRecords!.where((r) => r.isValid).length;
    final invalidCount = _previewRecords!.length - validCount;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l.hrisImportPreviewTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatChip(l.hrisImportTotal, _previewRecords!.length),
                      _buildStatChip(l.hrisImportValid, validCount, Colors.green),
                      _buildStatChip(l.hrisImportInvalid, invalidCount, Colors.red),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: Text(l.hrisImportUpdateExisting),
                    value: _updateExisting,
                    onChanged: (value) => setState(() => _updateExisting = value),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(l.hrisImportSampleRecords, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ..._previewRecords!.take(5).map((record) {
            return Card(
              color: record.isValid ? null : Colors.red.shade50,
              child: ListTile(
                leading: Icon(
                  record.isValid ? Icons.check_circle : Icons.error,
                  color: record.isValid ? Colors.green : Colors.red,
                ),
                title: Text(record.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(record.email),
                    if (!record.isValid)
                      Text(
                        record.validationErrors.join(', '),
                        style: const TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: validCount > 0 ? _startImport : null,
            child: Text(l.hrisImportStartButton),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () => setState(() {
              _previewRecords = null;
              _fieldMapping = null;
            }),
            child: Text(l.hrisImportBackButton),
          ),
        ],
      ),
    );
  }

  /// رقاقة إحصائية
  Widget _buildStatChip(String label, int value, [Color? color]) {
    return Chip(
      label: Text('$label: $value'),
      backgroundColor: color?.withOpacity(0.2),
    );
  }

  /// بدء الاستيراد
  Future<void> _startImport() async {
    final user = ref.read(currentUserProvider).value;
    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      final service = ref.read(hrisImportServiceProvider);
      final importId = FirebaseFirestore.instance.collection('hris_imports').doc().id;

      // إنشاء سجل استيراد
      final hrisImport = HRISImport(
        id: importId,
        fileType: _fileType!,
        fileName: _selectedFile!.path.split('/').last,
        status: ImportStatus.pending,
        totalRows: _previewRecords!.length,
        processedRows: 0,
        successfulRows: 0,
        failedRows: 0,
        uploadedBy: user.id,
        uploaderName: user.name,
        uploadedAt: DateTime.now(),
        institutionId: user.institutionId ?? '',
        companyId: user.companyId,
        fieldMapping: _fieldMapping!,
        updateExistingUsers: _updateExisting,
      );

      await FirebaseFirestore.instance
          .collection('hris_imports')
          .doc(importId)
          .set(hrisImport.toJson());

      // حفظ القالب إذا لزم الأمر
      if (_saveAsTemplate && _templateName != null && _templateName!.isNotEmpty) {
        final template = ImportTemplate(
          id: FirebaseFirestore.instance.collection('import_templates').doc().id,
          name: _templateName!,
          fieldMapping: _fieldMapping!,
          institutionId: user.institutionId ?? '',
          companyId: user.companyId,
          createdBy: user.id,
          createdAt: DateTime.now(),
        );
        await service.saveTemplate(template);
      }

      // بدء الاستيراد
      await service.importUsers(
        importId: importId,
        records: _previewRecords!,
        institutionId: user.institutionId ?? '',
        companyId: user.companyId,
        defaultRole: 'trainee',
        updateExisting: _updateExisting,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.hrisImportSuccess)),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      logger.e('Error importing users', error: e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.hrisImportError(e.toString()))),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// تحميل قالب
  Future<void> _loadTemplate(String institutionId) async {
    try {
      final templates = await ref.read(importTemplatesProvider(institutionId).future);
      
      if (!mounted) return;
      
      if (templates.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.hrisImportNoTemplates)),
        );
        return;
      }

      // عرض قائمة القوالب
      final selected = await showDialog<ImportTemplate>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(context.l.hrisImportChooseTemplate),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: templates.length,
                itemBuilder: (context, index) {
                  final template = templates[index];
                  return ListTile(
                    title: Text(template.name),
                    subtitle: template.description != null
                        ? Text(template.description!)
                        : null,
                    onTap: () => Navigator.pop(context, template),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(context.l.hrisImportCancel),
              ),
            ],
          );
        },
      );

      if (selected != null) {
        setState(() {
          _fieldMapping = selected.fieldMapping;
        });
      }
    } catch (e) {
      logger.e('Error loading template', error: e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.hrisImportError(e.toString()))),
        );
      }
    }
  }
}
