# Topology branch progress

This file is the handoff point for agents working on this branch. Keep it current after every
iteration; do not mark a milestone complete when its verification has not run.

## Milestones

- [x] **M0 — repository/game audit.** [Audit](docs/repository-audit.md) inventories all 60
  levels, source maps, validation, reusable UI, replacement candidates and the toolchain blocker.
- [x] **M1 — curriculum and exercise format.** [Topology curriculum](docs/topology-curriculum.md)
  specifies T1–T15, dependencies, typed exercises, success conditions and the vertical slice.
- [ ] **M2 — targeted refinement of existing levels.** Rename L35's finite-sum “Filters” title;
  otherwise preserve the already aligned curriculum unless regression evidence supports edits.
- [ ] **M3 — topology model and finite referee.** Shared `MyTopology`, standard finite examples,
  axiom-specific diagnostics and automated tests are not implemented yet.
- [ ] **M4 — T1–T4 foundations.** T1 is only a one-exercise architecture placeholder, not a
  completed level; T2–T4 are not implemented.
- [ ] **M5 — T5–T8 examples/continuity.**
- [ ] **M6 — T9–T11 constructions.**
- [ ] **M7 — T12–T14 global properties.**
- [ ] **M8 — T15 filters/convergence.**
- [ ] **M9 — integration and release.** Requires the pinned build, full regression/playthrough,
  and external mathematical review.

## Iteration 1 — audit, specification, and stable topology IDs

Implemented:

* Created the GitHub `topology` branch.
* Extended level IDs from integers to `L<n>` plus prefixed IDs such as `T1`, preserving numeric
  saved-game keys and numeric test IDs. Updated HTTP routes, CLI, online export, app packing,
  browser navigation/deep links, labels and issue reporting.
* Added optional typed `exercises` metadata and cross-validation against test names.
* Added a playable T1 architecture placeholder with an accepted answer and an overlap mutant.
* Documented the full audit and topology curriculum.

Verification:

* `python3 check_levels.py --static` at the original baseline: **passed**.
* `lean -o .scratch/lean/LeanCraftGame.Referee.olean LeanCraftGame/Referee.lean` using the VM's
  prebuilt Lean/Mathlib 4.33.1: **passed** (supplementary, not the pinned build).
* `lake build LeanCraftGame.Referee`: **blocked/failed** because repo pins Lean 4.35.0 but only
  4.33.1 is installed; dependency sources do not compile under the older compiler.
* Current branch `python3 check_levels.py --static`: **passed** for 61 levels.
* T1 with the supplementary 4.33.1 environment: starting file rejected by `#no_sorry`;
  `correct.lean` **4/4 passed**; `bug_overlap.lean` produced **2 proved failures**.
* Registry/deep-link/HTTP smoke checks: **passed**; `/api/levels` returns 61 levels and
  `/api/levels/T1` returns the T1 lesson and four tests.
* `python3 online/build.py`: **passed**, exporting all 61 levels.
* JavaScript syntax check was **not run**: `node` is unavailable in this VM.

Next iteration:

1. Build and test the shared `MyTopology` model and axiom-specific finite referee (M3).
2. Complete T2/T4 foundations needed by the vertical slice, then add Sierpiński T5.
3. Keep general theorem tests separate from finite exhaustive checks.

Release blocker: install/use Lean 4.35.0 in the verification environment, run every original
and topology solution/mutant, and perform a clean browser playthrough. An external topology
reviewer is still required by M9.
