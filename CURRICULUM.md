# Curriculum

The game assumes no knowledge of Lean. Each level adds one idea, shows a
worked example in its lesson text, and then asks the player to write similar
definitions. The early worlds teach syntax. The middle worlds teach the
idiosyncrasies of Lean and Mathlib that make a definition compile but mean
the wrong thing: truncated subtraction, casts, junk values such as `x / 0 = 0`,
the hidden `→` and `∧` in bounded quantifiers, and the library's own names and
classes. The last worlds are the real subject of the game: writing, reading
and auditing definitions.

Reading is not left to the end, though. **Most worlds end with a "Spot the bug"
level**: a colleague's definitions compile but are wrong, and the player proves it
with a counterexample, which the referee checks against the right answer. Before it,
the early worlds have a **Challenge** level: a harder writing task with traps, for
players who found the lessons easy. These
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

The number is the position in the browser, and also the name of the directory
(`LeanCraftGame/L<n>`, `variants/L<n>`); `LEVELS` in `web/server.py` lists the
directories in that order. Inserting a level means renumbering the ones after it.

| # | Dir | World | Level | Skill |
|---|---|---|---|---|
| 1 | L1 | Basics | Naming things | syntax |
| 2 | L2 | Basics | Functions | syntax |
| 3 | L3 | Basics | Making choices | syntax |
| 4 | L4 | Basics | Recursion | syntax |
| 5 | L5 | Basics | Challenge: counting | writing |
| 6 | L6 | Basics | Spot the bug | reading |
| 7 | L7 | Statements | True or false? | syntax |
| 8 | L8 | Statements | And | syntax |
| 9 | L9 | Statements | Or and not | syntax |
| 10 | L10 | Statements | Challenge: calendars and triangles | writing |
| 11 | L11 | Statements | Spot the bug: connectives | reading |
| 12 | L12 | Numbers | Integers and casts | syntax |
| 13 | L13 | Numbers | Division by zero | writing |
| 14 | L14 | Numbers | Challenge: truncated arithmetic | writing |
| 15 | L15 | Numbers | Spot the bug: numbers | reading |
| 16 | L16 | Quantifiers | For all | syntax |
| 17 | L17 | Quantifiers | If … then … | syntax |
| 18 | L18 | Quantifiers | There exists | syntax |
| 19 | L19 | Quantifiers | Quantifiers in order | syntax |
| 20 | L20 | Quantifiers | Bounded quantifiers | syntax |
| 21 | L21 | Quantifiers | Challenge: patterns in sequences | writing |
| 22 | L22 | Quantifiers | Spot the bug: quantifiers | reading |
| 23 | L23 | Predicate | Going to infinity | writing |
| 24 | L24 | Predicate | Bounded and monotone | writing |
| 25 | L25 | Predicate | Injective and surjective | writing |
| 26 | L26 | Predicate | Sequences that come back | writing |
| 27 | L27 | Predicate | Be the referee | testing |
| 28 | L28 | Library | Sets | syntax |
| 29 | L29 | Library | Using Mathlib | writing |
| 30 | L30 | Library | Generality | writing |
| 31 | L31 | Library | Divisibility and gcd | writing |
| 32 | L32 | Library | Relations | writing |
| 33 | L33 | Library | Spot the bug: the library | reading |
| 34 | L34 | Finite Sums | Sums | syntax |
| 35 | L35 | Finite Sums | Filters and counting | writing |
| 36 | L36 | Finite Sums | Closed forms | writing |
| 37 | L37 | Finite Sums | Challenge: finite sums | writing |
| 38 | L38 | Finite Sums | Spot the bug: sums | reading |
| 39 | L39 | Analysis | Limits | writing |
| 40 | L40 | Analysis | Continuity | writing |
| 41 | L41 | Analysis | Cauchy sequences | writing |
| 42 | L42 | Analysis | Cluster values | writing |
| 43 | L43 | Analysis | Spot the bug: limits | reading |
| 44 | L44 | Structure Syntax | Declaring a structure | syntax |
| 45 | L45 | Structure Syntax | Functions on structures | writing |
| 46 | L46 | Structure Syntax | Extending and updating | syntax |
| 47 | L47 | Structure Syntax | Challenge: structures | writing |
| 48 | L48 | Structure Syntax | Spot the bug: structures | reading |
| 49 | L49 | Structure | Your first structure | writing |
| 50 | L50 | Structure | Order relations | writing |
| 51 | L51 | Structure | Metric spaces | writing |
| 52 | L52 | Structure | A colleague's groups | reading |
| 53 | L53 | Classes | Classes and instances | syntax |
| 54 | L54 | Classes | Standard instances | writing |
| 55 | L55 | Classes | Instances that depend on instances | writing |
| 56 | L56 | Classes | Challenge: classes | writing |
| 57 | L57 | Classes | Spot the bug: classes | reading |
| 58 | L58 | Faithfulness | The AI proved the infinitude of primes! | auditing |
| 59 | L59 | Faithfulness | The AI proved the Collatz conjecture! | auditing |
| 60 | L60 | Faithfulness | The AI proved Goldbach! | auditing |

Symbols are introduced when they are first needed, each with its plain-ASCII
spelling where Lean has one. The **∀ Symbols** drawer in the browser lists all
of them with the keys to type them, and has a typing drill.

---

---

## Basics World: values and functions

### 1. Naming things (L1) · syntax

* **Teaches:** `def name : Type := value`; the types `Nat` and `String`; using a
  defined name in another definition; `sorry` as a placeholder; `--` comments; how to
  run the tests and read ✅/❌.
  (The `namespace … end` lines that wrap every level's code are added by the game and
  never shown, so they are not taught.)
* **Task:** give three constants their values: `answer : Nat` (42),
  `language : String` ("Lean"), `successor : Nat` (one more than `answer`).
* **Tests catch:** a wrong value, wrong capitalisation of the text.

### 2. Functions (L2) · syntax

