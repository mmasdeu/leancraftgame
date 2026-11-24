# Writing a level (v2)

A level is a directory `LeanCraftGame/L<n>/` with three files, plus sample answers in
`variants/L<n>/`. The number `n` is the position in the game (`LEVELS` in `web/server.py`
is the sorted list of directories).

| File | Contents |
|---|---|
| `Player.lean` | The first comment is the lesson (Markdown). The code inside `namespace L<n>` … `end L<n>` is what the player sees and edits; the two lines are hidden in the editor. `import LeanCraftGame.Lib.*` lines are hidden too. |
| `Tests.lean` | `#no_sorry` gates, then `#level_start`, the tests (`#expect_true`, `#expect_false`, `#expect_model`, `#expect_not_model`, `#expect_open`, `#expect_caught`) and `#level_report`. Other lines (a referee's copy of a colleague's code, helper definitions) form the preamble. |
| `level.json` | `world`, `title`, `skill`, `exercise` (one of Define, Construct, Repair, Classify, Refute, Referee, Connect, Audit), and optionally `predict`, `public`, `hintsAfter`, `checks` (signature checks) and `hints`. |
| `variants/L<n>/*.lean` | `correct*`/`fix*` must clear the level; `bug*` must get at least one ❌ (or be rejected by a check). Write them without the `namespace` lines. |

`python3 check_levels.py --static` validates the metadata; `python3 check_levels.py 58 59`
runs the sample answers through the referee (use `--jobs 2` on a small machine).

## Rules of thumb

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
