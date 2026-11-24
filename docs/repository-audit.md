# M0 repository and game audit

Audit baseline: commit `72937c2`, before the topology branch changes.

## Architecture and validation

Each level has one directory containing `Player.lean` (lesson and editable definitions),
`Tests.lean` (referee battery), and `level.json` (navigation, signature checks, predictions,
public tests and hints). `variants/<ID>/` contains accepted answers and deliberate mutants.
The source map is therefore `LeanCraftGame/L<n>/{Player.lean,Tests.lean,level.json}` and
`variants/L<n>/`, for each row below. The shared runner is `web/server.py`; the browser is
plain JavaScript in `web/static/`; `online/build.py` exports the same content for the hosted
version. `app/make_pack.py` collects imports for desktop releases.

Validation has four existing layers: Lean type checking and explicit signature checks;
`#no_sorry` gates; model/anti-model tests for structures; and hidden theorem/anti-theorem
batteries proved or refuted by `LeanCraftGame/Referee.lean`. A ❌ requires a Lean proof of
the opposite proposition. A timeout or unproved statement is ❓, never a counterexample.
This already implements the plan's central mathematical-honesty requirement.

Reusable components are the Markdown lesson viewer, Lean editor and diagnostics, prediction
and hint gates, model tests, mutation tests, verdict cache, sample-answer regression runner,
MathJax test rendering, and the symbol drawer. Reusable mathematical definitions live inside
individual level namespaces; there is currently no shared mathematical example library.

The server originally discovered only `L[0-9]*`, and the browser converted level IDs with
`Number(...)`. The topology branch introduces stable string IDs (`T1`–`T15`) while retaining
numeric IDs and saved progress for the original game. The online exporter, CLI, app packer,
and HTTP routes use the same registry.

## Inventory of all existing levels

The test count includes true/false, model and mutation checks. “Skill” is the existing
classification in `level.json`.

| ID | World | Title | Skill | Referee checks |
|---:|---|---|---|---:|
| 1 | Basics World | Naming things | syntax | 4 |
| 2 | Basics World | Functions | syntax | 9 |
| 3 | Basics World | Making choices | syntax | 10 |
| 4 | Basics World | Recursion | syntax | 11 |
| 5 | Basics World | Challenge: counting | writing | 18 |
| 6 | Basics World | Spot the bug | reading | 2 |
| 7 | Statements World | True or false? | syntax | 11 |
| 8 | Statements World | And | syntax | 13 |
| 9 | Statements World | Or and not | syntax | 13 |
| 10 | Statements World | Challenge: calendars and triangles | writing | 23 |
| 11 | Statements World | Spot the bug: connectives | reading | 6 |
| 12 | Numbers World | Integers and casts | syntax | 9 |
| 13 | Numbers World | Division by zero | writing | 13 |
| 14 | Numbers World | Challenge: truncated arithmetic | writing | 22 |
| 15 | Numbers World | Spot the bug: numbers | reading | 4 |
| 16 | Quantifiers World | For all | syntax | 10 |
| 17 | Quantifiers World | If … then … | syntax | 9 |
| 18 | Quantifiers World | There exists | syntax | 9 |
| 19 | Quantifiers World | Quantifiers in order | syntax | 8 |
| 20 | Quantifiers World | Bounded quantifiers | syntax | 9 |
| 21 | Quantifiers World | Challenge: patterns in sequences | writing | 16 |
| 22 | Quantifiers World | Spot the bug: quantifiers | reading | 6 |
| 23 | Predicate World | Going to infinity | writing | 9 |
| 24 | Predicate World | Bounded and monotone | writing | 18 |
| 25 | Predicate World | Injective and surjective | writing | 17 |
| 26 | Predicate World | Sequences that come back | writing | 27 |
| 27 | Predicate World | Be the referee | testing | 10 |
| 28 | Library World | Sets | syntax | 10 |
| 29 | Library World | Using Mathlib | writing | 14 |
| 30 | Library World | Generality | writing | 12 |
| 31 | Library World | Divisibility and gcd | writing | 22 |
| 32 | Library World | Relations | writing | 35 |
| 33 | Library World | Spot the bug: the library | reading | 6 |
| 34 | Finite Sums World | Sums | syntax | 17 |
| 35 | Finite Sums World | Filters and counting | writing | 24 |
| 36 | Finite Sums World | Closed forms | writing | 25 |
| 37 | Finite Sums World | Challenge: finite sums | writing | 21 |
| 38 | Finite Sums World | Spot the bug: sums | reading | 4 |
| 39 | Analysis World | Limits | writing | 6 |
| 40 | Analysis World | Continuity | writing | 16 |
| 41 | Analysis World | Cauchy sequences | writing | 8 |
| 42 | Analysis World | Cluster values | writing | 14 |
| 43 | Analysis World | Spot the bug: limits | reading | 4 |
| 44 | Structure Syntax World | Declaring a structure | syntax | 19 |
| 45 | Structure Syntax World | Functions on structures | writing | 21 |
| 46 | Structure Syntax World | Extending and updating | syntax | 22 |
| 47 | Structure Syntax World | Challenge: structures | writing | 24 |
| 48 | Structure Syntax World | Spot the bug: structures | reading | 4 |
| 49 | Structure World | Your first structure | writing | 6 |
| 50 | Structure World | Order relations | writing | 11 |
| 51 | Structure World | Metric spaces | writing | 13 |
| 52 | Structure World | A colleague's groups | reading | 11 |
| 53 | Classes World | Classes and instances | syntax | 12 |
| 54 | Classes World | Standard instances | writing | 14 |
| 55 | Classes World | Instances that depend on instances | writing | 20 |
| 56 | Classes World | Challenge: classes | writing | 23 |
| 57 | Classes World | Spot the bug: classes | reading | 3 |
| 58 | Faithfulness World | The AI proved the infinitude of primes! | auditing | 13 |
| 59 | Faithfulness World | The AI proved the Collatz conjecture! | auditing | 12 |
| 60 | Faithfulness World | The AI proved Goldbach! | auditing | 6 |

