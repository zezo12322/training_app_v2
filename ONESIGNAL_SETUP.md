# OneSignal Push Notifications Setup

## Current Status
✅ OneSignal is fully integrated in the codebase
✅ Default APP ID is configured: `c89cafa8-1e04-4b6a-bcf8-43ccae9c37cd`
✅ VS Code launch configurations updated with --dart-define

## How It Works

### 1. Service Initialization
The `OneSignalNotificationService` is initialized in `main.dart` after Firebase initialization.

### 2. APP ID Configuration
The APP ID is provided via `--dart-define` for security:
- **Default**: `c89cafa8-1e04-4b6a-bcf8-43ccae9c37cd` (already configured)
- **Custom**: Pass your own ID via `--dart-define=ONE_SIGNAL_APP_ID=your-app-id`

### 3. Launch Configurations
The `.vscode/launch.json` file includes the APP ID for all run modes:
- `training_app_v2` (debug mode)
- `training_app_v2 (profile mode)`
- `training_app_v2 (release mode)`

## Getting Your OneSignal APP ID

1. Go to [OneSignal Dashboard](https://onesignal.com)
2. Create a new app or select existing app
3. Go to **Settings → Keys & IDs**
4. Copy your **App ID** (UUID format)
5. Update `.vscode/launch.json` with your App ID

## Testing Push Notifications

### Manual Test (via OneSignal Dashboard)
1. Run the app: `flutter run` (or F5 in VS Code)
2. OneSignal will register the device and print the Player ID in logs
3. Go to OneSignal Dashboard → **Messages → New Push**
4. Select **Send to Test Users**
5. Enter the Player ID from logs
6. Send the notification

### Automated Test (via Backend Function)
The backend Cloud Function `sendPostNotification` automatically sends notifications when:
- A new course wall post is created
- A comment is added to a post
- A poll is created

## Security Notes

### ✅ What's Secure
- APP ID is public and safe to include in client code
- APP ID is passed via `--dart-define` (not hardcoded in source)

### ⚠️ What's NOT Secure
- **REST API KEY** should NEVER be in client code
- REST API KEY must only be in backend (Cloud Functions)

### Current Implementation
- ✅ REST API KEY removed from client code
- ✅ Notification sending moved to Cloud Functions (`functions/index.js`)
- ✅ Client only registers device and receives notifications

## Troubleshooting

### Issue: "App ID is missing or placeholder"
**Solution**: Ensure `--dart-define=ONE_SIGNAL_APP_ID=<UUID>` is passed when running

### Issue: Notifications not received
**Checks**:
1. Device is registered (check logs for Player ID)
2. App has notification permissions
3. OneSignal dashboard shows device as subscribed
4. Test with OneSignal Dashboard first before testing via backend

### Issue: Player ID not found in Firestore
**Solution**: The Player ID is stored in `users/{uid}/oneSignalPlayerId` field after device registration

## Development vs Production

### Development
- Use test APP ID from OneSignal
- Test with OneSignal Dashboard → Send to Test Users

### Production
- Create separate OneSignal app for production
- Update APP ID in production build: 
  ```bash
  flutter build apk --dart-define=ONE_SIGNAL_APP_ID=production-app-id
  ```
- Configure in CI/CD pipeline

## Firebase Cloud Functions Integration

The backend function sends notifications via OneSignal REST API:

```javascript
// functions/index.js
exports.sendPostNotification = functions.firestore
  .document('course_wall_posts/{postId}')
  .onCreate(async (snap, context) => {
    // Sends notification to enrolled users
    // Uses OneSignal REST API securely from backend
  });
```

### Required Environment Variables (Backend)
```bash
firebase functions:config:set onesignal.app_id="c89cafa8-1e04-4b6a-bcf8-43ccae9c37cd"
firebase functions:config:set onesignal.rest_api_key="YOUR_REST_API_KEY"
```

## Next Steps for Production

1. **Get your own OneSignal account** (if not using default)
2. **Configure REST API KEY in Cloud Functions**:
   ```bash
   firebase functions:config:set onesignal.rest_api_key="YOUR_KEY"
   ```
3. **Test notification flow**:
   - Create course wall post
   - Verify enrolled users receive notification
4. **Monitor OneSignal delivery stats** in dashboard

## Additional Resources

- [OneSignal Flutter SDK Docs](https://documentation.onesignal.com/docs/flutter-sdk-setup)
- [OneSignal REST API Docs](https://documentation.onesignal.com/reference/create-notification)
- [Firebase Cloud Functions](https://firebase.google.com/docs/functions)

---
**Last Updated**: Current implementation session
