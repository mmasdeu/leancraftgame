# Writing a level (v3)

A level is a directory `LeanCraftGame/L<n>/` with three files, plus sample answers in
`variants/L<n>/`. The number `n` is the position in the game (`LEVELS` in `web/server.py`
is the sorted list of directories).

| File | Contents |
|---|---|
| `Player.lean` | The first comment is the lesson (Markdown). Then the `import` lines the level needs (a part of Mathlib, `LeanCraftGame.Lib.*`): the player never sees them, and every test file gets them. The code inside `namespace L<n>` … `end L<n>` is what the player sees and edits; the two lines are hidden in the editor. |
| `Tests.lean` | `#no_sorry` gates, then `#level_start`, the tests and `#level_report`. Other lines (a referee's copy of a colleague's code, helper definitions) form the preamble. |
| `level.json` | `world`, `title`, `skill`, `exercise` (one of Write, Read, Construct, Refute, Repair, Audit), and optionally `predict`, `public`, `hintsAfter`, `checks` (signature checks), `hints`, `questions` (reading levels) and `timeout` (seconds per test, 60 to 300, for a level whose searches are long; the default is 60). |
| `variants/L<n>/*.lean` | `correct*`/`fix*` must clear the level; `bug*` must get at least one ❌ (or be rejected by a check); `other*` (a statement other than the one asked that the referee cannot refute: a true one, or a false one beyond its reach) must not clear the level and must get no ❌. Write them without the `namespace` lines. |

## "More info" boxes

A lesson can hold optional material in a collapsible box, closed by default:

```
:::more How Mathlib names lemmas
Text, lists and code blocks, as in the rest of the lesson.
:::
```

Use them for what a working Mathlib user needs but the task does not: how Mathlib really does
it (names, where things live, how to find a lemma, pitfalls) and the Lean behind it (coercions,
typeclass resolution, definitional equality, universes). A task must never depend on a box.

## Test commands

| Command | Passes when |
|---|---|
| `#expect_true "name" unfolding f g : P` | the referee proves `P` (❌: it proves `¬ P`) |
| `#expect_false "name" unfolding f g : P` | the referee proves `¬ P` (❌: it proves `P`) |
| `#expect_model "name" unfolding f : S.mk d₁ d₂` | every remaining field (axiom) of `S` holds for this data (`unfolding` the player's definitions used as data) |
| `#expect_not_model "name" unfolding f : S.mk d₁ d₂` | some axiom provably fails |
| `#expect_open "name" : P` | neither `P` nor `¬ P` is settled (a famous open problem) |
| `#expect_caught "name" : P` | `P` ("this mutant agrees with every probe") is refuted |
| `#expect_equiv "name" unfolding f : foo ↔ Q using h` | the player's statement `foo` says the same as `Q` (below) |
| `#expect_type "name" : e : T` | `e` elaborates with type `T` (❌ carries Lean's error) |
| `#expect_choice "name" : q = k` | the answer `q` to a reading question is `k` |

### Statements: `statement` and `#expect_equiv`

`statement foo (a b : ℝ) (h : 0 ≤ a) : P a b` is the game's theorem-without-proof: it
is `abbrev foo : Prop := ∀ (a b : ℝ), 0 ≤ a → P a b`. The player writes binders and
hypotheses exactly as in a Mathlib `theorem`.

`#expect_equiv "name" : L<n>.foo ↔ Q` compares a closed statement with the reference `Q`
**by shape**, because any two true statements are logically equivalent (`1 = 1` would
otherwise "say" AM-GM). Shapes match when the binders, hypotheses and conclusion agree in
order, up to: variable names, `( )` versus `{ }`, `≥`/`>` for `≤`/`<`, `≠` and `¬`
pushed inwards (`push_neg`), the sides of `=` swapped or reordered by `ac_rfl`, and the
sides of `≤`/`<` rewritten by `ring`. When shapes differ the referee looks for proof that
the statements differ: with `using h` (a Mathlib proof of `Q`, or of `¬ Q`) it only has to
refute the player's statement, which is fast; without it, it settles both sides. A true
statement of another shape gets ❓ (write an `other*` variant for it).

When the test is `∀ x, foo x ↔ Q x` (a *definition*, not a closed statement), agreeing
for every `x` is enough, and the referee also tries `push_neg`, `simp`, `tauto`, `grind`
and its own search. A wrong definition is best caught by instance tests (`#expect_true`
on a concrete sequence or function), which find counterexamples far more often.

### Reading levels: `questions` and `#expect_choice`

A reading level asks questions about Lean code shown in the lesson. Each question is an
answer line in the template, `def q1 : Fin 4 := sorry` (a multiple choice with four
choices, answered by the index of a choice, from 0) or `def q2 : Bool := sorry`, and an
entry in `level.json`:

```json
"questions": [
  {"answer": "q1", "text": "What does `#check am` print?", "choices": ["…", "…", "…", "…"]},
  {"answer": "q2", "text": "True or false: …"}
]
```

The browser shows the questions under the lesson as buttons that write the answer into
the code. Answers are graded without Lean (in the browser, and by `grade_answer` in
`web/server.py`): the key is read from the `#expect_choice` line, whose right-hand side must
be a literal (`2`, `true`, `false`). An `#expect_choice` on a name that is not a question
(a computed value, as in level 18) still runs in Lean. Test them with `#expect_choice "Question 1: …" : q1 = 2`, and gate each answer
with `#no_sorry`. Name a test after its question, never after its answer.

## Signature checks

`checks` in `level.json` are compiled after the player's code, before the tests, to reject
an answer that changed a name or a type. Write them with `#check`, not `example`
(an `example` over `ℝ` fails to compile as non-computable):

```json
"checks": [{"lean": "#check (L2.am : ℝ → ℝ → ℝ)", "message": "Keep `am : ℝ → ℝ → ℝ`."}]
```

`python3 check_levels.py --static` validates the metadata; `python3 check_levels.py 5 6`
runs the sample answers through the referee (use `--jobs 2` on a small machine).

## Rules of thumb

* **Follow the story.** Each world is a project of the Annex ([NARRATIVE.md](NARRATIVE.md)).
  A lesson opens with a short italic hook, teaches one piece of syntax or one reading or
  writing skill, and works an example that builds on an object of an earlier level (the
  `am` of level 2, the `ConvergesTo` of level 12, the `GaussInt` of level 30). Lessons never
  refer to an outside book or course. Use Mathlib's own names (`Set`, `Function.Injective`,
  `Filter.Tendsto`, `deriv`) from the Logic world on.
