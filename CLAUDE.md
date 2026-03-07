# Mecano App - Claude Code Instructions

## Project Overview
Virtual Mechanic mobile app for Tunisia. Flutter app targeting iOS + Android.
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
- **Commit frequently** — each logical unit of work gets its own commit.
- **Push only when asked** — never auto-push.
- **Run code gen** after modifying Freezed/Riverpod/Drift annotated files.
- **Validate before committing** (especially after deps/config changes):
  1. `flutter analyze` — 0 errors
  2. `flutter build apk --debug` — Android builds
  3. `flutter build ios --debug --no-codesign` — iOS builds
- All three must pass before a commit is considered safe.

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