## Content assessment and replacement candidates

The inventory matches the requested Part I progression closely. Basics, statements,
quantifiers, predicates, sets/relations, finite sums, analysis, structures/classes and
mathematical auditing are already present, with both construction and counterexample tasks.
There is no evidence for replacing the 60 levels wholesale. M2 should make targeted edits
only after running their existing mutants and solutions.

* **L35, “Filters and counting”**: rename to **“Finset filters and counting”**. Its exercises
  use finite-sum/filter notation, not mathematical filters; topology T15 will introduce
  neighbourhood filters.
* Spot-the-bug levels (6, 11, 15, 22, 33, 38, 43, 48, 57) are the existing repair/refute
  anchors. They should remain accessible and their feedback should be retained.
* Levels 27 and 58–60 explicitly teach test sufficiency, conjectures and vacuity; they
  should not be converted into ordinary proof exercises.

## Baseline checks and environment blocker

`python3 check_levels.py --static` passed for all original levels at the baseline.

`lake build LeanCraftGame.Referee` could not establish a clean pinned build in this VM:
the repository pins Lean 4.35.0, while the available `lean`/`lake` are 4.33.1. Lake fetched
the pinned sources but failed while compiling dependencies against the older compiler.
No source incompatibilities in the game itself were established by that failure. As a
supplementary check only, `lean -o .scratch/lean/LeanCraftGame.Referee.olean
LeanCraftGame/Referee.lean` succeeds against the VM's prebuilt 4.33.1 Mathlib.

A full clean-checkout build and all-answer playthrough still need Lean 4.35.0. This is a
release blocker, not silently a passing test.

## Where to add a level

1. Create `LeanCraftGame/T<n>/` with the three standard files and `variants/T<n>/` with
   `correct.lean` and at least one `bug*.lean` answer.
2. Discoverability is automatic: the shared registry reads original `L<n>` directories and
   prefixed directories such as `T<n>`; no second level list needs editing.
3. Import only the Mathlib modules needed by the lesson. Shared topology examples belong in
   `LeanCraftGame/Topology/`, not in a level namespace.
4. Validate metadata with `python3 check_levels.py --static`; validate solutions/mutants
   with `python3 check_levels.py T<n>` under the pinned toolchain.
5. Run `python3 online/build.py` to ensure static export includes the level.
