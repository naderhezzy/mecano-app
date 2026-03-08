# Mecano App - Claude Code Instructions

## Project Overview
Virtual Mechanic mobile app for Tunisia. Flutter app targeting iOS + Android.
**Repo**: https://github.com/naderhezzy/mecano-app
**Board**: GitHub Project "Mecano" (10 issues tracking phases)
See `project-progress.md` for detailed phase-by-phase progress tracking.

## Tech Stack
- **Flutter** (3.38.x stable) with Dart 3.10
- **Riverpod 4.x** (riverpod_annotation + riverpod_generator) — providers use `Ref` not typed refs
- **GoRouter 17.x** — declarative routing with auth guards
- **Supabase** (PostgreSQL + Auth + Realtime + Storage)
- **Drift 2.x** — local SQLite for offline-first
- **Freezed 3.x** — `@freezed` annotation for immutable models
- **fpdart** — `Either<AppException, T>` for error handling
- **Material 3** theming

## Architecture
- Feature-first + clean architecture layers (domain/data/presentation)
- Offline-first: Drift local DB -> Supabase remote sync
- Error handling: sealed `AppException` + `FutureEither<T>` typedef

## Key Conventions
- Provider functions use `Ref ref` (Riverpod 4.x, NOT typed `FooRef`)
- Freezed models: `@freezed class Foo with _$Foo { ... }`
- Generated files: `*.g.dart`, `*.freezed.dart`, `*.drift.dart`
- Code gen: `dart run build_runner build --delete-conflicting-outputs`
- Localization: ARB files in `lib/l10n/`, accessed via `context.l10n`
- Tunisia-specific: TND currency (3 decimals), +216 phone, governorates list

## Workflow Rules
- **Never do long tasks in one run.** Break work into multiple phases, each committed separately.
- **Step by step, phase by phase.** Each change should be reviewable independently.
- **Update `project-progress.md`** after completing each phase/commit.
- **Commit frequently** — each logical unit of work gets its own commit. **Before every commit**: show the proposed commit message and ask the user to review/approve. Never auto-commit.
- **NEVER push or create PRs unless explicitly asked.** No auto-push, no auto-PR.
- **Branching**: For any significant task (feature, fix, refactor), create a feature branch (`feature/`, `fix/`, `refactor/`). Work on the branch, then create a PR for review when asked. Only small doc/config changes go directly on `main`.
- **Run code gen** after modifying Freezed/Riverpod/Drift annotated files.
- **Validate before committing** (especially after deps/config changes):
  1. `flutter analyze` — 0 errors
  2. `flutter build apk --debug` — Android builds
  3. `flutter build ios --debug --no-codesign` — iOS builds
- All three must pass before a commit is considered safe.

## GitHub Project Board (MANDATORY)
**Board**: GitHub Project "Mecano" #1, owner: naderhezzy
**Columns**: Backlog → Ready → In progress → In review → Done

**Always keep the board in sync with your work — just like a human developer:**
- When **starting work** on a task/issue → move it to **In progress**
- When work is **ready for review** → move it to **In review**
- When work is **complete and committed** → move it to **Done**
- When **planning upcoming work** → move it to **Ready**
- When **creating new tasks** → create a GitHub issue, add to board, set appropriate status
- When **closing an issue** → also update its board status to **Done**

Use `gh` CLI and GraphQL API to update statuses. Reference IDs:
- Project GQL ID: `PVT_kwHOA_uoKM4BPIwp`
- Status Field ID: `PVTSSF_lAHOA_uoKM4BPIwpzg9onwQ`
- Status options: Backlog `f75ad846`, Ready `e18bf179`, In progress `47fc9ee4`, In review `aba860b9`, Done `98236657`

## Commands
```bash
# Install deps
flutter pub get

# Code generation
dart run build_runner build --delete-conflicting-outputs

# Run app
flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...

# Analyze
flutter analyze

# Test
flutter test
```

## File Structure
```
lib/
  main.dart / bootstrap.dart / app.dart
  core/        # constants, env, errors, extensions, utils, typedefs
  database/    # Drift DB + tables/
  l10n/        # app_en.arb, app_fr.arb
  routing/     # GoRouter + scaffold_with_nav_bar
  theme/       # colors, spacing, theme
  shared/      # providers, widgets
  features/    # splash, onboarding, auth, profile, vehicles,
               # maintenance, garages, bookings, home
```
