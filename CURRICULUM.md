# Curriculum

The game assumes no knowledge of Lean. Each level adds one idea, shows a
worked example in its lesson text, and then asks the player to write similar
definitions. The early worlds teach syntax. The middle worlds teach the
idiosyncrasies of Lean and Mathlib that make a definition compile but mean
the wrong thing: truncated subtraction, casts, junk values such as `x / 0 = 0`,
the hidden `→` and `∧` in bounded quantifiers, and the library's own names and
classes. The last worlds are the real subject of the game: writing, reading
and auditing definitions.

Reading is not left to the end, though. **Every world ends with a "Spot the bug"
level**: a colleague's definitions compile but are wrong, and the player proves it
with a counterexample, which the referee checks against the right answer. These
levels revisit the world's traps from the other side: having learned not to write
`∃ n, n > 0 → f n = 0`, the player must now recognise it in someone else's code and
produce the function that exposes it. The Predicate world goes one step further: in
"Be the referee" the player writes the test suite, and hidden *mutants* (wrong
definitions) must each fail one of the player's tests.

## How a level is played

Three mechanics keep the player reasoning about meaning, instead of turning a list of
tests green by trial and error. They are set per level in `level.json`.

* **Predict first** (`predict`). Before the first run, the player says whether a few
  statements, such as `LateBig (fun n => if n < 5 then 0 else 9)`, should be true or
  false. The answers lock in and are marked at once; those tests then stay visible.
  A probe is chosen where the trap of the level lies, so a wrong prediction points at
  a misunderstanding *before* any code is written, and a right prediction with a ❌
  says "you know the answer; your definition does not say it yet".
* **Hidden tests** (`public`). Only the predicted tests, and those listed in `public`,
  are shown from the start; every other test is hidden until it fails or comes back
  ❓, and all are shown once the level is cleared. A hidden failure still shows the
  input that broke the definition, so the evidence is never withheld, but the player
  cannot read the whole battery in advance and code against it. The Basics world and
  the "Spot the bug" levels set `"public": "all"`: their tests are the task itself.
  In those levels every test is a claim about the player's counterexample that must be
  true ("your two numbers do not multiply to 1"), so that no test reads as "should fail".
* **Gated, stepped hints** (`hintsAfter`, `steps`). A hint unlocks after
  `hintsAfter` failed runs (2 by default, 1 in the Basics world). A hint may have
  `steps` before it, usually a question; each further failed run unlocks the next
  step, and the hint itself, which often gives the answer, comes last. Only a ❌ (or ⚠️)
  makes a run a failed run and shows a hint: a ❓ is not a verdict against the
  player's definition, and a hint written for a failure would claim something the
  referee did not prove.

A cleared level earns up to three stars: one for clearing it, one for not opening a
hint, and one for predicting every statement right (or, in a level without
predictions, for clearing it without a failed run). `python3 check_levels.py --static`
checks that every `predict` and `public` entry names a test of the level.

Before level 1 comes a **Welcome page** (`LeanCraftGame/Intro.md`, the first tab in the
browser), which a first-time visitor sees on arrival. It is written for someone who has
never seen Lean: what Lean is, the difference between a definition and a theorem, why a
definition can be accepted and still be wrong (the referee exists to catch that), how a
level works (editor, **Run tests**, ✅ ❌ ❓, hints, `sorry`), five things to know about
reading Lean, how to type the symbols, and a map of the worlds ahead. Returning players
resume where they left off.

The number is the position in the browser (set by `LEVELS` in
`web/server.py`). The directory is `LeanCraftGame/L<n>`, numbered in the order the
levels were written.

