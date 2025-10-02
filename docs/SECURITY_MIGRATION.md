## Security & Field Unification Migration

### 1. Removed Client-Side OneSignal Secrets
Previously the app embedded OneSignal APP ID and REST API KEY in `notification_service.dart`.
This is insecure because mobile binaries can be decompiled and secrets harvested.

Action:
- Removed REST API key from client.
- Introduced `String.fromEnvironment('ONE_SIGNAL_APP_ID')` for the public app id.
- Added placeholder method `sendNotificationViaBackend` which must call a secure backend (e.g. Firebase Cloud Function) that holds the REST API key.

Next Steps Backend (outline):
1. Create Firebase Function `sendOneSignalNotification`.
2. Validate auth context & authorization (trainer/admin only for broadcast).
3. Use server-stored REST API key to call OneSignal REST API.
4. Return success/failure payload.

### 2. Unified User Role Field
Inconsistent fields existed: `userType` vs `role`.
The codebase now writes only `role` with values: `trainer` | `trainee`.

Migration Script Suggestion (one-off):
For each user document:
- If `role` missing and `userType` present => set `role = userType`.
- Optionally remove `userType` after verifying no legacy clients depend on it.

### 3. Added createdAt on user creation
Ensures consistent metadata for auditing & ordering.

### 4. Recommended Firestore Security Rules (conceptual snippet)
```
match /databases/{db}/documents {
  function isSignedIn() { return request.auth != null; }
  function userRole() { return get(/databases/$(db)/documents/users/$(request.auth.uid)).data.role; }

  match /users/{uid} {
    allow read: if isSignedIn() && uid == request.auth.uid; // or trainer/admin expansion
    allow create: if isSignedIn() && request.resource.data.role in ['trainer','trainee'];
    allow update: if isSignedIn() && uid == request.auth.uid && !("role" in request.resource.data.diff().changedKeys());
  }

  match /courses/{courseId} {
    allow create: if isSignedIn() && userRole() == 'trainer';
    allow update: if isSignedIn() && userRole() == 'trainer';
    allow read: if isSignedIn();
  }
}
```

Adjust rules to production needs.

### 5. Build / Run Update
Pass the OneSignal app id at build time:
```
flutter run --dart-define=ONE_SIGNAL_APP_ID=YOUR_APP_ID
```

### 6. Next
- Implement backend function for notifications.
- Remove any lingering references to `userType`.
- Add tests ensuring new users contain `role` only.
