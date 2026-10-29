# Curriculum

The game assumes no knowledge of Lean. Each level adds one idea, shows a
worked example in its lesson text, and then asks the player to write similar
definitions. The early worlds teach syntax. The middle worlds teach the
idiosyncrasies of Lean and Mathlib that make a definition compile but mean
the wrong thing: truncated subtraction, casts, junk values such as `x / 0 = 0`,
the hidden `→` and `∧` in bounded quantifiers, and the library's own names and
classes. The last worlds are the real subject of the game: writing, reading
and auditing definitions.

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
| 5 | L7 | Statements | True or false? | syntax |
| 6 | L8 | Statements | And | syntax |
| 7 | L9 | Statements | Or and not | syntax |
| 8 | L16 | Numbers | Integers and casts | syntax |
| 9 | L17 | Numbers | Division by zero | writing |
| 10 | L10 | Quantifiers | For all | syntax |
| 11 | L11 | Quantifiers | If … then … | syntax |
| 12 | L12 | Quantifiers | There exists | syntax |
| 13 | L13 | Quantifiers | Quantifiers in order | syntax |
| 14 | L18 | Quantifiers | Bounded quantifiers | syntax |
| 15 | L1 | Predicate | Going to infinity | writing |
| 16 | L19 | Library | Sets | syntax |
| 17 | L20 | Library | Using Mathlib | writing |
| 18 | L21 | Library | Generality | writing |
| 19 | L22 | Analysis | Limits | writing |
| 20 | L14 | Structure | Your first structure | writing |
| 21 | L2 | Structure | A colleague's groups | reading, then fixing |
| 22 | L3 | Faithfulness | The AI proved Goldbach! | auditing |

Symbols are introduced when they are first needed, each with its plain-ASCII
spelling where Lean has one. The **∀ Symbols** drawer in the browser lists all
of them with the keys to type them, and has a typing drill.

---

## Basics World: values and functions

### 1. Naming things (L4)

* **Teaches:** `def name : Type := value`; the types `Nat`, `String` and
  `Bool`; `sorry` as a placeholder; `--` comments; the `namespace … end` wrapper
  (leave it alone); how to run the tests and read ✅/❌.
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

---

## Statements World: `Prop` and the connectives

### 5. True or false? (L7)

* **Teaches:** `Prop`, a statement that is true or false; a *predicate* is a
  function returning `Prop`; no `if`, `true` or `false` in the body; naming
  predicates with a capital; the off-by-one trap `<` versus `≤`.
* **Worked example:** `IsBig`.
* **Task:** `IsEven`, `IsSmall` (below 10), `GoesInto a b`.
* **Tests catch:** `n % 2 = 1`, `n ≤ 10` (boundary value 10), swapped `a` and `b`.

### 6. And (L8)

