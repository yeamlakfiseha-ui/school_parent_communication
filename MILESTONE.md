# Milestone 1 — group review draft

**Status:** Implementation is ready for group review on the local `codex/m1-implementation` branch. The final `m1` tag has not been created. Rerun the checks on the final merged commit before tagging and submitting.

## Done

- Built the Parent, Teacher, School Leader, and App Administrator destinations as usable screens with role-aware `go_router` navigation. Child detail and term summary routes take a student ID parameter.
- Added made-up attendance, grade, behavior, check-in/out, announcement, schedule, and message records through in-memory repositories and Riverpod providers.
- Added teacher attendance controls, grade and behavior forms, a QR-scan walkthrough, parent record tabs and summary, messages, school updates and calendar, school overview, and user administration with parent-child links and simple pasted-CSV import.
- Added Freezed models for school records and retained the existing Freezed `User` and `Student` models.
- Added eight tests covering data updates and navigation from login into Parent and Teacher screens.
- Confirmed the existing `proposal` tag points to the proposal merge commit `7efb564e76c6699a401071f8199a3768104df454`.

## Not done or limited in this milestone

- QR scanning is represented by a student-selection demo flow; it does not request camera access or read a real QR code.
- The term summary is a template generated from sample records; it does not call a hosted AI service.
- All app data is in memory and resets when the app restarts. Firebase, REST calls, local persistence, push notifications, and file-picker CSV import are not included.
- The group must verify PR authorship and review records on GitHub, complete the individual AI declarations, review this self-score, merge the group work, and run the final checks before creating `m1`.
- This local branch has not been pushed, and no `m1` tag has been created.

## Pull requests authored and reviewed

The PR numbers below come from merge messages in the local repository history. Git history does not show who reviewed each PR, and a merge commit alone does not prove the PR author. Confirm the author and reviewers on the linked GitHub PR pages before submission. “Not found in local history” does not rule out activity in another repository or unmerged PR.

| Member | PRs found in local merge history (verify authorship) | PRs reviewed |
|---|---|---|
| Tamirat Petros (`Tamirat-Petros`) | [#4](https://github.com/yeamlakfiseha/school_parent_communication/pull/4), [#5](https://github.com/yeamlakfiseha/school_parent_communication/pull/5) | Not available in local Git history; verify on GitHub |
| Yeamlak Fiseha (`yeamlakfiseha-ui`) | [#1](https://github.com/yeamlakfiseha/school_parent_communication/pull/1), [#2](https://github.com/yeamlakfiseha/school_parent_communication/pull/2), [#3](https://github.com/yeamlakfiseha/school_parent_communication/pull/3) | Not available in local Git history; verify on GitHub |
| Surafel Kassa (`Surafel750`) | No PR found in this checkout’s merge history; confirm with the member | Not available in local Git history; verify on GitHub |
| Wakgari Eshetu (`Wakgari-Eshetu`) | No PR found in this checkout’s merge history; confirm with the member | Not available in local Git history; verify on GitHub |

## Draft self-score — group confirmation required

| Criterion | Draft score | Evidence |
|---|---:|---|
| All proposed screens present and navigable (3) | 3/3 | The proposal destinations have role-aware routes and usable in-memory walkthroughs; QR scanning and the AI summary are clearly represented as demos. |
| Feature-first structure; state in providers, not widgets (2) | 2/2 | Feature folders contain Freezed record models, repository interfaces, in-memory implementations, and Riverpod state controllers. |
| Tests present; analyzer and tests clean (1) | 1/1 | Eight tests pass, and `flutter analyze --fatal-infos` reports no issues in this local tree. |
| Repository hygiene (1) | 0/1 pending group workflow | This feature branch is ready for review, but it is not pushed or merged and the local history does not confirm PR reviews by all members. |
| Individual oral check (3) | 0/3 pending | The instructor has not held the individual checks yet. |
| **Total (10)** | **6/10 draft** | **Re-score as a group after checking the PR records and before tagging.** |

## One change before Milestone 2

Agree on shared model and provider interfaces before parallel screen work starts, then keep each member’s changes in a small reviewed PR.

## Verification output

Commands run locally on 27 November 2026 with Flutter 3.47.7. These results are for the current untagged branch, not the final tagged commit.

### `flutter analyze --fatal-infos`

```text
Analyzing ParentLink-m1...
No issues found! (ran in 18.4s)
```

### `flutter test`

```text
00:00 +0: loading test/app_navigation_test.dart
00:00 +0: loads the made-up school records from the in-memory repository
00:00 +1: parent can open the child detail screen from the drawer
00:00 +2: parent can open the child detail screen from the drawer
00:00 +3: parent can open the child detail screen from the drawer
00:00 +4: parent can open the child detail screen from the drawer
00:00 +5: parent can open the child detail screen from the drawer
00:00 +6: parent can open the child detail screen from the drawer
00:02 +7: teacher can navigate to the report entry form
00:03 +8: All tests passed!
```
