import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final _cloudLog = Logger();

/// Simple Cloudinary uploader using unsigned preset (for public profile images / light assets).
/// SECURITY: Use only for non-sensitive images. For sensitive/private use a backend signature flow.
class CloudinaryService {
  final String cloudName;
  final String uploadPreset; // unsigned preset

  CloudinaryService({required this.cloudName, required this.uploadPreset});

  Future<String> uploadImage(File file) async {
    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );
    final req = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final resp = await req.send();
    final body = await resp.stream.bytesToString();
    if (resp.statusCode == 200) {
      final data = jsonDecode(body) as Map<String, dynamic>;
      final url = data['secure_url'] as String?;
      if (url == null) throw Exception('No secure_url in Cloudinary response');
      return url;
    }
    _cloudLog.e('Cloudinary upload failed (${resp.statusCode}): $body');
    throw Exception('Cloudinary upload failed: $body');
  }

  /// Generic uploader (auto resource type) so we can store non-image files
  /// as a fallback when R2 is not configured. Uses the `auto` endpoint so
  /// Cloudinary infers resource_type (image/raw/video). For documents/zip/pdf
  /// it will treat them as raw.
  Future<String> uploadAny(File file) async {
    // نترك Cloudinary يحدد النوع تلقائياً (auto) بدون فرض Content-Type يدوياً
    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/auto/upload',
    );
    final req = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final resp = await req.send();
    final body = await resp.stream.bytesToString();
    if (resp.statusCode == 200) {
      final data = jsonDecode(body) as Map<String, dynamic>;
      final url = data['secure_url'] as String?;
      if (url == null) throw Exception('No secure_url in Cloudinary response');
      return url;
    }
    _cloudLog.e('Cloudinary generic upload failed (${resp.statusCode}): $body');
    throw Exception('Cloudinary generic upload failed: $body');
  }
}
