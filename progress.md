# Topology branch progress

> **Narrative redesign (current objective):** this branch now supersedes the earlier
> “append topology and make targeted edits” approach. All original lessons have been
> re-authored into the Sequences → Limits → Topology progression below. Do not revert to the
> old twelve-world structure described in the historical log.

This file is the handoff point for agents working on this branch. Keep it current after every
iteration; do not mark a milestone complete when its verification has not run.

## Milestones

- [x] **M0 — repository/game audit.** [Audit](docs/repository-audit.md) inventories all 60
  levels, source maps, validation, reusable UI, replacement candidates and the toolchain blocker.
- [x] **M1 — curriculum and exercise format.** [Topology curriculum](docs/topology-curriculum.md)
  specifies T1–T15, dependencies, typed exercises, success conditions and the vertical slice.
- [x] **M2 — narrative redesign (superseding targeted refinement).** All 60 original
  lessons are now framed as Sequences → Limits → Topology, with structures and type classes
  serving as topological preparation. The earlier “otherwise intact” curriculum is historical,
  not the current game structure.
- [x] **M3 — topology model and finite referee.** `Topology/Basic.lean` defines `MyTopology`,
  discrete, indiscrete, particular-point and Sierpiński examples. `Topology/Finite.lean`
  exhaustively checks finite candidates and returns stable axiom codes plus concrete witnesses.
  Automated general/finite tests pass in the supplementary 4.33.1 environment.
- [x] **M4 — T1–T4 foundations.** Four playable levels include constructions, set/family
  operations, equivalence classes and fibres, topology structures, concrete bad candidates,
  hints and solutions. T3 explains partitions and proves the fibre connection; the detailed
  arbitrary-partition construction is a possible later enrichment.
- [x] **M5 — T5–T8 examples/continuity.** Standard examples, closure, bases and continuity
  are implemented. T7 checks `Real.isTopologicalBasis_Ioo_rat`; T8 distinguishes continuous
  from open maps with a constant-false discrete-to-Sierpiński example.
- [x] **M6 — T9–T11 constructions.** All three levels are playable: two-sided
  homeomorphisms and counterexamples, induced subspaces and continuous inclusions,
  coordinate-generated products/projections and finite-coordinate cylinders. Box versus
  product is distinguished mathematically by the exercises; a formal non-openness proof
  for `allTrue` is optional enrichment.
- [x] **M7 — T12–T14 global properties.** Open-cover compactness, separation-based
  connectedness and T0/T1/Hausdorff are implemented. Finite, infinite-discrete,
  infinite-cofinite, Sierpiński and continuous-image examples are verified by general
  Lean/Mathlib theorems where required.
- [x] **M8 — T15 filters/convergence.** Neighbourhoods, `nhds`, `Filter.Tendsto`, discrete
  eventual equality, two distinct Sierpiński limits and Hausdorff uniqueness are implemented.
- [ ] **M9 — integration and release.** Pinned build/regression, JS syntax, local full-topology
  browser playthrough, and Linux desktop package/self-test now pass. Hosted execution was blocked
  by the public Lean Playground's 403 WebSocket response. Windows/macOS packages, deployment
  and external mathematical review remain open.

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

## Iteration 2 — shared topology model and finite referee

Implemented general `MyTopology` with arbitrary unions via `sUnion`, derived empty-set and
indexed-union laws, reusable standard examples, and an executable finite checker. The finite
checker tests `∅`, `univ`, every binary intersection and every subfamily union, returning
`axiom_violation/...` plus offending sets. Regression tests accept discrete, indiscrete and
Sierpiński families and independently reject all four axiom failures. They also verify the
missing union `{0,1}` witness. L35 was renamed and its lesson now distinguishes `Finset.filter`
from mathematical filters.

Verification: direct Lean compilation of `Topology/Basic.lean`, `Topology/Finite.lean`, and
`Topology/Tests.lean` **passed** with the VM's prebuilt 4.33.1 Mathlib. This supplements, but
does not replace, the pending pinned 4.35.0 build.

Next iteration: complete T2 and T4, connect the finite referee to their exercises, and add the
Sierpiński exercise in T5 for the first vertical slice.

## Iteration 3 — T2, T4 and T5 vertical-slice exercises

Implemented the family-definition, topology-structure and Sierpiński exercises. T2's finite
counterexample uses `List (Finset (Fin 3))`, with executable intersection/union diagnoses; its
arbitrary-union predicate also has a direct empty-subfamily semantic gate. T4 checks the actual
structure fields with Lean rather than asking the search referee to discover higher-order proofs.
T5 accepts `particularPoint true` and rejects the discrete and wrong-point constructions.

Verification with the supplementary 4.33.1 environment:

* T2 `correct.lean`: **9/9**; three mutants rejected (semantic gates or type errors).
* T4 `correct.lean`: **2/2 plus four structural checks**; two malformed structures rejected.
* T5 `correct.lean`: **4/4**; two wrong constructions produce proved failures.
* `python3 check_levels.py --static`: **passed for 63 levels**.