* **Teaches:** parameters `(n : Nat)`; the output type; applying a function with
  `f x` (no brackets or commas; brackets only group); `+ - * / %`; division
  drops the remainder; natural-number subtraction stops at 0.
* **Task:** `double`, `squared`, `addTen`, `minusOne` (one less, but 0 stays 0).
* **Tests catch:** `n + n` for the square, and `minusOne 0`, the truncated
  subtraction case.

### 3. Making choices (L3) · syntax

* **Teaches:** several parameters `(a b : Nat)`; `if … then … else …` (both
  branches, same type); the comparisons `= ≠ < ≤ > ≥`; that `=` is a
  statement and not an assignment. First use of `≤` and `\le`.
* **Worked example:** `biggest`.
* **Task:** `smallest`, `gap` (distance between two numbers, either order),
  `zeroOrOne`.
* **Tests catch:** `a - b` for the gap, which is 0 when `a < b`.

### 4. Recursion (L4) · syntax

* **Teaches:** definitions by cases, `| 0 => … | n + 1 => …`; the function
  type `Nat → Nat` before the cases; `_` as a wildcard; recursive calls on a
  smaller input; why the pattern is `n + 1` and never `n - 1`; termination;
  `match n with` as an alternative.
* **Worked example:** `factorial`.
* **Task:** fill in the cases of `sumTo`, `pow2` and `fib`.
* **Tests catch:** wrong base cases (`sumTo 0 = 1`, `pow2 0 = 0`) and wrong
  steps (`sumTo n + n`, `fib (n + 1) + fib (n + 1)`).

### 5. Challenge: counting (L5) · writing

* **Teaches:** turning a word problem into base cases and recursion: two-input pattern matching, several recursive calls, `if` inside a case.
* **Task:** define `stairs n` (ways to climb n steps, 1 or 2 at a time), `choose n k` (Pascal's rule) and `countEven n` (even numbers among 0..n). Predictions: `stairs 0 = 1`, `choose 3 5 = 0`, `countEven 0 = 1`.
* **Tests catch:** `stairs 0 = 0`, wrong recurrence, `choose` base cases in the wrong order or missing (`choose 0 k = 1`), the extra `+ 1`, `countEven` forgetting that 0 is even.

### 6. Spot the bug (L6) · reading

* **Teaches:** reading code instead of writing it; a counterexample as evidence;
  hunting systematically (every branch of an `if`, every "except" in the
  specification).
* **Task:** the colleague's `middle` (a median that is wrong when the largest
  number comes first or second) and `daysInYear` (which forgot the 400-year rule). Give
  three numbers and a year on which they are wrong.
* **Tests catch:** an input in sorted order (`1 2 3`), on which `middle` happens to
  be right, and the year 1900, on which `daysInYear` happens to be right.

---

## Statements World: `Prop` and the connectives

### 7. True or false? (L7) · syntax

* **Teaches:** `Prop`, a statement that is true or false; a *predicate* is a
  function returning `Prop`; no `if`, `true` or `false` in the body; naming
  predicates with a capital; the off-by-one trap `<` versus `≤`.
* **Worked example:** `IsBig`.
* **Task:** `IsEven`, `IsSmall` (below 10), `GoesInto a b`.
* **Tests catch:** `n % 2 = 1`, `n ≤ 10` (boundary value 10), swapped `a` and `b`.

### 8. And (L8) · syntax

