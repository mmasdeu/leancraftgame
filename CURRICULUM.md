# Curriculum (v2)

Version 2 of Lean Craft Game is organised as **one mathematical arc**: every world
prepares the next, and a few objects recur (the Collatz map, Fibonacci numbers,
the Gaussian integers, Sierpiński space). The player never writes a proof: where a
mathematician would prove something, the player supplies a definition, a witness or
a counterexample, and the referee does the proving.

Each level has an **exercise type** (`exercise` in `level.json`, shown as a tag above
the lesson):

| Type | The player… |
|---|---|
| Define | writes a definition matching a description |
| Construct | builds an example: a number, a function, a family of sets, a structure |
| Repair | fixes a colleague's definition or structure |
| Classify | decides which objects have a property (often `Bool` answers checked by exhaustive search) |
| Refute | gives a counterexample to a false claim or a wrong definition |
| Referee | chooses examples that tell right definitions from wrong ones (mutation testing) |
| Connect | relates two definitions (a sum and its closed form) |
| Audit | checks whether a formal statement says what it claims |

The referee's verdicts follow one rule of honesty: ❌ always comes with a Lean proof
(a counterexample, a violated axiom), ❓ means "inconclusive" and is never evidence
against the player, and a type error is reported by Lean before any test runs.

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
  cannot read the whole battery in advance and code against it. The Foundations world and
  the "Spot the bug" levels set `"public": "all"`: their tests are the task itself.
  In those levels every test is a claim about the player's counterexample that must be
  true ("your two numbers do not multiply to 1"), so that no test reads as "should fail".
* **Gated, stepped hints** (`hintsAfter`, `steps`). A hint unlocks after
  `hintsAfter` failed runs (2 by default, 1 in the Foundations world). A hint may have
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

## Foundations World

Numbers and functions, definitions by cases and by recursion, and witnesses. The Collatz map, Fibonacci numbers and the taxicab number 1729 appear here and come back later.

| # | Level | Type |
|---|---|---|
| 1 | Naming things | Define |
| 2 | Functions | Define |
| 3 | Making choices | Define |
| 4 | Recursion | Define |
| 5 | Challenge: witnesses | Construct |
| 6 | Spot the bug | Repair |

## Logic World

Statements as objects of type `Prop`; the connectives; implication, its converse and vacuous truth; equivalence. Boundary cases (`1` is neither prime nor composite, `0 ∣ 0`).

| # | Level | Type |
|---|---|---|
| 7 | Statements | Define |
| 8 | And, or, not | Define |
| 9 | If, then | Refute |
| 10 | Challenge: triangles | Define |
| 11 | Spot the bug: connectives | Refute |

## Numbers World

ℕ, ℤ and ℚ as different types; casts and where to put them; junk values (`1 / 0 = 0`) and why definitions should state properties instead of computing; Egyptian fractions.

| # | Level | Type |
|---|---|---|
| 12 | Integers and casts | Define |
| 13 | Division by zero | Define |
| 14 | Challenge: Egyptian fractions | Define |
| 15 | Spot the bug: numbers | Refute |

## Quantifier World

∀, ∃, restricted quantifiers, "eventually" (`∃ N, ∀ n ≥ N`) and "infinitely often", the order of quantifiers, periodicity.

| # | Level | Type |
|---|---|---|
| 16 | For all | Define |
| 17 | If … then … | Define |
| 18 | There exists | Define |
| 19 | Quantifiers in order | Define |
| 20 | Bounded quantifiers | Define |
| 21 | Challenge: periodicity | Define |
| 22 | Spot the bug: quantifiers | Refute |

## Sequence World

The first genuine definitions of analysis and combinatorics: tending to infinity, monotone and bounded, injective and surjective, recurrence; then the player writes the tests and hidden mutants must be caught.

| # | Level | Type |
|---|---|---|
| 23 | Going to infinity | Define |
| 24 | Bounded and monotone | Define |
| 25 | Injective and surjective | Define |
| 26 | Sequences that come back | Define |
| 27 | Be the referee | Referee |

## Set World

Sets as predicates; Mathlib's own definitions (`Even`, `Nat.properDivisors`, `Function.Injective`); type-class generality; divisibility and the gcd defined without size; relations, equivalences and orders.

| # | Level | Type |
|---|---|---|
| 28 | Sets | Define |
| 29 | Using Mathlib | Define |
| 30 | Generality | Define |
| 31 | Divisibility and gcd | Define |
| 32 | Relations | Define |
| 33 | Spot the bug: the library | Refute |