T1 remains only an architecture placeholder; T3, the rest of T4's diagnosis content and the
other T5 examples remain open. Next: T8/T9 complete the five-exercise end-to-end vertical slice.

## Iteration 4 — complete end-to-end vertical slice

Added T8 continuity and T9's continuous-bijection/non-homeomorphism counterexample. Shared
`Topology/Maps.lean` now bridges `MyTopology` to `TopologicalSpace` and proves `MyContinuous`
equivalent to Mathlib `Continuous`; identity and constant continuity lemmas are included.
The vertical checkpoint and its acceptance table are in [Vertical slice](docs/vertical-slice.md).

Verification with the supplementary 4.33.1 environment:

* shared topology mathematical tests: **passed**;
* T8: **3/3** plus identity, constant-map and explicit inverse-non-continuity Lean gates;
* T9: **3/3** plus bijectivity, forward continuity and inverse non-continuity Lean gates;
* all five vertical levels share the normal exercise format and reject their included mutants.

Desktop integration was audited and updated: import collection includes shared modules imported
by `Tests.lean`; all compiled game `.olean` files are copied; T9 is bundled into app self-tests.
Python compilation and import-collection assertions pass, but a desktop package was not built.
`python3 check_levels.py --static` and `python3 online/build.py` **pass for 66 levels**;
ordered topology registry/deep-link export checks pass. Node remains unavailable for a JS
syntax-only check, and the pinned toolchain remains the release blocker.

## Iteration 5 — completed foundations T1–T4

T1 now covers disjointness, covers, both preimage operations and a constant-map direct-image
counterexample. T3 adds independent relation axioms, equivalence structures, equivalence
classes and kernel/fibre connections. T4 has a second rejected open family, so its diagnosis
exercise uses two incorrect candidates. All have full-player solutions and deliberate mutants.

Supplementary 4.33.1 verification: T1 **10/10**, T3 **9/9**, T4 **3/3**, with all relevant
semantic gates and tested mutants behaving as expected. `check_levels.py --static` and the
online export pass. Next: expand M5 standard examples, closure and bases.

## Iteration 6 — M5 standard examples, closure and bases

T5 now constructs discrete, indiscrete, Sierpiński, particular-point and cofinite topologies.
The general cofinite construction is proved in the shared library. T6 implements closed sets,
interior, closure, density and clopen predicates with monotonicity and concrete example checks.
T7 implements both basis axioms, generated opens and a two-point basis not closed under unions.
T8 remains the verified continuity construction from the vertical slice.

Supplementary 4.33.1 verification: T5 **8/8**, T6 **6/6**, T7 **4/4**, all semantic gates and
mutants behaving as intended. Static validation and the online export pass. Full M5 remains open
because the formal rational-endpoint basis proof and a distinct T8 open-map exercise are pending.

## Iteration 7 — topological constructions T9–T11

Expanded T9 with the full homeomorphism structure and inverse-field checks. Added T10's
Mathlib `induced` subspace construction and continuous inclusion, plus the Sierpiński
open-not-closed example. Added T11's coordinate-generated product, open rectangles,
continuous projections, one-coordinate cylinders and infinite box-style `allTrue` example.

Supplementary 4.33.1 verification: T9 **4/4**, T10 **4/4**, T11 **4/4**, with all semantic
checks and included mutants behaving as intended. Static metadata and online export pass.
Next: global properties T12–T14 and the infinite cofinite proofs they require.

## Iteration 8 — global properties T12–T14

T12 uses unindexed covers and `Finset (Set α)` subcovers after the indexed version exposed an
unnecessary universe-polymorphism complication. General examples use Mathlib instances for
finite compactness, infinite-discrete noncompactness and cofinite compactness. T13 includes
Sierpiński connectedness, discrete-Bool separation and continuous images. T14 proves
Hausdorff ⇒ T1 ⇒ T0 and verifies Sierpiński T0/not-T1 plus infinite-cofinite T1/not-T2.
All distinguish infinite general proofs from finite checks.

Supplementary 4.33.1 verification: T12 **2/2**, T13 **2/2**, T14 **3/3**, all semantic gates
and included mutants behaving as expected. Static metadata and online export pass.
Next: T15 neighbourhoods, filters and convergence, then full integration/regression accounting.

## Iteration 9 — all 15 topology levels and final integration

Completed T15 neighbourhoods, filters and convergence. The constant-true Sierpiński sequence is
proved to converge to both distinct Boolean points; discrete convergence gives eventual equality
and `tendsto_nhds_unique` supplies Hausdorff uniqueness. Completed M5's remaining items with the
Mathlib rational-endpoint basis theorem and T8's continuous-but-not-open map.

Full topology regression using the supplementary Lean 4.33.1 environment:

* 15 correct answers and 43 deliberate mutants: **58 non-start answers, 0 unexpected results**;
* every starting file rejected, every correct answer passes all checks, every listed mutant is
  rejected or produces a proved failure;
* `python3 check_levels.py --static`: **passed**;
* online export: **75 levels**, with T1–T15 ordered and at least three typed exercises each;
* pinned 4.35.0 build, browser playthrough, deployment and external mathematical review remain
  open under M9 (see [Release checklist](docs/release-checklist.md)).

