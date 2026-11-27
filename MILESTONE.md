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
| **Liya Belay** | `LeaBelay` | [#18](https://github.com/MahderK/dono_here/pull/18), [#22](https://github.com/MahderK/dono_here/pull/22) | [#14](https://github.com/MahderK/dono_here/pull/14), [#16](https://github.com/MahderK/dono_here/pull/16), [#19](https://github.com/MahderK/dono_here/pull/19) |
| **Wangari Dereje** | `wang-i` | [#16](https://github.com/MahderK/dono_here/pull/16), [#17](https://github.com/MahderK/dono_here/pull/17) | [#15](https://github.com/MahderK/dono_here/pull/15), [#18](https://github.com/MahderK/dono_here/pull/18) |

### Individual Contributions

- **Mahder Kassaw:** Bootstrapped the Flutter app, dependencies, feature-first skeleton, `project.yaml`, and proposal sections (#13). Defined `freezed` domain models, repository interfaces, in-memory stores with seed data, Riverpod providers, and unit tests (#15). Implemented nearby donor matching/sorting logic, Nearby Donors screen, and tests (#19). Contributed auth redirect/localizations fixes, M1 demo flow integration, and merge conflict resolution (#20, #21).
- **Maedot:** Implemented the `go_router` navigation architecture, `StatefulShellRoute.indexedStack` bottom navigation shell, route constants, and all 7 placeholder screens (#14). Compiled and finalized Milestone 1 documentation (`MILESTONE.md`, `AI_USAGE.md`) and resolved `material_ui` deprecation imports across the codebase.
- **Siham Tewekel:** Implemented the Sign In / Register screen with form validation, loading/error states, `AuthNotifier` in Riverpod, `register` repository method, and router auth redirect (#20). Wrote unit/widget tests using `ProviderScope` overrides and cleaned up analyzer warnings/infos (#21). Coordinated `MILESTONE.md` and `AI_USAGE.md` contributions.
- **Liya Belay:** Implemented the Donor Profile form with Riverpod draft/validation/save state, shared blood-type/Addis Ababa area helpers, and unit tests (#18). Implemented the donor-side Home blood-type/urgency filter, profile prompt, Request Detail Respond section with eligibility rules, and unit/widget tests (#22).
- **Wangari Dereje:** Implemented the Create Request form and My Requests list connected to request repositories (#16). Implemented the requester-side Home open requests list, Request Detail screen, and Mark as Fulfilled functionality (#17).

---

## 3. Group Self-Score (10-Point Checklist)

1. **All 7 proposal screens exist and are reachable via `go_router` (1/1):** Every screen (`/sign-in`, `/home`, `/profile`, `/my-requests`, `/requests/new`, `/requests/:id`, `/requests/:id/donors`) is wired in `lib/core/router/app_router.dart` (PR #14).
2. **Shell navigation & detail route parameters (1/1):** `StatefulShellRoute.indexedStack` powers the 3-tab bottom navigation bar, and detail/matching routes read the `:id` path parameter (PR #14, #17, #19, #22).
3. **Riverpod state management — no app/domain state in widgets (1/1):** Auth session, donor profile, blood requests, and matching logic are managed through Riverpod providers/notifiers rather than widget `setState` (PRs #15–#22).
4. **Freezed models & in-memory repos behind interfaces (1/1):** All domain entities use `freezed`, and in-memory implementations sit behind abstract repository interfaces exposed via Riverpod providers (PR #15).
5. **Core user stories implemented in memory (1/1):** Sign-in/register, donor profile, creating/viewing/fulfilling requests, responding as a donor, and viewing nearby matching donors all work end-to-end in memory (PRs #16–#22).
6. **At least 5 meaningful unit/widget tests (1/1):** Unit and widget tests covering repositories, providers, and UI flows were added and pass (PR #21).
7. **`flutter analyze --fatal-infos` clean (1/1):** Analyzer runs with zero errors, warnings, or infos (output pasted below).
8. **`flutter test` passes (1/1):** All unit and widget tests pass cleanly (output pasted below).
9. **PR workflow & team collaboration (1/1):** All work was merged via feature branches and reviewed pull requests (#13–#22) with no direct commits to `main`.
10. **Documentation & transparency (`MILESTONE.md` & `AI_USAGE.md`) (1/1):** Both required documents are included with PR links, self-score evidence, AI usage logs, and real command outputs.

**Total Self-Score: 10 / 10**

---

## 4. Verification Output

### `flutter analyze --fatal-infos`
```text
Analyzing dono_here...                                                  
No issues found! (ran in 5.2s)
```

### `flutter test`
```text
00:24 +65: All tests passed!     

```