# AI Usage Log — Milestone 1

## What Was Generated and Where

### Bootstrap and Freezed/data boilerplate
- **Member:** Mahder Kassaw
- **AI-use level:** 3
- **AI assistance:** AI was used to draft the initial Flutter scaffold, the `freezed` model skeletons, and repetitive in-memory repository boilerplate, based on our feature-first structure.
- **What I changed:** Adapted names, file placement, and provider wiring to our project; regenerated the `.freezed.dart` files; resolved analyzer issues.
- **Verification:** Ran `flutter analyze --fatal-infos` and `flutter test`; PR reviewed and approved by teammates.

### Nearby donor filter/sort logic and screen
- **Member:** Mahder Kassaw
- **AI-use level:** 0
- **AI assistance:** Designed the matching and ordering rules myself first.
- **What I changed:** Put the rules in pure functions and a provider, added `area` to the request model, and wired the screen to real providers.
- **Verification:** Unit tests for ordering and provider behavior, widget tests for cards/empty/not-found states, full `flutter test` run.

### Auth redirect and coverage fixes
- **Member:** Mahder Kassaw
- **AI-use level:** 2
- **AI assistance:** AI helped explain the `material_ui` localizations error and draft the redirect-guard test.
- **What I changed:** Fixed the localizations setup, added the guard test, and restored the requester-side response test after conflicts.
- **Verification:** `flutter analyze --fatal-infos`, `flutter test` (65 tests passing at `e8673ee`), manual demo run.

### T1 — Core navigation & app shell
- **Member:** Maedot (`Maedotbbb`)
- **AI-use level:** 2
- **AI assistance:** AI was used to reference `go_router` `StatefulShellRoute.indexedStack` patterns, troubleshoot Flutter SDK/Git setup, and draft initial placeholder screen boilerplate.
- **What I changed:** Designed and wired the route hierarchy and `:id` parameters to match our feature-first architecture, aligned `DonoHereApp` naming, migrated imports to `material_ui`, updated `.gitignore`, and addressed all PR #14 review feedback.
- **Verification:** Ran `flutter analyze --fatal-infos` and `flutter test`, and manually verified navigation across all 7 routes.

### T9 — Milestone documentation
- **Member:** Maedot (`Maedotbbb`)
- **AI-use level:** 1
- **AI assistance:** AI was used to help format and organize the Markdown sections for `MILESTONE.md` and `AI_USAGE.md`.
- **What I changed:** Compiled all team contributions, verified every PR link, resolved remaining `material_ui` deprecation infos across the repo, and inserted real local verification outputs.
- **Verification:** Checked all PR links on GitHub and ran `flutter analyze --fatal-infos` and `flutter test` locally.

### T4 — Donor Profile
- **Member:** Liya Belay
- **AI-use level:** 3
- **AI assistance:** AI was used to plan the work, explain Git/GitHub steps, and draft the Donor Profile providers, screen, and tests, based on our repository and provider names.
- **What I changed:** Adapted the code to our project structure and names, committed it file by file, and fixed analyzer issues.
- **Verification:** Ran `flutter analyze --fatal-infos` and `flutter test`, tested the form manually in the app, PR reviewed by teammates.

### T6 (donor side) — Home filter and Respond
- **Member:** Liya Belay
- **AI-use level:** 3
- **AI assistance:** AI was used to draft the blood type filter, the respond rules, the profile prompt widget, the Respond section, and their tests, and to help connect them to Wangari's Home and Request Detail screens.
- **What I changed:** Wired the widgets into the existing screens and updated Wangari's Home test because Home now filters by blood type.
- **Verification:** `flutter analyze`, `flutter test`, manual run as a seeded donor user.

### T5 — Create Request and My Requests
- **Member:** Wangari Dereje
- **AI-use level:** 1 (Explain only)
- **AI assistance:** Explanations of the Flutter implementation, project structure, and request-related functionality.
- **What I changed:** Used the explanations to understand and implement my assigned features.
- **Verification:** Reviewed the implementation against the project requirements.

### T6 — Home and Request Detail
- **Member:** Wangari Dereje
- **AI-use level:** 1 (Explain only)
- **AI assistance:** Guidance on understanding the screens, application state, and repository functionality.
- **What I changed:** Applied relevant guidance while working on the assigned screens and functionality.
- **Verification:** Reviewed the implementation against the assigned requirements.

### Auth Flow
- **Member:** Siham Tewekel
- **AI-use level:** 2
- **AI assistance:** AI was used for explanations and troubleshooting while implementing the Riverpod auth state, the Sign In / Register form, and the router redirect guard, and to help draft the related unit and widget tests.
- **What I changed:** Implemented `AuthNotifier`/`AuthState`, the Sign In / Register screen with validation and loading/error states, the `register` repository method, and the auth redirect; added auth session and form tests using `ProviderScope` overrides and cleaned up analyzer issues.
- **Verification:** Ran `flutter analyze --fatal-infos` and `flutter test`, and manually verified sign-in, registration, sign-out, and redirect behavior.

---

## Individual Declarations

### Mahder Kassaw
- **Name:** Mahder Kassaw
- **Files I can explain:** App bootstrap (`main.dart`, `app.dart`), all files in `lib/domain/models/`, `lib/domain/repositories/`, `lib/data/repositories/`, `lib/data/seed/`, and `lib/core/providers/repository_providers.dart`, the nearby-donors screen, provider and date helper, plus their tests and the auth/response coverage fixes.
- **I entered no passwords, keys or personal data into an AI tool:** Yes
- **Signature:** Mahder Kassaw
- **Date:** November 28, 2026

### Maedot
- **Name:** Maedot Berhanu
- **Files I can explain:** `lib/core/router/app_router.dart`, `lib/core/router/app_routes.dart`, `lib/core/widgets/app_shell.dart`, `MILESTONE.md`, `AI_USAGE.md`.
- **I entered no passwords, keys or personal data into an AI tool:** Yes
- **Signature:** Maedot Berhanu
- **Date:** November 28, 2026

### Siham Tewekel
- **Name:** Siham Tewekel
- **Files I can explain:** `AuthNotifier` and `AuthState`, the Sign In / Register screen, the router redirect, the `register` method, and the tests I wrote.
- **I entered no passwords, keys or personal data into an AI tool:** Yes
- **Signature:** Siham Tewekel
- **Date:** November 27, 2026

### Liya Belay
- **Name:** Liya Belay
- **Files I can explain:** Donor Profile screen and providers, matching requests provider and Home list, respond rules and Respond section, and the tests for them.
- **I entered no passwords, keys or personal data into an AI tool:** Yes
- **Signature:** Liya Belay
- **Date:** November 27, 2026

### Wangari Dereje
- **Name:** Wangari Dereje
- **Files I can explain:** Create Request screen, My Requests screen, Home screen, Request Detail screen, and related request functionality.
- **I entered no passwords, keys or personal data into an AI tool:** Yes
- **Signature:** Wangari Dereje
- **Date:** November 27, 2026
