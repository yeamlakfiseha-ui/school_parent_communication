# Milestone 1 — group review draft

**Status:** Implementation is ready for group review on the local `feature/milestone-1` branch. The final `m1` tag has not been created. Rerun the checks on the final merged `main` commit before tagging and submitting.

## Done

- Built all 12 proposed destinations across the Parent, Teacher, School Leader, and App Administrator roles as usable screens with role-aware `go_router` navigation. Child detail and term summary routes accept a `studentId` path parameter.
- Added Freezed models for attendance, grades, behavior reports, check-in/out records, announcements, schedule items, and messages (`lib/features/school_data/domain/school_record.dart`), alongside the existing Freezed `User` and `Student` models.
- Added in-memory repositories behind domain interfaces (`SchoolRepository`, `StudentRepository`, `UsersRepository`, `AuthRepository`) and Riverpod state providers (`schoolDataProvider`, `studentsProvider`, `usersProvider`, `linkedChildrenProvider`, `authControllerProvider`).
- Implemented Tamirat's teacher-side features (`TeacherHomeScreen` daily attendance controls and `ReportEntryScreen` for grades and behavior notes), plus the `QrScannerScreen` arrival log walkthrough, parent record tabs and template term summary, messaging, announcements and schedule, school overview grouped dynamically by grade and section, and user management with parent-child linking and simple pasted-CSV import.
- Added 11 unit and widget tests covering `schoolDataProvider`, `studentsProvider`, Parent and Teacher drawer navigation, Teacher attendance updates, and Teacher grade/behavior report submission.
- Confirmed the existing `proposal` tag points to the proposal merge commit `7efb564e76c6699a401071f8199a3768104df454`.

## Not done or limited in this milestone

- QR scanning is represented by a student-selection demo flow; it does not request camera access or read a real QR code.
- The term summary is a template generated from sample records; it does not call a hosted AI service.
- All app data is in memory and resets when the app restarts. Firebase, REST calls, local persistence, push notifications, and file-picker CSV import belong to Milestone 2 and later.
- The group must complete PR authoring and review records on GitHub for all four members, fill in the individual AI declarations in `AI_USAGE.md`, confirm this self-score, merge to `main`, and rerun the final checks before creating the `m1` tag.
- This local `feature/milestone-1` branch has not been pushed, and no `m1` tag has been created.

## Pull requests authored and reviewed

The PR numbers below come from merge messages in the local repository history (`origin`: `https://github.com/yeamlakfiseha/school_parent_communication.git`). Git history alone does not show who reviewed each PR; confirm authors and reviewers on GitHub before tagging `m1`.

