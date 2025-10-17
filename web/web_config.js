// Web-specific configuration for Training App v2
// This file handles web platform initialization

(function() {
  'use strict';

  console.log('🚀 Training App v2 - Web Platform Initialization');

  // Check if running in web environment
  const isWeb = typeof window !== 'undefined' && typeof document !== 'undefined';
  
  if (!isWeb) {
    console.error('Not running in web environment!');
    return;
  }

  // Detect RTL language
  const detectRTL = () => {
    const lang = navigator.language || navigator.userLanguage;
    const rtlLanguages = ['ar', 'he', 'fa', 'ur'];
    return rtlLanguages.some(l => lang.startsWith(l));
  };

  // Set RTL if Arabic
  if (detectRTL()) {
    document.documentElement.setAttribute('dir', 'rtl');
    document.documentElement.setAttribute('lang', 'ar');
  }

  // Disable right-click on production (optional)
  if (window.location.hostname !== 'localhost' && window.location.hostname !== '127.0.0.1') {
    // Uncomment to disable right-click
    // document.addEventListener('contextmenu', e => e.preventDefault());
  }

  // Prevent zoom on mobile web
  document.addEventListener('gesturestart', (e) => {
    e.preventDefault();
  });

  // Handle PWA install prompt
  let deferredPrompt;
  window.addEventListener('beforeinstallprompt', (e) => {
    console.log('💾 PWA install prompt available');
    e.preventDefault();
    deferredPrompt = e;
    
    // Store for later use
    window.pwaInstallPrompt = deferredPrompt;
  });

  // PWA installed event
  window.addEventListener('appinstalled', () => {
    console.log('✅ PWA installed successfully');
    deferredPrompt = null;
  });

  // Check if running as PWA
  const isPWA = () => {
    return window.matchMedia('(display-mode: standalone)').matches ||
           window.navigator.standalone ||
           document.referrer.includes('android-app://');
  };

  if (isPWA()) {
    console.log('📱 Running as PWA');
    document.body.classList.add('pwa-mode');
  }

  // Service Worker Registration
  if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
      navigator.serviceWorker.register('/flutter_service_worker.js')
        .then((registration) => {
          console.log('✅ ServiceWorker registered:', registration.scope);
          
          // Check for updates
          registration.addEventListener('updatefound', () => {
            const newWorker = registration.installing;
            newWorker.addEventListener('statechange', () => {
              if (newWorker.state === 'installed' && navigator.serviceWorker.controller) {
                console.log('🔄 New version available! Please refresh.');
                // Optionally show update notification
              }
            });
          });
        })
        .catch((error) => {
          console.error('❌ ServiceWorker registration failed:', error);
        });
    });
  }

  // Online/Offline detection
  window.addEventListener('online', () => {
    console.log('🌐 Back online');
    document.body.classList.remove('offline-mode');
  });

  window.addEventListener('offline', () => {
    console.log('📵 Offline mode');
    document.body.classList.add('offline-mode');
  });

  // Performance monitoring
  if ('PerformanceObserver' in window) {
    try {
      const perfObserver = new PerformanceObserver((list) => {
        for (const entry of list.getEntries()) {
          // Log slow resources
          if (entry.duration > 2000) {
            console.warn(`⚠️ Slow resource: ${entry.name} (${entry.duration}ms)`);
          }
        }
      });
      perfObserver.observe({ entryTypes: ['resource', 'navigation'] });
    } catch (e) {
      console.log('Performance monitoring not supported');
    }
  }

  // Prevent iOS bounce scroll
  let touchStartY = 0;
  document.addEventListener('touchstart', (e) => {
    touchStartY = e.touches[0].clientY;
  }, { passive: true });

  document.addEventListener('touchmove', (e) => {
    const touchY = e.touches[0].clientY;
    const touchDiff = touchY - touchStartY;
    
    // Prevent pull-to-refresh on iOS
    if (touchDiff > 0 && window.scrollY === 0) {
      e.preventDefault();
    }
  }, { passive: false });

  // Log platform info
  console.log('📱 Platform Info:', {
    userAgent: navigator.userAgent,
    language: navigator.language,
    online: navigator.onLine,
    cookieEnabled: navigator.cookieEnabled,
    screen: `${screen.width}x${screen.height}`,
    viewport: `${window.innerWidth}x${window.innerHeight}`,
    isPWA: isPWA(),
    isRTL: detectRTL(),
  });

  // Global error handler
  window.addEventListener('error', (event) => {
    console.error('❌ Global error:', event.error);
  });

  window.addEventListener('unhandledrejection', (event) => {
    console.error('❌ Unhandled promise rejection:', event.reason);
  });

  console.log('✅ Web platform initialized successfully');
})();
