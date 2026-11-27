# ParentLink

School–parent communication app for Nativity Girls School (NGS), a group project
for the Mobile Application Development course. Parents follow their children's
attendance, grades and behavior reports and message teachers; teachers record
that data; school leaders post announcements and see school-wide reports; an app
administrator manages users. See [PROPOSAL.md](PROPOSAL.md) for the full scope.

## Status

Milestone 1 (screens, navigation, state): all data is in memory and resets when
the app restarts. Local persistence, the REST service and Firebase come in
Milestone 2. See [MILESTONE.md](MILESTONE.md) for what is done and not done.

## Run it

1. Install Flutter 3.47.7 (see `flutter-version.txt`).
2. `flutter pub get`
3. If the `android/` folder is missing, run
   `flutter create . --platforms=android --project-name parentlink` once.
4. `flutter run` on an Android emulator or device.

## Demo sign-in

Sign-in is a demo: any non-empty email and password is accepted, and the part of
the email before the `@` picks the role.

| Email starts with | Role |
|---|---|
| `teacher@` | Teacher |
| `leader@` | School leader |
| `admin@` | App administrator |
| anything else | Parent |

For example `teacher@parentlink.test` with the password `demo`.

## Checks

```bash
flutter analyze --fatal-infos
flutter test
```

## Project structure

```
lib/
  core/          router, theme, shared widgets
  features/<feature>/
    domain/      models (freezed) and repository interfaces
    data/        in-memory repository implementations
    presentation/ screens and Riverpod providers
```

Built with Flutter, Riverpod, `go_router` and `freezed`.

Generated files (`*.freezed.dart`, `*.g.dart`) are committed so that nobody needs
code generation to build. After you change a model, run
`dart run build_runner build -d` before committing.

## Team

- Yeamlak Fiseha ([@yeamlakfiseha](https://github.com/yeamlakfiseha))
- Tamirat Petros ([@Tamirat-Petros](https://github.com/Tamirat-Petros))
- Surafel Kassa ([@Surafel750](https://github.com/Surafel750))
- Wakgari Eshetu ([@Wakgari-Eshetu](https://github.com/Wakgari-Eshetu))

## More

[PROPOSAL.md](PROPOSAL.md) · [MILESTONE.md](MILESTONE.md) ·
[DECISIONS.md](DECISIONS.md) · [AI_USAGE.md](AI_USAGE.md)