| # | Dir | World | Level | Skill |
|---|---|---|---|---|
| 1 | L4 | Basics | Naming things | syntax |
| 2 | L5 | Basics | Functions | syntax |
| 3 | L6 | Basics | Making choices | syntax |
| 4 | L15 | Basics | Recursion | syntax |
| 5 | L23 | Basics | Spot the bug | reading |
| 6 | L7 | Statements | True or false? | syntax |
| 7 | L8 | Statements | And | syntax |
| 8 | L9 | Statements | Or and not | syntax |
| 9 | L24 | Statements | Spot the bug: connectives | reading |
| 10 | L16 | Numbers | Integers and casts | syntax |
| 11 | L17 | Numbers | Division by zero | writing |
| 12 | L25 | Numbers | Spot the bug: numbers | reading |
| 13 | L10 | Quantifiers | For all | syntax |
| 14 | L11 | Quantifiers | If … then … | syntax |
| 15 | L12 | Quantifiers | There exists | syntax |
| 16 | L13 | Quantifiers | Quantifiers in order | syntax |
| 17 | L18 | Quantifiers | Bounded quantifiers | syntax |
| 18 | L26 | Quantifiers | Spot the bug: quantifiers | reading |
| 19 | L1 | Predicate | Going to infinity | writing |
| 20 | L27 | Predicate | Be the referee | testing |
| 21 | L19 | Library | Sets | syntax |
| 22 | L20 | Library | Using Mathlib | writing |
| 23 | L21 | Library | Generality | writing |
| 24 | L28 | Library | Spot the bug: the library | reading |
| 25 | L22 | Analysis | Limits | writing |
| 26 | L29 | Analysis | Spot the bug: limits | reading |
| 27 | L14 | Structure | Your first structure | writing |
| 28 | L2 | Structure | A colleague's groups | reading |
| 29 | L3 | Faithfulness | The AI proved Goldbach! | auditing |

Symbols are introduced when they are first needed, each with its plain-ASCII
spelling where Lean has one. The **∀ Symbols** drawer in the browser lists all
of them with the keys to type them, and has a typing drill.

---

## Basics World: values and functions

### 1. Naming things (L4)

* **Teaches:** `def name : Type := value`; the types `Nat`, `String` and
  `Bool`; `sorry` as a placeholder; `--` comments; how to run the tests and read ✅/❌.
  (The `namespace … end` lines that wrap every level's code are added by the game and
  never shown, so they are not taught.)
* **Task:** give three constants their values: `answer : Nat` (42),
  `language : String` ("Lean"), `flag : Bool` (true).
* **Tests catch:** a wrong value, wrong capitalisation of the text.

### 2. Functions (L5)

* **Teaches:** parameters `(n : Nat)`; the output type; applying a function with
  `f x` (no brackets or commas; brackets only group); `+ - * / %`; division
  drops the remainder; natural-number subtraction stops at 0.
* **Task:** `double`, `squared`, `addTen`, `minusOne` (one less, but 0 stays 0).
* **Tests catch:** `n + n` for the square, and `minusOne 0`, the truncated
  subtraction case.

### 3. Making choices (L6)

* **Teaches:** several parameters `(a b : Nat)`; `if … then … else …` (both
  branches, same type); the comparisons `= ≠ < ≤ > ≥`; that `=` is a
  statement and not an assignment. First use of `≤` and `\le`.
* **Worked example:** `biggest`.
* **Task:** `smallest`, `gap` (distance between two numbers, either order),
  `zeroOrOne`.
* **Tests catch:** `a - b` for the gap, which is 0 when `a < b`.

### 4. Recursion (L15)

* **Teaches:** definitions by cases, `| 0 => … | n + 1 => …`; the function
  type `Nat → Nat` before the cases; `_` as a wildcard; recursive calls on a
  smaller input; why the pattern is `n + 1` and never `n - 1`; termination;
  `match n with` as an alternative.
* **Worked example:** `factorial`.
* **Task:** fill in the cases of `sumTo`, `pow2` and `fib`.
* **Tests catch:** wrong base cases (`sumTo 0 = 1`, `pow2 0 = 0`) and wrong
  steps (`sumTo n + n`, `fib (n + 1) + fib (n + 1)`).


