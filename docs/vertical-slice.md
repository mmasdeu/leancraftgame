# Vertical-slice acceptance record

The first end-to-end topology prototype contains the five exercises required by the plan.

| Exercise | Level | Success mechanism | Verification |
|---|---|---|---|
| Define a family of subsets | T2 | General Lean types plus explicit finite models | Correct answer 9/9; three mutants rejected |
| Define a topology | T4 | Direct structure-field and semantic Lean checks | Correct answer 2/2 plus four gates; two mutants rejected |
| Construct Sierpiński space | T5 | Reusable pedagogical structure and finite examples | Correct answer 4/4; two mutants refuted |
| Define continuity | T8 | Inverse-image predicate and genuine general Lean checks | Correct answer 3/3 plus identity/constant/non-continuity gates |
| Continuous bijection, not homeomorphism | T9 | Explicit discrete-to-indiscrete identity counterexample | Correct answer 3/3 plus bijection/bidirectional-continuity gates |

All five use `Player.lean`, `Tests.lean`, `level.json`, predictions/visibility/hints and
`variants/<ID>/`, so construction, submission and feedback use the standard game UI. T2 and
`Topology/Tests.lean` exercise finite-model checking; T4/T8 include genuine Lean proofs; T9
requires explicit counterexample data. Existing compile errors, proved failures and ❓
unsettled outcomes remain distinct, and no timeout is described as a counterexample.

## Shared infrastructure

* `Topology/Basic.lean`: `MyTopology`, discrete, indiscrete, particular-point, Sierpiński.
* `Topology/Finite.lean`: stable finite axiom diagnostics and concrete witnesses.
* `Topology/Maps.lean`: `MyContinuous`, identity/constant lemmas and the Mathlib bridge.
* `Topology/Tests.lean`: automated mathematical and finite-model tests, included by the root
  `LeanCraftGame.lean` build target.
* Desktop import collection now includes shared modules imported by tests and copies every
  compiled game `.olean`; app self-test cases include T9.

## Not yet complete

This is the requested early checkpoint, not all of M4–M6. T1 remains a placeholder, T3 and
most content in T5–T9 are pending. There is no complete 15-level playthrough yet. The VM has
Lean 4.33.1 while the project pins 4.35.0, so clean Lake builds, online execution against its
current Mathlib and desktop packaging still require verification with supported toolchains.
