/// Centralized application configuration pulling from compile-time environment.
/// Use --dart-define=KEY=value when running or building.
// ضع هنا عنوان الـ Cloud Function (أو أي Backend) لو حابب التطبيق يشتغل بدون --dart-define
// مثال: https://europe-west1-your-project-id.cloudfunctions.net/presignSpaceAudio?ext=
// عدّل القيمة مرة واحدة ثم احذف التعليق.
// Fallback presign endpoint (Cloudflare Worker) – used if no --dart-define overrides it.
// تأكد أن الرابط يبدأ بـ https:// ويوجد سلاش أخير ليسمح بتمرير الامتداد كمسار (audio/m4a الخ)
const String _spacesPresignFallback =
    'https://spring-mountain-1889.zakiziad9001-sd.workers.dev/';

// ============================================================================
// NOTIFICATIONS RELAY FALLBACK
// ضع هنا رابط الـ Worker (أو أي Relay backend) الذي يمسك سر OneSignal REST API KEY
// مثال (استبدل YOUR_SUBDOMAIN):
//   https://YOUR_SUBDOMAIN.workers.dev/
// ملاحظات:
// 1) بدون هذا الرابط أو --dart-define=NOTIF_ENDPOINT=... لن تُرسل الإشعارات.
// 2) هذا ليس سراً؛ السر الحقيقي (REST API KEY) يبقى داخل الـ Worker.
// 3) أبقِ على الشرطة المائلة النهائية / إذا كان الـ Worker يتطلب ذلك.
const String _notifRelayFallback =
    'https://onesignal-worker.tadreeblink.workers.dev';

class AppConfig {
  // Cloudinary (images)
  static const String cloudinaryCloudName = String.fromEnvironment(
    'CLOUDINARY_CLOUD_NAME',
    defaultValue: 'da3xvlxby',
  );
  static const String cloudinaryPreset = String.fromEnvironment(
    'CLOUDINARY_PRESET',
    defaultValue: 'avatars_unsigned',
  );

  // DigitalOcean Spaces (generic/audio uploads)
  // NOTE: نستخدم نفس أسلوب الـ presign عبر backend (Function / Edge) لإرجاع JSON:
  // { "putUrl": "...", "publicUrl": "..." }
  // إجبار التشغيل الافتراضي مفعّل (يمكن تعطيله فقط بالـ dart-define لو احتجت)
  static const bool useSpaces =
      String.fromEnvironment('USE_SPACES', defaultValue: 'true') == 'true';
  // إن لم يُمرر --dart-define واستخدمت fallback أعلاه سيُستخدم تلقائياً.
  static const String spacesPresignEndpoint = String.fromEnvironment(
    'SPACES_PRESIGN_ENDPOINT',
    defaultValue: _spacesPresignFallback,
  );

  // ---------------------------------------------------------------------------
  // Notifications (OneSignal backend relay)
  // Provide the Cloudflare Worker (or any relay) endpoint that accepts POST
  // with: { userIds: [], title: '', content: '', data: {} }
  // DO NOT put secrets here; the Worker holds the REST API key.
  // You can override at build time via:
  //   --dart-define=NOTIF_ENDPOINT=https://your-worker.example.com/
  // If no dart-define is passed, we fall back to this constant (empty by default).
  static const String notifEndpoint = String.fromEnvironment(
    'NOTIF_ENDPOINT',
    // Use fallback constant; إذا تركته فارغاً ستظهر تحذيرات في السجلات.
    defaultValue: _notifRelayFallback,
  );
}
