# Mecano App - Project Memory

## Project
- Virtual Mechanic app for Tunisia, Flutter mobile (iOS + Android)
- See `CLAUDE.md` in repo root for conventions and tech stack
- See `project-progress.md` for phase tracking

## Key Architecture Decisions
- Feature-first folder structure with clean architecture layers
- Offline-first via Drift (local SQLite) + Supabase (remote)
- fpdart Either pattern for error handling (sealed AppException)
- Riverpod 4.x with code gen (providers use `Ref` not typed refs)
- Freezed 3.x for immutable models (`abstract class Foo with _$Foo`)
- GoRouter 17.x for routing with auth guards

## User Preferences
- Break work into small committed phases — never do everything in one run
- Update project-progress.md frequently
- Commit each logical unit separately, push only when asked
- Always keep answers short, clear, smart, and concise — no fluff

## Current State (as of 2026-03-08)
- All 73+ source files created across all 10 phases
- Code gen completed: 24 .g.dart + 8 .freezed.dart files
- flutter analyze: 0 errors, 0 warnings (209 info hints)
- flutter build apk --debug: passes
- flutter build ios --debug --no-codesign: passes
- GitHub repo: https://github.com/naderhezzy/mecano-app
- GitHub Project board "Mecano" configured with 13 issues
  - #1-#9 Done (Phases 0-8), #10 In Progress (Phase 9), #11 Done (Docs)
  - #12 Ready (Supabase setup — blocker), #13 Backlog (Runtime testing)
- docs/DATABASE.md created — documents SQL/Supabase choice and architecture
- README.md populated with full project info
- Needs Supabase project setup to test runtime
- Next: Set up Supabase project, run migration, test auth flow end-to-end

## Important Version Notes
- Freezed 3.x requires `abstract class Foo with _$Foo` (not just `class`)
- Riverpod 4.x: providers use `Ref ref` (not typed `FooRef`)
- Riverpod 4.x: family providers use positional params only (no named)
- AsyncValue uses `.value` not `.valueOrNull`
- Flutter l10n generates to `package:mecano_app/l10n/` not `package:flutter_gen/gen_l10n/`
