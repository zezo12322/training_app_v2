import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import '../core/logging.dart';

/// خدمة رفع الملفات والصور
class FileUploadService {
  final FirebaseStorage _storage;
  final ImagePicker _imagePicker;

  FileUploadService({
    FirebaseStorage? storage,
    ImagePicker? imagePicker,
  })  : _storage = storage ?? FirebaseStorage.instance,
        _imagePicker = imagePicker ?? ImagePicker();

  /// اختيار صورة من المعرض
  Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      return image;
    } catch (e) {
      logger.e('Error picking image from gallery', error: e);
      return null;
    }
  }

  /// التقاط صورة من الكاميرا
  Future<XFile?> pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      return image;
    } catch (e) {
      logger.e('Error capturing image from camera', error: e);
      return null;
    }
  }

  /// ضغط الصورة
  Future<File?> compressImage(File imageFile, {int quality = 85}) async {
    try {
      // قراءة الصورة
      final bytes = await imageFile.readAsBytes();
      final image = img.decodeImage(bytes);
      
      if (image == null) {
        logger.w('Failed to decode image');
        return imageFile;
      }

      // تغيير الحجم إذا كانت كبيرة جداً
      img.Image resized = image;
      if (image.width > 1920 || image.height > 1920) {
        resized = img.copyResize(
          image,
          width: image.width > image.height ? 1920 : null,
          height: image.height > image.width ? 1920 : null,
        );
      }

      // ضغط بصيغة JPEG
      final compressed = img.encodeJpg(resized, quality: quality);

      // حفظ مؤقت
      final tempPath = path.join(
        path.dirname(imageFile.path),
        'compressed_${path.basename(imageFile.path)}',
      );
      final compressedFile = File(tempPath);
      await compressedFile.writeAsBytes(compressed);

      logger.i('Image compressed from ${bytes.length} to ${compressed.length} bytes');
      return compressedFile;
    } catch (e) {
      logger.e('Error compressing image', error: e);
      return imageFile;
    }
  }

  /// رفع صورة إلى Firebase Storage
  Future<String?> uploadImage({
    required File imageFile,
    required String folder,
    String? fileName,
    bool compress = true,
    Function(double)? onProgress,
  }) async {
    try {
      // ضغط الصورة أولاً
      File fileToUpload = imageFile;
      if (compress) {
        final compressed = await compressImage(imageFile);
        if (compressed != null) {
          fileToUpload = compressed;
        }
      }

      // تحديد اسم الملف
      final String uploadFileName = fileName ??
          '${DateTime.now().millisecondsSinceEpoch}${path.extension(imageFile.path)}';

      // المسار في Storage
      final String storagePath = '$folder/$uploadFileName';

      // رفع الملف
      final Reference ref = _storage.ref().child(storagePath);
      final UploadTask uploadTask = ref.putFile(fileToUpload);

      // متابعة التقدم
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress?.call(progress);
        logger.d('Upload progress: ${(progress * 100).toStringAsFixed(2)}%');
      });

      // انتظار الانتهاء
      final TaskSnapshot snapshot = await uploadTask;

      // الحصول على الرابط
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      logger.i('Image uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e, stackTrace) {
      logger.e('Error uploading image', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// رفع صورة للرسائل
  Future<String?> uploadChatImage({
    required File imageFile,
    required String chatRoomId,
    Function(double)? onProgress,
  }) async {
    return await uploadImage(
      imageFile: imageFile,
      folder: 'chat_images/$chatRoomId',
      compress: true,
      onProgress: onProgress,
    );
  }

  /// رفع صورة للملف الشخصي
  Future<String?> uploadProfileImage({
    required File imageFile,
    required String userId,
    Function(double)? onProgress,
  }) async {
    return await uploadImage(
      imageFile: imageFile,
      folder: 'profile_images',
      fileName: '$userId.jpg',
      compress: true,
      onProgress: onProgress,
    );
  }

  /// رفع صورة للدورة
  Future<String?> uploadCourseImage({
    required File imageFile,
    required String courseId,
    Function(double)? onProgress,
  }) async {
    return await uploadImage(
      imageFile: imageFile,
      folder: 'course_images',
      fileName: '$courseId.jpg',
      compress: true,
      onProgress: onProgress,
    );
  }

  /// حذف صورة من Storage
  Future<bool> deleteImage(String imageUrl) async {
    try {
      final Reference ref = _storage.refFromURL(imageUrl);
      await ref.delete();
      logger.i('Image deleted: $imageUrl');
      return true;
    } catch (e) {
      logger.e('Error deleting image', error: e);
      return false;
    }
  }

  /// الحصول على حجم الملف بالـ MB
  double getFileSizeInMB(File file) {
    final bytes = file.lengthSync();
    return bytes / (1024 * 1024);
  }

  /// التحقق من أن الملف صورة
  bool isImageFile(String filePath) {
    final ext = path.extension(filePath).toLowerCase();
    return ['.jpg', '.jpeg', '.png', '.gif', '.webp'].contains(ext);
  }
}
