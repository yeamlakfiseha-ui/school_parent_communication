# AI usage disclosure

Copy this file into your project as `AI_USAGE.md` and complete it for
every project milestone and for the final submission. Write "None" in a
section if it does not apply. Labs use a shorter three-line AI note
instead (see `../syllabus/policies.md`).

## Tools used

| Tool | Version / model | Used for |
|---|---|---|
| Claude | Not recorded in the existing proposal | Drafting and editing the original ParentLink proposal, as disclosed in that proposal. |
| ChatGPT | GPT-6 | Drafted and adapted the Flutter project structure, theme, role-aware router, auth/student models and repositories, and login screen. |
| Antigravity | Gemini 4 Hydrogen (Medium) | Drafted the messaging feature (`domain`, `data`, `presentation`), router integration for Parent/Teacher messaging & chat routes, and widget tests. |

## What was generated and where

*List the files or functions where a substantial part came from an AI
tool. For each, give the AI-use level (0 No AI, 1 Explain only, 2 Review,
3 Draft and verify — see `../syllabus/policies.md`), say what you changed
and how you verified it.*

| File / function | Member | AI-use level | What the tool produced | What we changed | How we verified it |
|---|---|---|---|---|---|
| `PROPOSAL.md` | Group (per the proposal) | 3 | Claude-assisted proposal draft | Group says it reviewed and edited it; individual changes should be confirmed | Existing proposal says Claude helped; no separate verification record included |
| App bootstrap, theme/router, auth and student models/repositories, login screen | Yeamlak Fiseha | 3 | Drafted the initial implementation and adapted it to ParentLink roles and screens | Group review and edits are pending | Freezed generation completed and `flutter analyze --fatal-infos` passed; `flutter test` reports there are no test files |
| Messaging feature (`lib/features/messaging/**`), messaging route wiring (`routes.dart`, `app_router.dart`), and `test/messaging_test.dart` | Surafel Kassa | 3 | Drafted messaging models/repository/controller, `MessagesScreen`, `ChatScreen`, shared avatar/timestamp widgets, route integration, and 3 widget tests | Reviewed against Milestone 1 rules, reused shared `User` model without duplicating `User`/`Student`, fixed relative import in `contact_avatar.dart`, and verified responsive layout and empty-message validation | `flutter analyze --fatal-infos` passed with 0 issues; `flutter test` passed all 3 tests in `test/messaging_test.dart` |

## Which tasks did we do without an assistant first?

*Name the parts you wrote or designed yourselves before asking an
assistant anything, for example the data model, the security rules or
the first test of a feature, and why you chose to do them alone.*

## Problems found in AI output

The first implementation used Riverpod's removed `valueOrNull` getter and concrete Freezed model declarations. Those were updated for the resolved Riverpod 3 and Freezed 4 packages. The first Riverpod 2 generator also failed against the Flutter 3.47.7 Dart 3.13 analyzer, so the generator dependencies were upgraded. The current analyzer passes; tests still need to be added.

## Individual declaration

Each member completes one row. List the files you can explain, including
the ones an assistant helped with. The TA chooses oral-check questions
from code **not** in your own list (see `milestones.md`).

| Name | I wrote or reviewed and can explain these files | I entered no passwords, keys or personal data into an AI tool (yes / no) | Signature |
|---|---|---|---|
| Surafel Kassa | `lib/features/messaging/**`, `lib/core/router/routes.dart`, `lib/core/router/app_router.dart`, `test/messaging_test.dart` | yes | Surafel Kassa |
| | | | |
| | | | |
| | | | |

Date:
