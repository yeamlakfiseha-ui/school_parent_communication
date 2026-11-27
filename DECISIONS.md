# Decisions

A short log of decisions and the reasons for them. These first entries were
written from what the repository shows; edit or replace any entry the group did
not actually decide, and add new ones as they are made.

## In-memory repositories behind interfaces (Milestone 1)

Screens depend on repository interfaces (`AuthRepository`, `StudentRepository`,
and the others), with in-memory implementations behind them. Why: Milestone 1
has no backend, and the interfaces let us add the REST service and Firebase in
Milestone 2 without changing the screens.

## Riverpod, `freezed` and `go_router`

State lives in Riverpod providers, models are immutable `freezed` classes, and
navigation uses `go_router`. Why: this is the course toolchain, and immutable
models plus providers keep state out of widgets and easy to test.

## Generated files are committed

`*.freezed.dart` and `*.g.dart` are in the repository. Why: teammates and CI can
build without running code generation. After changing a model, run
`dart run build_runner build -d` before committing.

## Merge commits, not squash

Pull requests are merged with a merge commit. Why: it keeps each member's own
commits in the history of `main`, which the TA uses with the oral checks and the
peer evaluation.
