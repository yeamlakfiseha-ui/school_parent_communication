# Milestone 1 — draft for group review

**Status:** Draft only. The `m1` tag has not been created. The analyzer and test output below came from the current untagged working tree; rerun both on the final tagged commit before submission.

## Done

- Set up the Flutter project structure, theme, Riverpod state, and role-aware `go_router` navigation.
- Added Freezed `User` and `Student` models, repository interfaces, in-memory repositories, and the login flow.
- Resolved dependencies and generated the Freezed model files with Flutter 3.47.7.
- The remote `proposal` tag points to `7efb564e76c6699a401071f8199a3768104df454`, a merge commit whose changed file is `PROPOSAL.md`.

## Not done

- The twelve proposal destinations are reachable through role-specific routes, but most currently show placeholder content rather than completed screens.
- No test files are present, so `flutter test` does not pass.
- Only Yeamlak has authored PRs in the repository; PR authoring and review participation for all four members is incomplete.
- The `m1` tag and the final tagged-commit command output are pending.
- The group must confirm the draft self-score and complete individual AI-use declarations.

## Pull requests authored and reviewed

GitHub PR records checked on 26 November 2026. The two recorded PRs were merged with merge commits; no submitted review records were found for them.

| Member | PRs authored | PRs reviewed |
|---|---|---|
| Tamirat Petros | None recorded | None recorded |
| Yeamlak Fiseha (`yeamlakfiseha-ui`) | [#1](https://github.com/yeamlakfiseha-ui/school_parent_communication/pull/1), [#2](https://github.com/yeamlakfiseha-ui/school_parent_communication/pull/2) | None recorded |
| Surafel Kassa | None recorded | None recorded |
| Wakgari Eshetu | None recorded | None recorded |

## Draft self-score — confirm with the group before tagging

| Criterion | Draft score | Evidence |
|---|---:|---|
| All proposed screens present and navigable (3) | 1/3 | All twelve destinations have role-guarded routes, but most route builders still render placeholder pages. |
| Feature-first structure and state in providers (2) | 1/2 | Auth state uses a Riverpod notifier and the auth/student domains have repository interfaces, while the student flow is not yet wired into a provider-backed screen. |
| Tests present and analyzer/tests clean (1) | 0/1 | `flutter analyze --fatal-infos` passes, but there are no test files and `flutter test` exits with an error. |
| Repository hygiene (1) | 0/1 | Two proposal PRs were merged with merge commits, but the other three members have no recorded authored or reviewed PRs yet. |
| Individual oral check (3) | 0/3 pending | No Milestone 1 oral-check results are available yet. |
| **Total (10)** | **2/10 draft** | **This draft needs group review before the milestone is tagged.** |

## Change before Milestone 2

Each member will author and review at least one small PR, with role-based screen work split across branches so the group can review it before merging.

## Verification output

These commands were run with Flutter 3.47.7 on the untagged working tree on 26 November 2026. Replace this section with fresh output from the final `m1` tagged commit before submission.

### `flutter analyze --fatal-infos`

```text
Analyzing Elective I...
No issues found! (ran in 15.9s)
```

### `flutter test`

```text
Test directory "test" not found.
```
