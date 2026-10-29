# DefGame: a Lean game about definitions, not proofs

LLMs now write many Lean proofs well, so the scarce skill has moved upstream:
**saying what you mean**. A definition can compile and still be wrong, vacuous,
or unusable, and no proof checker will warn you. DefGame teaches that skill.

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

Each test comes back ✅ (as expected), ❌ (the referee *proved the opposite*,
so it has a concrete witness against your definition) or ❓ (unsettled).

## Quick start

Requires Lean `v4.35.0` and Mathlib (`lake exe cache get` downloads it
prebuilt). To play in the browser (needs Python 3.9+, nothing else to install;
see [INSTALL.md](INSTALL.md)):

```bash
lake exe cache get      # first time only
python3 web/server.py --open
```

Or, without a browser, run a level on a file of your own:

```bash
python3 web/server.py --run 4 DefGame/L4/Player.lean
```

## The levels

The game starts from zero: no Lean knowledge is assumed, and each level teaches
one construct, with a worked example in the lesson text. There are 22 levels
in nine worlds; [CURRICULUM.md](CURRICULUM.md) lists what each one teaches and
which mistakes its tests catch.

* **Basics, Statements, Quantifiers:** the syntax of definitions (`def`,
  functions, recursion, `Prop`, `∧ ∨ ¬ →`, `∀ ∃` and their order, bounded
  quantifiers).
* **Numbers, Library, Analysis:** the idiosyncrasies of Lean and Mathlib
  (casts, junk values like `x / 0 = 0`, sets, the library's own names,
  implicit and instance arguments, limits in ℝ).
* **Predicate, Structure, Faithfulness:** the three original levels, about
  writing, reading and auditing definitions (described below).

The order is set by `LEVELS` in `web/server.py`; the directories
`DefGame/L<n>` are numbered in the order the levels were written.

The browser has a **Symbols** drawer that lists every symbol with the keys to
type it (`\forall`, `\to`, `\le`, …) and its plain-ASCII spelling, with a
typing drill. Clicking a symbol inserts it into the editor.

The last levels, in more detail, exercise three different skills:
**writing**, **reading**, and **auditing**.

### Going to infinity (Predicate World, level 15, writing)

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

### A colleague's groups (Structure World, level 21, reading, then fixing)

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

### The AI proved Goldbach! (Faithfulness World, level 22, auditing)

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

## Verified behaviour

`variants/L<n>/` holds sample answers for every level: a correct one and the
typical mistakes. `python3 check_levels.py` runs them all through the referee
and checks that every correct answer clears its level and every buggy answer
gets at least one ❌ (or is rejected before the tests run). Each bug is caught
by the test designed for it.

## Architecture

```
DefGame/Referee.lean     the referee: witness search + core tactics, and the test commands
DefGame/L<n>/Player.lean       what the player edits; its first comment is the lesson text
DefGame/L<n>/Tests.lean        hidden test battery (the level designer's real work)
DefGame/L<n>/level.json        title, signature checks and hints for the web version
web/server.py            local web server: runs each test as its own Lean process, streams verdicts
web/static/              the browser game (plain HTML/CSS/JS, no build step)
variants/                sample answers for every level (correct and buggy)
check_levels.py          checks every level against its sample answers
```

**The referee** (`Referee.lean`) is deliberately simple: iterative
deepening that alternates between proving `P` and proving `¬P`. Its moves are:
instantiate a `∀`-hypothesis, pick a witness for an `∃`-goal, split `∧`, and
destructure hypotheses. The candidate values are local variables, `x+1`, `2x`,
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
