# 🌐 دليل تشغيل Training App v2 على الويب

## 📋 المحتويات
- [التشغيل المحلي (Development)](#التشغيل-المحلي)
- [البناء للإنتاج (Production Build)](#البناء-للإنتاج)
- [النشر على Firebase Hosting](#النشر-على-firebase-hosting)
- [النشر على خادم مخصص](#النشر-على-خادم-مخصص)
- [استكشاف الأخطاء](#استكشاف-الأخطاء)

---

## 🚀 التشغيل المحلي

### الطريقة 1: Flutter Run (مع Hot Reload)

```bash
# تشغيل على Chrome
flutter run -d chrome

# تشغيل على Chrome مع web server محدد
flutter run -d chrome --web-port=8080

# تشغيل مع web renderer محدد
flutter run -d chrome --web-renderer html      # HTML renderer (أسرع)
flutter run -d chrome --web-renderer canvaskit  # CanvasKit (أفضل أداء)
flutter run -d chrome --web-renderer auto       # تلقائي (default)
```

### الطريقة 2: Web Server ثابت

```bash
# بناء نسخة تجريبية
flutter build web --profile

# تشغيل web server
cd build/web
python -m http.server 8000
# أو
php -S localhost:8000
```

ثم افتح: http://localhost:8000

---

## 📦 البناء للإنتاج

### Build أساسي

```bash
# Build production مُحسّن
flutter build web --release

# مع renderer محدد
flutter build web --release --web-renderer canvaskit

# مع base href مخصص (لو على subdirectory)
flutter build web --release --base-href /training-app/
```

### Build محسّن للأداء

```powershell
# بناء محسّن مع كل الخيارات
flutter build web --release `
  --web-renderer canvaskit `
  --dart-define=FLUTTER_WEB_USE_SKIA=true `
  --no-tree-shake-icons `
  --source-maps
```

**الناتج:** مجلد `build/web` جاهز للنشر

---

## 🔥 النشر على Firebase Hosting

### الخطوة 1: تثبيت Firebase CLI

```bash
# تثبيت عالمي
npm install -g firebase-tools

# تسجيل الدخول
firebase login
```

### الخطوة 2: تهيئة Firebase Hosting

```bash
# في مجلد المشروع
firebase init hosting

# الإعدادات:
# ✓ Public directory: build/web
# ✓ Configure as single-page app: Yes
# ✓ Set up automatic builds with GitHub: No (أو Yes إذا أردت CI/CD)
# ✓ Overwrite index.html: No
```

سيُنشئ ملف `firebase.json`:

```json
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ],
    "headers": [
      {
        "source": "**/*.@(jpg|jpeg|gif|png|svg|webp)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=31536000"
          }
        ]
      },
      {
        "source": "**/*.@(js|css)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=31536000"
          }
        ]
      }
    ]
  }
}
```

### الخطوة 3: Build & Deploy

```bash
# بناء التطبيق
flutter build web --release --web-renderer canvaskit

# نشر على Firebase
firebase deploy --only hosting

# نشر مع message
firebase deploy --only hosting -m "Training App v2 - Initial release"
```

### الخطوة 4: عرض الموقع

```bash
# فتح الموقع المباشر
firebase open hosting:site
```

سيكون الرابط: `https://training-app-v2-prod.web.app`

---

## 🌍 النشر على خادم مخصص

### VPS / Dedicated Server

```bash
# 1. بناء التطبيق
flutter build web --release

# 2. رفع المجلد build/web للخادم
# يمكن استخدام FTP, SFTP, rsync, أو GitHub Actions

# مثال مع rsync:
rsync -avz build/web/ user@server:/var/www/training-app/

# 3. إعداد Nginx
```

#### إعدادات Nginx:

```nginx
# /etc/nginx/sites-available/training-app
server {
    listen 80;
    server_name training-app.com www.training-app.com;
    
    # Redirect HTTP to HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name training-app.com www.training-app.com;
    
    # SSL Certificates
    ssl_certificate /etc/letsencrypt/live/training-app.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/training-app.com/privkey.pem;
    
    # Root directory
    root /var/www/training-app;
    index index.html;
    
    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml text/javascript application/javascript application/xml+rss application/json;
    
    # Cache static files
    location ~* \.(js|css|png|jpg|jpeg|gif|svg|ico|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
    
    # Flutter web routing
    location / {
        try_files $uri $uri/ /index.html;
        add_header X-Frame-Options "SAMEORIGIN" always;
        add_header X-Content-Type-Options "nosniff" always;
        add_header X-XSS-Protection "1; mode=block" always;
    }
    
    # Security headers
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
}
```

#### تفعيل الموقع:

```bash
# Link configuration
sudo ln -s /etc/nginx/sites-available/training-app /etc/nginx/sites-enabled/

# Test configuration
sudo nginx -t

# Reload Nginx
sudo systemctl reload nginx
```

---

## 🐳 Docker Deployment

### Dockerfile

```dockerfile
# Build stage
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app
COPY pubspec.* ./
RUN flutter pub get

COPY . .
RUN flutter build web --release --web-renderer canvaskit

# Production stage
FROM nginx:alpine

# Copy built files
COPY --from=build /app/build/web /usr/share/nginx/html

# Custom Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

### nginx.conf للـ Docker

```nginx
server {
    listen 80;
    server_name _;
    
    root /usr/share/nginx/html;
    index index.html;
    
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    location ~* \.(js|css|png|jpg|jpeg|gif|svg|ico)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

### Build & Run

```bash
# Build Docker image
docker build -t training-app-web .

# Run container
docker run -d -p 8080:80 --name training-app training-app-web

# Access at: http://localhost:8080
```

---

## 🔧 استكشاف الأخطاء

### مشكلة: الصفحة فارغة

**الحل:**
```bash
# تأكد من Firebase initialization
# افحص console للأخطاء:
# Chrome DevTools > Console

# جرب HTML renderer بدل CanvasKit:
flutter build web --release --web-renderer html
```

### مشكلة: الخطوط العربية لا تظهر

**الحل:**
```yaml
# في pubspec.yaml تأكد من:
flutter:
  fonts:
    - family: Cairo
      fonts:
        - asset: assets/fonts/Cairo-Regular.ttf
```

```dart
// في main.dart:
ThemeData(
  fontFamily: 'Cairo',
)
```

### مشكلة: Firebase not initialized

**الحل:**
```bash
# تأكد من وجود firebase_options.dart
flutter pub run flutterfire_cli:flutterfire configure --platforms=web

# أعد البناء
flutter build web --release
```

### مشكلة: CORS errors

**الحل:**
```javascript
// في Firebase Console > Storage > Rules
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read;
      allow write: if request.auth != null;
    }
  }
}

// في Firestore Rules > Rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### مشكلة: بطء التحميل

**الحلول:**
1. استخدم CanvasKit renderer (أفضل أداء)
2. فعّل Gzip compression
3. استخدم CDN
4. قلل حجم الصور (استخدم WebP)
5. Code splitting:

```bash
flutter build web --release --split-debug-info=./debug-info --obfuscate
```

---

## 📊 Performance Optimization

### 1. Tree Shaking

```bash
# يزيل الكود غير المستخدم
flutter build web --release --tree-shake-icons
```

### 2. Defer Loading

```html
<!-- في index.html -->
<script src="flutter_bootstrap.js" async defer></script>
```

### 3. Service Worker Caching

```javascript
// في flutter_service_worker.js (موجود أصلاً)
// يخزن الملفات للاستخدام Offline
```

### 4. Image Optimization

```bash
# حول الصور لـ WebP
# استخدم flutter_image_compress للضغط
```

---

## 🎯 Checklist قبل النشر

- [ ] ✅ Build production بنجاح
- [ ] ✅ اختبار على browsers مختلفة (Chrome, Firefox, Safari, Edge)
- [ ] ✅ اختبار على mobile browsers
- [ ] ✅ اختبار Offline mode (PWA)
- [ ] ✅ Firebase configuration صحيح
- [ ] ✅ Security rules محدّثة
- [ ] ✅ HTTPS مفعّل
- [ ] ✅ Gzip compression مفعّل
- [ ] ✅ Cache headers محددة
- [ ] ✅ RTL support يعمل
- [ ] ✅ الخطوط العربية تظهر
- [ ] ✅ الصور تحمّل
- [ ] ✅ Analytics مفعّل
- [ ] ✅ Error tracking مفعّل

---

## 🚀 أوامر سريعة

```bash
# Development
flutter run -d chrome

# Build
flutter build web --release --web-renderer canvaskit

# Deploy to Firebase
firebase deploy --only hosting

# Test production build locally
cd build/web && python -m http.server 8000
```

---

## 📞 المساعدة

**مشاكل شائعة:**
- Firebase: https://firebase.google.com/support
- Flutter Web: https://docs.flutter.dev/platform-integration/web
- Issues: GitHub Issues

**Resources:**
- Flutter Web Docs: https://flutter.dev/web
- Firebase Hosting: https://firebase.google.com/docs/hosting
- PWA Guide: https://web.dev/progressive-web-apps/

---

**آخر تحديث:** أكتوبر 17، 2025
