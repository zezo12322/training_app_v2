import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
import 'package:training_app/services/notification_service.dart'; // notification service
import 'package:url_launcher/url_launcher.dart';
import 'package:training_app/services/hybrid_storage_service.dart';

class ResourceLibraryScreen extends StatefulWidget {
  final String courseId;
  final bool isTrainer;

  const ResourceLibraryScreen({
    super.key,
    required this.courseId,
    required this.isTrainer,
  });

  @override
  State<ResourceLibraryScreen> createState() => _ResourceLibraryScreenState();
}

class _ResourceLibraryScreenState extends State<ResourceLibraryScreen> {
  bool _isLoading = false;

  Future<void> _pickAndUploadFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    final file = File(result.files.single.path!);
    final fileName = result.files.single.name;
    setState(() {
      _isLoading = true;
    });
    try {
      final hybrid = HybridStorageService();
      final uploadResult = await hybrid.uploadFile(file);
      final downloadUrl = uploadResult.url;
      await FirebaseFirestore.instance.collection('course_resources').add({
        'courseId': widget.courseId,
        'fileName': fileName,
        'fileUrl': downloadUrl,
        'uploadedAt': FieldValue.serverTimestamp(),
        'storageProvider': 'hybrid',
      });

      // --- إرسال الإشعار بعد الرفع بنجاح ---
      await _sendNewResourceNotification(fileName);
    } catch (e) {
      if (mounted) AppSnackBar.show(context, 'فشل رفع الملف: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _sendNewResourceNotification(String fileName) async {
    final courseDoc = await FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseId)
        .get();
    if (!courseDoc.exists) return;
    final courseName = courseDoc.data()?['name'] ?? 'كورس';
    final trainees = List<String>.from(courseDoc.data()?['trainees'] ?? []);
    if (trainees.isEmpty) return;

    await OneSignalNotificationService().sendNotificationViaBackend(
      userIds: trainees,
      title: 'ملف جديد في: $courseName',
      content: 'تمت إضافة ملف جديد بعنوان: $fileName',
    );
  }

  Future<void> _openFile(String fileUrl) async {
    final Uri url = Uri.parse(fileUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if (mounted) AppSnackBar.show(context, 'لا يمكن فتح هذا الملف: $fileUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مكتبة الموارد')),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 150));
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('course_resources')
              .where('courseId', isEqualTo: widget.courseId)
              .orderBy('uploadedAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'حدث خطأ. تأكد من إنشاء الفهرس المطلوب.\n\n${snapshot.error}',
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 120),
                  Center(child: Text('لا توجد ملفات في المكتبة بعد.')),
                ],
              );
            }

            final resources = snapshot.data!.docs;

            return ListView.builder(
              itemCount: resources.length,
              itemBuilder: (context, index) {
                final resource = resources[index];
                final fileUrl = resource['fileUrl'] as String;
                final fileName = resource['fileName'] as String;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.insert_drive_file,
                      color: Colors.blueGrey,
                    ),
                    title: Text(fileName),
                    trailing: const Icon(Icons.download_for_offline_outlined),
                    // --- تم تفعيل الزر هنا ---
                    onTap: () {
                      _openFile(fileUrl);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: widget.isTrainer
          ? FloatingActionButton.extended(
              heroTag: 'resource_library_fab', // unique tag
              onPressed: _isLoading ? null : _pickAndUploadFile,
              label: _isLoading
                  ? const Text('جار الرفع...')
                  : const Text('رفع ملف'),
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.0,
                      ),
                    )
                  : const Icon(Icons.upload_file),
            )
          : null,
    );
  }
}