## Finite World

Big operators over finite sets: sums, products, counting with `Finset.filter` (renamed "Counting": the filters of topology come later), closed forms, off-by-one errors.

| # | Level | Type |
|---|---|---|
| 34 | Sums | Define |
| 35 | Counting | Define |
| 36 | Closed forms | Connect |
| 37 | Challenge: finite sums | Define |
| 38 | Spot the bug: sums | Refute |

## Analysis World

Limits, continuity with ε–δ, Cauchy sequences, cluster values and subsequences; the colleague who forgot `ε > 0`.

| # | Level | Type |
|---|---|---|
| 39 | Limits | Define |
| 40 | Continuity | Define |
| 41 | Cauchy sequences | Define |
| 42 | Cluster values | Define |
| 43 | Spot the bug: limits | Refute |

## Structure World

Structures as bundled data: Gaussian integers and the Brahmagupta–Fibonacci identity, 2×2 integer matrices, matrix powers and Fibonacci numbers, torsion in SL₂(ℤ); morphisms and why preserving structure is not bijectivity; structures with axioms: intervals, partial orders, metrics, and a flawed axiomatisation of groups (find the junk model, then repair it).

| # | Level | Type |
|---|---|---|
| 44 | Declaring a structure | Define |
| 45 | Functions on structures | Define |
| 46 | Defaults and updates | Define |
| 47 | Challenge: matrices | Construct |
| 48 | Morphisms | Classify |
| 49 | Your first structure | Define |
| 50 | Order relations | Define |
| 51 | Metric spaces | Define |
| 52 | A colleague's groups | Repair |

## Class World

Type classes: one definition of power for every monoid, standard notation, instances built from instances, lexicographic orders, and instances that compile but break their laws.

| # | Level | Type |
|---|---|---|
| 53 | Classes and instances | Define |
| 54 | Standard instances | Define |
| 55 | Instances that depend on instances | Define |
| 56 | Challenge: orders from classes | Define |
| 57 | Spot the bug: classes | Refute |

## Topology World

Finite topological spaces (`Family n = Finset (Finset (Fin n))`), checked exhaustively by the referee with `decide`: sets and maps, families, relations and partitions, the axioms (a repair exercise), the gallery (discrete, indiscrete, Sierpiński, particular point), closure, bases, continuity, homeomorphisms, subspaces, products, compactness (on ℕ, since every finite space is compact), connectedness, separation axioms, neighbourhoods, filters and convergence. The examples live in `LeanCraftGame/Lib/Topology.lean`.

| # | Level | Type |
|---|---|---|
| 58 | Sets and maps | Refute |
| 59 | Families of sets | Construct |
| 60 | Relations and partitions | Construct |
| 61 | The definition of a topology | Repair |
| 62 | A gallery of spaces | Construct |
| 63 | Closed sets and closure | Define |
| 64 | Bases | Construct |
| 65 | Continuous maps | Define |
| 66 | Homeomorphisms | Classify |
| 67 | Subspaces | Construct |
| 68 | Products | Classify |
| 69 | Compactness | Refute |
| 70 | Connectedness | Construct |
| 71 | Separation | Classify |
| 72 | Neighbourhoods, filters and convergence | Construct |

## Audit World

An AI claims proofs of the infinitude of primes, the Collatz conjecture and Goldbach's conjecture; the player audits the statements by building toy worlds in which they give the wrong answer.

| # | Level | Type |
|---|---|---|
| 73 | The AI proved the infinitude of primes! | Audit |
| 74 | The AI proved the Collatz conjecture! | Audit |
| 75 | The AI proved Goldbach! | Audit |

## The shared library

`LeanCraftGame/Lib/Topology.lean` defines `Family n`, the standard finite spaces
(`Top.sierpinski`, `Top.discrete n`, `Top.indiscrete n`, `Top.particularPoint n p`,
`Top.excludedPoint n p`, `Top.chain3`) and the referee's own definitions (`Top.Ref.*`:
topology, continuity, homeomorphism, connectedness, T0/T1/T2). Tests import it; the
player's code sees it (the import line is hidden from the editor). Online, the
library is pasted into the prelude before the player's code (`online/build.py`).
A level never depends on a definition the player wrote in an earlier level: when a
later level needs a notion, the referee's copy in `Top.Ref` is used.
