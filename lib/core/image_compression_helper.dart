import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'logging.dart';

/// Utility class for image compression
class ImageCompressionHelper {
  /// Compress image file to reduce size before uploading
  /// 
  /// Returns compressed file or original if compression fails
  /// 
  /// Parameters:
  /// - [imageFile]: Original image file
  /// - [quality]: Compression quality (0-100), default 70
  /// - [minWidth]: Minimum width for the compressed image, default 1024
  /// - [minHeight]: Minimum height for the compressed image, default 1024
  static Future<File?> compressImage(
    File imageFile, {
    int quality = 70,
    int minWidth = 1024,
    int minHeight = 1024,
  }) async {
    try {
      // Get temporary directory
      final tempDir = await getTemporaryDirectory();
      final targetPath = path.join(
        tempDir.path,
        '${DateTime.now().millisecondsSinceEpoch}_compressed${path.extension(imageFile.path)}',
      );

      // Compress the image
      final result = await FlutterImageCompress.compressAndGetFile(
        imageFile.absolute.path,
        targetPath,
        quality: quality,
        minWidth: minWidth,
        minHeight: minHeight,
        format: CompressFormat.jpeg,
      );

      if (result != null) {
        return File(result.path);
      }

      // If compression failed, return original
      return imageFile;
    } catch (e) {
      logger.w('Error compressing image: $e');
      // If any error occurs, return original file
      return imageFile;
    }
  }

  /// Compress multiple images
  static Future<List<File>> compressMultipleImages(
    List<File> imageFiles, {
    int quality = 70,
    int minWidth = 1024,
    int minHeight = 1024,
  }) async {
    final compressed = <File>[];
    
    for (final imageFile in imageFiles) {
      final compressedImage = await compressImage(
        imageFile,
        quality: quality,
        minWidth: minWidth,
        minHeight: minHeight,
      );
      
      if (compressedImage != null) {
        compressed.add(compressedImage);
      }
    }
    
    return compressed;
  }

  /// Get compression ratio as percentage
  static Future<double> getCompressionRatio(File original, File compressed) async {
    final originalSize = await original.length();
    final compressedSize = await compressed.length();
    
    if (originalSize == 0) return 0;
    
    return ((originalSize - compressedSize) / originalSize) * 100;
  }
}
