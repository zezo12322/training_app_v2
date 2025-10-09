## Release Checklist (MVP)

### Pre-Deploy
- [ ] Update version in `pubspec.yaml` (semver + build number)
- [ ] Run `flutter clean && flutter pub get`
- [ ] Run tests `flutter test` (all green)
- [ ] `flutter gen-l10n` succeeds (no fallback extensions left)
- [ ] Verify no TODOs blocking (grep for TODO/FIXME)

### Firebase
- [ ] `firebase use <prod>` selected
- [ ] Deploy rules: `firebase deploy --only firestore:rules`
- [ ] Deploy indexes: `firebase deploy --only firestore:indexes` (or automatic) 
- [ ] Deploy functions: `firebase deploy --only functions`
- [ ] App Check configured (optional but recommended)
- [ ] Crashlytics & Analytics enabled (dart define / initialization)

### Integrity
- [ ] user_points not directly writable from client (rules confirmed)
- [ ] Cloud Function onPointEventCreate working (manual event test)
- [ ] Badge auto-award idempotent (duplicate event test)
- [ ] Daily streak recorded once per day

### UI/UX
- [ ] Badges overview accessible from course screen
- [ ] Progress card shows level & next badge info
- [ ] Arabic & English localization spot-checked
- [ ] Adaptive icons & splash verified (Android/iOS)

### Store Readiness
- [ ] Privacy Policy link present
- [ ] About screen includes version & contact email
- [ ] App size acceptable (analyze if >50MB)
- [ ] Keystore / code signing set up (Android) / Archive build (iOS)

### Final
- [ ] Internal testing track build published
- [ ] Smoke test on real device (login, quiz, task, streak, badge)
- [ ] Tag release in VCS (git tag vX.Y.Z)
- [ ] Create release notes summarizing changes

---
Generated automatically; adapt as needed for future iterations.