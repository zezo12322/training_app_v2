# 🔧 Google Sign-In Fix Guide

## ❌ Current Error
```
PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10: , null, null)
```

**Error Code 10** = Developer Error - SHA-1 fingerprint not registered in Firebase Console

---

## ✅ Solution: Add SHA-1 Fingerprint to Firebase

### **Your Debug SHA-1 Fingerprint:**
```
BC:A1:CC:DA:E1:9D:51:07:B3:DE:66:99:BA:43:72:80:14:6B:EF:24
```

### **Your Release SHA-1 Fingerprint (for production):**
```
31:5E:B5:E5:1D:BE:B9:96:6D:2A:73:40:7F:2B:B5:82:FA:0C:24:26
```

---

## 📋 Step-by-Step Fix

### **Step 1: Open Firebase Console**
1. Go to: https://console.firebase.google.com
2. Login with your Google account
3. Select project: **`trainingapp-mvp`**

### **Step 2: Navigate to Project Settings**
1. Click the **⚙️ Settings icon** (top-left corner)
2. Select **Project settings**
3. Scroll down to **Your apps** section
4. Find your Android app: `com.example.training_app_v2`
5. Click on the app to expand details

### **Step 3: Add SHA-1 Fingerprint**
1. Scroll to **SHA certificate fingerprints** section
2. Click **Add fingerprint** button
3. Paste the Debug SHA-1:
   ```
   BC:A1:CC:DA:E1:9D:51:07:B3:DE:66:99:BA:43:72:80:14:6B:EF:24
   ```
4. Click **Save**

### **Step 4: Download Updated google-services.json**
1. After saving, Firebase will show a download button
2. Click **Download google-services.json**
3. Replace the old file in your project:
   - Old file location: `android/app/google-services.json`
   - Replace it with the newly downloaded file

### **Step 5: Clean & Rebuild Project**

Open PowerShell in project root and run:

```powershell
# Stop Gradle daemon
cd android ; .\gradlew --stop ; cd ..

# Clean Flutter project
flutter clean

# Get dependencies
flutter pub get

# Run on device
flutter run --dart-define=ONE_SIGNAL_APP_ID=c89cafa8-1e04-4b6a-bcf8-43ccae9c37cd
```

### **Step 6: Test Google Sign-In**
1. Open the app on your Android device
2. Click **Sign in with Google** button
3. Select your Google account
4. ✅ Should work successfully now!

---

## 🔍 How to Verify SHA-1 is Added

After adding SHA-1 to Firebase Console, you should see:

1. In Firebase Console → Project Settings → Your apps:
   - **SHA certificate fingerprints** section will show your SHA-1
   - You'll see `BC:A1:CC:DA:E1:9D:51:07:B3:DE:66:99:BA:43:72:80:14:6B:EF:24` listed

2. In the updated `google-services.json`:
   - The `oauth_client` array will NO LONGER be empty
   - It will contain OAuth 2.0 client configurations

---

## 📱 For Production Release (Later)

When building for production, also add the Release SHA-1:

1. Follow same steps above
2. Add Release SHA-1: `31:5E:B5:E5:1D:BE:B9:96:6D:2A:73:40:7F:2B:B5:82:FA:0C:24:26`
3. Download updated `google-services.json` again
4. Build release APK

---

## 🎯 Why This Happens

Google Sign-In requires SHA-1 fingerprint registration for security:

- **Debug Mode**: Uses debug keystore SHA-1
- **Release Mode**: Uses release keystore SHA-1
- Firebase verifies the app signature matches registered SHA-1
- Without SHA-1, Google Play Services rejects sign-in attempts

---

## 🆘 Troubleshooting

### Problem: "I added SHA-1 but still getting error"

**Solution:**
1. Make sure you downloaded the **NEW** `google-services.json` after adding SHA-1
2. Replace the old file in `android/app/google-services.json`
3. Run `flutter clean` and rebuild

### Problem: "Can't find SHA certificate fingerprints section"

**Solution:**
1. Make sure you're in **Project Settings** (not App Settings)
2. Scroll all the way down to **Your apps**
3. Click on your Android app to expand it
4. SHA section is below the app package name

### Problem: "Download button is grayed out"

**Solution:**
1. Click **Save** after adding SHA-1
2. Wait 5 seconds for Firebase to process
3. Refresh the page
4. Try downloading again

---

## ✅ Success Indicators

After fixing, you should see:

1. **In Logs**: No more `ApiException: 10` errors
2. **In App**: Google account picker appears when clicking "Sign in with Google"
3. **In Firestore**: New user document created after successful sign-in
4. **In Firebase Auth**: User listed in Authentication → Users tab

---

## 📞 Need Help?

If you're still having issues:

1. **Check Logs**: Look for `GoogleSignIn` or `ApiException` in logs
2. **Verify Package Name**: Make sure Firebase app uses `com.example.training_app_v2`
3. **Check google-services.json**: Open file and verify `oauth_client` is not empty
4. **Try Release Build**: Sometimes debug builds have caching issues

---

**Last Updated**: October 16, 2025
**Status**: ⚠️ **ACTION REQUIRED** - Add SHA-1 to Firebase Console
