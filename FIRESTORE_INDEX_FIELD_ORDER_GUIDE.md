# Firestore Composite Index Field Ordering Guide

## The Problem
When creating composite indexes for Firestore queries, **field order matters**! Getting the order wrong results in FAILED_PRECONDITION errors even after deploying indexes.

## Real-World Example: Leaderboard Query

### The Query (from `leaderboard_repository.dart`)
```dart
Query query = _firestore
    .collection('user_course_progress')
    .where('courseId', isEqualTo: courseId)
    .where('lastActivityDate', isGreaterThanOrEqualTo: startDate)
    .orderBy('totalPoints', descending: true)
    .limit(50);
```

### First Attempt (❌ WRONG)
```json
{
  "collectionGroup": "user_course_progress",
  "fields": [
    { "fieldPath": "courseId", "order": "ASCENDING" },
    { "fieldPath": "lastActivityDate", "order": "ASCENDING" },
    { "fieldPath": "totalPoints", "order": "DESCENDING" }
  ]
}
```

**Why it failed**: Firestore requires fields in a specific order based on how they're used in the query.

### Correct Index (✅ RIGHT)
```json
{
  "collectionGroup": "user_course_progress",
  "fields": [
    { "fieldPath": "courseId", "order": "ASCENDING" },
    { "fieldPath": "totalPoints", "order": "DESCENDING" },
    { "fieldPath": "lastActivityDate", "order": "DESCENDING" }
  ]
}
```

## Firestore Index Field Ordering Rules

### Rule 1: Equality Filters First
All fields used with `==` (equality) must come **first** in the index.

```dart
.where('courseId', isEqualTo: courseId)  // ← Goes FIRST in index
```

### Rule 2: Explicit OrderBy Fields Next
Fields explicitly mentioned in `.orderBy()` come **after equality filters**.

```dart
.orderBy('totalPoints', descending: true)  // ← Goes SECOND in index
```

### Rule 3: Range Filter Fields Last
Fields used with `>`, `<`, `>=`, `<=`, `!=`, `in`, `array-contains` come **last**.

```dart
.where('lastActivityDate', isGreaterThanOrEqualTo: startDate)  // ← Goes LAST in index
```

### Rule 4: Implicit OrderBy
If you use a range filter without an explicit `.orderBy()` on that field, **Firestore adds it automatically**. Your index must account for this!

**Example**:
```dart
// Your code
.where('lastActivityDate', isGreaterThanOrEqualTo: startDate)
.orderBy('totalPoints', descending: true)

// Firestore interprets as
.where('lastActivityDate', isGreaterThanOrEqualTo: startDate)
.orderBy('totalPoints', descending: true)
.orderBy('lastActivityDate', descending: true)  // ← IMPLICIT!
```

## Common Mistakes

### ❌ Mistake 1: Range Field Before OrderBy Field
```json
{
  "fields": [
    { "fieldPath": "courseId", "order": "ASCENDING" },
    { "fieldPath": "lastActivityDate", "order": "ASCENDING" },  // ❌ Range field
    { "fieldPath": "totalPoints", "order": "DESCENDING" }       // ❌ OrderBy field
  ]
}
```

**Fix**: Swap them - orderBy first, then range:
```json
{
  "fields": [
    { "fieldPath": "courseId", "order": "ASCENDING" },
    { "fieldPath": "totalPoints", "order": "DESCENDING" },      // ✅ OrderBy field
    { "fieldPath": "lastActivityDate", "order": "DESCENDING" }  // ✅ Range field
  ]
}
```

### ❌ Mistake 2: Wrong Sort Direction
```json
{
  "fields": [
    { "fieldPath": "lastActivityDate", "order": "ASCENDING" }   // ❌ Wrong direction
  ]
}
```

If your query uses `descending: true`, the index must be `DESCENDING`:
```json
{
  "fields": [
    { "fieldPath": "lastActivityDate", "order": "DESCENDING" }  // ✅ Matches query
  ]
}
```

### ❌ Mistake 3: Missing Implicit OrderBy
```dart
// Query
.where('createdAt', isGreaterThan: yesterday)
.orderBy('priority', descending: true)
```

```json
// ❌ Missing createdAt in index
{
  "fields": [
    { "fieldPath": "priority", "order": "DESCENDING" }
  ]
}

// ✅ Correct - includes implicit orderBy on range field
{
  "fields": [
    { "fieldPath": "priority", "order": "DESCENDING" },
    { "fieldPath": "createdAt", "order": "ASCENDING" }  // ← Must be included!
  ]
}
```

## How to Debug Index Order Issues

### Step 1: Read the Error Message
```
Listen for Query(...where courseId==... and lastActivityDate>=... 
order by -totalPoints, -lastActivityDate, -__name__) failed
```

The `order by` clause shows **exactly** what Firestore expects:
- `-totalPoints` = `totalPoints DESCENDING`
- `-lastActivityDate` = `lastActivityDate DESCENDING`
- `-__name__` = auto-added by Firestore (for pagination)

### Step 2: Extract Field Order from Error
```
order by -totalPoints, -lastActivityDate
```

This translates to:
```json
{
  "fields": [
    { "fieldPath": "courseId", "order": "ASCENDING" },         // ← From where clause
    { "fieldPath": "totalPoints", "order": "DESCENDING" },     // ← From order by
    { "fieldPath": "lastActivityDate", "order": "DESCENDING" } // ← From order by (implicit)
  ]
}
```

### Step 3: Click the Console Link
Firestore error messages include a direct link to create the index:
```
You can create it here: https://console.firebase.google.com/v1/r/project/.../firestore/indexes?create_composite=...
```

Click it! It will show you the **exact** index Firebase wants.

### Step 4: Copy to firestore.indexes.json
Copy the field configuration from the console and add it to your local file.

## Quick Reference Chart

| Query Operation | Index Field Position | Example |
|----------------|---------------------|---------|
| `where('x', isEqualTo: ...)` | First | `{ "fieldPath": "x", "order": "ASCENDING" }` |
| `orderBy('y')` | After equalities | `{ "fieldPath": "y", "order": "ASCENDING" }` |
| `orderBy('y', descending: true)` | After equalities | `{ "fieldPath": "y", "order": "DESCENDING" }` |
| `where('z', isGreaterThan: ...)` | Last | `{ "fieldPath": "z", "order": "ASCENDING" }` |

**Pro Tip**: Firestore always adds `__name__` at the end for tie-breaking. You don't need to include it in `firestore.indexes.json` - it's automatic!

## Best Practices

1. **Always deploy from local file**: Never manually create indexes in Console, as they won't be tracked in version control
2. **Test with emulator first**: Use Firebase Emulator Suite to catch missing indexes before production deployment
3. **Use error links wisely**: Click the console link from errors to see the exact index needed, then add it to your local file
4. **Document why**: Add comments in your query code explaining which index it uses
5. **Monitor build time**: Large collections can take 10+ minutes to build indexes

## Training App v2 Leaderboard Solution

**Final working index**:
```json
{
  "collectionGroup": "user_course_progress",
  "queryScope": "COLLECTION",
  "fields": [
    { "fieldPath": "courseId", "order": "ASCENDING" },
    { "fieldPath": "totalPoints", "order": "DESCENDING" },
    { "fieldPath": "lastActivityDate", "order": "DESCENDING" }
  ]
}
```

**Deployed**: October 16, 2025  
**Status**: Building (2-10 minutes)  
**Use case**: Weekly/Monthly leaderboards with time-based filtering

---
**Learn More**: https://firebase.google.com/docs/firestore/query-data/index-overview