* **Teaches:** `∧` (`\and`, or `/\`); there is no `lo ≤ n ≤ hi`, write two
  comparisons; a definition may use earlier ones.
* **Worked example:** `InRange lo hi n`.
* **Task:** `IsTeen` (13 to 19), `EvenInRange` (reusing `InRange`).
* **Tests catch:** `∨` instead of `∧`, strict bounds, a missing condition.

### 7. Or and not (L9)

* **Teaches:** `∨` (`\or`, or `\/`); `¬` (`\not`, or `Not p`); binding strength
  `¬`, then `∧`, then `∨`, then `→`; parentheses.
* **Task:** `FreeTicket` (under 5 or at least 65), `PaysFull` (the opposite,
  using `FreeTicket`), `NotTiny` (neither 0 nor 1).
* **Tests catch:** `∧` for `∨`, boundary values 5 and 65, and
  `n ≠ 0 ∨ n ≠ 1`, which is always true.

---

## Numbers World: types of numbers and their traps

### 8. Integers and casts (L16)

* **Teaches:** `ℤ` and `ℕ` (`\Z`, `\N`); type ascription `(3 : ℤ)`; casts
  `(n : ℤ)`, displayed `↑n`; *where* the cast goes matters,
  `((a - b : ℕ) : ℤ)` subtracts in ℕ first; `(a - b : ℤ)` casts the leaves;
  dot notation `x.natAbs` for `Int.natAbs x`; the junk value
  `(-3 : ℤ).toNat = 0`.
* **Task:** `diff (a b : ℕ) : ℤ`, `distance (a b : ℤ) : ℕ`, `IsNegative`.
* **Tests catch:** the late cast (`diff 3 5 = 0`), `.toNat` instead of
  `.natAbs` (`distance (-4) 3 = 0`), `x ≤ 0` for negative.

### 9. Division by zero (L17)

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

---

## Quantifiers World: statements about sequences

### 10. For all (L10)

* **Teaches:** a sequence is a function `u : Nat → Nat`; the arrow `→` (`\to`,
  or `->`); `fun n => …`; `∀ n, P n` (`\forall`, or `forall`) and its comma.
* **Worked example:** `AllBig`.
* **Task:** `AlwaysBelow u B`, `AllEven u`.
* **Tests catch:** `∃` for `∀`, the bound the wrong way round, odd for even.

### 11. If … then … (L11)

* **Teaches:** `p → q` as "if p then q"; `→` binds weakest; `∀ n, p n → q n` for
  statements about only some positions; the classic mistake
  `∀ n, p n ∧ q n`.
* **Worked example:** `BigAfter`.
* **Task:** `LateBig` (from index 5 on, terms are at least 3), `EvenToEven`.
* **Tests catch:** `∧` for `→`. A sequence with small early terms must
  satisfy `LateBig`, and `∧` rejects it. This foreshadows the Goldbach level.

### 12. There exists (L12)

* **Teaches:** `∃ n, P n` (`\exists`, or `exists`); `∀` and `∃` are
  opposites; two properties of the *same* element go inside one `∃` joined by `∧`.
* **Worked example:** `HasBig`.
* **Task:** `HasZero`, `HasEvenBig` (one term both even and at least 10).
* **Tests catch:** `∀` for `∃`, and `(∃ n, even) ∧ (∃ n, big)`, which is
  caught by a sequence with an even term and a big term but none both.

### 13. Quantifiers in order (L13)

* **Teaches:** quantifiers are read left to right and the order matters;
  `∀ m, ∃ n, …` lets `n` depend on `m`, `∃ n, ∀ m, …` does not.
* **Task:** `HitsEverything f` (every number is a value of `f`), `Unbounded u`.
* **Tests catch:** the swapped order (rejects the identity sequence), and
  `∃ M, ∀ n, M ≤ u n` for `Unbounded` (it means "bounded below", so it accepts
  the constant sequence 7 and 0, 1, 0, 1, …).

### 14. Bounded quantifiers (L18)

* **Teaches:** Mathlib's shorthand `∀ n ≥ N, P n` and `∃ n > 0, P n`; that the
  bound becomes `→` under `∀` and `∧` under `∃`; why the hand-written
  `∃ n, n > 0 → P n` is true for every `P` (take `n = 0`); `∀ a b, …`.
* **Worked example:** `EventuallyBig u := ∃ N, ∀ n ≥ N, 10 ≤ u n`.
* **Task:** `HasPositiveRoot f`, `EventuallyZero u`.
* **Tests catch:** `∃ n, n > 0 → f n = 0` (accepts the identity, whose only
  root is 0), and `∀ N, ∃ n ≥ N, u n = 0` ("infinitely often", accepts
  0, 1, 0, 1, …).

---

## Predicate World: the first real definition

### 15. Going to infinity (L1) · writing

* **Builds on:** `∀ ∃ ∀` from level 13, bounded quantifiers from level 14, and
  the `∧`/`→` lesson from level 11.
* **Task:** `TendsToInfinity (u : ℕ → ℕ) : Prop`.
* **Test sequences** are chosen so that each classic mistake fails a specific,
  readable test:
  * unbounded only (`∀ M, ∃ n, M ≤ u n`) fails on 0, 0, 2, 0, 4, …;
  * strictly increasing fails on `n / 2` and on 0, 4, 2, 6, …;
  * the quantifier swap fails on `u n = n`, and the downstream lemmas then
    pass only vacuously;
  * monotone and unbounded fails on 0, 4, 2, 6, 4, 8, ….
* **Also tests** three downstream lemmas a user of the definition needs.

---

## Library World: speaking Mathlib

### 16. Sets (L19)

* **Teaches:** `Set ℕ`; set-builder notation `{n | P n}`; `∈`, `∉`, `⊆`, `∅`
  (`\in`, `\notin`, `\sub`, `\empty`); bounded quantifiers over sets,
  `∀ x ∈ s` and `∃ x ∈ s`; in Mathlib a set *is* a predicate.
* **Worked example:** `evens`.
* **Task:** `multiplesOf k`, `BoundedSet s`.
* **Tests catch:** `{n | k % n = 0}` (the divisors, not the multiples), and
  `∀ n ∈ s, ∃ B, n ≤ B` (always true: accepts 5, 6, 7, …).

### 17. Using Mathlib (L20)

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

### 18. Generality (L21)

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

---

## Analysis World: real numbers

### 19. Limits (L22)

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

---

## Structure World: bundling data and axioms

### 20. Your first structure (L14) · writing

* **Teaches:** `structure Name where` and its fields; building a value with
  `Name.mk`; a field whose type is a statement is an *axiom*; how the referee
  uses *models* (data that should, or should not, satisfy the axioms).
* **Task:** `Interval` (`lo`, `hi` and the axiom `lo ≤ hi`), `PosNat`
  (`val` and the axiom `0 < val`).
* **Tests catch:** a missing axiom (junk values accepted), `<` for `≤`, the
  inequality reversed, `0 ≤ val`.

### 21. A colleague's groups (L2) · reading, then fixing

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

### 22. The AI proved Goldbach! (L3) · auditing

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
| `if` and comparisons (3) | 5 onwards; decidability in 18 |
| recursion (4) | (not used later yet) |
| `Prop` and predicates (5) | 6 onwards |
| `∧ ∨ ¬`, precedence (6–7) | 9, 11, 14, 17, 22 |
| casts and junk values (8–9) | 19 (`(n : ℝ)`), 22 |
| `∀`, function arguments (10) | 11–19, 22 |
| `→` versus `∧` (11) | 14 (bounded quantifiers), 15, 22 (the Goldbach bug) |
| `∃` and quantifier order (12–13) | 15, 16, 19, 22 |
| bounded quantifiers (14) | 15, 16, 18, 19 |
| sets (16) | 18 (`IsUpperBound`) |
| library names, dot notation (17) | 8 introduces dot notation; 21 |
| classes `[Preorder α]` (18) | 21 (structures are the next step towards classes) |
| `structure` and axioms (20) | 21 |

## Not covered yet

These parts of Lean and Mathlib still have no level:

* **Structure syntax:** anonymous constructors `⟨a, b⟩`, structure instance
  notation `{ lo := 2, hi := 5, h := … }`, projections `p.lo`, `extends`.
* **Classes and instances:** `class`, `instance`, and Mathlib's algebraic
  hierarchy (`Group G` with `*`, `1`, `⁻¹` notation). Level 21 uses a plain
  structure instead.
* **Finite sums and `Finset`:** `∑ i ∈ Finset.range n, f i`, and the
  off-by-one in `Finset.range n = {0, …, n - 1}`.
* **Filters:** how Mathlib actually states limits, `Filter.Tendsto u atTop (𝓝 a)`,
  and why it is equivalent to level 19's definition.
* **`Bool` versus `Prop`:** `==` versus `=`, `decide`, and the automatic
  coercion between them.
* **`noncomputable`,** `Classical`, and definitions that cannot be evaluated.
* **Other data types:** `Fin n`, `List`, `Option`.