## Iteration 10 — pinned Lean 4.35.0 release build and full regression

Installed elan 4.2.4 and the pinned `leanprover/lean4:v4.35.0` toolchain in this project's home,
then downloaded the matching Mathlib cache with `lake exe cache get`. With
`PATH="$HOME/.elan/bin:$PATH"`:

* `lake build`: **passed all 3143 jobs**, with only the existing `Mathlib.Tactic` module-system
  warnings in `Referee.lean` and `Topology/Basic.lean`.
* Complete `python3 check_levels.py` regression: **all 75 levels behaved as expected**. The
  initial run hit the one-hour command limit during L47 without unexpected results. A second
  invocation covering L47–L60 and T1–T15 reused the verdict cache and ended with
  **“All answers behave as expected.”** Together the two runs cover the whole game.
* This closes the pinned clean build and complete automated original/topology regression gates.
  Browser playthrough, packaging, JS syntax check, deployment and external review remain open.

## Iteration 11 — M9 UI and desktop release checks

Completed the local release checks and tested the hosted path:

* JavaScript: official Node v22.23.5 archive SHA-256 verified; both `web/static/app.js` and
  `web/static/live.js` pass `node --check`.
* Desktop pack: `app/make_pack.py --out dist --url-base file:///unused` succeeded (15,615 files,
  486 MB); `app/build_app.py` produced the 24.1 MB Linux archive. The initial packaged self-test
  exposed an app-harness bug: a compile-rejected T9 mutant was reported as a harness failure.
  Updated `app/launcher.py` to accept compile rejection consistently with `check_levels.py`.
  Rebuilt package and **packaged app self-test passed**, covering L1, L13 and T9 positive/negative.
* Browser: pinned local server plus headless Chromium cleared **all 15 topology levels through the
  real UI**, with no page errors. T1→T2 Next navigation and the final T15 completion state passed.
  Reproducible test: [tests/browser_topology.py](tests/browser_topology.py).
* Hosted backend: the static online page loaded and started T7, but the public Lean Playground
  WebSocket returned **HTTP 403 during handshake** (`Could not connect`). No code executed remotely.
  The same backend for T15 was not run; no workaround was attempted and no hosted pass is claimed.

M9 remains open only for Windows/macOS packaging, deployment and the required external
mathematician/student playthrough, plus any hosted-backend retest when the public service permits it.

## Iteration 12 — complete sequence/limit/topology narrative redesign

Reworked all original 60 lesson texts and metadata, not just the topology appendage. Every
original level now has a new story-led title, act, chapter, objective and explicit bridge to its
next step. Added **ACT I — SEQUENCES**, **ACT II — LIMITS**, and **ACT III — TOPOLOGY** to the
actual lesson UI. Structure/class levels now explicitly prepare packaged topology axioms and
instances; the three prime/orbit/Goldbach auditing levels form a coda after T15 rather than a
pre-topology detour. Intro, landing page and README now describe a single mathematical journey.

`level.json` now supplies narrative `order`; the shared registry sorts by it while retaining
stable IDs and saved progress. Actual order is L1–L57, T1–T15, then L58–L60. Generated the new
[Curriculum](CURRICULUM.md), full [narrative design](docs/narrative-redesign.md) and 60-row
[narrative data](docs/narrative-data.json). Static narrative checks and docs are retained in
`tests/check_narrative.py`; Chromium coverage is in `tests/browser_narrative.py`.

Verification:

* all 60 original lessons have new titles, acts, objectives and bridges; all T1–T15 have
  callbacks to the preceding acts;
* all 75 browser pages render in the new order, with no JavaScript page errors;
* representative browser solutions passed L1 (4/4), L23 (9/9), L39 (6/6), T15 (5/5);
* T15 Next correctly enters L58's coda; static level metadata and 75-level online export pass;
* existing proof tests and solutions were preserved, so the full proof regression from iteration
  10 remains the mathematical baseline while text/navigation changes receive focused UI tests.

## Iteration 13 — narrative merged with beta publication

Integrated the `/beta` Pages deployment configuration with the complete three-act narrative.
The publication configuration originally required a repository-author workflow push and is now
also present on remote `topology`; the local permission-boundary note is preserved in history.
Root site and `/play` remain separate from `/beta`, all published branches use the same shared
registry and current 75-level storyline. Merge conflict in this file is resolved by preserving
both records. Static and browser verification below precedes the publication check.


## Publication check — beta is updated

Merged `narrative-redesign` into `topology` as `20cb28e` and pushed it. GitHub Actions
[run 45440289153](https://github.com/mmasdeu/leancraftgame/actions/runs/45440289153) completed
successfully, including the Pages publication step. The raw published file
`gh-pages/beta/data/levels.json` contains 75 levels, beginning with `Sequences / Record a first
reading` and ending with `Topology / Audit a famous conjecture`. The CDN may briefly continue to
serve the earlier build; the underlying beta artifact is confirmed updated for review.
