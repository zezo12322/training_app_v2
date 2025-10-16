# Sign-Out Crash Fix

## Problem
App crashed after user signed out with "Lost connection to device" error. Firestore logs showed:
```
W/Firestore: Listen for Query(polls/...) failed: Status{code=PERMISSION_DENIED}
W/Firestore: Listen for Query(user_points/...) failed: Status{code=PERMISSION_DENIED}
```

## Root Cause
When users signed out, **Firestore stream providers continued listening** to collections they no longer had permission to access:
1. `userPointsStreamProvider` - Watches `user_points/{userId}`
2. `pollProvider` - Watches `polls/{pollId}`

These providers were **missing `.autoDispose`**, so they kept listening even after widgets unmounted and users signed out.

## Solution

### 1. Added `.autoDispose` to Stream Providers
Updated providers to automatically clean up when no longer watched:

**File: `lib/providers/gamification_providers.dart`**
```dart
// Before
final userPointsStreamProvider = StreamProvider.family<UserPoints?, String>((
  ref,
  userId,
) { ... });

// After
final userPointsStreamProvider = StreamProvider.family.autoDispose<UserPoints?, String>((
  ref,
  userId,
) { ... });
```

**File: `lib/providers/poll_providers.dart`**
```dart
// Before
final pollProvider = StreamProvider.family<Poll?, String>((ref, pollId) { ... });

// After
final pollProvider = StreamProvider.family.autoDispose<Poll?, String>((ref, pollId) { ... });
```

### 2. Added Provider Cleanup on Sign-Out
Enhanced `AuthWrapper` to automatically invalidate providers when users sign out:

**File: `lib/screens/auth_wrapper.dart`**
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final authState = ref.watch(authStateProvider);

  // Clean up providers when user signs out
  ref.listen(authStateProvider, (previous, next) {
    next.whenData((user) {
      if (user == null && previous?.value != null) {
        // User just signed out - invalidate all data providers
        ref.invalidate(currentUserModelProvider);
      }
    });
  });

  return authState.when(...);
}
```

## Impact
- **Prevents PERMISSION_DENIED errors** after sign-out
- **Stops app crashes** when users log out
- **Cleans up Firestore listeners** automatically
- **Reduces memory usage** by disposing unused providers

## Testing
1. Run app and log in as any role
2. Navigate to screens with polls or gamification features
3. Tap logout button
4. App should return to login screen **without crashing**
5. No PERMISSION_DENIED errors in logs

## Pattern for Future Providers
**Always use `.autoDispose` for StreamProviders** that watch Firestore:
```dart
// ✅ CORRECT
final myStreamProvider = StreamProvider.autoDispose<T>((ref) { ... });
final myFamilyProvider = StreamProvider.family.autoDispose<T, Param>((ref, param) { ... });

// ❌ WRONG (will leak listeners)
final myStreamProvider = StreamProvider<T>((ref) { ... });
final myFamilyProvider = StreamProvider.family<T, Param>((ref, param) { ... });
```

---
**Fixed**: October 16, 2025
**Files Changed**: 3 files
- `lib/providers/gamification_providers.dart`
- `lib/providers/poll_providers.dart`  
- `lib/screens/auth_wrapper.dart`
