import 'dart:io';
import 'package:mime/mime.dart';
import 'cloudinary_service.dart';
import 'spaces_upload_service.dart';
import 'package:training_app/config/app_config.dart';

/// Result of an upload (URL + the underlying storage key if available)
class UploadResult {
  final String url;
  final String? key; // for future deletion support
  UploadResult(this.url, {this.key});
}

/// A hybrid storage abstraction:
///  - Images -> Cloudinary (transform/CDN advantages)
///  - Other files (audio, generic, docs) -> DigitalOcean Spaces (S3-compatible)
class HybridStorageService {
  final CloudinaryService? _cloudinary;
  final SpacesUploadService? _spaces;

  HybridStorageService()
    : _cloudinary = CloudinaryService(
        cloudName: AppConfig.cloudinaryCloudName,
        uploadPreset: AppConfig.cloudinaryPreset,
      ),
      _spaces =
          (AppConfig.useSpaces && AppConfig.spacesPresignEndpoint.isNotEmpty)
          ? SpacesUploadService(
              presignEndpoint: AppConfig.spacesPresignEndpoint,
            )
          : null;

  bool _isImage(File f) {
    final mime = lookupMimeType(f.path) ?? '';
    return mime.startsWith('image/');
  }

  Future<UploadResult> uploadFile(File file, {String? forcedExt}) async {
    if (_isImage(file)) {
      final url = await _cloudinary!.uploadImage(file);
      return UploadResult(url);
    }
    if (_spaces != null) {
      final ext = (forcedExt ?? file.path.split('.').last).toLowerCase();
      final mime = lookupMimeType(file.path) ?? 'application/octet-stream';
      final url = await _spaces.uploadObject(
        file,
        extension: ext,
        contentType: mime,
      );
      return UploadResult(url);
    }
    // Fallback: use Cloudinary auto/raw upload for non-image if Spaces disabled
    final fallbackUrl = await _cloudinary!.uploadAny(file);
    return UploadResult(fallbackUrl);
  }
}
