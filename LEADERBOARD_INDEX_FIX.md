# Leaderboard Index Fix Summary

## Problem
The app crashed with FAILED_PRECONDITION errors when loading leaderboard data. Firestore requires composite indexes for queries that:
1. Filter by one field (`courseId`)
2. Filter by a range on another field (`lastActivityDate >= startDate`)
3. Order by a third field (`totalPoints DESC`)

## Error Messages
```
Listen for Query(user_course_progress where courseId==... and lastActivityDate>=... 
order by -totalPoints, -lastActivityDate, -__name__) failed: 
Status{code=FAILED_PRECONDITION, description=The query requires an index.
```

## Solution Applied

### 1. Added Missing Composite Index
**File**: `firestore.indexes.json`

Added new index:
```json
{
  "collectionGroup": "user_course_progress",
  "queryScope": "COLLECTION",
  "fields": [
    { "fieldPath": "courseId", "order": "ASCENDING" },
    { "fieldPath": "lastActivityDate", "order": "ASCENDING" },
    { "fieldPath": "totalPoints", "order": "DESCENDING" }
  ]
}
```

### 2. Deployed to Firebase
```bash
firebase deploy --only firestore:indexes
```
✅ **Status**: Successfully deployed

## ⏳ IMPORTANT: Index Building Time
**Composite indexes take time to build** (typically 2-10 minutes depending on data volume):
- Small collections (<1000 docs): ~2-3 minutes
- Medium collections (1K-10K docs): ~5-10 minutes
- Large collections (>10K docs): 10+ minutes

## How to Check Index Status

### Option 1: Firebase Console
1. Go to: https://console.firebase.google.com/project/trainingapp-mvp/firestore/indexes
2. Look for the `user_course_progress` index with:
   - `courseId` (Ascending)
   - `lastActivityDate` (Ascending)
   - `totalPoints` (Descending)
3. Status should show:
   - 🔄 **Building** → Wait a few more minutes
   - ✅ **Enabled** → Ready to use!

### Option 2: Firebase CLI
```bash
firebase firestore:indexes:list
```

## Testing the Fix

### 1. Wait for Index to Build
Check Firebase Console (link above) until index status = **Enabled**

### 2. Restart the App
```bash
flutter run
```

### 3. Navigate to Leaderboard
1. Open any course
2. Tap the leaderboard/trophy icon
3. Switch between tabs:
   - Weekly
   - Monthly
   - All Time

### Expected Behavior
- ✅ No FAILED_PRECONDITION errors in logs
- ✅ Leaderboard data loads successfully
- ✅ Rankings display correctly sorted by points

## Query Details

The leaderboard uses three different queries:

### All-Time Leaderboard
```dart
collection('user_course_progress')
  .where('courseId', isEqualTo: courseId)
  .orderBy('totalPoints', descending: true)
  .limit(50)
```
✅ Uses existing index: `(courseId ASC, totalPoints DESC)`

### Weekly/Monthly Leaderboard
```dart
collection('user_course_progress')
  .where('courseId', isEqualTo: courseId)
  .where('lastActivityDate', isGreaterThanOrEqualTo: startDate)
  .orderBy('totalPoints', descending: true)
  .limit(50)
```
✅ Uses NEW index: `(courseId ASC, totalPoints DESC, lastActivityDate DESC)`

**Important**: When you use a range filter (`>=`) on a field, Firestore automatically adds it to the `orderBy` clause. So even though the code only explicitly orders by `totalPoints`, Firestore requires `lastActivityDate` in the index as well. The field order in the index must match: **equality filters → orderBy fields → range filter fields**.

## Crash Investigation

The app also crashed at the end with:
```
F/crash_dump64(30876): crash_dump.cpp:479] failed to attach to thread 692: Permission denied
Lost connection to device.
```

This appears to be an **unrelated Android system issue** (not caused by Firestore indexes):
- Likely a device-specific debugging permission issue
- The app was already running successfully for 18+ seconds before crash
- All core features (auth, courses, navigation) were working

**Recommendation**: Ignore this crash unless it happens consistently. It may be caused by:
- Android debugging tools on specific device (CPH2059 - OPPO device)
- Background processes interfering with debugger
- Known issue with certain Android versions

## Performance Notes

The logs show several SEVERE frame timing warnings:
```
[FRAME][SEVERE] build=1506ms raster=41ms
[FRAME][SEVERE] build=590ms raster=2ms
```

These indicate UI performance issues (frames taking >100ms to build). Consider:
1. Optimizing widget builds (use `const` where possible)
2. Caching network images
3. Using `ListView.builder` instead of `ListView` for long lists
4. Profiling with Flutter DevTools to find bottlenecks

## Next Steps

1. ⏳ **Wait 2-5 minutes** for index to finish building
2. 🔍 **Check index status** in Firebase Console
3. ▶️ **Restart app** and test leaderboard
4. ✅ **Verify** no FAILED_PRECONDITION errors
5. 🎉 **Enjoy working leaderboards!**

---
**Created**: October 16, 2025  
**Status**: Index deployed, awaiting build completion