### 5. Spot the bug (L23) · reading

* **Teaches:** reading code instead of writing it; a counterexample as evidence;
  hunting systematically (every branch of an `if`, every "except" in the
  specification).
* **Task:** the colleague's `middle` (a median that is wrong when the largest
  number comes first or second) and `isLeap` (which forgot the 400-year rule). Give
  three numbers and a year on which they are wrong.
* **Tests catch:** an input in sorted order (`1 2 3`), on which `middle` happens to
  be right, and the year 1900, on which `isLeap` happens to be right.

---

## Statements World: `Prop` and the connectives

### 6. True or false? (L7)

* **Teaches:** `Prop`, a statement that is true or false; a *predicate* is a
  function returning `Prop`; no `if`, `true` or `false` in the body; naming
  predicates with a capital; the off-by-one trap `<` versus `≤`.
* **Worked example:** `IsBig`.
* **Task:** `IsEven`, `IsSmall` (below 10), `GoesInto a b`.
* **Tests catch:** `n % 2 = 1`, `n ≤ 10` (boundary value 10), swapped `a` and `b`.

### 7. And (L8)

* **Teaches:** `∧` (`\and`, or `/\`); there is no `lo ≤ n ≤ hi`, write two
  comparisons; a definition may use earlier ones.
* **Worked example:** `InRange lo hi n`.
* **Task:** `IsTeen` (13 to 19), `EvenInRange` (reusing `InRange`).
* **Tests catch:** `∨` instead of `∧`, strict bounds, a missing condition.

### 8. Or and not (L9)

* **Teaches:** `∨` (`\or`, or `\/`); `¬` (`\not`, or `Not p`); binding strength
  `¬`, then `∧`, then `∨`, then `→`; parentheses.
* **Task:** `FreeTicket` (under 5 or at least 65), `PaysFull` (the opposite,
  using `FreeTicket`), `NotTiny` (neither 0 nor 1).
* **Tests catch:** `∧` for `∨`, boundary values 5 and 65, and
  `n ≠ 0 ∨ n ≠ 1`, which is always true.


### 9. Spot the bug: connectives (L24) · reading

* **Teaches:** that a predicate can be wrong in two directions, too weak (accepts
  too much) or too strong (rejects too much); binding strengths again.
* **Task:** the colleague's `IsTeen` (`∨` for `∧`: accepts everything),
  `IsWeekend` (`∧` for `∨`: rejects everything) and `BothOdd`
  (`¬ a % 2 = 0 ∧ b % 2 = 0`, where `¬` only covers the left side). Give an input
  on the wrong side of each.
* **Tests catch:** a genuine teenager, a weekday, two odd numbers.

---

## Numbers World: types of numbers and their traps

### 10. Integers and casts (L16)

* **Teaches:** `ℤ` and `ℕ` (`\Z`, `\N`); type ascription `(3 : ℤ)`; casts
  `(n : ℤ)`, displayed `↑n`; *where* the cast goes matters,
  `((a - b : ℕ) : ℤ)` subtracts in ℕ first; `(a - b : ℤ)` casts the leaves;
  dot notation `x.natAbs` for `Int.natAbs x`; the junk value
  `(-3 : ℤ).toNat = 0`.
* **Task:** `diff (a b : ℕ) : ℤ`, `distance (a b : ℤ) : ℕ`, `IsNegative`.
* **Tests catch:** the late cast (`diff 3 5 = 0`), `.toNat` instead of
  `.natAbs` (`distance (-4) 3 = 0`), `x ≤ 0` for negative.

### 11. Division by zero (L17)

* **Teaches:** `ℚ` (`\Q`); in Lean every function is total, so `x / 0` has a
  value, and Mathlib chose `0`; the other junk values (`3 - 5`, `7 / 0`,
  `Real.sqrt (-1)`, `0⁻¹`); stating definitions by multiplying instead of
  dividing, or with the hypothesis that rules out zero; `a + b / 2` is
  `a + (b / 2)`.
* **Worked example:** `IsHalf x y := 2 * y = x`.
* **Task:** `average`, `IsReciprocal x y`, `HasSlope x₁ y₁ x₂ y₂ m`.
* **Tests catch:** `y = 1 / x` (makes 0 its own reciprocal), the slope as a
  quotient (gives a vertical line slope 0), the multiplied form without
  `x₁ ≠ x₂` (accepts any slope through a single point), and the missing
  parentheses in `a + b / 2`.


### 12. Spot the bug: numbers (L25) · reading

* **Teaches:** that junk-value bugs agree with the intended meaning on most inputs,
  so random checks miss them; asking "where is the junk value?".
* **Task:** the colleague's `diff` (late cast), `IsReciprocal` (`y = 1 / x`) and
  `average` (`a + b / 2`). Give inputs on which each is wrong.
* **Tests catch:** `a ≥ b` for `diff`, a genuine reciprocal pair, and `a = 0` for
  `average`, where `a + b / 2` happens to equal `(a + b) / 2`.

---

## Quantifiers World: statements about sequences

### 13. For all (L10)

* **Teaches:** a sequence is a function `u : Nat → Nat`; the arrow `→` (`\to`,
  or `->`); `fun n => …`; `∀ n, P n` (`\forall`, or `forall`) and its comma.
* **Worked example:** `AllBig`.
* **Task:** `AlwaysBelow u B`, `AllEven u`.
* **Tests catch:** `∃` for `∀`, the bound the wrong way round, odd for even.

### 14. If … then … (L11)

* **Teaches:** `p → q` as "if p then q"; `→` binds weakest; `∀ n, p n → q n` for
  statements about only some positions; the classic mistake
  `∀ n, p n ∧ q n`.
* **Worked example:** `BigAfter`.
* **Task:** `LateBig` (from index 5 on, terms are at least 3), `EvenToEven`.
* **Tests catch:** `∧` for `→`. A sequence with small early terms must
  satisfy `LateBig`, and `∧` rejects it. This foreshadows the Goldbach level.

### 15. There exists (L12)

* **Teaches:** `∃ n, P n` (`\exists`, or `exists`); `∀` and `∃` are
  opposites; two properties of the *same* element go inside one `∃` joined by `∧`.
* **Worked example:** `HasBig`.
* **Task:** `HasZero`, `HasEvenBig` (one term both even and at least 10).
* **Tests catch:** `∀` for `∃`, and `(∃ n, even) ∧ (∃ n, big)`, which is
  caught by a sequence with an even term and a big term but none both.

### 16. Quantifiers in order (L13)

* **Teaches:** quantifiers are read left to right and the order matters;
  `∀ m, ∃ n, …` lets `n` depend on `m`, `∃ n, ∀ m, …` does not.
* **Task:** `HitsEverything f` (every number is a value of `f`), `Unbounded u`.
* **Tests catch:** the swapped order (rejects the identity sequence), and
  `∃ M, ∀ n, M ≤ u n` for `Unbounded` (it means "bounded below", so it accepts
  the constant sequence 7 and 0, 1, 0, 1, …).

### 17. Bounded quantifiers (L18)

* **Teaches:** Mathlib's shorthand `∀ n ≥ N, P n` and `∃ n > 0, P n`; that the
  bound becomes `→` under `∀` and `∧` under `∃`; why the hand-written
  `∃ n, n > 0 → P n` is true for every `P` (take `n = 0`); `∀ a b, …`.
* **Worked example:** `EventuallyBig u := ∃ N, ∀ n ≥ N, 10 ≤ u n`.
* **Task:** `HasPositiveRoot f`, `EventuallyZero u`.
* **Tests catch:** `∃ n, n > 0 → f n = 0` (accepts the identity, whose only
  root is 0), and `∀ N, ∃ n ≥ N, u n = 0` ("infinitely often", accepts
  0, 1, 0, 1, …).


### 18. Spot the bug: quantifiers (L26) · reading

* **Teaches:** translating a quantified statement literally before judging it;
  counterexamples that are functions (`fun n => …`).
* **Task:** the colleague's `HasPositiveRoot` (`∃ n, n > 0 → …`, true for every `f`),
  `EventuallyZero` ("infinitely often") and `Unbounded` (`∃ M, ∀ n, M ≤ u n`, which
  says "bounded below"). Give a function that each accepts wrongly.
* **Tests catch:** a function with a positive root, a sequence that is eventually 0,
  an unbounded sequence; and, for `EventuallyZero`, a sequence the colleague's
  definition rejects.

---

## Predicate World: the first real definition

### 19. Going to infinity (L1) · writing

* **Builds on:** `∀ ∃ ∀` from level 16, bounded quantifiers from level 17, and
  the `∧`/`→` lesson from level 14.
* **Task:** `TendsToInfinity (u : ℕ → ℕ) : Prop`.
* **Test sequences** are chosen so that each classic mistake fails a specific,
  readable test:
  * unbounded only (`∀ M, ∃ n, M ≤ u n`) fails on 0, 0, 2, 0, 4, …;
  * strictly increasing fails on `n / 2` and on 0, 4, 2, 6, …;
  * the quantifier swap fails on `u n = n`, and the downstream lemmas then
    pass only vacuously;
  * monotone and unbounded fails on 0, 4, 2, 6, 4, 8, ….
* **Also tests** three downstream lemmas a user of the definition needs.


### 20. Be the referee (L27) · testing

* **Teaches:** choosing tests. A good probe sits on the boundary of the notion: a
  sequence that tends to infinity *without* a property people confuse with it
  (monotone, strictly increasing, at least `n`), or one that does not, *despite* such
  a property (unbounded, eventually positive). This is how every test battery of
  the game was made.
* **Task:** two sequences that tend to infinity and two that do not. The labels must
  be honest (four public tests). Six hidden mutants, wrong definitions of
  `TendsToInfinity`, must each get one of the four sequences wrong
  (`#expect_caught`): quantifiers swapped, merely unbounded, strictly increasing,
  monotone and unbounded, at least the identity, eventually positive. A mutant that
  survives is revealed with its definition.
* **Tests catch:** an "obvious" suite (`n`, `2n`, `0`, `n % 2`) catches only the
  swapped quantifiers, and five mutants survive; a dishonest label fails its label test. Catching all six needs every slot:
  `n / 2`, `0, 4, 2, 6, …`, `0, 0, 2, 0, 4, …` and a constant.

---

## Library World: speaking Mathlib

### 21. Sets (L19)

* **Teaches:** `Set ℕ`; set-builder notation `{n | P n}`; `∈`, `∉`, `⊆`, `∅`
  (`\in`, `\notin`, `\sub`, `\empty`); bounded quantifiers over sets,
  `∀ x ∈ s` and `∃ x ∈ s`; in Mathlib a set *is* a predicate.
* **Worked example:** `evens`.
* **Task:** `multiplesOf k`, `BoundedSet s`.
* **Tests catch:** `{n | k % n = 0}` (the divisors, not the multiples), and
  `∀ n ∈ s, ∃ B, n ≤ B` (always true: accepts 5, 6, 7, …).

### 22. Using Mathlib (L20)

* **Teaches:** reusing library notions (`Even`, `Odd`, `Nat.Prime`, `∣`,
  `Function.Injective`, `Function.Surjective`, `Monotone`, `StrictMono`);
  divides `∣` (`\|`) is not the keyboard `|`, and reads "d divides a";
  namespaces and dot notation (`p.Prime`, `f.Injective`); near-misses such as
  `Prime` versus `Nat.Prime`; library definitions may be stated differently
  (`Even n` is `∃ r, n = r + r`).
* **Worked example:** `BigEven n := Even n ∧ 4 ≤ n`.
* **Task:** `TwinPrime p`, `CommonDivisor d a b`, `OneToOne f`.
* **Tests catch:** `a ∣ d` (divisibility the wrong way round), `∨` in
  `TwinPrime`, and `Function.Surjective` for injective.

### 23. Generality (L21)

* **Teaches:** implicit arguments `{α : Type*}`; instance arguments
  `[Preorder α]`; the error *failed to synthesize* when one is missing;
  choosing the weakest class; `[LinearOrder α]` is needed to *compute*
  `if a ≤ b` (decidability).
* **Worked example:** `AlwaysBelow {α : Type*} [Preorder α] …`.
* **Task:** generalise `Between`, `IsUpperBound` and `largest` from ℕ to
  every ordered type. The tests use them on ℕ, ℤ and ℚ, and the level's
  checks reject definitions that still only work on ℕ.
* **Tests catch:** strict inequalities in `Between`; a definition left on ℕ is
  rejected by the checks before the tests run.


### 24. Spot the bug: the library (L28) · reading

* **Teaches:** that library notions have fixed meanings and argument orders, and a
  definition using them can still say the wrong thing.
* **Task:** the colleague's `CommonDivisor` (`a ∣ d ∧ b ∣ d`, a common multiple),
  `TwinPrime` (`∨` for `∧`) and `multiplesOf` (`{n | k % n = 0}`, the divisors).
  Give an input that each accepts wrongly.
* **Tests catch:** a genuine common divisor, a genuine twin prime, a genuine multiple.

---

## Analysis World: real numbers

### 25. Limits (L22)

* **Teaches:** `ℝ` (`\R`); real sequences `ℕ → ℝ`; the absolute value `|x|`;
  casts `(n : ℝ)`; `ε` (`\e`) and `∀ ε > 0`; the ε–N definition of a limit.
* **Worked example:** `BoundedSeq u := ∃ M, ∀ n, |u n| ≤ M`.
* **Task:** `ConvergesTo u a`.
* **Tests catch:** a missing `ε > 0` (no sequence converges, not even a
  constant one), and `∃ n` instead of `∀ n ≥ N` (accepts 0, 1, 0, 1, … as
  converging to 0).
* **Not caught:** `∃ N, ∀ ε > 0, …` (one `N` for every `ε`). Telling it apart
  needs a sequence such as `1 / (n + 1)`, and proving that it converges needs
  the Archimedean property, which the referee cannot find.


### 26. Spot the bug: limits (L29) · reading

* **Teaches:** working out *which way* a definition is wrong (too strong or too
  weak) before looking for a counterexample.
* **Task:** Alice forgot `ε > 0` (too strong: no sequence converges), Bob wrote
  `∃ n` instead of `∀ n ≥ N` (too weak). Give a convergent sequence that Alice
  rejects and a divergent one that Bob accepts.
* **Tests catch:** a sequence that does not converge to the given limit, a
  convergent sequence for Bob, and one that never comes close.

---

## Structure World: bundling data and axioms

### 27. Your first structure (L14) · writing

* **Teaches:** `structure Name where` and its fields; building a value with
  `Name.mk`; a field whose type is a statement is an *axiom*; how the referee
  uses *models* (data that should, or should not, satisfy the axioms).
* **Task:** `Interval` (`lo`, `hi` and the axiom `lo ≤ hi`), `PosNat`
  (`val` and the axiom `0 < val`).
* **Tests catch:** a missing axiom (junk values accepted), `<` for `≤`, the
  inequality reversed, `0 ≤ val`.

### 28. A colleague's groups (L2) · reading, then fixing

* A colleague's `Group'` has associativity, a **left** identity and a
  **right** inverse. It compiles and every group is an instance, but it is
  not the theory of groups.
* **Part A, break it:** give a junk model on `Bool` that satisfies the
  colleague's axioms but is not a group (answer: `a * b = b`).
* **Part B, fix it:** write `Group₂`. It is checked against a zoo of models:
  ℤ, `Bool` under xor, ℤ/3 and the non-commutative S₃ must be models; `a * b = b`
  (three carriers), (ℕ, +) and (`Bool`, and) must each break some axiom.
  Adding `mul_comm` "to be safe" fails on S₃, and the report names it.

---

## Faithfulness World: auditing a formal statement

### 29. The AI proved Goldbach! (L3) · auditing

* An "AI" formalises Goldbach as
  `∀ n, 2 < n → n % 2 = 0 → ∃ p q, IsPrime p ∧ IsPrime q → p + q = n` and
  proves it in one line. (`→` binds weaker than `∧`, so `p = 0` is a witness.)
* **Task:** `GoldbachFor (P : ℕ → Prop)`, Goldbach relative to an arbitrary
  notion of "prime". You cannot test a statement nobody can prove, but you can
  test it in toy worlds where you know the answer:

  | World | Expected | Catches |
  |---|---|---|
  | everything is prime | true | hypotheses written as conjuncts |
  | primes = odd numbers | true | forgetting "even" |
  | primes = numbers ≥ 2 | true | `2 ≤ n` instead of `2 < n` |
  | nothing is prime | false | the AI's precedence bug |
  | only 2 is prime | false | the AI's precedence bug |
  | real primes | open | "proved an open problem: probably vacuous" |

---

## How the skills build

| Skill from … | is used in … |
|---|---|
| `def`, types, application (1–2) | everything |
| `if` and comparisons (3) | 5, 6 onwards; decidability in 23 |
| recursion (4) | (not used later yet) |
| reading code, counterexamples (5) | 9, 12, 18, 24, 26, 28 (part A), 29 |
| `Prop` and predicates (6) | 7 onwards |
| `∧ ∨ ¬`, precedence (7–8) | 9, 11, 14, 18, 22, 24, 29 |
| casts and junk values (10–11) | 12, 25 (`(n : ℝ)`), 29 |
| `∀`, function arguments (13) | 14–20, 25, 26, 29 |
| `→` versus `∧` (14) | 17 (bounded quantifiers), 18, 19, 29 (the Goldbach bug) |
| `∃` and quantifier order (15–16) | 18, 19, 20, 21, 25, 26, 29 |
| bounded quantifiers (17) | 18, 19, 21, 23, 25, 26 |
| choosing tests (20) | 29 (toy worlds are tests for a statement) |
| sets (21) | 23 (`IsUpperBound`), 24 |
| library names, dot notation (22) | 10 introduces dot notation; 24, 28 |
| classes `[Preorder α]` (23) | 28 (structures are the next step towards classes) |
| `structure` and axioms (27) | 28 |

## Not covered yet

These parts of Lean and Mathlib still have no level:

* **Structure syntax:** anonymous constructors `⟨a, b⟩`, structure instance
  notation `{ lo := 2, hi := 5, h := … }`, projections `p.lo`, `extends`.
* **Classes and instances:** `class`, `instance`, and Mathlib's algebraic
  hierarchy (`Group G` with `*`, `1`, `⁻¹` notation). Level 28 uses a plain
  structure instead.
* **Finite sums and `Finset`:** `∑ i ∈ Finset.range n, f i`, and the
  off-by-one in `Finset.range n = {0, …, n - 1}`.
* **Filters:** how Mathlib actually states limits, `Filter.Tendsto u atTop (𝓝 a)`,
  and why it is equivalent to level 25's definition.
* **`Bool` versus `Prop`:** `==` versus `=`, `decide`, and the automatic
  coercion between them.
* **`noncomputable`,** `Classical`, and definitions that cannot be evaluated.
* **Other data types:** `Fin n`, `List`, `Option`.
