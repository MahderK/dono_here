# Milestone 1 — Dono Here

## 1. What Is Done / Not Done

### Done
- **T0 — Repo & Flutter bootstrap:** Feature-first folder structure, `flutter_riverpod`, `go_router`, `freezed`, and strict linting configured.
- **T1 — Core navigation & app shell:** All 7 proposal screens reachable via `go_router` with `StatefulShellRoute.indexedStack` bottom navigation and `:id` path parameters.
- **T2 — Domain models & repositories:** `freezed` models (`User`, `DonorProfile`, `BloodRequest`, `RequestResponse`) and in-memory repository implementations behind abstract interfaces.
- **T3 — Auth feature:** In-memory sign-in/register flow, current-user Riverpod state, and router redirect guard.
- **T4 — Donor profile:** Create/edit donor profile (blood type, area, availability) persisted in memory via repository provider.
- **T5 — Create request & My requests:** Form to post blood requests and filtered list of the current user's requests.
- **T6 — Home, Request detail, respond/fulfill:** Open requests feed, detail view via `:id` param, donor respond action, and requester mark-fulfilled action.
- **T7 — Nearby donors & matching:** Compatible available donor filtering and suggestion ordering for a request.
- **T8 — Tests & analyzer cleanup:** Unit and widget test suite added; analyzer and tests passing.
- **T9 — Documentation:** `MILESTONE.md` and `AI_USAGE.md` completed.

### Not Done
- None for Milestone 1 scope. (Persistent backend/Firebase integration, real GPS distance calculation, and push notifications are planned for Milestone 2.)

---

## 2. Team Contributions & Pull Requests

| Member | GitHub | PRs Authored | PRs Reviewed |
|---|---|---|---|
| **Mahder Kassaw** | `MahderK` | [#13](https://github.com/MahderK/dono_here/pull/13), [#15](https://github.com/MahderK/dono_here/pull/15), [#19](https://github.com/MahderK/dono_here/pull/19) *(+ commits in [#20](https://github.com/MahderK/dono_here/pull/20), [#21](https://github.com/MahderK/dono_here/pull/21))* | [#14](https://github.com/MahderK/dono_here/pull/14), [#17](https://github.com/MahderK/dono_here/pull/17), [#20](https://github.com/MahderK/dono_here/pull/20), [#22](https://github.com/MahderK/dono_here/pull/22) |
| **Maedot** | `Maedotbbb` | [#14](https://github.com/MahderK/dono_here/pull/14), *(docs PR)* | [#13](https://github.com/MahderK/dono_here/pull/13), [#17](https://github.com/MahderK/dono_here/pull/17), [#21](https://github.com/MahderK/dono_here/pull/21) |
| **Siham Tewekel** | `siham-collab` | [#20](https://github.com/MahderK/dono_here/pull/20), [#21](https://github.com/MahderK/dono_here/pull/21) | [#13](https://github.com/MahderK/dono_here/pull/13), [#15](https://github.com/MahderK/dono_here/pull/15), [#16](https://github.com/MahderK/dono_here/pull/16), [#19](https://github.com/MahderK/dono_here/pull/19) |
| **Liya Belay** | `LeaBelay` | [#18](https://github.com/MahderK/dono_here/pull/18), [#22](https://github.com/MahderK/dono_here/pull/22) | [#14](https://github.com/MahderK/dono_here/pull/14), [#16](https://github.com/MahderK/dono_here/pull/16), [#19](https://github.com/MahderK/dono_here/pull/19) |
| **Wangari Dereje** | `wang-i` | [#16](https://github.com/MahderK/dono_here/pull/16), [#17](https://github.com/MahderK/dono_here/pull/17) | [#15](https://github.com/MahderK/dono_here/pull/15), [#18](https://github.com/MahderK/dono_here/pull/18) |

### Individual Contributions

- **Mahder Kassaw:** Bootstrapped the Flutter app, dependencies, feature-first skeleton, `project.yaml`, and proposal sections (#13). Defined `freezed` domain models, repository interfaces, in-memory stores with seed data, Riverpod providers, and unit tests (#15). Implemented nearby donor matching/sorting logic, Nearby Donors screen, and tests (#19). Contributed auth redirect/localizations fixes, M1 demo flow integration, and merge conflict resolution (#20, #21).
- **Maedot:** Implemented the `go_router` navigation architecture, `StatefulShellRoute.indexedStack` bottom navigation shell, route constants, and all 7 placeholder screens (#14). Compiled and finalized Milestone 1 documentation (`MILESTONE.md`, `AI_USAGE.md`) and resolved `material_ui` deprecation imports across the codebase.
- **Siham Tewekel:** Implemented the Sign In / Register screen with form validation, loading/error states, `AuthNotifier` in Riverpod, `register` repository method, and router auth redirect (#20). Wrote unit/widget tests using `ProviderScope` overrides and cleaned up analyzer warnings/infos (#21). Coordinated `MILESTONE.md` and `AI_USAGE.md` contributions.
- **Liya Belay:** Implemented the Donor Profile form with Riverpod draft/validation/save state, shared blood-type/Addis Ababa area helpers, and unit tests (#18). Implemented the donor-side Home blood-type/urgency filter, profile prompt, Request Detail Respond section with eligibility rules, and unit/widget tests (#22).
- **Wangari Dereje:** Implemented the Create Request form and My Requests list connected to request repositories (#16). Implemented the requester-side Home open requests list, Request Detail screen, and Mark as Fulfilled functionality (#17).

---

## 3. Group Self-Score (Mini-Rubric)

| Criterion | Max | Self-Score | Evidence |
|---|---|---|---|
| All proposed screens present and navigable | 3 | 3 | All 7 proposal screens (`/sign-in`, `/home`, `/profile`, `/my-requests`, `/requests/new`, `/requests/:id`, `/requests/:id/donors`) are wired in `go_router` with `StatefulShellRoute.indexedStack` bottom navigation and `:id` path parameters (PR #14, #16–#22). |
| Feature-first structure; state in providers, not widgets | 2 | 2 | The codebase follows `lib/core` and `lib/features/<feature>/{domain,data,presentation}`, with `freezed` models, abstract in-memory repositories, and all application state managed in Riverpod providers (PR #13, #15–#22). |
| Tests present; analyser and tests clean in the pasted output | 1 | 1 | Unit and widget tests cover repositories, providers, and UI flows, and both `flutter analyze --fatal-infos` and `flutter test` pass cleanly in the pasted output below (PR #15, #18–#22). |
| Repository hygiene: branches, pull requests, readable history | 1 | 1 | All work was developed on dedicated feature branches, reviewed by teammates, and merged via pull requests (#13–#22) with clear commit messages and no direct commits to `main`. |
| Individual oral check (recorded per member) | 3 | *(Pending TA)* | To be assessed individually by the TA in the lab following the Milestone 1 deadline. |

**Group Deliverable Self-Score:** 7 / 7 *(+ 3 points pending individual oral check)*

---

## 4. One Thing We Will Change Before Milestone 2

Write unit and widget tests alongside each feature PR and align on `.gitignore` and Flutter SDK/import conventions upfront so every branch stays clean and passes `flutter analyze --fatal-infos` before review.

---

## 5. Verification Output

### `flutter analyze --fatal-infos`
```text
Analyzing dono_here...                                                  
No issues found! (ran in 5.2s)
```

### `flutter test`
```text
00:24 +65: All tests passed!     

```