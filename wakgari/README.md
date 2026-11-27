# Wakgari · parent side (WIP)

This folder holds my parent-side work for **Parent home** and **Child detail
(attendance, grades, behavior, check-in/out)**. It builds on Tamirat's milestone
1 structure, but every file here is new — nothing already on `main` is edited,
so this branch can be pushed without touching anyone else's work.

## Run it

```bash
flutter run -t wakgari/main.dart
```

The demo signs in as `parent@parentlink.test` (any password), then shows the new
parent home. The demo parent is linked to two children (Mimi Bekele and Liya
Abebe) so the child switcher on the detail screen is visible.

## Tests

```bash
flutter test wakgari/test
flutter analyze
```

## What is here

```
wakgari/
  main.dart                          demo entrypoint (parent only)
  features/parent/
    domain/
      child_records.dart             record scoping, attendance summary,
                                     subject trends, gate sessions, presence
      child_overview.dart            "needs attention" rules and averages
    presentation/
      parent_providers.dart          links, linked children, clock, overview,
                                     behavior read state
      parent_home_screen.dart        child cards, today's status, alerts
      child_detail_screen.dart       four tabs with summaries and switcher
      formatting.dart                status labels, clock/duration formatting
      widgets/                       cards shared by the two screens
  test/
    child_records_test.dart
    parent_providers_test.dart
    parent_screens_test.dart
```

## The four extra ideas built in

1. **Mark a behavior note as read.** Concerns show `Mark as read`; the state is
   kept per report id (`acknowledgedBehaviorProvider`), so the teacher side can
   later show it as a read receipt. Nothing is added to the Freezed models.
2. **Child switcher for siblings.** The parent home and child detail resolve
   children from a many-to-many link (`Map<String, List<String>>`), and the
   detail header shows chips when there is more than one child.
3. **"Today" status from the gate.** `In school since 7:42`, `Checked out 15:20`,
   `Absent today`, or `Today not marked yet`, derived from the newest session.
4. **Attendance rate / recent-days strip and per-subject trends.** The
   attendance tab shows the rate, present/late/absent counts and the last ten
   marks; grades show latest score, change since the previous score, average and
   a progress bar.

Plus the baseline fixes for this milestone:

- A parent only sees linked children. There is **no fallback** to
  `students.take(2)` or `students.first`, and opening an id the parent does not
  own shows a locked screen instead of another family's records.
- Derived rules moved out of `build()` into `domain/` and providers, so they are
  unit tested instead of recalculated in three screens.
- Loading, error (with retry) and empty states for every tab.
- Tab labels carry record counts; status labels are shared instead of raw enum
  names such as `medium`.
- The clock is injected (`nowProvider`) so "today" logic is testable.

## Integrating into `lib/` later (not done on purpose)

1. Move `wakgari/features/parent/domain/*` and `presentation/*` into
   `lib/features/parent/`. Imports already use `package:parentlink/...` for
   shared code and relative paths inside the feature, so the move is a copy.
2. Point the router at the new screens:

   ```dart
   _Page(AppRoutes.parentHome, 'Home', Icons.home_outlined,
       (_) => ParentHomeScreen(
             onOpenChild: (id) => context.push('/parent/child/$id'),
           )),
   _Page(AppRoutes.childDetail, 'Child detail', Icons.child_care,
       (state) => ChildDetailScreen(
             studentId: state.pathParameters['studentId'] ?? '',
             onBack: () => context.pop(),
             onOpenChild: (id) => context.pushReplacement('/parent/child/$id'),
           )),
   ```

3. Delete the old `ParentHomeScreen` / `ChildDetailScreen` from
   `parent_screens.dart` (keep `TermSummaryScreen`), and replace
   `linkedChildrenProvider` with `parentChildLinksProvider`. The old provider
   seeds `{'u1': 's-101'}`, but auth user ids are emails, so that link never
   matches — which is why the current screen falls back to sample children.
4. Add the same rows to `AI_USAGE.md` before submitting.
