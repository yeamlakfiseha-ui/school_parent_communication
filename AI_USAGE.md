# AI usage disclosure — Milestone 1

## Tools used

| Tool | Version / model | Used for |
|---|---|---|
| Claude | Claude (proposal & Milestone 1) | Drafting and editing `PROPOSAL.md`, Milestone 1 screens, in-memory repositories/providers, tests, and draft docs. |
| Antigravity | Gemini 4 Hydrogen | Code review, `studentsProvider` repository wiring, screen bug fixes, teacher tests, and doc updates. |

## What was generated and where

| File / function | Member | AI-use level | What the tool produced | What we changed | How we verified it |
|---|---|---|---|---|---|
| `PROPOSAL.md` | Group | 3 | Proposal draft | Reviewed and edited by the group | Proposal and sketches committed (`proposal` tag) |
| Auth, `User`/`Student` foundation, initial router & theme | Yeamlak Fiseha | 3 | Initial project setup, Freezed `User`/`Student`, and login screen | Adapted to ParentLink roles | Retained and verified with `flutter analyze --fatal-infos` |
| `lib/features/school_data/**`, `lib/features/students/**`, `lib/features/teacher/**`, `test/**` | Tamirat Petros | 3 | Freezed school records, in-memory repositories, Riverpod providers, teacher screens, and tests | Replaced global student list with `studentsProvider`, fixed teacher subtitle, and added teacher/student tests | `flutter analyze --fatal-infos` and `flutter test` (11 tests passed) |
| `lib/core/router/app_router.dart`, `lib/core/theme/app_theme.dart`, `lib/features/{parent,community,leadership,admin,users}/**`, `MILESTONE.md` | Group (drafted for review) | 3 | Role routes, shared widgets, parent/leader/admin/community screens, and draft `MILESTONE.md` | Fixed nested CSV card in `ManageUsersScreen` and dynamic grade/section grouping | Navigation widget tests and `flutter analyze --fatal-infos` passed |

## Which tasks did we do without an assistant first?

None — all Milestone 1 code and tests were drafted with AI assistance and reviewed/verified before submission.

## Problems found in AI output

- Replaced deprecated dropdown `value` parameters with `initialValue`.
- Moved sample students from a global list in `in_memory_school_repository.dart` into `InMemoryStudentRepository` and `studentsProvider`.
- Unnested the `"Import CSV text"` card from inside `"Add a user"` in `ManageUsersScreen`.
- Updated `teacher_screens_test.dart` to wait for the floating `SnackBar` before tapping `"Save report"` a second time.

## Individual declaration

| Name | I wrote or reviewed and can explain these files | I entered no passwords, keys or personal data into an AI tool (yes / no) | Signature |
|---|---|---|---|
| Tamirat Petros | `lib/features/school_data/**`, `lib/features/students/**`, `lib/features/teacher/**`, `test/**`, `lib/core/router/app_router.dart` | yes | Tamirat Petros |
| Yeamlak Fiseha | `lib/features/auth/**`, `lib/core/router/**`, `lib/core/theme/**`, `lib/features/parent/**` |  |  |
| Surafel Kassa | `lib/features/community/**`, `test/**`, `AI_USAGE.md` |  |  |
| Wakgari Eshetu | `project.yaml`, `MILESTONE.md`, `lib/features/leadership/**`, `lib/features/admin/**` |  |  |

Date: 27 November 2026
