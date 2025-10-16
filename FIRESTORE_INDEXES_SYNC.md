# Firestore Indexes Synchronization Guide

## Overview
This document explains how to keep your local `firestore.indexes.json` file synchronized with the indexes deployed to Firebase.

## Problem
When deploying indexes, Firebase may warn about indexes that exist in production but are missing from your local file:

```
i  firestore: The following indexes are defined in your project but are not present in your firestore indexes file:
        (course_wall) -- (courseId,ASCENDING) (isArchived,ASCENDING) (isPinned,DESCENDING) (createdAt,DESCENDING)
        (departments) -- (companyId,ASCENDING) (name,ASCENDING)
```

## Why This Happens
- Indexes can be created automatically via Firebase Console
- Team members may deploy indexes from their machines
- Indexes created via auto-generated links (from FAILED_PRECONDITION errors)
- Manual index creation during development/testing

## Solution: Always Choose "No" When Asked to Delete

When Firebase asks:
```
✔ Would you like to delete these indexes? Selecting no will continue the rest of the deployment.
```

**Best Practice**: Select **No** and then manually add the missing indexes to your local file.

## How to Sync Indexes

### Step 1: List Current Deployed Indexes
```bash
firebase firestore:indexes
```

This shows all indexes currently deployed to Firebase (with their exact field configurations).

### Step 2: Identify Missing Indexes
Compare the output with your local `firestore.indexes.json` file.

### Step 3: Add Missing Indexes
Add any missing indexes to `firestore.indexes.json` in alphabetical order by collection name.

Example:
```json
{
  "collectionGroup": "departments",
  "queryScope": "COLLECTION",
  "fields": [
    { "fieldPath": "companyId", "order": "ASCENDING" },
    { "fieldPath": "name", "order": "ASCENDING" }
  ]
}
```

### Step 4: Redeploy
```bash
firebase deploy --only firestore:indexes
```

Now your local file matches production! ✅

## Recently Added Indexes (October 16, 2025)

### 1. Departments Index
**Purpose**: Efficiently query departments within a company, sorted by name
```json
{
  "collectionGroup": "departments",
  "queryScope": "COLLECTION",
  "fields": [
    { "fieldPath": "companyId", "order": "ASCENDING" },
    { "fieldPath": "name", "order": "ASCENDING" }
  ]
}
```

**Use Case**: Department selection dropdowns, department management screens

### 2. Course Wall - Archive/Pin Filter
**Purpose**: Query wall posts with archive and pin status
```json
{
  "collectionGroup": "course_wall",
  "queryScope": "COLLECTION",
  "fields": [
    { "fieldPath": "courseId", "order": "ASCENDING" },
    { "fieldPath": "isArchived", "order": "ASCENDING" },
    { "fieldPath": "isPinned", "order": "DESCENDING" },
    { "fieldPath": "createdAt", "order": "DESCENDING" }
  ]
}
```

**Use Case**: 
- Show non-archived posts, with pinned posts first
- Archive management screens
- Wall post filtering

### 3. User Course Progress - Leaderboard
**Purpose**: Leaderboard queries with time-based filtering
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

**Use Case**: Weekly/Monthly leaderboards (filter by date, order by points)

## Automation Opportunity

Consider creating a pre-deployment check script:

```bash
# check-indexes.sh
echo "Fetching current Firebase indexes..."
firebase firestore:indexes > deployed-indexes.json

echo "Comparing with local firestore.indexes.json..."
# Add comparison logic here

echo "✅ Indexes are synchronized"
```

## Best Practices

1. **Never delete indexes** without team discussion (they may be used in production)
2. **Always check** `firebase firestore:indexes` before deploying
3. **Document** why each index exists (add comments in code where query is used)
4. **Test locally** with Firebase Emulator Suite to catch missing indexes early
5. **Monitor** Firebase Console → Firestore → Indexes for "Building" status after deployment

## Troubleshooting

### Index Build Failed
**Symptom**: Index status stuck in "Building" or shows "Error"
**Solution**: Delete and recreate the index via Firebase Console

### Query Still Fails After Deployment
**Symptom**: FAILED_PRECONDITION error persists
**Cause**: Index still building (takes 2-10 minutes)
**Solution**: Wait and retry, or check Firebase Console for index status

### Duplicate Indexes
**Symptom**: Multiple similar indexes for same collection
**Solution**: Review and consolidate - Firebase optimizes automatically but cleanup helps maintainability

---
**Last Updated**: October 16, 2025  
**Indexes in Production**: 45  
**Collections with Indexes**: 23
