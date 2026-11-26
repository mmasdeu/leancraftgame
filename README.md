# Lean Craft Game: a Lean game about definitions, not proofs

> **This is the `v3` branch**, to be published at <https://mmasdeu.github.io/leancraftgame/v3/>.
> Version 3 follows *Mathematics in Lean* (MIL) chapter by chapter: 50 levels in thirteen
> worlds, one per chapter, plus a final audit. The player reads as much as writes, states
> theorems without proving them, and uses Mathlib's own names. See [CURRICULUM.md](CURRICULUM.md)
> and the design in [REDESIGN_PLAN.md](REDESIGN_PLAN.md).

[![Downloads](https://img.shields.io/github/downloads/mmasdeu/leancraftgame/total?label=downloads)](https://github.com/mmasdeu/leancraftgame/releases) [![Latest release](https://img.shields.io/github/downloads/mmasdeu/leancraftgame/latest/total?label=latest%20release)](https://github.com/mmasdeu/leancraftgame/releases/latest)

LLMs now write many Lean proofs well, so the scarce skill has moved upstream:
**saying what you mean**. A definition can compile and still be wrong, vacuous,
or unusable, and no proof checker will warn you. Lean Craft Game teaches that skill.

**The core mechanic.** The player never writes a proof. The player writes a
definition or the statement of a theorem, gives a witness or a counterexample, or reads
Lean code and answers questions about it. A hidden *test
battery* then asks an automated *referee* to prove or refute dozens of facts
about it:

| Test kind | Meaning | Catches |
|---|---|---|
| `#expect_true` | sanity theorems: should hold | definitions that are too strong |
| `#expect_false` | anti-theorems: their negation should be provable | definitions that are too weak or vacuous |
| `#expect_true` (downstream) | lemmas a *user* of the definition needs | definitions that are unusable |
| `#expect_model` | a structure must admit the intended models | axioms that are too strong |
| `#expect_not_model` | a structure must rule out junk models | axioms that are too weak |
| `#expect_open` | an open problem must not be trivially provable or refutable | vacuous or silly statements |
| `#expect_caught` | a wrong definition (a *mutant*) must disagree with one of the player's tests | test suites that miss a mistake |
| `#expect_equiv` | the player's `statement` must say the same as the intended one (same binders, hypotheses and conclusion, up to algebra) | missing hypotheses, wrong conclusions, statements that are true but not the one asked |
| `#expect_type` | a term must have a given type | wrong binders (explicit where implicit was asked), wrong shapes |
| `#expect_choice` | the answer to a reading question | misreadings |

Each test comes back ✅ (as expected), ❌ (the referee *proved the opposite*,
so it has a concrete witness against your definition) or ❓ (unsettled).

**Thinking before running.** So that a level is not cleared by turning a visible list
green by trial and error:

* **Predict first.** Before the first run, the player says whether a few statements
  should be true or false; the answers lock in and are marked.
* **Hidden tests.** Most tests stay hidden until they fail (the failure, with its
  counterexample, is always shown), and all are shown once the level is cleared.
* **Gated hints.** Hints unlock after failed runs (runs with a ❌; a ❓ does not
  count), one step at a time, from a question to the answer.
* **Stars.** A cleared level earns up to three: cleared, no hint opened, every
  prediction right.

**Reading as much as writing.** About two levels in five are reading levels: the player
answers questions about Lean code, reads Mathlib signatures, or proves a colleague's
definitions wrong with counterexamples (*Spot the bug*, the last level of most worlds).
In *Be the referee* the player writes the tests, and hidden wrong definitions must each
fail one of them.

## Quick start

**To play:** download the app for Windows, macOS or Linux from the
[Lean Craft Game website](https://mmasdeu.github.io/leancraftgame/) or the
[Releases page](https://github.com/mmasdeu/leancraftgame/releases). It installs Lean and
the parts of Mathlib it needs on its first launch, then works offline. See
[INSTALL.md](INSTALL.md).

**From a checkout** (to change levels or the referee): this needs Lean `v4.35.0`
and Mathlib (`lake exe cache get` downloads it prebuilt), and Python 3.9+:

```bash
lake exe cache get      # first time only
python3 web/server.py --open
```

Or, without a browser, run a level on a file of your own:

```bash
python3 web/server.py --run 1 LeanCraftGame/L1/Player.lean
```

## The levels

The game starts from zero: no Lean knowledge is assumed. A Welcome page (`LeanCraftGame/Intro.md`)
introduces Lean and the game to first-time visitors, and then each level teaches one
piece of syntax or one reading or writing skill, with a worked example from MIL in the
lesson text, and names the MIL section it follows. There are 50 levels in thirteen
worlds, one per MIL chapter, and a final audit; [CURRICULUM.md](CURRICULUM.md) lists them
with their exercise types (Write, Read, Construct, Refute, Repair, Audit), and
[AUTHORING.md](AUTHORING.md) explains how a level is written.

1. **Getting Started** (MIL 1) and **Basics** (MIL 2): reading a Lean file, `def`, how
   Lean parses, reading Mathlib signatures, stating theorems with `statement`, generic
   statements with type classes.
2. **Logic** (MIL 3): `∀ ∃ ¬ ∧ ∨ ↔`, pushing negations, the order of quantifiers,
   convergence of sequences, mutation testing ("Be the referee").
3. **Sets and Functions**, **Elementary Number Theory**, **Discrete Mathematics**
   (MIL 4–6): `Set`, images, injectivity, Schröder–Bernstein; primes, irrationality,
   recursion; `Finset`, big operators, inductive types.
4. **Structures**, **Hierarchies**, **Groups and Rings** (MIL 7–9): structures, the
   Gaussian integers, classes and instances, morphisms, sub-objects, `ZMod`, ideals,
   polynomials.
5. **Linear Algebra**, **Topology**, **Differential Calculus**, **Integration and
   Measure Theory** (MIL 10–13): linear maps, matrices, filters, metric and topological
   spaces (with finite spaces checked exhaustively), `deriv`, `∫`. Where the referee
   cannot compute, the checks are on types and on the shape of statements.

### Reading levels

A *Read* level shows Lean code in the lesson and asks questions about it. The answers
are lines of the player's code (`def q1 : Fin 4 := 2`), and the browser shows the
questions under the lesson as buttons that write those lines. Questions aim at the
traps: `#eval (7 + 2) / 2` is `4`, `-x ^ 2` is `-(x ^ 2)`, a hypothesis that an
application of `pow_le_pow_left₀` must supply.

### Stating theorems (Basics, level 5, writing)

`statement two_mul_le (a b : ℝ) : 2 * a * b ≤ a ^ 2 + b ^ 2` names a proposition without
proving it. The referee compares it with the intended statement by *shape*, because any
two true statements are logically equivalent:

| Player writes | Referee says |
|---|---|
| `(a b : ℝ) : 2 * a * b ≤ a ^ 2 + b ^ 2`, or `a ^ 2 + b ^ 2 ≥ 2 * (a * b)` | ✅ |
| `(a b : ℝ) : a ^ 2 + b ^ 2 ≤ 2 * a * b` | ❌ "your statement is FALSE, the intended one TRUE" (with a counterexample) |
| `(a + b) ^ 2 = (a + b) ^ 2` for the binomial formula | ❓ "true, but not the statement asked for" |

### Be the referee (Logic, level 13, testing)

The player is given the right definition of convergence to 0 and writes four test
sequences (two that converge, two that do not). Hidden *mutants* (`ε ≥ 0`, "close again
and again", "eventually small", no absolute value, "decreasing") must each be caught by
one of them.

### The AI proved Goldbach! (Final Audit, level 51, auditing)

An "AI" formalises Goldbach as
`∀ n, 2 < n → n % 2 = 0 → ∃ p q, IsPrime p ∧ IsPrime q → p + q = n`
and proves it in one line, with no `sorry`. (The `→` binds weaker than `∧`, so
`p = 0` is a witness.) The player writes the statement relative to an arbitrary notion
of "prime" and tests it in toy worlds where the answer is known: **you can't test a
statement nobody can prove, but you can test it in toy worlds.**

## Usage counts

Both versions count, anonymously, how often each level is run and cleared (GoatCounter; only the level
number is sent, never code, no cookies). The Welcome page says so and has a checkbox to switch it off.
Events are kept per mode (`/online/…`, `/windows/…`, `/mac/…`, `/linux/…`) and aggregated (`/all/level/<n>/…`,
`/all/run`, `/all/cleared`); the landing page shows the last two (enable *public counters* in GoatCounter's
settings for this). The site code is in `web/static/config.js` (local) and `online/build.py` (online); remove it to disable
counting altogether.

## Online version

A static copy of the game that needs no Lean on the server. The browser sends the player's
code to the Lean Playground (<https://live.lean-lang.org/>, project `MathlibDemo`) over a
websocket and reads the referee's verdicts from the diagnostics.

```bash
python3 online/build.py          # writes dist/online/: upload it to any static web host
```

* `online/build.py` exports the levels to `data/levels.json` and turns `Referee.lean` into
  `data/prelude.lean`, one self-contained block (its `initialize` references become global
  values, since a file cannot use its own `initialize`). `web/static/live.js` pastes it, the
  player's code and all the tests into **one** file per run, which is how it differs from the
  local server (one Lean process per test).
* A run takes about a minute for most levels, and a few minutes for the hardest. A test that
  runs more than 60 s is dropped (✅ for a test that should stay open, ❓ otherwise), and a
  cut-off session continues with the remaining tests.
* The Welcome page tells the player that the code goes to a public server.
* It depends on the Playground: its Lean and Mathlib versions (this project pins
  `lean-toolchain`; the Playground follows the latest Mathlib), its availability and its limits.
  Ask the Lean community before sending real traffic its way.

## Verified behaviour

`variants/L<n>/` holds sample answers for every level: a correct one and the
typical mistakes. `python3 check_levels.py` runs them all through the referee
and checks that every correct answer clears its level and every buggy answer
gets at least one ❌ (or is rejected before the tests run). Each bug is caught
by the test designed for it. An `other*` answer, a statement other than the one asked
that no proof can refute (a true one, such as `(a + b) ^ 2 = (a + b) ^ 2` for the binomial
formula), must not clear its level and must get no ❌. `python3 check_levels.py --static`
only checks the levels' metadata (predictions, public tests, hints, questions) against
their tests, without Lean.

`python3 tests/browser_questions.py` plays every reading level in a headless browser
(Playwright): it answers the questions by clicking, checks that the code follows the
buttons and the buttons the code, and that the level is cleared. `python3
make_curriculum.py` regenerates [CURRICULUM.md](CURRICULUM.md) from the levels.

## Architecture

```
LeanCraftGame/Referee.lean     the referee: witness search + core tactics, and the test commands
LeanCraftGame/Lib/*.lean       shared library (finite topological spaces), imported by the tests; online it is
                               pasted into the prelude, before the player's code
LeanCraftGame/L<n>/Player.lean       what the player edits; its first comment is the lesson text; the `namespace`/`end` lines
                                     around the code are never shown, and are added back when the tests run
LeanCraftGame/L<n>/Tests.lean        hidden test battery (the level designer's real work)
LeanCraftGame/L<n>/level.json        title, signature checks, predictions, public tests and hints for the web version
web/server.py            local web server: runs each test as its own Lean process, streams verdicts
web/static/              the browser game (plain HTML/CSS/JS, no build step)
web/static/vendor/       MathJax 3.2.2 (tex-chtml.js and its fonts), bundled for offline use
variants/                sample answers for every level (correct and buggy)
check_levels.py          checks every level against its sample answers
app/launcher.py          the desktop app: installs Lean and the Mathlib pack on first launch, then serves the game
app/make_pack.py         builds the Mathlib pack (the modules the game loads) and deps.json
app/build_app.py         freezes the app with PyInstaller for the current OS
.github/workflows/release.yml   builds, smoke-tests and publishes the apps for Windows, macOS and Linux
.github/workflows/pages.yml     on this branch: publishes the online game to the v3/ folder of gh-pages
```

**The referee** (`Referee.lean`) is deliberately simple: iterative
deepening that alternates between proving `P` and proving `¬P`. Its moves are:
instantiate a `∀`-hypothesis, pick a witness for an `∃`-goal, split `∧`, and
destructure hypotheses; when the goal is `False`, a hypothesis `¬ Q` can be used by
proving `Q` instead. The candidate values are local variables, `x+1`, `2x`,
`2x+1`, `x-1`, `x-2` and small numerals (also `1/2` in ℚ and ℝ). After
instantiating a `∀`-hypothesis, side conditions such as `0 < ε`, `N ≤ n` or
`x ∈ s` are discharged on the spot. Set membership and `⊆` are unfolded. Leaves
are closed with `decide`, `omega`, `positivity`, `linarith`, `simp_all` and
`grind`, plus `norm_num` and an `abs`-aware `linarith` when the goal involves
ℚ or ℝ. If the search finds
nothing, a last shallow pass pushes negations inwards (`push_neg`, so that
`¬ ∀ x, P x` becomes `∃ x, ¬ P x`) and also tries Mathlib's heavier tactics
`norm_num`, `tauto`, `nlinarith` and `aesop`. A goal on which every closer has
failed is remembered, so iterative deepening does not retry it. ❌ is always
backed by a real Lean proof of the opposite statement, so the game never tells a
player they're wrong without evidence. `#referee_stats` prints how often each
closing tactic was called, how often it succeeded and how long it took.

## Known limitations and next steps

* **The referee is weak on purpose.** `grind` cannot derive `a * 1 = a` from
  left identity, left inverse and right inverse, which is why Level 52 checks
  structures against models instead of deriving theorems from them. The
  Mathlib tactics are now available, but I have not tested whether they
  suffice for downstream tests like "every `Group₂` has a right identity".
  Mathlib also makes Mathlib-based levels possible (limits in ℝ, filters,
  topological spaces); a level imports what it needs in its `Player.lean`.
* **Speed.** Every test is its own Lean process, which loads Mathlib's
  tactics (about 3 s), and the Mathlib simp set makes each search step slower.
  On 8 cores, a correct answer to "Going to infinity" takes about 30 s, and the
  slowest test that a correct answer must pass (in "Using Mathlib") takes about
  38 s. Tests that end up ❓ run until the time limit, 60 s by default
  (`--timeout`). An open-problem test that runs out of time counts as ✅, since
  nothing settled it; this is what clears the Goldbach level. Verdicts are
  cached per (definition, test) pair. A persistent Lean process that loads
  Mathlib once (such as the Lean REPL) would remove the startup cost.
* **Scoring dimensions not yet implemented:**
  * *minimality*: is an axiom derivable from the others? This needs a stronger
    prover.
  * *ergonomics*: the heartbeat cost of the downstream lemmas.
  * *generality*.
* **Platform.** The natural home is lean4game (the engine behind the Natural
  Number Game), extended with a "definition level" type whose goal is a hidden
  test file rather than a proof state. The `#expect_*` commands are written so
  that they could become the level format directly.
* **Two-player mode:** player A writes a definition, player B writes
  `#expect_*` tests, and B scores for every ❌ they can produce.
