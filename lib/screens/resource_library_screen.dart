import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/core/ui/snackbar_helper.dart';
import 'package:training_app/services/notification_service.dart'; // notification service
import 'package:url_launcher/url_launcher.dart';
import 'package:training_app/services/hybrid_storage_service.dart';
import '../core/l10n_ext.dart';

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
      if (mounted) AppSnackBar.show(context, context.l.resourceLibraryUploadFailed(e.toString()));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _sendNewResourceNotification(String fileName) async {
    final l = context.l;
    final courseDoc = await FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseId)
        .get();
    if (!courseDoc.exists) return;
    final courseName = courseDoc.data()?['name'] ?? l.resourceLibraryDefaultCourseName;
    final trainees = List<String>.from(courseDoc.data()?['trainees'] ?? []);
    if (trainees.isEmpty) return;

    await OneSignalNotificationService().sendNotificationViaBackend(
      userIds: trainees,
      title: l.resourceLibraryNotificationTitle(courseName),
      content: l.resourceLibraryNotificationContent(fileName),
    );
  }

  Future<void> _openFile(String fileUrl) async {
    final Uri url = Uri.parse(fileUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if (mounted) AppSnackBar.show(context, context.l.resourceLibraryCannotOpen(fileUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Scaffold(
      appBar: AppBar(title: Text(l.resourceLibraryTitle)),
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
                  l.resourceLibraryError(snapshot.error.toString()),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 120),
                  Center(child: Text(l.resourceLibraryEmpty)),
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
                  ? Text(l.resourceLibraryUploading)
                  : Text(l.resourceLibraryUploadButton),
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
