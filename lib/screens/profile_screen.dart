import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/auth_provider.dart';
import '../core/logging.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isUploading = false;

  Future<void> _pickAndUploadImage(String uid) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 55, maxWidth: 180);
    if (picked == null) return;
    setState(() { _isUploading = true; });
    try {
      final file = File(picked.path);
      final storageRef = FirebaseStorage.instance.ref().child('user_images').child('$uid.jpg');
      await storageRef.putFile(file);
      final url = await storageRef.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(uid).update({'imageUrl': url});
      // Refresh provider after update
      ref.invalidate(currentUserModelProvider);
    } catch (e, st) {
      logger.e('Failed to upload profile image', error: e, stackTrace: st);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطأ في رفع الصورة: $e')));
      }
    } finally {
      if (mounted) setState(() { _isUploading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final userModelAsync = ref.watch(currentUserModelProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي')),
      body: authState.when(
        data: (firebaseUser) {
          if (firebaseUser == null) {
            return const Center(child: Text('يجب تسجيل الدخول'));
          }
          return userModelAsync.when(
            data: (appUser) {
              if (appUser == null) {
                return const Center(child: Text('لا توجد بيانات مستخدم')); 
              }
              final imageUrl = appUser.imageUrl; // قد تكون null
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
                          backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
                          child: imageUrl == null ? Icon(Icons.person, size: 60, color: Colors.grey.shade600) : null,
                        ),
                        if (_isUploading)
                          const CircularProgressIndicator()
                        else
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                              onPressed: () => _pickAndUploadImage(appUser.id),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(appUser.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(appUser.email, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 12),
                    Chip(label: Text(appUser.role == 'trainer' ? 'مدرب' : 'متدرب')),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('خطأ: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('خطأ بالمصادقة: $e')),
      ),
    );
  }
}