* **Every level has a trap**, and a prediction (or a question) aims at it.
* **Definitions only.** The player never proves. Where a mathematician would prove, ask for a
  definition, a witness or a counterexample, and let a test state the theorem.
* **Every test is a claim the player can read.** In reading levels, phrase tests as claims
  about the player's counterexample that must be true ("your two numbers do not multiply to 1").
* **Never depend on an earlier level's answer.** Give the needed definitions in the template,
  or use the referee's copy (`Top.Ref.*` in the Topology world).
* **Honesty.** ❌ must mean a proof of the opposite. A correct answer that gets ❓ is a bug in
  the level: simplify the test (split a conjunction, use explicit sets) until the referee
  settles it, and run every variant.

## Making tests settle

* Finite statements are decided by `decide` / `decide +kernel` before any search. Statements
  about `Fin n`, `Finset (Fin n)`, `Family n` and bounded quantifiers over them (`∀ U ∈ T`,
  `∀ x : Fin n`, even `∃ T : Family 3`) are decided exhaustively. The referee raises
  `synthInstance.maxSize` so that deeply nested bounded quantifiers get a `Decidable` instance.
* `unfolding A B` unfolds the player's definitions (in that order) before the search. List
  every definition the statement goes through, including the gallery (`Top.sierpinski`) when the
  search must see the members of a family.
* The witness search tries small numbers `0–4, 6, 100`, expressions built from the variables in
  sight (`x + 1`, `2x`, `2x + 1`, `x - 1`), and the members of an explicit `{a, b, …}` in
  `∃ U ∈ {a, b, …}` or `∀ U ∈ {a, b, …}` hypotheses. Choose numbers in levels accordingly
  (the referee will not find `5`).
* Over `ℕ → ℕ` sequences and `Set ℕ` the referee reasons rather than computes; prefer
  `fun n => if … then … else …` with small thresholds.
* Statements about equality of functions or of structures are hard; compare fields
  (`(f z).re = 3 ∧ (f z).im = 4`) or values instead.

## Names

The player's code lives in `namespace L<n>`, and the tests `open` it. A player name that also
exists at the root of Mathlib (`dist`, `interior`, `closure`, `IsClosed`, `IsOpenMap`, `flip`,
`norm`, …) makes the tests ambiguous. Either choose another name or write the tests with
qualified names (`L63.closure`) and without `open L63`. Messages shown to the player have the
`L<n>.` prefix removed (`tidy` in `web/server.py` and `web/static/live.js`).

## The shared library

`LeanCraftGame/Lib/Topology.lean` holds the finite spaces and the referee's definitions. A new
library module must import only Mathlib and other `Lib` modules, must not use `initialize`,
and is picked up by `online/build.py` (which pastes it into the online prelude, before the
player's code) and by `lake build LeanCraftGame` (add it to `LeanCraftGame.lean`).

## Pitfalls

* **No `-/` inside the lesson.** The lesson is the first comment of `Player.lean` and ends at
  the first `-/`, so a doc comment `/-- … -/` inside one of its code blocks cuts it short.
  Write such examples without the doc comment. `check_levels.py --static` reports it.
* **Module names change between Mathlib versions.** `--static` checks that every import of
  `Player.lean` exists in the pinned Mathlib.
* **Membership in an ideal or a submodule.** The referee's normalisation introduces through
  `x ∈ Ideal.span s` into raw set statements. Wrap such facts in an `@[irreducible]`
  definition with a simp lemma back to membership (see L37's Tests preamble).
* **Reference proofs.** A `using` proof is checked when the test runs: if it does not
  elaborate (a missing import, a renamed lemma), the test is ⚠ even for a correct answer.
* **Load.** A test that takes 60 s while several runs share the machine may take 15 s alone.
  Before changing a level because of a ❓, time the test alone.
