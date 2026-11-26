# AI usage disclosure — Milestone 1 draft

Complete the personal declaration and signature rows yourselves. This file records assistant use for the project; each member should confirm their own contribution before submission.

## Tools used

| Tool | Version / model | Used for |
|---|---|---|
| Claude | Not recorded in the existing proposal disclosure | The proposal says Claude helped draft and edit `PROPOSAL.md`; the group should confirm the details. |
| ChatGPT Codex | GPT-6 | Reviewing the assignment and existing project; implementing the Milestone 1 screens, in-memory models/repositories/providers, navigation updates, tests, and draft milestone notes in this branch. |

## What was generated and where

AI-use level 3 means draft and verify. Members should review the files they plan to discuss and update this table if their individual use differs.

| Files / functions | Member using the assistant | AI-use level | What the tool produced | What the group changed or should review | Verification |
|---|---|---:|---|---|---|
| `lib/core/router/app_router.dart`, `lib/core/theme/app_theme.dart` | Tamirat Petros | 3 | Replaced placeholder route builders with role-specific screen routes and added a shared visual theme. | Group should confirm the final route and navigation choices after review. | Parent and teacher navigation widget tests pass; analyzer reports no issues. |
| `lib/features/school_data/**`, `lib/features/users/**` | Tamirat Petros | 3 | Freezed records, repository interfaces, in-memory sample data, Riverpod controllers, and user-child links. | Sample values and the simple CSV format should be reviewed; data intentionally resets on restart. | Six provider tests pass; generated Freezed files are included. |
| `lib/features/{parent,teacher,community,leadership,admin}/presentation/**`, `lib/core/widgets/**` | Tamirat Petros | 3 | Parent, teacher, school leader, and administrator milestone screens and shared UI pieces. | QR scanning and the term summary are demos; camera, backend, and hosted AI work remain for later milestones. | Widget navigation tests cover Parent Child Detail and Teacher report entry. |
| `test/**`, `MILESTONE.md` | Tamirat Petros | 3 | Provider and navigation tests, plus a draft milestone report and verification output. | Group must verify PR and review records, self-score, declarations, and final tagged-commit output. | `flutter analyze --fatal-infos` and `flutter test` passed on this untagged branch. |
| Existing login, auth, and `User` / `Student` foundation | Recorded in the previous AI disclosure as Yeamlak Fiseha | 3 | The prior disclosure says the initial structure, router, models, repositories, and login were assistant-drafted. | Verify that the member attribution and description match the repository history. | Existing generated files were retained; the full project analyzer and tests pass in this branch. |
| `PROPOSAL.md` | Group, per the proposal | 3 | Proposal draft assisted by Claude, as stated in the proposal. | Group says it reviewed and edited the document; confirm individual contributions. | Existing proposal and sketches are present in the checkout. |

## Work done without an assistant first

Each member should name any design, code, or tests they created before asking an assistant, or write “None.” Do not complete this section on another member’s behalf.

## Problems found in assistant output

- The analyzer flagged deprecated dropdown `value` parameters; these were replaced with `initialValue`, and the final analyzer run passed.
- The QR screen uses a selected student to demonstrate check-in/out; it does not scan a real camera image.
- The term summary uses a transparent template based on sample records; it is not a hosted language-model response.
- The pasted CSV importer supports simple comma-separated rows and does not parse quoted commas.

## Individual declaration

Each member should fill in their own files they can explain, whether they used an assistant, the yes/no data statement requested by the course, and their signature. Do not sign for another member.

| Name | Files I wrote or reviewed and can explain | I entered no passwords, keys or personal data into an AI tool (yes / no) | Signature |
|---|---|---|---|
| Tamirat Petros |  |  |  |
| Yeamlak Fiseha |  |  |  |
| Surafel Kassa |  |  |  |
| Wakgari Eshetu |  |  |  |

Date: 27 November 2026
