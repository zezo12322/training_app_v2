# Deploy Firestore Rules - URGENT FIX

## Problem
The app crashes with `PERMISSION_DENIED` when creating polls because the Firestore security rules don't allow the optional fields (`allowMultipleVotes`, `showResultsBeforeVoting`, `endsAt`).

## Solution Applied
Updated `firestore.rules` (lines 762-787) to allow these optional fields.

## How to Deploy (Choose ONE method):

### Method 1: Firebase Console (Easiest)
1. Go to https://console.firebase.google.com/
2. Select your project
3. Go to **Firestore Database** → **Rules** tab
4. Copy the ENTIRE contents of `firestore.rules` file
5. Paste into the editor
6. Click **Publish**

### Method 2: Firebase CLI (If installed)
```bash
firebase deploy --only firestore:rules
```

### Method 3: VS Code Extension
1. Install "Firebase Explorer" extension
2. Right-click on `firestore.rules`
3. Select "Deploy Firestore Rules"

## Verification
After deploying, the poll creation should work without `PERMISSION_DENIED` errors.

## Changed Rules Section
```javascript
// OLD (line 769):
allow create: if isSignedIn() && 
  request.resource.data.createdBy == request.auth.uid &&
  request.resource.data.keys().hasAll(['question', 'options', 'createdBy', 'createdAt', 'totalVotes']) &&
  // ... validation ...

// NEW (lines 769-779):
allow create: if isSignedIn() && 
  request.resource.data.createdBy == request.auth.uid &&
  request.resource.data.keys().hasAll(['question', 'options', 'createdBy', 'createdAt', 'totalVotes']) &&
  // ... validation ...
  // Allow optional fields
  (!request.resource.data.keys().hasAny(['allowMultipleVotes']) || request.resource.data.allowMultipleVotes is bool) &&
  (!request.resource.data.keys().hasAny(['showResultsBeforeVoting']) || request.resource.data.showResultsBeforeVoting is bool) &&
  (!request.resource.data.keys().hasAny(['endsAt']) || request.resource.data.endsAt is timestamp);
```
