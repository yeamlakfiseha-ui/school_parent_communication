# AI usage disclosure — Milestone 1

## Tools used

| Tool | Version / model | Used for |
|---|---|---|
| Claude | Claude (exact model version not recorded) | Drafting and editing `PROPOSAL.md`, Milestone 1 screens, in-memory repositories/providers, tests, and draft docs. |
| ChatGPT | GPT-6 | Drafted and adapted the Flutter project structure, theme, role-aware router, auth/student models and repositories, and initial login screen (PR #3). |
| Antigravity | Gemini 4 Hydrogen (High) | Code review, `studentsProvider` repository wiring, screen bug fixes, teacher/student tests, and PR #6 review fixes. |

## What was generated and where

| File / function | Member | AI-use level | What the tool produced | What we changed | How we verified it |
|---|---|---|---|---|---|
| `PROPOSAL.md` | Group | 3 | Proposal draft | Reviewed and edited by the group | Proposal and sketches committed (`proposal` tag) |
| `lib/main.dart`, `lib/app.dart`, `lib/core/router/routes.dart`, `lib/features/auth/**`, `lib/features/students/**`, initial `app_router.dart`, `app_theme.dart`, and `login_screen.dart` | Yeamlak Fiseha | 3 | Initial project setup, Freezed `User`/`Student`, repositories, and initial login screen | Adapted to ParentLink roles and Riverpod 3 / Freezed 4 | Verified on PR #3 with `flutter analyze --fatal-infos` |
| `lib/features/school_data/**`, `lib/features/students/presentation/**`, `lib/features/teacher/**`, `lib/features/users/**`, `lib/core/widgets/parent_link_widgets.dart`, `lib/features/{parent,community,leadership,admin}/presentation/**`, Milestone 1 updates to `app_router.dart` & `login_screen.dart`, `test/**` | Tamirat Petros | 3 | Freezed school records, in-memory repositories, Riverpod providers, walkthrough screens (excluding messaging), and unit/widget tests | Replaced global student list with `studentsProvider`, unnested CSV card, fixed grade/section grouping, added `mounted` guard after `showDatePicker`, removed duplicate messaging code in favor of PR #8, and added teacher/student tests | Code reviewed and walked through; final `flutter analyze --fatal-infos` and `flutter test` rerun pending on `main` after merge |

## Which tasks did we do without an assistant first?

None — all Milestone 1 code and tests were drafted with AI assistance and reviewed/verified before submission.

## Problems found in AI output

- Replaced deprecated dropdown `value` parameters with `initialValue`.
- Moved sample students from a global list in `in_memory_school_repository.dart` into `InMemoryStudentRepository` and `studentsProvider`.
- Unnested the `"Import CSV text"` card from inside `"Add a user"` in `ManageUsersScreen`.
- Updated `teacher_screens_test.dart` to wait for the floating `SnackBar` before tapping `"Save report"` a second time.
- Added an `if (!mounted) return;` check after `await showDatePicker` in `PostAnnouncementScreen`.

## Individual declaration

Each member completes one row. List the files you can explain, including the ones an assistant helped with.

| Name | I wrote or reviewed and can explain these files | I entered no passwords, keys or personal data into an AI tool (yes / no) | Signature |
|---|---|---|---|
| Tamirat Petros | `lib/features/school_data/**`, `lib/features/students/**`, `lib/features/teacher/**`, `lib/features/users/**`, `lib/core/widgets/parent_link_widgets.dart` | yes | Tamirat Petros |
| Yeamlak Fiseha | | | |
| Surafel Kassa | | | |
| Wakgari Eshetu | | | |

Date: 27 November 2026
