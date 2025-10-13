import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import '../core/result.dart';
import 'hybrid_storage_service.dart';

/// Service for uploading media files using HybridStorageService (Cloudinary/Spaces)
class MediaUploadService {
  final HybridStorageService _storage = HybridStorageService();
  final ImagePicker _picker = ImagePicker();

  /// Pick a single image from gallery
  Future<XFile?> pickImageFromGallery() async {
    try {
      return await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
    } catch (e) {
      return null;
    }
  }

  /// Pick multiple images from gallery (max 5)
  Future<List<XFile>> pickMultipleImages({int maxImages = 5}) async {
    try {
      final images = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      
      // Limit to max images
      if (images.length > maxImages) {
        return images.sublist(0, maxImages);
      }
      return images;
    } catch (e) {
      return [];
    }
  }

  /// Pick image from camera
  Future<XFile?> pickImageFromCamera() async {
    try {
      return await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
    } catch (e) {
      return null;
    }
  }

  /// Upload a single image using HybridStorageService (Cloudinary)
  /// Returns the download URL
  Future<Result<String>> uploadImage({
    required File imageFile,
    Function(double progress)? onProgress,
  }) async {
    try {
      // Validate image before upload
      final validation = await validateImage(imageFile);
      if (validation.isFailure) {
        return FailureResult(validation.failureOrNull!);
      }

      // Upload using HybridStorageService (will use Cloudinary for images)
      final uploadResult = await _storage.uploadFile(imageFile);
      
      // Simulate progress completion
      onProgress?.call(1.0);
      
      return Success(uploadResult.url);
    } catch (e) {
      return FailureResult(
        Failure.unknown('فشل رفع الصورة: $e'),
      );
    }
  }

  /// Upload multiple images using HybridStorageService
  /// Returns list of download URLs
  Future<Result<List<String>>> uploadMultipleImages({
    required List<File> imageFiles,
    Function(int completed, int total)? onProgress,
  }) async {
    try {
      final List<String> downloadUrls = [];
      
      for (int i = 0; i < imageFiles.length; i++) {
        final result = await uploadImage(
          imageFile: imageFiles[i],
        );
        
        result.when(
          success: (url) {
            downloadUrls.add(url);
            onProgress?.call(i + 1, imageFiles.length);
          },
          failure: (error) {
            // Continue with other images even if one fails
            onProgress?.call(i + 1, imageFiles.length);
          },
        );
      }
      
      if (downloadUrls.isEmpty) {
        return FailureResult(
          Failure.unknown('فشل رفع جميع الصور'),
        );
      }
      
      return Success(downloadUrls);
    } catch (e) {
      return FailureResult(
        Failure.unknown('خطأ في رفع الصور: $e'),
      );
    }
  }

  /// Delete image from storage (if supported by backend)
  Future<Result<void>> deleteImage(String imageUrl) async {
    try {
      // Note: Cloudinary/Spaces deletion requires backend API
      // This is a placeholder for future implementation
      return const Success(null);
    } catch (e) {
      return FailureResult(
        Failure.unknown('خطأ في حذف الصورة: $e'),
      );
    }
  }

  /// Delete multiple images from storage
  Future<Result<void>> deleteMultipleImages(List<String> imageUrls) async {
    try {
      // Note: Batch deletion requires backend API implementation
      for (final url in imageUrls) {
        await deleteImage(url);
      }
      return const Success(null);
    } catch (e) {
      return FailureResult(
        Failure.unknown('خطأ في حذف الصور: $e'),
      );
    }
  }

  /// Get file size in MB
  Future<double> getFileSizeMB(File file) async {
    final bytes = await file.length();
    return bytes / (1024 * 1024);
  }

  /// Validate image file
  /// Returns true if valid, false otherwise
  Future<Result<bool>> validateImage(File imageFile) async {
    try {
      // Check file exists
      if (!await imageFile.exists()) {
        return FailureResult(
          Failure.validation('الملف غير موجود'),
        );
      }

      // Check file size (max 10MB)
      final sizeMB = await getFileSizeMB(imageFile);
      if (sizeMB > 10) {
        return FailureResult(
          Failure.validation('حجم الصورة كبير جداً (الحد الأقصى 10 ميجابايت)'),
        );
      }

      // Check file extension
      final ext = path.extension(imageFile.path).toLowerCase();
      if (!['.jpg', '.jpeg', '.png', '.gif', '.webp'].contains(ext)) {
        return FailureResult(
          Failure.validation('صيغة الصورة غير مدعومة'),
        );
      }

      return const Success(true);
    } catch (e) {
      return FailureResult(
        Failure.unknown('خطأ في التحقق من الصورة: $e'),
      );
    }
  }

  /// Validate multiple images
  Future<Result<bool>> validateMultipleImages(List<File> imageFiles) async {
    for (final file in imageFiles) {
      final result = await validateImage(file);
      if (result.isFailure) {
        return result;
      }
    }
    return const Success(true);
  }
}