| Member | PRs found in local merge history (verify authorship) | PRs reviewed |
|---|---|---|
| Tamirat Petros (`Tamirat-Petros`) | [#4](https://github.com/yeamlakfiseha/school_parent_communication/pull/4) (revert of #3), [#5](https://github.com/yeamlakfiseha/school_parent_communication/pull/5) (re-revert of #3); Milestone 1 feature PR pending push/merge | Pending (planned: Surafel's PR) |
| Yeamlak Fiseha (`yeamlakfiseha-ui`) | [#1](https://github.com/yeamlakfiseha/school_parent_communication/pull/1), [#2](https://github.com/yeamlakfiseha/school_parent_communication/pull/2), [#3](https://github.com/yeamlakfiseha/school_parent_communication/pull/3) | Pending (planned: Tamirat's PR) |
| Surafel Kassa (`Surafel750`) | No PR found in local merge history yet; confirm with the member | Pending (planned: Wakgari's PR) |
| Wakgari Eshetu (`Wakgari-Eshetu`) | No PR found in local merge history yet; confirm with the member | Pending (planned: Yeamlak's PR) |

## Draft self-score — group confirmation required

| Criterion | Draft score | Evidence |
|---|---:|---|
| All proposed screens present and navigable (3) | 3/3 | All 12 proposal destinations have role-aware routes and usable in-memory walkthroughs; QR scanning and the AI summary are clearly represented as demos. |
| Feature-first structure; state in providers, not widgets (2) | 2/2 | Feature folders contain Freezed models, repository interfaces, in-memory implementations, and Riverpod controllers (`schoolDataProvider`, `studentsProvider`, `usersProvider`, `authControllerProvider`). |
| Tests present; analyzer and tests clean (1) | 1/1 | Eleven unit and widget tests pass, and `flutter analyze --fatal-infos` reports no issues in this local tree. |
| Repository hygiene (1) | 0/1 pending group workflow | `feature/milestone-1` is not pushed or merged through individual member PRs with recorded peer reviews yet. |
| Individual oral check (3) | 0/3 pending | The instructor has not held the individual lab oral checks yet. |
| **Total (10)** | **6/10 draft** | **Re-score as a group after completing PR reviews and before tagging `m1`.** |

## One change before Milestone 2

Agree on shared model and provider interfaces before parallel screen work starts, then land each member's changes in small, peer-reviewed PRs rather than a single combined branch.

## Verification output

Commands run locally on 27 November 2026 with Flutter 3.47.7 on the untagged `feature/milestone-1` working tree. Rerun on the final merged and tagged `m1` commit before submission.

### `flutter analyze --fatal-infos`

```text
Analyzing ParentLink-m1...
No issues found! (ran in 8.0s)
```

### `flutter test`

```text
00:00 +0: loading C:/Users/hp/Desktop/MYFS JOURNEY/SupplyFlow/ParentLink-m1/test/app_navigation_test.dart
00:00 +0: C:/Users/hp/Desktop/MYFS JOURNEY/SupplyFlow/ParentLink-m1/test/app_navigation_test.dart: parent can open the child detail screen from the drawer
00:02 +1: C:/Users/hp/Desktop/MYFS JOURNEY/SupplyFlow/ParentLink-m1/test/app_navigation_test.dart: teacher can navigate to the report entry form
00:03 +2: loading C:/Users/hp/Desktop/MYFS JOURNEY/SupplyFlow/ParentLink-m1/test/features/school_data/school_data_provider_test.dart
00:05 +2: C:/Users/hp/Desktop/MYFS JOURNEY/SupplyFlow/ParentLink-m1/test/features/school_data/school_data_provider_test.dart: loads the made-up school records from the in-memory repository
00:05 +3: C:/Users/hp/Desktop/MYFS JOURNEY/SupplyFlow/ParentLink-m1/test/features/school_data/school_data_provider_test.dart: teacher can change a student attendance status
00:05 +4: C:/Users/hp/Desktop/MYFS JOURNEY/SupplyFlow/ParentLink-m1/test/features/school_data/school_data_provider_test.dart: teacher can add a grade to the in-memory records
00:05 +5: C:/Users/hp/Desktop/MYFS JOURNEY/SupplyFlow/ParentLink-m1/test/features/school_data/school_data_provider_test.dart: teacher can add a behavior report
00:05 +6: C:/Users/hp/Desktop/MYFS JOURNEY/SupplyFlow/ParentLink-m1/test/features/school_data/school_data_provider_test.dart: a parent message is added to its student conversation
00:05 +7: C:/Users/hp/Desktop/MYFS JOURNEY/SupplyFlow/ParentLink-m1/test/features/school_data/school_data_provider_test.dart: school leader can add an announcement to the feed
00:05 +8: loading C:/Users/hp/Desktop/MYFS JOURNEY/SupplyFlow/ParentLink-m1/test/features/students/students_provider_test.dart
00:07 +8: C:/Users/hp/Desktop/MYFS JOURNEY/SupplyFlow/ParentLink-m1/test/features/students/students_provider_test.dart: loads sample students from the in-memory student repository
00:07 +9: loading C:/Users/hp/Desktop/MYFS JOURNEY/SupplyFlow/ParentLink-m1/test/features/teacher/teacher_screens_test.dart
00:09 +9: C:/Users/hp/Desktop/MYFS JOURNEY/SupplyFlow/ParentLink-m1/test/features/teacher/teacher_screens_test.dart: teacher can mark student attendance and update today count
00:25 +10: C:/Users/hp/Desktop/MYFS JOURNEY/SupplyFlow/ParentLink-m1/test/features/teacher/teacher_screens_test.dart: teacher can submit a grade and a behavior report
00:29 +11: All tests passed!
```
