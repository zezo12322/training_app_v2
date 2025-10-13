import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../services/media_upload_service.dart';
import '../providers/wall_post_providers.dart';
import '../providers/auth_provider.dart';

class AddPostDialog extends ConsumerStatefulWidget {
  final String courseId;
  final String courseName;

  const AddPostDialog({
    super.key,
    required this.courseId,
    required this.courseName,
  });

  @override
  ConsumerState<AddPostDialog> createState() => _AddPostDialogState();
}

class _AddPostDialogState extends ConsumerState<AddPostDialog> {
  final TextEditingController _contentController = TextEditingController();
  final MediaUploadService _mediaService = MediaUploadService();
  final List<XFile> _selectedImages = [];
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final images = await _mediaService.pickMultipleImages(maxImages: 5);
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages.clear();
        _selectedImages.addAll(images);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final image = await _mediaService.pickImageFromCamera();
    if (image != null) {
      setState(() {
        _selectedImages.clear();
        _selectedImages.add(image);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Future<void> _submitPost() async {
    final content = _contentController.text.trim();
    if (content.isEmpty && _selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى كتابة محتوى أو إضافة صورة')),
      );
      return;
    }

    final authUser = ref.read(authStateProvider).value;
    if (authUser == null) return;

    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    try {
      // Upload images first if any
      List<String> imageUrls = [];
      if (_selectedImages.isNotEmpty) {
        final imageFiles = _selectedImages.map((xFile) => File(xFile.path)).toList();
        
        // Validate images
        final validationResult = await _mediaService.validateMultipleImages(imageFiles);
        if (validationResult.isFailure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(validationResult.failureOrNull!.message)),
            );
          }
          setState(() => _isUploading = false);
          return;
        }

        // Upload images
        final uploadResult = await _mediaService.uploadMultipleImages(
          imageFiles: imageFiles,
          onProgress: (completed, total) {
            setState(() {
              _uploadProgress = completed / total;
            });
          },
        );

        uploadResult.when(
          success: (urls) {
            imageUrls = urls;
          },
          failure: (error) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('خطأ في رفع الصور: ${error.message}')),
              );
            }
            setState(() => _isUploading = false);
            return;
          },
        );
      }

      // Create post
      final result = await ref.read(addPostProvider)(
        courseId: widget.courseId,
        content: content,
        authorId: authUser.uid,
        authorEmail: authUser.email ?? '',
        authorName: authUser.displayName,
        imageUrls: imageUrls,
      );

      result.when(
        success: (_) {
          if (mounted) {
            Navigator.pop(context, true);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم نشر المنشور بنجاح')),
            );
          }
        },
        failure: (error) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('خطأ: ${error.message}')),
            );
          }
        },
      );
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.create,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'منشور جديد',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text input
                    TextField(
                      controller: _contentController,
                      maxLines: 6,
                      maxLength: 5000,
                      decoration: const InputDecoration(
                        hintText: 'ماذا تريد أن تشارك؟',
                        border: OutlineInputBorder(),
                        counterText: '',
                      ),
                      enabled: !_isUploading,
                    ),
                    const SizedBox(height: 8),
                    
                    // Character counter
                    Text(
                      '${_contentController.text.length}/5000',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Image picker buttons
                    if (!_isUploading) ...[
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _pickImages,
                              icon: const Icon(Icons.photo_library),
                              label: const Text('اختيار صور'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _pickImageFromCamera,
                              icon: const Icon(Icons.camera_alt),
                              label: const Text('التقاط صورة'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Selected images preview
                    if (_selectedImages.isNotEmpty) ...[
                      Text(
                        'الصور المحددة (${_selectedImages.length}/5):',
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _selectedImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(_selectedImages[index].path),
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  if (!_isUploading)
                                    Positioned(
                                      top: 4,
                                      left: 4,
                                      child: CircleAvatar(
                                        radius: 14,
                                        backgroundColor: Colors.black54,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.close,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          onPressed: () => _removeImage(index),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Upload progress
                    if (_isUploading) ...[
                      const SizedBox(height: 16),
                      LinearProgressIndicator(value: _uploadProgress),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          _uploadProgress < 1
                              ? 'جاري رفع الصور... ${(_uploadProgress * 100).toInt()}%'
                              : 'جاري نشر المنشور...',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Footer buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isUploading ? null : () => Navigator.pop(context),
                    child: const Text('إلغاء'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: _isUploading ? null : _submitPost,
                    icon: _isUploading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send),
                    label: Text(_isUploading ? 'جاري النشر...' : 'نشر'),
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