* **Teaches:** `∧` (`\and`, or `/\`); there is no `lo ≤ n ≤ hi`, write two
  comparisons; a definition may use earlier ones.
* **Worked example:** `InRange lo hi n`.
* **Task:** `IsTeen` (13 to 19), `EvenInRange` (reusing `InRange`).
* **Tests catch:** `∨` instead of `∧`, strict bounds, a missing condition.

### 9. Or and not (L9) · syntax

* **Teaches:** `∨` (`\or`, or `\/`); `¬` (`\not`, or `Not p`); binding strength
  `¬`, then `∧`, then `∨`, then `→`; parentheses.
* **Task:** `FreeTicket` (under 5 or at least 65), `PaysFull` (the opposite,
  using `FreeTicket`), `NotTiny` (neither 0 nor 1).
* **Tests catch:** `∧` for `∨`, boundary values 5 and 65, and
  `n ≠ 0 ∨ n ≠ 1`, which is always true.

### 10. Challenge: calendars and triangles (L10) · writing

* **Teaches:** combining `∧ ∨ ¬ ≠ < ≤ %` with care for precedence and "exactly one".
* **Task:** define `LeapYear` (Gregorian), `IsTriangle a b c` (three strict inequalities, no subtraction), `ExactlyOneEven a b c`. Predictions: `LeapYear 1900`, `IsTriangle 1 2 3`, `ExactlyOneEven 2 4 6`.
* **Tests catch:** missing century rule or 400 exception, `≤` instead of `<` (flat triangles), one missing inequality (each of the three long-side cases tested), "at least one even", zero-length side.

### 11. Spot the bug: connectives (L11) · reading

* **Teaches:** that a predicate can be wrong in two directions, too weak (accepts
  too much) or too strong (rejects too much); binding strengths again.
* **Task:** the colleague's `IsTeen` (`∨` for `∧`: accepts everything),
  `IsWeekend` (`∧` for `∨`: rejects everything) and `BothOdd`
  (`¬ a % 2 = 0 ∧ b % 2 = 0`, where `¬` only covers the left side). Give an input
  on the wrong side of each.
* **Tests catch:** a genuine teenager, a weekday, two odd numbers.

---

## Numbers World: types of numbers and their traps

### 12. Integers and casts (L12) · syntax

* **Teaches:** `ℤ` and `ℕ` (`\Z`, `\N`); type ascription `(3 : ℤ)`; casts
  `(n : ℤ)`, displayed `↑n`; *where* the cast goes matters,
  `((a - b : ℕ) : ℤ)` subtracts in ℕ first; `(a - b : ℤ)` casts the leaves;
  dot notation `x.natAbs` for `Int.natAbs x`; the junk value
  `(-3 : ℤ).toNat = 0`.
* **Task:** `diff (a b : ℕ) : ℤ`, `distance (a b : ℤ) : ℕ`, `IsNegative`.
* **Tests catch:** the late cast (`diff 3 5 = 0`), `.toNat` instead of
  `.natAbs` (`distance (-4) 3 = 0`), `x ≤ 0` for negative.

### 13. Division by zero (L13) · writing

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

### 14. Challenge: truncated arithmetic (L14) · writing

* **Teaches:** truncated `ℕ` subtraction, rounding-down division, cast placement, division by zero.
* **Task:** define `absDiff` (ℕ), `signum` (ℤ), `ratio a b : ℚ` (0 if b = 0), `percent a b` (rounded to nearest, halves up, in ℕ). Predictions: `absDiff 3 5 = 2`, `ratio 1 2 = 1 / 2`, `percent 1 8 = 13`.
* **Tests catch:** `a - b` alone, ℕ division then cast, `100 * a / b` rounding down, halves rounded down, missing sign case, junk value at b = 0.

### 15. Spot the bug: numbers (L15) · reading

* **Teaches:** that junk-value bugs agree with the intended meaning on most inputs,
  so random checks miss them; asking "where is the junk value?".
* **Task:** the colleague's `diff` (late cast), `IsReciprocal` (`y = 1 / x`) and
  `average` (`a + b / 2`). Give inputs on which each is wrong.
* **Tests catch:** `a ≥ b` for `diff`, a genuine reciprocal pair, and `a = 0` for
  `average`, where `a + b / 2` happens to equal `(a + b) / 2`.

---

## Quantifiers World: statements about sequences

### 16. For all (L16) · syntax

* **Teaches:** a sequence is a function `u : Nat → Nat`; the arrow `→` (`\to`,
  or `->`); `fun n => …`; `∀ n, P n` (`\forall`, or `forall`) and its comma.
* **Worked example:** `AllBig`.
* **Task:** `AlwaysBelow u B`, `AllEven u`.
* **Tests catch:** `∃` for `∀`, the bound the wrong way round, odd for even.

### 17. If … then … (L17) · syntax

* **Teaches:** `p → q` as "if p then q"; `→` binds weakest; `∀ n, p n → q n` for
  statements about only some positions; the classic mistake
  `∀ n, p n ∧ q n`.
* **Worked example:** `BigAfter`.
* **Task:** `LateBig` (from index 5 on, terms are at least 3), `EvenToEven`.
* **Tests catch:** `∧` for `→`. A sequence with small early terms must
  satisfy `LateBig`, and `∧` rejects it. This foreshadows the Goldbach level.

### 18. There exists (L18) · syntax

* **Teaches:** `∃ n, P n` (`\exists`, or `exists`); `∀` and `∃` are
  opposites; two properties of the *same* element go inside one `∃` joined by `∧`.
* **Worked example:** `HasBig`.
* **Task:** `HasZero`, `HasEvenBig` (one term both even and at least 10).
* **Tests catch:** `∀` for `∃`, and `(∃ n, even) ∧ (∃ n, big)`, which is
  caught by a sequence with an even term and a big term but none both.

### 19. Quantifiers in order (L19) · syntax

* **Teaches:** quantifiers are read left to right and the order matters;
  `∀ m, ∃ n, …` lets `n` depend on `m`, `∃ n, ∀ m, …` does not.
* **Task:** `HitsEverything f` (every number is a value of `f`), `Unbounded u`.
* **Tests catch:** the swapped order (rejects the identity sequence), and
  `∃ M, ∀ n, M ≤ u n` for `Unbounded` (it means "bounded below", so it accepts
  the constant sequence 7 and 0, 1, 0, 1, …).

### 20. Bounded quantifiers (L20) · syntax

* **Teaches:** Mathlib's shorthand `∀ n ≥ N, P n` and `∃ n > 0, P n`; that the
  bound becomes `→` under `∀` and `∧` under `∃`; why the hand-written
  `∃ n, n > 0 → P n` is true for every `P` (take `n = 0`); `∀ a b, …`.
* **Worked example:** `EventuallyBig u := ∃ N, ∀ n ≥ N, 10 ≤ u n`.
* **Task:** `HasPositiveRoot f`, `EventuallyZero u`.
* **Tests catch:** `∃ n, n > 0 → f n = 0` (accepts the identity, whose only
  root is 0), and `∀ N, ∃ n ≥ N, u n = 0` ("infinitely often", accepts
  0, 1, 0, 1, …).

### 21. Challenge: patterns in sequences (L21) · writing

* **Teaches:** nested quantifiers and bounds for sequence properties: order, `p > 0`, fixed vs chosen constant.
* **Task:** define `Periodic`, `EventuallyConstant`, `HasMaximum`, `EventuallyPeriodic` for `u : ℕ → ℕ`. Predictions: `Periodic (fun n => n)`, `Periodic (fun n => if n < 5 then 7 else 0)`, `HasMaximum (fun _ => 5)`.
* **Tests catch:** `p = 0` allowed, `∃ N` added to `Periodic`, constant fixed to 0, `∀ n ≥ N, ∃ c`, `∀ n, ∃ m` for maximum, strict `<`, minimum instead of maximum.

### 22. Spot the bug: quantifiers (L22) · reading

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

### 23. Going to infinity (L23) · writing

* **Builds on:** `∀ ∃ ∀` from level 19, bounded quantifiers from level 20, and
  the `∧`/`→` lesson from level 17.
* **Task:** `TendsToInfinity (u : ℕ → ℕ) : Prop`.
* **Test sequences** are chosen so that each classic mistake fails a specific,
  readable test:
  * unbounded only (`∀ M, ∃ n, M ≤ u n`) fails on 0, 0, 2, 0, 4, …;
  * strictly increasing fails on `n / 2` and on 0, 4, 2, 6, …;
  * the quantifier swap fails on `u n = n`, and the downstream lemmas then
    pass only vacuously;
  * monotone and unbounded fails on 0, 4, 2, 6, 4, 8, ….
* **Also tests** three downstream lemmas a user of the definition needs.

### 24. Bounded and monotone (L24) · writing

* **Teaches:** Properties of integer sequences `u : ℕ → ℤ` that mix quantifier order and inequalities: `∃ M, ∀ n` (bounded) versus `∀ n, ∃ M` (empty), one-sided versus two-sided bounds (absolute value on `ℤ`), `≤` versus `<`, and monotone over *all* pairs `m ≤ n` (or equivalently consecutive terms) rather than a prefix.
* **Task:** Define `BoundedAbove u`, `Bounded u` (with `|u n| ≤ M`, `M : ℕ`), `NonDecreasing u` and `StrictlyIncreasing u`.
* **Tests catch:** `∀ n, ∃ M` (accepts `n`); a one-sided `Bounded` (accepts `-n`); `m ≤ n → u m < u n` for strictness (fails on `n`); `m < n → u m ≤ u n` for strictness (accepts `n / 2`); a missing hypothesis `m ≤ n`; reversed inequality; monotone only from some point on (`0, 1, 2, 0, 0, …`); both the all-pairs and the consecutive-terms formulation are accepted (tests are concrete sequences plus lemmas valid for both).

### 25. Injective and surjective (L25) · writing

* **Teaches:** The two classic `∀∃`-patterns on functions `f : ℕ → ℕ`: injectivity (`f a = f b → a = b`, direction of the arrow, `∀ a b`) and surjectivity (`∀ y, ∃ x, f x = y`, not `∀ x, ∃ y` nor `∃ x, ∀ y`), and `Bijective` as a conjunction. Tested on truncated subtraction and parity tricks.
* **Task:** Define `Injective f`, `Surjective f`, `Bijective f`.
* **Tests catch:** `a = b → f a = f b` (true for everything); `f a ≠ f b → a ≠ b`; `∀ a, ∃ b, …` trivialised by `b = a`; `∀ x, ∃ y, f x = y` (trivial); `∃ x, ∀ y, …`; `0 < y →` hypothesis (misses 0 in `n - 1`); `Bijective` as `∨`; examples `n + 1` (injective, not surjective), `n - 1` (surjective, not injective), `n % 3`, `2 * n`, constant, the identity, and the pair-swapping function `if n % 2 = 0 then n + 1 else n - 1` (injective only: its surjectivity needs a parity-dependent witness the referee cannot find); lemmas: two colliding inputs make `f` neither injective nor bijective.

### 26. Sequences that come back (L26) · writing

* **Teaches:** "Eventually" (`∃ N, ∀ n ≥ N`) versus "infinitely often" (`∀ N, ∃ n ≥ N`) versus "at least once" (`∃ n`), and their negations; recurrence to the starting value `u 0`.
* **Task:** Define `EventuallyEqual u a`, `InfinitelyOften u a`, `OnlyFinitelyOften u a` (negation with `¬` pushed in) and `Recurrent u` (`u n = u 0` infinitely often).
* **Tests catch:** swapped quantifiers (both ways); `∃ n, u n = a` (once); an `EventuallyEqual` that ignores `a`; `Recurrent` using `0` instead of `u 0` (`1, 0, 0, …`); recurrence "once" (`7,7,7,7,7,0,…`); `OnlyFinitelyOften` as `∀ n, u n ≠ a` or as `∀ N, ∃ n ≥ N, u n ≠ a`; examples `n % 2`, `n % 3`, `n`, a constant, `if n < 5 then 7 else 0`, `if n % 2 = 0 then 0 else n`.

### 27. Be the referee (L27) · testing

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

### 28. Sets (L28) · syntax

* **Teaches:** `Set ℕ`; set-builder notation `{n | P n}`; `∈`, `∉`, `⊆`, `∅`
  (`\in`, `\notin`, `\sub`, `\empty`); bounded quantifiers over sets,
  `∀ x ∈ s` and `∃ x ∈ s`; in Mathlib a set *is* a predicate.
* **Worked example:** `evens`.
* **Task:** `multiplesOf k`, `BoundedSet s`.
* **Tests catch:** `{n | k % n = 0}` (the divisors, not the multiples), and
  `∀ n ∈ s, ∃ B, n ≤ B` (always true: accepts 5, 6, 7, …).

### 29. Using Mathlib (L29) · writing

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

### 30. Generality (L30) · writing

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

### 31. Divisibility and gcd (L31) · writing

* **Teaches:** building number theory from `∣`, quantifiers and `≤`: coprimality, the algebraist's gcd (common divisor that every common divisor divides), primes and squarefree numbers, with the corner cases 0 and 1 (`n ∣ 0` always, `0 ∣ n` only for `n = 0`).
* **Task:** define `Coprime'`, `IsGcd`, `IsPrime'`, `Squarefree'` (`CommonDiv` given), without Mathlib's `Nat.gcd`/`Nat.Prime`.
* **Tests catch:** a gcd that is only a common divisor (`IsGcd 12 18 3`), the reversed `d ∣ e`, the schoolbook "largest" version (fails at `IsGcd 0 0 0`), 1 accepted as prime, primes defined by a vacuous bounded clause (0 and 1), coprime as "neither divides the other", squarefree accepting 0 or rejecting everything with a divisor.

### 32. Relations (L32) · writing

* **Teaches:** the laws of a relation `r : ℕ → ℕ → Prop` (reflexive, symmetric, transitive, antisymmetric) and their bundles (equivalence relation, partial order); vacuous truth of "if … then …" laws; antisymmetry concludes `a = b`.
* **Task:** define `Reflexive'`, `Symmetric'`, `Transitive'`, `Antisymmetric'`, `IsEquivalence'`, `IsPartialOrder'`, tested on `≤`, `<`, `∣`, same remainder mod 3, `≠`, the empty and the full relation.
* **Tests catch:** reflexivity written as an implication (empty relation), a trivially true symmetry, transitivity with a side condition `a ≠ c`, antisymmetry confused with asymmetry or lacking the `a = b` conclusion, bundles that forget reflexivity (the empty relation passes).

### 33. Spot the bug: the library (L33) · reading

* **Teaches:** that library notions have fixed meanings and argument orders, and a
  definition using them can still say the wrong thing.
* **Task:** the colleague's `CommonDivisor` (`a ∣ d ∧ b ∣ d`, a common multiple),
  `TwinPrime` (`∨` for `∧`) and `multiplesOf` (`{n | k % n = 0}`, the divisors).
  Give an input that each accepts wrongly.
* **Tests catch:** a genuine common divisor, a genuine twin prime, a genuine multiple.

---

## Finite Sums World: adding up over finite sets

### 34. Sums (L34) · syntax

* **Teaches:** the big-operator notation `∑ i ∈ Finset.range n, f i` (typed `\sum`, `\in`), `Finset` as a finite set that can be added up, `Finset.range n = {0..n-1}` (the off-by-one trap), `Finset.Icc a b` (both ends) and `Finset.Ico a b` (right end excluded), the empty sum is 0, the formula after the comma reaches over `*` but stops at `+` and `-` (brackets needed for `2 * i + 1`).
* **Task:** one worked sum (`sumOfDoubles`) and four to write: `squares` (1² + … + n²), `oddSum` (first n odd numbers), `sumBelow`, `sumBetween a b` (Ico). Tests are public.
* **Tests catch:** `range` where `Icc 1 n` is needed (`squares 4`), `Icc` where `Ico` is needed (`sumBetween 4 4`), `2 * i - 1` over `range n` (first term truncated), `range (b - a)` instead of a shifted set, empty and reversed ranges.

### 35. Filters and counting (L35) · writing

* **Teaches:** `Finset.filter (fun i => …) s`, `.card`, sums over a filter or with `if` inside, `∏` and the empty product 1.
* **Task:** `numDivisors`, `countPrimes` (below n), `fact` as a product, `multiples3or5` (below n, "or" counted once), `IsPerfect`.
* **Tests catch:** `range (n+1)` letting 0 count as a divisor of 0, `countPrimes` including n, `∏` over `range n` (a factor 0), double counting 15 with two separate sums, `IsPerfect 0` (empty sum equals 0) and `IsPerfect 1` (`Icc` includes n itself).

### 36. Closed forms (L36) · writing

* **Teaches:** a sum and its closed form agree (the referee checks every n below 10), double sums with an inner range depending on the outer variable, `if` inside a double sum, sums in ℚ with exact division and casts before dividing.
* **Task:** worked `triSum`/`triFormula`/`pairs`; write `cubeSum`, `cubeFormula`, `sameParity` (double sum), `geom`, `geomFormula`, `meanSquare`.
* **Tests catch:** `range` for cubes, wrong brackets in `n * (n + 1) / 2 ^ 2` and `n * ((n + 1) / 2)`, ℕ division in `geom` and `meanSquare`, `n - 1` in the geometric closed form (fails at n = 0), counting all pairs or including j = i in the double sum.

### 37. Challenge: finite sums (L37) · writing

* **Teaches:** nothing new: write out the terms by hand.
* **Task:** `telescope` (ℚ, 1/(i(i+1)) over 1..n), `sumOfSucc` (sum of i + 1: brackets needed, since a sum stops at `+`), `rangeSum a b` (empty if b < a), `totalChange` of a sequence (distances with truncated subtraction), `floorSum` (n / i in ℕ).
* **Tests catch:** ℕ division then cast, `range` instead of `Icc 1 n`, `∑ …, i + 1` meaning (∑ i) + 1, `Ico` for an inclusive range, subtraction of sums, only-up or only-down differences, an extra step `range (n+1)`, `range n` dropping the term n / n.

### 38. Spot the bug: sums (L38) · reading

* **Teaches:** auditing sums by writing out the set and testing small inputs; both ends of a range; a bug (squaring the sum instead of the terms) that needs two nonzero terms to show.
* **Task:** give `tn`, `dn`, `pn`, `en` on which the colleague's `triangle` (range vs Icc), `numDivisors` (Ico drops n), `primesUpTo` (range drops n) and `evenSquares` (square outside the sum) are wrong.
* **Tests catch:** inputs on which the colleague's code still agrees with the right one (`tn = 0`, `dn = 0`, composite `pn`, small `en`).

---

## Analysis World: real numbers

### 39. Limits (L39) · writing

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

### 40. Continuity (L40) · writing

* **Teaches:** the ε-δ definition of continuity at a point for `f : ℝ → ℝ`, built in two layers: the inner predicate `IsDeltaFor f a ε δ` ("δ is a good choice for ε": `0 < δ` and every `x` with `|x - a| < δ` has `|f x - f a| < ε`), then `ContAt f a := ∀ ε > 0, ∃ δ, IsDeltaFor f a ε δ`. Same shape as "Limits" with a real `δ` in place of the index `N`, and definitions that call each other.
* **Task:** worked example `BoundedBy f M := ∀ x, |f x| ≤ M`; the player writes `IsDeltaFor` and `ContAt`.
* **Tests catch:** `δ = 0` / negative `δ` (forgotten `0 < δ`; a constant function with `δ = 0`), `|x|` instead of `|x - a|` (id at 3), `|f x - a|` instead of `|f x - f a|` (`x + 1` at 2), `≤ δ` in the hypothesis (`2x`, `δ = 1/2`, `ε = 1`), `≤ ε` in the conclusion (step function: a jump of exactly `ε`), forgotten `ε > 0` (constant function is continuous), and positive probes (id, constants, `x + 1`, `|x|`, a step function away from its jump). The referee cannot refute continuity of a function at a point (it needs a witness `x` closer than the unknown `δ`), so the *negative* verdicts are all on the explicit-`δ` predicate, where the witnesses are numerals like `1/2`. A standalone `ContAt` that forgets `0 < δ` is therefore only caught if the player also forgets it in `IsDeltaFor` (the level is built so that is the natural thing to do). "∃δ before ∀ε" cannot be caught (only `❓`), so it is not tested.

### 41. Cauchy sequences (L41) · writing

* **Teaches:** the Cauchy condition for real sequences: `∀ ε > 0, ∃ N, ∀ m ≥ N, ∀ n ≥ N, |u m - u n| < ε`, with *two* universally quantified indices that must both be beyond `N`; a warm-up `IsEventuallyConstant u := ∃ N, ∀ n ≥ N, u n = u N` (the `∃ N, ∀ n ≥ N` shape without `ε`).
* **Task:** worked example `ConvergesTo`; the player writes `IsEventuallyConstant` and `IsCauchy`.
* **Tests catch:** forgotten `ε > 0` (constant sequence), `∃` instead of `∀` for the pair `m, n` (`0, 1, 2, 3, …` accepted), free `n` instead of `n ≥ N` (`1, 0, 0, 0, …`: the first terms never matter), `∀ n` instead of `∀ n ≥ N` and `∃ n ≥ N` instead of `∀ n ≥ N` in the warm-up (`7, 7, 7, 7, 7, 0, 0, …` and `0, 1, 2, 3, …`). Not tested (the referee cannot do it): the "only consecutive terms" weakening and "`N` before `ε`", which need sequences like `1/n` or harmonic sums; the negative test `0, 1, 0, 1, …` is also dropped from `IsCauchy` (search too deep).

### 42. Cluster values (L42) · writing

* **Teaches:** the `∀ ε > 0, ∀ N, ∃ n ≥ N` quantifier pattern (cluster value, "close infinitely often") against the `∃ N, ∀ n ≥ N` of limits; subsequences, via a strictly increasing index map `φ : ℕ → ℕ` and the composite `fun n => u (φ n)`; the interplay of a conjunction of a monotonicity condition and a convergence statement.
* **Task:** worked example `ConvergesTo`; the player writes `ClusterValue u a` and `IsSubseqLimit u φ a` (φ strictly increasing and `u ∘ φ` converges to `a`).
* **Tests catch:** forgotten `ε > 0`; "some term" without `n ≥ N` and "`∃ N`" instead of "`∀ N`" (`7` is not a cluster value of `7, 7, 7, 7, 7, 0, 0, …`); using the definition of a limit (`0` and `1` are cluster values of `0, 1, 0, 1, …`); no cluster value `0` of `0, 1, 2, 3, …`; forgetting that `φ` must be strictly increasing (`φ n = 0`, `φ n = n / 2`, and a weakly increasing `φ`); comparing `u n` instead of `u (φ n)` with `a`.

### 43. Spot the bug: limits (L43) · reading

* **Teaches:** working out *which way* a definition is wrong (too strong or too
  weak) before looking for a counterexample.
* **Task:** Alice forgot `ε > 0` (too strong: no sequence converges), Bob wrote
  `∃ n` instead of `∀ n ≥ N` (too weak). Give a convergent sequence that Alice
  rejects and a divergent one that Bob accepts.
* **Tests catch:** a sequence that does not converge to the given limit, a
  convergent sequence for Bob, and one that never comes close.

---

## Structure Syntax World: declaring and using structures

### 44. Declaring a structure (L44) · syntax

* **Teaches:** `structure P where` with fields `name : type`; the three ways to build a value (`P.mk a b`, `⟨a, b⟩`, `{ x := a, y := b }`); reading fields with `p.x` and `Point.x p`; the order of fields.
* **Task:** `Point` is given; declare `Rectangle` (`width`, `height`) and `Card` (`rank`, `suit`); build `origin`, `p34`, `wide`, `queenOfHearts`; write `perimeter` and `swapPoint` by reading fields.
* **Tests catch:** fields declared in the wrong order (`Rectangle.mk 7 2` has width 7), values built in the wrong order, `2 * w + h` instead of `2 * (w + h)`, `swapPoint` that does not swap.

### 45. Functions on structures (L45) · writing

* **Teaches:** `def Point.add (p q : Point) : Point`, dot notation `p.add q`, `namespace Point … end Point`, pattern matching on `⟨a, b⟩`, structures as results.
* **Task:** `Point.add`, `Point.dist2` (squared distance in ℕ), `Rectangle.area`, `Rectangle.grow`, `Rectangle.topRight`.
* **Tests catch:** truncated subtraction in `dist2` (⟨1,1⟩ ⟨4,5⟩, mixed signs ⟨4,1⟩ ⟨1,5⟩, one coordinate fixed only), swapped coordinates in `add`/`topRight`, `area` as a sum, `grow` by `k` instead of `2k` or with width/height swapped.

### 46. Extending and updating (L46) · syntax

* **Teaches:** `{ p with x := … }`, default field values `x : ℕ := 5`, `{}` and partial `{ volume := 0 }`, `structure Point3 extends Point where z : ℕ` (parent first in `mk`, `q.x`, `q.toPoint`), parameterised `structure Pair (α : Type)` and `{α : Type}` in functions.
* **Task:** `moveRight` with `with`; declare `Settings` with defaults and build `quiet`; declare `Point3` and write `raise`; declare `Pair α` and write `Pair.swap`, `Pair.dup`.
* **Tests catch:** updating the wrong field, overwriting instead of adding, wrong default values, fields in the wrong order, `quiet` rebuilt without the defaults, `raise` that resets `x`, `y`, `swap` that duplicates a field.

### 47. Challenge: structures (L47) · writing

* **Teaches:** combining everything: defaults, `with`, `extends`, recursion on a structure-valued function. A calendar with 12 months of 30 days.
* **Task:** declare `Date` (defaults month = day = 1) and `Moment extends Date` with a `time : Time`; write `newYear`, `Date.nextDay`, `Date.addDays` (recursion), `Moment.addMinutes` (carries minutes, hours and days).
* **Tests catch:** wrong default (day 0), fields out of order, the 30th mapped to day 31, day not reset at month change, missing year carry, year increased in all of December, `addDays` that only adds one day, `addMinutes` that forgets the date, forgets `% 24`, swaps hour/minute, or ignores the minutes.

### 48. Spot the bug: structures (L48) · reading

* **Teaches:** reading structure code critically: a `with` update reading the wrong field, a `with` that copies a field that must be reset, `⟨ , , ⟩` with fields in the wrong places, a field-by-field comparison where a lexicographic one was specified.
* **Task:** four colleague functions on `Version` (`bumpPatch`, `bumpMinor`, `setPatch`, `newer`); give counterexample inputs for each.
* **Tests catch:** counterexamples that do not actually separate the colleague's code from the right one (equal minor/patch, patch 0, etc.). Claim-style tests, `public: "all"`.

---

## Structure World: bundling data and axioms

### 49. Your first structure (L49) · writing

* **Teaches:** `structure Name where` and its fields; building a value with
  `Name.mk`; a field whose type is a statement is an *axiom*; how the referee
  uses *models* (data that should, or should not, satisfy the axioms).
* **Task:** `Interval` (`lo`, `hi` and the axiom `lo ≤ hi`), `PosNat`
  (`val` and the axiom `0 < val`).
* **Tests catch:** a missing axiom (junk values accepted), `<` for `≤`, the
  inequality reversed, `0 ≤ val`.

### 50. Order relations (L50) · writing

* **Teaches:** writing the axiom fields of a structure whose data is a relation `le : α → α → Prop`: reflexivity, antisymmetry (conclusion `a = b`, not symmetry) and transitivity (right order of the variables).
* **Task:** complete `PartialOrder'` with `refl`, `antisymm`, `trans`. The referee plugs in `≤`, `≥`, divisibility on {0..6}, equality, `≤` on `Fin 3` (accepted) and `<`, `≠`, the always-true relation, "differ by at most 1", `a % 2 ≤ b % 2`, "equal or next" (reflexive, antisymmetric, not transitive) (rejected).
* **Tests catch:** forgotten reflexivity (`<`, `≠` slip in); no antisymmetry (always-true, parity-comparison, "differ by 1" slip in); no transitivity ('equal or next' slips in); antisymmetry written as the symmetric `le a b → le b a` or as `a = b → le a b` (rejects `≤`); transitivity with variables in the wrong order (rejects `≤`) or missing (non-transitive relations slip in).

### 51. Metric spaces (L51) · writing

* **Teaches:** axioms of a distance `dist : α → α → ℤ` with an `↔` axiom (`dist a b = 0 ↔ a = b`), non-negativity (a real axiom because the target is ℤ), symmetry and the triangle inequality; which junk each direction/axiom excludes.
* **Task:** complete `Metric'` with `eq_zero`, `nonneg`, `symm`, `triangle`. Accepted models on four points: `|x-y|`, discrete metric, `2|x-y|`, truncated-difference distance. Rejected: `x-y`, `(x-y)^2`, zero distance, `x+y`, `max x y`, parity pseudo-distance, one-way (asymmetric) distance, constant 1, `-|x-y|`.
* **Tests catch:** (non-negativity is in fact a consequence of the other three axioms, so a player may leave it out: `0 = dist a a ≤ dist a b + dist b a = 2 dist a b`; a nice discussion) only `a = b → dist a b = 0` (zero distance, parity slip in); only `dist a b = 0 → a = b` (x+y, max, constant 1 slip in); missing symmetry (x-y, one-way); missing/reversed triangle inequality ((x-y)^2).

### 52. A colleague's groups (L52) · reading

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

## Classes World: one notation, many types

### 53. Classes and instances (L53) · syntax

* **Teaches:** `class C (α : Type) where field : …`, `instance : C T where field := …` (optionally named), calling `Size.size x`, instance resolution ("failed to synthesize"), `inferInstance`, a function with an instance argument `[Size α]`.
* **Task:** write three instances of a given class `Size`: `String` (length), `List ℕ` (number of entries), a player-visible structure `Rect` (area).
* **Tests catch:** list size taken as the sum instead of the length (`[7]`, `[10, 20]`), the area replaced by sum or perimeter (`Rect.mk 0 5`, `1 × 9` against `3 × 3`), a constant size for strings.

### 54. Standard instances (L54) · writing

* **Teaches:** the classes behind notation: `Add`, `Neg`, `Sub`, `Zero` (numeral `0`), and the general `HAdd α β γ`; anonymous constructor `⟨a, b⟩`; `deriving DecidableEq`; instances using each other.
* **Task:** give the structure `Vec` (two integers) the instances `Add`, `Zero`, `Neg`, `Sub`, and `HAdd Vec ℤ Vec` (shift both coordinates).
* **Tests catch:** `sub` with its arguments reversed, `neg` changing one coordinate, `zero` not the origin, shift of one coordinate, mixed-up coordinates in `add`; a deleted instance (checks); consistency (`v + -v = 0`, `v - v = 0`).

### 55. Instances that depend on instances (L55) · writing

* **Teaches:** conditional instances `instance {α} [Add α] : Add (Pair α)`, chaining of instance search (`Pair (Pair ℕ)`, `Pair (ℕ × ℕ)`, `List (Pair String)`), why a function needs `[Size α]` in its signature, `class … extends …`.
* **Task:** complete `Add (Pair α)`, `Size (Pair α)`, `Size (List α)`, `largest [Size α] (xs : List α)` and `heavy [Weighted α] (a : α)`.
* **Tests catch:** list size as length, size of only the first component, `largest` as sum or first entry, `heavy` using the wrong fields, swapped coordinates, an instance specialised to `ℕ` (checks), nesting.

### 56. Challenge: classes (L56) · writing

* **Teaches:** instances that type check but are lawless: `Ord`/`compare` and `Ordering`, `Max`, `Min`, tie-breaking with `Ordering.then`, laws as the real specification (commutative `max`, antisymmetric `compare`, `compare a a = .eq`).
* **Task:** for `Score` (points, penalty) write `value` in `ℤ`, `Ord`, `Max`, `Min` for the ranking (value, then points) and `best` of a list.
* **Tests catch:** truncated subtraction for `value`, points before value, `compare` never returning `.eq` (not antisymmetric), `max`/`min` that depend on the argument order on ties, `min` written as `max`, `best` seeded with `Score.mk 0 0`.

### 57. Spot the bug: classes (L57) · reading

* **Teaches:** reading instance code critically: `+` that is not associative, an instance that ignores part of its input, two instances (`Ord`, `Max`) that Lean never checks agree.
* **Task:** give counterexamples: three numbers with `(a + b) + c ≠ a + (b + c)` for averaging marks, a list whose colleague-`Size` is not its sum, two versions where `max` returns a lower one according to `compare`.
* **Tests catch:** equal numbers (associative by luck), a list whose ignored entries are all 0, versions where `max` and `compare` agree.

---

## Faithfulness World: auditing a formal statement

### 58. The AI proved the infinitude of primes! (L58) · auditing

* **Teaches:** the audit checklist (read the formula in words, find the missing
  ingredient, cheapest witness, check definitions on 0/1/2, toy worlds); that a
  true, compiling proof says nothing about faithfulness; that
  `∀ n, ∃ p, P p ∧ p ≠ n` means only "at least two", while "infinitely many"
  needs `n < p`.
* **Task:** the AI proves `∀ n, ∃ p, IsPrime p ∧ p ≠ n` (with an `IsPrime` that
  forgot `2 ≤ p`). The player writes `Unbounded P` (the faithful statement,
  for any `P`), a finite counterexample world `smallWorld` (numbers in 2..100,
  at least two of them), and `fakePrime` (a number the AI's `IsPrime` accepts
  but `Nat.Prime` rejects: 1).
* **Tests catch:** `p ≠ n` instead of `n < p` (the world "2 and 3"), `P p → n < p`
  (vacuous in the empty world), `∃ p, ∀ n` (all numbers), worlds with one number
  (AI's claim false), infinite worlds, worlds containing 0 or 1, and the fake prime
  0 (which the AI's `IsPrime` rejects) or a real prime.

### 59. The AI proved the Collatz conjecture! (L59) · auditing

* **Teaches:** the "cheapest witness" failure (`∃ k, o n k ≤ n` holds at `k = 0`),
  `=` vs `≤` (junk value 0 satisfies `≤ 1`), junk values (`0 / 2 = 0`, `0 - k = 0`:
  the start 0 is stuck, so "positive" is a real hypothesis), `∀ n ∃ k` vs
  `∃ k ∀ n`; auditing by replacing the process with toy processes.
* **Task:** the AI's `AIClaim o := ∀ n, ∃ k, o n k ≤ n` is proved by `k = 0`.
  The player writes `Collatz o` (from every positive `n`, some `o n k = 1`), a
  lazy process `lazyWorld` where the AI's claim holds but the real one fails, and
  a start `stuckStart` (0) that the AI's `step` leaves fixed.
* **Tests catch:** `≤ n` (counting up), `≤ 1` (falls to 0), missing `0 < n`
  (counting down), swapped quantifiers (process "stays n until step n, then 1"),
  a non-process or non-failing `lazyWorld`, and `stuckStart` = 1 or 2.

### 60. The AI proved Goldbach! (L60) · auditing

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

## How the skills build

| Skill from … | is used in … |
|---|---|
| `def`, types, application (1–2) | everything |
| `if` and comparisons (3) | 6, 7 onwards; decidability in 30 |
| recursion (4) | 5 ("Challenge: counting") |
| reading code, counterexamples (6) | 11, 15, 22, 33, 38, 43, 48, 52 (part A), 57, 58–60 |
| `Prop` and predicates (7) | 8 onwards |
| `∧ ∨ ¬`, precedence (8–9) | 11, 13, 17, 22, 29, 33, 60 |
| casts and junk values (12–13) | 15, 39 (`(n : ℝ)`), 60 |
| `∀`, function arguments (16) | 17–27, 39, 43, 60 |
| `→` versus `∧` (17) | 20 (bounded quantifiers), 22, 23, 60 (the Goldbach bug) |
| `∃` and quantifier order (18–19) | 22, 23, 27, 28, 39, 43, 60 |
| bounded quantifiers (20) | 22, 23, 28, 30, 39, 43 |
| choosing tests (27) | 60 (toy worlds are tests for a statement) |
| sets (28) | 30 (`IsUpperBound`), 33 |
| library names, dot notation (29) | 12 introduces dot notation; 33, 52 |
| classes `[Preorder α]` (30) | 52 (structures are the next step towards classes) |
| `∑`, `Finset.range`, `Finset.filter` (34–38) | (not used later yet) |
| `structure`, `⟨ ⟩`, `{ v with … }` (44–48) | 49–52, 53–57 (instances are built with them) |
| `class` and `instance` (53–57) | 58–60 (what a formalisation hides in `+` and `max`) |
| `structure` and axioms (49) | 50–52 |


## Not covered yet

These parts of Lean and Mathlib still have no level:

* **Mathlib's algebraic hierarchy:** `Group G` with `*`, `1`, `⁻¹` notation, as
  opposed to a plain structure like the one in "A colleague's groups".
* **Filters:** how Mathlib actually states limits, `Filter.Tendsto u atTop (𝓝 a)`,
  and why it is equivalent to the definition in "Limits".
* **`Bool` versus `Prop`:** `==` versus `=`, `decide`, and the automatic
  coercion between them.
* **`noncomputable`,** `Classical`, and definitions that cannot be evaluated.
* **Other data types:** `Option`, and `List` and `Fin n` beyond the little the later
  worlds use of them.
