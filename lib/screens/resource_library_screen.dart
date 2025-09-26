import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/services/notification_service.dart'; // <<< استيراد
import 'package:url_launcher/url_launcher.dart';

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
    setState(() { _isLoading = true; });
    try {
      final storageRef = FirebaseStorage.instance.ref().child('course_resources').child(widget.courseId).child(fileName);
      await storageRef.putFile(file);
      final downloadUrl = await storageRef.getDownloadURL();
      await FirebaseFirestore.instance.collection('course_resources').add({
        'courseId': widget.courseId, 'fileName': fileName, 'fileUrl': downloadUrl,
        'uploadedAt': FieldValue.serverTimestamp(),
      });

      // --- إرسال الإشعار بعد الرفع بنجاح ---
      await _sendNewResourceNotification(fileName);

    } catch (e) {
      if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل رفع الملف: $e')));
    } finally {
      if(mounted) setState(() { _isLoading = false; });
    }
  }

  Future<void> _sendNewResourceNotification(String fileName) async {
    final courseDoc = await FirebaseFirestore.instance.collection('courses').doc(widget.courseId).get();
    if (!courseDoc.exists) return;
    final courseName = courseDoc.data()?['name'] ?? 'كورس';
    final trainees = List<String>.from(courseDoc.data()?['trainees'] ?? []);
    if (trainees.isEmpty) return;

    final tokensSnapshot = await FirebaseFirestore.instance.collection('users').where(FieldPath.documentId, whereIn: trainees).get();
    final List<String> playerIds = tokensSnapshot.docs
        .map((doc) => doc.data()['oneSignalPlayerId'] as String?)
        .where((id) => id != null).toList().cast<String>();

    await OneSignalNotificationService().sendNotification(
      playerIds: playerIds,
      title: 'ملف جديد في: $courseName',
      content: 'تمت إضافة ملف جديد بعنوان: $fileName',
    );
  }

  Future<void> _openFile(String fileUrl) async {
    final Uri url = Uri.parse(fileUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('لا يمكن فتح هذا الملف: $fileUrl')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مكتبة الموارد'),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
            return Center(child: Text('حدث خطأ. تأكد من إنشاء الفهرس المطلوب.\n\n${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('لا توجد ملفات في المكتبة بعد.'));
          }

          final resources = snapshot.data!.docs;

          return ListView.builder(
            itemCount: resources.length,
            itemBuilder: (context, index) {
              final resource = resources[index];
              final fileUrl = resource['fileUrl'] as String;
              final fileName = resource['fileName'] as String;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: const Icon(Icons.insert_drive_file, color: Colors.blueGrey),
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
      floatingActionButton: widget.isTrainer
          ? FloatingActionButton.extended(
        onPressed: _isLoading ? null : _pickAndUploadFile,
        label: _isLoading ? const Text('جار الرفع...') : const Text('رفع ملف'),
        icon: _isLoading
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.0))
            : const Icon(Icons.upload_file),
      )
          : null,
    );
  }
}