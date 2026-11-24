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
| Original 60 levels remain registered and metadata-valid | Passed with new narrative | All original lessons have new act, objective and bridge metadata and texts; all 75 levels pass static checks and render in the three-act order. |
| Complete current-game solution/mutant regression | Passed (pinned) | All 75 levels covered; zero unexpected results across the initial run and resumed L47–T15 run. |
| Clean pinned Lean 4.35.0 build | Passed | Installed elan and Lean 4.35.0 in project home; `lake build` completed all 3143 jobs. |
| JavaScript syntax check | Passed | Official Node v22.23.5 archive SHA-256 verified; both app.js and live.js pass `node --check`. |
| Complete topology browser playthrough | Passed locally | Headless Chromium cleared T1–T15 through the real UI with no page errors; Next navigation and final completion passed. Original levels were covered by the full automated regression. |
| Desktop package and app self-test | Passed on Linux | 486 MB Mathlib pack and 24.1 MB app archive built; packaged self-test passed after fixing compile-rejection handling. Windows/macOS remain unverified. |
| Hosted online execution | **Blocked externally** | Static page loaded, but the public Lean Playground WebSocket returned HTTP 403 before running T7. No workaround; T15 hosted run not attempted. |
| Beta deployment configuration | **Local only — push blocked** | `pages.yml` publishes `topology` directly to `/beta`, preserving the main site. GitHub rejected the workflow commit because this connection lacks `workflows` permission; no deployment occurred. |
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


## Iteration 11 verification result

The local UI and desktop gates now pass. A packaged-app harness bug was found and fixed:
compile-rejected negative cases are now accepted consistently with the main regression runner.
The browser regression script is `tests/browser_topology.py`; it cleared all 15 topology levels.
Hosted execution remains blocked by the public service’s 403 WebSocket handshake response,
and Windows/macOS, deployment and external mathematical review are not claimed complete.
