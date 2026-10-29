# Lean Craft Game: a Lean game about definitions, not proofs

LLMs now write many Lean proofs well, so the scarce skill has moved upstream:
**saying what you mean**. A definition can compile and still be wrong, vacuous,
or unusable, and no proof checker will warn you. Lean Craft Game teaches that skill.

**The core mechanic.** The player never writes a proof. The player writes a
definition (a predicate, a structure, a formal statement). A hidden *test
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

Each test comes back ✅ (as expected), ❌ (the referee *proved the opposite*,
so it has a concrete witness against your definition) or ❓ (unsettled).

**Thinking before running.** So that a level is not cleared by turning a visible list
green by trial and error:

* **Predict first.** Before the first run, the player says whether a few statements
  should be true or false; the answers lock in and are marked.
* **Hidden tests.** Most tests stay hidden until they fail (the failure, with its
  counterexample, is always shown), and all are shown once the level is cleared.
* **Gated hints.** Hints unlock after failed runs, one step at a time, from a
  question to the answer.
* **Stars.** A cleared level earns up to three: cleared, no hint opened, every
  prediction right.

**Reading in every world.** Every world ends with a *Spot the bug* level, in which
the player proves a colleague's definitions wrong with counterexamples, and the
Predicate world has *Be the referee*, in which the player writes the tests and hidden
mutants must each fail one of them.

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
python3 web/server.py --run 4 LeanCraftGame/L4/Player.lean
```

## The levels

The game starts from zero: no Lean knowledge is assumed. A Welcome page (`LeanCraftGame/Intro.md`)
introduces Lean and the game to first-time visitors, and then each level teaches one
construct, with a worked example in the lesson text. There are 29 levels
in nine worlds; [CURRICULUM.md](CURRICULUM.md) lists what each one teaches and
which mistakes its tests catch, and how predictions, hidden tests and hints are
set in `level.json`.

* **Basics, Statements, Quantifiers:** the syntax of definitions (`def`,
  functions, recursion, `Prop`, `∧ ∨ ¬ →`, `∀ ∃` and their order, bounded
  quantifiers).
* **Numbers, Library, Analysis:** the idiosyncrasies of Lean and Mathlib
  (casts, junk values like `x / 0 = 0`, sets, the library's own names,
  implicit and instance arguments, limits in ℝ).
* **Predicate, Structure, Faithfulness:** the three original levels, about
  writing, reading and auditing definitions (described below).
* **Spot the bug** (the last level of every world) and **Be the referee**: reading a
  colleague's definitions and proving them wrong with counterexamples, and writing a
  test suite that catches hidden wrong definitions.

The order is set by `LEVELS` in `web/server.py`; the directories
`LeanCraftGame/L<n>` are numbered in the order the levels were written.

The browser has a **Symbols** drawer that lists every symbol with the keys to
type it (`\forall`, `\to`, `\le`, …) and its plain-ASCII spelling, with a
typing drill. Clicking a symbol inserts it into the editor.

The last levels, in more detail, exercise three different skills:
**writing**, **reading**, and **auditing**.

### Going to infinity (Predicate World, level 19, writing)

*Define `TendsToInfinity (u : ℕ → ℕ) : Prop`.*

The test sequences are chosen so that each classic wrong definition fails a
specific, readable test:

| Player writes | Referee says |
|---|---|
| `∀ M, ∃ N, ∀ n ≥ N, M ≤ u n` | 🏆 9/9 |
| `∀ M, ∃ n, M ≤ u n` (unbounded) | ❌ "0, 0, 2, 0, 4, 0, … does not tend to infinity" |
| `∀ n, u n < u (n+1)` (strictly increasing) | ❌ "n / 2 tends to infinity" and ❌ "0, 4, 2, 6, … tends to infinity" |
| `∃ N, ∀ M, ∀ n ≥ N, M ≤ u n` (quantifier swap) | ❌ "u n = n tends to infinity". The downstream lemmas still pass, but only *vacuously*: nothing satisfies the definition. |
| monotone ∧ unbounded | ❌ "0, 4, 2, 6, 4, 8, … tends to infinity (it is not monotone!)" |

### A colleague's groups (Structure World, level 28, reading, then fixing)

A colleague's `Group'` has associativity, a **left** identity and a **right**
inverse. It compiles, and every group is an instance, but it is not the theory
of groups.

* **Part A, break it:** give the data of a junk model on `Bool`. The referee
  checks that it satisfies `Group'` and that it is not a group. (Answer:
  `a * b = b`.)
* **Part B, fix it:** write `Group₂`. It is checked against a zoo of models.
  ℤ, `Bool` under xor, ℤ/3 and the non-commutative S₃ must all be models.
  `a * b = b` (on three carriers), (ℕ, +) and (`Bool`, and) must each break
  some axiom. Adding `mul_comm` "to be safe" fails on S₃, and the report names
  `mul_comm` as the axiom that fails.

### The AI proved Goldbach! (Faithfulness World, level 29, auditing)

An "AI" formalises Goldbach as
`∀ n, 2 < n → n % 2 = 0 → ∃ p q, IsPrime p ∧ IsPrime q → p + q = n`
and proves it in one line, with no `sorry`. (The `→` binds weaker than `∧`, so
`p = 0` is a witness.)

The player writes `GoldbachFor (P : ℕ → Prop)`: Goldbach relative to an
arbitrary notion of "prime". This is the main idea of the level: **you can't
test a statement nobody can prove, but you can test it in toy worlds where you
know the answer.**

| World | Expected | Catches |
|---|---|---|
| everything is prime | true | hypotheses written as conjuncts |
| primes = odd numbers | true | forgetting "even" |
| primes = numbers ≥ 2 | true | `2 ≤ n` instead of `2 < n` |
| nothing is prime | false | the AI's precedence bug |
| only 2 is prime | false | the AI's precedence bug |
| real primes | **open** | "proved an open problem: probably vacuous" |

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
by the test designed for it. `python3 check_levels.py --static` only checks the
levels' metadata (predictions, public tests, hints) against their tests, without Lean.

## Architecture

```
LeanCraftGame/Referee.lean     the referee: witness search + core tactics, and the test commands
LeanCraftGame/L<n>/Player.lean       what the player edits; its first comment is the lesson text
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
site/                    the landing page with the download links (published to gh-pages by .github/workflows/pages.yml)
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
  left identity, left inverse and right inverse, which is why Level 2 checks
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
