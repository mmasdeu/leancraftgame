# Topology release checklist

Status after iteration 9. “Passed (supplementary)” means Lean 4.33.1 with the VM's prebuilt
Mathlib, not the repository's pinned Lean 4.35.0.

| Requirement | Status | Evidence / remaining action |
|---|---|---|
| T1–T15 accessible in order | Passed | Shared registry has original 60 followed by exactly T1–T15. |
| At least three exercises per topology level | Passed | Online export assertion checks typed metadata for all 15. |
| Validated solutions and feedback | Passed (supplementary) | 15 solutions, 43 mutants, zero unexpected results. All levels have hints, tests and variants. |
| Finite-model referee tests | Passed (supplementary) | `Topology/Tests.lean` accepts standard examples and isolates all four axiom failures with witnesses. |
| Reused standard spaces | Passed | Shared discrete, indiscrete, particular-point, Sierpiński and cofinite definitions; Mathlib usual topology on `ℝ`. |
| Mathlib relationship documented and checked | Passed (supplementary) | `Topology/Maps.lean`, induced/product APIs, `Filter.Tendsto`, `nhds`, and proper/bottom-filter warning in T15. |
| Mathematical distinctions and strict examples | Passed (supplementary) | Continuous/open, bijective/homeomorphic, T0/T1/T2, compact/cofinite, connected/Sierpiński, two limits checked. |
| Original 60 levels remain registered and metadata-valid | Passed | 75-level static check and online export. Only L35 title/lesson wording changed. |
| Complete current-game solution/mutant regression | Passed (pinned) | All 75 levels covered; zero unexpected results across the initial run and resumed L47–T15 run. |
| Clean pinned Lean 4.35.0 build | Passed | Installed elan and Lean 4.35.0 in project home; `lake build` completed all 3143 jobs. |
| JavaScript syntax check | Not run | `node` is unavailable. Static page code and generated data were exercised through the Python server/export only. |
| Complete browser playthrough | Not run | Run local and online games with supported toolchains and pass every level through the UI. |
| Desktop package and app self-test | Not run | Import collection and T9 self-test data updated; actual pinned package was not built. |
| Deployment | Not run | Requires preceding build/playthrough checks and normal release authorisation. |
| External mathematical review | **Required** | At least one external mathematician or advanced mathematics student must play and report feedback. |

Recommended gate order:

1. In a Lean 4.35.0 environment, run `lake exe cache get`, `lake build`, and
   `python3 check_levels.py` for the entire game.
2. Run `python3 online/build.py`; test local and hosted runs, especially T7's extra real-topology
   import and all filters in T15.
3. Build the desktop pack and execute its self-test, then perform a human topology playthrough.
4. Obtain external mathematical feedback, address it, and only then publish/deploy M9.


## Pinned verification result

Lean 4.35.0 is now installed in the project home via elan. `lake exe cache get` succeeded and
`lake build` completed all **3143 jobs**. The all-level checker was split by the one-hour command
limit: the first run covered L1 through part of L47 with no unexpected result, and a resumed
L47–T15 run used the verdict cache and ended **“All answers behave as expected.”** Thus the
automated build/regression gate passes. This does not replace the remaining UI, packaging and
external-review gates above.
