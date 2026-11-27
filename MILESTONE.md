# Milestone 1 — group review draft

## Done

- Built role-aware `go_router` navigation across all 12 proposed destinations for the Parent, Teacher, School Leader, and App Administrator roles (`ChildDetailScreen` and `TermSummaryScreen` accept a `studentId` path parameter; `Messages` routes show a placeholder in PR #6 pending Surafel's PR #8 `lib/features/messaging/**`).
- Added Freezed models for attendance, grades, behavior reports, check-in/out records, announcements, and schedule items (`lib/features/school_data/domain/school_record.dart`), alongside the existing Freezed `User` and `Student` models.
- Added in-memory repositories behind domain interfaces (`SchoolRepository`, `StudentRepository`, `UsersRepository`, `AuthRepository`) and Riverpod state providers (`schoolDataProvider`, `studentsProvider`, `usersProvider`, `linkedChildrenProvider`, `authControllerProvider`).
- Implemented the Milestone 1 walkthrough screens (`TeacherHomeScreen`, `ReportEntryScreen`, `QrScannerScreen`, `ParentHomeScreen`, `ChildDetailScreen`, `TermSummaryScreen`, `AnnouncementsScreen`, `SchoolOverviewScreen`, `PostAnnouncementScreen`, `AdminHomeScreen`, and `ManageUsersScreen`), built by Tamirat Petros on top of Yeamlak Fiseha's project foundation. Going forward, Yeamlak keeps the foundation (`auth`, `router`, `theme`) and Wakgari Eshetu takes ownership of the parent side (`lib/features/parent/**`), while Surafel Kassa owns messaging (`PR #8`).
- Added unit and widget tests covering `schoolDataProvider`, `studentsProvider`, Parent and Teacher drawer navigation, Teacher attendance updates, and Teacher grade/behavior report submission.
- Confirmed the existing `proposal` tag points to the proposal merge commit `7efb564e76c6699a401071f8199a3768104df454`.

## Not done or limited in this milestone

- Messaging screens and `ChatMessage` live in Surafel's PR `#8` (`feature/messaging`); PR `#6` leaves placeholder widgets on `/parent/messages` and `/teacher/messages` to avoid duplicate messaging implementations.
- QR scanning is represented by a student-selection demo flow; it does not request camera access or read a real QR code.
- The term summary is a template generated from sample records; it does not call a hosted AI service.
- All app data is in memory and resets when the app restarts. Firebase, REST calls, local persistence, push notifications, and file-picker CSV import belong to Milestone 2 and later.
- The group must complete PR reviews and merge-commit merges on GitHub for all four members, fill in the remaining individual AI declarations and signatures in `AI_USAGE.md`, confirm this self-score, merge to `main`, and rerun the final checks on `main` before creating the `m1` tag.

## Pull requests authored and reviewed

PR numbers below refer to `https://github.com/yeamlakfiseha/school_parent_communication`. Confirm submitted GitHub reviews before tagging `m1`.

| Member | PRs authored | PRs reviewed |
|---|---|---|
| Tamirat Petros (`Tamirat-Petros`) | [#6](https://github.com/yeamlakfiseha/school_parent_communication/pull/6) (`feature/milestone-1`) | Pending (planned: Surafel's PR) |
| Yeamlak Fiseha (`yeamlakfiseha-ui`) | [#1](https://github.com/yeamlakfiseha/school_parent_communication/pull/1), [#2](https://github.com/yeamlakfiseha/school_parent_communication/pull/2), [#3](https://github.com/yeamlakfiseha/school_parent_communication/pull/3), [#4](https://github.com/yeamlakfiseha/school_parent_communication/pull/4) (revert of #3), [#5](https://github.com/yeamlakfiseha/school_parent_communication/pull/5) (re-revert of #3), [#7](https://github.com/yeamlakfiseha/school_parent_communication/pull/7) (`docs/readme-and-decisions`) | Pending (planned: Tamirat's PR) |
| Surafel Kassa (`Surafel750`) | [#8](https://github.com/yeamlakfiseha/school_parent_communication/pull/8) (`feature/messaging`) | Pending (planned: PR #6 or Wakgari's PR) |
| Wakgari Eshetu (`Wakgari-Eshetu`) | Pending (parent/admin refactor PR) | Pending (planned: PR #6 or Yeamlak's PR) |

## Draft self-score — group confirmation required

| Criterion | Draft score | Evidence |
|---|---:|---|
| All proposed screens present and navigable (3) | 3/3 | All 12 proposal destinations have role-aware routes (with messaging completed in PR #8); QR scanning and the AI summary are clearly represented as demos. |
| Feature-first structure; state in providers, not widgets (2) | 1.5/2 | Repositories and Riverpod controllers (`schoolDataProvider`, `studentsProvider`, `usersProvider`, `authControllerProvider`) manage app state, while derived filtering, sorting, averages, grade/section grouping, and CSV parsing remain inside screen widgets and several features still lack `domain/` folders. |
| Tests present; analyzer and tests clean (1) | Pending rerun on `main` | Unit and widget test files exist under `test/`, and final `flutter analyze --fatal-infos` and `flutter test` verification must be rerun on `main` after all PRs are merged. |
| Repository hygiene (1) | 0/1 pending group workflow | PRs #6, #7, and #8 still require peer reviews and merge commits on GitHub, and Wakgari still needs an authored PR before tagging `m1`. |
| Individual oral check (3) | 0/3 pending | The instructor has not held the individual lab oral checks yet. |
| **Total (10)** | **4.5/10 draft (before final test/analyzer run)** | **Re-score as a group after completing PR reviews, merging to `main`, and rerunning checks before tagging `m1`.** |

## One change before Milestone 2

Move derived view logic (filtering, sorting, averages, today's attendance, grade/section grouping, and CSV parsing in `UsersController`) out of screen widgets into plain Dart `domain/` classes/functions and small derived Riverpod providers, split into small peer-reviewed PRs per screen (`parent`, `community`, `leadership`, `teacher`, and `admin` for Wakgari).

### Later work (Milestone 2)

- **Document shared data layer in `DECISIONS.md`:** Add the note to `DECISIONS.md` (from PR #7) explaining that feature modules share `school_data` as their data layer while keeping their own `domain/` and `presentation/` folders.
- **Inject `DateTime.now()` via `clockProvider`:** Add `final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);` so providers and tests do not rely directly on wall-clock time.
- **Make `SchoolRepository` asynchronous:** Change `SchoolRepository.loadInitialData()` to return `Future<SchoolData>`, convert `schoolDataProvider` to an `AsyncNotifier`, and update screens to use `.when(data, loading, error)` before wiring Firebase and the REST API.

## Verification output

Verification output is intentionally left to be rerun on `main` after all Milestone 1 PRs are merged and before creating the `m1` tag. Paste the fresh output from `main` for both commands here:

- `flutter analyze --fatal-infos`
- `flutter test`
