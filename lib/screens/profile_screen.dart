import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // حزمة اختيار الصور
import 'package:firebase_storage/firebase_storage.dart'; // حزمة التخزين
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _currentUser = FirebaseAuth.instance.currentUser;
  bool _isLoading = false;

  // دالة لاختيار صورة ورفعها
  Future<void> _pickAndUploadImage() async {
    final imagePicker = ImagePicker();
    // 1. السماح للمستخدم باختيار صورة
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50, // ضغط الصورة لتقليل حجمها
      maxWidth: 150,    // تصغير أبعاد الصورة
    );

    if (pickedImage == null) {
      return; // المستخدم ألغى الاختيار
    }

    final selectedImageFile = File(pickedImage.path);

    setState(() {
      _isLoading = true;
    });

    try {
      // 2. إنشاء مسار فريد للصورة في Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${_currentUser!.uid}.jpg');

      // 3. رفع الملف إلى المسار المحدد
      await storageRef.putFile(selectedImageFile);

      // 4. الحصول على رابط التحميل الخاص بالصورة
      final imageUrl = await storageRef.getDownloadURL();

      // 5. تحديث مستند المستخدم في Firestore برابط الصورة
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser.uid)
          .update({'imageUrl': imageUrl});

    } catch (e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('حدث خطأ أثناء رفع الصورة: $e'))
        );
      }
    } finally {
      if(mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(_currentUser?.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('لم يتم العثور على بيانات المستخدم.'));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final userName = userData['name'] ?? 'لا يوجد اسم';
          final userEmail = userData['email'] ?? 'لا يوجد بريد';
          final imageUrl = userData['imageUrl'] as String?;

          return Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade300,
                      // عرض الصورة إذا كانت موجودة
                      backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
                      // عرض أيقونة إذا لم تكن هناك صورة
                      child: imageUrl == null
                          ? Icon(Icons.person, size: 60, color: Colors.grey.shade600)
                          : null,
                    ),
                    // عرض دائرة تحميل أثناء رفع الصورة
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                    // زر الكاميرا لاختيار صورة جديدة
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                          onPressed: _pickAndUploadImage,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(userName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(userEmail, style: const TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }
}