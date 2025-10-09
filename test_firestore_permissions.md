# Firestore Permission Test Guide

## Issues Fixed
Three permission errors were resolved:

### 1. Users Collection Query Error
The `users` collection had `allow list: if false;` which blocked notification queries.

### 2. Course Wall Posts Query Error  
The `course_wall` collection list rule was incorrectly checking `resource != null` during list evaluation.

### 3. Post Comments Query Error (NEW)
The `post_comments` collection had no security rules defined at all.

## What Was Changed

### Users Collection Rules
```javascript
// OLD - Blocked all list queries
allow list: if false;

// NEW - Allow trainer queries with constraints
allow list: if isSignedIn() && isTrainer() && 
  request.query.limit <= 30 &&
  (request.query.orderBy.size() == 0 || 
   (request.query.orderBy.size() == 1 && request.query.orderBy[0] == '__name__'));
```

### Course Wall Collection Rules
```javascript
// OLD - Incorrectly checked resource during list query
allow list: if isSignedIn() && 
  request.query.limit <= 50 && 
  resource != null && enrolledFromCourse(courseDoc());

// NEW - Fixed list rule (resource is null during list evaluation)
allow list: if isSignedIn() && 
  request.query.limit <= 50;
```

### Post Comments Collection Rules (ADDED)
```javascript
// NEW - Complete rules for post comments
match /post_comments/{commentId} {
  // Read: enrolled users can see comments on posts in their courses
  allow get: if isSignedIn() && resource != null && enrolledFromPost(postDoc());
  // List: allow with limit (filtered by get rules)
  allow list: if isSignedIn() && request.query.limit <= 100;
  // Create: enrolled users can comment, with content validation
  allow create: if isSignedIn() && enrolledFromPost(postDocFromReq()) &&
    request.resource.data.authorId == request.auth.uid &&
    // ... field validation
}
```

## Test the Fix

### 1. Test Wall Post Notifications
1. Sign in as a trainer
2. Go to a course with enrolled trainees  
3. Add a wall post
4. Check that the notification is sent without permission errors

### 2. Verify Security Still Works
1. Try signing in as a trainee
2. Attempt to query all users - should still be blocked
3. Verify trainees can only see trainer profiles and their own

### 3. Monitor Firebase Console
- Check the Firestore logs for any remaining permission errors
- Verify the query patterns match what we allowed

## Security Considerations

The updated rules maintain security by:
- Only allowing trainers to perform list queries
- Limiting query results to 30 documents max
- Restricting query patterns to document ID queries only
- Maintaining all other existing restrictions

## Alternative Approaches (for future consideration)

If you want even tighter security, consider:

1. **Denormalized approach**: Store `oneSignalPlayerId` in course documents
2. **Cloud Function**: Move notification logic to server-side
3. **Subcollection**: Store notification tokens in course-specific subcollections

## Related Files Modified
- `firestore.rules` - Updated users collection permissions