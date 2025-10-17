// Service Worker for PWA and offline support
'use strict';

const CACHE_NAME = 'training-app-v2-cache-v1';
const urlsToCache = [
  '/',
  '/index.html',
  '/manifest.json',
  '/icons/Icon-192.png',
  '/icons/Icon-512.png',
  '/favicon.png',
];

// Install event - cache essential files
self.addEventListener('install', (event) => {
  console.log('[ServiceWorker] Install');
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        console.log('[ServiceWorker] Caching app shell');
        return cache.addAll(urlsToCache);
      })
      .then(() => self.skipWaiting())
  );
});

// Activate event - clean old caches
self.addEventListener('activate', (event) => {
  console.log('[ServiceWorker] Activate');
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME) {
            console.log('[ServiceWorker] Removing old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    }).then(() => self.clients.claim())
  );
});

// Fetch event - serve from cache, fallback to network
self.addEventListener('fetch', (event) => {
  // Skip cross-origin requests
  if (!event.request.url.startsWith(self.location.origin)) {
    return;
  }

  // Skip Firebase API calls
  if (event.request.url.includes('firebaseio.com') || 
      event.request.url.includes('googleapis.com')) {
    return;
  }

  event.respondWith(
    caches.match(event.request)
      .then((response) => {
        // Cache hit - return response
        if (response) {
          return response;
        }

        // Clone the request
        const fetchRequest = event.request.clone();

        return fetch(fetchRequest).then((response) => {
          // Check if valid response
          if (!response || response.status !== 200 || response.type !== 'basic') {
            return response;
          }

          // Clone the response
          const responseToCache = response.clone();

          caches.open(CACHE_NAME)
            .then((cache) => {
              cache.put(event.request, responseToCache);
            });

          return response;
        }).catch((error) => {
          console.log('[ServiceWorker] Fetch failed:', error);
          // Return offline page if available
          return caches.match('/index.html');
        });
      })
  );
});

// Push notification event
self.addEventListener('push', (event) => {
  console.log('[ServiceWorker] Push received:', event);
  
  const options = {
    body: event.data ? event.data.text() : 'إشعار جديد',
    icon: '/icons/Icon-192.png',
    badge: '/icons/Icon-192.png',
    vibrate: [200, 100, 200],
    tag: 'training-notification',
    requireInteraction: false,
  };

  event.waitUntil(
    self.registration.showNotification('Training App v2', options)
  );
});

// Notification click event
self.addEventListener('notificationclick', (event) => {
  console.log('[ServiceWorker] Notification clicked');
  event.notification.close();

  event.waitUntil(
    clients.openWindow('/')
  );
});
