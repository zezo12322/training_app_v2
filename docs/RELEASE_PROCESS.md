# Release & Deployment Process

## Environments
| Env | Purpose | Notes |
|-----|---------|-------|
| dev | Local + emulators | Fast iteration, no permanent data |
| staging | Pre-prod, feature flag validation | Mirrors prod security rules |
| prod | Live users | Strict change control |

## Semantic Versioning
Format: vMAJOR.MINOR.PATCH
- MAJOR: Breaking schema/rule shifts
- MINOR: New features (non-breaking)
- PATCH: Fixes / internal improvements

## Feature Flag Rollout Steps
1. Dark launch (flag=false, code deployed)
2. Internal enable (super_admin only)
3. Limited cohort (future: percentage rollout) *(placeholder)*
4. Full enable
5. Cleanup (remove dead code paths if stable)

## Pre-Release Checklist (Automatable)
- [ ] All unit & integration tests green
- [ ] Firestore rules diff reviewed (no unintended widening)
- [ ] build_runner artifacts up-to-date
- [ ] Lint passes (no new warnings in critical dirs)
- [ ] Emulator rule simulation suite passes
- [ ] CHANGELOG updated
- [ ] Bump version & tag

## Deployment Steps (Flutter + CF)
1. Tag commit: `git tag vX.Y.Z && git push --tags`
2. Deploy Cloud Functions: `firebase deploy --only functions` (after dry-run in staging)
3. Deploy Firestore rules & indexes: `firebase deploy --only firestore:rules,firestore:indexes`
4. Release mobile/web build (platform-specific pipelines)
5. Post-deploy verification: health checks, open alerts count, feature flag states

## Rollback Playbook
| Scenario | Action |
|----------|--------|
| Logic bug (non-schema) | Toggle feature flag off, redeploy patch if needed |
| Rules regression | Re-deploy previous rules tag, invalidate clients (optional) |
| CF widespread failure | Rollback to previous Functions version (firebase console) |
| Data corruption risk | Disable writes (temp rule allow read only), run audit, restore from backup/export |

## Observability Hooks
- Correlation ID enforced on callables
- Deployment annotation log record: { version, deployer, ts }

## Backlog
- [ ] Automate checklist via CI script
- [ ] Add CHANGELOG.md auto append script
- [ ] Introduce canary device testing step
