# Topology branch progress

This file is the handoff point for agents working on this branch. Keep it current after every
iteration; do not mark a milestone complete when its verification has not run.

## Milestones

- [x] **M0 — repository/game audit.** [Audit](docs/repository-audit.md) inventories all 60
  levels, source maps, validation, reusable UI, replacement candidates and the toolchain blocker.
- [x] **M1 — curriculum and exercise format.** [Topology curriculum](docs/topology-curriculum.md)
  specifies T1–T15, dependencies, typed exercises, success conditions and the vertical slice.
- [ ] **M2 — targeted refinement of existing levels.** Content edits are done: L35 is now
  “Finset filters and counting”, with an explicit distinction from convergence filters. The
  original curriculum otherwise stays intact. Full playthrough verification awaits Lean 4.35.0.
- [x] **M3 — topology model and finite referee.** `Topology/Basic.lean` defines `MyTopology`,
  discrete, indiscrete, particular-point and Sierpiński examples. `Topology/Finite.lean`
  exhaustively checks finite candidates and returns stable axiom codes plus concrete witnesses.
  Automated general/finite tests pass in the supplementary 4.33.1 environment.
- [x] **M4 — T1–T4 foundations.** Four playable levels include constructions, set/family
  operations, equivalence classes and fibres, topology structures, concrete bad candidates,
  hints and solutions. T3 explains partitions and proves the fibre connection; the detailed
  arbitrary-partition construction is a possible later enrichment.
- [ ] **M5 — T5–T8 examples/continuity.** The standard examples, closed/interior/closure,
  bases and continuity exercises are playable and tested. Pending enrichment: a formal proof
  for rational-endpoint intervals on `ℝ` and a separate direct open-map counterexample in T8
  (the intended inverse-image distinction is already checked).
- [x] **M6 — T9–T11 constructions.** All three levels are playable: two-sided
  homeomorphisms and counterexamples, induced subspaces and continuous inclusions,
  coordinate-generated products/projections and finite-coordinate cylinders. Box versus
  product is distinguished mathematically by the exercises; a formal non-openness proof
  for `allTrue` is optional enrichment.
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
