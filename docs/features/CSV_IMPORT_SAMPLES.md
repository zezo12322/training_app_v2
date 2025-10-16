# CSV Import Samples

Use the Bulk Import screen to apply batched updates to Firestore using a simple CSV format.

Format (header required):

```
collection,docId,field.path,value
```

- collection: top-level collection name (e.g., `courses`, `quizzes`, `institutions`).
- docId: target document ID (will be created if missing).
- field.path: dot-notated field path to set (nested maps supported).
- value: scalar (string/number/bool) or JSON for objects/arrays. If it contains commas, wrap it in double quotes.

Examples:

```
users,uid_123,displayName,Ahmed Ali
users,uid_123,role,trainer
users,uid_123,settings.emailOptIn,true

courses,course_1,title,Intro to Dart
courses,course_1,meta,"{\"level\":\"beginner\",\"durationMin\":90}"

institutions,inst_abc,name,Future Academy
institutions,inst_abc,active,true

skills,algo,name,Algorithms Basics
skills,algo,category,cs
skills,algo,priority,1

weekly_challenges,2025w41,targetType,complete_lessons
weekly_challenges,2025w41,targetValue,5
weekly_challenges,2025w41,scope,"{\"tenantType\":\"institution\",\"tenantId\":\"inst_abc\"}"
```

Notes:
- Writes must pass Firestore security rules; many analytical collections are server-only.
- Prefer batching related changes to the same document to reduce write ops.
- Large imports are chunked into batches of ~200 field sets internally.
- Ensure your admin role and tenant scope allow the changes you intend.
