import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/core/l10n_ext.dart';

class BulkImportScreen extends ConsumerStatefulWidget {
  const BulkImportScreen({super.key});

  @override
  ConsumerState<BulkImportScreen> createState() => _BulkImportScreenState();
}

class _BulkImportScreenState extends ConsumerState<BulkImportScreen> {
  String _log = '';
  bool _busy = false;

  void _append(String s) => setState(() => _log += '$s\n');

  Future<void> _pickAndImport() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result == null || result.files.isEmpty) return;
    final file = result.files.single;
    final bytes = file.bytes ?? await File(file.path!).readAsBytes();
    final content = utf8.decode(bytes);
    await _importCsv(content);
  }

  Future<void> _importCsv(String csv) async {
    setState(() => _busy = true);
    try {
      final lines = const LineSplitter()
          .convert(csv)
          .where((l) => l.trim().isNotEmpty)
          .toList();
      if (lines.isEmpty) {
        _append('Empty CSV');
        return;
      }
      // Header: collection,docId,field.path,value (JSON if complex)
      final header = lines.first.split(',').map((e) => e.trim()).toList();
      if (header.length < 4 ||
          header[0] != 'collection' ||
          header[1] != 'docId' ||
          header[2] != 'field.path' ||
          header[3] != 'value') {
        _append('Invalid header. Expected: collection,docId,field.path,value');
        return;
      }
      final db = FirebaseFirestore.instance;
      // We'll create batches on-demand when flushing pendingDocs
      int op = 0;
      Map<String, Map<String, dynamic>> pendingDocs = {};
      for (int i = 1; i < lines.length; i++) {
        final cols = _safeSplitCsvLine(lines[i]);
        if (cols.length < 4) {
          _append('Skip line ${i + 1}: insufficient columns');
          continue;
        }
        final collection = cols[0];
        final docId = cols[1];
        final fieldPath = cols[2];
        final valueRaw = cols
            .sublist(3)
            .join(','); // support commas in JSON values
        dynamic value;
        // Try parse JSON; fallback to raw string, try int/double/bool
        value = _tryParseJson(valueRaw.trim());
        value ??= _tryParsePrimitive(valueRaw.trim());
        final key = '$collection/$docId';
        final map = pendingDocs.putIfAbsent(key, () => {});
        _assignNested(map, fieldPath.split('.'), value);
        op++;
        if (op % 200 == 0) {
          final batch = db.batch();
          pendingDocs.forEach((k, data) {
            final parts = k.split('/');
            final ref = db.collection(parts[0]).doc(parts[1]);
            batch.set(ref, data, SetOptions(merge: true));
          });
          await batch.commit();
          _append('Committed ${pendingDocs.length} docs');
          pendingDocs.clear();
        }
      }
      if (pendingDocs.isNotEmpty) {
        final batch2 = db.batch();
        pendingDocs.forEach((k, data) {
          final parts = k.split('/');
          final ref = db.collection(parts[0]).doc(parts[1]);
          batch2.set(ref, data, SetOptions(merge: true));
        });
        await batch2.commit();
        _append('Committed ${pendingDocs.length} docs');
      }
      _append('Import complete');
    } catch (e) {
      _append('Error: $e');
    } finally {
      setState(() => _busy = false);
    }
  }

  List<String> _safeSplitCsvLine(String line) {
    final List<String> parts = [];
    final sb = StringBuffer();
    bool inQuotes = false;
    for (int i = 0; i < line.length; i++) {
      final ch = line[i];
      if (ch == '"') {
        inQuotes = !inQuotes;
      } else if (ch == ',' && !inQuotes) {
        parts.add(sb.toString());
        sb.clear();
      } else {
        sb.write(ch);
      }
    }
    parts.add(sb.toString());
    return parts.map((e) => e.trim()).toList();
  }

  dynamic _tryParseJson(String s) {
    if (!(s.startsWith('{') || s.startsWith('['))) return null;
    try {
      return jsonDecode(s);
    } catch (_) {
      return null;
    }
  }

  dynamic _tryParsePrimitive(String s) {
    if (s.toLowerCase() == 'true') return true;
    if (s.toLowerCase() == 'false') return false;
    final i = int.tryParse(s);
    if (i != null) return i;
    final d = double.tryParse(s);
    if (d != null) return d;
    return s;
  }

  void _assignNested(
    Map<String, dynamic> map,
    List<String> path,
    dynamic value,
  ) {
    Map<String, dynamic> cur = map;
    for (int i = 0; i < path.length; i++) {
      final key = path[i];
      final last = i == path.length - 1;
      if (last) {
        cur[key] = value;
      } else {
        cur = (cur[key] ??= <String, dynamic>{}) as Map<String, dynamic>;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.bulkImportTitle)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Builder(builder: (context) => Text(context.l.bulkImportCsvFormat)),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _busy ? null : _pickAndImport,
                  icon: const Icon(Icons.upload_file),
                  label: Builder(builder: (context) => Text(context.l.bulkImportPickCsv)),
                ),
                const SizedBox(width: 12),
                if (_busy) const CircularProgressIndicator(),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(child: Text(_log)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
