# 🎯 QUICK START - Course Wall Testing

## 🚀 Start Testing NOW!

### Option 1: Run the App
```bash
cd g:\training_app_v2
flutter run
```

### Option 2: Test on Device
```bash
flutter run -d <device-id>
```

---

## ✅ What's Ready to Test

### 1. Basic Flow (Trainee):
1. Login as trainee
2. Open any course
3. See posts on the wall
4. Tap reaction button → choose emoji
5. Tap comment count → see comments
6. Type comment → send
7. Pull down to refresh

### 2. Trainer Flow:
1. Login as trainer
2. Open your course
3. Write a new post
4. Tap ⋮ on any post → Pin it
5. See pinned posts on top (📌)
6. Tap ⋮ → Delete a post

### 3. Real-time Test:
1. Open same course on 2 devices
2. Add reaction on device 1
3. See it update instantly on device 2

---

## 🎨 What You'll See

### WallPostCard:
```
┌─────────────────────────────────┐
│ 👤 Ahmad Ahmed    📌  (معدّل)   │ ⋮
│ منذ دقيقتين                     │
│                                  │
│ هذا منشور تجريبي مع محتوى طويل│
│ يحتوي على عدة أسطر...          │
│                                 │
│ [Image if exists]               │
│─────────────────────────────────│
│ 👍❤️🎉 12                        │ 5 تعليقات
│─────────────────────────────────│
│ 👍 إعجاب         💬 تعليق       │
└─────────────────────────────────┘
```

### Reaction Picker:
```
┌─────────────────────────┐
│   اختر تفاعلك          │
│                         │
│  👍    ❤️    🎉        │
│  💪    👏    🔥        │
│                         │
└─────────────────────────┘
```

### Comments Sheet:
```
┌─────────────────────────┐
│ التعليقات            ✕ │
├─────────────────────────┤
│ 👤 Sara Ali             │
│    منذ ساعة             │
│    تعليق رائع!          │
├─────────────────────────┤
│ 👤 Mohamed Hassan       │
│    منذ 5 دقائق          │
│    شكراً على الشرح     │
└─────────────────────────┘
│ اكتب تعليقاً...    📤  │
└─────────────────────────┘
```

---

## 🐛 Known Issues (Non-blocking)

1. ⚠️ No nested replies yet (flat comments only)
2. ⚠️ Can't edit posts/comments yet
3. ⚠️ No media upload yet
4. ⚠️ All comments load at once (no pagination)

**These are planned for Days 3-5** ✅

---

## 📱 Test Scenarios

### Scenario 1: Add Post & React
```
1. Open course as trainee
2. Write: "مرحباً بالجميع!"
3. Send
4. Tap reaction button
5. Choose 👍
6. See reaction appear
```

### Scenario 2: Comment Flow
```
1. Tap "X تعليق" on any post
2. Type: "تعليق تجريبي"
3. Send
4. See comment appear at bottom
5. Tap delete (trash icon)
6. Confirm
7. See comment disappear
```

### Scenario 3: Pin Post (Trainer)
```
1. Login as trainer
2. Open your course
3. Tap ⋮ on any post
4. Select "تثبيت"
5. See 📌 indicator
6. See post jump to top
7. Tap ⋮ → "إلغاء التثبيت"
8. See post return to normal position
```

---

## 🎯 Success Criteria

All should work:
- [x] Posts display
- [x] Reactions add/remove
- [x] Comments open
- [x] Add comment
- [x] Delete comment
- [x] Pin/Unpin (trainer)
- [x] Real-time updates
- [x] Pull to refresh
- [x] Animations smooth
- [x] No crashes

---

## 🆘 Troubleshooting

### Issue: No posts appear
**Fix:** Pull to refresh or restart app

### Issue: Can't add reaction
**Fix:** Make sure you're logged in

### Issue: Comments don't open
**Fix:** Check postId is valid

### Issue: Real-time not working
**Fix:** Check internet connection

---

## 📞 Report Issues

Found a bug? Document:
1. Steps to reproduce
2. Expected behavior
3. Actual behavior
4. Screenshots (if applicable)
5. Device/OS

---

**Happy Testing! 🎉**
